package fz.pracP;

import ci.db.ConnDB;
import java.sql.*;

/**
 * PurReport 
 *
 * @author  cs55  
 * 
 */
public class PurReport {
	private Driver dbDriver = null;
	private Connection con = null;
	private Statement stmt = null;
	private ResultSet rs = null;

	/*public static void main(String[] args) {
		PurReport dr = new PurReport();
		String rs = dr.getGroups("20306");
		System.out.println(rs);
	}*/
	//傳入變數sern-->20306
	public String getGroups(String sern) {
		String groups = "&nbsp;";
		
		try{
			//connect ORP3 EG
		        ConnDB cn = new ConnDB();
			cn.setORP3EGUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			con = dbDriver.connect(cn.getConnURL(), null);
			stmt = con.createStatement();
			
			rs = stmt.executeQuery("select groups from egtcbas where sern=" + sern);
			if(rs.next()){
				groups = rs.getString("groups");
			}
			
		} catch(Exception e) {
			//e.printStackTrace();
			try{con.rollback();}catch(SQLException se){}
			return "Error:"+e.toString();
		}
		finally {
			try{if(rs != null) rs.close();}catch(SQLException e){}
	  		try{if(stmt != null) stmt.close();}catch(SQLException e){}
	   		try{if(con != null) con.close();}catch(SQLException e){}
		}
		return groups;
	}
	public String getBP(String fltd, String fltno, String sect, String sern) {
		int rCount = 0;
		String rstring = "&nbsp;";
		
		try{
			//connect ORP3 EG
		        ConnDB cn = new ConnDB();
			cn.setORP3EGUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			con = dbDriver.connect(cn.getConnURL(), null);
			stmt = con.createStatement();
			
			rs = stmt.executeQuery("select count(*) rcount from egtgddt where fltd=to_date('"+fltd+
			"','yyyy/mm/dd') and fltno='"+fltno+"' and sect=upper('"+sect+"') and gdtype='GD1' and sern=" + sern);
			if(rs.next()){
				rCount = rs.getInt("rcount");
			}
			if(rCount > 0){
				rstring = "*";
			}
			else{
				rstring = "&nbsp;";
			}
		} catch(Exception e) {
			//e.printStackTrace();
			try{con.rollback();}catch(SQLException se){}
			return "Error:"+e.toString();
		}
		finally {
			try{if(rs != null) rs.close();}catch(SQLException e){}
	  		try{if(stmt != null) stmt.close();}catch(SQLException e){}
	   		try{if(con != null) con.close();}catch(SQLException e){}
		}
		return rstring;
	}
}
