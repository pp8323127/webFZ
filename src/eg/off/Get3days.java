package eg.off;

import java.sql.*;
import java.util.*;
import ci.db.*;

/**
 * @author cs71 Created on  2007/12/27
 */
public class Get3days
{

    public static void main(String[] args)
    {
    }
    
    private static Connection conn = null;
    private static Statement stmt = null;
    private static ResultSet rs = null;
    private String sql = null;
    private ArrayList daysAL = new ArrayList();
    
    public String get3daysAL()
    {
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();

//          ******************************************************************************
            sql = " SELECT To_Char(SYSDATE-1,'yyyy/mm/dd') dp, To_Char(SYSDATE,'yyyy/mm/dd') d1,  " +
            	  " To_Char(SYSDATE+1,'yyyy/mm/dd') dn FROM dual " ;      
            rs = stmt.executeQuery(sql);

            if (rs.next())
            {
                daysAL.add(rs.getString("dp"));
                daysAL.add(rs.getString("d1"));
                daysAL.add(rs.getString("dn"));
            }
            //******************************************************************************
            return "Y";
        }
        catch ( Exception e )
        {
            System.out.println(e.toString());
            return e.toString();
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
    
    public ArrayList getDaysAL()
    {
        return daysAL;
    }
}
