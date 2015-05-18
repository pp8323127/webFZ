package fz.pracP.zc;

import java.sql.*;
import java.util.*;

import ci.db.*;

/**
 * EvaluationType 取得助理座艙長考評項目資料
 * 
 * 
 * @author cs66
 * @version 1.0 2007/3/15
 * 
 * Copyright: Copyright (c) 2007
 */
public class EvaluationType {
	private ArrayList dataAL;

	public EvaluationType() {
		SelectData();
	}

	public void SelectData() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ConnDB cn = new ConnDB();
		Driver dbDriver = null;
		try {
			cn.setORP3EGUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);

			pstmt = conn
					.prepareStatement("SELECT * FROM egtzcdesc order by scoretype");

			ArrayList al = null;
			rs = pstmt.executeQuery();
			while (rs.next()) {
				if (al == null)
					al = new ArrayList();

				EvaluationTypeObj obj = new EvaluationTypeObj();
				obj.setScoreType(rs.getString("scoreType"));
				obj.setScoreDesc(rs.getString("scoreDesc"));
				obj.setDescDetail(rs.getString("descDetail"));

				al.add(obj);
			}

			setDataAL(al);

			pstmt.close();
			rs.close();
			conn.close();

		} catch (Exception e) {
			System.out.println(e.toString());
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

				}
				conn = null;
			}
		}
	}
	public ArrayList getDataAL() {
		return dataAL;
	}
	private void setDataAL(ArrayList dataAL) {
		this.dataAL = dataAL;
	}
}
