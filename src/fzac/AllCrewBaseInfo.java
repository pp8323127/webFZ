package fzac;

import java.sql.*;
import java.util.*;

import ci.db.*;

/**
 * AllCrewBaseInfo 取得全部組員Base資料
 * 
 * 
 * @author cs66
 * @version 1.0 2006/10/2
 * 
 * Copyright: Copyright (c) 2006
 */
public class AllCrewBaseInfo {

	// public static void main(String[] args){
	// AllCrewBaseInfo al = new AllCrewBaseInfo();
	// // System.out.println(al.getBase("640090"));
	// }

	private ArrayList empnoAL;
	private ArrayList baseAL;
	private String startDateInYMD = null;

	public AllCrewBaseInfo() {
		SelectData();

	}

	public AllCrewBaseInfo(String startDateInYMD) {
		this.startDateInYMD = startDateInYMD;
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
			cn.setAOCIPRODCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);

			if (startDateInYMD != null) {
				pstmt = conn
						.prepareStatement("SELECT staff_num,base FROM crew_base_v b "
								+ "WHERE prim_base='Y' AND b.eff_dt <= To_Date(?,'yyyymmdd') "
								+ "AND (b.Exp_dt IS NULL OR b.Exp_dt >=To_Date(?,'yyyymmdd') ) "
								+ "GROUP BY staff_num,base");
				pstmt.setString(1, startDateInYMD);
				pstmt.setString(2, startDateInYMD);

			} else {
				pstmt = conn
						.prepareStatement("SELECT staff_num,base FROM crew_base_v b "
								+ "WHERE prim_base='Y' AND b.eff_dt <= sysdate "
								+ "AND (b.Exp_dt IS NULL OR b.Exp_dt >=sysdate ) "
								+ "GROUP BY staff_num,base");

			}

			rs = pstmt.executeQuery();

			empnoAL = null;
			baseAL = null;

			while (rs.next()) {
				if (empnoAL == null) {
					empnoAL = new ArrayList();
				}
				if (baseAL == null) {
					baseAL = new ArrayList();
				}
				empnoAL.add(rs.getString("staff_num"));
				baseAL.add(rs.getString("base"));

			}
			rs.close();
			pstmt.close();
			conn.close();

		} catch (ClassNotFoundException e) {
			System.out.println(e.toString());
		} catch (Exception e) {
			System.out.println(e.toString());
		}

		finally {

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

	public String getBase(String empno) {
		String base = "";
		int idx = 0;

		idx = empnoAL.indexOf(empno);
		if (idx != -1) {
			base = (String) baseAL.get(idx);
		}
		return base;
	}
}
