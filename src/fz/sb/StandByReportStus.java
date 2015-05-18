package fz.sb;

import java.sql.*;
import ci.db.*;

/**
 * StandByReportStus
 * 
 * 正式報到:有兩分鐘容忍遲到範圍
 * 
 * 
 * @author cs66
 * @version 1.0 2007/6/1
 * 
 * Copyright: Copyright (c) 2007
 */
public class StandByReportStus {

	// public static void main(String[] args) {
	// StandByReportStus rs = new StandByReportStus("764005", "629567");
	// try {
	// rs.SelectData();
	// if (rs.getStandbyCrewObj() != null) {
	// StanbyCrewObj obj = rs.getStandbyCrewObj();
	// System.out.println(obj.getCname() + "\t" + obj.isReported()
	// + "\t" + obj.getComments());
	//				
	//				
	// SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd");
	// System.out.println(format.format(obj.getStr_dt_ts()));
	// System.out.println(new
	// SimpleDateFormat("HH:mm").format(obj.getERptDateTime()));
	// System.out.println(new SimpleDateFormat("yyyy/MM/dd
	// HH:mm").format(obj.getRRptDateTime()));
	// }
	// } catch (Exception e) {
	// e.printStackTrace();
	// }
	//
	// }

	private String series_num;
	private String empno;
	private StanbyCrewObj standbyCrewObj;
	/**
	 * @param series_num
	 * @param empno
	 */
	public StandByReportStus(String series_num, String empno) {

		this.series_num = series_num;
		this.empno = empno;
	}

	public void SelectData() throws Exception {
		if (series_num == null || empno == null)
			throw new NullPointerException(
					"Parameters (series_num,empno) are required!!");
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		ConnDB cn = new ConnDB();

		Driver dbDriver = null;

		try {

			cn.setORP3FZUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);

		

			pstmt = conn
					.prepareStatement("SELECT c.preferred_name cname,LTrim(c.seniority_code,'0')  sern,"
							+ "c.section_number,(CASE WHEN fz.rrptdatetime IS  NULL THEN  null "
							+ "WHEN fz.rrptdatetime >fz.erptdatetime "
							+ "AND fz.rrptdatetime <=  fz.erptdatetime +(1/24) "
							+ "THEN '遲到' "
							+ "WHEN fz.rrptdatetime >fz.erptdatetime "
							+ "AND fz.rrptdatetime > (fz.erptdatetime +(1/24)) "
							+ "THEN '未到' "
							+ "WHEN fz.rrptdatetime<=fz.erptdatetime THEN  '準時' "
							+ "ELSE '' 	END ) comments ,fz.* "
							+ "FROM fztsbrpt fz,fzdb.crew_v c "
							+ "WHERE  fz.empno = c.staff_num "
							+ "AND  fz.series_num=?  AND fz.empno=? ");

			pstmt.setString(1, series_num);
			pstmt.setString(2, empno);

			rs = pstmt.executeQuery();

			StanbyCrewObj obj = null;
			if (rs.next()) {

				if (obj == null)
					obj = new StanbyCrewObj();

				obj.setCname(ci.tool.UnicodeStringParser.removeExtraEscape(rs
						.getString("cname")));
				obj.setDuty_cd(rs.getString("duty_cd"));
				obj.setEmpno(rs.getString("empno"));
				obj.setEnd_dt_ts(rs.getTimestamp("end_dt"));
				obj.setGroups(rs.getString("section_number"));

				obj.setRRptDateTime(rs.getTimestamp("rrptdatetime"));
				obj.setERptDateTime(rs.getTimestamp("erptDateTime"));
				obj.setSeries_num(rs.getString("series_num"));
				obj.setSern(rs.getString("sern"));
				obj.setStr_dt_ts(rs.getTimestamp("str_dt"));
				obj.setComments(rs.getString("comments"));

			}

			setStandbyCrewObj(obj);
			pstmt.close();
			rs.close();
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
	}
	public StanbyCrewObj getStandbyCrewObj() {
		return standbyCrewObj;
	}

	public void setStandbyCrewObj(StanbyCrewObj standbyCrewObj) {
		this.standbyCrewObj = standbyCrewObj;
	}

}
