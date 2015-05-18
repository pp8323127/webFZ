package swap3ackhh;

import java.sql.*;
import java.util.*;

import ci.db.*;

/**
 * CrewSkj
 * 
 * 
 * @author cs66
 * @version 1.0 2006/4/26
 * 
 * Copyright: Copyright (c) 2006
 */
public class CrewSkj {

	// public static void main(String[] args) {
	// CrewSkj cs = new CrewSkj(null, null, null);
	// ArrayList aCrewSkjAL = null;
	//
	// try {
	// cs.SelectData();
	// aCrewSkjAL = cs.getCrewSkjAL();
	// } catch (ClassNotFoundException e) {
	// e.printStackTrace();
	// } catch (SQLException e) {
	// e.printStackTrace();
	// } catch (Exception e) {
	// e.printStackTrace();
	// }
	//
	// if (aCrewSkjAL != null) {
	// for (int i = 0; i < aCrewSkjAL.size(); i++) {
	// CrewSkjObj objX = (CrewSkjObj) aCrewSkjAL.get(i);
	// System.out.println(objX.getTripno() + "\t" + objX.getDutycode()
	// + "\t" + objX.getCr());
	//
	// }
	//
	// } else {
	// System.out.println("no schedule");
	// }
	//
	// }
	private String year;
	private String month;
	private String empno;
	private ArrayList crewSkjAL;
	/**
	 * @param year
	 * @param month
	 * @param empno
	 */
	public CrewSkj(String year, String month, String empno) {
		this.year = year;
		this.month = month;
		this.empno = empno;
	}

	public void SelectData() throws ClassNotFoundException, SQLException,
			Exception {
		if (null != year && null != month && null != empno) {

			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			ConnDB cn = new ConnDB();
			// ConnAOCI cn = new ConnAOCI();
			Driver dbDriver = null;
			ArrayList al = new ArrayList();

			try {
				cn.setAOCIPRODCP();
				dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
				conn = dbDriver.connect(cn.getConnURL(), null);

				// cn.setAOCIFZUser();
				// java.lang.Class.forName(cn.getDriver());
				// conn = DriverManager.getConnection(cn.getConnURL(),
				// cn.getConnID(),
				// cn.getConnPW());

				pstmt = conn.prepareStatement("select r.staff_num,  To_Char(dps.series_num) tripno,"
								+ "To_Char(str_dt_tm_loc,'yyyy/mm/dd') fdate,"
								// 非fly任務則取其任務名稱當fltno欄位
								+ " (CASE WHEN dps.duty_cd NOT IN ( 'FLY','TVL') THEN dps.duty_cd ELSE dps.flt_num END ) fltno,"
								+ " dps.duty_cd cd,Nvl(r.special_indicator,' ') spCode "
								+ "from duty_prd_seg_v dps, roster_v r "
								+ "where dps.series_num=r.series_num "
								+ "AND r.series_num <> 0 "// 必須有series_num
								+ "AND r.staff_num=? AND r.delete_ind='N' "
								+ "AND dps.duty_seq_num||dps.item_seq_num=11 " // 只抓第1段
								+ "AND dps.duty_cd NOT IN ('B1','B2','CT','FT','GS','EE','MT') "
								+ "AND act_str_dt_tm_gmt between to_date('"
								+ year
								+ month
								+ "01 0000','yyyymmdd hh24mi') and "
								+ "last_day(to_date('"
								+ year
								+ month
								+ "01 2359','yyyymmdd hh24mi'))");

				// 申請者班表
				pstmt.setString(1, empno);

				rs = pstmt.executeQuery();
				al = new ArrayList();
				ArrayList seriesAL = new ArrayList();

				while (rs.next()) {
					CrewSkjObj sobj = new CrewSkjObj();
					sobj.setEmpno(rs.getString("staff_num"));
					sobj.setFdate(rs.getString("fdate"));
					sobj.setTripno(rs.getString("tripno"));
					sobj.setCd(rs.getString("cd"));
					sobj.setSpCode(rs.getString("spCode"));
					sobj.setDutycode(rs.getString("fltno"));
					seriesAL.add(rs.getString("tripno"));
					al.add(sobj);
				}

				pstmt.close();
				rs.close();

				// 取得各trip的cr
				for (int i = 0; i < al.size(); i++) {
					CrewSkjObj sobj = (CrewSkjObj) al.get(i);

					try {

						pstmt = conn.prepareStatement("select nvl(SUM(trunc(DECODE(duty_cd,'FLY', duration_mins,"
										+ " duration_mins*0.5))),0) totalCr from duty_prd_seg_v"
										+ " where (duty_cd='FLY' or cop_duty_cd='ACM') "
										+ " and series_num=? " 
										+ " and act_str_dt_tm_gmt <= Last_Day(To_Date('"+year+"/"+month+"/01 235959','yyyy/mm/dd hh24:mi:ss'))");
						pstmt.setString(1, (String) seriesAL.get(i));

						rs = pstmt.executeQuery();
						while (rs.next()) {
							sobj.setCr(rs.getString("totalCr"));

						}

					} catch (NumberFormatException ne) {
						sobj.setCr("0000");
					}

				}

				// 判斷最後一航段是否跨月 ,申請者
				if (al != null && al.size() > 0) {

					CrewSkjObj sobjA = (CrewSkjObj) al.get(al.size() - 1);
					MonthCrossTrip mct = new MonthCrossTrip(year, month, sobjA
							.getTripno(), empno);
					mct.initData();
					if (mct.isCrossMonth()) {
						if (mct.getTripInthisMonthCr() == null) {
							sobjA.setCr("");
						} else {
							sobjA.setCr(mct.getTripInthisMonthCr());
						}

					}
				}
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
