package sch;

import java.sql.*;
import java.text.*;
import java.util.*;

import ci.db.*;

/**
 * CS66_CrewMonthlySch (未完成!!)
 * 
 * 
 * @author cs66
 * @version 1.0 2007/4/30
 * 
 * Copyright: Copyright (c) 2007
 */
public class CS66_CrewMonthlySch {
	private ArrayList FullMonthDateObjAL;
	private String year;
	private String month;
	private String base;
	private String rank;
	private String specialSkill;
	private AllrankObj staffRankObj = null;
	private AllCRObj staffCrObj = null;
	private ArrayList scheDataAL;
	private ArrayList dataAL;

	public static void main(String[] args) {
		CS66_CrewMonthlySch c = new CS66_CrewMonthlySch("2007", "05", "TPE",
				"PR", "*");
		try {
			c.SelectSkjData();
			System.out.println("XX");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public CS66_CrewMonthlySch(String year, String month, String base,
			String rank, String specialSkill) {
		this.year = year;
		this.month = month;
		this.base = base;
		this.rank = rank;
		this.specialSkill = specialSkill;
		setFullMonthDateObjAL();// 取得全月表頭
		SelectAllRank();// 取得所有Rank
	}

	/**
	 * 
	 * 取得班表資料(一人多筆資料）
	 * 
	 */
	public void SelectSkjData() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ConnDB cn = new ConnDB();

		// Driver dbDriver = null;
		try {

			String rankSQL = "";
			String specialSkillSQL = "";

			if (!"".equals(rank) && "X".equals(specialSkill))
				rankSQL = " and cr.rank_cd='" + rank + "' ";

			if ("retire".equals(specialSkill)) {
				specialSkillSQL = " and sk.skill_cd in ('*','**') ";
			} else if (!"X".equals(specialSkill)) {
				specialSkillSQL = " and sk.skill_cd='" + specialSkill + "' ";
			}

			// cn.setAOCIPRODCP();
			// dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			// conn = dbDriver.connect(cn.getConnURL(), null);
			cn.setAOCIPRODFZUser();
			java.lang.Class.forName(cn.getDriver());
			conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),
					cn.getConnPW());

			StringBuffer sqlSB = new StringBuffer();

			sqlSB.append("select cr.rank_cd,r.staff_num empno, ");
			sqlSB.append("c.preferred_name cname, ");
			sqlSB.append("to_char(d.act_str_dt_tm_gmt,'dd') sdd, ");
			sqlSB.append("to_char(d.act_end_dt_tm_gmt,'dd') edd, ");
			sqlSB.append("to_char(d.act_str_dt_tm_gmt,'mm') smm, ");
			sqlSB.append("to_char(d.act_end_dt_tm_gmt,'mm') emm, ");
			sqlSB.append("to_char(d.act_str_dt_tm_gmt,'HH24MI') shh, ");
			sqlSB.append("to_char(d.act_end_dt_tm_gmt,'HH24MI') ehh, ");
			sqlSB.append("to_char(d.str_dt_tm_loc,'HH24') sloc, ");
			sqlSB.append("lpad(nvl(d.flt_num,''),4,'0') fltno, ");
			sqlSB
					.append("decode(d.duty_cd,'LO','---',nvl(d.duty_cd,'')) dutycd,");
			sqlSB.append("nvl(d.cop_duty_cd,'') copcd, ");
			sqlSB.append("d.port_a dpt, d.port_b arv, c.seniority_code code ");
			sqlSB.append("from roster_v r, duty_prd_seg_v d, crew_v c,");
			sqlSB.append("crew_base_v b, rank_tp_v rt, ");
			sqlSB.append("crew_rank_v cr, crew_spec_skills_v sk ");
			sqlSB.append("where r.series_num=d.series_num ");
			sqlSB.append("and r.staff_num=c.staff_num ");
			sqlSB.append("and c.staff_num=b.staff_num and b.base=? ");
			sqlSB.append("and (b.exp_dt >= sysdate or b.exp_dt is null) ");
			sqlSB.append("and r.acting_rank=rt.display_rank_cd ");
			sqlSB.append("and rt.fd_ind='N' ");
			sqlSB.append("and c.staff_num=cr.staff_num ");
			sqlSB.append("and (cr.exp_dt >= sysdate or cr.exp_dt is null) ");
			sqlSB.append("and c.staff_num=sk.staff_num(+) ");
			sqlSB.append("and (sk.exp_dt >= sysdate or sk.exp_dt is null) ");
			// q_sk +
			sqlSB.append(specialSkillSQL);

			// TODO
			// sqlSB.append("and r.staff_num='640095' ");

			sqlSB.append("and (d.act_str_dt_tm_gmt between ");
			sqlSB.append("to_date(?,'yyyymmddHH24MI') ");
			sqlSB.append("and last_day(to_date(?,'yyyymmHH24MI')) ");
			sqlSB.append("or d.act_end_dt_tm_gmt between ");
			sqlSB.append("to_date(?,'yyyymmddHH24MI') ");
			sqlSB.append("and last_day(to_date(?,'yyyymmHH24MI'))) ");
			sqlSB.append("and r.delete_ind='N' and d.duty_cd<>'RST' ");
			// q_rank +
			sqlSB.append(rankSQL);

			sqlSB.append("union all ");

			sqlSB.append("select cr.rank_cd,r.staff_num empno, ");
			sqlSB.append("c.preferred_name cname, ");
			sqlSB.append("to_char(r.act_str_dt,'dd') sdd, ");
			sqlSB.append("to_char(r.act_end_dt,'dd') edd, ");
			sqlSB.append("to_char(r.act_str_dt,'mm') smm, ");
			sqlSB.append("to_char(r.act_end_dt,'mm') emm, ");
			sqlSB.append("to_char(r.act_str_dt,'HH24MI') shh, ");
			sqlSB.append("to_char(r.act_end_dt,'HH24MI') ehh, ");
			sqlSB.append("to_char(r.act_str_dt,'HH24') sloc,'' fltno,  ");
			sqlSB.append("r.duty_cd dutycd, '' copcd,r.location_cd dpt, ");
			sqlSB.append("r.location_cd arv, c.seniority_code code ");
			sqlSB.append("from roster_v r, crew_v c, ");
			sqlSB.append("crew_base_v b,rank_tp_v rt, ");
			sqlSB.append(" crew_rank_v cr, crew_spec_skills_v sk ");
			sqlSB.append("where r.series_num=0 ");
			sqlSB.append("and r.staff_num=c.staff_num ");
			sqlSB.append("and c.staff_num=b.staff_num and b.base=? ");
			sqlSB.append("and (b.exp_dt >= sysdate or b.exp_dt is null) ");
			sqlSB.append("and r.acting_rank=rt.display_rank_cd ");
			sqlSB.append("and rt.fd_ind='N' and c.staff_num=cr.staff_num ");
			sqlSB.append("and (cr.exp_dt >= sysdate or cr.exp_dt is null) ");

			sqlSB.append("and c.staff_num=sk.staff_num(+) ");
			sqlSB.append("and (sk.exp_dt >= sysdate or sk.exp_dt is null) ");
			// q_sk +
			sqlSB.append(specialSkillSQL);

			// TODO
			// sqlSB.append("and r.staff_num='640095' ");

			sqlSB
					.append("and (r.act_str_dt between to_date(?,'yyyymmddHH24MI') ");
			sqlSB.append("and last_day(to_date(?,'yyyymmHH24MI')) or ");
			sqlSB.append("r.act_end_dt between to_date(?,'yyyymmddHH24MI') ");
			sqlSB.append("and last_day(to_date(?,'yyyymmHH24MI'))) ");
			sqlSB.append("and r.delete_ind='N' ");
			// q_rank +
			sqlSB.append(rankSQL);

			sqlSB.append("order by code, empno, sdd, edd");

			System.out.println(sqlSB.toString());
			pstmt = conn.prepareStatement(sqlSB.toString());
			for (int i = 1; i < 10; i = i + 5) {
				pstmt.setString(i, base);
				pstmt.setString(i + 1, year + month + "010000");
				pstmt.setString(i + 2, year + month + "2359");
				pstmt.setString(i + 3, year + month + "010000");
				pstmt.setString(i + 4, year + month + "2359");

			}

			rs = pstmt.executeQuery();
			ArrayList al = null;

			while (rs.next()) {
				if (al == null)
					al = new ArrayList();

				CrewScheDetailObj detailObj = new CrewScheDetailObj();
				detailObj.setEmpno(rs.getString("empno"));
				detailObj.setCname(ci.tool.UnicodeStringParser
						.removeExtraEscape(rs.getString("cname")));
				detailObj.setSern(rs.getString("sern"));

				detailObj.setArv(rs.getString("arv"));
				detailObj.setCopCD(rs.getString("copCD"));
				detailObj.setDpt(rs.getString("dpt"));
				detailObj.setDutyCD(rs.getString("dutyCD"));
				detailObj.setEndDay(rs.getString("endDay"));
				detailObj.setEndHour(rs.getString("endHour"));
				detailObj.setEndMonth(rs.getString("endMonth"));
				detailObj.setFltno(rs.getString("fltno"));
				detailObj.setStartDay(rs.getString("startDay"));
				detailObj.setStartHour(rs.getString("startHour"));
				detailObj.setStartLocHour(rs.getString("startLocHour"));
				detailObj.setStartMonth(rs.getString("startMonth"));

				al.add(detailObj);

			}

			pstmt.close();
			rs.close();
			conn.close();
			setDataAL(al);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException e) {}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {

				}
				conn = null;
			}
		}
	}
	/**
	 * 
	 * 取得全月表頭
	 * 
	 */
	public void setFullMonthDateObjAL() {
		ArrayList al = null;

		Calendar c = Calendar.getInstance();// 開始

		c.set(Integer.parseInt(year), Integer.parseInt(month) - 1, 01, 0, 0, 0);

		Calendar c2 = Calendar.getInstance();// 結束,取得當月最後一天= 當月+1月-1天
		c.set(Integer.parseInt(year), Integer.parseInt(month) - 1, 01, 0, 0, 0);
		c2.add(Calendar.MONTH, 1);
		c2.add(Calendar.DATE, -1);

		SimpleDateFormat sd = new SimpleDateFormat("E", Locale.UK);

		for (int i = 1; i <= c2.get(Calendar.DATE); i++) {
			if (al == null)
				al = new ArrayList();

			c.set(Calendar.DATE, i);

			DateObj obj = new DateObj();
			obj.setDay(c.get(Calendar.DATE));
			obj.setYyyymmdd(new SimpleDateFormat("yyyyMMdd", Locale.UK)
					.format(c.getTime()));
			obj.setDayOfWeek(sd.format(c.getTime()).substring(0, 2)
					.toUpperCase());

			al.add(obj);

		}
		this.FullMonthDateObjAL = al;
	}

	public ArrayList getFullMonthDateObjAL() {
		return FullMonthDateObjAL;
	}
	/**
	 * 取得所有 Crew 的 Rank
	 * 
	 */
	public void SelectAllRank() {

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ConnDB cn = new ConnDB();
		Driver dbDriver = null;
		try {

			cn.setAOCIPRODCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);

			pstmt = conn
					.prepareStatement("SELECT c.staff_num ,c.rank_cd "
							+ "FROM crew_rank_v c, rank_tp_v tp "
							+ "WHERE c.rank_cd = tp.display_rank_cd AND tp.fd_ind='N' "
							+ "AND c.eff_dt <= To_Date(?,'yyyymm') "
							+ "AND (c.exp_dt IS NULL OR c.exp_dt>=To_Date(?,'yyyymm')) "
							+ "ORDER BY c.staff_num	");

			pstmt.setString(1, year + month);
			pstmt.setString(2, year + month);

			rs = pstmt.executeQuery();
			ArrayList staff_numAL = null;
			ArrayList rank_cdAL = null;
			while (rs.next()) {
				if (staff_numAL == null)
					staff_numAL = new ArrayList();
				if (rank_cdAL == null)
					rank_cdAL = new ArrayList();
				staff_numAL.add(rs.getString("staff_num"));
				rank_cdAL.add(rs.getString("rank_cd"));

			}
			this.staffRankObj = new AllrankObj();
			staffRankObj.setStaff_numAL(staff_numAL);
			staffRankObj.setRank_cdAL(rank_cdAL);

			rs.close();
			pstmt.close();
			conn.close();

		} catch (Exception e) {

		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException e) {}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {

				}
				conn = null;
			}
		}
	}

	/**
	 * 取得所有 Crew 的 CR
	 * 
	 */
	public void SelectAllCR() {

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ConnDB cn = new ConnDB();
		Driver dbDriver = null;
		try {

			cn.setAOCIPRODCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);

			pstmt = conn
					.prepareStatement("SELECT staff_num, "
							+ "to_char(trunc(Sum(non_std_fly_hours)/60))||':'||to_char(mod(Sum(non_std_fly_hours),60)) cr "
							+ "FROM crew_cum_hr_cc_v "
							+ "WHERE cal_dt BETWEEN To_Date(?,'yyyymmdd hh24mi') "
							+ " AND Last_Day(To_Date(?,'yyyymmdd hh24mi')) "
							+ "GROUP BY staff_num");

			pstmt.setString(1, year + month + "01 0000");
			pstmt.setString(2, year + month + "01 2359");

			rs = pstmt.executeQuery();
			ArrayList staff_numAL = null;
			ArrayList crAL = null;
			while (rs.next()) {
				if (staff_numAL == null)
					staff_numAL = new ArrayList();
				if (crAL == null)
					crAL = new ArrayList();
				staff_numAL.add(rs.getString("staff_num"));
				crAL.add(rs.getString("cr"));

			}
			this.staffCrObj = new AllCRObj();
			staffCrObj.setStaff_numAL(staff_numAL);
			staffCrObj.setCRAL(crAL);

			rs.close();
			pstmt.close();
			conn.close();

		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException e) {}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {

				}
				conn = null;
			}
		}
	}

	public ArrayList getScheDataAL() {
		return scheDataAL;
	}

	public void setScheDataAL(ArrayList scheDataAL) {
		this.scheDataAL = scheDataAL;
	}

	public ArrayList getDataAL() {
		return dataAL;
	}

	/**
	 * 將一人多筆資料，轉換成一人一個 CrewMonthlyScheObj
	 * 
	 * @param dataAL
	 * 
	 */
	private void setDataAL(ArrayList dataAL) {

		if (dataAL != null) {
			for (int i = 0; i < dataAL.size(); i++) {
				CrewScheDetailObj obj = (CrewScheDetailObj) dataAL.get(i);
				CrewMonthlyScheObj preObj = null;
				if (i != 0) {
					preObj = (CrewMonthlyScheObj) dataAL.get(i - 1);

					if (preObj.getEmpno().equals(obj.getEmpno())) {

					}

				}

			}
		}

		this.dataAL = dataAL;

	}
}

