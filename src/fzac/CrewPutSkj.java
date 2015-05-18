package fzac;

import java.sql.*;
import java.util.*;

import ci.db.*;

/**
 * CrewPutSkj 取得組員已丟出之班表
 * 
 * 
 * @author cs66
 * @version 1.0 2007/1/31
 * 
 * Copyright: Copyright (c) 2007
 */
public class CrewPutSkj {

	private String empno;
	private String year;
	private String month;
	private ArrayList putSkjAL;// 已丟出之班表資料

	public CrewPutSkj(String empno, String year, String month) {
		this.empno = empno;
		this.year = year;
		this.month = month;
	}

	public void SelectData() {
		if (empno == null | year == null | month == null) {
			throw new NullPointerException("Parameter missed.");
		}
		Connection conn = null;
		ConnDB cn = new ConnDB();
		Driver dbDriver = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		ArrayList al = null;

		try {
			cn.setORP3FZUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);

			pstmt = conn
					.prepareStatement("select fdate,fltno,tripno,put_date putdate,comments from fztsput where empno =? and   fdate like ?");
			pstmt.setString(1, empno);
			pstmt.setString(2, year + "/" + month + "/%");
			rs = pstmt.executeQuery();

			while (rs.next()) {
				if (al == null) {
					al = new ArrayList();
				}
				swap3ac.CrewSkjObj obj = new swap3ac.CrewSkjObj();
				obj.setFdate(rs.getString("fdate"));
				obj.setDutycode(rs.getString("fltno"));
				obj.setTripno(rs.getString("tripno"));
				obj.setCd(rs.getString("comments"));
				al.add(obj);
			}
			setPutSkjAL(al);
			rs.close();
			pstmt.close();
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
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException e) {}
		}
	}

	public ArrayList getPutSkjAL() {
		return putSkjAL;
	}

	private void setPutSkjAL(ArrayList putSkjAL) {
		this.putSkjAL = putSkjAL;
	}
}
