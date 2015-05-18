package fzac;

import java.sql.*;
import java.util.*;

import ci.db.*;

/**
 * CockpitCrewRATLicenceNo 取得前艙組員空勤檢定證號碼（Licencd_cd='RAT'）
 * 
 * 
 * @author cs66
 * @version 1.0 2006/10/13
 * 
 * Copyright: Copyright (c) 2006
 */
public class CockpitCrewRATLicenceNo {

	ArrayList empnoAL = new ArrayList();
	ArrayList licence_numAL = new ArrayList();
	private int index;
	public void initData() throws ClassNotFoundException, SQLException,
			InstantiationException, IllegalAccessException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		ConnDB cn = new ConnDB();
		Driver dbDriver = null;

		try {

			cn.setAOCIPRODCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);

			pstmt = conn
					.prepareStatement("SELECT staff_num,licence_num FROM crew_licence_v "
							+ "WHERE (exp_dt >=SYSDATE OR Exp_dt IS NULL) "
							+ "AND licence_cd='RAT'GROUP BY staff_num  ,licence_num");

			rs = pstmt.executeQuery();

			while (rs.next()) {
				empnoAL.add(rs.getString("staff_num"));
				licence_numAL.add(rs.getString("licence_num"));

			}

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
	 * 設定empno所對應的index
	 */

	private void setIndex(String empno) {

		index = -1;

		try {
			if (empnoAL == null) {
				initData();
			}

			index = empnoAL.indexOf(empno);

		} catch (IndexOutOfBoundsException e) {
			index = -1;
		} catch (ClassNotFoundException e) {
			index = -1;
		} catch (SQLException e) {
			index = -1;
		} catch (InstantiationException e) {
			index = -1;
		} catch (IllegalAccessException e) {
			index = -1;
		}

	}

	/**
	 * 
	 * @param empno
	 *            員工號
	 * @return 檢定證號碼
	 * 
	 */
	public String getLicenceNo(String empno) {
		setIndex(empno);
		if (index != -1) {
			return (String) licence_numAL.get(index);
		} else {
			return "";
		}
	}
}
