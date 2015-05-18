package swap3ackhh;

import java.sql.*;
import ci.db.*;

/**
 * PublishCheck 檢查班表是否正式公布
 * 
 * 
 * @author cs66
 * @version 1.0 2006/4/11
 * 
 * Copyright: Copyright (c) 2006
 */
public class PublishCheck {

//	public static void main(String[] args) {
//
//		PublishCheck pc = new PublishCheck("2006", "02");
//		if (pc.isSettingPubDate()) {// 已設定日期
//			System.out.println("班表是否已公布？" + pc.isPublished());
//		} else {
//			System.out.println("尚未設定班表公布日");
//		}
//
//	}

	private String year;
	private String month;
	private boolean isPublished = false;
	private boolean isSettingPubDate = false;
	/**
	 * @param year
	 *            班表日期（年 yyyy）
	 * @param month
	 *            班表日期（月 mm）
	 */
	public PublishCheck(String year, String month) {
		this.year = year;
		this.month = month;
		SelectData();
	}

	public void SelectData() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ConnDB cn = new ConnDB();
		Driver dbDriver = null;

		try {
			// User connection pool to ORP3DF
			cn.setORP3FZUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);

			// 直接連線
			// cn.setORT1FZ();
			// java.lang.Class.forName(cn.getDriver());
			// conn = DriverManager.getConnection(cn.getConnURL(),
			// cn.getConnID(),
			// cn.getConnPW());

			sql = "SELECT To_Char(pubdate,'yyyy/mm/dd hh24:mi') pubdate "
					+ "FROM fztspub WHERE yyyy='" + year + "' AND mm='" + month
					+ "' AND pubdate < SYSDATE";
			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();
			String str = null;
			while (rs.next()) {
				str = rs.getString("pubdate");
			}

			pstmt.close();
			rs.close();

			if (str != null) {
				setPublished(true);
				setSettingPubDate(true);
			} else {
				sql = "SELECT To_Char(pubdate,'yyyy/mm/dd hh24:mi') pubdate "
						+ "FROM fztspub WHERE yyyy='" + year + "' AND mm='"
						+ month + "' ";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					setSettingPubDate(true);
				}
			}

		} catch (SQLException e) {
			System.out.print(e.toString());
		} catch (Exception e) {
			System.out.print(e.toString());
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

	public boolean isPublished() {
		return isPublished;
	}
	private void setPublished(boolean isPublished) {
		this.isPublished = isPublished;
	}

	public boolean isSettingPubDate() {
		return isSettingPubDate;
	}

	private void setSettingPubDate(boolean isSettingPubDate) {
		this.isSettingPubDate = isSettingPubDate;
	}
}
