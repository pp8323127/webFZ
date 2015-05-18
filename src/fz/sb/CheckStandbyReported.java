package fz.sb;

import java.sql.*;
import java.util.*;

import ci.db.*;

/**
 * CheckStandbyReported
 * 正式報到:有兩分鐘容忍遲到範圍
 * 
 * @author cs66
 * @version 1.0 2007/6/1
 * 
 * Copyright: Copyright (c) 2007
 */
public class CheckStandbyReported {
	// public static void main(String[] args) {
	// CheckStandbyReported c = new CheckStandbyReported("2007", "06", "01");
	// try {
	// c.SelectData();
	// System.out.println(c.getReported("641166", "787180"));
	// System.out.println(c.getReported("630731", "787184"));
	// } catch (Exception e) {
	// e.printStackTrace();
	// }
	//
	// }

	private String year;
	private String month;
	private String day;
	private ArrayList sbAL;
	/**
	 * @param year
	 *            四位數西元年
	 * @param month
	 *            月份
	 * @param day
	 *            日期
	 */
	public CheckStandbyReported(String year, String month, String day) {

		this.year = year;
		this.month = month;
		this.day = day;
	}

	public void SelectData() throws Exception {

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
					.prepareStatement("SELECT fz.*,(CASE WHEN fz.rrptdatetime IS  NULL "
							+ "THEN  null  WHEN fz.rrptdatetime >fz.erptdatetime "
							+ "AND fz.rrptdatetime <=  fz.erptdatetime +(1/24) "
							+ "THEN 'N' "
							+ "WHEN fz.rrptdatetime >fz.erptdatetime "
							+ "AND fz.rrptdatetime > (fz.erptdatetime +(1/24)) "
							+ "THEN 'N' ELSE 'Y' END ) rptFlag "
							+ "FROM fztsbrpt fz "
							+ "WHERE str_dt BETWEEN To_Date(?,'yyyymmdd hh24mi') "
							+ "AND  To_Date(?,'yyyymmdd hh24mi')");

			pstmt.setString(1, year + month + day + " 0000");
			pstmt.setString(2, year + month + day + " 2359");
			rs = pstmt.executeQuery();
			ArrayList al = null;

			while (rs.next()) {
				if (al == null)
					al = new ArrayList();
				StanbyCrewObj obj = new StanbyCrewObj();
				obj.setSeries_num(rs.getString("series_num"));
				obj.setEmpno(rs.getString("empno"));
				obj.setStr_dt_ts(rs.getTimestamp("str_dt"));
				obj.setEnd_dt_ts(rs.getTimestamp("end_dt"));

				if (rs.getString("rptFlag") == null) {
					// 尚未報到
					obj.setReported(false);

				} else if (rs.getString("rptFlag").equals("Y")) {
					// 準時報到
					obj.setOnTimeReported(true);

				} else if (rs.getString("rptFlag").equals("N")) {
					// 遲到或未到
					obj.setReported(true);
				}

				al.add(obj);

			}
			setSbAL(al);
			pstmt.close();
			rs.close();
			conn.close();

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

	public ArrayList getSbAL() {
		return sbAL;
	}

	public void setSbAL(ArrayList sbAL) {

		this.sbAL = sbAL;
	}

	/**
	 * 檢查組員是否準時報到
	 * 
	 * @param empno
	 * @param series_num
	 * @return
	 * 
	 */
	public boolean getOnTimeReported(String empno, String series_num) {
		boolean isOntimeReported = false;
		if (getSbAL() != null) {
			for (int i = 0; i < getSbAL().size(); i++) {
				StanbyCrewObj obj = (StanbyCrewObj) getSbAL().get(i);
				if (obj.getSeries_num().equals(series_num)
						&& obj.getEmpno().equals(empno)) {
					isOntimeReported = obj.isOnTimeReported();
					break;
				}
			}
		}
		return isOntimeReported;

	}

	/**
	 * 檢查組員是否已報到
	 * 
	 * @param empno
	 * @param series_num
	 * @return
	 * 
	 */
	public boolean getReported(String empno, String series_num) {
		boolean isReported = false;
		if (getSbAL() != null) {
			for (int i = 0; i < getSbAL().size(); i++) {
				StanbyCrewObj obj = (StanbyCrewObj) getSbAL().get(i);

				if (obj.getSeries_num().equals(series_num)
						&& obj.getEmpno().equals(empno)) {

					isReported = obj.isReported();
					break;
				}
			}
		}
		return isReported;

	}

}
