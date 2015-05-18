package fz.daysoff;

import ci.db.ConnDB;
import java.sql.*;
import java.util.*;

public class GetRank
{
    private Statement stmt = null;
    private ResultSet rs = null;
    private Connection conn = null;
    private Driver dbDriver = null;
    private String str = "0";
	private String sql = "";
	private String rank = "";
    ArrayList rankAL = new ArrayList();
    ArrayList empnoAL = new ArrayList();
    
    public GetRank (String yymm)
	{
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
			
			sql = " select staff_num, rank_cd FROM crew_rank_v " +
				  " where Trunc(eff_dt,'dd') <= To_Date('"+yymm+"01','yyyymmdd')  " +
				  " AND (exp_dt IS NULL OR trunc(exp_dt,'dd') >= Last_Day(To_Date('"+yymm+"01','yyyymmdd'))) " +
				  " AND rank_cd IN ('CA','FO','FDT','FE','RP') ";
            
            rs = stmt.executeQuery(sql);
            
            while(rs.next())
            {
                 empnoAL.add(rs.getString("staff_num"));
                 rankAL.add(rs.getString("rank_cd"));
            }
		}
		catch(Exception e)
		{
			System.out.println("Error : "+e.toString());  
		}
		finally
		{
			if(rs!=null)try{rs.close();}catch(Exception e){}
			if(stmt!=null)try{stmt.close();}catch(Exception e){}
			if(conn!=null)try{conn.close();}catch(Exception e){}
		}
	}

	public String getRank(String empno)
	{	   
	        int idx = 0;
	        String occu = "";
	        idx = empnoAL.indexOf(empno);
	        if ( idx != -1 ) 
	        {
	            occu = (String) rankAL.get(idx);
	        }
	        return occu;	
    }
	
    public static void main(String args []) 
	{
        GetRank ca = new GetRank("200705");
        System.out.println(ca.getRank("631848"));
        System.out.println(ca.getRank("639255"));
    }
    
}