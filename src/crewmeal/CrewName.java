package crewmeal;

import java.sql.*;
import java.util.*;
import ci.db.*;

/**
 * @author cs71 Created on 2005/10/6
 */
public class CrewName
{
    private Statement stmt = null;
    private ResultSet rs = null;
    private Connection conn = null;
    private String sql = "";     
    private Driver dbDriver = null;

    private ArrayList empnoAL;
    private ArrayList cnameAL;
    private ArrayList enameAL;


//    public static void main(String[] args)
//    {
//        CrewName c = new CrewName();
//        System.out.println(c.getCname("635856"));
//        System.out.println(c.getEname("631848"));        
//        System.out.println(c.getNation("631848"));        
//        System.out.println(c.getUnitcd("631848"));
//        System.out.println(c.getPostcd("631848"));        
//        System.out.println(c.getUnitDsc("631848"));        
//        System.out.println(c.getPostDsc("631848"));        
//        System.out.println(c.getBirthdt("631848"));        
//        System.out.println(c.getIndt("631848"));        
//        System.out.println(c.getPostdt("631848"));  
//        System.out.println(c.getBanknoNT("631848"));        
//        System.out.println(c.getBanknoUS("631848"));         
//        
//    }

    
    public CrewName()
    {
        try 
        {
            ConnDB cn = new ConnDB();            
//            cn.setORP3FZUser();
//            java.lang.Class.forName(cn.getDriver());
//            conn = DriverManager.getConnection(cn.getConnURL() ,cn.getConnID() ,
//                    cn.getConnPW());            
            
    		cn.setORP3FZUserCP();
    		dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
    		conn = dbDriver.connect(cn.getConnURL(), null);
            stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);

            sql = "SELECT * FROM fzvname";
            rs = stmt.executeQuery(sql);
            empnoAL= new ArrayList();
            cnameAL= new ArrayList();
            enameAL= new ArrayList();
                     
            while (rs.next()) 
            {
                empnoAL.add(rs.getString("empno"));
                cnameAL.add(rs.getString("cname"));        
                enameAL.add(rs.getString("ename"));    
            }

        } 
        catch (SQLException e) 
        {
            System.out.print(e.toString());
        } 
        catch (Exception e) 
        {
            System.out.print(e.toString());

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
    }// end of public HRInfo()

    public CrewName(String empno)
    {
        try 
        {
            ConnDB cn = new ConnDB();
          
//            cn.setORP3FZUser();
//            java.lang.Class.forName(cn.getDriver());
//            conn = DriverManager.getConnection(cn.getConnURL() ,cn.getConnID() ,
//                    cn.getConnPW());            
            
    		cn.setORP3FZUserCP();
    		dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
    		conn = dbDriver.connect(cn.getConnURL(), null);
            stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);

            sql = "SELECT * FROM fzvname where empno = '"+empno+"'";

            rs = stmt.executeQuery(sql);

            empnoAL= new ArrayList();
            cnameAL= new ArrayList();
            enameAL= new ArrayList();
                     
            while (rs.next()) 
            {
                empnoAL.add(rs.getString("empno"));
                cnameAL.add(rs.getString("cname"));        
                enameAL.add(rs.getString("ename"));    
            }

        } 
        catch (SQLException e) 
        {
            System.out.print(e.toString());
        } 
        catch (Exception e) 
        {
            System.out.print(e.toString());

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
    }// end of public HRInfo(String empno) 
    
    
    
    public String getCname(String empno) 
    {
        int idx = 0;
        String cname = "";
        idx = empnoAL.indexOf(empno);
        if ( idx != -1 ) 
        {
            cname = (String) cnameAL.get(idx);
        }
        return cname;
    }  
    
    public String getEname(String empno) 
    {
        int idx = 0;
        String ename = "";
        idx = empnoAL.indexOf(empno);
        if ( idx != -1 ) 
        {
            ename = (String) enameAL.get(idx);
        }
        return ename;
    }  
       
}//end of class
