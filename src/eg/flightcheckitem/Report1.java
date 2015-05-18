package eg.flightcheckitem;

import java.sql.*;
import java.util.*;

import eg.db.*;

/**
 * Report1
 * 
 * 
 * @author cs66
 * @version 1.0 2007/6/29
 * 
 * Copyright: Copyright (c) 2007
 */
public class Report1 {
	private String startDate;
	private String endDate;
	private String executeStatus;
	private String checkSeqno;
	private ArrayList dataAL;

	public Report1(String startDate, String endDate, String checkSeqno,
			String executeStatus) {
		this.startDate = startDate;
		this.endDate = endDate;
		this.executeStatus = executeStatus;
		this.checkSeqno = checkSeqno;

	}

	public void SelectData() throws Exception {
		if (checkSeqno == null)
			throw new NullPointerException("Parameters: Check Item is missed.");
		if (!ci.tool.CheckDate.isValidateDate(startDate))
			throw new Exception("開始日期格式不正確（yyyy/mm/dd）");
		if (!ci.tool.CheckDate.isValidateDate(endDate))
			throw new Exception("結束日期格式不正確（yyyy/mm/dd）");
		if (!ci.tool.CheckDate.checkDateRange(startDate, endDate))
			throw new Exception("結束日期必須大於開始日期 ");

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
//		ci.db.ConnDB cn = new ci.db.ConnDB();
		 ConnectDB cn = new ConnectDB();
		// LocalConnectDB cn = new LocalConnectDB();
//		Driver dbDriver = null;
		try {

//			cn.setORP3EGUserCP();
//			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
//			conn = dbDriver.connect(cn.getConnURL(), null);

			// // 直接連線 ORP3FZ
			// cn.setORT1EG();
			// // cn.setORP3EGUser();
			// java.lang.Class.forName(cn.getDriver());
			// conn = DriverManager.getConnection(cn.getConnURL(),
			// cn.getConnID(),
			// cn.getConnPW());
			  conn = cn.getDataSourceConnection();

			// 檢查是否有需查核之項目
			StringBuffer sqlSB = new StringBuffer();

			sqlSB.append("SELECT to_char(m.fltd,'yyyy/mm/dd') fltdStr,");
			sqlSB.append("c.cname,m.* ");
			sqlSB.append("FROM egtchkrdm m,egtcbas c ");
			sqlSB.append("where m.psrempn = trim(c.empn) and m.checkSeqno=? ");
			sqlSB.append("AND fltd BETWEEN To_Date(?,'yyyy/mm/dd') ");
			sqlSB.append("AND To_Date(?,'yyyy/mm/dd') ");

			if ("Y".equals(executeStatus) || "N".equals(executeStatus)) {
				sqlSB.append("AND executestatus=? ");
			}
			sqlSB.append("ORDER BY fltd ");

			pstmt = conn.prepareStatement(sqlSB.toString());
			pstmt.setString(1, checkSeqno);
			pstmt.setString(2, startDate);
			pstmt.setString(3, endDate);

			if ("Y".equals(executeStatus) || "N".equals(executeStatus)) {
				pstmt.setString(4, executeStatus);
			}

			rs = pstmt.executeQuery();
			ArrayList al = null;

			while (rs.next()) {
				if (al == null)
					al = new ArrayList();
				CheckRecordObj obj = new CheckRecordObj();
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
				obj.setPsrCname(rs.getString("cname"));

				al.add(obj);
			}
			pstmt.close();
			rs.close();

			sqlSB = new StringBuffer();
			// check 查核項目資料是否已輸入
			int tempCount = 0;

			if (al != null) {
				for (int i = 0; i < al.size(); i++) {
					CheckRecordObj obj = (CheckRecordObj) al.get(i);
					sqlSB = new StringBuffer();

					// 先自座艙長報告，取得Acno及 psrsern

					sqlSB.append("SELECT f.acno,f.psrsern ");
					sqlSB.append("FROM egtchkrdm m,egtcflt f ");
					sqlSB.append("WHERE m.fltd = f.fltd ");
					sqlSB.append("AND m.fltno = f.fltno ");
					sqlSB.append("AND m.sector = f.sect ");
					sqlSB.append("AND m.psrempn = f.psrempn ");
					sqlSB.append("AND  m.seqno =?");

					pstmt = conn.prepareStatement(sqlSB.toString());
					pstmt.setString(1, obj.getSeqno());

					rs = pstmt.executeQuery();

					while (rs.next()) {
						obj.setAcno(rs.getString("acno"));
						obj.setPsrSern(rs.getString("psrsern"));
					}
					rs.close();
					pstmt.close();

					// check 查核項目資料是否已輸入
					sqlSB = new StringBuffer();
					sqlSB.append("SELECT rd.* ,itd.description ");
					sqlSB.append("FROM egtchkrdd rd,egtchkitd itd ");
					sqlSB.append("WHERE rd.checkseqno = itd.seqno ");
					sqlSB.append("AND rd.checkdetailseq = itd.itemseqno ");
					sqlSB.append("AND rd.checkrdSeq=? ");
					sqlSB.append("ORDER BY rd.correct desc	 ");

					pstmt = conn.prepareStatement(sqlSB.toString());

					pstmt.setString(1, obj.getSeqno());

					rs = pstmt.executeQuery();
					ArrayList detailAL = null;
					while (rs.next()) {
						if (detailAL == null)
							detailAL = new ArrayList();

						CheckRecordDetailObj detailObj = new CheckRecordDetailObj();
						detailObj.setCheckDetailSeq(rs
								.getString("checkDetailSeq"));
						detailObj.setCheckRdSeq(rs.getString("checkRdSeq"));
						detailObj.setCheckSeqno(rs.getString("checkSeqno"));
						detailObj.setComments(rs.getString("comments"));
						detailObj.setCorrect(rs.getString("correct"));
						detailObj.setDescription(rs.getString("description"));

						detailAL.add(detailObj);
					}
					rs.close();
					pstmt.close();

					obj.setCheckDetailAL(detailAL);

				}
			}

			setDataAL(al);
			pstmt.close();
			rs.close();
			conn.close();

		} catch (Exception e) {
			System.out.println(e.toString());
			e.printStackTrace();
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

}
