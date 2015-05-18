package eg.flightcheckitem;

import java.sql.*;
import java.util.*;

import eg.db.*;

/**
 * RetrieveCheckItem 以查核項目的序號，取得查詢項目的資料
 * 
 * 
 * @author cs66
 * @version 1.0 2007/6/21
 * 
 * Copyright: Copyright (c) 2007
 */
public class RetrieveCheckItem {

	private String seqno;
	private ArrayList dataAL;
	private CheckMainItemObj chkMainItemObj;
	public RetrieveCheckItem(String seqno) {
		this.seqno = seqno;
	}

	public void SelectData() throws Exception {
		if (seqno == null)
			throw new NullPointerException(
					"Parameters: checkItem seqno value is required.");

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
//		ci.db.ConnDB cn = new ci.db.ConnDB();
		 ConnectDB cn = new ConnectDB();
		// LocalConnectDB cn = new LocalConnectDB();
//		Driver dbDriver = null;
		try {
			// User connection pool to ORP3DF
			// cn.setORP3EGUserCP();
			// dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			// conn = dbDriver.connect(cn.getConnURL(), null);

			// 直接連線 ORP3FZ
//			cn.setORT1EG();
//			// cn.setORP3EGUser();
//			java.lang.Class.forName(cn.getDriver());
//			conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),
//					cn.getConnPW());
			 conn = cn.getDataSourceConnection();

			// 取得查核資料
			pstmt = conn.prepareStatement("SELECT m.description md,d.* "
					+ "FROM egtchkitm m,egtchkitd d "
					+ "WHERE m.seqno = d.seqno "
					+ "AND m.seqno=? ORDER BY executestatus desc");

			pstmt.setString(1, seqno);
			rs = pstmt.executeQuery();
			ArrayList al = null;
			CheckMainItemObj obj =  new CheckMainItemObj();;
			while (rs.next()) {
			
				obj.setSeqno(rs.getString("seqno"));
				obj.setDescription(rs.getString("md"));

				if (al == null)
					al = new ArrayList();
				CheckDetailItemObj dObj = new CheckDetailItemObj();
				dObj.setDescription(rs.getString("description"));
				dObj.setEvalStatus(rs.getString("evalStatus"));
				dObj.setExecuteStatus(rs.getString("executeStatus"));
				dObj.setItemSeqno(rs.getString("itemSeqno"));
				dObj.setSeqno(rs.getString("seqno"));

				al.add(dObj);
				
				
				
			}
			obj.setCheckDetailAL(al);
			setChkMainItemObj(obj);
			
			pstmt.close();
			rs.close();

			conn.close();

		} catch (Exception e) {
			System.out.println(e.toString());
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
	public ArrayList getDataAL() {
		return dataAL;
	}
	public void setDataAL(ArrayList dataAL) {
		this.dataAL = dataAL;
	}

	public CheckMainItemObj getChkMainItemObj() {
		return chkMainItemObj;
	}

	public void setChkMainItemObj(CheckMainItemObj chkMainItemObj) {
		this.chkMainItemObj = chkMainItemObj;
	}

}
