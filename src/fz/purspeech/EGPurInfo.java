package fz.purspeech;

import java.sql.*;
import java.util.*;

import ci.db.*;

/**
 * @author cs71 Created on  2006/10/23
 */
public class EGPurInfo
{

    public static void main(String[] args)
    {
        EGPurInfo eg = new EGPurInfo();
        System.out.println(eg.getCname("631747"));
        System.out.println(eg.getEname("631747"));
        System.out.println(eg.getSern("631747"));
        System.out.println(eg.getSection("631747"));
        System.out.println("Done");
    }
    
  
    private Statement stmt = null;
    private ResultSet rs = null;
    private Connection conn = null;
    private Driver dbDriver = null;
    private String str = "0";
    private String sql = "";   
    private String cname = "";
    private String ename = "";
    
    private ArrayList empnoAL = new ArrayList();
    private ArrayList cnameAL = new ArrayList();
    private ArrayList enameAL = new ArrayList();
    private ArrayList sernAL = new ArrayList();
    private ArrayList sectionAL = new ArrayList();
    
    public EGPurInfo()
    {
        try
        {
            ConnDB cn = new ConnDB();
//            cn.setORP3EGUser();        
//	        java.lang.Class.forName(cn.getDriver());
//	        conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),cn.getConnPW());
	        	   
	        cn.setORP3EGUserCP();
	        dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	        conn = dbDriver.connect(cn.getConnURL(), null);
			
            stmt = conn.createStatement();
                       
            sql =  " SELECT trim(empn) empn, sern, SECTION, cname, ename  FROM egtcbas ";

            rs = stmt.executeQuery(sql);
            while (rs.next())
            {
               empnoAL.add(rs.getString("empn"));
               sernAL.add(rs.getString("sern"));
               cnameAL.add(rs.getString("cname"));
               enameAL.add(rs.getString("ename"));
               sectionAL.add(rs.getString("section"));
            }


        } 
        catch (Exception e)
        {
            str = "Error : " + e.toString();
        } 
        finally
        {
            if (rs != null)
                try
                {
                    rs.close();
                } catch (Exception e)
                {
                }
            if (stmt != null)
                try
                {
                    stmt.close();
                } catch (Exception e)
                {
                }
            if (conn != null)
                try
                {
                    conn.close();
                } catch (Exception e)
                {
                }
        }
    }

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
    
    public String getSern(String empno) 
    {
        int idx = 0;
        String sern = "";
        idx = empnoAL.indexOf(empno);
        if ( idx != -1 ) 
        {
            sern = (String) sernAL.get(idx);
        }
        return sern;
    }
    
    public String getSection(String empno) 
    {
        int idx = 0;
        String section = "";
        idx = empnoAL.indexOf(empno);
        if ( idx != -1 ) 
        {
            section = (String) sectionAL.get(idx);
        }
        return section;
    }

}
