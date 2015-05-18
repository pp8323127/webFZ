package eg.zcrpt;

import java.sql.*;
import java.util.*;
import ci.db.*;
import eg.*;
import fz.pracP.*;

/**
 * @author cs71 Created on  2009/10/7
 * //20140915 CS80 getZCFltList改寫
 */
public class ZCReport
{
    ArrayList  objAL = new ArrayList();
    ArrayList  crewListobjAL = new ArrayList();
    ArrayList  fltIrrobjAL = new ArrayList();
    ArrayList  crewGradeobjAL = new ArrayList();
    
    private String errorstr = "Y";
    private String sql = "";
    
    public static void main(String[] args)
    {
        ZCReport zcrt = new ZCReport();
        zcrt.getZCFltList("2014","09","637135");
//        zcrt.getZCFltList("2010","02","632341");
//        zcrt.getZCFltList("2010","02","633473");
//        zcrt.getZCFltList("2010","10","633477");
//        zcrt.getZCFltList("2010","12","633028");        
//        ArrayList dataAL = zcrt.getObjAL();
//        dataAL = zcrt.getObjAL();
//
//        fz.pracP.dispatch.FlexibleDispatch fld = new fz.pracP.dispatch.FlexibleDispatch();
//        for(int i=0;i<dataAL.size();i++)
//        {
//            ZCReportObj obj = (ZCReportObj)dataAL.get(i);
////          System.out.println("seq = "+i+" --> "+obj.getFdate()+"*"+obj.getFlt_num()+"*"+obj.getPort());
//        }
        
//        System.out.println(objAL.size());
//        System.out.println(zcrt.getCrewGrade("1","").size());
//        zcrt.getZCFltListForPR("2011/01/01","3751","TPESUB","630326");
//        System.out.println(zcrt.getZCReportSeqno("2010/05/01","0017","NRTTPE","631877"));
        System.out.println("Done");
    }
    
