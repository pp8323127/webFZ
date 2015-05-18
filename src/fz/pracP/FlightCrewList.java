package fz.pracP;

import java.sql.*;
import java.util.*;

import org.hibernate.criterion.*;

import ci.db.*;
import ci.tool.*;
import fzac.*;

/**
 * FlightCrewList 取航班組員及CA名單
 * 
 * @author cs66
 * @version 1.0 2006/2/21
 * @version 1.1 2006/04/24 組員中文姓名從fzvname取得
 * @version 1.2 2006/07/24 修改取得班表sql,加入較寬鬆但有使用index (dps.act_str_dt_tm_gmt )的條件
 * @version 1.3 2006/08/20 delay班次班號+Z
 * @version 1.4 2007/02/10 新增班次原本就有Z的判斷
 * @version 1.5 2008/2/23 修改判斷purser的sql,排除roster.special_indicator為 I, S, P
 * 2014/01/21 CS80 modify-CM null,再取MC
 * 2014/09/29 配合iCS調整
 * Copyright: Copyright (c) 2006
 */
public class FlightCrewList 
{
    private fz.prObj.FltObj fltObj;
    private GetFltInfo fltInfo;
    private ArrayList crewObjList;
    private ArrayList crewSernList;
    private CrewInfoObj CAObj;
    private CrewInfoObj purCrewObj;
    private CrewInfoObj mpCrewObj;// 取得組長資料

    private String sect;
    private String strDt = null; // format yyyy/mm/dd hh24:mi

     public static void main(String[] args) 
     {
        fz.pracP.GetFltInfo ft = new fz.pracP.GetFltInfo("2014/09/16", "0006", false);
//        System.out.println("done getfltinfo");
        FlightCrewList fcl = new FlightCrewList(ft, "TPELAX","2014/09/16 17:32");
//        System.out.println("done fcl");
        try
        {
//            fcl.RetrieveDataForZC("633020", "TPELAX");
//            ft.RetrieveDataForZC("632275", "YVRTPE");
            fcl.RetrieveData();
        }

        catch ( Exception e )
        {

            System.out.print(e.toString());
        }
     }
    
    

    public FlightCrewList(GetFltInfo fltInfo, String sect, String strDt) {
        this.fltInfo = fltInfo;
        this.sect = sect;
        this.strDt = strDt;

    }
    public FlightCrewList(GetFltInfo fltInfo, String sect) {
        this.fltInfo = fltInfo;
        this.sect = sect;

    }

    public void initData() {

        ArrayList dataAL = null;
        try {
            if (fltInfo.getDataAL() == null) {
                fltInfo.RetrieveData();
            }

            dataAL = fltInfo.getDataAL();

        } catch (SQLException e) {
            System.out.println(e.toString());
        } catch (Exception e) {
            System.out.println(e.toString());
        }

        for (int i = 0; i < dataAL.size(); i++) {
            fz.prObj.FltObj obj = (fz.prObj.FltObj) dataAL.get(i);
            if (sect.equals(obj.getDpt() + obj.getArv())) {
                setFltObj(obj);
                // setPurCrewObj(obj.getPurCrewObj());
            }

        }

    }

