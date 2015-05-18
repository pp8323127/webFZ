package fzac;

import java.sql.*;
import java.util.*;

import ci.db.*;

/**
 * CockpitCrewFleet 取得前艙組員機隊別
 * 
 * DB: AirCrews
 * 
 * @author cs66
 * @version 1.0 2006/3/30
 *  
 * Copyright: Copyright (c) 2006
 */
public class CockpitCrewFleet {

	// public static void main(String[] args) {
	//
	// CockpitCrewFleet cft = new CockpitCrewFleet();
	// try {
	// cft.initData();
	// System.out.println(cft.getFleetCd("634446"));
	// System.out.println(cft.getFleetCd("310085"));
	//			
	//			
	//
	// } catch (ClassNotFoundException e) {
	// e.printStackTrace();
	// } catch (SQLException e) {
	// e.printStackTrace();
	// }
	// }
	ArrayList empnoAL = new ArrayList();
	ArrayList fleetAL = new ArrayList();
	private int index;
	public void initData() throws SQLException, Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ConnDB cn = new ConnDB();
		Driver dbDriver = null;
		// ConnAOCI cna = new ConnAOCI();

		try {
			cn.setAOCIPRODCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);
			// 直接連線
			// cna.setAOCIFZUser();
			// java.lang.Class.forName(cna.getDriver());
			// conn = DriverManager.getConnection(cna.getConnURL(), cna
			// .getConnID(), cna.getConnPW());

			pstmt = conn
					.prepareStatement("select k.staff_num, w.fleet_cd "
							+ "from crew_rank_v k, rank_tp_v p,(select distinct a.staff_num,"
							+ " b.fleet_grp_cd fleet_cd from crew_fleet_v a, fleet_grp_v b "
							+ "where a.fleet_cd = b.fleet_cd and fleet_grp_cd <> 'CBN' "
							+ "AND a.eff_dt <=sysdate AND  (a.exp_dt IS NULL OR Exp_dt >=SYSDATE)) w "
							+ "where p.display_rank_cd=k.rank_cd and p.fd_ind = 'Y' "
							+ "AND k.staff_num = w.staff_num");

			rs = pstmt.executeQuery();

			while (rs.next()) {
				empnoAL.add(rs.getString("staff_num"));
				fleetAL.add(rs.getString("fleet_cd"));

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
		} catch (Exception e) {
			index = -1;
		}

	}

	/**
	 * 
	 * @param empno
	 *            員工號
	 * @return 機隊別
	 * 
	 */
	public String getFleetCd(String empno) {
		setIndex(empno);
		if (index != -1) {
			return (String) fleetAL.get(index);
		} else {
			return "";
		}
	}

}
