package swap3ackhh.smsacP;

import java.sql.*;
import java.util.*;
import ci.db.*;
import ci.tool.*;

/**
 * AddCrewPhoneData 新增組員手機號碼資料
 * 
 * 
 * @author cs66
 * @version 1.0 2006/4/11
 * 
 * Copyright: Copyright (c) 2006
 */
public class AddCrewPhoneData {

	private String empno;
	private ArrayList dataAL;

	/**
	 * @param empno
	 *            新增的組員帳號
	 * @param crewPhoneData
	 *            原始組員名單資料
	 */

	public AddCrewPhoneData(String empno, ArrayList crewPhoneData) {

		this.empno = empno;
		this.dataAL = crewPhoneData;
	}
	public void initData() throws ClassNotFoundException, SQLException,
			Exception {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;
		 ConnDB cn = new ConnDB();
//		ConnAOCI cna = new ConnAOCI();
		 Driver dbDriver = null;
		ArrayList seriesAL = new ArrayList();

		try {
			// User connection pool 
				cn.setAOCIPRODCP();
			 dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			 conn = dbDriver.connect(cn.getConnURL(), null);

//			cna.setAOCIFZUser();
//			java.lang.Class.forName(cna.getDriver());
//			conn = DriverManager.getConnection(cna.getConnURL(), cna
//					.getConnID(), cna.getConnPW());

			stmt = conn.createStatement();

			sql = "SELECT c.staff_num,To_Number(c.seniority_code) sern,c.preferred_name cname,"
					+ "nvl(t.mobile_phone_num,' ') mphone ,r.rank_cd "
					+ "FROM crew_v c ,acdba.crew_contact_t t ,crew_rank_v r "
					+ "WHERE c.staff_num = t.staff_num AND c.staff_num = r.staff_num "
					+ "AND c.staff_num='"
					+ empno
					+ "' AND r.eff_dt <= SYSDATE AND "
					+ "(r.exp_dt >= SYSDATE OR r.exp_dt IS null)";

			rs = stmt.executeQuery(sql);

			CrewPhoneListObj o = null;
			while (rs.next()) {
				o = new CrewPhoneListObj();
				o.setEmpno(rs.getString("staff_num"));
				o.setSern(rs.getString("sern"));
				o.setCname(UnicodeStringParser.removeExtraEscape(rs
						.getString("cname")));
				o.setRank(rs.getString("rank_cd"));
				o.setMphone(rs.getString("mphone"));
				o.setNewCrew(true);

			}
			if (o != null) {
				dataAL.add(o);

			}

		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {}
			if (stmt != null)
				try {
					stmt.close();
				} catch (SQLException e) {}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException e) {}

		}

	}

	public ArrayList getDataAL() {
		return dataAL;
	}

}