    //ZC report old
    public void getZCFltList_old(String yyyy, String mm, String empno)
    {
        Connection conn = null;
        Statement stmt = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Driver dbDriver = null;
        fz.pracP.dispatch.FlexibleDispatch fld = new fz.pracP.dispatch.FlexibleDispatch();
       
        try
        {           
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();
           
//          sql = " select fleet_cd," +//738不用填報告
//    	  " to_char(dps.str_dt_tm_loc,'yyyy/mm/dd') fdate, dps.flt_num flt_num, " +
//        " to_char(str_dt_tm_loc,'yyyy/mm/dd hh24:mi') stdDt, dps.port_a||dps.port_b port, " +
//        " r.acting_rank act_rank, r.special_indicator special_indicator, maxseqno, cflt.* " +
//        " from duty_prd_seg_v dps, roster_v r , " +
//        " (SELECT cflt.*, To_Char(fltd,'yyyymmdd')||sect||fltno||zcempn keystr " +
//        " FROM egtzcflt cflt WHERE fltd BETWEEN to_date('"+yyyy+mm+"01 0000','yyyymmdd hh24mi') - 1 " +
//        " AND Last_Day(to_date('"+yyyy+mm+"01 2359','yyyymmdd hh24mi') ) AND zcempn = '"+empno+"') cflt, " +
//        " (select nvl(max(seqno),0)+1 maxseqno from egtzcflt) getseqno " +
//        " where dps.series_num=r.series_num " +
//        " AND To_Char(dps.str_dt_tm_loc,'yyyymmdd')||dps.port_a||dps.port_b||dps.flt_num||'"+empno+"' = cflt.keystr (+) " +
//        " and dps.delete_ind = 'N' AND  r.delete_ind='N' and r.staff_num ='"+empno+"' " +
//        " AND dps.act_str_dt_tm_gmt BETWEEN to_date('"+yyyy+mm+"01 0000','yyyymmdd hh24mi') " +
//        " AND Last_Day(to_date('"+yyyy+mm+"01 2359','yyyymmdd hh24mi') ) AND dps.duty_cd='FLY'  " +
//        " order by str_dt_tm_gmt" ;
  
  sql = " SELECT * FROM (  select fleet_cd," +//738不用填報告
          " to_char(dps.str_dt_tm_loc,'yyyy/mm/dd') fdate, dps.flt_num flt_num, " +
          " to_char(str_dt_tm_loc,'yyyy/mm/dd hh24:mi') stdDt, dps.port_a||dps.port_b port, " +
          " r.acting_rank act_rank, r.special_indicator special_indicator, maxseqno, cflt.* " +
          " from duty_prd_seg_v dps, roster_v r , " +
          " (SELECT cflt.*, To_Char(fltd,'yyyymmdd')||sect||fltno||zcempn keystr " +
          " FROM egtzcflt cflt WHERE fltd BETWEEN to_date('"+yyyy+mm+"01 0000','yyyymmdd hh24mi') - 1 " +
          " AND Last_Day(to_date('"+yyyy+mm+"01 2359','yyyymmdd hh24mi') ) AND zcempn = '"+empno+"') cflt, " +
          " (select nvl(max(seqno),0)+1 maxseqno from egtzcflt) getseqno " +
          " where dps.series_num=r.series_num " +
          " AND To_Char(dps.str_dt_tm_loc,'yyyymmdd')||dps.port_a||dps.port_b||dps.flt_num||'"+empno+"' = cflt.keystr (+) " +
          " and dps.delete_ind = 'N' AND  r.delete_ind='N' and r.staff_num ='"+empno+"' " +
          " AND dps.act_str_dt_tm_gmt BETWEEN to_date('"+yyyy+mm+"01 0000','yyyymmdd hh24mi') " +
          " AND Last_Day(to_date('"+yyyy+mm+"01 2359','yyyymmdd hh24mi') ) AND dps.duty_cd='FLY'  " +
          " UNION " +
          " select fleet_cd," +//738不用填報告
          " to_char(dps.str_dt_tm_loc,'yyyy/mm/dd') fdate, dps.flt_num flt_num, " +
          " to_char(str_dt_tm_loc,'yyyy/mm/dd hh24:mi') stdDt, dps.port_a||dps.port_b port, " +
          " r.acting_rank act_rank, r.special_indicator special_indicator, maxseqno, cflt.* " +
          " from duty_prd_seg_v dps, roster_v r , " +
          " (SELECT cflt.*, To_Char(fltd,'yyyymmdd')||sect||fltno||zcempn keystr " +
          " FROM egtzcflt cflt WHERE fltd BETWEEN to_date('"+yyyy+mm+"01 0000','yyyymmdd hh24mi') - 1 " +
          " AND Last_Day(to_date('"+yyyy+mm+"01 2359','yyyymmdd hh24mi') ) AND zcempn = '"+empno+"') cflt, " +
          " (select nvl(max(seqno),0)+1 maxseqno from egtzcflt) getseqno " +
          " where dps.series_num=r.series_num " +
          " AND To_Char(dps.str_dt_tm_loc,'yyyymmdd')||dps.port_a||dps.port_b||dps.flt_num||'Z'||'"+empno+"' = cflt.keystr " +
          " and dps.delete_ind = 'N' AND  r.delete_ind='N' and r.staff_num ='"+empno+"' " +
          " AND dps.act_str_dt_tm_gmt BETWEEN to_date('"+yyyy+mm+"01 0000','yyyymmdd hh24mi') " +
          " AND Last_Day(to_date('"+yyyy+mm+"01 2359','yyyymmdd hh24mi') ) AND dps.duty_cd='FLY' " +
          " )  order by stdDt, seqno asc "; 
  
//  sql = " select fleet_cd," +//20140211 mapping cm report Z航班||dps.flt_num
//          " to_char(dps.str_dt_tm_loc,'yyyy/mm/dd') fdate, dps.flt_num flt_num, " +
//          " to_char(str_dt_tm_loc,'yyyy/mm/dd hh24:mi') stdDt, dps.port_a||dps.port_b port, " +
//          " r.acting_rank act_rank, r.special_indicator special_indicator, maxseqno, cflt.* " +
//          " from duty_prd_seg_v dps, roster_v r , " +
//          " (SELECT cflt.*, To_Char(fltd,'yyyymmdd')||sect||zcempn keystr " +
//          " FROM egtzcflt cflt WHERE fltd BETWEEN to_date('"+yyyy+mm+"01 0000','yyyymmdd hh24mi') - 1 " +
//          " AND Last_Day(to_date('"+yyyy+mm+"01 2359','yyyymmdd hh24mi') ) AND zcempn = '"+empno+"') cflt, " +
//          " (select nvl(max(seqno),0)+1 maxseqno from egtzcflt) getseqno " +
//          " where dps.series_num=r.series_num " +
//          " AND To_Char(dps.str_dt_tm_loc,'yyyymmdd')||dps.port_a||dps.port_b||'"+empno+"' = cflt.keystr (+) " +
//          " and dps.delete_ind = 'N' AND  r.delete_ind='N' and r.staff_num ='"+empno+"' " +
//          " AND dps.act_str_dt_tm_gmt BETWEEN to_date('"+yyyy+mm+"01 0000','yyyymmdd hh24mi') " +
//          " AND Last_Day(to_date('"+yyyy+mm+"01 2359','yyyymmdd hh24mi') ) AND dps.duty_cd='FLY'  " +
//          " order by str_dt_tm_gmt" ;
            
//System.out.println(sql);
//System.out.println("");
            rs = stmt.executeQuery(sql);
            objAL.clear();

            while (rs.next())
            {
                ZCReportObj obj = new ZCReportObj();                
                obj.setFdate(rs.getString("fdate"));
                obj.setFlt_num(rs.getString("flt_num"));                
                obj.setStdDt(rs.getString("stdDt"));
                obj.setPort(rs.getString("port"));
//                obj.setAct_rank(rs.getString("act_rank"));
                obj.setAct_rank(getZCRank(empno));//"FC"
                obj.setSpecial_indicator(rs.getString("special_indicator"));
                obj.setSeqno(rs.getString("seqno"));
                obj.setFltd(rs.getString("fltd"));
                obj.setFltno(rs.getString("fltno"));
                obj.setSect(rs.getString("sect"));
                obj.setAcno(rs.getString("acno"));
                obj.setCpname(rs.getString("cpname"));
                obj.setCpno(rs.getString("cpno"));
                obj.setPsrname(rs.getString("psrname"));
                obj.setPsrempn(rs.getString("psrempn"));
                obj.setPsrsern(rs.getString("psrsern"));
                obj.setPgroups(rs.getString("pgroups"));
                obj.setZcname(rs.getString("zcname"));
                obj.setZcempn(rs.getString("zcempn"));
                obj.setZcsern(rs.getString("zcsern"));
                obj.setZcgrps(rs.getString("zcgrps"));
                obj.setMemo(rs.getString("memo"));
                obj.setIfsent(rs.getString("ifsent"));
                obj.setSentdate(rs.getString("sentdate"));
                obj.setNewdate(rs.getString("newdate"));
                obj.setNewuser(rs.getString("newuser"));
                obj.setRjtuser(rs.getString("rjtuser"));                
                obj.setRjtdate(rs.getString("rjtdate"));
                obj.setChguser(rs.getString("chguser"));
                obj.setChgdate(rs.getString("chgdate"));
                obj.setFleet_cd(rs.getString("fleet_cd"));   
                
//System.out.println("here 1");            
                //Acting rank 為 FC 且 special_indicateor <> 'E' && Long range ='Y' 才需寫報告
                //fld.getLong_range(obj.getFdate(), obj.getFlt_num(), obj.getPort(), empno) ;
                //String tempstr = fld.getLongRang();
//System.out.println("tempstr "+tempstr);
                //判斷是否需寫ZC報告
                //if("FC".equals(obj.getAct_rank()) && "Y".equals(tempstr)) 
                //if("Y".equals(ifNeedZCReport(obj.getAct_rank(),obj.getSpecial_indicator(), tempstr, obj.getPort())))
                //{
                //SR3075 改為FC(ZC)皆要寫報告
                if("FC".equals(obj.getAct_rank()) | "MC".equals(obj.getAct_rank()) | "ZC".equals(obj.getSpecial_indicator()))
                {
                    if("".equals(obj.getSeqno()) | obj.getSeqno() == null)
                    {//Not edit yet     
//System.out.println("Not edit yet ");                      
                        obj.setSeqno(rs.getString("maxseqno"));
    //System.out.print(rs.getString("maxseqno"));      
    //System.out.println("-->  "+obj.getFlt_num()+" "+obj.getPort()+ " "+obj.getFdate());    
                        try
                        {
                            FlightCrewList fcl = null;
                            String flt_num = obj.getFlt_num();
    //System.out.println("*** "+obj.getFdate()+"   "+flt_num+"         "+obj.getStdDt());                           
                            //Set purser info
                            if(obj.getFlt_num().indexOf("Z") > 0)
                            {                       
                                //******************************************************************                            
                                GetFltInfo ft = new GetFltInfo(obj.getFdate(), flt_num,true);
    //                          ft.RetrieveData();
                                ft.RetrieveDataForZC(empno, obj.getPort());                         
                                fcl = new FlightCrewList(ft,obj.getPort(),obj.getStdDt());     
    //                          fcl.RetrieveData();
                                fcl.RetrieveDataForZC(empno,obj.getPort());
                                //*****************************************************************
                            }
                            else
                            {
                            //******************************************************************
                                GetFltInfo ft = new GetFltInfo(obj.getFdate(), flt_num);
    //                          ft.RetrieveData();
                                ft.RetrieveDataForZC(empno, obj.getPort());                             
//                              fcl = new FlightCrewList(ft,obj.getPort());     
                                fcl = new FlightCrewList(ft,obj.getPort(),obj.getStdDt());   
    //                          fcl.RetrieveData();  
                                fcl.RetrieveDataForZC(empno,obj.getPort());
                            //*****************************************************************
                            }
                            //set ca info    
                            fzac.CrewInfoObj caObj = fcl.getCAObj();
                            if(caObj != null)
                            {
                                obj.setCpname(caObj.getCname());
                                obj.setCpno(caObj.getEmpno()); 
                            }
    //System.out.println("here 2");                     
                            fz.prObj.FltObj fltObj  = fcl.getFltObj();  
                            obj.setAcno(fltObj.getAcno());                      
                            
                            fzac.CrewInfoObj purObj = fcl.getPurCrewObj();                          
                            obj.setPsrempn(purObj.getEmpno());
                            obj.setPsrsern(purObj.getSern());
                            obj.setPsrname(purObj.getCname());        
                            obj.setPgroups(purObj.getGrp());
                            //Set ZC info
                             EGInfo egi = new EGInfo(empno);
                             EgInfoObj egobj = egi.getEGInfoObj(empno); 
                             obj.setZcempn(egobj.getEmpn());
                             obj.setZcname(egobj.getCname());
                             obj.setZcsern(egobj.getSern());
                             obj.setZcgrps(egobj.getGroups());
                             
                             //Set Crews
                             ArrayList zccrewAL = new ArrayList();
                             ArrayList crewObjList = fcl.getCrewObjList();       
                             for(int i = 0; i<crewObjList.size(); i++)
                             {
                                 fzac.CrewInfoObj cobj = (fzac.CrewInfoObj)crewObjList.get(i);
                                 if(!empno.equals(cobj.getEmpno()))
                                 {
                                     ZCReportCrewListObj zccrewobj = new ZCReportCrewListObj();
                                     zccrewobj.setEmpno(cobj.getEmpno());
                                     zccrewobj.setSern(cobj.getSern());
                                     zccrewobj.setCname(cobj.getCname());
                                     zccrewobj.setGrp(cobj.getGrp());                         
                                     zccrewobj.setSeqno(obj.getSeqno());
                                     zccrewAL.add(zccrewobj);
                                 }
                             }  
                             obj.setZccrewObjAL(zccrewAL);
                        }                    
                        catch (Exception e) 
                        {   
                            System.out.println("**"+e.toString());      
                            errorstr = e.toString();
                        }finally
                        {
                            try { if (rs != null)rs.close();}
                            catch ( Exception e ){}
                            try{if (stmt != null)stmt.close();}
                            catch ( Exception e ){}
                            try{if (pstmt != null) pstmt.close();}
                            catch ( Exception e ){}
                            try{ if (conn != null)conn.close(); }
                            catch ( Exception e ){ }
                        }
                    }
                    else //if("".equals(obj.getSeqno()) | obj.getSeqno() == null)
                    {                       
    //                  Set Crews
                        ArrayList zccrewAL = new ArrayList();
                        zccrewAL = getZCCrewList(obj.getSeqno());                       
                        if(zccrewAL.size()>0)
                        {//己編輯組員各單
                            obj.setZccrewObjAL(zccrewAL);
                        }         
                        else
                        {//from aircrews crew list
                            try
                            {
                                //Set purser info       
                                boolean fltnowithZ = false;
                                if(obj.getFlt_num().indexOf("Z")>0)
                                {
                                    fltnowithZ = true;
                                }
                                GetFltInfo ft = new GetFltInfo(obj.getFdate(), obj.getFlt_num(), fltnowithZ);                               
                                FlightCrewList fcl = new FlightCrewList(ft,obj.getPort(),obj.getStdDt());   
                                fcl.RetrieveDataForZC(empno,obj.getPort());
                                
                                ArrayList crewObjList = fcl.getCrewObjList();       
                                 for(int i = 0; i<crewObjList.size(); i++)
                                 {
                                     fzac.CrewInfoObj cobj = (fzac.CrewInfoObj)crewObjList.get(i);
                                     if(!empno.equals(cobj.getEmpno()))
                                     {
                                         ZCReportCrewListObj zccrewobj = new ZCReportCrewListObj();
                                         zccrewobj.setEmpno(cobj.getEmpno());
                                         zccrewobj.setSern(cobj.getSern());
                                         zccrewobj.setCname(cobj.getCname());
                                         zccrewobj.setGrp(cobj.getGrp());                         
                                         zccrewobj.setSeqno(obj.getSeqno());
                                         zccrewAL.add(zccrewobj);
                                     }
                                 }  
                                 obj.setZccrewObjAL(zccrewAL);
                            }                    
                            catch (Exception e) 
                            {   
                                System.out.print(e.toString());     
                                errorstr = e.toString();
                            }finally
                            {
                                try { if (rs != null)rs.close();}
                                catch ( Exception e ){}
                                try{if (stmt != null)stmt.close();}
                                catch ( Exception e ){}
                                try{if (pstmt != null) pstmt.close();}
                                catch ( Exception e ){}
                                try{ if (conn != null)conn.close(); }
                                catch ( Exception e ){ }
                            }
                        }
                        //set Flt irr
                        obj.setZcfltirrObjAL(getZCFltIrrItem(obj.getSeqno()));                    
                    }
                }//if("FC".equals(obj.getAct_rank()) && "Y".equals(tempstr))    
                objAL.add(obj);
            }   
            //******************************************************************************
            

            if(objAL.size()>0)
            {
                for(int i=0; i<objAL.size(); i++)
                {
                    ZCReportObj obj = (ZCReportObj) objAL.get(i);                    
                    //**************************************
//                    System.out.println(obj.getFdate().substring(0,4)+obj.getFdate().substring(5,7)+obj.getFdate().substring(8)+"#"+ obj.getFlt_num()+"#"+ obj.getPort()+"#"+ obj.getStdDt());
                    fz.pracP.GetFltnoWithSuffix gf = new fz.pracP.GetFltnoWithSuffix(obj.getFdate().substring(0, 4)+obj.getFdate().substring(5, 7)+obj.getFdate().substring(8),obj.getFlt_num(), obj.getPort(),obj.getStdDt());
                    if (gf.getFltnoWithSuffix().indexOf("Z") > -1) 
                    {
//                        System.out.println(obj.getFlt_num());
                    // 最後一碼為Z時，不檢查delay班次號碼
                      obj.setFlt_num(gf.getFltnoWithSuffix());
//                      System.out.println(obj.getFlt_num());
                      // System.out.println(gf.getFltnoWithSuffix());
                    }
                }      
            }
            
        }
        catch ( Exception e )
        {
            System.out.println(e.toString());
            errorstr = e.toString();
        }
        finally
        {
            try
            {
                if (rs != null)
                    rs.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (stmt != null)
                    stmt.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (pstmt != null)
                    pstmt.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (conn != null)
                    conn.close();
            }
            catch ( Exception e )
            {
            }
        }
    }
    //20140915 ZC report 
    public void getZCFltList(String yyyy, String mm, String empno)
    {
        Connection conn = null;
        Statement stmt = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Driver dbDriver = null;
        fz.pracP.dispatch.FlexibleDispatch fld = new fz.pracP.dispatch.FlexibleDispatch();
        String maxSeq = "";
        try
        {           
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();
           
//            sql = " select fleet_cd," +//738不用填報告
//      	  " to_char(dps.str_dt_tm_loc,'yyyy/mm/dd') fdate, dps.flt_num flt_num, " +
//          " to_char(str_dt_tm_loc,'yyyy/mm/dd hh24:mi') stdDt, dps.port_a||dps.port_b port, " +
//          " r.acting_rank act_rank, r.special_indicator special_indicator, maxseqno, cflt.* " +
//          " from duty_prd_seg_v dps, roster_v r , " +
//          " (SELECT cflt.*, To_Char(fltd,'yyyymmdd')||sect||fltno||zcempn keystr " +
//          " FROM egtzcflt cflt WHERE fltd BETWEEN to_date('"+yyyy+mm+"01 0000','yyyymmdd hh24mi') - 1 " +
//          " AND Last_Day(to_date('"+yyyy+mm+"01 2359','yyyymmdd hh24mi') ) AND zcempn = '"+empno+"') cflt, " +
//          " (select nvl(max(seqno),0)+1 maxseqno from egtzcflt) getseqno " +
//          " where dps.series_num=r.series_num " +
//          " AND To_Char(dps.str_dt_tm_loc,'yyyymmdd')||dps.port_a||dps.port_b||dps.flt_num||'"+empno+"' = cflt.keystr (+) " +
//          " and dps.delete_ind = 'N' AND  r.delete_ind='N' and r.staff_num ='"+empno+"' " +
//          " AND dps.act_str_dt_tm_gmt BETWEEN to_date('"+yyyy+mm+"01 0000','yyyymmdd hh24mi') " +
//          " AND Last_Day(to_date('"+yyyy+mm+"01 2359','yyyymmdd hh24mi') ) AND dps.duty_cd='FLY'  " +
//          " order by str_dt_tm_gmt" ;
    
    sql = " SELECT * FROM (  select fleet_cd," +//738不用填報告
            " to_char(dps.str_dt_tm_loc,'yyyy/mm/dd') fdate, dps.flt_num flt_num, " +
            " to_char(str_dt_tm_loc,'yyyy/mm/dd hh24:mi') stdDt, dps.port_a||dps.port_b port, " +
            " r.acting_rank act_rank, r.special_indicator special_indicator, maxseqno, cflt.* " +
            " from duty_prd_seg_v dps, roster_v r , " +
            " (SELECT cflt.*, To_Char(fltd,'yyyymmdd')||sect||fltno||zcempn keystr " +
            " FROM egtzcflt cflt WHERE fltd BETWEEN to_date('"+yyyy+mm+"01 0000','yyyymmdd hh24mi') - 1 " +
            " AND Last_Day(to_date('"+yyyy+mm+"01 2359','yyyymmdd hh24mi') ) AND zcempn = '"+empno+"') cflt, " +
            " (select nvl(max(seqno),0)+1 maxseqno from egtzcflt) getseqno " +
            " where dps.series_num=r.series_num " +
            " AND To_Char(dps.str_dt_tm_loc,'yyyymmdd')||dps.port_a||dps.port_b||dps.flt_num||'"+empno+"' = cflt.keystr (+) " +
            " and dps.delete_ind = 'N' AND  r.delete_ind='N' and r.staff_num ='"+empno+"' " +
            " AND dps.act_str_dt_tm_gmt BETWEEN to_date('"+yyyy+mm+"01 0000','yyyymmdd hh24mi') " +
            " AND Last_Day(to_date('"+yyyy+mm+"01 2359','yyyymmdd hh24mi') ) AND dps.duty_cd='FLY'  " +
            " UNION " +
            " select fleet_cd," +//738不用填報告
            " to_char(dps.str_dt_tm_loc,'yyyy/mm/dd') fdate, dps.flt_num flt_num, " +
            " to_char(str_dt_tm_loc,'yyyy/mm/dd hh24:mi') stdDt, dps.port_a||dps.port_b port, " +
            " r.acting_rank act_rank, r.special_indicator special_indicator, maxseqno, cflt.* " +
            " from duty_prd_seg_v dps, roster_v r , " +
            " (SELECT cflt.*, To_Char(fltd,'yyyymmdd')||sect||fltno||zcempn keystr " +
            " FROM egtzcflt cflt WHERE fltd BETWEEN to_date('"+yyyy+mm+"01 0000','yyyymmdd hh24mi') - 1 " +
            " AND Last_Day(to_date('"+yyyy+mm+"01 2359','yyyymmdd hh24mi') ) AND zcempn = '"+empno+"') cflt, " +
            " (select nvl(max(seqno),0)+1 maxseqno from egtzcflt) getseqno " +
            " where dps.series_num=r.series_num " +
            " AND To_Char(dps.str_dt_tm_loc,'yyyymmdd')||dps.port_a||dps.port_b||dps.flt_num||'Z'||'"+empno+"' = cflt.keystr " +
            " and dps.delete_ind = 'N' AND  r.delete_ind='N' and r.staff_num ='"+empno+"' " +
            " AND dps.act_str_dt_tm_gmt BETWEEN to_date('"+yyyy+mm+"01 0000','yyyymmdd hh24mi') " +
            " AND Last_Day(to_date('"+yyyy+mm+"01 2359','yyyymmdd hh24mi') ) AND dps.duty_cd='FLY' " +
            " )  order by stdDt, seqno asc "; 
    
//    sql = " select fleet_cd," +//20140211 mapping cm report Z航班||dps.flt_num
//            " to_char(dps.str_dt_tm_loc,'yyyy/mm/dd') fdate, dps.flt_num flt_num, " +
//            " to_char(str_dt_tm_loc,'yyyy/mm/dd hh24:mi') stdDt, dps.port_a||dps.port_b port, " +
//            " r.acting_rank act_rank, r.special_indicator special_indicator, maxseqno, cflt.* " +
//            " from duty_prd_seg_v dps, roster_v r , " +
//            " (SELECT cflt.*, To_Char(fltd,'yyyymmdd')||sect||zcempn keystr " +
//            " FROM egtzcflt cflt WHERE fltd BETWEEN to_date('"+yyyy+mm+"01 0000','yyyymmdd hh24mi') - 1 " +
//            " AND Last_Day(to_date('"+yyyy+mm+"01 2359','yyyymmdd hh24mi') ) AND zcempn = '"+empno+"') cflt, " +
//            " (select nvl(max(seqno),0)+1 maxseqno from egtzcflt) getseqno " +
//            " where dps.series_num=r.series_num " +
//            " AND To_Char(dps.str_dt_tm_loc,'yyyymmdd')||dps.port_a||dps.port_b||'"+empno+"' = cflt.keystr (+) " +
//            " and dps.delete_ind = 'N' AND  r.delete_ind='N' and r.staff_num ='"+empno+"' " +
//            " AND dps.act_str_dt_tm_gmt BETWEEN to_date('"+yyyy+mm+"01 0000','yyyymmdd hh24mi') " +
//            " AND Last_Day(to_date('"+yyyy+mm+"01 2359','yyyymmdd hh24mi') ) AND dps.duty_cd='FLY'  " +
//            " order by str_dt_tm_gmt" ;
            
//System.out.println(sql);
//System.out.println("");
            rs = stmt.executeQuery(sql);
            objAL.clear();

            while (rs.next())
            {
                ZCReportObj obj = new ZCReportObj();                
                obj.setFdate(rs.getString("fdate"));
                obj.setFlt_num(rs.getString("flt_num"));                
                obj.setStdDt(rs.getString("stdDt"));
                obj.setPort(rs.getString("port"));
                obj.setSpecial_indicator(rs.getString("special_indicator"));
                obj.setSeqno(rs.getString("seqno"));
                obj.setFltd(rs.getString("fltd"));
                obj.setFltno(rs.getString("fltno"));
                obj.setSect(rs.getString("sect"));
                obj.setAcno(rs.getString("acno"));
                obj.setCpname(rs.getString("cpname"));
                obj.setCpno(rs.getString("cpno"));
                obj.setPsrname(rs.getString("psrname"));
                obj.setPsrempn(rs.getString("psrempn"));
                obj.setPsrsern(rs.getString("psrsern"));
                obj.setPgroups(rs.getString("pgroups"));
                obj.setZcname(rs.getString("zcname"));
                obj.setZcempn(rs.getString("zcempn"));
                obj.setZcsern(rs.getString("zcsern"));
                obj.setZcgrps(rs.getString("zcgrps"));
                obj.setMemo(rs.getString("memo"));
                obj.setIfsent(rs.getString("ifsent"));
                obj.setSentdate(rs.getString("sentdate"));
                obj.setNewdate(rs.getString("newdate"));
                obj.setNewuser(rs.getString("newuser"));
                obj.setRjtuser(rs.getString("rjtuser"));                
                obj.setRjtdate(rs.getString("rjtdate"));
                obj.setChguser(rs.getString("chguser"));
                obj.setChgdate(rs.getString("chgdate"));
                obj.setFleet_cd(rs.getString("fleet_cd"));   
                maxSeq = rs.getString("maxseqno");
                objAL.add(obj);
            }   
            //******************************************************************************
            try { if (rs != null)rs.close();}
            catch ( Exception e ){}
            try{if (stmt != null)stmt.close();}
            catch ( Exception e ){}
            try{if (pstmt != null) pstmt.close();}
            catch ( Exception e ){}
            try{ if (conn != null)conn.close(); }
            catch ( Exception e ){ }

            if(objAL.size()>0)
            {
                for(int i=0; i<objAL.size(); i++)
                {
                    ZCReportObj obj = (ZCReportObj) objAL.get(i);    

                    obj.setAct_rank(getZCRank(empno));//"FC"
                    //**************************************
//                    System.out.println(obj.getFdate().substring(0,4)+obj.getFdate().substring(5,7)+obj.getFdate().substring(8)+"#"+ obj.getFlt_num()+"#"+ obj.getPort()+"#"+ obj.getStdDt());
                    fz.pracP.GetFltnoWithSuffix gf = new fz.pracP.GetFltnoWithSuffix(obj.getFdate().substring(0, 4)+obj.getFdate().substring(5, 7)+obj.getFdate().substring(8),obj.getFlt_num(), obj.getPort(),obj.getStdDt());
                    if (gf.getFltnoWithSuffix().indexOf("Z") > -1) 
                    {
//                        System.out.println(obj.getFlt_num());
                    // 最後一碼為Z時，不檢查delay班次號碼
                      obj.setFlt_num(gf.getFltnoWithSuffix());
//                      System.out.println(obj.getFlt_num());
                      // System.out.println(gf.getFltnoWithSuffix());
                    }
                    
                    /****/
                  //System.out.println("here 1");            
                    //Acting rank 為 FC 且 special_indicateor <> 'E' && Long range ='Y' 才需寫報告
                    //fld.getLong_range(obj.getFdate(), obj.getFlt_num(), obj.getPort(), empno) ;
                    //String tempstr = fld.getLongRang();
    //System.out.println("tempstr "+tempstr);
                    //判斷是否需寫ZC報告
                    //if("FC".equals(obj.getAct_rank()) && "Y".equals(tempstr)) 
                    //if("Y".equals(ifNeedZCReport(obj.getAct_rank(),obj.getSpecial_indicator(), tempstr, obj.getPort())))
                    //{
                    //SR3075 改為FC(ZC)皆要寫報告
                    if("FC".equals(obj.getAct_rank()) | "MC".equals(obj.getAct_rank()) | "ZC".equals(obj.getSpecial_indicator()))
                    {
                        if("".equals(obj.getSeqno()) | obj.getSeqno() == null)
                        {//Not edit yet     
    //System.out.println("Not edit yet ");                      
                            obj.setSeqno(maxSeq);
        //System.out.print(rs.getString("maxseqno"));      
        //System.out.println("-->  "+obj.getFlt_num()+" "+obj.getPort()+ " "+obj.getFdate());    
                            try
                            {
                                FlightCrewList fcl = null;
                                String flt_num = obj.getFlt_num();
        //System.out.println("*** "+obj.getFdate()+"   "+flt_num+"         "+obj.getStdDt());                           
                                //Set purser info
                                if(obj.getFlt_num().indexOf("Z") > 0)
                                {                       
                                    //******************************************************************                            
                                    GetFltInfo ft = new GetFltInfo(obj.getFdate(), flt_num,true);
                                    ft.RetrieveDataForZC(empno, obj.getPort());                         
                                    fcl = new FlightCrewList(ft,obj.getPort(),obj.getStdDt());     
                                    fcl.RetrieveDataForZC(empno,obj.getPort());
                                    //*****************************************************************
                                }
                                else
                                {
                                //******************************************************************
                                    GetFltInfo ft = new GetFltInfo(obj.getFdate(), flt_num);
                                    ft.RetrieveDataForZC(empno, obj.getPort());      
                                    fcl = new FlightCrewList(ft,obj.getPort(),obj.getStdDt());   
                                    fcl.RetrieveDataForZC(empno,obj.getPort());
                                //*****************************************************************
                                }
                                //set ca info    
                                fzac.CrewInfoObj caObj = fcl.getCAObj();
                                if(caObj != null)
                                {
                                    obj.setCpname(caObj.getCname());
                                    obj.setCpno(caObj.getEmpno()); 
                                }
        //System.out.println("here 2");                     
                                fz.prObj.FltObj fltObj  = fcl.getFltObj();  
                                obj.setAcno(fltObj.getAcno());                      
                                
                                fzac.CrewInfoObj purObj = fcl.getPurCrewObj();                          
                                obj.setPsrempn(purObj.getEmpno());
                                obj.setPsrsern(purObj.getSern());
                                obj.setPsrname(purObj.getCname());        
                                obj.setPgroups(purObj.getGrp());
                                //Set ZC info
                                 EGInfo egi = new EGInfo(empno);
                                 EgInfoObj egobj = egi.getEGInfoObj(empno); 
                                 obj.setZcempn(egobj.getEmpn());
                                 obj.setZcname(egobj.getCname());
                                 obj.setZcsern(egobj.getSern());
                                 obj.setZcgrps(egobj.getGroups());
                                 
                                 //Set Crews
                                 ArrayList zccrewAL = new ArrayList();
                                 ArrayList crewObjList = fcl.getCrewObjList();       
                                 for(int ci = 0; ci<crewObjList.size(); ci++)
                                 {
                                     fzac.CrewInfoObj cobj = (fzac.CrewInfoObj)crewObjList.get(ci);
                                     if(!empno.equals(cobj.getEmpno()))
                                     {
                                         ZCReportCrewListObj zccrewobj = new ZCReportCrewListObj();
                                         zccrewobj.setEmpno(cobj.getEmpno());
                                         zccrewobj.setSern(cobj.getSern());
                                         zccrewobj.setCname(cobj.getCname());
                                         zccrewobj.setGrp(cobj.getGrp());                         
                                         zccrewobj.setSeqno(obj.getSeqno());
                                         zccrewAL.add(zccrewobj);
                                     }
                                 }  
                                 obj.setZccrewObjAL(zccrewAL);
                            }                    
                            catch (Exception e) 
                            {   
                                //System.out.println("**"+e.toString());      
                                errorstr = e.toString();
                            }finally
                            {
                                try { if (rs != null)rs.close();}
                                catch ( Exception e ){}
                                try{if (stmt != null)stmt.close();}
                                catch ( Exception e ){}
                                try{if (pstmt != null) pstmt.close();}
                                catch ( Exception e ){}
                                try{ if (conn != null)conn.close(); }
                                catch ( Exception e ){ }
                            }
                        }
                        else //if("".equals(obj.getSeqno()) | obj.getSeqno() == null)
                        {                       
        //                  Set Crews
                            ArrayList zccrewAL = new ArrayList();
                            zccrewAL = getZCCrewList(obj.getSeqno());                       
                            if(zccrewAL.size()>0)
                            {//己編輯組員各單
                                obj.setZccrewObjAL(zccrewAL);
                            }         
                            else
                            {//from aircrews crew list
                                try
                                {
                                    //Set purser info       
                                    boolean fltnowithZ = false;
                                    if(obj.getFlt_num().indexOf("Z")>0)
                                    {
                                        fltnowithZ = true;
                                    }
                                    GetFltInfo ft = new GetFltInfo(obj.getFdate(), obj.getFlt_num(), fltnowithZ);                               
                                    FlightCrewList fcl = new FlightCrewList(ft,obj.getPort(),obj.getStdDt());   
                                    fcl.RetrieveDataForZC(empno,obj.getPort());
                                    
                                    ArrayList crewObjList = fcl.getCrewObjList();       
                                     for(int ci = 0; ci<crewObjList.size(); ci++)
                                     {
                                         fzac.CrewInfoObj cobj = (fzac.CrewInfoObj)crewObjList.get(ci);
                                         if(!empno.equals(cobj.getEmpno()))
                                         {
                                             ZCReportCrewListObj zccrewobj = new ZCReportCrewListObj();
                                             zccrewobj.setEmpno(cobj.getEmpno());
                                             zccrewobj.setSern(cobj.getSern());
                                             zccrewobj.setCname(cobj.getCname());
                                             zccrewobj.setGrp(cobj.getGrp());                         
                                             zccrewobj.setSeqno(obj.getSeqno());
                                             zccrewAL.add(zccrewobj);
                                         }
                                     }  
                                     obj.setZccrewObjAL(zccrewAL);
                                }                    
                                catch (Exception e) 
                                {   
                                    System.out.print(e.toString());     
                                    errorstr = e.toString();
                                }finally
                                {
                                    try { if (rs != null)rs.close();}
                                    catch ( Exception e ){}
                                    try{if (stmt != null)stmt.close();}
                                    catch ( Exception e ){}
                                    try{if (pstmt != null) pstmt.close();}
                                    catch ( Exception e ){}
                                    try{ if (conn != null)conn.close(); }
                                    catch ( Exception e ){ }
                                }
                            }
                            //set Flt irr
                            obj.setZcfltirrObjAL(getZCFltIrrItem(obj.getSeqno()));                    
                        }
                        
                        objAL.set(i, obj);
//                        System.out.print(i);  
                    }//if("FC".equals(obj.getAct_rank()) && "Y".equals(tempstr))
                   
                }      
            }
            
        }
        catch ( Exception e )
        {
            ///System.out.println(e.toString());
            errorstr = e.toString();
        }
        finally
        {
            try
            {
                if (rs != null)
                    rs.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (stmt != null)
                    stmt.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (pstmt != null)
                    pstmt.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (conn != null)
                    conn.close();
            }
            catch ( Exception e )
            {
            }
        }
    }
    
