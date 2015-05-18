package fzac.checkIn;

import java.sql.*;
import java.util.*;

import ci.db.*;

/**
 * ACCheckinData AirCrews Checkin Data,以日期及組員BASE,或Fltno,取得當日各航班未報到組員數量
 * 
 * 
 * @author cs66
 * @version 1.0 2007/8/29
 * 
 * Copyright: Copyright (c) 2007
 */
public class ACCheckinData {
	private String fltDate;
	private String crewBase;// 組員的BASE
	private String dptStation;// 起站
	private String fltno;

	/**
	 * 選擇全部航班,儲存 ACCheckinMainObj; 單一航班,儲存 ACCheckinDetailObj
	 */
	private ArrayList dataAL;

	/**
	 * @param fltDate
	 *            format:yyyy/mm/dd
	 * @param crewBase
	 * @param dptStation
	 *            departure station
	 */
	public ACCheckinData(String fltDate, String crewBase, String dptStation) {
		this.fltDate = fltDate;
		this.crewBase = crewBase;
		this.dptStation = dptStation;
		try {
			SelectAllData();
		} catch (Exception e) {

		}
	}

	/**
	 * @param fltDate
	 *            format:yyyy/mm/dd
	 * @param crewBase
	 * @param dptStation
	 *            departure station
	 * @param fltno
	 */
	public ACCheckinData(String fltDate, String crewBase, String dptStation,
			String fltno) {
		this.fltDate = fltDate;
		this.crewBase = crewBase;
		this.dptStation = dptStation;
		this.fltno = fltno;
		try {
			SelectDataByFltno();
		} catch (Exception e) {

		}
	}

	public void SelectAllData() throws Exception {
		if (!ci.tool.CheckDate.isValidateDate(fltDate))
			throw new NullPointerException(fltDate + " 非有效日期");

		if (fltDate == null || crewBase == null || dptStation == null)
			throw new NullPointerException("缺少必要參數");

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		ConnDB cn = new ConnDB();
		Driver dbDriver = null;

		try {
			 cn.setAOCIPRODCP();
			 dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			 conn = dbDriver.connect(cn.getConnURL(), null);

//			cn.setAOCIPRODFZUser();
//			java.lang.Class.forName(cn.getDriver());
//			conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),
//					cn.getConnPW());

			StringBuffer sb = new StringBuffer();

			sb.append("select flt_num,dep_arp_cd,Count(*) noShowNum ");
			sb.append("from crew_dops_v a, rank_tp_v b, crew_base_v c ");
			sb.append("where a.staff_num=c.staff_num(+) ");
			sb.append("and a.acting_rank=b.display_rank_cd ");
			sb.append("and c.base=? ");
			sb
					.append("and (c.eff_dt <=SYSDATE AND (c.exp_dt >= sysdate or c.exp_dt is null) ) ");
			sb.append("AND c.prim_base='Y' ");
			sb.append("and b.fd_ind='N' ");
			sb.append("and flt_dt_tm between ");
			sb
					.append("to_date(?,'yyyy/mm/ddHH24MI') and to_date(?,'yyyy/mm/ddHH24MI') ");
			sb.append("and a.item_seq_num=1 ");
			sb.append("and dep_arp_cd=? ");

			sb.append("and (no_show = 'Y' or no_show is null) ");
			sb.append("GROUP BY flt_num,dep_arp_cd");

			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, crewBase);
			pstmt.setString(2, fltDate + " 0000");
			pstmt.setString(3, fltDate + " 2359");
			pstmt.setString(4, dptStation);
			rs = pstmt.executeQuery();
			ArrayList al = null;

			while (rs.next()) {
				if (al == null)
					al = new ArrayList();
				ACCheckinMainObj mObj = new ACCheckinMainObj();
				mObj.setDptStation(rs.getString("dep_arp_cd"));
				mObj.setFltno(rs.getString("flt_num"));
				mObj.setNoShowNum(rs.getInt("noShowNum"));

				al.add(mObj);

			}
			setDataAL(al);

			rs.close();
			pstmt.close();

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

	public void SelectDataByFltno() throws Exception {
		if (!ci.tool.CheckDate.isValidateDate(fltDate))
			throw new NullPointerException(fltDate + " 非有效日期");

		if (fltDate == null || crewBase == null || dptStation == null
				|| fltno == null)
			throw new NullPointerException("缺少必要參數");

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		ConnDB cn = new ConnDB();
		Driver dbDriver = null;

		try {
			 cn.setAOCIPRODCP();
			 dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			 conn = dbDriver.connect(cn.getConnURL(), null);

//			cn.setAOCIPRODFZUser();
//			java.lang.Class.forName(cn.getDriver());
//			conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),
//					cn.getConnPW());

			StringBuffer sb = new StringBuffer();
			sb.append("select flt_num,a.staff_num ");
			sb.append("from crew_dops_v a, rank_tp_v b, crew_base_v c ");
			sb.append("where a.staff_num=c.staff_num(+) ");
			sb.append("and a.acting_rank=b.display_rank_cd ");
			sb.append("and c.base=? ");
			sb.append("and (c.eff_dt <=SYSDATE AND ");
			sb.append(" (c.exp_dt >= sysdate or c.exp_dt is null) ) ");
			sb.append("AND c.prim_base='Y' ");
			sb.append("and b.fd_ind='N' ");
			sb.append("and flt_dt_tm between ");
			sb.append(" to_date(?,'yyyy/mm/ddHH24MI') ");
			sb.append(" and to_date(?,'yyyy/mm/ddHH24MI') ");
			sb.append("and a.item_seq_num=1  ");
			sb.append("and dep_arp_cd=? ");
			sb.append("and flt_num=? ");
			sb.append("and (no_show = 'Y' or no_show is null) ");

			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, crewBase);
			pstmt.setString(2, fltDate + " 0000");
			pstmt.setString(3, fltDate + " 2359");
			pstmt.setString(4, dptStation);
			pstmt.setString(5, fltno);
			
			rs = pstmt.executeQuery();
			ArrayList al = null;

			while (rs.next()) {
				if (al == null)
					al = new ArrayList();
				ACCheckinDetailObj obj = new ACCheckinDetailObj();
				obj.setFltno(rs.getString("flt_num"));
				obj.setNoShowEmpno(rs.getString("staff_num"));
				al.add(obj);

			}
			setDataAL(al);

			rs.close();
			pstmt.close();

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

	public void setDataAL(ArrayList dataAL) {
		this.dataAL = dataAL;
	}

}
