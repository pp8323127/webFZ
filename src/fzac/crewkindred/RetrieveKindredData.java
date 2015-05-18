package fzac.crewkindred;

import java.sql.*;
import java.util.*;

import ci.db.*;
import ci.tool.*;

/**
 * RetrieveKindredData 取得組員登錄的家屬聯絡資料
 * 
 * 
 * @author cs66
 * @version 1.0 2008/2/14
 * 
 * Copyright: Copyright (c) 2008
 */
public class RetrieveKindredData {

	// public static void main(String[] args) {
	// RetrieveKindredData rd = null;
	//
	// try {
	// rd = new RetrieveKindredData("636750");
	// if (rd.hasNoneExportedData()) {
	// System.out.println("有尚未匯入的資料");
	// CrewKindredObj obj = rd.getNoneExportedObj();
	// System.out.println(obj.getKindred_surName()
	// + obj.getKindred_First_Name() + "\t"
	// + obj.getKinddred_Phone_Num()+"\t");
	// } else {
	// System.out.println("無待匯入的資料");
	// }
	//
	// if (rd.getKindredAL() != null) {
	// System.out.println("有已經匯入的歷史紀錄");
	// for (int i = 0; i < rd.getKindredAL().size(); i++) {
	// CrewKindredObj obj = (CrewKindredObj) rd.getKindredAL()
	// .get(i);
	//
	// System.out.println(obj.getKindred_surName()
	// + obj.getKindred_First_Name() + "\t"
	// + obj.getKinddred_Phone_Num());
	// }
	// } else {
	// System.out.println("無歷史資料");
	// }
	// } catch (Exception e) {
	// e.printStackTrace();
	// }
	//
	// }

	private String empno;
	private CrewKindredObj noneExportedObj;// 尚未匯入的資料
	private ArrayList kindredAL;// 不包含尚未匯入的資料
	private CrewKindredObj activeCKDataObj;// 目前已生效之家屬資料

	public RetrieveKindredData(String empno) throws Exception {
		this.empno = empno;
		SelectData();

	}

	/**
	 * 
	 * @return 是否有尚未匯入的資料,有：回傳true, 無：回傳false
	 * 
	 */
	public boolean hasNoneExportedData() {
		boolean bool = false;
		if (getNoneExportedObj() != null) {
			bool = true;
		}
		return bool;
	}

	/**
	 * 取得資料
	 * 
	 * @throws Exception
	 * 
	 */
	public void SelectData() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		ConnDB cn = new ConnDB();

		Driver dbDriver = null;

		try {

			// User connection pool to ORP3DF
			 cn.setORP3FZUserCP();
			 dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			 conn = dbDriver.connect(cn.getConnURL(), null);
			//
//			cn.setORT1FZAP();
//			java.lang.Class.forName(cn.getDriver());
//			conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),
//					cn.getConnPW());

			pstmt = conn
					.prepareStatement("SELECT * FROM fztckind WHERE empno=? "
							+ "ORDER BY export_ind desc,export_time DESC, apply_time desc,delete_ind");

			pstmt.setString(1, empno);
			rs = pstmt.executeQuery();
			ArrayList al = null;
			while (rs.next()) {

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

				if ("N".equals(obj.getDelete_ind())
						&& "N".equals(obj.getExport_ind())) {
					// 尚未匯入，也未刪除者
					setNoneExportedObj(obj);
				} else {
					if (al == null)
						al = new ArrayList();
					al.add(obj);
				}
				setKindredAL(al);
			}
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
	 * 
	 * 取得已生效之家屬聯絡資料
	 * 
	 * @throws Exception
	 * 
	 */
	public void SelectActiveData() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		ConnDB cn = new ConnDB();

		Driver dbDriver = null;

		try {

			cn.setAOCIPRODCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);

			// cn.setAOCIPRODFZUser();
			// java.lang.Class.forName(cn.getDriver());
			// conn = DriverManager.getConnection(cn.getConnURL(),
			// cn.getConnID(),
			// cn.getConnPW());

			pstmt = conn.prepareStatement("SELECT * FROM crew_next_of_kin_v "
					+ "WHERE staff_num=? and contact_phone_num is not null ");

			pstmt.setString(1, empno);
			rs = pstmt.executeQuery();
			CrewKindredObj obj = null;
			while (rs.next()) {

				if (obj == null)
					obj = new CrewKindredObj();

				obj.setEmpno(rs.getString("staff_num"));

				obj.setKinddred_Phone_Num(rs.getString("contact_phone_num"));
				obj.setKindred_First_Name(UnicodeStringParser.removeExtraEscape(rs.getString("first_name")));
				obj.setKindred_surName(UnicodeStringParser.removeExtraEscape(rs.getString("surname")));

			}
			setActiveCKDataObj(obj);
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
	public CrewKindredObj getNoneExportedObj() {
		return noneExportedObj;
	}

	public void setNoneExportedObj(CrewKindredObj nonExportedObj) {
		this.noneExportedObj = nonExportedObj;
	}

	public ArrayList getKindredAL() {
		return kindredAL;
	}

	public void setKindredAL(ArrayList kindredAL) {
		this.kindredAL = kindredAL;
	}

	public CrewKindredObj getActiveCKDataObj() {
		return activeCKDataObj;
	}

	public void setActiveCKDataObj(CrewKindredObj activeCrewKindredDataObj) {
		this.activeCKDataObj = activeCrewKindredDataObj;
	}
}