    public void RetrieveData() throws SQLException, Exception {
        initData();

        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        String sql = null;

        ConnAOCI cna = new ConnAOCI();
        ConnDB cn = new ConnDB();
        Driver dbDriver = null;

        try 
        {

            cn.setAOCIPRODCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL(), null);

//           cna.setAOCIFZUser();
//           java.lang.Class.forName(cna.getDriver());
//           conn = DriverManager.getConnection(cna.getConnURL(), cna.getConnID(), cna.getConnPW());

//            cn.setORT1FZ();
//            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
//            conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());

            
            stmt = conn.createStatement();

            // 取得series
            ArrayList seriesAL = new ArrayList();
            sql = "SELECT DISTINCT series_num FROM duty_prd_seg_v dps "
                    + "WHERE  dps.act_str_dt_tm_gmt BETWEEN To_Date('"
                    + fltObj.getStdD()
                    + " 0000','yyyy/mm/dd  hh24mi') -2 AND To_Date('"
                    + fltObj.getStdD()
                    + " 2359','yyyy/mm/dd hh24mi')+2  and dps.str_dt_tm_loc BETWEEN To_Date('"
                    + fltObj.getStdD()
                    + " 0000','yyyy/mm/dd hh24mi') "
                    + "AND To_Date('"
                    + fltObj.getStdD()
                    + " 2359','yyyy/mm/dd hh24mi') "
                    + "and dps.port_a||dps.port_b='"
                    + sect
                    + "' AND  dps.delete_ind='N' AND dps.fd_ind='N' AND dps.flt_num='";
            if (fltInfo.isFltnoWithZ()) {
                sql += fltObj.getFltno() + "' ";
            } else {

                sql += fltObj.getFltno().replace('Z', ' ').trim() + "' ";
            }

            if (null != strDt) {
//                sql += "AND dps.str_dt_tm_loc = to_date('" + strDt  + "','yyyy/mm/dd hh24:mi')";
                sql += "AND dps.str_dt_tm_loc between to_date('" + strDt + "','yyyy/mm/dd hh24:mi') -1/24" +
                		" and  to_date('" + strDt + "','yyyy/mm/dd hh24:mi') + 1/24 ";

            }
            
//System.out.println("series######"+sql);
            rs = stmt.executeQuery(sql);

            while (rs.next()) 
            {
                seriesAL.add(rs.getString("series_num"));
            }
            rs.close();           
           if(null!= seriesAL && seriesAL.size() > 0){
            // 取得座艙長資料
               sql = "SELECT r.staff_num,ltrim(c.seniority_code,'0') sern,c.preferred_name cname,"
                       + "c.other_surname||' '||c.other_first_name ename,"
                       + "r.acting_rank,Nvl(r.special_indicator,'') spCode,c.section_number "
                       + "FROM roster_v r,crew_v c WHERE r.staff_num = c.staff_num ";

               if (seriesAL.size() == 1) {
                   sql += " AND r.series_num='" + seriesAL.get(0) + "' ";
               } else {
                   sql += " AND r.series_num in (";
                   for (int i = 0; i < seriesAL.size(); i++) {
                       if (i == 0) {
                           sql += "'" + seriesAL.get(i) + "'";
                       } else {
                           sql += ",'" + seriesAL.get(i) + "'";
                       }

                   }
                   sql += ")";
               }    
               sql += " AND r.delete_ind='N' AND Nvl(r.special_indicator,' ') NOT IN ( 'I','S','P') ";
               ////20140121 sharon =>有FLY PR,踢MC.
               if(fltInfo.getCountPR() > 0){
                   sql += " AND r.acting_rank ='PR' ";
               }else{
                   sql += " AND (r.acting_rank = 'MC' OR (r.acting_rank = 'FC' and r.special_indicator = 'J') )";
               }
               sql += " ORDER BY decode(r.ACTING_RANK,'PR','000001','MC','000002','FC','000003',lpad(r.STAFF_NUM,6,'0'))";
               
   //System.out.println("CM########"+sql);         

               rs = stmt.executeQuery(sql);
               while(rs.next()) {
                   CrewInfoObj o = new CrewInfoObj();
                   o.setEmpno(rs.getString("staff_num"));
                   o.setSern(rs.getString("sern"));
                   o.setGrp(rs.getString("section_number"));
                   o.setCname(UnicodeStringParser.removeExtraEscape(rs.getString("cname")));// 轉中文碼
                   setPurCrewObj(o);
               }

               rs.close();
               // 取得組長資料
               sql = "SELECT trim(r.staff_num) staff_num,ltrim(c.seniority_code,'0') sern,c.preferred_name cname,"
                       + "c.other_surname||' '||c.other_first_name ename,"
                       + "r.acting_rank,Nvl(r.special_indicator,'') spCode,c.section_number "
                       + "FROM roster_v r,crew_v c WHERE r.staff_num = c.staff_num ";

               if (seriesAL.size() == 1) {
                   sql += " AND r.series_num='" + seriesAL.get(0) + "' ";
               } else {
                   sql += " AND r.series_num in (";
                   for (int i = 0; i < seriesAL.size(); i++) {
                       if (i == 0) {
                           sql += "'" + seriesAL.get(i) + "'";
                       } else {
                           sql += ",'" + seriesAL.get(i) + "'";
                       }

                   }
                   sql += ")";
               }
               sql += " AND r.delete_ind='N' " +
                          " AND r.acting_rank = 'PR' AND Nvl(r.special_indicator,' ') IN ('S','P')";
               
   //System.out.println("MP########"+sql);         

               rs = stmt.executeQuery(sql);
               while (rs.next()) {
                   CrewInfoObj p = new CrewInfoObj();
                   p.setEmpno(rs.getString("staff_num"));
                   p.setSern(rs.getString("sern"));
                   p.setGrp(rs.getString("section_number"));
                   p.setCname(UnicodeStringParser.removeExtraEscape(rs.getString("cname")));// 轉中文碼
                   setMpCrewObj(p); // 取得組長
               }
//               test
//               if("0100".equals(fltInfo.getFltno()) || "0101".equals(fltInfo.getFltno())){
//                   CrewInfoObj p = new CrewInfoObj();
//                   p.setEmpno("625303");
//                   p.setCname("羅申");
//                   setMpCrewObj(p); // dummy取得組長
//               }
               
               if(null!= rs) rs.close();
//               
               // 抓後艙組員名單
//             sql = "SELECT r.staff_num,ltrim(c.seniority_code,'0') sern,c.preferred_name cname,"
//                     + "c.other_surname||' '||c.other_first_name ename, " 
//                     + " Decode(dps.duty_cd,'FLY','FLY','TVL') duty_cd, "//Betty add on 20090505
//                     + "r.acting_rank,Nvl(r.special_indicator,'') spCode,c.section_number "
//                     + "FROM roster_v r,crew_v c, duty_prd_seg_v dps  WHERE r.staff_num = c.staff_num ";
   //
//             if (seriesAL.size() == 1) {
//                 sql += " AND r.series_num='" + seriesAL.get(0) + "' ";
//             } else {
//                 sql += " AND r.series_num in (";
//                 for (int i = 0; i < seriesAL.size(); i++) {
//                     if (i == 0) {
//                         sql += "'" + seriesAL.get(i) + "'";
//                     } else {
//                         sql += ",'" + seriesAL.get(i) + "'";
//                     }
   //
//                 }
//                 sql += ")";
//             }
//             
//             sql += " AND dps.series_num = r.series_num  AND dps.delete_ind='N' AND dps.duty_cd IN ('FLY','TVL') " +
//                    " AND dps.fd_ind='N' AND dps.port_a||dps.port_b='"+sect+"' and dps.flt_num = '"+fltInfo.getFltno()+"' ";
//             sql += " AND r.delete_ind='N' AND r.acting_rank <>'PR' ";
//             sql += "  order by duty_cd, c.seniority_code";
               
               
               
               
               //抓後艙組員名單 Due to duplicate crew--> distinct
               sql = " SELECT * FROM ( SELECT r.staff_num,ltrim(c.seniority_code,'0') sern,c.preferred_name cname,"
                   + "c.other_surname||' '||c.other_first_name ename, " 
                   + " Decode(dps.duty_cd,'FLY','FLY','TVL') duty_cd, "//Betty add on 20090505
                   + "r.acting_rank,Nvl(r.special_indicator,'') spCode,c.section_number section_number, c.seniority_code "
                   + "FROM roster_v r,crew_v c, duty_prd_seg_v dps  WHERE r.staff_num = c.staff_num ";

               if (seriesAL.size() == 1) {
                   sql += " AND r.series_num='" + seriesAL.get(0) + "' ";
               } else {
                   sql += " AND r.series_num in (";
                   for (int i = 0; i < seriesAL.size(); i++) {
                       if (i == 0) {
                           sql += "'" + seriesAL.get(i) + "'";
                       } else {
                           sql += ",'" + seriesAL.get(i) + "'";
                       }
       
                   }
                   sql += ")";
               }
            
               sql += " AND dps.series_num = r.series_num  AND dps.delete_ind='N' AND dps.duty_cd IN ('FLY','TVL') " +
                      " AND dps.fd_ind='N' AND dps.port_a||dps.port_b='"+sect+"' and dps.flt_num = '"+fltInfo.getFltno()+"' "+
                      " AND dps.ACT_STR_DT_TM_GMT between to_date('"+getFltObj().getStdD() +"','yyyy/mm/dd') -2 and  to_date('"+getFltObj().getStdD() +"','yyyy/mm/dd') +2 "+//20140108 sharon =>踢掉特殊航段之重複組員
                      " AND r.delete_ind='N' ";
               //20140121 sharon =>有FLY PR,MC需加入名單.
               if(fltInfo.getCountPR() > 0){
                   sql += "  AND r.acting_rank <> 'PR' ";
               }else{
                   sql += " AND r.delete_ind='N' AND r.acting_rank not in ('PR','MC') ";//201306 sharon
               }
               
               sql += " ) GROUP BY  staff_num,sern,cname,ename, duty_cd, acting_rank,spCode,section_number, seniority_code ";
               sql += " order by duty_cd, seniority_code";
               
   //System.out.println(sql);
               rs = stmt.executeQuery(sql);

               ArrayList al = new ArrayList();
               ArrayList al2 = new ArrayList();

               

               while (rs.next()) 
               {
                   CrewInfoObj o = new CrewInfoObj();

                   o.setEmpno(rs.getString("staff_num"));
                   o.setSern(rs.getString("sern"));
//                   o.setCname(rs.getString("staff_num")));
   //System.out.println(o.getCname());             
                   o.setEname(rs.getString("ename"));
                   o.setOccu(rs.getString("acting_rank"));
                   o.setSpCode(rs.getString("spCode"));
                   o.setGrp(rs.getString("section_number"));
                   o.setDuty_cd(rs.getString("duty_cd"));
                   al.add(o);

                   al2.add(rs.getString("sern"));
               }

               aircrew.CrewCName cc = new aircrew.CrewCName();
               if (al.size() > 0) 
               {
                   for(int ci=0 ;ci<al.size();ci++){
                       CrewInfoObj obj = (CrewInfoObj) al.get(ci);
                       obj.setCname(cc.getCname(obj.getEmpno()));
                       al.set(ci, obj);
                   }                   
                   setCrewObjList(al);
                   setCrewSernList(al2);
               }
               rs.close();
               sql = "";

               // 抓CA資料,先取得series
               seriesAL = new ArrayList();
               sql = "SELECT DISTINCT series_num FROM duty_prd_seg_v dps "
                       + "WHERE  dps.act_str_dt_tm_gmt BETWEEN To_Date('"
                       + fltObj.getStdD()
                       + " 0000','yyyy/mm/dd  hh24mi') -2 AND To_Date('"
                       + fltObj.getStdD()
                       + " 2359','yyyy/mm/dd hh24mi')+2 and dps.str_dt_tm_loc BETWEEN To_Date('"
                       + fltObj.getStdD()
                       + " 0000','yyyy/mm/dd hh24mi') "
                       + "AND To_Date('"
                       + fltObj.getStdD()
                       + " 2359','yyyy/mm/dd hh24mi') "
                       + "AND dps.delete_ind='N' AND dps.fd_ind='Y' and dps.duty_cd = 'FLY' AND dps.flt_num='";
               
               if (fltInfo.isFltnoWithZ()) {
                   sql += fltObj.getFltno();
               } else {
                   sql += fltObj.getFltno().replace('Z', ' ').trim();
               }

               sql += "' and dps.act_port_a||dps.act_port_b='" + sect + "' ";

               if (null != strDt && !"".equals(strDt)) {

                   sql += " AND dps.str_dt_tm_loc = to_date('" + strDt
                           + "','yyyy/mm/dd hh24:mi')";
               }
               
   //System.out.println("** "+sql);
               rs = stmt.executeQuery(sql);
               while (rs.next()) {
                   seriesAL.add(rs.getString("series_num"));
               }

               sql = null;
               if (seriesAL.size() == 1) 
               {

                   sql = "SELECT trim(r.staff_num) staff_num,"
                           + "c.other_surname||' '||c.other_first_name ename, "
                           + "r.acting_rank ,r.acting_rank,Nvl(r.special_indicator,'') spCode "
                           + "FROM roster_v r,crew_v c WHERE r.staff_num = c.staff_num "
                           + "AND r.series_num='"
                           + seriesAL.get(0)
                           + "' "
                           + "AND r.duty_cd='FLY' AND r.delete_ind='N' and r.acting_rank='CA' ";

               } 
               else if (seriesAL.size() != 0 && seriesAL.size()>1) 
               {

                   sql = "SELECT trim(r.staff_num) staff_num,"
                           + "c.other_surname||' '||c.other_first_name ename, "
                           + "r.acting_rank ,r.acting_rank,Nvl(r.special_indicator,'') spCode "
                           + "FROM roster_v r,crew_v c WHERE r.staff_num = c.staff_num "
                           + "AND r.series_num in (";

                   for (int i = 0; i < seriesAL.size(); i++) {
                       if (i == 0) {
                           sql += "'" + seriesAL.get(i) + "'";
                       } else {
                           sql += ",'" + seriesAL.get(i) + "'";
                       }

                   }
                   sql += ") AND r.duty_cd='FLY' AND r.delete_ind='N' and r.acting_rank='CA'";
               }
               
   //System.out.println(sql);          
               if (sql != null) 
               {
                   rs = stmt.executeQuery(sql);

                   CrewInfoObj o = new CrewInfoObj();
                   while (rs.next()) 
                   {
                       // CA的中文名字，抓fzdb.fzvname
                       o.setEmpno(rs.getString("staff_num"));
                       o.setEname(rs.getString("ename"));
                   }
                   if(o.getEmpno()!=null && !"".equals(o.getEmpno())){
                       o.setCname(cc.getCname(o.getEmpno()));
                       setCAObj(o);
                   }

                   rs.close();
                   stmt.close();
                   conn.close();

////                   cn.setAOCIPRODCP();
//                   cn.setORP3FZUserCP();
//                   dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
//                   conn = dbDriver.connect(cn.getConnURL(), null);
//                   
////                 cn.setORP3FZUser();
////                 java.lang.Class.forName(cn.getDriver());
////                 conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
//                 
////                   cn.setORT1FZ();
////                 dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
////                 conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
//
//                   stmt = conn.createStatement();
//
//                   sql = "select cname from fzvname where empno='" + o.getEmpno()+ "'";
//                   rs = stmt.executeQuery(sql);
//                   while (rs.next()) {
//                       o.setCname(rs.getString("cname"));
//                   }

               }
           } 
            
            

        }catch ( Exception e )
        {
            System.out.println("FlightC"+e.toString());
        }
        finally {
            if (rs != null)
                try {
                    rs.close();
                } catch (SQLException e) {}
            if (stmt != null)
                try {
                    stmt.close();
                } catch (SQLException e) {}
            if (conn != null)
                try {
                    conn.close();
                } catch (SQLException e) {}
        }
    }
    
    
    public void initDataForZC(String zcempno,String sect) 
    {
        ArrayList dataAL = null;
        try {
            if (fltInfo.getDataAL() == null) {
                fltInfo.RetrieveDataForZC(zcempno,sect);
            }

            dataAL = fltInfo.getDataAL();

        } catch (Exception e) {
            System.out.println(e.toString());
        }

        for (int i = 0; i < dataAL.size(); i++) {
            fz.prObj.FltObj obj = (fz.prObj.FltObj) dataAL.get(i);
            if (sect.equals(obj.getDpt() + obj.getArv())) 
            {
                setFltObj(obj);
                // setPurCrewObj(obj.getPurCrewObj());
            }

        }

    }
    
    public void RetrieveDataForZC(String zcempno, String sect) 
    {
        initDataForZC(zcempno, sect);

        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        String sql = null;

        ConnAOCI cna = new ConnAOCI();
        ConnDB cn = new ConnDB();
        Driver dbDriver = null;

        try 
        {

            cn.setAOCIPRODCP();
//            cn.setORP3FZUserCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL(), null);

//           cna.setAOCIFZUser();
//           java.lang.Class.forName(cna.getDriver());
//           conn = DriverManager.getConnection(cna.getConnURL(), cna.getConnID(), cna.getConnPW());

//          cn.setORT1FZ();
//          dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
//          conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
            
            stmt = conn.createStatement();

            // 取得series
            ArrayList seriesAL = new ArrayList();
            sql = "SELECT DISTINCT dps.series_num  series_num FROM duty_prd_seg_v dps, roster_v r "
                    + "WHERE  dps.series_num = r.series_num and r.delete_ind='N' " 
                    //+ "and r.staff_num = '"+zcempno+"' " 
                    + "and dps.act_str_dt_tm_gmt BETWEEN To_Date('"
                    + fltObj.getStdD()
                    + " 0000','yyyy/mm/dd  hh24mi') -2 AND To_Date('"
                    + fltObj.getStdD()
                    + " 2359','yyyy/mm/dd hh24mi')+2  and dps.str_dt_tm_loc BETWEEN To_Date('"
                    + fltObj.getStdD()
                    + " 0000','yyyy/mm/dd hh24mi') "
                    + "AND To_Date('"
                    + fltObj.getStdD()
                    + " 2359','yyyy/mm/dd hh24mi') "
                    + "and dps.port_a||dps.port_b='"
                    + sect
                    + "' AND  dps.delete_ind='N' AND dps.fd_ind='N' " 
                    + "  AND  dps.DUTY_cd = 'FLY' "  //20140121 sharon add only flt series
                    + "  AND dps.flt_num='";
            if (fltInfo.isFltnoWithZ()) {
                sql += fltObj.getFltno() + "' ";
            } else {

                sql += fltObj.getFltno().replace('Z', ' ').trim() + "' ";
            }

            if (null != strDt) {
                sql += "AND dps.str_dt_tm_loc = to_date('" + strDt
                        + "','yyyy/mm/dd hh24:mi')";

            }
            
//System.out.println("取得series "+sql);
            rs = stmt.executeQuery(sql);

            while (rs.next()) 
            {
                seriesAL.add(rs.getString("series_num"));
//                System.out.println(rs.getString("series_num"));
            }
            rs.close();
            
//            System.out.println(seriesAL.size());
            if(seriesAL != null && seriesAL.size() > 0){
                // 取得座艙長資料
                sql = "SELECT r.staff_num,ltrim(c.seniority_code,'0') sern,c.preferred_name cname,"
                        + "c.other_surname||' '||c.other_first_name ename,"
                        + "r.acting_rank,Nvl(r.special_indicator,'') spCode,c.section_number "
                        + "FROM roster_v r,crew_v c WHERE r.staff_num = c.staff_num ";
    
                if (seriesAL.size() == 1) {
                    sql += " AND r.series_num='" + seriesAL.get(0) + "' ";
                } else {
                    sql += " AND r.series_num in (";
                    for (int i = 0; i < seriesAL.size(); i++) {
                        if (i == 0) {
                            sql += "'" + seriesAL.get(i) + "'";
                        } else {
                            sql += ",'" + seriesAL.get(i) + "'";
                        }
    
                    }
                    sql += ")";
                }
                
                sql += " AND r.delete_ind='N'";
                ////20140121 sharon =>有FLY PR,踢MC.
                if(fltInfo.getCountPR() > 0){
                    sql += " AND r.acting_rank ='PR' ";
                }else{//201306,J為MC training code.
                    sql += " AND (r.acting_rank in ('PR', 'MC') OR (r.acting_rank = 'FC' and Nvl(r.special_indicator,' ') = 'J')) ";
                }                       
                sql += " AND Nvl(r.special_indicator,' ') NOT IN ( 'I','S','P') "+
                       " ORDER BY decode(r.ACTING_RANK,'PR','000001','MC','000002','FC','000003',lpad(r.STAFF_NUM,6,'0'))";
//    System.out.println("取得座艙長資料 "+sql);           
    
                rs = stmt.executeQuery(sql);
                while (rs.next()){
                    CrewInfoObj o = new CrewInfoObj();
                    o.setEmpno(rs.getString("staff_num"));
                    o.setSern(rs.getString("sern"));
                    o.setGrp(rs.getString("section_number"));
                    o.setCname(UnicodeStringParser.removeExtraEscape(rs.getString("cname")));// 轉中文碼
                    setPurCrewObj(o);
                }
    
                rs.close();
    
                // 抓後艙組員名單
    //          sql = "SELECT r.staff_num,ltrim(c.seniority_code,'0') sern,c.preferred_name cname,"
    //                  + "c.other_surname||' '||c.other_first_name ename, " 
    //                  + " Decode(dps.duty_cd,'FLY','FLY','TVL') duty_cd, "//Betty add on 20090505
    //                  + "r.acting_rank,Nvl(r.special_indicator,'') spCode,c.section_number "
    //                  + "FROM roster_v r,crew_v c, duty_prd_seg_v dps  WHERE r.staff_num = c.staff_num ";
    //
    //          if (seriesAL.size() == 1) {
    //              sql += " AND r.series_num='" + seriesAL.get(0) + "' ";
    //          } else {
    //              sql += " AND r.series_num in (";
    //              for (int i = 0; i < seriesAL.size(); i++) {
    //                  if (i == 0) {
    //                      sql += "'" + seriesAL.get(i) + "'";
    //                  } else {
    //                      sql += ",'" + seriesAL.get(i) + "'";
    //                  }
    //
    //              }
    //              sql += ")";
    //          }
    //          
    //          sql += " AND dps.series_num = r.series_num  AND dps.delete_ind='N' AND dps.duty_cd IN ('FLY','TVL') " +
    //                 " AND dps.fd_ind='N' AND dps.port_a||dps.port_b='"+sect+"' and dps.flt_num = '"+fltInfo.getFltno()+"' ";
    //          sql += " AND r.delete_ind='N' AND r.acting_rank <>'PR' ";
    //          sql += "  order by duty_cd, c.seniority_code";
                
                
    //          抓後艙組員名單 Due to duplicate crew--> distinct
                sql = " SELECT * FROM ( SELECT r.staff_num,ltrim(c.seniority_code,'0') sern,c.preferred_name cname,"
                    + "c.other_surname||' '||c.other_first_name ename, " 
                    + " Decode(dps.duty_cd,'FLY','FLY','TVL') duty_cd, "//Betty add on 20090505
                    + "r.acting_rank,Nvl(r.special_indicator,'') spCode,c.section_number section_number, c.seniority_code "
                    + "FROM roster_v r,crew_v c, duty_prd_seg_v dps  WHERE r.staff_num = c.staff_num ";
    
                if (seriesAL.size() == 1) {
                    sql += " AND r.series_num='" + seriesAL.get(0) + "' ";
                } else {
                    sql += " AND r.series_num in (";
                    for (int i = 0; i < seriesAL.size(); i++) {
                        if (i == 0) {
                            sql += "'" + seriesAL.get(i) + "'";
                        } else {
                            sql += ",'" + seriesAL.get(i) + "'";
                        }   
                    }
                    sql += ")";
                }
            
                sql += " and r.delete_ind = 'N'" +//20140121 sharon add 
                       " AND dps.series_num = r.series_num  AND dps.delete_ind='N' AND dps.duty_cd = 'FLY' " +//IN ('FLY','TVL')
                       " AND dps.fd_ind='N' AND dps.port_a||dps.port_b='"+sect+"'" +
//                       " and dps.flt_num = '"+fltInfo.getFltno()+"' "+
                       "  AND dps.flt_num='";
                       if (fltInfo.isFltnoWithZ()) {
                           sql += fltObj.getFltno() + "' ";
                       } else {

                           sql += fltObj.getFltno().replace('Z', ' ').trim() + "' ";
                       }
                sql += " and dps.ACT_STR_DT_TM_GMT between to_date('"+getFltObj().getStdD() +"','yyyy/mm/dd') -2 and  to_date('"+getFltObj().getStdD() +"','yyyy/mm/dd') +2 ";//20140108 sharon 剔除特殊航段重複組員
                
                //20140121 sharon =>有FLY PR,MC需加入名單.
                if(fltInfo.getCountPR() > 0){
                    sql += "  AND r.acting_rank <> 'PR' ";
                }else{
                    sql += " AND r.delete_ind='N' AND r.acting_rank not in ('PR','MC') ";//201306 sharon
                }
                
                sql += " ) GROUP BY  staff_num,sern,cname,ename, duty_cd, acting_rank,spCode,section_number, seniority_code ";   
                sql += " order by duty_cd, seniority_code";
                
//    System.out.println("抓後艙組員名單 "+sql);
                rs = stmt.executeQuery(sql);
    
                ArrayList al = new ArrayList();
                ArrayList al2 = new ArrayList();
    
                aircrew.CrewCName cc = new aircrew.CrewCName();
    
                while (rs.next()) 
                {
                    CrewInfoObj o = new CrewInfoObj();
    
                    o.setEmpno(rs.getString("staff_num"));
                    o.setSern(rs.getString("sern"));
//                    o.setCname(cc.getCname(rs.getString("staff_num")));
    //System.out.println(o.getCname());             
                    o.setEname(rs.getString("ename"));
                    o.setOccu(rs.getString("acting_rank"));
                    o.setSpCode(rs.getString("spCode"));
                    o.setGrp(rs.getString("section_number"));
                    o.setDuty_cd(rs.getString("duty_cd"));
                    al.add(o);
    
                    al2.add(rs.getString("sern"));
                }
                
                if (al.size() > 0) 
                {                    
                    for(int ci=0 ;ci<al.size();ci++){
                        CrewInfoObj obj = (CrewInfoObj) al.get(ci);
                        obj.setCname(cc.getCname(obj.getEmpno()));
                        al.set(ci, obj);
                    }                   
                    setCrewObjList(al);
                    setCrewSernList(al2);
                }
                rs.close();
                sql = "";
    
                // 抓CA資料,先取得series
                seriesAL = new ArrayList();
                sql = "SELECT DISTINCT series_num FROM duty_prd_seg_v dps "
                        + "WHERE  dps.act_str_dt_tm_gmt BETWEEN To_Date('"
                        + fltObj.getStdD()
                        + " 0000','yyyy/mm/dd  hh24mi') -2 AND To_Date('"
                        + fltObj.getStdD()
                        + " 2359','yyyy/mm/dd hh24mi')+2 and dps.str_dt_tm_loc BETWEEN To_Date('"
                        + fltObj.getStdD()
                        + " 0000','yyyy/mm/dd hh24mi') "
                        + "AND To_Date('"
                        + fltObj.getStdD()
                        + " 2359','yyyy/mm/dd hh24mi') "
                        + "AND dps.delete_ind='N' AND dps.fd_ind='Y' and dps.duty_cd = 'FLY' AND dps.flt_num='";
                
                if (fltInfo.isFltnoWithZ()) {
                    sql += fltObj.getFltno();
                } else {
                    sql += fltObj.getFltno().replace('Z', ' ').trim();
                }
    
                sql += "' and dps.act_port_a||dps.act_port_b='" + sect + "' ";
    
                if (null != strDt && !"".equals(strDt)) {
    
                    sql += " AND dps.str_dt_tm_loc = to_date('" + strDt
                            + "','yyyy/mm/dd hh24:mi')";
                }
                
    //System.out.println(sql);
                rs = stmt.executeQuery(sql);
                while (rs.next()) {
                    seriesAL.add(rs.getString("series_num"));
                }
    
                sql = null;
                if (seriesAL.size() == 1) 
                {
    
                    sql = "SELECT trim(r.staff_num) staff_num,"
                            + "c.other_surname||' '||c.other_first_name ename, "
                            + "r.acting_rank ,r.acting_rank,Nvl(r.special_indicator,'') spCode "
                            + "FROM roster_v r,crew_v c WHERE r.staff_num = c.staff_num "
                            + "AND r.series_num='"
                            + seriesAL.get(0)
                            + "' "
                            + "AND r.duty_cd='FLY' AND r.delete_ind='N' and r.acting_rank='CA' ";
    
                } 
                else if (seriesAL.size() != 0) 
                {
    
                    sql = "SELECT trim(r.staff_num) staff_num,"
                            + "c.other_surname||' '||c.other_first_name ename, "
                            + "r.acting_rank ,r.acting_rank,Nvl(r.special_indicator,'') spCode "
                            + "FROM roster_v r,crew_v c WHERE r.staff_num = c.staff_num "
                            + "AND r.series_num in (";
    
                    for (int i = 0; i < seriesAL.size(); i++) {
                        if (i == 0) {
                            sql += "'" + seriesAL.get(i) + "'";
                        } else {
                            sql += ",'" + seriesAL.get(i) + "'";
                        }
    
                    }
                    sql += ") AND r.duty_cd='FLY' AND r.delete_ind='N' and r.acting_rank='CA'";
                }
                
    //System.out.println(sql);          
                if (sql != null) 
                {
                    rs = stmt.executeQuery(sql);
    
                    CrewInfoObj o = new CrewInfoObj();
    
                    while (rs.next()) 
                    {
                        // CA的中文名字，抓fzdb.fzvname
//                        o.setCname(cc.getCname(rs.getString("staff_num")));
                        o.setEname(rs.getString("ename"));
                        o.setEmpno(rs.getString("staff_num"));
    
                    }
                    if(o.getEmpno()!=null && !"".equals(o.getEmpno())){
                        o.setCname(cc.getCname(o.getEmpno()));
                        setCAObj(o);
                    }
                    rs.close();
                    stmt.close();
                    conn.close();
                    
//                    cn.setAOCIPRODCP();
////                    cn.setORP3FZUserCP();
//                    dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
//                    conn = dbDriver.connect(cn.getConnURL(), null);
//                    
////                  cn.setORP3FZUser();
////                  java.lang.Class.forName(cn.getDriver());
////                  conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
//                    
////                    cn.setORT1FZ();
////                    dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
////                    conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
//                    
//                    stmt = conn.createStatement();
//    
//                    sql = "select cname from fzvname where empno='" + o.getEmpno()
//                            + "'";
//    //System.out.println(sql);              
//                    rs = stmt.executeQuery(sql);
//                    while (rs.next()) {
//                        o.setCname(rs.getString("cname"));
//                    }
    
                    
                }
            }

        } 
        catch ( Exception e )
        {
            System.out.println(e.toString());
        }
        finally 
        {
            if (rs != null)
                try {
                    rs.close();
                } catch (SQLException e) {}
            if (stmt != null)
                try {
                    stmt.close();
                } catch (SQLException e) {}
            if (conn != null)
                try {
                    conn.close();
                } catch (SQLException e) {}
        }
    }
    
    public fz.prObj.FltObj getFltObj() {
        return fltObj;
    }

    private void setFltObj(fz.prObj.FltObj fltObj) {
        this.fltObj = fltObj;
    }

    public ArrayList getCrewObjList() {
        return crewObjList;
    }

    private void setCrewObjList(ArrayList crewList) {
        this.crewObjList = crewList;
    }

    public CrewInfoObj getCAObj() {
        return CAObj;
    }

    private void setCAObj(CrewInfoObj obj) {
        CAObj = obj;
    }

    public ArrayList getCrewSernList() {
        return crewSernList;
    }

    private void setCrewSernList(ArrayList crewSernList) {
        this.crewSernList = crewSernList;
    }

    public CrewInfoObj getPurCrewObj() {
        return purCrewObj;
    }

    private void setPurCrewObj(CrewInfoObj purCrewObj) {
        this.purCrewObj = purCrewObj;
    }



    public CrewInfoObj getMpCrewObj()
    {
        return mpCrewObj;
    }



    public void setMpCrewObj(CrewInfoObj mpCrewObj)
    {
        this.mpCrewObj = mpCrewObj;
    }
    
}