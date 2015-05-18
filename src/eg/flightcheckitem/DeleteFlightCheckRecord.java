package eg.flightcheckitem;

import java.sql.*;
import java.util.*;

import eg.db.*;

/**
 * DeleteFlightCheckRecord
 * 
 * 
 * @author cs66
 * @version 1.0 2007/7/4
 * 
 * Copyright: Copyright (c) 2007
 */
public class DeleteFlightCheckRecord {
	private CheckItemKeyValue chkItemKey;
	private String errMsg = "";
	private boolean deleteStatus = false;

	/**
	 * @param chkItemKey
	 *            比對Key值,含fltd,fltno,sector,series_num
	 * @throws Exception
	 */
	public DeleteFlightCheckRecord(CheckItemKeyValue chkItemKey) {
		this.chkItemKey = chkItemKey;
	}


	public void DeleteData() throws Exception {

		if (chkItemKey == null)
			throw new NullPointerException("Parameters: Key value is required.");

		String errMsg = "";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		// ci.db.ConnDB cn = new ci.db.ConnDB();
		ConnectDB cn = new ConnectDB();
//		 LocalConnectDB cn = new LocalConnectDB();
//		Driver dbDriver = null;
		try {
			// User connection pool to ORP3DF
			// cn.setORP3EGUserCP();
			// dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			// conn = dbDriver.connect(cn.getConnURL(), null);

			// 直接連線 ORP3FZ
			// cn.setORT1EG();
			// cn.setORP3EGUser();
			// java.lang.Class.forName(cn.getDriver());
			// conn = DriverManager.getConnection(cn.getConnURL(),
			// cn.getConnID(),
			// cn.getConnPW());
			conn = cn.getDataSourceConnection();
			conn.setAutoCommit(false);
			// 以班號及日期,檢查是否有需查核之項目
			pstmt = conn.prepareStatement("SELECT seqno FROM egtchkrdm "
					+ "WHERE fltd=To_Date(?,'yyyy/mm/dd') "
					+ "AND fltno=? AND sector=? AND psrempn=?");

			pstmt.setString(1, chkItemKey.getFltd());
			pstmt.setString(2, chkItemKey.getFltno());
			pstmt.setString(3, chkItemKey.getSector());
			pstmt.setString(4, chkItemKey.getPsrEmpn());
			rs = pstmt.executeQuery();

			ArrayList al = null;

			while (rs.next()) {
				if (al == null)
					al = new ArrayList();
				al.add(rs.getString("seqno"));
			}
			pstmt.close();
			rs.close();

			if (al != null) {
				for (int i = 0; i < al.size(); i++) {
					pstmt = conn
							.prepareStatement("delete egtchkrdd where checkrdseq=?");
					pstmt.setString(1, (String) al.get(i));
					pstmt.executeUpdate();

					pstmt = conn
							.prepareStatement("delete egtchkrdm where seqno=?");
					pstmt.setString(1, (String) al.get(i));
					pstmt.executeUpdate();

					pstmt.close();
				}

			}
			conn.commit();
			conn.close();
			setDeleteStatus(true);

		} catch (SQLException e) {
			setDeleteStatus(false);
			errMsg += e.getMessage();
			try {
				// 有錯誤時 rollback
				conn.rollback();
			} catch (SQLException e1) {
				errMsg += e1.getMessage();
			}

		} catch (Exception e) {
			setDeleteStatus(false);
			errMsg += e.getMessage();

			try {
				// 有錯誤時 rollback
				conn.rollback();
			} catch (SQLException e1) {
				errMsg += e1.getMessage();
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

				}
				conn = null;
			}
		}
		setErrMsg(errMsg);

	}
	public boolean isDeleteStatus() {
		return deleteStatus;
	}

	private void setDeleteStatus(boolean deleteStatus) {
		this.deleteStatus = deleteStatus;
	}

	public String getErrMsg() {
		return errMsg;
	}

	private void setErrMsg(String errMsg) {
		this.errMsg = errMsg;
	}

}
