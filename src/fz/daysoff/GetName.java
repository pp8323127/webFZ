package fz.daysoff;

import ci.db.ConnDB;
import java.sql.*;
import java.util.*;

public class GetName
{
    private Statement stmt = null;
    private ResultSet rs = null;
    private Connection conn = null;
    private Driver dbDriver = null;   
    ArrayList cnameAL = new ArrayList();
    ArrayList enameAL = new ArrayList();
    ArrayList empAL = new ArrayList();

    public GetName()
	{
	    String str = "0";
		String sql = "";
	    String fleet = "";
	    
        try
		{
			ConnDB cn = new ConnDB();			
			cn.setORP3DFUser();
			java.lang.Class.forName(cn.getDriver());
			conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),cn.getConnPW());
						
//			cn.setORP3FZUserCP();
//			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
//			conn = dbDriver.connect(cn.getConnURL(), null);
			
			stmt = conn.createStatement();

			sql = "  SELECT employid, cname, lname, fname FROM hrvegemploy  ";
            
            rs = stmt.executeQuery(sql);
            while(rs.next())
            {
                empAL.add(rs.getString("employid"));
                cnameAL.add(rs.getString("cname"));
                enameAL.add(rs.getString("fname")+" "+rs.getString("lname"));
            }  
		}
		catch(Exception e)
		{
			str = "Error : "+e.toString();  
		}
		finally
		{
			if(rs!=null)try{rs.close();}catch(Exception e){}
			if(stmt!=null)try{stmt.close();}catch(Exception e){}
			if(conn!=null)try{conn.close();}catch(Exception e){}
		}
    }	
    
    public String getCname(String empno)
    {
        String str = "";
        for(int i=0; i<empAL.size(); i++)
        {
            if(empno.equals(empAL.get(i)))
            {
                str = str +"/"+ cnameAL.get(i);
            }
        }
        
        if(!"".equals(str))
        {
            str = str.substring(1);
        }
        return str;
    }
    
    public String getEname(String empno)
    {
        String str = "";
        for(int i=0; i<empAL.size(); i++)
        {
            if(empno.equals(empAL.get(i)))
            {
                str = str +"/"+ enameAL.get(i);
            }
        }
        
        if(!"".equals(str))
        {
            str = str.substring(1);
        }
        return str;
    }
    
    public static void main(String args []) 
	{
        System.out.println(new java.util.Date());
        GetName ca = new GetName();
        //System.out.println(ca.getFleetAll("631848"));

        //System.out.println(ca.getFleetAll("638767"));
        System.out.println(new java.util.Date());
        System.out.println(ca.getCname("631848"));
        System.out.println(new java.util.Date());
        System.out.println(ca.getEname("631848"));
        System.out.println(new java.util.Date());
    }
    
}