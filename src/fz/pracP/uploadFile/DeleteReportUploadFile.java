package fz.pracP.uploadFile;

//import java.io.*;
import java.sql.*;
import java.util.*;

import ci.db.*;

/**
 * DeleteReportUploadFile �R��������i�ɡA�P�ɧR���W���ɮפ�DB Data
 * 
 * SYSTEM: �����y�������i(EG) �W���ɮץ\��
 * 
 * @author cs66
 * @version 1.0 2006/3/20
 * 
 * Copyright: Copyright (c) 2006
 */
public class DeleteReportUploadFile {

	// public static void main(String[] args) {
	// DeleteData dd = new DeleteData("2006/03/16", "0006", "TPELAX");
	// DeleteReportUploadFile du = new DeleteReportUploadFile("2006/03/16",
	// "0006", "TPELAX");
	// ArrayList fileNameAL = null;
	// try {
	// du.initData();
	// fileNameAL = du.getFileNameList();
	// //�R��DB Data
	// dd.DoDelete();
	//    
	// System.out.println("�R����Ƨ���!!");
	//    
	// for ( int i = 0; i < fileNameAL.size(); i++) {
	// DeleteFile df = new DeleteFile((String) fileNameAL.get(i));
	// try {
	// df.DoDelete();
	// System.out.println("�R���ɮסG" + (String) fileNameAL.get(i)
	// + " ����!!");
	// } catch (IOException e1) {
	// System.out.println(e1.toString());
	// }
	// }
	// System.out.println("�����R��!!");
	//    
	// } catch (ClassNotFoundException e) {
	// System.out.println(e.toString());
	// } catch (SQLException e) {
	// System.out.println(e.toString());
	// }
	//    
	// }

	private String fdate;
	private String fltno;
	private String sect;
	private ArrayList fileNameList;

	/**
	 * @param fdate
	 *            format: yyyy/mm/dd
	 * @param fltno
	 * @param sect
	 */
	public DeleteReportUploadFile(String fdate, String fltno, String sect) {
		this.fdate = fdate;
		this.fltno = fltno;
		this.sect = sect;
	}

	public void initData() throws  SQLException,Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ConnDB cn = new ConnDB();

		Driver dbDriver = null;

		try {
			// User connection pool to ORP3DF
			cn.setORP3EGUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);

			// �����s�u
			// cn.setORT1EG();
			// java.lang.Class.forName(cn.getDriver());
			// conn = DriverManager.getConnection(cn.getConnURL()
			// ,cn.getConnID() ,
			// cn.getConnPW());

			sql = "SELECT filename FROM egtfile WHERE fltd= To_Date(?,'yyyy/mm/dd') AND fltno=? AND sect=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, fdate);
			pstmt.setString(2, fltno);
			pstmt.setString(3, sect);
			// �����o�ӥ����i�Ҧ��ɮצW��
			rs = pstmt.executeQuery();
			if (rs != null) {
				fileNameList = new ArrayList();
				while (rs.next()) {
					fileNameList.add(rs.getString("filename"));
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

	public ArrayList getFileNameList() {
		return fileNameList;
	}
}