    public ArrayList getZCCrewList(String seqno)
    {
        Connection conn = null;
        Statement stmt = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ArrayList zccrewAL = new ArrayList();
       
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();
           
            sql = " SELECT * FROM egtzccrew WHERE seqno = to_number("+seqno+") " ;            
//            System.out.println(sql);
            rs = stmt.executeQuery(sql);

            while (rs.next())
            {                
                ZCReportCrewListObj zccrewobj = new ZCReportCrewListObj();
                zccrewobj.setSeqno(rs.getString("seqno"));
                zccrewobj.setEmpno(rs.getString("empno"));
                zccrewobj.setSern(rs.getString("sern"));
                zccrewobj.setCname(rs.getString("cname"));                
                zccrewobj.setDuty(rs.getString("duty"));
                zccrewobj.setScore(rs.getString("score"));                
                zccrewobj.setGrp(rs.getString("grp"));    
                zccrewobj.setBest_performance(rs.getString("best_performance"));
//                zccrewobj.setGradeobjAL(getCrewGrade(rs.getString("seqno"),rs.getString("empno")));
                zccrewAL.add(zccrewobj);
            }   
            //******************************************************************************
            if(zccrewAL!=null && zccrewAL.size()>0){
                for(int i=0;i<zccrewAL.size();i++){
                    ZCReportCrewListObj obj = (ZCReportCrewListObj) zccrewAL.get(i);
                    obj.setGradeobjAL(getCrewGrade(obj.getSeqno(),obj.getEmpno()));
                    zccrewAL.set(i, obj);
                }
            }
        }
        catch ( Exception e )
        {
            System.out.println(e.toString());
            errorstr = e.toString();
        }
        finally
        {
            try
            {
                if (rs != null)
                    rs.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (stmt != null)
                    stmt.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (pstmt != null)
                    pstmt.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (conn != null)
                    conn.close();
            }
            catch ( Exception e )
            {
            }
        }
        crewListobjAL = zccrewAL;
        return zccrewAL;
    }
    
    public ArrayList getZCFltIrrItem(String seqno)
    {
        Connection conn = null;
        Statement stmt = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ArrayList fltirrAL = new ArrayList();
       
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();
           
            sql = " SELECT To_Char(cflt.fltd,'yyyy/mm/dd') fltd, cflt.fltno, cflt.sect, cflt.acno, " +
                  " cflt.psrempn, cflt.psrsern, cflt.psrname, " +
                  " To_Char(cmdt.itemclose_date,'yyyy/mm/dd hh24:mi') itemclose_date2, " +
                  " cmdt.*, pi.itemdsc dsc " +
                  " FROM egtzcflt cflt, egtzccmdt cmdt, egtcmpi pi WHERE cflt.seqno = cmdt.seqno " +
                  " AND cmdt.itemno = pi.itemno AND cmdt.seqno = to_number("+seqno+")" ;            
//            System.out.println(sql);
            rs = stmt.executeQuery(sql);
            fltirrAL.clear();
            while (rs.next())
            {                
                ZCFltIrrItemObj fltirrobj = new ZCFltIrrItemObj();
                fltirrobj.setSeqkey(rs.getString("seqkey"));  
                fltirrobj.setSeqno(rs.getString("seqno"));
                fltirrobj.setFltd(rs.getString("fltd"));
                fltirrobj.setFltno(rs.getString("fltno"));
                fltirrobj.setSect(rs.getString("sect"));               
                fltirrobj.setAcno(rs.getString("acno"));
                fltirrobj.setPsrempn(rs.getString("psrempn"));                
                fltirrobj.setPsrname(rs.getString("psrname"));    
                fltirrobj.setPsrsern(rs.getString("psrsern"));
                fltirrobj.setItemno(rs.getString("itemno"));
                fltirrobj.setItemdsc(rs.getString("itemdsc"));
                fltirrobj.setItemdsc2(rs.getString("dsc"));
                fltirrobj.setComments(rs.getString("comments"));
                fltirrobj.setFlag(rs.getString("flag"));  
                fltirrobj.setItemclose(rs.getString("itemclose"));  
                fltirrobj.setItemclose_date(rs.getString("itemclose_date2"));                    
                fltirrAL.add(fltirrobj);
            }   
            //******************************************************************************
            if(fltirrAL!=null && fltirrAL.size()>0){
                for(int i=0;i<fltirrAL.size();i++){
                    ZCFltIrrItemObj obj = (ZCFltIrrItemObj) fltirrAL.get(i);
                    obj.setItemhandleobjAL(getZCReportCheck(obj.getSeqkey()));
                    fltirrAL.set(i, obj);
                }
            }
        }
        catch ( Exception e )
        {
            System.out.println(e.toString());
            errorstr = e.toString();
        }
        finally
        {
            try
            {
                if (rs != null)
                    rs.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (stmt != null)
                    stmt.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (pstmt != null)
                    pstmt.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (conn != null)
                    conn.close();
            }
            catch ( Exception e )
            {
            }
        }
        fltIrrobjAL = fltirrAL;
        return fltirrAL;
    }
    
    public ArrayList getZCReportCheck(String seqkey)
    {
        Connection conn = null;
        Statement stmt = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ArrayList zcrptchkAL = new ArrayList();
       
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();
           
            sql = " SELECT chk.*, hr.cname handle_username, " +
                  " To_Char(chk.handle_date,'yyyy/mm/dd hh24:mi') handle_date2, " +
                  " To_Char(chk.itemclose_date,'yyyy/mm/dd hh24:mi') itemclose_date2 " +
                  " FROM egtzcchk chk, hrvegemploy hr WHERE chk.seqkey = to_number("+seqkey+") " +
                  " AND chk.handle_userid = hr.employid (+) " ;            
//            System.out.println(sql);
            rs = stmt.executeQuery(sql);

            while (rs.next())
            {                
                ZCReportCheckObj zcrptchkobj = new ZCReportCheckObj();
                zcrptchkobj.setSeqkey(rs.getString("seqkey"));
                zcrptchkobj.setHandle_unit(rs.getString("handle_unit"));
                zcrptchkobj.setHandle_unit_desc("");
                zcrptchkobj.setHandle_userid(rs.getString("handle_userid"));
                zcrptchkobj.setHandle_username(rs.getString("handle_username"));
                zcrptchkobj.setHandle_date(rs.getString("handle_date2"));
                zcrptchkobj.setComments(rs.getString("comments"));
                zcrptchkobj.setItemclose(rs.getString("itemclose"));
                zcrptchkobj.setItemclose_date(rs.getString("itemclose_date2"));
                zcrptchkAL.add(zcrptchkobj);                    
            }   
            //******************************************************************************
        }
        catch ( Exception e )
        {
            System.out.println(e.toString());
            errorstr = e.toString();
        }
        finally
        {
            try
            {
                if (rs != null)
                    rs.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (stmt != null)
                    stmt.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (pstmt != null)
                    pstmt.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (conn != null)
                    conn.close();
            }
            catch ( Exception e )
            {
            }
        }
        return zcrptchkAL;
    }
    
    
    public ArrayList getCrewGrade(String seqno, String empno)
    {
        Connection conn = null;
        Statement stmt = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ArrayList gradeAL = new ArrayList();
       
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();
           
            sql = " SELECT gddt.*, crew.cname, gdtp.gdname dsc, crew.score,gdtp.comments deptcreate " +
                  " FROM egtzcgddt gddt, egtgdtp gdtp, egtzccrew crew " +
                  " WHERE crew.seqno = gddt.seqno  AND gddt.gdtype = gdtp.gdtype AND crew.empno = gddt.empno " +
                  " AND gddt.seqno = to_number("+seqno+") AND (gddt.empno = '"+empno+"' OR gddt.sern = '"+empno+"') " ;            
//            System.out.println(sql);
            rs = stmt.executeQuery(sql);

            while (rs.next())
            {                
                ZCGradeObj gradeobj = new ZCGradeObj();
                gradeobj.setSeqno(rs.getString("seqno"));
                gradeobj.setEmpno(rs.getString("empno"));
                gradeobj.setSern(rs.getString("sern"));
                gradeobj.setCname(rs.getString("cname"));                
                gradeobj.setGdtype(rs.getString("gdtype"));
                gradeobj.setGddesc(rs.getString("dsc"));     
                gradeobj.setScore(rs.getString("score"));
                gradeobj.setComments(rs.getString("comments"));
                gradeobj.setDeptcreate(rs.getString("deptcreate"));
                gradeAL.add(gradeobj);
            }   
            //******************************************************************************
        }
        catch ( Exception e )
        {
            System.out.println(e.toString());
            errorstr = e.toString();
        }
        finally
        {
            try
            {
                if (rs != null)
                    rs.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (stmt != null)
                    stmt.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (pstmt != null)
                    pstmt.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (conn != null)
                    conn.close();
            }
            catch ( Exception e )
            {
            }
        }
        crewGradeobjAL = gradeAL;
        return crewGradeobjAL;
    }
    
    //view ZC Report from Purser Report
    public void getZCFltListForPR(String fltdt, String fltno, String sect, String purempno)
    {
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
       
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();
           
            sql = " SELECT cflt.*, To_Char(fltd,'yyyy/mm/dd') fltd2, " +
                  " To_Char(sentdate,'yyyy/mm/dd hh24:mi') sentdate2 FROM egtzcflt cflt " +
                  " WHERE fltd = To_Date('"+fltdt+"','yyyy/mm/dd') " +
                  " AND (fltno = '"+fltno+"' or fltno = REPLACE('"+fltno+"','Z',''))  " +
                  " AND sect ='"+sect+"' " +
                  " AND psrempn = '"+purempno+"'" ;
            
//            System.out.println(sql);
            rs = stmt.executeQuery(sql);
            objAL.clear();            
            while (rs.next())
            {
                ZCReportObj obj = new ZCReportObj();
                obj.setFdate(rs.getString("fltd2"));
                obj.setFlt_num(rs.getString("fltno"));
                obj.setStdDt(rs.getString("fltd2"));
                obj.setPort(rs.getString("sect"));
                obj.setAct_rank("FC");
                obj.setSeqno(rs.getString("seqno"));
                obj.setFltd(rs.getString("fltd2"));
                obj.setFltno(rs.getString("fltno"));
                obj.setSect(rs.getString("sect"));
                obj.setAcno(rs.getString("acno"));
                obj.setCpname(rs.getString("cpname"));
                obj.setCpno(rs.getString("cpno"));
                obj.setPsrname(rs.getString("psrname"));
                obj.setPsrempn(rs.getString("psrempn"));
                obj.setPsrsern(rs.getString("psrsern"));
                obj.setPgroups(rs.getString("pgroups"));
                obj.setZcname(rs.getString("zcname"));
                obj.setZcempn(rs.getString("zcempn"));
                obj.setZcsern(rs.getString("zcsern"));
                obj.setZcgrps(rs.getString("zcgrps"));
                obj.setMemo(rs.getString("memo"));
                obj.setIfsent(rs.getString("ifsent"));
                obj.setSentdate(rs.getString("sentdate2"));
                obj.setNewdate(rs.getString("newdate"));
                obj.setNewuser(rs.getString("newuser"));
                obj.setRjtuser(rs.getString("rjtuser"));                
                obj.setRjtdate(rs.getString("rjtdate"));
                obj.setChguser(rs.getString("chguser"));
                obj.setChgdate(rs.getString("chgdate"));
                
                if("Y".equals(obj.getIfsent()))
                {
//                  Set Crews
                    ArrayList zccrewAL = new ArrayList();
                    zccrewAL = getZCCrewList(obj.getSeqno());
                    if(zccrewAL.size()>0)
                    {//己編輯組員各單
                        obj.setZccrewObjAL(zccrewAL);
                    }  
                    obj.setZcfltirrObjAL(getZCFltIrrItem(obj.getSeqno()));                    
                }
                objAL.add(obj);
            }   
            
            
            //******************************************************************************
        }
        catch ( Exception e )
        {
            System.out.println(e.toString());
            errorstr = e.toString();
        }
        finally
        {
            try
            {
                if (rs != null)
                    rs.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (stmt != null)
                    stmt.close();
            }
            catch ( Exception e )
            {
            }
            
            try
            {
                if (conn != null)
                    conn.close();
            }
            catch ( Exception e )
            {
            }
        }
    }
    
