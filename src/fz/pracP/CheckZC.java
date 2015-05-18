package fz.pracP;

import java.sql.*;

import ci.db.*;

/**
 * CheckZC 組員Duty = 'ZC' 時必須輸入Zone Chief考評
 * 
 * 
 * @author cs66
 * @version 1.0 2007/1/16
 * 
 * Copyright: Copyright (c) 2007
 */
public class CheckZC {


	private String fdate;// format: yyyy/mm/dd
	private String fltno;
	private String sect;
	private String purserEmpno;
	private String[] crewEmpno;
	private String[] crewDuty;
	private String zcEmpno;
	private boolean hasZC = false;
	private boolean isZCEvaluated = false;

	/**
	 * @param fdate
	 *            日期
	 * @param fltno
	 *            班號
	 * @param sect
	 *            航段
	 * @param purserEmpno
	 *            座艙長員工號
	 * @param crewEmpno
	 *            組員員工號陣列
	 * @param crewDuty
	 *            組員Duty陣列
	 */
	public CheckZC(String fdate, String fltno, String sect, String purserEmpno,
			String[] crewEmpno, String[] crewDuty) {
		this.fdate = fdate;
		this.fltno = fltno;
		this.sect = sect;
		this.purserEmpno = purserEmpno;
		this.crewDuty = crewDuty;
		this.crewEmpno = crewEmpno;
		setHasZC();
	}

	public boolean isHasZC() {
		return hasZC;
	}

	private void setHasZC() {
		if (crewDuty != null) {
			for (int i = 0; i < crewDuty.length; i++) {
				if ("ZC".equals(crewDuty[i])) {
					this.hasZC = true;
					setZcEmpno(this.crewEmpno[i]);

				}
			}
		}
	}

	public void SelectData() {
		if (isHasZC()) {

			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			ConnDB cn = new ConnDB();
			Driver dbDriver = null;

			try {
				cn.setORP3EGUserCP();
				dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
				conn = dbDriver.connect(cn.getConnURL(), null);

				pstmt = conn.prepareStatement("SELECT * FROM egtzcdt "
						+ "WHERE fltd=To_Date(?,'yyyy/mm/dd') "
						+ "AND fltno=? AND sect = ? and empno=?");

				pstmt.setString(1, fdate);
				pstmt.setString(2, fltno);
				pstmt.setString(3, sect);
				pstmt.setString(4, zcEmpno);

				rs = pstmt.executeQuery();
				if (rs.next()) {
					setZCEvaluated(true);

				}

				pstmt.close();
				rs.close();
				conn.close();

			} catch (Exception e) {

			} finally {
				if (rs != null)
					try {
						rs.close();
					} catch (SQLException e) {}
				if (pstmt != null)
					try {
						pstmt.close();
					} catch (SQLException e) {}
				if (conn != null) {
					try {
						conn.close();
					} catch (SQLException e) {
						System.out.println(e.toString());
					}
					conn = null;
				}
			}
		}
	}

	public void deleteData() {

		Connection conn = null;
		PreparedStatement pstmt = null;

		ConnDB cn = new ConnDB();
		Driver dbDriver = null;

		try {

			cn.setORP3EGUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);

			if (isHasZC()) {
				pstmt = conn.prepareStatement("delete egtzcdt "
						+ "WHERE fltd=To_Date(?,'yyyy/mm/dd') "
						+ "AND fltno=? AND sect = ? and empno =?");

				pstmt.setString(1, fdate);
				pstmt.setString(2, fltno);
				pstmt.setString(3, sect);
				pstmt.setString(4, zcEmpno);

				pstmt.executeUpdate();
			} else {
				// 全部刪除
				pstmt = conn.prepareStatement("delete egtzcdt "
						+ "WHERE fltd=To_Date(?,'yyyy/mm/dd') "
						+ "AND fltno=? AND sect = ?");
				pstmt.setString(1, fdate);
				pstmt.setString(2, fltno);
				pstmt.setString(3, sect);
				pstmt.executeUpdate();
			}
			pstmt.close();

			conn.close();

		} catch (Exception e) {

		} finally {

			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException e) {}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					System.out.println(e.toString());
				}
				conn = null;
			}
		}

	}

	public boolean isZCEvaluated() {
		return isZCEvaluated;
	}

	private void setZCEvaluated(boolean isZCEvaluated) {
		this.isZCEvaluated = isZCEvaluated;
	}

	public String getZcEmpno() {
		return zcEmpno;
	}

	private void setZcEmpno(String zcEmpno) {
		this.zcEmpno = zcEmpno;
	}

}
