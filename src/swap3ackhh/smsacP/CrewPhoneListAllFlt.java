package swap3ackhh.smsacP;

import java.sql.*;
import java.util.*;

import ci.db.*;
import ci.tool.*;

/**
 * CrewPhoneListAllFlt 單日全部航班組員手機號碼名單
 * 
 * 
 * @author cs66
 * @version 1.0 2006/4/11
 * 
 * Copyright: Copyright (c) 2006
 */
public class CrewPhoneListAllFlt {

	// public static void main(String[] args) {
	// CrewPhoneListAllFlt cflt2 = new CrewPhoneListAllFlt("2006", "04", "12");
	// ArrayList al = null;
	// try {
	// System.out.println(new java.util.Date() + "\tSTART!!");
	// // cflt2.initFLYData();
	// cflt2.initFLYData2("02", "00", "8");
	// System.out.println(new java.util.Date() + "\tEND!!");
	// al = cflt2.getDataAL();
	// if (al != null) {
	// for (int i = 0; i < al.size(); i++) {
	//
	// SMSFlightObj o = (SMSFlightObj) al.get(i);
	// System.out.println(o.getFdate() + "\t" + o.getFltno());
	// }
	// } else {
	// System.out.println("查無資料");
	// }
	//
	// System.out.println(al.size());
	//
	// } catch (SQLException e) {
	// e.printStackTrace();
	// } catch (Exception e) {
	// e.printStackTrace();
	// }
	// }

	private String year;
	private String month;
	private String day;
	private ArrayList dataAL;
	/**
	 * @param year
	 * @param month
	 * @param day
	 */
	public CrewPhoneListAllFlt(String year, String month, String day) {
		this.year = year;
		this.month = month;
		this.day = day;

	}

	/**
	 * 取得單日全部台北起飛之航班
	 * 
	 * @throws SQLException
	 * @throws Exception
	 * 
	 */
	public void initFLYData() throws SQLException, Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ConnDB cn = new ConnDB();
		// ConnAOCI cna = new ConnAOCI();
		Driver dbDriver = null;
		ArrayList seriesAL = new ArrayList();
		ArrayList fltnoAL = new ArrayList();
		try {
			// User connection pool
			cn.setAOCIPRODCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);

			// cna.setAOCIFZUser();
			// java.lang.Class.forName(cna.getDriver());
			// conn = DriverManager.getConnection(cna.getConnURL(), cna
			// .getConnID(), cna.getConnPW());

			// Step1. 先取得serries_num

			sql = "SELECT  series_num FROM duty_prd_seg_v dps "
					+ "WHERE  dps.str_dt_tm_loc BETWEEN To_Date('"
					+ year
					+ month
					+ day
					+ " 0000','yyyymmdd hh24mi') "
					+ "AND To_Date('"
					+ year
					+ month
					+ day
					+ " 2359','yyyymmdd hh24mi') "
					+ "AND dps.port_a='KHH' AND  dps.delete_ind='N' AND dps.fd_ind='N' "
					+ "AND dps.duty_cd='FLY' GROUP BY series_num";

			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			ArrayList al = new ArrayList();

			while (rs.next()) {
				SMSFlightObj o = new SMSFlightObj();
				o.setFdate(year + "/" + month + "/" + day);
				o.setSeries_num(rs.getString("series_num"));
				al.add(o);
			}
			pstmt.close();
			rs.close();

			// Step2. 再取得組員資料
			sql = "SELECT r.series_num,r.staff_num,To_Number(c.seniority_code) sern,c.preferred_name cname,"
					+ "r.acting_rank,nvl(t.mobile_phone_num,' ') mphone "
					+ "FROM roster_v r,crew_v c ,acdba.crew_contact_t t "
					+ "WHERE r.staff_num = c.staff_num  "
					+ "AND r.staff_num = t.staff_num  AND r.delete_ind='N' "
					+ "AND r.series_num=?  order by r.acting_rank desc,r.staff_num";

			for (int i = 0; i < al.size(); i++) {
				SMSFlightObj obj = (SMSFlightObj) al.get(i);
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, obj.getSeries_num());
				rs = pstmt.executeQuery();

