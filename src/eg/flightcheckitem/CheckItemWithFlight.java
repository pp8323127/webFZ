package eg.flightcheckitem;

import java.sql.*;
import java.util.*;
import eg.db.*;

/**
 * CheckItemWithFlight 檢查該航班是否有需檢查項目,
 * 
 * 
 * @author cs66
 * @version 1.0 2007/6/21
 * 
 * Copyright: Copyright (c) 2007
 */
public class CheckItemWithFlight {

	private boolean hasCheckItem = false;
	private ArrayList chkItemAL;
	private CheckItemKeyValue chkItemKey;
	private boolean hasCheckAllOrNoCheck = true;
	/**
	 * @param chkItemKey
	 *            比對Key值,含fltd,fltno,sector,series_num
	 * @throws Exception
	 */
	public CheckItemWithFlight(CheckItemKeyValue chkItemKey) throws Exception {

		this.chkItemKey = chkItemKey;
		SelectData();
	}

	public void SelectData() throws Exception {

		if (chkItemKey == null)
			throw new NullPointerException("Parameters: Key value is required.");

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
			// cn.setORT1EG();
//			 cn.setORP3EGUser();
//			 java.lang.Class.forName(cn.getDriver());
//			 conn = DriverManager.getConnection(cn.getConnURL(),
//			 cn.getConnID(),
//			 cn.getConnPW());
		    
		    
			conn = cn.getDataSourceConnection();

			// 以班號及日期,檢查是否有需查核之項目
			pstmt = conn.prepareStatement("SELECT m.seqno,m.description,f.fltno "
							+ "FROM egtchkitm m,egtchkflt f "
							+ "WHERE  m.seqno = f.seqno "
							// + "AND m.executecheck='Y' "
							+ "AND ( To_Date(?,'yyyy/mm/dd') BETWEEN startDate AND endDate) "
							+ "AND fltno=rtrim(?,'Z') order by seqno");

			pstmt.setString(1,chkItemKey.getFltd());
			pstmt.setString(2, chkItemKey.getFltno());
			rs = pstmt.executeQuery();
			ArrayList al = null;
			while (rs.next()) 
			{
			    if(!"0065TPEBKK".equals(chkItemKey.getFltno()+chkItemKey.getSector()))
				{
					if (al == null)
						al = new ArrayList();
					CheckMainItemObj obj = new CheckMainItemObj();
					obj.setSeqno(rs.getString("seqno"));
					obj.setDescription(rs.getString("description"));
					obj.setFltno(rs.getString("fltno"));				
				    al.add(obj);
				}
			}
			pstmt.close();
			rs.close();

			// check 查核項目資料是否已輸入
			int tempCount = 0;
			if (al != null) {

				for (int i = 0; i < al.size(); i++) {
					CheckMainItemObj obj = (CheckMainItemObj) al.get(i);
					pstmt = conn.prepareStatement("SELECT * FROM egtchkrdm "
							+ "WHERE fltd = To_Date(?,'yyyy/mm/dd') "
							+ "AND fltno = ? AND sector = ? "
							+ "AND psrempn = ? AND checkseqno=?");
					pstmt.setString(1, chkItemKey.getFltd());
					pstmt.setString(2, chkItemKey.getFltno());
					pstmt.setString(3, chkItemKey.getSector());
					pstmt.setString(4, chkItemKey.getPsrEmpn());
					pstmt.setString(5, obj.getSeqno());

					rs = pstmt.executeQuery();
					if (rs.next()) {

						tempCount++;
						obj.setHasCheckData(true);

						// check rd 主檔seqno
						obj.setCheckRdSeq(rs.getString("seqno"));
					}

					pstmt.close();
					rs.close();

				}
				if (tempCount < al.size()) {// 有檢查項目尚未輸入
					setHasCheckAllOrNoCheck(false);
				}

			}

			setChkItemAL(al);

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
	public boolean isHasCheckItem() {
		return hasCheckItem;
	}
	private void setHasCheckItem(boolean hasCheckItem) {
		this.hasCheckItem = hasCheckItem;
	}

	public ArrayList getChkItemAL() {
		return chkItemAL;
	}

	private void setChkItemAL(ArrayList chkItemAL) {
		this.chkItemAL = chkItemAL;
	}

	public boolean isHasCheckAllOrNoCheck() {
		return hasCheckAllOrNoCheck;
	}

	public void setHasCheckAllOrNoCheck(boolean hasCheckAllOrNoCheck) {
		this.hasCheckAllOrNoCheck = hasCheckAllOrNoCheck;
	}
}
