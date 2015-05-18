package fz.pracP.uploadFile;

import java.sql.*;

import ci.db.*;

/**
 * DeleteData 刪除 DB 中之 record
 * 
 * SYSTEM: 網路座艙長報告(EG) 上傳檔案功能
 * 
 * @author cs66
 * @version 1.0 2006/3/17
 * 
 * Copyright: Copyright (c) 2006
 */
public class DeleteData {

	// public static void main(String[] args) {
	// DeleteData dd = new DeleteData("2006/03/16", "0006", "TPELAX",
	// "200600001.jpg");
	//
	// try {
	// dd.DoDelete();
	// } catch (ClassNotFoundException e) {
	// // TODO Auto-generated catch block
	// e.printStackTrace();
	// } catch (SQLException e) {
	// // TODO Auto-generated catch block
	// e.printStackTrace();
	// }
	// System.out.println("刪除狀態：" + dd.isDelSuccess());
	// }

	private String fdate;
	private String fltno;
	private String sect;

	private String uploadFileName;
	private boolean delSuccess = false;
	private String msg = "";

	/**
	 * @param fdate
	 *            yyyy/mm/dd
	 * @param fltno
	 * @param sect
	 * @param purEmpno
	 *            purser's empno
	 */
	public DeleteData(String fdate, String fltno, String sect,
			String uploadFileName) {
		this.fdate = fdate;
		this.fltno = fltno;
		this.sect = sect;

		this.uploadFileName = uploadFileName;
	}

	public DeleteData(String fdate, String fltno, String sect) {
		this.fdate = fdate;
		this.fltno = fltno;
		this.sect = sect;
	}

	public void DoDelete() throws  SQLException,Exception {
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
			// 直接連線
			// cn.setORT1EG();
			// java.lang.Class.forName(cn.getDriver());
			// conn = DriverManager.getConnection(cn.getConnURL()
			// ,cn.getConnID() ,
			// cn.getConnPW());

			if (uploadFileName != null) {
				sql = "DELETE egtfile WHERE fltd=To_Date(?,'yyyy/mm/dd') and fltno=? and sect=?  and filename=? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, fdate);
				pstmt.setString(2, fltno);
				pstmt.setString(3, sect);
				pstmt.setString(4, uploadFileName);

			} else {
				sql = "DELETE egtfile WHERE fltd=To_Date(?,'yyyy/mm/dd') and fltno=? and sect=? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, fdate);
				pstmt.setString(2, fltno);
				pstmt.setString(3, sect);

			}

			pstmt.executeUpdate();

			setDelSuccess(true);

		} catch(Exception e){
			setDelSuccess(false);
			
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

	
	public void DoZCDelete() throws  SQLException,Exception {
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
			// 直接連線
//			 cn.setORT1EG();
//			 java.lang.Class.forName(cn.getDriver());
//			 conn = DriverManager.getConnection(cn.getConnURL()
//			 ,cn.getConnID() ,
//			 cn.getConnPW());

			if (uploadFileName != null) {
				sql = "DELETE egtzcfile WHERE fltd=To_Date(?,'yyyy/mm/dd') and fltno=? and sect=?  and filename=? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, fdate);
				pstmt.setString(2, fltno);
				pstmt.setString(3, sect);
				pstmt.setString(4, uploadFileName);

			} else {
				sql = "DELETE egtzcfile WHERE fltd=To_Date(?,'yyyy/mm/dd') and fltno=? and sect=? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, fdate);
				pstmt.setString(2, fltno);
				pstmt.setString(3, sect);

			}

			pstmt.executeUpdate();
			setDelSuccess(true);
//			setMsg(sql+uploadFileName);
		}catch(Exception e){
			setDelSuccess(false);
//			setMsg(e.toString());
		}finally {

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
	public boolean isDelSuccess() {
		return delSuccess;
	}

	private void setDelSuccess(boolean delStatus) {
		this.delSuccess = delStatus;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}
	
}