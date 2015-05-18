package eg;

import ci.db.ConnDB;
import java.sql.*;

public class CheckLogon {
	private Connection con = null;
	private Statement stmt = null;
	private ResultSet rs = null;
	private Driver dbDriver = null;
	
	private String userstation = null;
	private String username = null;
	private String sql = null;
	
	/*public static void main(String[] args) {
		CheckLogon cl = new CheckLogon();
		System.out.println(cl.doCheck("a", "aa0716"));
	}*/

	public String doCheck(String userid, String password) {
		//¿À¨dlogon ID and Password¨Oß_•øΩT
		try{
			//connect ORP3 EG
		        ConnDB cn = new ConnDB();
			cn.setORP3EGUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			con = dbDriver.connect(cn.getConnURL(), null);
			stmt = con.createStatement();
					
			sql = "select userstation, username from egtuser where userid=upper('"+userid+"') and password=upper('"+password+"')";
			rs = stmt.executeQuery(sql);
	
			if(rs.next()){
				userstation = rs.getString("userstation");
				username = rs.getString("username");
			}

		} catch(Exception e) {
			//e.printStackTrace();
			try{con.rollback();}catch(SQLException se){}
			return e.toString()+"Error:"+sql;
		}
		finally {
			try{if(rs != null) rs.close();}catch(SQLException e){}
	  		try{if(stmt != null) stmt.close();}catch(SQLException e){}
	   		try{if(con != null) con.close();}catch(SQLException e){}
		}
		if(username == null){
			return "Please check your Id or Password !!";
		}
		else{
			return "0";
		}
	}
	public String getStation(){
		return userstation;
	}
	public String getName(){
		return username;
	}
}
