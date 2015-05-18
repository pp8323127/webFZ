package fzAuthP;

import java.sql.*;

import ci.db.*;

/**
 * 驗證人事資料 <br>
 * DB:Connection pool
 * 
 * @author cs66 at 2005/6/29
 * @version 1.1 2006/03/01
 */
public class CheckHRUnit 
{
	private ConnDB cn;
	private Connection conn;
	private Statement stmt;
	private String sql = null;
	private Driver dbDriver = null;
	private ResultSet rs;
	private fzAuthP.HRObj hrObj;
	private boolean isHR; // 有人力資料
	private boolean isDutyEmp; // 在職員工

	public CheckHRUnit() 
	{
		cn = new ConnDB();
//		cn.setORP3FZUser();
		 cn.setORP3FZUserCP();
		RetrieveData();
	}

	public void RetrieveData() throws NullPointerException 
	{
		try 
		{
//			 java.lang.Class.forName(cn.getDriver());
//			 conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),cn.getConnPW());

			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);

			stmt = conn.createStatement();
			sql = "SELECT h.analysa analysa,h.indt,h.employid,h.exstflg,h.cname,h.fname||' '||h.lname ename,h.unitcd ,"
					+ "u2.unitcd uperUnit FROM hrvegemploy h,hrvpbunitcd u,hrvpbunitcd u2 "
					+ "WHERE h.unitcd=u.unitcd AND u.uperut =u2.unitcd AND  h.employid='"
					+ UserID.getUserid() + "'";
			
			rs = stmt.executeQuery(sql);

			while (rs.next()) 
			{
				hrObj = new HRObj();
				hrObj.setEmployid(rs.getString("employid"));
				hrObj.setCname(rs.getString("cname"));
				hrObj.setExstflg(rs.getString("exstflg"));
				hrObj.setUnitcd(rs.getString("unitcd"));
				hrObj.setAnalysa(rs.getString("analysa"));
				hrObj.setIndt(rs.getString("indt"));
				hrObj.setPostcd(rs.getString("postcd"));
			
				setHrObj(hrObj);
			}

			if (null == hrObj) 
			{
				setNoHR();
			} 
			else 
			{
				setHR(true);

				// 檢查是否在職
				if ("Y".equals(hrObj.getExstflg())) 
				{
					setDutyEmp(true);
				} 
				else 
				{
					setDutyEmp(false);
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
	}

	/**
	 * 設定無人事資料者之各項身份判斷.
	 */
	public void setNoHR() {
		setHR(false);

		setDutyEmp(false);

	}

	public boolean isDutyEmp() {
		return isDutyEmp;
	}

	public void setDutyEmp(boolean hasHR) {
		this.isDutyEmp = hasHR;
	}

	public boolean isHR() {
		return isHR;
	}

	public void setHR(boolean isHR) {
		this.isHR = isHR;
	}

	public HRObj getHrObj() {
		if (null == hrObj) { 
			hrObj = new HRObj();
		}
		return hrObj;
	}

	public void setHrObj(HRObj hrObj) {
		this.hrObj = hrObj;
	}
}