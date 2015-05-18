package fzac;

import java.sql.*;

import ci.db.*;

/**
 * NextDuty 取得下一個任務
 * 
 * DB: DataSource 連結AirCrews
 * 
 * @author cs66
 * @version 1.0 2006/4/21 (排除ADO, RDO, OF, RST, LO)
 * @version 1.1 2006/10/13 (排除GDO.RDO.BOFF.RST.LO.ADO)
 * @version 2 2007/01/08 下一個任務包含S開頭者,自當日2359往後起算
 * 
 * Copyright: Copyright (c) 2006
 */
public class NextDuty {

	private String nextDutyYear = "";
	private String nextDutyMonth = "";
	private String nextDutyDay = "";
	private String nextDutyCode = "";
	private String nextDutyFltnum = "";

	private String fdate;// yyyy/mm/dd
	private String empno;

	/**
	 * @param fdate
	 *            目前時間 ,format yyyy/mm/dd
	 * @param empno
	 *            組員員工號
	 */
	public NextDuty(String fdate, String empno) {
		this.fdate = fdate;
		this.empno = empno;
		RetrieveData();
	}

	public void RetrieveData() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		// ConnectDataSource cn = new ConnectDataSource();
		ConnDB cn = new ConnDB();
		Driver dbDriver = null;

		try {

			// conn = cn.getAOCIConnection();
			cn.setAOCIPRODCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);

			// pstmt = conn
			// .prepareStatement("select
			// r.roster_num,to_char(d.str_dt_tm_gmt,'yyyy') yyyy, "
			// + "to_char(d.str_dt_tm_gmt,'mm') mm,to_char(d.str_dt_tm_gmt,'dd')
			// dd,"
			// + "d.flt_num flt_num, d.duty_cd "
			// + "from roster_v r, duty_prd_seg_v d "
			// + "where r.series_num=d.series_num(+) and r.staff_num=? "
			// + "and (d.flt_num not in ('ADO','RDO','OF','RST','LO') or
			// d.flt_num is null) "
			// + "and r.delete_ind='N' and
			// to_char(d.str_dt_tm_gmt,'yyyy/mm/dd')>? "
			// + "order by d.str_dt_tm_gmt");
			pstmt = conn
					.prepareStatement("select dps.act_str_dt_tm_gmt a,To_Char(dps.act_str_dt_tm_gmt,'yyyy') yyyy, "
							+ "To_Char(dps.act_str_dt_tm_gmt,'mm') mm,To_Char(dps.act_str_dt_tm_gmt,'dd') dd,r.staff_num,"
							+ " (CASE WHEN dps.flt_num='0' then dps.duty_cd ELSE dps.flt_num end ) duty_cd "
							+ "from duty_prd_seg_v dps, roster_v r "
							+ " where dps.series_num=r.series_num "
							+ " and dps.delete_ind = 'N' "
							+ "    AND  r.delete_ind='N'"
							+ " and r.staff_num =? "
							+ "AND dps.act_str_dt_tm_gmt > to_date(?,'yyyy/mm/dd hh24mi') "
//							+ "AND  SubStr(dps.duty_cd,1,1)<>'S' "
							+ "AND  dps.duty_cd NOT IN ('HS1','HS2','LO','RST') "
							+ "UNION ALL "
							+ "SELECT r.str_dt a,To_Char(r.str_dt,'yyyy') yyyy,"
							+ "To_Char(r.str_dt,'mm') mm,To_Char(r.str_dt,'dd') dd,"
							+ "r.staff_num,duty_cd "
							+ "FROM roster_v r "
							+ "WHERE r.staff_num=? AND r.series_num=0 "
							+ "AND r.delete_ind='N' "
							+ "AND str_dt > To_Date(?,'yyyy/mm/dd hh24mi') "
							+ "AND duty_cd NOT IN ('GDO','RDO','BOFF','ADO') order by a");

			pstmt.setString(1, empno);
			pstmt.setString(2, fdate + " 2359");
			pstmt.setString(3, empno);
			pstmt.setString(4, fdate + " 2359");
			rs = pstmt.executeQuery();

			// 只抓第一個
			if (rs.next()) {
				setNextDutyCode(rs.getString("duty_cd"));
				setNextDutyFltnum(rs.getString("duty_cd"));
				setNextDutyYear(rs.getString("yyyy"));
				setNextDutyMonth(rs.getString("mm"));
				setNextDutyDay(rs.getString("dd"));
			}

			pstmt.close();
			rs.close();
			conn.close();

		} catch (SQLException e) {
			System.out.println(e.toString());
		} catch (ClassNotFoundException e) {
			System.out.println(e.toString());
		} catch (Exception e) {
			System.out.println(e.toString());
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					System.out.println(e.toString());
				}
				conn = null;
			}
		}

	}

	public String getNextDutyCode() {
		return nextDutyCode;
	}

	public String getNextDutyDay() {
		return nextDutyDay;
	}

	public String getNextDutyFltnum() {
		return nextDutyFltnum;
	}

	public String getNextDutyMonth() {
		return nextDutyMonth;
	}

	public String getNextDutyYear() {
		return nextDutyYear;
	}

	public void setNextDutyCode(String nextDutyCode) {
		this.nextDutyCode = nextDutyCode;
	}

	public void setNextDutyDay(String nextDutyDay) {
		this.nextDutyDay = nextDutyDay;
	}

	public void setNextDutyFltnum(String nextDutyFltnum) {
		this.nextDutyFltnum = nextDutyFltnum;
	}

	public void setNextDutyMonth(String nextDutyMonth) {
		this.nextDutyMonth = nextDutyMonth;
	}

	public void setNextDutyYear(String nextDutyYear) {
		this.nextDutyYear = nextDutyYear;
	}
}
