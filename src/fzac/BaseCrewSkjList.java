package fzac;

import java.sql.*;
import java.util.*;

import ci.db.*;

/**
 * BaseCrewSkjList 取得各外站單月全部報表
 * 
 * DB: AirCrews
 * 
 * @author cs66
 * @version 1.0 2006/3/23
 * 
 * Copyright: Copyright (c) 2006
 */
public class BaseCrewSkjList {

	// public static void main(String[] args) {
	// BaseCrewSkjList bcl = new BaseCrewSkjList("2006", "03", "TYO");
	// System.out.println("開始 " + new java.util.Date());
	// bcl.initData();
	// System.out.println("完成 " + new java.util.Date());
	// ArrayList al = bcl.getDataAL();
	// System.out.println("資料筆數：" + al.size());
	// StringBuffer sb = new StringBuffer();
	//
	// for (int i = 0; i < al.size(); i++) {
	// BaseCrewSkjObj o = (BaseCrewSkjObj) al.get(i);
	//
	// ArrayList s = o.getCrewSkj();
	//
	// if (s != null) {
	//
	// System.out.println("***********************\n" + i + "\t"
	// + o.getEmpno() + "\t" + o.getSern()
	// + "\n***********************\n");
	//
	// for (int j = 0; j < s.size(); j++) {
	// CrewSkjObj co = (CrewSkjObj) s.get(j);
	//
	// System.out.println(co.getFdateLoc() + "\t" + co.getFltno()
	// + "\t" + co.getDpt() + "\t" + co.getArv());
	// }
	// }
	// }
	// }

	private String year;
	private String month;
	private String base;
	private ArrayList dataAL;
	private String sect_num;

	public BaseCrewSkjList(String year, String month, String base) {
		this.year = year;
		this.month = month;
		this.base = base;
		setSect_num();
	}

	public void initData() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
//		ConnAOCI cna = new ConnAOCI();
		ConnDB cn = new ConnDB();
		Driver dbDriver = null;

		try {
			// User connection pool 
			cn.setAOCIPRODCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);

			// 直接連線
			// cna.setAOCIFZUser();
			// java.lang.Class.forName(cna.getDriver());
			// conn = DriverManager.getConnection(cna.getConnURL(), cna
			// .getConnID(), cna.getConnPW());

			sql = "SELECT staff_num,To_Number(seniority_code) sern "
					+ "FROM crew_v WHERE section_number" + getSect_num()
					+ " AND emp_status='A'";

			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();
			ArrayList empAL = new ArrayList();
			ArrayList al = new ArrayList();

			while (rs.next()) {
				empAL.add(rs.getString("staff_num"));
				BaseCrewSkjObj obj = new BaseCrewSkjObj();
				obj.setEmpno(rs.getString("staff_num"));
				obj.setSern(rs.getString("sern"));
				al.add(obj);
			}

			pstmt.close();
			pstmt = null;

			rs.close();
			rs = null;

			for (int i = 0; i < empAL.size(); i++) {

				sql = "select r.staff_num,To_Char(dps.str_dt_tm_loc,'yyyy/mm/dd') fdate, "
						+ "(CASE WHEN dps.flt_num='0' then dps.duty_cd ELSE dps.flt_num end ) duty_cd,"
						+ "dps.act_port_a dpt,dps.act_port_b arv "
						+ "from duty_prd_seg_v dps, roster_v r,acdba.crew_t c "
						+ "where dps.series_num=r.series_num and r.staff_num=c.staff_num "
						+ "and dps.delete_ind = 'N' AND  r.delete_ind='N' "
						+ "and c.staff_num =?  AND dps.str_dt_tm_gmt BETWEEN  to_date('"
						+ year
						+ month
						+ "01 00:00','yyyymmdd hh24:mi') "
						+ "AND Last_Day(To_Date('"
						+ year
						+ month
						+ "01 23:59','yyyymmdd hh24:mi')) "
						+ "UNION ALL SELECT r.staff_num,To_Char(str_dt,'yyyy/mm/dd') fdate,duty_cd,"
						+ "'' dpt,'' arv "
						+ "FROM roster_v r WHERE r.staff_num=?  AND r.series_num=0 AND r.delete_ind='N' "
						+ "AND str_dt BETWEEN To_Date('"
						+ year
						+ month
						+ "01 0000','yyyymmdd hh24mi') "
						+ "AND Last_Day(To_Date('"
						+ year
						+ month
						+ "01 2359','yyyymmdd hh24mi')) " + " order by fdate";

				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, (String) empAL.get(i));
				pstmt.setString(2, (String) empAL.get(i));

				rs = pstmt.executeQuery();

				BaseCrewSkjObj obj = (BaseCrewSkjObj) al.get(i);

				ArrayList tmpSkjAL = null;
				if (rs != null) {
					tmpSkjAL = new ArrayList();
					while (rs.next()) {
						CrewSkjObj o = new CrewSkjObj();
						o.setFdateLoc(rs.getString("fdate"));
						o.setDpt(rs.getString("dpt"));
						o.setArv(rs.getString("arv"));
						o.setFltno(rs.getString("duty_cd"));
						tmpSkjAL.add(o);
					}
				}

				obj.setCrewSkj(tmpSkjAL);

				pstmt.close();
				pstmt = null;

				rs.close();
				rs = null;
			}
			setDataAL(al);

		} catch (SQLException e) {
			System.out.print(e.toString());
		} catch (Exception e) {
			System.out.print(e.toString());
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

	public String getSect_num() {
		return sect_num;
	}

	/**
	 * base 與 section_number 對照 <br>
	 * TPE: 1,2,3,4,96,98 <br>
	 * KHH: H <br>
	 * TYO: J <br>
	 * SIN: S <br>
	 * SGN: V <br>
	 * BKK: T
	 * 
	 */
	private void setSect_num() {
		String sect = "";
		if ("TPE".equalsIgnoreCase(base)) {
			sect = " in ('1','2','3','4','96','98') ";
		} else if ("KHH".equalsIgnoreCase(base)) {
			sect = " = 'H' ";
		} else if ("TYO".equalsIgnoreCase(base)) {
			sect = " = 'J' ";
		} else if ("SIN".equalsIgnoreCase(base)) {
			sect = " = 'S' ";
		} else if ("SGN".equalsIgnoreCase(base)) {
			sect = " = 'V' ";
		} else if ("BKK".equalsIgnoreCase(base)) {
			sect = " = 'T' ";
		}

		this.sect_num = sect;
	}

	public ArrayList getDataAL() {
		return dataAL;
	}

	private void setDataAL(ArrayList dataAL) {
		this.dataAL = dataAL;
	}
}
