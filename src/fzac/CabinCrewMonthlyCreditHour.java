package fzac;

import java.sql.*;

import ci.db.*;
import ci.tool.*;

/**
 * CabinCrewMonthlyCreditHour
 * 
 * 計算後艙組員當月 Credit hours
 * 
 * @author cs66
 * @version 1.0 2006/5/16
 * @version 1.1 2006/6/14 更改SQL,cr = crew_cum_hr_cc_v.non_std_fly_hours總和
 * 
 * Copyright: Copyright (c) 2006
 */
public class CabinCrewMonthlyCreditHour {

	public static void main(String[] args) {
		CabinCrewMonthlyCreditHour c = new CabinCrewMonthlyCreditHour("2006",
				"06", "633817");
		try {
			c.RetrieveData();
			System.out.println(c.getCrInHHMM());
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (InstantiationException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		}
	}
	private String empno;
	private String year;
	private String month;
	private String crInMin = "0";// 當月飛時(分鐘)
	private String crInHHMM = "0000";// 當月飛時(HHMM)
	private String crInHrs = "0";// 當月飛時(小時制,三位數小數)

	public CabinCrewMonthlyCreditHour(String year, String month, String empno) {
		this.year = year;
		this.month = month;
		this.empno = empno;
	}

	public void RetrieveData() throws SQLException, ClassNotFoundException,
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

			// pstmt = conn
			// .prepareStatement("SELECT ( SELECT sum(rem_fh_28) totalcr FROM
			// crew_cum_hr_cc_v c "
			// + "WHERE staff_num=? AND c.cal_dt BETWEEN To_Date(?,'yyyymmdd
			// hh24mi') "
			// + "AND Last_Day(To_Date(?,'yyyymmdd hh24mi')) "
			// + ")+( "
			// + "select count(*)*2*60 from roster_v where delete_ind='N' "
			// + "and staff_num=? and str_dt between to_date(?,'yyyymmdd
			// hh24:mi') "
			// + "and Last_Day(to_date(?,'yyyymmdd hh24:mi')) "
			// + "and duty_cd in ('AL', 'WL', 'FL', 'IL', 'OL', 'NB') "
			// + ")+( select count(*)*2*60 from roster_v r where
			// (r.series_num,r.sched_nm) in "
			// + " (select d.series_num, d.sched_nm from duty_prd_seg_v d "
			// + "where r.series_num=d.series_num and r.sched_nm = d.sched_nm "
			// + "and d.delete_ind = 'N' and d.duty_cd not in
			// ('LO','RST','REST') "
			// + "and d.duty_cd in (select a.duty_cd from
			// assignment_type_groups_v a where ASSNT_GRP_CD='LVCR')) "
			// + "and r.delete_ind='N' and r.staff_num=? and "
			// + "trunc(r.str_dt) BETWEEN To_Date(?,'yyyymmdd hh24mi') "
			// + "AND Last_Day(To_Date(?,'yyyymmdd hh24mi')) ) totalcr FROM
			// dual");
			pstmt = conn
					.prepareStatement(" SELECT staff_num,sum(non_std_fly_hours) totalcr "
							+ "FROM crew_cum_hr_cc_v c   WHERE staff_num = ? AND  c.cal_dt  BETWEEN "
							+ "To_Date(?,'yyyymmdd hh24mi')  AND Last_Day(To_Date(?,'yyyymmdd hh24mi')) GROUP BY  staff_num");

			pstmt.setString(1, empno);
			pstmt.setString(2, year + month + "01 0000");
			pstmt.setString(3, year + month + "01 2359");

			rs = pstmt.executeQuery();
			while (rs.next()) {
				setCrInMin(rs.getString("totalcr"));
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

	public String getCrInMin() {
		return crInMin;
	}

	private void setCrInMin(String crInMin) {
		this.crInMin = crInMin;
		setCrInHrs(TimeUtil.minToHours(3, crInMin));
		setCrInHHMM(TimeUtil.minToHHMM(crInMin));

	}

	public String getCrInHHMM() {
		return crInHHMM;
	}

	private void setCrInHHMM(String crInHHMM) {
		this.crInHHMM = crInHHMM;
	}

	public String getCrInHrs() {
		return crInHrs;
	}

	private void setCrInHrs(String crInHrs) {
		this.crInHrs = crInHrs;
	}

}
