package crewhousing;

import java.sql.*;
import java.util.*;

import ci.db.*;

/**
 * @author cs71 Created on  2008/8/5
 */
public class ValidStation
{

    ArrayList stationAL = new ArrayList();
    public static void main(String[] args)
    {       
        ValidStation vs = new ValidStation();
        vs.getStation("2008/01/01","2008/12/31");
    }
    
    public String getStation() //List Flts of available station
	{		
	    Connection conn = null;
		Statement stmt = null;	
		ResultSet rs = null;	
		String sql = "";
		String stn = "";
		try 
		{
		    ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();  
            stmt = conn.createStatement();
            
            sql = " SELECT s.stn stn  FROM fztrstn s ";
//		      System.out.println(sql);
		      rs = stmt.executeQuery(sql);
		      while(rs.next())
		      {
		         stationAL.add(rs.getString("stn"));
		      }
			return "Y";			
		} 
		catch (Exception e) 
		{
			return e.toString();
		} 
		finally 
		{
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {}
			if (stmt != null)
				try 
				{
					stmt.close();
				} catch (SQLException e) {}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException e) {}
		}
	}
	
    public String getStation(String sdate, String edate) //List Flts of available station
	{		
	    Connection conn = null;
		Statement stmt = null;	
		ResultSet rs = null;	
		String sql = "";
		String stn = "";
		try 
		{
		    ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();  
            stmt = conn.createStatement();
            
            sql = " SELECT s.stn stn  FROM fztrstn s " +
		      	  " WHERE s.effdt between to_date('"+sdate+"','yyyy/mm/dd') and to_date('"+edate+"','yyyy/mm/dd') " +
		      	  " AND ( s.expdt IS NULL OR s.expdt >= to_date('"+sdate+"','yyyy/mm/dd')) ";
//		      System.out.println(sql);
		      rs = stmt.executeQuery(sql);
		      while(rs.next())
		      {
		         stationAL.add(rs.getString("stn"));
		      }
			return "Y";			
		} 
		catch (Exception e) 
		{
			return e.toString();
		} 
		finally 
		{
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {}
			if (stmt != null)
				try 
				{
					stmt.close();
				} catch (SQLException e) {}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException e) {}
		}
	}
    
    public String stnMaintain() //List Flts of available station
	{		
	    Connection conn = null;
		Statement stmt = null;	
		ResultSet rs = null;	
		String sql = "";
		String stn = "";
		try 
		{
		    ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();  
            stmt = conn.createStatement();
            
            sql = " SELECT stn, to_char(effdt,'yyyy/mm/dd') effdt, to_char(expdt,'yyyy/mm/dd') expdt, chguser," +
            	  " to_char(chgdate,'yyyy/mm/dd') chgdate, " +
            	  " case when (effdt<=sysdate and ( expdt IS NULL OR expdt >= sysdate)) then 'Y' else 'N' end isvalid " +
            	  " FROM fztrstn ";
//		      System.out.println(sql);
		      rs = stmt.executeQuery(sql);
		      while(rs.next())
		      {
		         StnObj obj = new StnObj();
		         obj.setStn(rs.getString("stn"));
		         obj.setEffdt(rs.getString("effdt"));
		         obj.setExpdt(rs.getString("expdt"));
		         obj.setChguser(rs.getString("chguser"));
		         obj.setChgdate(rs.getString("chgdate"));
		         obj.setIfvalid(rs.getString("isvalid"));
		         stationAL.add(obj);
		      }
			return "Y";			
		} 
		catch (Exception e) 
		{
			return e.toString();
		} 
		finally 
		{
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {}
			if (stmt != null)
				try 
				{
					stmt.close();
				} catch (SQLException e) {}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException e) {}
		}
	}
	
	public ArrayList  getStationAL()
	{
	    return stationAL;
	}
    
}
