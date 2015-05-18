package fzAuthP;
import java.sql.*;
import ci.db.*;

/**
 * 驗證是否為PowerUser(admin...), <br>
 * 驗證table: fztuser <br>
 * DB:Connection pool
 * 
 * @author cs66 at 2005/6/29
 * @version 1.1 2006/03/01
 */
public class CheckAccPwd 
{
	 public static void main(String[] args) 
    {	 
	     CheckAccPwd ck = new CheckAccPwd("EDUser","ED123");
		 System.out.println("是否有帳號(檢查密碼):" + ck.hasAccount());
	 }

	
	
	private boolean correctpwd = false;
	private String userid = "";
	private String pwd = "";

	public CheckAccPwd(String userid, String pwd) 
	{
	    this.userid = userid;
	    this.pwd = pwd;		
		RetrieveData();
	}

	public void RetrieveData() throws NullPointerException 
	{
		int count = 0;
		Connection conn = null;
		Statement stmt =null;;
		String sql = null;
		ResultSet rs = null;
		Driver dbDriver = null;
		try 
		{
		    ConnDB cn = new ConnDB();
//			 cn.setORP3FZUser();
//			 java.lang.Class.forName(cn.getDriver());
//			 conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());

		    cn.setORP3FZUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);

			stmt = conn.createStatement();
			sql = " SELECT count(*) c FROM fztuidg WHERE userid = '"+userid+"' AND password = '"+pwd+"' " +
				  " AND password IS NOT NULL ";
//System.out.println(sql);
			rs = stmt.executeQuery(sql);
			if (rs.next()) 
			{
				count = rs.getInt("c");
			}
			
			if (count > 0) 
			{
				// 有帳號且密碼正確
			    correctpwd = true;
			} 		
		} 
		catch (SQLException e) 
		{
			System.out.println(e.toString());
		} 
		catch (Exception e) 
		{
			System.out.println(e.toString());
		} 
		finally 
		{
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {
					System.out.println(e.toString());
				}
			if (stmt != null)
				try {
					stmt.close();
				} catch (SQLException e) {
					System.out.println(e.toString());
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException e) {
					System.out.println(e.toString());
				}
		}
	}


	public boolean hasAccount() 
	{
		return correctpwd;
	}

}