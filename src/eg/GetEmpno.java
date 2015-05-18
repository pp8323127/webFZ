package eg;

import java.sql.*;
import ci.db.*;

/**
 * @author cs71 Created on  2007/8/29
 */
public class GetEmpno
{  
    
    public static void main(String[] args)
    {
   //     PlanPeriod pp = new PlanPeriod();
        System.out.println(GetEmpno.getEmpno("9635"));
        System.out.println("Done");
    }
    
	public static String getEmpno(String empno) 
	{
	    String empn ="";
	    Driver dbDriver = null;
	    Connection conn = null;
	    Statement stmt = null;
	    ResultSet rs = null;
	    String sql = "";
	    try
        {
	        ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();
            //******************************************************************************
            sql = " SELECT empn FROM egtcbas WHERE empn = '"+empno+"' " +
            	  " union SELECT empn FROM egtcbas WHERE sern = '"+empno+"' ";

//            System.out.println(sql);
            rs = stmt.executeQuery(sql);

            if (rs.next())
            {
                empn = rs.getString("empn").trim();
            }        
            
            return empn;
        }
        catch ( Exception e )
        {
            System.out.println(e.toString());
            return "Error : "+e.toString();
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
     
  
}
