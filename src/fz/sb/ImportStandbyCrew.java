package fz.sb;

import java.sql.*;
import java.util.*;

import ci.db.*;
import ci.tool.*;

/**
 * ImportStandbyCrew
 * 
 * 
 * @author cs66
 * @version 1.0 2007/5/25
 * 
 * Copyright: Copyright (c) 2007
 */
public class ImportStandbyCrew {

	public static void main(String[] args) {

		ImportStandbyCrew c = new ImportStandbyCrew();

		WriteLog wl = new WriteLog("D:\\batchLog\\importStandByCrew.txt");
		try {
			c.SelectImportedData();

			c.SelectSourceData();
			c.ImportData();

			String str = " 本日 ";
			if (c.getImportDate() != null) 
			{
				str = c.getImportDate();
			}
			if (c.isHasBeenImported()) {

				wl.WriteFileWithTime(str + " 資料已經匯入,不重複轉檔");
			} 
			else 
			{

				wl.WriteFileWithTime("更新 " + str + " 資料共 " + c.getUpdateRows()
						+ " 筆.");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private String importDate;
	private boolean hasBeenImported = false;;
	private ArrayList dataAL;
	private int updateRows = 0;
	/**
	 * @param importDate
	 *            format: yyyymmdd
	 */
	public ImportStandbyCrew(String importDate) {

		this.importDate = importDate;
	}
	public ImportStandbyCrew() {}
	/**
	 * 取得已匯入之 Stanby crew 資料
	 * 
	 * @throws Exception
	 * 
	 */
	public void SelectImportedData() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ConnDB cn = new ConnDB();

		try {
//			cn.setORT1FZAP();
			cn.setORP3FZAP();
			java.lang.Class.forName(cn.getDriver());
			conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),
					cn.getConnPW());

			pstmt = conn.prepareStatement("SELECT * FROM fztsbrpt "
							+ "WHERE str_dt BETWEEN To_Date(To_Char(SYSDATE,'yyyymmdd')||'0000','yyyymmddhh24mi') "
							+ "AND  To_Date(To_Char(SYSDATE,'yyyymmdd')||'2359','yyyymmddhh24mi')");

			if (importDate == null) {// 預設為今天
				pstmt = conn
						.prepareStatement("SELECT * FROM fztsbrpt "
								+ "WHERE str_dt BETWEEN To_Date(To_Char(SYSDATE,'yyyymmdd')||'0000','yyyymmddhh24mi') "
								+ "AND  To_Date(To_Char(SYSDATE,'yyyymmdd')||'2359','yyyymmddhh24mi')");
			} else {
				pstmt = conn
						.prepareStatement("SELECT * FROM fztsbrpt "
								+ "WHERE str_dt BETWEEN To_Date(?||'0000','yyyymmddhh24mi') "
								+ "AND  To_Date(?||'2359','yyyymmddhh24mi')");
				pstmt.setString(1, importDate);
				pstmt.setString(2, importDate);

			}

			rs = pstmt.executeQuery();
			while (rs.next()) {
				setHasBeenImported(true);
			}
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
	public boolean isHasBeenImported() {
		return hasBeenImported;
	}
	public void setHasBeenImported(boolean hasBeenImported) {
		this.hasBeenImported = hasBeenImported;
	}
	/**
	 * 取得AirCrews Stanby Crew 資料
	 * 
	 * @throws Exception
	 * 
	 */
	public void SelectSourceData() throws Exception {
		if (!isHasBeenImported()) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			ConnDB cn = new ConnDB();

			try {
				cn.setAOCIPRODFZUser();
				java.lang.Class.forName(cn.getDriver());
				conn = DriverManager.getConnection(cn.getConnURL(), cn
						.getConnID(), cn.getConnPW());

				String sql = "";
				if (importDate == null) {
					sql = "select r.series_num,r.staff_num empno,dps.act_str_dt_tm_gmt str_dt, "
							+ "dps.act_end_dt_tm_gmt end_dt,dps.duty_cd "
							+ "from duty_prd_seg_v dps,roster_v r,crew_v c,crew_rank_v cv "
							+ "where   r.series_num = dps.series_num "
							+ "AND  r.staff_num = c.staff_num AND r.staff_num=cv.staff_num  "
							+ "AND dps.str_dt_tm_gmt   between To_Date(To_Char(SYSDATE,'yyyymmdd')||'0000','yyyymmddhh24mi')  "
							+ "AND To_Date(To_Char(SYSDATE,'yyyymmdd')||'2359','yyyymmddhh24mi') "
							+ "AND dps.delete_ind='N' AND dps.fd_ind='N'  AND r.delete_ind='N'  "
							+ "AND  r.sched_nm <> 'DUMMY' "
							+ "AND c.section_number in ('1','2','3','4','96','98','H') "
							+ "AND SubStr(dps.duty_cd,1,1)='S' "
							+ "AND (cv.eff_dt <= sysdate "
							+ "and  ( cv.exp_dt IS NULL OR cv.exp_dt > sysdate) ) "
							+ "order by r.str_dt,c.seniority_code";
					pstmt = conn.prepareStatement(sql);
				} else {
					sql = "select r.series_num,r.staff_num empno,dps.act_str_dt_tm_gmt str_dt, "
					        + "dps.act_end_dt_tm_gmt end_dt, dps.duty_cd "
							+ "from duty_prd_seg_v dps,roster_v r,crew_v c,crew_rank_v cv "
							+ "where   r.series_num = dps.series_num "
							+ "AND  r.staff_num = c.staff_num AND r.staff_num=cv.staff_num  "
							+ "AND dps.str_dt_tm_gmt   between To_Date(?||'0000','yyyymmddhh24mi')  "
							+ "AND To_Date(?||'2359','yyyymmddhh24mi') "
							+ "AND dps.delete_ind='N' AND dps.fd_ind='N'  AND r.delete_ind='N'  "
							+ "AND  r.sched_nm <> 'DUMMY' "
							+ "AND c.section_number in ('1','2','3','4','96','98','H') "
							+ "AND SubStr(dps.duty_cd,1,1)='S' "
							+ "AND (cv.eff_dt <= To_Date(?,'yyyymmdd') "
							+ "and  ( cv.exp_dt IS NULL OR cv.exp_dt > To_Date(?,'yyyymmdd')) ) "
							+ "order by r.str_dt,c.seniority_code";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, importDate);
					pstmt.setString(2, importDate);
					pstmt.setString(3, importDate);
					pstmt.setString(4, importDate);
				}

				rs = pstmt.executeQuery();
				ArrayList al = null;
				while (rs.next()) {
					if (al == null)
						al = new ArrayList();

					StanbyCrewObj obj = new StanbyCrewObj();
					obj.setEmpno(rs.getString("empno"));
					obj.setEnd_dt(rs.getDate("end_dt"));
					obj.setSeries_num(rs.getString("series_num"));
					obj.setStr_dt(rs.getDate("str_dt"));
					
					obj.setStr_dt_ts(rs.getTimestamp("str_dt"));
					obj.setEnd_dt_ts(rs.getTimestamp("end_dt"));
					obj.setDuty_cd(rs.getString("duty_cd"));
					al.add(obj);

				}
				setDataAL(al);
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
	}
	public ArrayList getDataAL() {
		return dataAL;
	}
	public void setDataAL(ArrayList dataAL) {
		this.dataAL = dataAL;
	}
	public String getImportDate() {
		return importDate;
	}
	public void setImportDate(String importDate) {
		this.importDate = importDate;
	}

	/**
	 * 轉入資料
	 * 
	 * @throws Exception
	 * 
	 */
	public void ImportData() throws Exception {
		if (getDataAL() != null) {

			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			ConnDB cn = new ConnDB();
			int rowCount = 0;
			try {
//				cn.setORT1FZAP();
				cn.setORP3FZAP();
				java.lang.Class.forName(cn.getDriver());

				for (int i = 0; i < getDataAL().size(); i++) {
					StanbyCrewObj obj = (StanbyCrewObj) getDataAL().get(i);
					conn = DriverManager.getConnection(cn.getConnURL(), cn
							.getConnID(), cn.getConnPW());
					conn.setAutoCommit(false);

					pstmt = conn
							.prepareStatement("insert into fztsbrpt(series_num,empno,str_dt,"
									+ "end_dt,erptdatetime,updateuser,updatedatetime,duty_cd) "
									+ "values(?,?,?,?,?,'SYSTEM',sysdate,?)");
					pstmt.setString(1, obj.getSeries_num());
					pstmt.setString(2, obj.getEmpno());
//					pstmt.setDate(3, (java.sql.Date) obj.getStr_dt());
//					pstmt.setDate(4, (java.sql.Date) obj.getEnd_dt());
//					pstmt.setDate(5, (java.sql.Date) obj.getStr_dt());
					pstmt.setTimestamp(3, obj.getStr_dt_ts());
					pstmt.setTimestamp(4, obj.getEnd_dt_ts());
					pstmt.setTimestamp(5, obj.getStr_dt_ts());
					pstmt.setString(6,obj.getDuty_cd());
					rowCount += pstmt.executeUpdate();

					conn.commit();
					pstmt.close();
					conn.close();

				}
				setUpdateRows(rowCount);

				if (!conn.isClosed()) {
					conn.close();
				}

			} catch (SQLException e) {
				try {
					// 有錯誤時 rollback
					conn.rollback();
				} catch (SQLException e1) {

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
	}
	public int getUpdateRows() {
		return updateRows;
	}
	private void setUpdateRows(int updateRows) {
		this.updateRows = updateRows;
	}
}