class DateObj {
	private int Day;// Day of Month,start by 1
	private String dayOfWeek;// EX: SU,MO,....
	private String yyyymmdd;

	public int getDay() {
		return Day;
	}
	public void setDay(int day) {
		Day = day;
	}
	public String getDayOfWeek() {
		return dayOfWeek;
	}
	public void setDayOfWeek(String dayOfWeek) {
		this.dayOfWeek = dayOfWeek;
	}
	public String getYyyymmdd() {
		return yyyymmdd;
	}
	public void setYyyymmdd(String yyyymmdd) {
		this.yyyymmdd = yyyymmdd;
	}

}
class AllrankObj {
	private ArrayList staff_numAL;
	private ArrayList rank_cdAL;

	public void setRank_cdAL(ArrayList rank_cdAL) {
		this.rank_cdAL = rank_cdAL;
	}
	public void setStaff_numAL(ArrayList staff_numAL) {
		this.staff_numAL = staff_numAL;
	}

	public String getRankCd(String staff_num) {
		String rankCD = "";
		if (staff_numAL != null) {
			int idx = 0;
			try {
				idx = staff_numAL.indexOf(staff_num);
				if (idx != -1) {
					rankCD = (String) rank_cdAL.get(idx);
				}

			} catch (Exception e) {
				idx = 0;
				rankCD = "";
			}

		}
		return rankCD;

	}

}

class AllCRObj {
	private ArrayList staff_numAL;
	private ArrayList CRAL;

	public void setCRAL(ArrayList cral) {
		CRAL = cral;
	}

	public void setStaff_numAL(ArrayList staff_numAL) {
		this.staff_numAL = staff_numAL;
	}

	public String getCR(String staff_num) {
		String CR = "";
		if (staff_numAL != null) {
			int idx = 0;
			try {
				idx = staff_numAL.indexOf(staff_num);
				if (idx != -1) {
					CR = (String) CRAL.get(idx);
				}

			} catch (Exception e) {
				idx = 0;
				CR = "";
			}

		}
		return CR;

	}

}