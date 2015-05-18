package fzac;

import java.sql.*;
import java.util.*;

import ci.db.*;
import ci.tool.*;

/**
 * OffCrewReport OFF組員報表 (SR7351)
 * 
 * 
 * 1.(全部-有任務)的組員
 * 
 * 2.以base,rank區分
 * 
 * 3.全部組員
 * 
 * 以當日Base.Rank有效為判斷條件,取得所有組員
 * 
 * 4.有任務的組員
 * 
 * (1)duty_prd_seg_v / duty_cd not in ('ADO','RDO','RST','BOFF')
 * 
 * (2)roster_v / duty_cd not in ('ADO','RDO','RST','BOFF') and series_num = 0
 * 
 * (1) + (2) = 有任務組員
 * 
 * 
 * 
 * @author cs66
 * @version 1.0 2007/11/28
 * 
 * Copyright: Copyright (c) 2007
 */
public class OffCrewReport {
	// public static void main(String[] args) {
	// OffCrewReport rp = new OffCrewReport("2007/12/04", "0000", "0200");
	// rp.setRank("PR");
	// rp.setBase("KHH");
	// ArrayList allData = null;
	// try {
	// rp.SelectData();
	// allData = rp.getDataAL();
	// if (allData != null) {
	//
	// for (int i = 0; i < allData.size(); i++) {
	// NoneFlyCrewListObj obj = (NoneFlyCrewListObj) allData
	// .get(i);
	// System.out.println(obj.getEmpno() + "\t" + obj.getCname()
	// + "\t\t" + obj.getRank() + "\t" + obj.getDutyCd()
	// + "\t" + obj.getBase());
	// }
	// System.out.println("共" + allData.size() + "筆");
	// } else {
	// System.out.println("no data!!");
	// }
	//
	// } catch (Exception e) {
	// e.printStackTrace();
	// }
	// }
	private String queryDate;// year+month+day

	private String startTime;
	private String endTime;
	private String base;
	private String rank;
	private StringBuffer SQLallData;// 全部資料
	private StringBuffer SQLhasDuty;// 特殊Duty(Rank)資料
	private StringBuffer SQLOffDuty;// OFF Duty者
	private StringBuffer SQLLODuty;// LO Duty或當日在某任務區間內者

	private ArrayList dataAL;// 儲存 NoneFlyCrewListObj

	/**
	 * @param queryDate
	 *            查詢日期, year+month+day
	 * @param startTime
	 *            查詢開始時間,hh24mi
	 * @param endTime
	 *            查詢結束時間,hh24mi
	 */
	public OffCrewReport(String queryDate, String startTime, String endTime) {
		this.queryDate = queryDate;
		this.startTime = startTime;
		this.endTime = endTime;

	}