				ArrayList al2 = new ArrayList();
				while (rs.next()) {
					CrewPhoneListObj o = new CrewPhoneListObj();
					o.setEmpno(rs.getString("staff_num"));
					o.setSern(rs.getString("sern"));
					o.setCname(UnicodeStringParser.removeExtraEscape(rs
							.getString("cname")));
					o.setRank(rs.getString("acting_rank"));
					o.setMphone(rs.getString("mphone"));

					al2.add(o);
				}
				obj.setCrewPhoneList(al2);
				pstmt.close();
				rs.close();
			}

			// Step3. 取得詳細航班資料.dpt,arv,btime,etime

			sql = "SELECT flt_num,To_Char(dps.str_dt_tm_loc,'hh24:mi') btime,  "
					+ "To_Char(dps.end_dt_tm_loc,'hh24:mi') etime,"
					+ "port_a dpt,port_b arv FROM   duty_prd_seg_v dps "
					+ "WHERE series_num=? AND dps.port_a='KHH' AND  dps.delete_ind='N' "
					+ "AND dps.fd_ind='N' AND dps.duty_cd='FLY' AND  dps.str_dt_tm_loc BETWEEN To_Date('"
					+ year
					+ month
					+ day
					+ " 0000','yyyymmdd hh24mi') "
					+ "AND To_Date('"
					+ year
					+ month
					+ day
					+ " 2359','yyyymmdd hh24mi') ";

			for (int i = 0; i < al.size(); i++) {
				SMSFlightObj obj = (SMSFlightObj) al.get(i);
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, obj.getSeries_num());
				rs = pstmt.executeQuery();

				while (rs.next()) {
					obj.setBtime(rs.getString("btime"));
					obj.setEtime(rs.getString("etime"));
					obj.setDpt(rs.getString("dpt"));
					obj.setArv(rs.getString("arv"));
					obj.setFltno(rs.getString("flt_num"));
				}

				pstmt.close();
				rs.close();
			}

			setDataAL(al);

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
	 * 取得幾小時內起飛之航班
	 * 
	 * @throws SQLException
	 * @throws Exception
	 * 
	 */
	public void initFLYData2(String hh, String mm, String hourRange)
			throws SQLException, Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ConnDB cn = new ConnDB();
		// ConnAOCI cna = new ConnAOCI();
		Driver dbDriver = null;
		ArrayList seriesAL = new ArrayList();
		ArrayList fltnoAL = new ArrayList();
		try {
			cn.setAOCIPRODCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);

			// cna.setAOCIFZUser();
			// java.lang.Class.forName(cna.getDriver());
			// conn = DriverManager.getConnection(cna.getConnURL(), cna
			// .getConnID(), cna.getConnPW());

			// Step1. 先取得serries_num

			sql = "SELECT  series_num FROM duty_prd_seg_v dps "
					+ "WHERE  dps.str_dt_tm_loc BETWEEN To_Date(?,'yyyymmddhh24mi') "
					+ "AND (To_Date(?,'yyyymmddhh24mi')+"
					+ hourRange
					+ "/24 )"
					+ "AND dps.port_a='KHH' AND  dps.delete_ind='N' AND dps.fd_ind='N' "
					+ "AND dps.duty_cd='FLY' GROUP BY series_num";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, year + month + day + hh + mm);
			pstmt.setString(2, year + month + day + hh + mm);
			rs = pstmt.executeQuery();
			ArrayList al = new ArrayList();

			while (rs.next()) {
				SMSFlightObj o = new SMSFlightObj();
				o.setFdate(year + "/" + month + "/" + day);
				o.setSeries_num(rs.getString("series_num"));
				al.add(o);
			}
			pstmt.close();
			rs.close();

			// Step2. 再取得組員資料
			sql = "SELECT r.series_num,r.staff_num,To_Number(c.seniority_code) sern,c.preferred_name cname,"
					+ "r.acting_rank,nvl(t.mobile_phone_num,' ') mphone "
					+ "FROM roster_v r,crew_v c ,acdba.crew_contact_t t "
					+ "WHERE r.staff_num = c.staff_num  "
					+ "AND r.staff_num = t.staff_num  AND r.delete_ind='N' "
					+ "AND r.series_num=?  order by r.acting_rank desc,r.staff_num";

			for (int i = 0; i < al.size(); i++) {
				SMSFlightObj obj = (SMSFlightObj) al.get(i);
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, obj.getSeries_num());
				rs = pstmt.executeQuery();

				ArrayList al2 = new ArrayList();
				while (rs.next()) {
					CrewPhoneListObj o = new CrewPhoneListObj();
					o.setEmpno(rs.getString("staff_num"));
					o.setSern(rs.getString("sern"));
					o.setCname(UnicodeStringParser.removeExtraEscape(rs
							.getString("cname")));
					o.setRank(rs.getString("acting_rank"));
					o.setMphone(rs.getString("mphone"));

					al2.add(o);
				}
				obj.setCrewPhoneList(al2);
				pstmt.close();
				rs.close();
			}

			// Step3.取得詳細航班資料.dpt,arv,btime,etime

			sql = "SELECT flt_num,To_Char(dps.str_dt_tm_loc,'hh24:mi') btime,  "
					+ "To_Char(dps.end_dt_tm_loc,'hh24:mi') etime,"
					+ "port_a dpt,port_b arv FROM   duty_prd_seg_v dps "
					+ "WHERE series_num=? AND dps.port_a='KHH' AND  dps.delete_ind='N' "
					+ "AND dps.fd_ind='N' AND dps.duty_cd='FLY' AND  dps.str_dt_tm_loc BETWEEN To_Date(?,'yyyymmddhh24mi') "
					+ "AND (To_Date(?,'yyyymmddhh24mi')+" + hourRange + "/24 )";

			for (int i = 0; i < al.size(); i++) {
				SMSFlightObj obj = (SMSFlightObj) al.get(i);
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, obj.getSeries_num());
				pstmt.setString(2, year + month + day + hh + mm);
				pstmt.setString(3, year + month + day + hh + mm);
				rs = pstmt.executeQuery();

				while (rs.next()) {
					obj.setBtime(rs.getString("btime"));
					obj.setEtime(rs.getString("etime"));
					obj.setDpt(rs.getString("dpt"));
					obj.setArv(rs.getString("arv"));
					obj.setFltno(rs.getString("flt_num"));
				}

				pstmt.close();
				rs.close();
			}

			setDataAL(al);
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

	public ArrayList getDataAL() {
		return dataAL;
	}

	private void setDataAL(ArrayList dataAL) {
		this.dataAL = dataAL;
	}

}
