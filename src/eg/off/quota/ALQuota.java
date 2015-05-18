package eg.off.quota;

import java.sql.*;
import java.util.*;
import ci.db.*;
/**
 * @author cs71 Created on  2007/9/28
 */
public class ALQuota
{    
    private String sql = null;
    private String qdate = "";
    private String yyyy = "";
    private String mm = "";
    private String leaverank = "";
    private String inst = "";
    private int type = 0;
    private String returnstr = "";
    ArrayList objAL = new ArrayList();
    
    public static void main(String[] args)
    {
        System.out.println(new java.util.Date());
        ALQuota alq = new ALQuota("2009","02","TPE FS");

        alq.getQuota();
        System.out.println(new java.util.Date());
//        System.out.println(alq.getObjAL().size());
//        ALQuota alq = new ALQuota();
        System.out.println(new java.util.Date());
        alq.setUsedQuota();
        System.out.println(new java.util.Date());
        System.out.println("Done");
    }
    
    public ALQuota ()
    { 
    }
    
    public ALQuota (String qdate)
    {
        this.qdate = qdate;
        this.inst = "A";
    }
    
    public ALQuota (String qdate, String leaverank)
    {
        this.qdate = qdate;
        this.leaverank = leaverank;
        this.inst = "B";
    }
    
    public ALQuota (String yyyy, String mm, String leaverank)
    {
        this.yyyy = yyyy;
        this.mm = mm;
        this.leaverank = leaverank;
        this.inst = "C";
    }
    
    public ALQuota (String yyyy, String mm, int type)
    {
        this.yyyy = yyyy;
        this.mm = mm;
        this.type = type;
        this.inst = "D";
    }
    
