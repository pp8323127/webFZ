package fzac;

import java.sql.*;
import java.util.*;

import ci.db.*;
import ci.tool.*;

/**
 * FlyingTime 取得單日各航班飛時
 * 
 * DB: AirCrews
 * 
 * 
 * @author cs66
 * @version 1.0 2006/3/29
 * @version 1.1 2006/4/21 新增TVL航班
 * @version 1.2 2006/8/9 新增INDEX  條件 (act_str_dt_tm_gmt, +- 2days)
 * 
 * Copyright: Copyright (c) 2006
 */
public class FlyingTime {

	// public static void main(String[] args) {
	// FlyingTime ft = new FlyingTime("2006/04/21", "0065");
	// ArrayList al = null;
	//
	// try {
	// ft.initData();
	// al = ft.getDataAL();
	// if (al == null) {
	// System.out.println("No DATA!!");
	// } else {
	//
	// for (int i = 0; i < al.size(); i++) {
	// FlyingTimeObj o = (FlyingTimeObj) al.get(i);
	// System.out.println(o.getFdateLocal() + "\t" + o.getFltno()
	// + "\t" + o.getDuty_cd()
	// + "\t" + o.getFlyTimeHHMM() + "\t"
	// + o.getSeries_num() + "\t" + o.getDpt()
	// + o.getArv());
	//
	// }
	// }
	// } catch (SQLException e) {
	// e.printStackTrace();
	// } catch (ClassNotFoundException e) {
	// e.printStackTrace();
	// }
	//
	// }

	private String fdate; // yyyy/mm/dd
	private String fltno;
	private ArrayList dataAL;

	public FlyingTime(String fdate, String fltno) {
		this.fdate = fdate;
		this.fltno = fltno;

	}

	public FlyingTime(String fdate) {
		this.fdate = fdate;
	}

	public void initData() throws SQLException, Exception {
		if (!CheckDate.isValidateDate(fdate)) {
			return;

		}

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		// ConnAOCI cna = new ConnAOCI();
		ConnDB cn = new ConnDB();
		 Driver dbDriver = null;

		try {
			// User connection pool

			cn.setAOCIPRODCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);

		
			ArrayList al;

			// 選擇單日全部航班
			if (fltno == null | "".equals(fltno)) {
				al = new ArrayList();
				sql = "SELECT series_num,dps.duty_cd  FROM duty_prd_seg_v dps "
					+ "WHERE delete_ind='N' and fd_ind='N' "
					+ " AND dps.act_str_dt_tm_gmt BETWEEN To_Date('"
					+ fdate
					+ " 0000','yyyy/mm/dd hh24mi')-2 AND To_Date('"
					+ fdate
					+ " 2359','yyyy/mm/dd hh24mi')+2 "
					+ "and dps.str_dt_tm_loc "
					+ "BETWEEN To_Date('"
					+ fdate
					+ " 0000','yyyy/mm/dd hh24mi') AND To_Date('"
					+ fdate
					+ " 2359','yyyy/mm/dd hh24mi') "
					+ "AND duty_seq_num=1 AND item_seq_num=1"
					+ " AND (duty_cd='FLY'or duty_cd='TVL') ORDER BY flt_num";

				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();

				while (rs.next()) {
					FlyingTimeObj o = new FlyingTimeObj();
					o.setSeries_num(rs.getString("series_num"));
					// o.setFlyTimeMins(rs.getString("totalCr"));
					o.setDuty_cd(rs.getString("duty_cd"));
					al.add(o);
				}
				pstmt.close();
				rs.close();
				// 取得CR
				for (int i = 0; i < al.size(); i++) {
					FlyingTimeObj o = (FlyingTimeObj) al.get(i);

					sql = "SELECT To_Char(str_dt_tm_loc,'yyyy/mm/dd') fdateLoc,"
							+ "To_Char(str_dt_tm_gmt,'yyyy/mm/dd') fdateTPE,"
							+ "flt_num,port_a dpt,port_b arv,s.totalCr "
							+ "FROM duty_prd_seg_v,"
							+ "(select nvl(SUM(trunc(DECODE(duty_cd,'FLY', duration_mins,"
							+ "duration_mins*0.5))),0) totalCr from duty_prd_seg_v "
							+ "where (duty_cd='FLY' or cop_duty_cd='ACM') "
							+ "and series_num=? ) s WHERE series_num=? "
							+ "AND duty_seq_num=1 AND item_seq_num=1";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, o.getSeries_num());
					pstmt.setString(2, o.getSeries_num());
					rs = pstmt.executeQuery();
					while (rs.next()) {
						o.setFlyTimeMins(rs.getString("totalCr"));
						o.setFdateLocal(rs.getString("fdateLoc"));
						o.setFdateTPE(rs.getString("fdateTPE"));
						o.setFltno(rs.getString("flt_num"));
						o.setDpt(rs.getString("dpt"));
						o.setArv(rs.getString("arv"));
					}
					pstmt.close();
					rs.close();

				}

				if (al.size() > 0) {
					setDataAL(al);
				}

				else {
					setDataAL(null);
				}

			}
			// 選擇單一航班
			else {

				sql = "SELECT series_num,duty_cd  FROM duty_prd_seg_v dps "
					+ "WHERE delete_ind='N'  and fd_ind='N' "
					+ " AND dps.act_str_dt_tm_gmt BETWEEN To_Date('"
					+ fdate
					+ " 0000','yyyy/mm/dd hh24mi')-2 AND To_Date('"
					+ fdate
					+ " 2359','yyyy/mm/dd hh24mi')+2 "
					+ "and dps.str_dt_tm_loc "
					+ "BETWEEN To_Date('"
					+ fdate
					+ " 0000','yyyy/mm/dd hh24mi') AND To_Date('"
					+ fdate
					+ " 2359','yyyy/mm/dd hh24mi') "
					+ "AND flt_num=LPad(?,4,'0') "
					+ "AND duty_seq_num=1 AND item_seq_num=1"
					+ " AND (duty_cd='FLY'or duty_cd='TVL') ORDER BY str_dt_tm_gmt";

				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, fltno);
				rs = pstmt.executeQuery();
				al = new ArrayList();

