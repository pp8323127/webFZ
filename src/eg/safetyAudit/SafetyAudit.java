package eg.safetyAudit;

import java.sql.*;
import ci.db.ConnDB;

public class SafetyAudit {

    /**
     * @param args
     */
    private String purName  = null;
    private String purSern  = null;
    private String sql = null;
    private String returnStr = null;
    
    public static void main(String[] args) {
        // TODO Auto-generated method stub
        SafetyAudit a = new SafetyAudit();
         System.out.print(a.getSAinfo("630304"));
        
    }
    
    public SafetyAudit(){
        
    }
    
    public String getSAinfo(String purempno)
    {
        Statement stmt = null;
        ResultSet rs = null;
        Connection conn = null;
        Driver dbDriver = null;
        
        try 
        {
            ConnDB cn = new ConnDB();
            
            cn.setORP3EGUser();
            java.lang.Class.forName(cn.getDriver());
            conn = DriverManager.getConnection(cn.getConnURL() ,cn.getConnID() , cn.getConnPW());      
            stmt = conn.createStatement();
            sql= "select EMPN, SERN, CNAME from egtcbas where empn = '"+ purempno+ "' ";
            rs = stmt.executeQuery(sql);     
            while(rs.next())
            {
                purName = rs.getString("cname");
                purSern = rs.getString("sern");
            }  
            
        } 
        catch (SQLException e) 
        {
            System.out.print(e.toString());
            returnStr = e.toString();
        } 
        catch (Exception e) 
        {
            System.out.print(e.toString());
            returnStr = e.toString();
        }
        finally 
        {

            if ( rs != null ) try {
                rs.close();
            } catch (SQLException e) {}
            if ( stmt != null ) try {
                stmt.close();
            } catch (SQLException e) {}
            if ( conn != null ) try {
                conn.close();
            } catch (SQLException e) {}

        }
        return purName+"/"+purSern;
    }
}
