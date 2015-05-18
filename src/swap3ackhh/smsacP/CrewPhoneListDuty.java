package swap3ackhh.smsacP;

import java.sql.*;
import java.util.*;

import ci.db.*;
import ci.tool.*;

/**
 * CrewPhoneListSingleFlt 產生上課或待命組員名單s
 * 
 * 
 * @author cs66
 * @version 1.0 2006/4/13
 * 
 * Copyright: Copyright (c) 2006
 */
public class CrewPhoneListDuty {

//	public static void main(String[] args) {
//		CrewPhoneListDuty cflt = new CrewPhoneListDuty("2006", "04", "13", "AL");
//		ArrayList al = null;
//		try {
//			cflt.initData();
//			al = cflt.getDataAL();
//			if (al != null) {
//				for (int i = 0; i < al.size(); i++) {
//
//					CrewPhoneListObj o = (CrewPhoneListObj) al.get(i);
//					System.out.println(o.getEmpno() + "\t" + o.getCname()
//							+ "\t" + o.getRank() + "\t" + o.getMphone());
//				}
//			} else {
//				System.out.println("查無此班");
//			}
//			System.out.println("********************");
//
//			AddCrewPhoneData ap = new AddCrewPhoneData("640090", al);
//			ap.initData();
//			al = ap.getDataAL();
//			if (al != null) {
//				for (int i = 0; i < al.size(); i++) {
//					CrewPhoneListObj o = (CrewPhoneListObj) al.get(i);
//					System.out.println(o.getEmpno() + "\t" + o.getCname()
//							+ "\t" + o.getRank() + "\t" + o.getMphone());
//				}
//			} else {
//				System.out.println("查無此班");
//			}
//		} catch (SQLException e) {
//			e.printStackTrace();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//	}

	private String year;
	private String month;
	private String day;
	private String dutyCd;
	private ArrayList dataAL;

	/**
	 * @param year
	 * @param month
	 * @param day
	 * @param dutyCd
	 */
	public CrewPhoneListDuty(String year, String month, String day,
			String dutyCd) {
		this.year = year;
		this.month = month;
		this.day = day;
		this.dutyCd = dutyCd.toUpperCase();
	}

	public void initData() throws SQLException, Exception {
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
			// 先取得serries_num

			sql = "SELECT DISTINCT series_num FROM duty_prd_seg_v dps "
					+ "WHERE  dps.str_dt_tm_loc BETWEEN To_Date('" + year
					+ month + day + " 0000','yyyy/mm/dd hh24mi') "
					+ "AND To_Date('" + year + month + day
					+ " 2359','yyyy/mm/dd hh24mi')  "
					+ "AND  dps.delete_ind='N' AND dps.fd_ind='N' "
					+ "AND dps.duty_cd=upper('" + dutyCd + "')";

			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				seriesAL.add(rs.getString("series_num"));
			}

			rs.close();

			// 再取得組員資料

			// 若duty_prd_seg_V中無資料,取roster

			if (seriesAL.size() == 0) {
				sql = "SELECT r.staff_num,To_Number(c.seniority_code) sern,c.preferred_name cname,"
						+ "r.acting_rank,nvl(t.mobile_phone_num,' ') mphone "
						+ "FROM roster_v r,crew_v c ,acdba.crew_contact_t t "
						+ "WHERE str_dt BETWEEN To_Date('"
						+ year
						+ month
						+ day
						+ " 0000','yyyymmdd hh24mi') "
						+ "AND To_Date('"
						+ year
						+ month
						+ day
						+ " 2359','yyyymmdd hh24mi') "
						+ "AND r.staff_num = t.staff_num and r.staff_num = c.staff_num AND r.delete_ind='N' "
						+ "AND duty_cd='"
						+ dutyCd
						+ "' order by r.acting_rank desc,r.staff_num";
			} else {

				sql = "SELECT r.staff_num,To_Number(c.seniority_code) sern,c.preferred_name cname,"
						+ "r.acting_rank,nvl(t.mobile_phone_num,' ') mphone "
						+ "FROM roster_v r,crew_v c ,acdba.crew_contact_t t "
						+ "WHERE r.staff_num = c.staff_num  "
						+ "AND r.staff_num = t.staff_num  AND r.delete_ind='N' ";

				if (seriesAL.size() == 1) {
					sql += "AND r.series_num='" + seriesAL.get(0) + "' ";
				} else {
					sql += " AND r.series_num in (";
					for (int i = 0; i < seriesAL.size(); i++) {
						if (i == 0) {
							sql += "'" + seriesAL.get(i) + "'";
						} else {
							sql += ",'" + seriesAL.get(i) + "'";
						}

					}
					sql += ")";
				}
				sql += " order by r.acting_rank desc,r.staff_num";

			}

			
			rs = stmt.executeQuery(sql);
			ArrayList al = new ArrayList();
			while (rs.next()) {
				CrewPhoneListObj o = new CrewPhoneListObj();
				o.setEmpno(rs.getString("staff_num"));
				o.setSern(rs.getString("sern"));
				o.setCname(UnicodeStringParser.removeExtraEscape(rs
						.getString("cname")));
				o.setRank(rs.getString("acting_rank"));
				o.setMphone(rs.getString("mphone"));
				al.add(o);
			}

			if (al.size() == 0) {
				setDataAL(null);
			} else {
				setDataAL(al);
			}
			rs.close();

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

	private void setDataAL(ArrayList dataAL) {
		this.dataAL = dataAL;
	}

	public String getDutyCd() {
		return dutyCd;
	}
}