				while (rs.next()) {
					FlyingTimeObj o = new FlyingTimeObj();
					o.setSeries_num(rs.getString("series_num"));
					o.setDuty_cd(rs.getString("duty_cd"));
					al.add(o);

				}
				pstmt.close();
				rs.close();
				for (int i = 0; i < al.size(); i++) {
					FlyingTimeObj o = (FlyingTimeObj) al.get(i);

					sql = "SELECT To_Char(str_dt_tm_loc,'yyyy/mm/dd') fdateLoc,"
							+ "To_Char(str_dt_tm_gmt,'yyyy/mm/dd') fdateTPE,"
							+ "flt_num,port_a dpt,port_b arv,s.totalCr "
							+ "FROM duty_prd_seg_v ,"
							+ "(select nvl(SUM(trunc(DECODE(duty_cd,'FLY', duration_mins,"
							+ "duration_mins*0.5))),0) totalCr from duty_prd_seg_v "
							+ "where (duty_cd='FLY' or cop_duty_cd='ACM') "
							+ "and series_num=? ) s WHERE series_num=? and flt_num=LPad(?,4,'0') "
							+ "AND duty_seq_num=1 AND item_seq_num=1";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, o.getSeries_num());
					pstmt.setString(2, o.getSeries_num());
					pstmt.setString(3, fltno);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						if (rs.getString("fdateLoc") == null) {
							o.setFdateLocal(fdate);
						} else {
							o.setFdateLocal(rs.getString("fdateLoc"));
						}
						if (rs.getString("fdateTPE") == null) {
							o.setFdateTPE(fdate);
						} else {
							o.setFdateTPE(rs.getString("fdateTPE"));
						}

						if (rs.getString("flt_num") == null) {
							o.setFltno(fltno);
						} else {
							o.setFltno(rs.getString("flt_num"));
						}

						o.setDpt(rs.getString("dpt"));
						o.setArv(rs.getString("arv"));
						o.setFlyTimeMins(rs.getString("totalCr"));

					}
					pstmt.close();
					rs.close();

				}
				if (al.size() > 0) {
					setDataAL(al);
				}

				else {
					setDataAL(null);
				}

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
	public ArrayList getDataAL() {
		return dataAL;
	}

	private void setDataAL(ArrayList dataAL) {
		this.dataAL = dataAL;
	}
}
