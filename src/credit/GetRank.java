package credit;

import ci.db.*;
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
    
    public GetRank()
	{
		try
		{
			ConnDB cn = new ConnDB();			
//			cn.setAOCIPROD();
//			java.lang.Class.forName(cn.getDriver());
//			conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),cn.getConnPW());
						
			cn.setAOCIPRODCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);
			
			stmt = conn.createStatement();		
			
			sql = "select staff_num, rank_cd FROM crew_rank_v where (exp_dt IS NULL OR exp_dt > SYSDATE)  ";
            
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
    
    public GetRank(String empno)
	{
		try
		{
			ConnDB cn = new ConnDB();			
//			cn.setAOCIPROD();
//			java.lang.Class.forName(cn.getDriver());
//			conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),cn.getConnPW());
						
			cn.setAOCIPRODCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);
			
			stmt = conn.createStatement();		
			
			sql = " select staff_num, rank_cd FROM crew_rank_v where staff_num = '"+empno+"' " +
				  " and (exp_dt IS NULL OR exp_dt > SYSDATE)  ";
            
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


	public String getRankAll(String empno)
	{
        try
		{
			ConnDB cn = new ConnDB();			
//			cn.setAOCIPROD();
//			java.lang.Class.forName(cn.getDriver());
//			conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),cn.getConnPW());
						
			cn.setAOCIPRODCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);
			
			stmt = conn.createStatement();			
			
			sql = "select rank_cd FROM crew_rank_v where staff_num = '"+empno+"' and (exp_dt IS NULL OR exp_dt > SYSDATE)  ";
            
            rs = stmt.executeQuery(sql);
            while(rs.next())
            {
                rank = rank+","+rs.getString("rank_cd");
            }
            
            if (rank.length() > 1)
            {
                str = rank.substring(1);
            }
            else
            {
                str = rank;
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
		return str;
    }

	
    public static void main(String args []) 
	{
        GetRank ca = new GetRank("635856");
//        System.out.println(ca.getRankAll("631848"));
        System.out.println(ca.getRank("635856"));
    }
    
}