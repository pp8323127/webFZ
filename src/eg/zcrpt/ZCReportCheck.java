package eg.zcrpt;

import java.sql.*;
import java.util.*;

import ci.db.*;
import eg.*;
/**
 * @author cs71 Created on  2009/10/7
 */
public class ZCReportCheck
{
    ArrayList  objAL = new ArrayList();
    ArrayList  crewListobjAL = new ArrayList();
    ArrayList  fltIrrobjAL = new ArrayList();
    ArrayList  crewGradeobjAL = new ArrayList();
    
    private String errorstr = "Y";
    private String sql = "";  
    private String prrpt_fltno = "";
    public static void main(String[] args)
    {
        ZCReportCheck zcrt = new ZCReportCheck();
        System.out.println(zcrt.getMonthlyUnHandleZCReportForCM("628804","2014","01").size());
        zcrt.getUnHandleZCReportForCM("628804", "2014/01/01", "0903", "TPEHKG");

//        zcrt.getZCFltList("2009","10","634623");

//          zcrt.getZCReportLate("2010","11","3","TPE");
//        System.out.println(zcrt.getZCReportCheck("9").size());
//        System.out.println(zcrt.getCrewGrade("1","").size());
//        zcrt.getZCFltListForPR("2009/10/01","0835","TPEBKK","629975");        
//        zcrt.viewZCReport("2009/10/01","2009/10/31","634623","TPE");
//        zcrt.viewZCReport("","","634623","TPE");
//        System.out.println(zcrt.getLong_range("2009/12/23", "0008", "TPELAX", "630523")); 
//        ArrayList objAL = zcrt.getObjAL();
//        System.out.println(objAL.size());
    }
    
  //取得當月需處理ZC report 的航班, 2014/02/01 生效
    public ArrayList getMonthlyUnHandleZCReportForCM(String cmempno, String yyyy, String mm)//CM empno
    {
        Connection conn = null;
        Statement stmt = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ArrayList unHandleAL = new ArrayList();
       
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();
           
            sql = " SELECT cflt.seqno seqno, To_Char(fltd,'yyyy/mm/dd') fltd, fltno, sect " +
            	  " FROM egtzcflt cflt, egtzccmdt dt " +
            	  " WHERE cflt.ifsent = 'Y'  AND psrempn ='"+cmempno+"' AND (cflt.rptclose ='N' OR  cflt.rptclose IS NULL) " +
            	  " AND fltd between to_date('"+yyyy+"/"+mm+"/01','yyyy/mm/dd') " +
            	  " and Last_Day(to_date('"+yyyy+"/"+mm+"/01','yyyy/mm/dd')) AND cflt.seqno = dt.seqno AND  (dt.itemclose IS NULL OR dt.itemclose = 'N') " +
            	  " and fltd >= to_date('2014/02/01','yyyy/mm/dd') order by fltd " ;
            
//            System.out.println(sql);
            rs = stmt.executeQuery(sql);

            while (rs.next())
            {
                ZCReportObj obj = new ZCReportObj();
                obj.setSeqno(rs.getString("seqno"));
                obj.setFltd(rs.getString("fltd"));
                obj.setFltno(rs.getString("fltno"));
                obj.setSect(rs.getString("sect"));
                unHandleAL.add(obj);
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
        return unHandleAL;
    }
    
    
    //unhandle zc report
    public void getUnHandleZCReportForCM(String cmempno, String fltd, String fltno, String sector)//CM empno
    {
        Connection conn = null;
    	Statement stmt = null;
//    	PreparedStatement pstmt = null;
    	ResultSet rs = null;
    	objAL.clear();
       
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
	        conn = ch.getConnection();
            stmt = conn.createStatement();
           
            sql = " SELECT cflt.seqno seqno, To_Char(fltd,'yyyy/mm/dd') fltd, fltno, sect, cpname, " +
            	  " cpno, acno, psrempn, psrsern, psrname, pgroups, zcempn, zcsern, zcname, zcgrps, " +
            	  " dt.seqkey seqkey, dt.itemno itemno, ti.itemdsc itemdsc_m, pi.itemdsc itemdsc_s, " +
            	  " dt.itemdsc itemdsc, dt.comments zccomm, ck.handle_userid handle_userid, ck.comments cmcomm " +
            	  " FROM egtzcflt cflt, egtzccmdt dt, egtzcchk ck, egtcmpi pi, egtcmti ti " +
            	  " WHERE cflt.ifsent = 'Y'  AND psrempn ='"+cmempno+"' " +
            	  " AND (cflt.rptclose ='N' OR  cflt.rptclose IS NULL) " +
            	  " AND fltd = to_date('"+fltd+"','yyyy/mm/dd') and fltno = '"+fltno+"' and sect ='"+sector+"' " +
            	  " AND cflt.seqno = dt.seqno AND (dt.itemclose IS null OR dt.itemclose = 'N') " +
            	  " AND (dt.itemclose IS NULL OR dt.itemclose = 'N')  " +
            	  " AND ti.itemno = pi.kin AND dt.itemno =pi.itemno " +
            	  " AND dt.seqkey = ck.seqkey (+)  AND ck.itemclose (+) <> 'Y'  " +
            	  " AND handle_userid(+) = '"+cmempno+"'" ;      
            
//            System.out.println(sql);
            rs = stmt.executeQuery(sql);

            while (rs.next())
            {
                ZCReportCheckObj obj = new ZCReportCheckObj();
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
                obj.setSeqkey(rs.getString("seqkey"));
                obj.setItemno(rs.getString("itemno"));
                obj.setItemdsc_m(rs.getString("itemdsc_m"));
                obj.setItemdsc_s(rs.getString("itemdsc_s"));
                obj.setItemdsc(rs.getString("itemdsc"));
                obj.setZccomm(rs.getString("zccomm"));
                obj.setHandle_userid(rs.getString("handle_userid"));
                obj.setCmcomm(rs.getString("cmcomm"));
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
    
    public String getPRReportFltno()
    {
        return prrpt_fltno;
    }
    
    
    
    
    
    
}
