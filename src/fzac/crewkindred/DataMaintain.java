package fzac.crewkindred;

import java.sql.*;
import java.util.*;
import ci.db.*;

/**
 * DataMaintain 家屬電話資料維護,包含匯入、查詢歷史資料
 * 
 * 
 * @author cs66
 * @version 1.0 2008/2/19
 * 
 * Copyright: Copyright (c) 2008
 */
public class DataMaintain {

	// public static void main(String[] args) {
	// DataMaintain dm = new DataMaintain();
	// ArrayList al = null;
	// // 取得尚未匯入之資料
	//
	// try {
	// // dm.SelectUnExportedData();
	// dm.setYear("2008");
	// dm.setMonth("02");
	// dm.setEmpno("640073");
	// dm.setSelectDeletedData(true);
	// dm.setSelectCrewAllData(true);
	// dm.SelectHistoryData();
	// al = dm.getDataAL();
	// if (al != null) {
	// System.out.println("共有 " + al.size() + " 筆資料");
	// } else {
	// System.out.println("no data");
	// }
	// System.out.println();
	// } catch (Exception e) {
	// e.printStackTrace();
	// }
	// }

	private ArrayList dataAL;
	private String year = null;
	private String month = null;
	private String empno = null;

	// 預設只看尚未刪除的資料
	// 若將 selectDeletedData 設為true,則顯示全部資料
	private boolean selectDeletedData = false;

	// 查詢組員所有資料,(忽略年月的條件)
	private boolean selectCrewAllData = false;

	/**
	 * 取得尚未匯入之資料
	 * 
	 * @throws Exception
	 * 
	 */
	public void SelectUnExportedData() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		ConnDB cn = new ConnDB();

		Driver dbDriver = null;

		try {

			cn.setORP3FZUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);

			// cn.setORT1FZAP();
			// java.lang.Class.forName(cn.getDriver());
			// conn = DriverManager.getConnection(cn.getConnURL(),
			// cn.getConnID(), cn.getConnPW());

			pstmt = conn
					.prepareStatement("SELECT * FROM fztckind WHERE  export_ind='N' "
							+ "AND (delete_ind='N' or delete_ind is NULL) "
							+"ORDER BY apply_time");

			rs = pstmt.executeQuery();
			ArrayList al = null;
			while (rs.next()) {
				if (al == null)
					al = new ArrayList();
				CrewKindredObj obj = new CrewKindredObj();
				obj.setDelete_ind(rs.getString("delete_ind"));
				obj.setEmpno(rs.getString("empno"));
				obj.setExport_ind(rs.getString("export_ind"));
				obj.setExport_time(rs.getTimestamp("export_time"));
				obj.setExport_Empno(rs.getString("export_Empno"));
				obj.setKinddred_Phone_Num(rs.getString("kinddred_Phone_Num"));
				obj.setKindred_First_Name(rs.getString("kindred_First_Name"));
				obj.setKindred_surName(rs.getString("kindred_surName"));
				obj.setApply_time(rs.getTimestamp("apply_time"));

				al.add(obj);
			}
			setDataAL(al);
			rs.close();
			pstmt.close();
			conn.close();

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
	 * 取得歷史資料
	 * 
	 * @throws Exception
	 * 
	 */
	public void SelectHistoryData() throws Exception {
		if (year == null && month == null && empno == null) {
			throw new NullPointerException("請輸入查詢條件");
		}
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		ConnDB cn = new ConnDB();

		Driver dbDriver = null;

		try {

			cn.setORP3FZUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);

			// cn.setORT1FZAP();
			// java.lang.Class.forName(cn.getDriver());
			// conn = DriverManager.getConnection(cn.getConnURL(),
			// cn.getConnID(), cn.getConnPW());

			StringBuffer sb = new StringBuffer();
			sb.append("SELECT * FROM fztckind WHERE  ");

			// 預設只看尚未刪除的資料
			// 若將selctDeletedData 設為true,則顯示全部資料
			if (!isSelectDeletedData()) {
				// 未刪除 & 已匯入的資料
				sb.append("export_ind='Y' AND (delete_ind='N' or delete_ind is null) ");
			} else {
				// 包含已刪除的資料

				sb.append("(export_ind='Y' or ");
				sb.append(" (export_ind='N' AND delete_ind='Y') )  ");
			}

			if (getEmpno() == null) {
				// 以年月查詢
				sb
						.append("AND apply_time between to_date(?,'yyyymmdd hh24mi') ");
				sb.append("AND last_day(to_date(?,'yyyymm hh24mi')) ");
				sb.append("ORDER BY export_time,apply_time");
				pstmt = conn.prepareStatement(sb.toString());
				pstmt.setString(1, getYear() + getMonth() + "01");
				pstmt.setString(2, getYear() + getMonth() + " 2359");

			} else if (isSelectCrewAllData()) {
				// 查詢員工號所有資料
				sb.append("AND empno = ? ");
				sb.append("ORDER BY export_time,apply_time");
				pstmt = conn.prepareStatement(sb.toString());
				pstmt.setString(1, getEmpno());

			} else {
				sb.append("AND empno = ? ");
				sb
						.append("AND apply_time between to_date(?,'yyyymmdd hh24mi') ");
				sb.append("AND last_day(to_date(?,'yyyymm hh24mi')) ");
				sb.append("ORDER BY export_time,apply_time");

				pstmt = conn.prepareStatement(sb.toString());
				pstmt.setString(1, getEmpno());
				pstmt.setString(2, getYear() + getMonth() + "01");
				pstmt.setString(3, getYear() + getMonth() + " 2359");
			}

			rs = pstmt.executeQuery();
			ArrayList al = null;
			while (rs.next()) {
				if (al == null)
					al = new ArrayList();
				CrewKindredObj obj = new CrewKindredObj();
				obj.setDelete_ind(rs.getString("delete_ind"));
				obj.setEmpno(rs.getString("empno"));
				obj.setExport_ind(rs.getString("export_ind"));
				obj.setExport_time(rs.getTimestamp("export_time"));
				obj.setExport_Empno(rs.getString("export_Empno"));
				obj.setKinddred_Phone_Num(rs.getString("kinddred_Phone_Num"));
				obj.setKindred_First_Name(rs.getString("kindred_First_Name"));
				obj.setKindred_surName(rs.getString("kindred_surName"));
				obj.setApply_time(rs.getTimestamp("apply_time"));

				al.add(obj);
			}
			setDataAL(al);
			rs.close();
			pstmt.close();
			conn.close();

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
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {

				}
				conn = null;
			}
		}

	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public String getEmpno() {
		return empno;
	}
	public void setEmpno(String empno) {
		this.empno = empno;
	}
	public ArrayList getDataAL() {
		return dataAL;
	}
	public void setDataAL(ArrayList dataAL) {
		this.dataAL = dataAL;
	}

	public boolean isSelectDeletedData() {
		return selectDeletedData;
	}

	public void setSelectDeletedData(boolean selectDeletedData) {
		this.selectDeletedData = selectDeletedData;
	}

	public boolean isSelectCrewAllData() {
		return selectCrewAllData;
	}

	public void setSelectCrewAllData(boolean selectCrewAllData) {
		this.selectCrewAllData = selectCrewAllData;
	}
}