	public void SelectData() throws Exception {
		setSQL();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		// ConnAOCI cn = new ConnAOCI();
		ConnDB cn = new ConnDB();
		Driver dbDriver = null;

		try {
			// User connection pool to ORP3DF
			cn.setAOCIPRODCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);

			// 直接連線
			// cn.setAOCIFZUser();
			// java.lang.Class.forName(cn.getDriver());
			// conn = DriverManager.getConnection(cn.getConnURL(),
			// cn.getConnID(),
			// cn.getConnPW());

			ArrayList al = null;
			pstmt = conn.prepareStatement(getSQLallData().toString());

			rs = pstmt.executeQuery();

			while (rs.next()) {
				if (al == null)
					al = new ArrayList();
				NoneFlyCrewListObj obj = new NoneFlyCrewListObj();
				obj.setBase(rs.getString("base"));
				if (null != rs.getString("cname")) {
					obj.setCname(UnicodeStringParser.removeExtraEscape(rs
							.getString("cname"))); // 轉中文碼
				}

				obj.setDutyCd(rs.getString("duty_cd"));
				obj.setEmpno(rs.getString("staff_num"));
				obj.setFdate(rs.getString("fdate"));
				obj.setRank(rs.getString("rank"));
				obj.setSern(rs.getString("sern"));
				obj.setGrp(rs.getString("section_number"));

				al.add(obj);

			}
			rs.close();
			pstmt.close();
			// System.out.println(al.size());
			ArrayList al2 = null;
			pstmt = conn.prepareStatement(getSQLhasDuty().toString());

			rs = pstmt.executeQuery();

			while (rs.next()) {
				if (al2 == null)
					al2 = new ArrayList();
				NoneFlyCrewListObj obj = new NoneFlyCrewListObj();
				obj.setBase(rs.getString("base"));
				obj.setCname(UnicodeStringParser.removeExtraEscape(rs
						.getString("cname"))); // 轉中文碼
				obj.setDutyCd(rs.getString("duty_cd"));
				obj.setEmpno(rs.getString("staff_num"));
				obj.setFdate(rs.getString("fdate"));
				obj.setRank(rs.getString("rank"));
				obj.setSern(rs.getString("sern"));
				obj.setGrp(rs.getString("section_number"));

				al2.add(obj);

			}
			// System.out.println(al2.size());
			rs.close();
			pstmt.close();
			ArrayList al3 = null;
			pstmt = conn.prepareStatement(getSQLOffDuty().toString());

			rs = pstmt.executeQuery();

			while (rs.next()) {
				if (al3 == null)
					al3 = new ArrayList();
				NoneFlyCrewListObj obj = new NoneFlyCrewListObj();
				obj.setBase(rs.getString("base"));
				obj.setCname(UnicodeStringParser.removeExtraEscape(rs
						.getString("cname"))); // 轉中文碼
				obj.setDutyCd(rs.getString("duty_cd"));
				obj.setEmpno(rs.getString("staff_num"));
				obj.setFdate(rs.getString("fdate"));
				obj.setRank(rs.getString("rank"));
				obj.setSern(rs.getString("sern"));
				obj.setGrp(rs.getString("section_number"));

				al3.add(obj);

			}
			// System.out.println(al3.size());
			rs.close();
			pstmt.close();

			ArrayList al4 = null;
			pstmt = conn.prepareStatement(getSQLLODuty().toString());
			rs = pstmt.executeQuery();
			while (rs.next()) {
				if (al4 == null)
					al4 = new ArrayList();
				NoneFlyCrewListObj obj = new NoneFlyCrewListObj();
				obj.setBase(rs.getString("base"));
				obj.setCname(UnicodeStringParser.removeExtraEscape(rs
						.getString("cname"))); // 轉中文碼
				obj.setDutyCd(rs.getString("duty_cd"));
				obj.setEmpno(rs.getString("staff_num"));
				obj.setFdate(rs.getString("fdate"));
				obj.setRank(rs.getString("rank"));
				obj.setSern(rs.getString("sern"));
				obj.setGrp(rs.getString("section_number"));
				al4.add(obj);

			}
			conn.close();
			this.combineData(al, al2, al3, al4);

		} catch (SQLException e) {
			throw e;
		} catch (Exception e) {
			throw e;
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
	 * 處理資料（相減部分）,取得OFF DUTY組員的DUTY_CD
	 * 
	 * @param allData
	 *            所有有任務的組員
	 * @param partialData
	 *            需排除的組員(有任務的組員)
	 * 
	 */

	public void combineData(ArrayList allData, ArrayList partialData,
			ArrayList offData, ArrayList LOData) throws Exception {
		if (allData == null)
			throw new NullPointerException("NO DATA FOUND");

		// 將OFF DUTYCODE 塞入all DATA
		if (offData != null) {
			for (int i = 0; i < allData.size(); i++) {
				NoneFlyCrewListObj obj = (NoneFlyCrewListObj) allData.get(i);

				for (int j = 0; j < offData.size(); j++) {
					NoneFlyCrewListObj obj2 = (NoneFlyCrewListObj) offData
							.get(j);
					if (obj.getEmpno().equals(obj2.getEmpno())) {
						obj.setDutyCd(obj2.getDutyCd());
						obj.setFdate(obj2.getFdate());
						break;
					}
				}
			}
		}

		if (partialData != null) {

			for (int i = 0; i < allData.size(); i++) {
				NoneFlyCrewListObj obj = (NoneFlyCrewListObj) allData.get(i);

				for (int j = 0; j < partialData.size(); j++) {
					NoneFlyCrewListObj obj2 = (NoneFlyCrewListObj) partialData
							.get(j);

					if (obj.getEmpno().equals(obj2.getEmpno())) {

						allData.set(i, null);
						break;
					}

				}

			}
		}

		List l = new ArrayList();
		for (int i = 0; i < allData.size(); i++) {
			if (allData.get(i) != null) {
				l.add(allData.get(i));
			}

		}

		allData = (ArrayList) l;
		// 去除LO組員
		if (LOData != null) {
			for (int i = 0; i < allData.size(); i++) {
				NoneFlyCrewListObj obj = (NoneFlyCrewListObj) allData.get(i);

				for (int idx = 0; idx < LOData.size(); idx++) {
					NoneFlyCrewListObj obj2 = (NoneFlyCrewListObj) LOData
							.get(idx);
					if (obj.getEmpno().equals(obj2.getEmpno())) {
						allData.set(i, null);
						break;
					}
				}

			}
		}
		l = new ArrayList();
		for (int i = 0; i < allData.size(); i++) {
			if (allData.get(i) != null) {
				l.add(allData.get(i));
			}

		}
		allData = (ArrayList) l;
		setDataAL(allData);

	}
	public String getBase() {
		return base;
	}

	public void setBase(String base) {
		if ("".equals(base)) {
			base = null;
		}

		this.base = base;

	}

	public String getRank() {
		return rank;
	}

	public void setRank(String rank) {
		if ("".equals(rank)) {
			rank = null;
		}

		this.rank = rank;

	}

	public StringBuffer getSQLhasDuty() {
		return SQLhasDuty;
	}

	public String getEndTime() {
		return endTime;
	}

	public String getQueryDate() {
		return queryDate;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setSQL() {
		StringBuffer sb = new StringBuffer();
		// 依條件選擇
		sb.append("select r.staff_num, ltrim(c.seniority_code,'0') sern,");
		sb.append(" c.preferred_name cname,");
		sb.append(" c.section_number,b.base, cv.rank_cd rank,");
		sb.append("to_char(r.str_dt,'yyyy/mm/dd ') fdate,");
		sb.append("  r.duty_cd,r.str_dt dd ,r.series_num ");
		sb.append("from roster_v r, crew_v c,crew_base_v b,crew_rank_v cv ");
		sb.append("where r.staff_num=c.staff_num ");
		sb.append("  AND r.staff_num = b.staff_num ");
		sb.append("  AND r.staff_num = cv.staff_num ");
		sb.append("  AND r.delete_ind='N' and r.str_dt between ");
		sb.append("to_date('" + getQueryDate() + " ");
		sb.append(getStartTime() + "','yyyy/mm/dd hh24mi') ");
		sb.append("  AND to_date('" + getQueryDate());
		sb.append(" " + getEndTime() + "','yyyy/mm/dd hh24mi') ");

		sb.append("  AND r.duty_cd NOT IN ('RDO','ADO','BOFF') ");
		sb.append("  AND r.series_num='0' ");

		sb.append("  AND b.prim_base='Y' ");
		sb.append("  AND b.eff_dt <= To_Date('" + getQueryDate()
				+ "','yyyy/mm/dd') ");

		sb.append("  AND (b.Exp_dt IS NULL OR b.Exp_dt >=To_Date('");
		sb.append(getQueryDate() + "','yyyy/mm/dd') ) ");

		sb.append("	 AND ( cv.exp_dt IS NULL  OR cv.exp_dt >= To_Date('");
		sb.append(getQueryDate() + "','yyyy/mm/dd') ) ");

		sb.append("  AND cv.eff_dt <= To_Date('" + getQueryDate());
		sb.append("','yyyy/mm/dd') ");

		if (getRank() != null) {
			sb.append(" AND cv.rank_cd='" + getRank() + "' ");

		}

		sb.append("UNION all ");

		sb.append("select r.staff_num empno, ");
		sb.append(" LTrim(c.seniority_code,'0') sern,");
		sb.append(" c.preferred_name cname,c.section_number,b.base,");
		sb.append(" cv.rank_cd rank,");
		sb.append("  to_char(dps.act_str_dt_tm_gmt,'yyyy/mm/dd') fdate,");
		sb.append(" dps.duty_cd ,dps.act_str_dt_tm_gmt dd ,r.series_num ");
		sb.append("from roster_v r, crew_v c, duty_prd_seg_v dps,");
		sb.append("  crew_rank_v cv,crew_base_v b ");
		sb.append("where r.staff_num=c.staff_num ");
		sb.append(" AND r.staff_num=cv.staff_num ");
		sb.append(" AND r.series_num = dps.series_num ");
		sb.append(" AND r.staff_num = b.staff_num ");
		sb.append(" AND r.delete_ind='N' ");
		sb.append(" AND b.prim_base='Y' ");
		sb.append(" AND dps.act_str_dt_tm_gmt between ");
		sb.append("to_date('" + getQueryDate());
		sb.append(" " + getStartTime() + "','yyyy/mm/dd hh24mi') ");
		sb.append("AND to_date('" + getQueryDate() + " ");
		sb.append(getEndTime() + "','yyyy/mm/dd hh24mi') ");

		sb.append("AND b.eff_dt <= To_Date('" + getQueryDate());
		sb.append("','yyyy/mm/dd') ");

		sb.append("AND (b.Exp_dt IS NULL OR b.Exp_dt >=To_Date('");
		sb.append(getQueryDate() + "','yyyy/mm/dd') ) ");
		sb.append("AND cv.eff_dt <= To_Date('" + getQueryDate());
		sb.append("','yyyy/mm/dd') ");

		sb.append("AND ( cv.exp_dt IS NULL OR cv.exp_dt >= ");
		sb.append(" To_Date('" + getQueryDate() + "','yyyy/mm/dd') ) ");

		sb.append("AND dps.duty_cd <> 'RST' ");

		if (getRank() != null) {
			sb.append(" AND cv.rank_cd='" + getRank() + "' ");

		}

		sb.append(" ORDER BY Rank, base,section_number,staff_num");

		setSQLhasDuty(sb);

		// all Data,當日所有Active組員
		sb = new StringBuffer();

		sb.append("SELECT c.staff_num, ");
		sb.append(" ltrim(c.seniority_code,'0') sern,");
		sb.append(" nvl(c.preferred_name,'')  cname,c.section_number,");
		sb.append(" b.base, cv.rank_cd Rank,");
		sb.append(" '' AS \"fdate\",null AS \"duty_cd\",");
		sb.append(" ''  AS \"dd\" ,'' AS \"series_num\" ");

		sb.append("FROM  crew_v c,crew_base_v b,crew_rank_v cv ");
		sb.append("WHERE c.staff_num = b.staff_num ");
		sb.append(" AND c.staff_num = cv.staff_num ");
		sb.append(" AND b.prim_base='Y' ");
		sb.append(" AND b.eff_dt <= To_Date('");
		sb.append(getQueryDate() + "','yyyy/mm/dd') ");
		sb.append(" AND (b.Exp_dt IS NULL OR b.Exp_dt >=");
		sb.append(" To_Date('" + getQueryDate() + "','yyyy/mm/dd') ) ");

		sb.append(" AND ( cv.exp_dt IS NULL  OR cv.exp_dt >= ");
		sb.append("  To_Date('" + getQueryDate() + "','yyyy/mm/dd') ) ");

		sb.append(" AND cv.eff_dt <= To_Date('");
		sb.append(getQueryDate() + "','yyyy/mm/dd') ");
		if (getRank() != null) {
			sb.append(" AND cv.rank_cd='" + getRank() + "' ");

		}

		if (getBase() != null) {

			sb.append(" AND b.base='" + getBase() + "' ");
		}
		sb.append("ORDER BY staff_num");
		setSQLallData(sb);

		// **** 當日為 ADO,RDO,BOFF,RST 任務者
		sb = new StringBuffer();
		sb.append("select r.staff_num, ltrim(c.seniority_code,'0') sern,");
		sb.append(" c.preferred_name cname,");
		sb.append(" c.section_number,b.base, cv.rank_cd rank,");
		sb.append("to_char(r.str_dt,'yyyy/mm/dd ') fdate,");
		sb.append("  r.duty_cd,r.str_dt dd ,r.series_num ");
		sb.append("from roster_v r, crew_v c,crew_base_v b,crew_rank_v cv ");
		sb.append("where r.staff_num=c.staff_num ");
		sb.append("  AND r.staff_num = b.staff_num ");
		sb.append("  AND r.staff_num = cv.staff_num ");
		sb.append("  AND r.delete_ind='N' and r.str_dt between ");
		sb.append("to_date('" + getQueryDate() + " ");
		sb.append(getStartTime() + "','yyyy/mm/dd hh24mi') ");
		sb.append("  AND to_date('" + getQueryDate());
		sb.append(" " + getEndTime() + "','yyyy/mm/dd hh24mi') ");

		sb.append("  AND r.duty_cd IN ('RDO','ADO','BOFF') ");
		sb.append("  AND r.series_num='0' ");

		sb.append("  AND b.prim_base='Y' ");
		sb.append("  AND b.eff_dt <= To_Date('" + getQueryDate()
				+ "','yyyy/mm/dd') ");

		sb.append("  AND (b.Exp_dt IS NULL OR b.Exp_dt >=To_Date('");
		sb.append(getQueryDate() + "','yyyy/mm/dd') ) ");

		sb.append("	 AND ( cv.exp_dt IS NULL  OR cv.exp_dt >= To_Date('");
		sb.append(getQueryDate() + "','yyyy/mm/dd') ) ");

		sb.append("  AND cv.eff_dt <= To_Date('" + getQueryDate());
		sb.append("','yyyy/mm/dd') ");

		if (getRank() != null) {
			sb.append(" AND cv.rank_cd='" + getRank() + "' ");

		}

		sb.append("UNION all ");

		sb.append("select r.staff_num , ");
		sb.append(" LTrim(c.seniority_code,'0') sern,");
		sb.append(" c.preferred_name cname,c.section_number,b.base,");
		sb.append(" cv.rank_cd rank,");
		sb.append("  to_char(dps.act_str_dt_tm_gmt,'yyyy/mm/dd') fdate,");
		sb.append(" dps.duty_cd ,dps.act_str_dt_tm_gmt dd ,r.series_num ");
		sb.append("from roster_v r, crew_v c, duty_prd_seg_v dps,");
		sb.append("  crew_rank_v cv,crew_base_v b ");
		sb.append("where r.staff_num=c.staff_num ");
		sb.append(" AND r.staff_num=cv.staff_num ");
		sb.append(" AND r.series_num = dps.series_num ");
		sb.append(" AND r.staff_num = b.staff_num ");
		sb.append(" AND r.delete_ind='N' ");
		sb.append(" AND b.prim_base='Y' ");
		sb.append(" AND dps.act_str_dt_tm_gmt between ");
		sb.append("to_date('" + getQueryDate());
		sb.append(" " + getStartTime() + "','yyyy/mm/dd hh24mi') ");
		sb.append("AND to_date('" + getQueryDate() + " ");
		sb.append(getEndTime() + "','yyyy/mm/dd hh24mi') ");

		sb.append("AND b.eff_dt <= To_Date('" + getQueryDate());
		sb.append("','yyyy/mm/dd') ");

		sb.append("AND (b.Exp_dt IS NULL OR b.Exp_dt >=To_Date('");
		sb.append(getQueryDate() + "','yyyy/mm/dd') ) ");
		sb.append("AND cv.eff_dt <= To_Date('" + getQueryDate());
		sb.append("','yyyy/mm/dd') ");

		sb.append("AND ( cv.exp_dt IS NULL OR cv.exp_dt >= ");
		sb.append(" To_Date('" + getQueryDate() + "','yyyy/mm/dd') ) ");

		sb.append("AND dps.duty_cd = 'RST' ");

		if (getRank() != null) {
			sb.append(" AND cv.rank_cd='" + getRank() + "' ");

		}

		sb.append(" ORDER BY Rank, base,section_number,staff_num");

		setSQLOffDuty(sb);

		// **** LO Duty
		sb = new StringBuffer();
		sb.append("select r.staff_num,  ");
		sb.append("LTrim(c.seniority_code,'0') sern, c.preferred_name cname,");
		sb.append("c.section_number,b.base,cv.rank_cd rank,");
		sb.append("to_char(dps.act_str_dt_tm_gmt,'yyyy/mm/dd') fdate,");
		sb.append("dps.duty_cd ,dps.act_str_dt_tm_gmt dd ,r.series_num ");
		sb.append("from roster_v r, crew_v c, duty_prd_seg_v dps,");
		sb.append("crew_rank_v cv,crew_base_v b ");
		sb.append("where r.staff_num=c.staff_num ");
		sb.append("AND r.staff_num=cv.staff_num ");
		sb.append("AND r.series_num = dps.series_num ");
		sb.append("AND r.staff_num = b.staff_num ");
		sb.append("AND r.delete_ind='N' ");
		sb.append("AND b.prim_base='Y' ");
		sb.append("AND dps.act_str_dt_tm_gmt  between to_date('"
				+ getQueryDate());

		sb.append(" 0000','yyyy/mm/dd hh24mi')-10 ");
		sb.append("AND to_date('" + getQueryDate());
		sb.append(" 2359','yyyy/mm/dd hh24mi')+10 ");
		sb.append("and to_date('" + getQueryDate());
		sb.append("','yyyy/mm/dd') between trunc(dps.act_str_dt_tm_gmt) ");
		sb.append("and trunc(dps.act_end_dt_tm_gmt) ");
		sb.append("AND b.eff_dt <= To_Date('" + getQueryDate());
		sb.append("','yyyy/mm/dd')  ");
		sb.append("AND (b.Exp_dt IS NULL OR b.Exp_dt >=To_Date('"
				+ getQueryDate());
		sb.append("','yyyy/mm/dd') ) ");

		sb.append("AND cv.eff_dt <= To_Date('" + getQueryDate()
				+ "','yyyy/mm/dd') ");
		sb.append("AND ( cv.exp_dt IS NULL  OR cv.exp_dt >= To_Date('");
		sb.append(getQueryDate());
		sb.append("','yyyy/mm/dd') ) ");
		sb.append("AND dps.duty_cd <> 'RST' ");

		if (getRank() != null) {
			sb.append(" AND cv.rank_cd='" + getRank() + "' ");

		}

		sb.append(" ORDER BY Rank, base,section_number,staff_num");
		setSQLLODuty(sb);
	}
	public StringBuffer getSQLallData() {
		return SQLallData;
	}

	public void setSQLallData(StringBuffer lallData) {
		SQLallData = lallData;
	}

	public void setSQLhasDuty(StringBuffer lhasDuty) {
		SQLhasDuty = lhasDuty;
	}

	public ArrayList getDataAL() {
		return dataAL;
	}

	public void setDataAL(ArrayList dataAL) {
		this.dataAL = dataAL;
	}

	public StringBuffer getSQLOffDuty() {
		return SQLOffDuty;
	}

	public void setSQLOffDuty(StringBuffer offDuty) {
		SQLOffDuty = offDuty;
	}

	public StringBuffer getSQLLODuty() {
		return SQLLODuty;
	}

	public void setSQLLODuty(StringBuffer duty) {
		SQLLODuty = duty;
	}

}
