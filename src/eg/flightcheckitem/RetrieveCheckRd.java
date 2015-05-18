package eg.flightcheckitem;

import java.sql.*;
import java.util.*;

//import eg.db.*;

/**
 * RetrieveCheckRd 取得已輸入的查核資料
 * 
 * 
 * @author cs66
 * @version 1.0 2007/6/26
 * 
 * Copyright: Copyright (c) 2007
 */
public class RetrieveCheckRd {
	private String seqno;// 檢查項目的seqno
	private String checkRdSeqno;// CheckRd的seqno
	private boolean hasCheckRd = false;
	private CheckItemKeyValue chkItemKey;// 檢查match 的key value
	private CheckRecordObj checkRdObj;

	public RetrieveCheckRd(String seqno) {
		this.seqno = seqno;
	}

	public void SelectData() throws Exception {

		if (seqno == null)
			throw new NullPointerException("Parameters: Check Item is missed.");
		if (checkRdSeqno == null && chkItemKey == null)
			throw new NullPointerException(
					"Parameters: Data is missed.( Key value is required)");

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ci.db.ConnDB cn = new ci.db.ConnDB();
//		 ConnectDB cn = new ConnectDB();
		// LocalConnectDB cn = new LocalConnectDB();
		Driver dbDriver = null;
		try {

			cn.setORP3EGUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);

			// // 直接連線 ORP3FZ
//			 cn.setORT1EG();
//			 // cn.setORP3EGUser();
//			 java.lang.Class.forName(cn.getDriver());
//			 conn = DriverManager.getConnection(cn.getConnURL(),
//			 cn.getConnID(),
//			 cn.getConnPW());
//			  conn = cn.getDataSourceConnection();

			// 檢查是否有需查核之項目
			StringBuffer sqlSB = new StringBuffer();
			sqlSB.append("SELECT to_char(m.fltd,'yyyy/mm/dd') fltdStr,");
			sqlSB.append("m.* ");
			sqlSB.append("FROM egtchkrdm m ");
			sqlSB.append("where checkSeqno=? ");

			if (checkRdSeqno != null) {
				// 以 CheckRdSeqno取得資料
				sqlSB.append("and seqno=? ");

				pstmt = conn.prepareStatement(sqlSB.toString());

				pstmt.setString(1, seqno);
				pstmt.setString(2, checkRdSeqno);
			} else {
				// 以航班資訊（match key: chkItemKey）取得資料

				sqlSB.append("and fltd=to_date(?,'yyyy/mm/dd') and fltno=? ");
				sqlSB.append("and sector=?  and psrEmpn=? ");

				pstmt = conn.prepareStatement(sqlSB.toString());

				pstmt.setString(1, seqno);
				pstmt.setString(2, chkItemKey.getFltd());
				pstmt.setString(3, chkItemKey.getFltno());
				pstmt.setString(4, chkItemKey.getSector());
				pstmt.setString(5, chkItemKey.getPsrEmpn());

			}

			rs = pstmt.executeQuery();
			CheckRecordObj obj = null;
			while (rs.next()) {

				obj = new CheckRecordObj();
				obj.setSeries_num(rs.getString("series_num"));
				obj.setFltd(rs.getString("fltdStr"));
				obj.setFlightDate(rs.getDate("fltd"));
				obj.setFltno(rs.getString("fltno"));
				obj.setSector(rs.getString("sector"));
				obj.setPsrEmpn(rs.getString("psrEmpn"));

				obj.setSeqno(rs.getString("seqno"));
				obj.setCheckSeqno(rs.getString("checkSeqno"));
				obj.setExecuteCheck(rs.getString("executeStatus"));
				obj.setEvalStatus(rs.getString("evalStatus"));
				obj.setComments(rs.getString("comments"));
				

			}
			pstmt.close();
			rs.close();

			sqlSB = new StringBuffer();
			// check 查核項目資料是否已輸入
			int tempCount = 0;
			if (obj != null) {
				sqlSB = new StringBuffer();

			
				ArrayList detailAL = null;
				sqlSB = new StringBuffer();
				sqlSB.append("SELECT rd.* FROM egtchkrdd rd ");
				sqlSB.append("WHERE checkrdSeq=? ORDER BY checkdetailseq");

				pstmt = conn.prepareStatement(sqlSB.toString());

				pstmt.setString(1, checkRdSeqno);

				rs = pstmt.executeQuery();
				while (rs.next()) {
					if (detailAL == null)
						detailAL = new ArrayList();

					CheckRecordDetailObj detailObj = new CheckRecordDetailObj();
					detailObj.setCheckDetailSeq(rs.getString("checkDetailSeq"));
					detailObj.setCheckRdSeq(rs.getString("checkRdSeq"));
					detailObj.setCheckSeqno(rs.getString("checkSeqno"));
					detailObj.setComments(rs.getString("comments"));
					detailObj.setCorrect(rs.getString("correct"));

					detailAL.add(detailObj);
				}
				rs.close();
				pstmt.close();
				
				obj.setCheckDetailAL(detailAL);

				

			}
			setCheckRdObj(obj);
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
	public boolean isHasCheckRd() {
		return hasCheckRd;
	}

	private void setHasCheckRd(boolean hasCheckRd) {
		this.hasCheckRd = hasCheckRd;
	}

	public CheckItemKeyValue getChkItemKey() {
		return chkItemKey;
	}

	public void setChkItemKey(CheckItemKeyValue chkItemKey) {
		this.chkItemKey = chkItemKey;
	}

	public String getSeqno() {
		return seqno;
	}

	public void setSeqno(String seqno) {
		this.seqno = seqno;
	}

	public CheckRecordObj getCheckRdObj() {
		return checkRdObj;
	}

	public void setCheckRdObj(CheckRecordObj checkRdObj) {
		this.checkRdObj = checkRdObj;
	}

	public String getCheckRdSeqno() {
		return checkRdSeqno;
	}

	public void setCheckRdSeqno(String checkRdSeqno) {
		this.checkRdSeqno = checkRdSeqno;
	}

}
