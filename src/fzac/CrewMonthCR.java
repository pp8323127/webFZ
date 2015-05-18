package fzac;

import java.sql.*;
import java.util.*;

import ci.db.*;

/**
 * CrewMonthCR 取得前艙組員單月credit hours
 * 
 * 
 * @author cs66
 * @version 1.0 2006/5/30
 * 
 * Copyright: Copyright (c) 2006
 */
public class CrewMonthCR {

	private String year;
	private String month;
	private String empno;
	private String cr = "";
	/**
	 * @param year
	 * @param month
	 */
	public CrewMonthCR(String year, String month) {

		this.year = year;
		this.month = month;
	}

	public void initData(String empno) throws ClassNotFoundException,
			SQLException, InstantiationException, IllegalAccessException {
		this.empno = empno;
		if (empno == null) {
			throw new SQLException("Parameter is required!");
		}

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		ConnDB cn = new ConnDB();

		Driver dbDriver = null;
		ArrayList al = new ArrayList();
		boolean isThisMonth = false;
		String dateRangeCondition = "";

		try {

			cn.setAOCIPRODCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);

			pstmt = conn
					.prepareStatement("SELECT ( SELECT sum(rem_fh_28) totalcr FROM crew_cum_hr_cc_v c "
							+ "WHERE staff_num=? AND c.cal_dt  BETWEEN To_Date(?,'yyyymmdd hh24mi') "
							+ "AND Last_Day(To_Date(?,'yyyymmdd hh24mi')) "
							+ ")+( "
							+ "select count(*)*2*60 from roster_v  where delete_ind='N' "
							+ "and staff_num=? and str_dt between to_date(?,'yyyymmdd hh24:mi') "
							+ "and Last_Day(to_date(?,'yyyymmdd hh24:mi')) "
							+ "and  duty_cd in ('AL', 'WL', 'FL', 'IL',  'OL', 'NB') "
							+ ")+(  select count(*)*2*60  from roster_v r  where (r.series_num,r.sched_nm) in "
							+ " (select d.series_num, d.sched_nm from duty_prd_seg_v d "
							+ "where r.series_num=d.series_num and r.sched_nm = d.sched_nm "
							+ "and d.delete_ind = 'N' and d.duty_cd not in ('LO','RST','REST') "
							+ "and d.duty_cd in  "
							+ "(select a.duty_cd from assignment_type_groups_v a where ASSNT_GRP_CD='LVCR')) "
							+ "and r.delete_ind='N' and r.staff_num=? and "
							+ "trunc(r.str_dt) BETWEEN To_Date(?,'yyyymmdd hh24mi') "
							+ "AND Last_Day(To_Date(?,'yyyymmdd hh24mi')) ) totalcr FROM  dual");

			for (int i = 1; i < 10; i = i + 3) {
				pstmt.setString(i, empno);
				pstmt.setString(i + 1, year + month + "01 0000");
				pstmt.setString(i + 2, year + month + "01 2359");

			}

			rs = pstmt.executeQuery();
			String cr = "";
			while (rs.next()) {
				cr = rs.getString("totalcr");
			}
			setCr(cr);

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

	public String getCr() {
		return cr;
	}

	private void setCr(String cr) {
		this.cr = cr;
	}

}
