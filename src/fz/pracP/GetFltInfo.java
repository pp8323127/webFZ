package fz.pracP;

import java.sql.*;
import java.util.*;
import ci.db.*;
import ci.tool.*;

/**
 * GetFltInfo 取得航班資訊,及座艙長資料
 * 
 * @author cs66
 * @version 1.0 2006/2/18
 * @version 1.1 2006/05/03
 *          新增nvl(special_indicator)判斷，不為P(不執行任務),I,S,正常值special_indicator應為null,
 * @version 1.2 2006/07/24 修改取得班表sql,加入較寬鬆但有使用index (dps.act_str_dt_tm_gmt
 *          ,da13.da13_scdate_u)的條件
 * @version 1.3 2006/08/20 delay班號加Z
 * @version 1.4 2007/02/10 新增班次原本就有Z的判斷
 * 2014/01/21 CS80 modify-CM null,再取MC
 * 2014/09/29 配合iCS調整
 * 2014/11/15 W艙 12/04上傳java
 * Copyright: Copyright (c) 2006
 */
public class GetFltInfo {

     public static void main(String[] args) {
        
//     GetFltInfo ft = new GetFltInfo("2013/11/03", "0188");
//   GetFltInfo ft = new GetFltInfo("2009/11/25", "0066Z", true);
//   GetFltInfo ft = new GetFltInfo("2010/02/26", "0007", true);
//   GetFltInfo ft = new GetFltInfo("2014/03/31", "0680Z", "HKGTPE");
   GetFltInfo ft = new GetFltInfo("2014/11/13", "0007", "LAXTPE","");
     ArrayList dataAL = null;
     System.out.println(new java.util.Date());
     try 
     {
     ft.RetrieveData();
//   ft.RetrieveDataForZC("633474","TPEHKG");
     dataAL = ft.getDataAL();
                    
     if ( !ft.isHasData() ) {
     System.out.println("查無資料!!");
     } else {
     System.out.println("yes!!有該筆航班資料");
     
     dataAL = ft.getDataAL();
    if(dataAL.size()>0)
    {
        for(int i =0; i < dataAL.size(); i++)
        {
            fz.prObj.FltObj obj = (fz.prObj.FltObj) dataAL.get(i);
                String temparv = obj.getArv();
                String tempdpt = obj.getDpt();
                System.out.println(obj.getAcno());
        }                   
    }           
                        
     }
        
     } 
     catch (Exception e) {
     System.out.println(e.toString());
     }
                
                
     for ( int i = 0; i < dataAL.size(); i++) {
     fz.prObj.FltObj obj = (fz.prObj.FltObj) dataAL.get(i);
     fzac.CrewInfoObj purCrewObj = obj.getPurCrewObj();
     System.out.println(obj.getFltno() + "\t" + obj.getPurEmpno() + "\t"
     +
     purCrewObj.getGrp()+"\t"+purCrewObj.getCname()+"\t"+obj.getSeries_num());
     }
                
        
     }

    private String startDt;// yyyy/mm/dd
    private String fltno;
    private String sect="";
    private boolean hasData = false;
    private ArrayList dataAL;
    private boolean fltnoWithZ = false;// 原始班次號碼即有Z,預設為false
    private int countPR = 0;
    public GetFltInfo(String startDt, String fltno) {
        this.startDt = startDt;
        this.fltno = fltno.replace('Z', ' ').trim();

    }

    /**
     * @param startDt
     * @param fltno
     * @param fltnoWithZ
     *            班次是否有Z
     */
    public GetFltInfo(String startDt, String fltno, boolean fltnoWithZ) {
        this.startDt = startDt;
        this.fltnoWithZ = fltnoWithZ;
        this.fltno = fltno;

    }
    
    public GetFltInfo(String startDt, String fltno, String sect) 
    {
        this.startDt = startDt;
        this.fltno = fltno;
        this.fltnoWithZ = true;
        this.sect = sect;
    }
    
    public GetFltInfo(String startDt, String fltno, String sect ,String z) {//app用 ,sharon add
        this.startDt = startDt;
        this.fltno = fltno.replace('Z', ' ').trim();
        this.sect = sect;
    }

