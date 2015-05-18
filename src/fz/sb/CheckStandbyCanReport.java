package fz.sb;

import java.sql.*;
import ci.db.*;

/**
 * CheckStandbyCanReport 檢查是否符合 standby 報到條件 (應報到時間前後四小時內),並更新資料
 * 
 * 
 * @author cs66
 * @version 1.0 2007/6/4
 * 
 * Copyright: Copyright (c) 2007
 */
public class CheckStandbyCanReport {
	private String empno;
	private boolean isReportable = false;
	private String message;
	private String series_num;



	public CheckStandbyCanReport(String empno) {
		this.empno = empno;
		CheckAndUpdateData();
	}
	public void CheckAndUpdateData() {

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		ConnDB cn = new ConnDB();
		Driver dbDriver = null;

		try {
			cn.setORP3FZUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);

		
			String cname = "";
			pstmt = conn.prepareStatement("select cname from egdb.egtcbas where trim(empn)=?");
			pstmt.setString(1, empno);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				cname = "("+rs.getString("cname")+")<br>";
			}

			rs.close();
			pstmt.close();

			pstmt = conn.prepareStatement("SELECT * FROM fztsbrpt "
					+ "WHERE empno=? AND SYSDATE BETWEEN str_dt-(4/24) "
					+ "AND str_dt +(4/24)");

			pstmt.setString(1, empno);
			rs = pstmt.executeQuery();
			int tempCount = 0;
			while (rs.next()) {
				if (rs.getString("rrptDateTime") != null) {
					setReportable(false);
					setMessage(empno + " " + cname + " 您已經報到,無須重複報到.");
				} else {
					setReportable(true);
					setSeries_num(rs.getString("series_num"));

				}
				tempCount++;

			}
			rs.close();
			pstmt.close();
			conn.close();

			if (tempCount == 0) {
				setMessage(empno + " " + cname + " 目前您無 Standby 需報到<br>"
						+ "如有任何疑問請洽簽派櫃臺");
			} else if (isReportable()) {
				UpdateData(cname);
			}

		} catch (Exception e) {
			System.out.println("失敗" + e.toString());
			setMessage(getMessage() + "失敗" + e.toString());
		} finally {

			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException e) {}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException e) {}

		}
	}

	/**
	 * 更新資料
	 * 
	 */
	private void UpdateData(String cname) {
		if (series_num == null || empno == null) {
			return;
		} else {
			if(cname == null)
				cname = "";
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			ConnDB cn = new ConnDB();
			Driver dbDriver = null;

			try {
				cn.setORP3FZUserCP();
				dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
				conn = dbDriver.connect(cn.getConnURL(), null);


				pstmt = conn
						.prepareStatement("UPDATE fztsbrpt SET rrptdatetime=SYSDATE,"
								+ "updateuser=? WHERE series_num=? AND empno=? ");

				pstmt.setString(1, empno);
				pstmt.setString(2, getSeries_num());
				pstmt.setString(3, empno);
				pstmt.executeUpdate();
				setMessage(empno + " " + cname + " 您已完成報到手續");

				pstmt.close();
				conn.close();

			} catch (Exception e) {
				System.out.println(e.toString());
				setMessage(getMessage() + "失敗:" + e.toString());
			} finally {

				if (rs != null)
					try {
						rs.close();
					} catch (SQLException e) {}
				if (pstmt != null)
					try {
						pstmt.close();
					} catch (SQLException e) {}
				if (conn != null)
					try {
						conn.close();
					} catch (SQLException e) {}

			}
		}

	}

	public boolean isReportable() {
		return isReportable;
	}
	public void setReportable(boolean isReportable) {
		this.isReportable = isReportable;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getSeries_num() {
		return series_num;
	}

	public void setSeries_num(String series_num) {
		this.series_num = series_num;
	}
}
