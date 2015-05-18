package fz.daysoff;

import ci.db.ConnDB;
import java.sql.*;
import java.util.*;

public class GetFleet
{
    private Statement stmt = null;
    private ResultSet rs = null;
    private Connection conn = null;
    private Driver dbDriver = null;   
    ArrayList objAL = new ArrayList();
    ArrayList empAL = new ArrayList();

    public GetFleet(String yymm)
	{
	    String str = "0";
		String sql = "";
	    String fleet = "";
	    
        try
		{
			ConnDB cn = new ConnDB();			
			cn.setAOCIPROD();
			java.lang.Class.forName(cn.getDriver());
			conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),cn.getConnPW());
						
//			cn.setAOCIPRODCP();
//			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
//			conn = dbDriver.connect(cn.getConnURL(), null);
			
			stmt = conn.createStatement();

			sql = " SELECT * FROM crew_fleet_v WHERE Trunc(eff_dt,'dd') <= To_Date('"+yymm+"01','yyyymmdd')  " +
				  " AND (exp_dt IS NULL OR trunc(exp_dt,'dd') >= Last_Day(To_Date('"+yymm+"01','yyyymmdd'))) " +
				  " AND fleet_cd IN ('738','744','343','333','APQ','AB6') ";
            
            rs = stmt.executeQuery(sql);
            while(rs.next())
            {
                empAL.add(rs.getString("staff_num"));
                objAL.add(rs.getString("fleet_cd"));
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
    
    public String getFleet(String empno)
    {
        String str = "";
        for(int i=0; i<empAL.size(); i++)
        {
            if(empno.equals(empAL.get(i)))
            {
                str = str +"/"+ objAL.get(i);
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
        GetFleet ca = new GetFleet("200705");
        //System.out.println(ca.getFleetAll("631848"));

        //System.out.println(ca.getFleetAll("638767"));
        System.out.println(new java.util.Date());
        System.out.println(ca.getFleet("631848"));
        System.out.println(new java.util.Date());
        System.out.println(ca.getFleet("631848"));
        System.out.println(new java.util.Date());
        System.out.println(ca.getFleet("635855"));
        System.out.println(new java.util.Date());
    }
    
}