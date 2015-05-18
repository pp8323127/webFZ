package ci.tool;

import java.sql.*;

/**
 * WriteFZUseLog
 * 
 * 
 * @author cs66
 * @version 1.0 2007/5/30
 * 
 * Copyright: Copyright (c) 2007
 */
public class WriteFZUseLog {
	private String userid;
	private String userip;
	private String sysid;
	private String prgid;
	private String executeYear;
	private String executeMonth;
	private String status;
	private String comments;

	/**
	 * @param userid
	 *            使用者帳號
	 * @param userip
	 *            使用者IP
	 * @param sysid
	 *            系統代號
	 * @param prgid
	 *            程式代號
	 * @param executeYear
	 *            執行年份
	 * @param executeMonth
	 *            執行日期
	 * @param status
	 *            狀態
	 * @param comments
	 *            備註
	 */
	public WriteFZUseLog(String userid, String userip, String sysid,
			String prgid, String executeYear, String executeMonth,
			String status, String comments) {

		this.userid = userid;
		this.userip = userip;
		this.sysid = sysid;
		this.prgid = prgid;
		this.executeYear = executeYear;
		this.executeMonth = executeMonth;
		this.status = status;
		this.comments = comments;
	}
	public WriteFZUseLog() {}

	public void InsertData() throws Exception {
		if (userid == null)
			throw new NullPointerException("Userid is required!!");

		Connection conn = null;
		PreparedStatement pstmt = null;

		ci.db.ConnDB cn = new ci.db.ConnDB();
		// ConnectDB cn = new ConnectDB();
		// LocalConnectDB cn = new LocalConnectDB();
		Driver dbDriver = null;
		try {
			// User connection pool to ORP3DF
			cn.setORP3FZUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);

			// 直接連線 ORP3FZ
			// cn.setORT1EG();
			// cn.setORP3EGUser();
			// java.lang.Class.forName(cn.getDriver());
			// conn = DriverManager.getConnection(cn.getConnURL(),
			// cn.getConnID(),
			// cn.getConnPW());
			// conn = cn.getDataSourceConnection();

			pstmt = conn
					.prepareStatement("INSERT INTO fztlog "
							+ "(login_time,userid,userip,sysid,prgid,executeYear,executeMonth,status,comments) "
							+ "VALUES(SYSDATE,?,?,?,?,?,?,?,?)");
			pstmt.setString(1, userid);
			pstmt.setString(2, userip);
			pstmt.setString(3, sysid);
			pstmt.setString(4, prgid);
			pstmt.setString(5, executeYear);
			pstmt.setString(6, executeMonth);
			pstmt.setString(7, status);
			pstmt.setString(8, comments);

			pstmt.executeUpdate();

			pstmt.close();
			conn.close();

		} catch (Exception e) {
			System.out.println("write FZUSERLOG ERROR:"+e.toString());
		} finally {

			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException e) {}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {

				}
				conn = null;
			}
		}

	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	public void setExecuteMonth(String executeMonth) {
		this.executeMonth = executeMonth;
	}
	public void setExecuteYear(String executeYear) {
		this.executeYear = executeYear;
	}
	public void setPrgid(String prgid) {
		this.prgid = prgid;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public void setSysid(String sysid) {
		this.sysid = sysid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public void setUserip(String userip) {
		this.userip = userip;
	}

}
