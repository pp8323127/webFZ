package eg.flightcheckitem;

import java.sql.*;
import java.util.*;

import eg.db.*;

/**
 * CheckItemData 取得所有查核項目資料(資料維護用）
 * 
 * 
 * @author cs66
 * @version 1.0 2007/6/27
 * 
 * Copyright: Copyright (c) 2007
 */
public class CheckItemData {
	private ArrayList dataAL;// 儲存 CheckMainItemObj 物件

	public void SelectData() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		// ci.db.ConnDB cn = new ci.db.ConnDB();
		ConnectDB cn = new ConnectDB();
		// LocalConnectDB cn = new LocalConnectDB();
		Driver dbDriver = null;
		try {

			// cn.setORP3EGUserCP();
			// dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			// conn = dbDriver.connect(cn.getConnURL(), null);

			// 直接連線 ORP3FZ
			// cn.setORT1EG();
			// // cn.setORP3EGUser();
			// java.lang.Class.forName(cn.getDriver());
			// conn = DriverManager.getConnection(cn.getConnURL(),
			// cn.getConnID(),
			// cn.getConnPW());
			conn = cn.getDataSourceConnection();

			// 取得查核資料
			pstmt = conn
					.prepareStatement("SELECT *  FROM egtchkitm order by startDate ,unit");

			rs = pstmt.executeQuery();
			ArrayList al = null;

			while (rs.next()) {
				if (al == null)
					al = new ArrayList();
				CheckMainItemObj obj = new CheckMainItemObj();;
				obj.setSeqno(rs.getString("seqno"));
				//obj.setExecuteCheck(rs.getString("executeCheck"));
				obj.setDescription(rs.getString("description"));
				obj.setUpdUser(rs.getString("updUser"));
				obj.setUpdDate(rs.getDate("updDate"));
				obj.setUnit(rs.getString("unit"));
				obj.setStartDate(rs.getDate("startDate"));
				obj.setEndDate(rs.getDate("endDate"));

				al.add(obj);

			}
			rs.close();
			pstmt.close();

			if (al != null) {
				for (int i = 0; i < al.size(); i++) {
					CheckMainItemObj obj = (CheckMainItemObj) al.get(i);
					// 取得fltno資料
					pstmt = conn.prepareStatement("SELECT * FROM egtchkflt "
							+ "WHERE seqno=? ORDER BY fltno");
					pstmt.setString(1, obj.getSeqno());
					rs = pstmt.executeQuery();
					ArrayList fltnoAL = null;
					while (rs.next()) {
						if (fltnoAL == null)
							fltnoAL = new ArrayList();

						fltnoAL.add(rs.getString("fltno"));
					}
					rs.close();
					pstmt.close();
					obj.setFltnoAL(fltnoAL);

					// 取得查核細項資料

					pstmt = conn.prepareStatement("SELECT * FROM egtchkitd "
							+ "WHERE seqno=? "
							+ "ORDER BY executestatus desc,evalstatus");
					pstmt.setString(1, obj.getSeqno());
					rs = pstmt.executeQuery();
					ArrayList detailAL = null;
					while (rs.next()) {
						if (detailAL == null)
							detailAL = new ArrayList();

						CheckDetailItemObj dObj = new CheckDetailItemObj();
						dObj.setDescription(rs.getString("description"));
						dObj.setEvalStatus(rs.getString("evalStatus"));
						dObj.setExecuteStatus(rs.getString("executeStatus"));
						dObj.setItemSeqno(rs.getString("itemSeqno"));
						dObj.setSeqno(rs.getString("seqno"));
						detailAL.add(dObj);
					}
					obj.setCheckDetailAL(detailAL);
					rs.close();
					pstmt.close();

					// 檢查是否已有輸入資料

					pstmt = conn
							.prepareStatement("SELECT count(seqno) cnt FROM egtchkrdm "
									+ "WHERE checkseqno=?");
					pstmt.setString(1, obj.getSeqno());
					rs = pstmt.executeQuery();
					if (rs.next()) {
						if (rs.getInt("cnt") > 0) {
							obj.setHasCheckData(true);
						}
					}

					rs.close();
					pstmt.close();

				}
			}

			setDataAL(al);
			rs.close();
			pstmt.close();

			conn.close();

		} catch (Exception e) {
			System.out.println(e.toString());
//			e.printStackTrace();
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

	private void setDataAL(ArrayList dataAL) {
		this.dataAL = dataAL;
	}
}
