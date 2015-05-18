package swap3ackhh.smsacP;

import java.sql.*;
import java.util.*;

import ci.db.*;
import ci.tool.*;

/**
 * CrewPhoneListSingleFlt 產生單一航班組員手機號碼名單
 * 
 * 
 * @author cs66
 * @version 1.0 2006/4/11
 * 
 * Copyright: Copyright (c) 2006
 */
public class CrewPhoneListSingleFlt {

//	public static void main(String[] args) {
//		CrewPhoneListSingleFlt cflt = new CrewPhoneListSingleFlt("2006", "04",
//				"22", "006");
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
	private String fltno;
	private ArrayList dataAL;
	/**
	 * @param year
	 * @param month
	 * @param day
	 * @param fltno
	 */
	public CrewPhoneListSingleFlt(String year, String month, String day,
			String fltno) {
		this.year = year;
		this.month = month;
		this.day = day;
		this.fltno = fltno;
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
			// User connection pool to ORP3DF

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
					+ " 2359','yyyy/mm/dd hh24mi') AND dps.port_a='KHH' "
					+ "AND  dps.delete_ind='N' AND dps.fd_ind='N' "
					+ "AND dps.flt_num=LPad('" + fltno + "',4,'0')";

			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				seriesAL.add(rs.getString("series_num"));
			}

			rs.close();

			// 再取得組員資料
			sql = "SELECT LPad('" + fltno + "',4,'0') fltno,r.staff_num,To_Number(c.seniority_code) sern,c.preferred_name cname,"
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
				o.setFltno(rs.getString("fltno"));
				al.add(o);
			}

			if (al.size() == 0) {
				setDataAL(null);
			} else {
				setDataAL(al);
			}
			rs.close();
			// 取得四碼fltno
			rs = stmt.executeQuery("SELECT LPad('" + fltno
					+ "',4,'0') f FROM dual ");
			String f = null;
			while (rs.next()) {
				f = rs.getString("f");
			}
			this.fltno = f;

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

	public String getFltno() {
		return fltno;
	}
}
