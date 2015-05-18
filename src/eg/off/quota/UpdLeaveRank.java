package eg.off.quota;

import java.sql.*;
import ci.db.*;
/**
 * @author cs71 Created on  2007/9/28
 */
public class UpdLeaveRank
{   
    
    public static void main(String[] args)
    {
        UpdLeaveRank ulr = new UpdLeaveRank();
        System.out.println(new java.util.Date());
        ulr.setEmptyLeaveRank();
        System.out.println(new java.util.Date());
        System.out.println("Done");
    }
    
    public void setEmptyLeaveRank()
    {
        Connection conn = null;
        Statement stmt = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        
	    try
	    {
//	        ConnectionHelper ch = new ConnectionHelper();
//	        conn = ch.getConnection();
	        EGConnDB cn = new EGConnDB();
            cn.setORP3EGUser(); 
	    	java.lang.Class.forName(cn.getDriver());
	    	conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());   
	    	
//	    	cn.setORP3EGUser();  
//	    	java.lang.Class.forName(cn.getDriver());
//	    	conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),cn.getConnPW());
	        stmt = conn.createStatement();	
	        
	        //update egtoffs.leaverank
	        //****************************************************************************************
	        sql = " SELECT empn, offno FROM egtoffs WHERE offtype IN ('0','15','16') " +
	        	  " and offsdate between sysdate AND (SYSDATE + 120) AND leaverank IS null ";	        
	        rs = stmt.executeQuery(sql);

	        pstmt = conn.prepareStatement("update egtoffs set leaverank = ? where offno = ? ");
	        int count2 =0;
	        while (rs.next())
	        {			
//	            System.out.println(eg.GetJobType.getEmpJobType(rs.getString("empn")));
	            pstmt.setString(1, eg.GetJobType.getEmpJobType(rs.getString("empn")));
				pstmt.setString(2, rs.getString("offno"));
				pstmt.addBatch();
				count2++;
				if (count2 == 10)
				{
					pstmt.executeBatch();
					pstmt.clearBatch();
					count2 = 0;
				}
			}

			if (count2 > 0)
			{
				pstmt.executeBatch();
				pstmt.clearBatch();
			}	        
	        //*******************************************************************************
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
}
