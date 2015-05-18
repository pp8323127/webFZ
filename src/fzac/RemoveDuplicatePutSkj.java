package fzac;

import java.sql.*;
import java.util.*;
import ci.db.*;

/**
 * RemoveDuplicatePutSkj 移除已丟出之班表
 * 
 * 
 * @author cs66
 * @version 1.0 2006/4/16
 * 
 * Copyright: Copyright (c) 2006
 */
public class RemoveDuplicatePutSkj {

	// public static void main(String[] args) {
	// swap3ac.CrewSwapSkj csk = new swap3ac.CrewSwapSkj("636750", "null",
	// "2006", "04");
	//
	// swap3ac.CrewInfoObj obj = null;
	//
	// ArrayList dataAL = null;
	// try {
	// csk.SelectData();
	// obj = csk.getACrewInfoObj();
	// dataAL = csk.getACrewSkjAL();
	//
	// } catch (SQLException e) {
	// e.printStackTrace();
	// } catch (Exception e) {
	// e.printStackTrace();
	//
	// }
	//
	// fzac.CrewPutSkjObj cpObj2 = new fzac.CrewPutSkjObj();
	// cpObj2.setCrewInfo(obj);
	// cpObj2.setSkjObj(dataAL);
	//
	// // 移除已丟出之班表
	// fzac.RemoveDuplicatePutSkj rp = new fzac.RemoveDuplicatePutSkj(cpObj2);
	//
	// try {
	// rp.job();
	// } catch (SQLException e) {
	// e.printStackTrace();
	// } catch (Exception e) {
	// e.printStackTrace();
	// }
	// fzac.CrewPutSkjObj cpObj = rp.getCrewSkjObj();
	// ArrayList al = cpObj.getSkjObj();
	// for (int i = 0; i < al.size(); i++) {
	// swap3ac.CrewSkjObj objX = (swap3ac.CrewSkjObj) al.get(i);
	// System.out.println(objX.getTripno() + "\t" + objX.getFdate());
	// }
	// }
	private CrewPutSkjObj crewSkjObj;
	private ArrayList tripnoAL;
	public RemoveDuplicatePutSkj(CrewPutSkjObj crewSkjObj) {
		this.crewSkjObj = crewSkjObj;
	}

	/**
	 * 取得已丟出之班表
	 * 
	 * @throws SQLException
	 * @throws Exception
	 * 
	 */
	public void SelectPutData() throws SQLException, Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		ConnDB cn = new ConnDB();

		Driver dbDriver = null;

		try {
			// User connection pool
			cn.setORP3FZUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);

			

			pstmt = conn
					.prepareStatement("select distinct tripno from fztsput where empno=?");
			pstmt.setString(1, crewSkjObj.getEmpno());
			rs = pstmt.executeQuery();
			ArrayList al = new ArrayList();
			while (rs.next()) {
				al.add(rs.getString("tripno"));

			}
			if (al.size() > 0) {
				setTripnoAL(al);
			} else {
				setTripnoAL(null);
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

	public void RemoveDuplicateData() {
		if (tripnoAL != null) {
			ArrayList dataAL = crewSkjObj.getSkjObj();

			for (int idx = 0; idx < tripnoAL.size(); idx++) {
				for (int i = 0; i < dataAL.size(); i++) {
					swap3ac.CrewSkjObj o = (swap3ac.CrewSkjObj) dataAL.get(i);
					if (o.getTripno().equals(tripnoAL.get(idx))) {

						dataAL.remove(i);
						if (i != 0) {
							i--;
						};
						break;

					}
				}

			}

			crewSkjObj.setSkjObj(dataAL);
			setCrewSkjObj(crewSkjObj);

		}

	}

	public void job() throws SQLException, Exception {
		SelectPutData();
		RemoveDuplicateData();

	}
	public ArrayList getTripnoAL() {
		return tripnoAL;
	}

	private void setTripnoAL(ArrayList tripnoAL) {
		this.tripnoAL = tripnoAL;
	}

	public CrewPutSkjObj getCrewSkjObj() {
		return crewSkjObj;
	}

	private void setCrewSkjObj(CrewPutSkjObj crewSkjObj) {
		this.crewSkjObj = crewSkjObj;
	}
}
