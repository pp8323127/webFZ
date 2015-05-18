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
public class CheckPowerUser 
{
	 public static void main(String[] args) 
	 {
		 UserID u = new UserID("635863", "abc123");
		 CheckPowerUser ck = new CheckPowerUser();
		 System.out.println("是否為PowerUser(檢查密碼):" + ck.isPowerUser());
		 System.out.println("是否有powerUser帳號：" + ck.isHasPowerUserAccount());
	 }

	private ConnDB cn;
	private Connection conn;
	private Statement stmt;
	private String sql = null;
	private ResultSet rs;
	private Driver dbDriver = null;
	private boolean isPowerUser;
	private boolean hasPowerUserAccount;

	public CheckPowerUser() 
	{
		cn = new ConnDB();
//		 cn.setORP3FZUser();
		cn.setORP3FZUserCP();
		RetrieveData();
	}

	public boolean RetrieveData() throws NullPointerException 
	{
		String pwd = null;
		int count = 0;
		try 
		{
//			 java.lang.Class.forName(cn.getDriver());
//			 conn = DriverManager.getConnection(cn.getConnURL(),cn.getConnID(),cn.getConnPW());
			 
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);

			stmt = conn.createStatement();
			sql = "SELECT u.userid,u.pwd,i.GID "
					+ "FROM fztuser u,fztuidg i WHERE u.userid = i.userid AND u.userid='"
					+ UserID.getUserid() + "' AND i.gid='CSOZEZ'";

			rs = stmt.executeQuery(sql);
			while (rs.next()) 
			{
				pwd = rs.getString("pwd");
				count++;
			}
			if (count == 0) 
			{
				// 沒PowerUser帳號
				setHasPowerUserAccount(false);
				setPowerUser(false);
			} 
			else 
			{ // 有PowerUser帳號
				setHasPowerUserAccount(true);

				if (pwd.equals(UserID.getPassword())) 
				{
					// poweruser帳號密碼驗證成功
					setPowerUser(true);
				} 
				else 
				{
					setPowerUser(false);
				}
			}
		} 
		catch (ClassNotFoundException e) 
		{
			System.out.println(e.toString());
		} 
		catch (SQLException e) 
		{
			System.out.println(e.toString());
		} 
		catch (InstantiationException e) 
		{
			System.out.println(e.toString());
		} 
		catch (IllegalAccessException e) 
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
		return hasPowerUserAccount;
	}

	public boolean isHasPowerUserAccount() {
		return hasPowerUserAccount;
	}

	public void setHasPowerUserAccount(boolean hasPowerUserAccount) {
		this.hasPowerUserAccount = hasPowerUserAccount;
	}

	public boolean isPowerUser() {
		return isPowerUser;
	}

	public void setPowerUser(boolean isPowerUser) {
		this.isPowerUser = isPowerUser;
	}
}