    public void RetrieveData() throws SQLException, Exception {
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        String sql = null;
        ConnAOCI cna = new ConnAOCI();
        ConnDB cn = new ConnDB();
        Driver dbDriver = null;
        int countPR = 0;
        try 
        {
            cn.setAOCIPRODCP();
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL(), null);

//           cna.setAOCIFZUser();
//           java.lang.Class.forName(cna.getDriver());
//           conn = DriverManager.getConnection(cna.getConnURL(), cna.getConnID(), cna.getConnPW());
           
//           cn.setORT1FZ();
//           dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
//           conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
           
            stmt = conn.createStatement();
            //2014 01 21 sharon modify-CM null,再取MC
            sql = "SELECT count(*) Count_PR "
                    + "from roster_v r, duty_prd_seg_v dps "
                    + "WHERE r.series_num = dps.series_num AND r.delete_ind='N' "
                    + "AND dps.act_str_dt_tm_gmt BETWEEN To_Date('"+ startDt + " 0000','yyyy/mm/dd hh24mi') -2 " 
                    + "AND To_Date('"+ startDt + " 2359','yyyy/mm/dd hh24mi')+2 "
                    + "AND dps.str_dt_tm_loc BETWEEN To_Date('"+ startDt+ " 0000','yyyy/mm/dd hh24mi')  "
                    + "AND To_Date('"+ startDt+ " 2359','yyyy/mm/dd hh24mi') "
                    + " AND ( dps.flt_num=LPad('"+ fltno+ "',4,'0') or dps.flt_num = '"+ fltno+ "' ) " 
//                  + " AND dps.flt_num = '"+ fltno+ "'" 
                    + " AND r.acting_rank='PR' "
                    + " and dps.duty_cd = 'FLY' "//in ('FLY','TVL')                 
                    + "AND  Nvl(r.special_indicator,'-') NOT IN ('P','I','S') ";
          //System.out.println("  ####### GetFltInfoPR ");//+sql
            rs = stmt.executeQuery(sql);       
            while (rs.next()) 
            {
                setCountPR(rs.getInt("Count_PR"));
            }
            rs.close();  
            sql = "SELECT r.series_num,r.staff_num,To_Char(dps.str_dt_tm_loc,'yyyy/mm/dd hh24:mi') strDt,"
                    + "To_Char(dps.end_dt_tm_loc,'yyyy/mm/dd hh24:mi') endDt, "
                    + "dps.port_a dpt,dps.port_b arv,dps.flt_num fltno, " 
                    + "dps.duty_cd "
                    + "from roster_v r, duty_prd_seg_v dps "
                    + "WHERE r.series_num = dps.series_num AND r.delete_ind='N' "
                    + "AND dps.act_str_dt_tm_gmt BETWEEN To_Date('"
                    + startDt
                    + " 0000','yyyy/mm/dd hh24mi') -2 AND To_Date('"
                    + startDt
                    + " 2359','yyyy/mm/dd hh24mi')+2 "
                    + "AND dps.str_dt_tm_loc BETWEEN "
                    + "To_Date('"
                    + startDt
                    + " 0000','yyyy/mm/dd hh24mi')  "
                    + "AND To_Date('"
                    + startDt
                    + " 2359','yyyy/mm/dd hh24mi') "
                    + " AND ( dps.flt_num=LPad('"+ fltno+ "',4,'0') or dps.flt_num = '"+ fltno+ "' ) " 
//                    + " AND dps.flt_num = '"+ fltno+ "'"                    
                    + " and dps.duty_cd in ('FLY','TVL') "                
//                    + "AND  Nvl(r.special_indicator,'-') NOT IN ('P','I','S') ";
                    + "AND  Nvl(r.special_indicator,'-') NOT IN ('I','S') "; 
            if(countPR > 0){
                sql += " AND r.acting_rank = 'PR' ";
            }else{
                sql += " AND (r.acting_rank in ('PR', 'MC') OR (r.acting_rank = 'FC' and r.special_indicator = 'J')) ";//201306 代理
            }           
            
            if(!"".equals(sect) && sect != null)
            {
                sql = sql + " AND dps.port_a||dps.port_b='"+sect+"' ";
            }
            sql += " ORDER BY decode(r.ACTING_RANK,'PR','000001','MC','000002','FC','000003',lpad(r.STAFF_NUM,6,'0'))," +
            	   " decode(Nvl(r.special_indicator,'-'),'-','01','A','02','P','03','J','04','T','05','06') ";//20140415 order spcode
                    //A:換班PR,P:生病PR,J:受訓MC,T:trainning PR.
            
//System.out.println("  ####### GetFltInfo ");//+sql
            rs = stmt.executeQuery(sql);
            ArrayList al = new ArrayList();

            while (rs.next()) 
            {
                fz.prObj.FltObj obj = new fz.prObj.FltObj();
                fzac.CrewInfoObj purCrewObj = new fzac.CrewInfoObj();
                obj.setArv(rs.getString("arv"));
                obj.setDpt(rs.getString("dpt"));
                obj.setStdD(rs.getString("strDt").substring(0, 10)); /* yyyy/mm/dd */
                obj.setEndD(rs.getString("endDt").substring(0, 10));
                obj.setStdDt(rs.getString("strDt")); /*yyyy/mm/dd hh24:mi*/
                obj.setEndDt(rs.getString("endDt"));
                obj.setFltno(rs.getString("fltno"));
                obj.setSeries_num(rs.getString("series_num"));
                obj.setPurEmpno(rs.getString("staff_num"));
                purCrewObj.setEmpno(rs.getString("staff_num"));
                purCrewObj.setDuty_cd(rs.getString("duty_cd"));//20130808 Sharon add
                obj.setPurCrewObj(purCrewObj);
                al.add(obj);
            }

            if (al.size() > 0) 
            {
                setHasData(true);
                for (int i = 0; i < al.size(); i++) {
                    // 取得airops acno
                    fz.prObj.FltObj obj = (fz.prObj.FltObj) al.get(i);
                    sql = "SELECT da13.da13_acno,da13.da13_actp,Nvl(da13_pxac,0) pxac,"
                        + "Nvl(da13_actual_f,0) actualF," 
                        + "Nvl(da13_actual_c,0) actualC,"
                        + "Nvl(da13_actual_y,0) actualY,"
                        + "Nvl(da13_actual_w,0) actualW,"
                        + "Nvl(da13_actual_f,0)+ Nvl(da13_actual_c,0)+Nvl(da13_actual_y,0)+Nvl(da13_actual_w,0) book_total, "
                        + "da13.da13_fltno|| (CASE WHEN to_char(da13.da13_stdl,'dd') <> to_char(da13.da13_atdl,'dd') "
                        + "THEN 'Z'   ELSE ''  END) fltnoZ "
                        + "FROM acdba.v_ittda13_ci da13 WHERE da13.da13_scdate_u BETWEEN "
                        + "To_Date('"+ obj.getStdD()+ " 0000','yyyy/mm/dd hh24:mi')-2 AND "
                        + "To_Date('"+ obj.getStdD()+ " 2359','yyyy/mm/dd hh24:mi')+2 "
                        + "AND da13.da13_etdl between To_Date('"+ obj.getStdD()+ " 00:00','yyyy/mm/dd hh24:mi') " 
                        + " AND To_Date( '" + obj.getStdD() + "23:59','yyyy/mm/dd hh24:mi') "
                        + "AND (da13.da13_fltno='"+ obj.getFltno()+ "' or da13.da13_fltno='"+ obj.getFltno().replace('Z', ' ').trim()+ "') "
                        + "AND da13.da13_fm_sector='"+ obj.getDpt()+ "' AND da13.da13_to_sector='"+ obj.getArv() + "' ";
                    
                    if(!"".equals(obj.getStdDt()) && obj.getStdDt() != null)
                    {
                        sql = sql + " and da13.da13_etdl= To_Date('"+ obj.getStdDt()+ "','yyyy/mm/dd hh24:mi') ";
                        //test
                        //sql = sql + " and da13.da13_etdl between To_Date('"+ obj.getStdDt()+ "','yyyy/mm/dd hh24:mi')-1/24 " +
                        //" and To_Date('"+ obj.getStdDt()+ "','yyyy/mm/dd hh24:mi')+1/24 ";
                        
                    }
//System.out.println(sql);
//System.out.println("  airops#######  "+sql);
                    rs = stmt.executeQuery(sql);

                    while (rs.next()) 
                    {
                        obj.setAcno(rs.getString("da13_acno"));
                        obj.setActp(rs.getString("da13_actp"));
                        obj.setActualF(rs.getString("actualF"));
                        obj.setActualC(rs.getString("actualC"));
                        obj.setActualY(rs.getString("actualY"));
                        obj.setActualW(rs.getString("actualW"));
                        obj.setBook_total(rs.getString("book_total"));
                        obj.setPxac(rs.getString("pxac"));                      
                    }
                    // 取得座艙長資料
                    fzac.CrewInfoObj purCrewObj = obj.getPurCrewObj();
                    rs = stmt.executeQuery("SELECT To_Number(c.seniority_code) sern,c.preferred_name cname,"
                                    + "c.section_number grp FROM crew_v c WHERE staff_num='"
                                    + purCrewObj.getEmpno() + "'");
                    while (rs.next()) 
                    {
                        purCrewObj.setSern(rs.getString("sern"));
                        purCrewObj.setGrp(rs.getString("grp"));
                        
                        purCrewObj.setCname(UnicodeStringParser.removeExtraEscape(rs.getString("cname")));// 轉中文碼
                    }

                }

            }
            setDataAL(al);
        }catch ( Exception e )
            {
                System.out.println(e.toString());
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

    public void RetrieveDataForZC(String zcempno, String sect) 
    {
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
            
//             cna.setAOCIFZUser();
//             java.lang.Class.forName(cna.getDriver());
//             conn = DriverManager.getConnection(cna.getConnURL(), cna.getConnID(), cna.getConnPW());
            
//          cn.setORT1FZ();
//          dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
//          conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
            
             stmt = conn.createStatement();
             
             
            String strdt = "";
            sql = "SELECT r.series_num,r.staff_num,To_Char(dps.str_dt_tm_loc,'yyyy/mm/dd hh24:mi') strDt,"
                + "To_Char(dps.end_dt_tm_loc,'yyyy/mm/dd hh24:mi') endDt, "
                + "dps.port_a dpt,dps.port_b arv,dps.flt_num fltno "
                + "from roster_v r, duty_prd_seg_v dps "
                + "WHERE r.series_num = dps.series_num AND r.delete_ind='N' "
                + "AND dps.act_str_dt_tm_gmt BETWEEN To_Date('"
                + startDt
                + " 0000','yyyy/mm/dd hh24mi') -2 AND To_Date('"
                + startDt
                + " 2359','yyyy/mm/dd hh24mi')+2 "
                + "AND dps.str_dt_tm_loc BETWEEN "
                + "To_Date('"
                + startDt
                + " 0000','yyyy/mm/dd hh24mi')  "
                + "AND To_Date('"
                + startDt
                + " 2359','yyyy/mm/dd hh24mi') "
                + " AND ( dps.flt_num=LPad('"+ fltno+ "',4,'0') or dps.flt_num = '"+ fltno+ "' ) " 
                + " AND r.staff_num='"+zcempno+"' "
                + " and dps.port_a||dps.port_b = '"+sect+"' "
                + " and dps.duty_cd = 'FLY' ";//in ('FLY','TVL') 
            
            //Get ZC fltdata for mapping correct purser
//System.out.println(sql);
            rs = stmt.executeQuery(sql);
            while (rs.next())           
            {
                strdt  = rs.getString("strDt");
            }
            
//System.out.println("strdt "+strdt);
            rs.close();     
          //2014/01/21 sharon modify-CM null,再取MC
            sql = "SELECT count(*) Count_PR "
                    + "from roster_v r, duty_prd_seg_v dps "
                    + "WHERE r.series_num = dps.series_num AND r.delete_ind='N' "
                    + "AND dps.act_str_dt_tm_gmt BETWEEN To_Date('"+ startDt + " 0000','yyyy/mm/dd hh24mi') -2 " 
                    + "AND To_Date('"+ startDt + " 2359','yyyy/mm/dd hh24mi')+2 "
                    + "AND dps.str_dt_tm_loc BETWEEN To_Date('"+ startDt+ " 0000','yyyy/mm/dd hh24mi')  "
                    + "AND To_Date('"+ startDt+ " 2359','yyyy/mm/dd hh24mi') "
                    + " AND dps.flt_num = '"+ fltno+ "'"
                    + " AND r.acting_rank='PR' "
                    + " and dps.duty_cd = 'FLY' "//in ('FLY','TVL')                 
                    + "AND  Nvl(r.special_indicator,'-') NOT IN ('P','I','S') ";
                      //System.out.println("  ####### GetFltZCInfoPR ");//+sql
//            System.out.println("countPR"+sql);
            rs = stmt.executeQuery(sql);       
            while (rs.next()) 
            {
                setCountPR(rs.getInt("Count_PR"));
            }
            rs.close();   
//  ====================================
            //Get Flt record*************************************************************************           
            sql = "SELECT r.series_num,r.staff_num,To_Char(dps.str_dt_tm_loc,'yyyy/mm/dd') strD,"
                + "To_Char(dps.end_dt_tm_loc,'yyyy/mm/dd') endD, " 
                + "To_Char(dps.str_dt_tm_loc,'yyyy/mm/dd hh24:mi') strDt, "
                + "To_Char(dps.end_dt_tm_loc,'yyyy/mm/dd hh24:mi') endDt, "
                + "dps.port_a dpt,dps.port_b arv,dps.flt_num fltno "
                + "from roster_v r, duty_prd_seg_v dps "
                + "WHERE r.series_num = dps.series_num AND r.delete_ind='N' "   
                + "AND dps.act_str_dt_tm_gmt BETWEEN To_Date('"
                + startDt
                + " 0000','yyyy/mm/dd hh24mi') -2 AND To_Date('"
                + startDt
                + " 2359','yyyy/mm/dd hh24mi')+2 "
                + "AND dps.str_dt_tm_loc BETWEEN "
                + "To_Date('"
                + startDt
                + " 0000','yyyy/mm/dd hh24mi')  "
                + "AND To_Date('"
                + startDt
                + " 2359','yyyy/mm/dd hh24mi') "
                + " AND dps.str_dt_tm_loc = To_Date('"+ strdt+"','yyyy/mm/dd hh24:mi') "                
                + " AND ( dps.flt_num=LPad('"+ fltno+ "',4,'0') or dps.flt_num = '"+ fltno+ "' ) " 
                + " and dps.duty_cd ='FLY' " //'in ('FLY','TVL') 
                + " and dps.port_a||dps.port_b = '"+sect+"' "
                + "AND  Nvl(r.special_indicator,'-') NOT IN ('P','I','S') ";
            
                if(countPR > 0){
                    sql += " AND r.acting_rank = 'PR' ";
                }else{
                    sql += " AND (r.acting_rank in ('PR', 'MC') OR (r.acting_rank = 'FC' and Nvl(r.special_indicator, ' ') = 'J')) ";//201306 代理
                }    
            
            
//System.out.println("flt record:"+sql);
            rs = stmt.executeQuery(sql);
            ArrayList al = new ArrayList();

            while (rs.next()) 
            {
                fz.prObj.FltObj obj = new fz.prObj.FltObj();
                fzac.CrewInfoObj purCrewObj = new fzac.CrewInfoObj();
                obj.setArv(rs.getString("arv"));
                obj.setDpt(rs.getString("dpt"));
                obj.setStdD(rs.getString("strD")); /* yyyy/mm/dd */
                obj.setEndD(rs.getString("endD"));
                obj.setStdDt(rs.getString("strDt")); /* yyyy/mm/dd hh24:mi */
                obj.setEndDt(rs.getString("endDt"));
                obj.setFltno(rs.getString("fltno"));
                obj.setSeries_num(rs.getString("series_num"));
                obj.setPurEmpno(rs.getString("staff_num"));
                purCrewObj.setEmpno(rs.getString("staff_num"));
                obj.setPurCrewObj(purCrewObj);
                al.add(obj);
            }
            rs.close();
            
            if(al.size() <= 0)//purser open
            {
                //Get Flt record*************************************************************************           
                sql = "SELECT r.series_num,r.staff_num,To_Char(dps.str_dt_tm_loc,'yyyy/mm/dd') strD,"
                    + "To_Char(dps.end_dt_tm_loc,'yyyy/mm/dd') endD, " 
                    + "To_Char(dps.str_dt_tm_loc,'yyyy/mm/dd hh24:mi') strDt, "
                    + "To_Char(dps.end_dt_tm_loc,'yyyy/mm/dd hh24:mi') endDt, "
                    + "dps.port_a dpt,dps.port_b arv,dps.flt_num fltno "
                    + "from roster_v r, duty_prd_seg_v dps "
                    + "WHERE r.series_num = dps.series_num AND r.delete_ind='N' "   
                    + "AND dps.act_str_dt_tm_gmt BETWEEN To_Date('"
                    + startDt
                    + " 0000','yyyy/mm/dd hh24mi') -2 AND To_Date('"
                    + startDt
                    + " 2359','yyyy/mm/dd hh24mi')+2 "
                    + "AND dps.str_dt_tm_loc BETWEEN "
                    + "To_Date('"
                    + startDt
                    + " 0000','yyyy/mm/dd hh24mi')  "
                    + "AND To_Date('"
                    + startDt
                    + " 2359','yyyy/mm/dd hh24mi') "
                    + " AND dps.str_dt_tm_loc = To_Date('"+ strdt+"','yyyy/mm/dd hh24:mi') "                
                    + " AND ( dps.flt_num=LPad('"+ fltno+ "',4,'0') or dps.flt_num = '"+ fltno+ "' ) " 
                    + " AND r.acting_rank='FC' "
                    + " and dps.duty_cd = 'FLY' "//in ('FLY','TVL')
                    + " and dps.port_a||dps.port_b = '"+sect+"' "
                    + "AND  Nvl(r.special_indicator,'-') NOT IN ('P','I','S') ";
                
//System.out.println(sql);
                rs = stmt.executeQuery(sql);
                while (rs.next()) 
                {
                    fz.prObj.FltObj obj = new fz.prObj.FltObj();
                    fzac.CrewInfoObj purCrewObj = new fzac.CrewInfoObj();
                    obj.setArv(rs.getString("arv"));
                    obj.setDpt(rs.getString("dpt"));
                    obj.setStdD(rs.getString("strD")); /* yyyy/mm/dd */
                    obj.setEndD(rs.getString("endD"));
                    obj.setStdDt(rs.getString("strDt")); /* yyyy/mm/dd hh24:mi */
                    obj.setEndDt(rs.getString("endDt"));
                    obj.setFltno(rs.getString("fltno"));
                    obj.setSeries_num(rs.getString("series_num"));
                    //purser open , purser is null
                    obj.setPurEmpno("");
                    purCrewObj.setEmpno("");
                    obj.setPurCrewObj(purCrewObj);
                    al.add(obj);
                }
                rs.close();             
            }           
            
            if (al.size() > 0) 
            {
                setHasData(true);
                for (int i = 0; i < al.size(); i++) 
                {
                    // 取得airops acno
                    fz.prObj.FltObj obj = (fz.prObj.FltObj) al.get(i);
                    sql = "SELECT da13.da13_acno,Nvl(da13_pxac,0) pxac,"
                        + "Nvl(da13_actual_f,0) actualF," 
                        + "Nvl(da13_actual_c,0) actualC,"
                        + "Nvl(da13_actual_y,0) actualY,"
                        + "Nvl(da13_actual_w,0) actualW,"
                        + "Nvl(da13_actual_f,0)+ Nvl(da13_actual_c,0)+Nvl(da13_actual_y,0)+Nvl(da13_actual_w,0) book_total, "
                        + "da13.da13_fltno|| (CASE WHEN to_char(da13.da13_stdl,'dd') <> to_char(da13.da13_atdl,'dd') "
                        + "THEN 'Z'   ELSE ''  END) fltnoZ "
                        + "FROM acdba.v_ittda13_ci da13 WHERE da13.da13_scdate_u BETWEEN "
                        + "To_Date('"
                        + obj.getStdD()
                        + " 0000','yyyy/mm/dd hh24:mi')-2 AND "
                        + "To_Date('"
                        + obj.getStdD()
                        + " 2359','yyyy/mm/dd hh24:mi')+2 "
                        + "AND da13.da13_etdl between "
                        + "To_Date('"
                        + obj.getStdD()
                        + " 00:00','yyyy/mm/dd hh24:mi') AND "
                        + "To_Date( '"
                        + obj.getStdD()
                        + "23:59','yyyy/mm/dd hh24:mi') "
                        + "and (da13.da13_atdl = To_Date( '"+ obj.getStdDt()+"','yyyy/mm/dd hh24:mi') " 
                        + " or da13.da13_etdl = To_Date( '"+ obj.getStdDt()+"','yyyy/mm/dd hh24:mi') ) "
                        + "AND (da13.da13_fltno='"+ obj.getFltno()+ "' or da13.da13_fltno='"+ obj.getFltno().replace('Z', ' ').trim()+ "') "
//                      + "and da13.da13_fltno='"+ obj.getFltno() 
                        + "AND da13.da13_fm_sector='"
                        + obj.getDpt()
                        + "' AND da13.da13_to_sector='"
                        + obj.getArv() + "' ";
//System.out.println(sql);
                    rs = stmt.executeQuery(sql);

                    while (rs.next()) 
                    {
                        obj.setAcno(rs.getString("da13_acno"));
                        obj.setActualF(rs.getString("actualF"));
                        obj.setActualC(rs.getString("actualC"));
                        obj.setActualY(rs.getString("actualY"));
                        obj.setActualW(rs.getString("actualW"));
                        obj.setBook_total(rs.getString("book_total"));
                        obj.setPxac(rs.getString("pxac"));                      
                    }
                    
                    rs.close();
                    
                    //20101206 modify in case purser is open
                    if(!"".equals(obj.getPurCrewObj()) && obj.getPurCrewObj() != null)
                    {
                        // 取得座艙長資料
                        fzac.CrewInfoObj purCrewObj = obj.getPurCrewObj();
                        sql = "SELECT To_Number(c.seniority_code) sern,c.preferred_name cname,"
                            + "c.section_number grp FROM crew_v c WHERE staff_num='"
                            + purCrewObj.getEmpno() + "'";
                        
    //System.out.println(sql);                  
                        rs = stmt.executeQuery(sql);
                        
                        while (rs.next()) 
                        {
                            purCrewObj.setSern(rs.getString("sern"));
                            purCrewObj.setGrp(rs.getString("grp"));
                            purCrewObj.setCname(UnicodeStringParser.removeExtraEscape(rs.getString("cname")));// 轉中文碼
                            
                        }
                        rs.close();
                    }
                }
            }       
            setDataAL(al);

        } 
        catch ( Exception e )
        {
            System.out.println(e.toString());
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
    
    public boolean isHasData() {
        return hasData;
    }

    private void setHasData(boolean hasData) {
        this.hasData = hasData;
    }

    public ArrayList getDataAL() {
        return dataAL;
    }

    public void setDataAL(ArrayList dataAL) {
        this.dataAL = dataAL;
    }
    
    public String getFltno() {
        return fltno;
    }


    public boolean isFltnoWithZ() {
        return fltnoWithZ;
    }

    public int getCountPR()
    {
        return countPR;
    }

    public void setCountPR(int countPR)
    {
        this.countPR = countPR;
    }
    
}