package fz.pracP.pa;

import java.sql.*;
import java.util.*;

import ci.db.*;

/**
 * PACrewEvalData PA Crew 考評
 * 
 * 
 * @author cs71
 * @version 1.0 2007/3/15
 * 
 * Copyright: Copyright (c) 2007
 */
public class PACrewEvalData {

	private String fltd;// 日期,format: yyyy/mm/dd
	private String fltno;// 航班號
	private String sect;// 區段
	private String empno;// PA員工號
	private ArrayList dataAL;
	private String seqno;// 該筆PA資料的seqno

	// public static void main(String[] args) {
	// PACrewEvalData pa = new PACrewEvalData("2007/03/16", "0007",
	// "LAXTPE", "632978");
	// ArrayList al = null;
	// try {
	// pa.SelectDataByMainAndDetail();
	// al = pa.getDataAL();
	//
	// if (al != null) {
	// for (int i = 0; i < al.size(); i++) {
	// PACrewEvalMainObj o = (PACrewEvalMainObj) al.get(i);
	// System.out.println(o.getGdYear() + "\t" + o.getUpddate());
	// if (o.getDetailObjAL() != null) {
	// for (int index = 0; index < o.getDetailObjAL().size(); index++) {
	// PACrewEvalDetailObj dObj = (PACrewEvalDetailObj)
	// o.getDetailObjAL().get(index);
	// System.out.println(dObj.getScoreDesc()+":"+dObj.getScore()+",附註："+dObj.getComm()+"\t");
	//						
	// }
	// }
	//
	// }
	// } else {
	// System.out.println("查無資料!!");
	// }
	// } catch (Exception e) {
	// e.printStackTrace();
	// }
	// }
	
	public PACrewEvalData(String fltd, String fltno, String sect,String empno) 
	{
		this.fltd = fltd;
		this.fltno = fltno;
		this.sect = sect;
		this.empno = empno;
	}

	public void SelectData() throws Exception 
	{
		if (fltd == null | fltno == null | sect == null | empno == null)		    
			throw new NullPointerException("Parameter missed!!");

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ConnDB cn = new ConnDB();
		Driver dbDriver = null;
		String sql = "";
		try 
		{
			cn.setORP3EGUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);
			sql = " SELECT m.seqno,To_Char(m.fltd,'yyyy') gdyear,m.fltd,To_Char(m.fltd,'yyyy/mm/dd') fltd1,m.fltno, " +
				  " m.sect,m.empno,m.upddate,m.upduser,s.scoretype,s.score,s.comm,d.scoredesc " +
				  " FROM egtpadm m,egtpads s,egtpadesc d " +
				  " where  m.seqno = s.seqno AND s.scoretype = d.scoretype " +
				  " AND fltd=to_date(?,'yyyy/mm/dd') and fltno=? and sect=? and empno=? ";
			
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, fltd);
			pstmt.setString(2, fltno);
			pstmt.setString(3, sect);
			pstmt.setString(4, empno);

			ArrayList al = null;
			rs = pstmt.executeQuery();
			while (rs.next()) {
				if (al == null)
					al = new ArrayList();

				setSeqno(rs.getString("seqno"));
				PACrewEvalObj obj = new PACrewEvalObj();
				obj.setSeqno(rs.getString("seqno"));
				obj.setEmpno(rs.getString("empno"));
				obj.setFltd(rs.getString("fltd1"));
				obj.setFlightDate(rs.getDate("fltd"));
				obj.setFltno(rs.getString("fltno"));
				obj.setGdYear(rs.getString("gdYear"));
				obj.setSect(rs.getString("sect"));
				obj.setUpduser(rs.getString("upduser"));
				obj.setUpddate(rs.getDate("upddate"));
				obj.setScoreType(rs.getString("scoretype"));
				obj.setScore(rs.getString("score"));
				obj.setComm(rs.getString("comm"));
				obj.setScoreDesc(rs.getString("scoreDesc"));

				al.add(obj);
			}

			setDataAL(al);
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
	public void SelectDataByMainAndDetail() throws Exception 
	{
		if (fltd == null | fltno == null | sect == null | empno == null)
			throw new NullPointerException("Parameter missed!!");

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ConnDB cn = new ConnDB();
		Driver dbDriver = null;
		String sql = "";
		try {
			cn.setORP3EGUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);
			sql = "select m.*,to_char(fltd,'yyyy/mm/dd') fltd1, To_Char(m.fltd,'yyyy') gdyear from  egtpadm m "
				+ "where fltd=to_date(?,'yyyy/mm/dd') and fltno=? "
				+ "and sect=? and empno=?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, fltd);
			pstmt.setString(2, fltno);
			pstmt.setString(3, sect);
			pstmt.setString(4, empno);

			ArrayList al = null;

			// 取得主項資料
			rs = pstmt.executeQuery();
			while (rs.next()) {
				if (al == null)
					al = new ArrayList();

				PACrewEvalMainObj obj = new PACrewEvalMainObj();
				obj.setSeqno(rs.getString("seqno"));
				obj.setEmpno(rs.getString("empno"));
				obj.setFltd(rs.getString("fltd1"));
				obj.setFlightDate(rs.getDate("fltd"));
				obj.setFltno(rs.getString("fltno"));
				obj.setGdYear(rs.getString("gdYear"));
				obj.setSect(rs.getString("sect"));
				obj.setUpduser(rs.getString("upduser"));
				obj.setUpddate(rs.getDate("upddate"));

				al.add(obj);
			}
			pstmt.close();
			rs.close();

			if (al != null) 
			{
				// 取得細項

				for (int i = 0; i < al.size(); i++) 
				{
					PACrewEvalMainObj obj = (PACrewEvalMainObj) al.get(i);
					
					sql = " SELECT d.seqno,d.scoretype,d.score,d.comm,e.scoredesc "	+ 
					      " FROM egtpads d,egtpadesc e " +
						  " WHERE d.scoretype = e.scoretype AND d.seqno=? ";
					
					pstmt = conn.prepareStatement(sql);

					pstmt.setString(1, obj.getSeqno());
					rs = pstmt.executeQuery();
					ArrayList detailAL = null;
					while (rs.next()) {
						if (detailAL == null)
							detailAL = new ArrayList();

						PACrewEvalDetailObj dObj = new PACrewEvalDetailObj();
						dObj.setComm(rs.getString("comm"));
						dObj.setScore(rs.getInt("score"));
						dObj.setScoreDesc(rs.getString("scoreDesc"));
						dObj.setScoreType(rs.getString("scoreType"));
						dObj.setSeqno(rs.getString("seqno"));

						detailAL.add(dObj);
					}
					obj.setDetailObjAL(detailAL);

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

	private void setDataAL(ArrayList dataAL) {
		this.dataAL = dataAL;
	}

	public String getSeqno() {
		return seqno;
	}

	private void setSeqno(String seqno) {
		this.seqno = seqno;
	}

}
