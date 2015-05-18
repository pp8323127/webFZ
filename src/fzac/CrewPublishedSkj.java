package fzac;

import java.sql.*;
import java.util.*;

import ci.db.*;

/**
 * CrewPublishedSkj 取得組員大於今日已公佈之班表
 * 
 * 
 * @author cs66
 * @version 1.0 2006/4/26
 * 
 * Copyright: Copyright (c) 2006
 */
public class CrewPublishedSkj {

//	public static void main(String[] args) {
//		CrewPublishedSkj cs = new CrewPublishedSkj("2006","05","640090");
//		ArrayList aCrewSkjAL = null;
//
//		try {
//			cs.SelectData();
//			aCrewSkjAL = cs.getCrewSkjAL();
//		} catch (ClassNotFoundException e) {
//			e.printStackTrace();
//		} catch (SQLException e) {
//			e.printStackTrace();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//
//		if (aCrewSkjAL != null) {
//			for (int i = 0; i < aCrewSkjAL.size(); i++) {
//				CrewMonthSkjObj objX = (CrewMonthSkjObj) aCrewSkjAL.get(i);
//				System.out.println(objX.getTripno() + "\t" + objX.getFltno());
//
//			}
//
//		} else {
//			System.out.println("no schedule");
//		}
//
//	}
	private String empno;
	private ArrayList crewSkjAL;
	/**
	 * @param year
	 * @param month
	 * @param empno
	 */
	public CrewPublishedSkj( String empno) {
		this.empno = empno;
	}

	public void SelectData() throws ClassNotFoundException, SQLException,
			Exception {
		if (null != empno) {

			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			ConnDB cn = new ConnDB();
			Driver dbDriver = null;
//			ConnAOCI cna = new ConnAOCI();

			ArrayList al = new ArrayList();

			try {

//				cna.setAOCIFZUser();
//				java.lang.Class.forName(cna.getDriver());
//				conn = DriverManager.getConnection(cna.getConnURL(), cna
//						.getConnID(), cna.getConnPW());

				cn.setAOCIPRODCP();
				dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
				conn = dbDriver.connect(cn.getConnURL(), null);

				
//				pstmt = conn
//						.prepareStatement("SELECT r.staff_num,r.series_num,To_char(dps.str_dt_tm_loc,'yyyy/mm/dd hh24:mi') strFdate,"
//								+ "To_char(dps.end_dt_tm_loc,'yyyy/mm/dd hh24:mi') endFdate, "
//								+ "(CASE WHEN dps.duty_cd='FLY' THEN dps.flt_num ELSE dps.duty_cd END )fltno,"
//								+ "dps.port_a,dps.port_b,r.special_indicator spCode,r.acting_rank "
//								+ "FROM roster_v r,duty_prd_seg_v dps "
//								+ "WHERE dps.series_num = r.series_num AND  r.staff_num=? "
//								+ "AND dps.str_dt_tm_loc BETWEEN To_Date('"
//								+ year
//								+ month
//								+ "01 0000','yyyymmdd hh24mi') "
//								+ "AND Last_Day(To_Date('"
//								+ year
//								+ month
//								+ "01 2359','yyyymmdd hh24mi')) "
//								+ "AND r.delete_ind='N' AND dps.delete_ind='N' AND fd_ind='N' "
//								+ "ORDER BY r.str_dt ,dps.series_num,dps.duty_seq_num||dps.item_seq_num");


				pstmt = conn
				.prepareStatement("SELECT r.staff_num,r.series_num,To_char(dps.str_dt_tm_loc,'yyyy/mm/dd hh24:mi') strFdate,"
						+ "To_char(dps.end_dt_tm_loc,'yyyy/mm/dd hh24:mi') endFdate, "
						+ "(CASE WHEN dps.duty_cd='FLY' THEN dps.flt_num ELSE dps.duty_cd END )fltno,"
						+ "dps.port_a,dps.port_b,r.special_indicator spCode,r.acting_rank "
						+ "FROM roster_v r,duty_prd_seg_v dps "
						+ "WHERE dps.series_num = r.series_num AND  r.staff_num=? "
						+ "AND r.act_str_dt >=sysdate AND duty_published='Y' "
						+ "AND r.delete_ind='N' AND dps.delete_ind='N' AND fd_ind='N' "
						+ "ORDER BY r.str_dt ,dps.series_num,dps.duty_seq_num||dps.item_seq_num");
				
				
				
				// 申請者班表
				pstmt.setString(1, empno);

				rs = pstmt.executeQuery();
				al = new ArrayList();
				ArrayList seriesAL =null;

				while (rs.next()) {
					if(seriesAL == null){
						seriesAL =  new ArrayList();
					}
					CrewMonthSkjObj obj = new CrewMonthSkjObj();
					obj.setEmpno(rs.getString("staff_num"));
					obj.setStrFdate(rs.getString("strFdate"));
					obj.setActing_rank(rs.getString("acting_rank"));
					obj.setTripno(rs.getString("series_num"));

					obj.setDpt(rs.getString("port_a"));
					obj.setArv(rs.getString("port_b"));
					obj.setSpCode(rs.getString("spCode"));
					obj.setFltno(rs.getString("fltno"));
					obj.setEndFdate(rs.getString("endFdate"));

					al.add(obj);
				}

				pstmt.close();
				rs.close();

				if (al.size() > 0) {
					setCrewSkjAL(al);
				} else {
					setCrewSkjAL(null);

				}

				rs.close();
				pstmt.close();
				conn.close();
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
		} else {
			setCrewSkjAL(null);

		}
	}

	public ArrayList getCrewSkjAL() {
		return crewSkjAL;
	}

	public void setCrewSkjAL(ArrayList crewSkjAL) {
		this.crewSkjAL = crewSkjAL;
	}
}