    public void getQuota ()
    {
        Connection conn = null;
        Statement stmt = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
	    try
	    {
	        
	        ConnectionHelper ch = new ConnectionHelper();
	        conn = ch.getConnection();
//	        EGConnDB cn = new EGConnDB();
//            cn.setORP3EGUserCP(); 
//	    	java.lang.Class.forName(cn.getDriver());
//	    	conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());   
	    	
//	    	cn.setORP3EGUser();   
//	    	java.lang.Class.forName(cn.getDriver());
//	    	conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),cn.getConnPW());
	        stmt = conn.createStatement();	
	
	        //******************************************************************************
	        //get data from egtqobd
	        if("A".equals(inst))
	        {
	            sql = " SELECT To_char(quota_dt,'yyyy/mm/dd') qdate, leaverank, quota FROM egtqobd " +
	            	  " WHERE quota_dt = To_Date('"+qdate+"','yyyy/mm/dd') order by leaverank, qdate " ;                
	        }
	        else if("B".equals(inst))
	        {
	            sql = " SELECT To_char(quota_dt,'yyyy/mm/dd') qdate, leaverank, quota FROM egtqobd " +
          	  		  " WHERE quota_dt = To_Date('"+qdate+"','yyyy/mm/dd') AND leaverank = '"+leaverank+"' " +
          	  		  " order by leaverank, qdate " ;  
	        } 
	        else if("C".equals(inst))
	        {
	            sql = " SELECT To_char(quota_dt,'yyyy/mm/dd') qdate, leaverank, quota FROM egtqobd " +
          	  		  " WHERE Trunc(quota_dt,'mm') =  To_Date('"+yyyy+"/"+mm+"/01','yyyy/mm/dd') " +
          	  		  " AND leaverank = '"+leaverank+"' order by leaverank, qdate  " ;  
	        }
	        else if("D".equals(inst))
	        {
	            sql = " SELECT To_char(quota_dt,'yyyy/mm/dd') qdate, leaverank, quota FROM egtqobd " +
//          	  		  " WHERE Trunc(quota_dt,'mm') =  To_Date('"+yyyy+"/"+mm+"/01','yyyy/mm/dd') " +
	                  " where quota_dt BETWEEN To_Date('"+yyyy+"/"+mm+"/01','yyyy/mm/dd') " +
	                  " AND Last_Day(To_Date('"+yyyy+"/"+mm+"/01','yyyy/mm/dd') ) " +
          	  		  " order by leaverank, qdate " ;  
	        }
	        else
	        {
	            sql = " SELECT To_char(quota_dt,'yyyy/mm/dd') qdate, leaverank, quota FROM egtqobd " +
	            	  " order by leaverank, qdate " ;  
	        }
	        	
//System.out.println(sql);
	        rs = stmt.executeQuery(sql);
	
	        while (rs.next())
	        {
	            ALQuotaObj obj = new ALQuotaObj();
	            obj.setQuota_dt(rs.getString("qdate"));
	            obj.setLeaverank(rs.getString("leaverank"));
	            obj.setQuota(rs.getString("quota"));
	            objAL.add(obj);
	        }
	        //******************************************************************************
	    }
	    catch ( Exception e )
	    {
	        System.out.println(e.toString());
	    }
	    finally
	    {
	        try
	        {
	            if (rs != null)
	            {
	                rs.close();
	            }
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
    
    public void setUsedQuota()
    {
        Connection conn = null;
        Statement stmt = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
	    try
	    {
	        ConnectionHelper ch = new ConnectionHelper();
	        conn = ch.getConnection();
//	        EGConnDB cn = new EGConnDB();
//            cn.setORP3EGUserCP(); 
//	    	java.lang.Class.forName(cn.getDriver());
//	    	conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());   
	    	
//	    	cn.setORP3EGUser();    
////          cn.setORT1EG();
//	    	java.lang.Class.forName(cn.getDriver());
//	    	conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),cn.getConnPW());
	        stmt = conn.createStatement();	
	        
	        //update egtoffs.leaverank
	        //**********************************************************************************
//	        sql = " SELECT trim(empn) empn, offno  FROM egtoffs WHERE offtype in ('0','15','16') AND leaverank IS NULL  " +
//	        	  " AND offyear = '2009' ";
//	        
//	        rs = stmt.executeQuery(sql);
//
//	        pstmt = conn.prepareStatement("update egtoffs set leaverank = ? where form_num = ? or offno = ? ");
//	        int count2 =0;
//	        while (rs.next())
//	        {			
////	            System.out.println(GetJobType.getEmpJobType(rs.getString("empn")));
//	            pstmt.setString(1, eg.GetJobType.getEmpJobType(rs.getString("empn")));
//				pstmt.setString(2, rs.getString("offno"));
//				pstmt.setString(3, rs.getString("offno"));
//				pstmt.addBatch();
//				count2++;
//				if (count2 == 10)
//				{
//					pstmt.executeBatch();
//					pstmt.clearBatch();
//					count2 = 0;
//				}
//			}
//
//			if (count2 > 0)
//			{
//				pstmt.executeBatch();
//				pstmt.clearBatch();
//			}	        
	        //*******************************************************************************
			//calculate used quota for each day
	        for(int i=0; i<objAL.size(); i++)
	        {
	            ALQuotaObj obj = (ALQuotaObj) objAL.get(i);
//	            System.out.println(obj.getLeaverank()+"/"+obj.getQuota_dt()+"/"+obj.getQuota()+"/"+obj.getQuota_used());
	            sql = " SELECT Count(*) c FROM egtoffs " +
	            	  " WHERE To_Date('"+obj.getQuota_dt()+"','yyyy/mm/dd') BETWEEN offsdate AND offedate " +
	            	  " AND offsdate between To_Date('"+obj.getQuota_dt()+"','yyyy/mm/dd')-45 and To_Date('"+obj.getQuota_dt()+"','yyyy/mm/dd')" +
	            	  " AND (remark <> '*' or alrelease ='Y') AND offtype in ('0','15','16') AND leaverank = '"+obj.getLeaverank()+"' ";
//	            System.out.println(sql);
	            rs = stmt.executeQuery(sql);
	            if(rs.next())
	            {
	                obj.setQuota_used(rs.getString("c"));
	                int temp_quota_left = 0;
	                temp_quota_left = Integer.parseInt(obj.getQuota()) - Integer.parseInt(obj.getQuota_used());
//	                if(temp_quota_left<0)
//	                {
//	                    temp_quota_left = 0;
//	                }
	                obj.setQuota_left(Integer.toString(temp_quota_left));
	            }
	        }	  
	        
//	        for(int i=0; i<objAL.size(); i++)
//	        {
//	            ALQuotaObj obj = (ALQuotaObj) objAL.get(i);
//	            
//	            System.out.println(obj.getLeaverank()+"/"+obj.getQuota_dt()+"/"+obj.getQuota()+"/"+obj.getQuota_used()+"/"+obj.getQuota_left());	           
//	        }
	    }
	    catch ( Exception e )
	    {
	        System.out.println(e.toString());
	    }
	    finally
	    {
	        try
	        {
	            if (rs != null)
	            {
	                rs.close();
	            }
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
    
    public void setReleaseQuota()
    {
        Connection conn = null;
        Statement stmt = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
	    try
	    {
	        ConnectionHelper ch = new ConnectionHelper();
	        conn = ch.getConnection();
	        stmt = conn.createStatement();		        
       
	        //*******************************************************************************
			//calculate used quota for each day
	        for(int i=0; i<objAL.size(); i++)
	        {
	            ALQuotaObj obj = (ALQuotaObj) objAL.get(i);
	            sql = " SELECT Count(*) c FROM egtoffs " +
	            	  " WHERE To_Date('"+obj.getQuota_dt()+"','yyyy/mm/dd') BETWEEN offsdate AND offedate " +
	            	  " AND offsdate between To_Date('"+obj.getQuota_dt()+"','yyyy/mm/dd')-45 and To_Date('"+obj.getQuota_dt()+"','yyyy/mm/dd')" +
	            	  " AND alrelease ='Y' AND offtype in ('0','15','16') AND leaverank = '"+obj.getLeaverank()+"' ";
//	            System.out.println(sql);
	            rs = stmt.executeQuery(sql);
	            if(rs.next())
	            {
	                obj.setQuota_release(rs.getString("c"));
	            }
	        }
	    }
	    catch ( Exception e )
	    {
	        System.out.println(e.toString());
	    }
	    finally
	    {
	        try
	        {
	            if (rs != null)
	            {
	                rs.close();
	            }
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
    
    public ArrayList getObjAL()
    {
        return objAL;
    }
    
}