//  get Seqno, if EGTZCFLT has seqno then get seqno else get next
    public String getZCReportSeqno(String fltdt, String fltno, String sect, String zcempno)
    {
        String tempseqno ="";
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        ResultSet rs2 = null;
       
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();
           
            sql = " SELECT seqno FROM egtzcflt cflt " +
                  " WHERE fltd = To_Date('"+fltdt+"','yyyy/mm/dd') " +
                  " AND (fltno = '"+fltno+"' or fltno = REPLACE('"+fltno+"','Z',''))  " +
                  " AND sect ='"+sect+"' AND zcempn = '"+zcempno+"'" ;
            
//            System.out.println(sql);
            rs = stmt.executeQuery(sql);

            if (rs.next())
            {
                if("".equals(rs.getString("seqno")) | rs.getString("seqno") == null )
                {//get maxseqno + 1 
                    rs2 = stmt.executeQuery("SELECT Max(seqno)+1 seqno FROM egtzcflt");
                    if(rs2.next())
                    {
                        tempseqno = rs2.getString("seqno");
                    }
                }
                else
                {
                    tempseqno = rs.getString("seqno");
                
                }
            }   
            else
            {
                rs2 = stmt.executeQuery("SELECT Max(seqno)+1 seqno FROM egtzcflt");
                if(rs2.next())
                {
                    tempseqno = rs2.getString("seqno");
                }
            }
            //******************************************************************************
        }
        catch ( Exception e )
        {
            System.out.println(e.toString());
            errorstr = e.toString();
        }
        finally
        {
            try
            {
                if (rs != null)
                    rs.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (rs2 != null)
                    rs2.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (stmt != null)
                    stmt.close();
            }
            catch ( Exception e )
            {
            }
            
            try
            {
                if (conn != null)
                    conn.close();
            }
            catch ( Exception e )
            {
            }
        }
        return tempseqno;
    }
    
    public String ifNeedZCReport(String rank, String special_indicator, String getLong_range, String sect)
    {
        String str = "N";
        if("FC".equals(rank) && !"E".equals(special_indicator) && "Y".equals(getLong_range))    
        {
            str = "Y";
        }
        
        if("FC".equals(rank) && !"E".equals(special_indicator) && sect.indexOf("HND") >= 0)
        {
            str ="Y";
        }
        
        //高雄組員必須寫ZC report  acting rank 不為FC        
//        if(!"FC".equals(rank) && "ZC".equals(special_indicator) && ("KHHHGH".equals(sect) | "HGHKHH".equals(sect) | "KHHPVG".equals(sect) | "PVGKHH".equals(sect)))
        if(!"FC".equals(rank) && "ZC".equals(special_indicator) && ("KHHPVG".equals(sect) | "PVGKHH".equals(sect)))
        {
           str = "Y";   
        }
        
        return str;
    }
    
    public String getZCRank(String empno)
    {
        // TODO Auto-generated method stub
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        String isZC = "";
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();

            this.sql = " select rank_cd from crew_rank_v where staff_num = '"+empno+"' and (exp_dt is null  or exp_dt > sysdate) and eff_dt <= sysdate";

            rs = stmt.executeQuery(this.sql);

            if(rs.next())
            {
             isZC= rs.getString("rank_cd");
            }

        }
        catch ( Exception e )
        {
            System.out.println(e.toString());
            errorstr = e.toString();
        }
        finally
        {
            try
            {
                if (rs != null)
                    rs.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (stmt != null)
                    stmt.close();
            }
            catch ( Exception e )
            {
            }
            
            try
            {
                if (conn != null)
                    conn.close();
            }
            catch ( Exception e )
            {
            }
        }
        return isZC;
    }
    
    public String getSql()
    {
        return sql;
    }
    
    public String getStr()
    {
        return errorstr;
    }
    
    public ArrayList getObjAL()
    {
        return objAL;
    }
    
    public ArrayList getCrewListObjAL()
    {
        return crewListobjAL;
    }
    
    public ArrayList getFltIrrObjAL()
    {
        return fltIrrobjAL;
    }
    
    public ArrayList getCrewGradeObjAL()
    {
        return crewGradeobjAL;
    }
    
    
    
    
    
}
