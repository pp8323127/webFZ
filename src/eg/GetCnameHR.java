package eg;

import java.sql.*;
import ci.db.*;

public class GetCnameHR
{
	private Connection dbCon = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private Driver dbDriver = null;
	private String sql = "";

	public String getName(String empno) throws Exception{
		String cname = "";
		ConnDB cn = new ConnDB();
		
		try{
			//cn.setORP3FZUserCP();
			//dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			//dbCon = dbDriver.connect(cn.getConnURL(), null);
			Class.forName("oracle.jdbc.driver.OracleDriver");
   			dbCon = DriverManager.getConnection("jdbc:oracle:thin:@192.168.42.42:1521:ort1","fzdb","fz$888");
			
			sql = "select cname from hrdb.hrvegemploy where employid = '"+empno+"'";
			
			pstmt = dbCon.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()){
				cname = rs.getString("cname");
			}
			rs.close();
			pstmt.close();
			return cname;
		}
		catch (Exception e)
		{
			  throw e;
		}
		finally
		{
			try{if(rs != null) rs.close();}catch(SQLException e){}
			try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
			try{if(dbCon != null) dbCon.close();}catch(SQLException e){}
		}
	}
}