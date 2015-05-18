package fz.pracP.pa;

import java.sql.*;
import java.util.*;
import ci.db.*;

/**
 * DeleteErrorPAData 刪除多餘的PA資料
 * 
 * 
 * @author cs71
 * @version 1.0 2008/07/10
 * 
 * Copyright: Copyright (c) 2008
 */
public class DeleteErrorPAData {
	private String fltd;// 日期,format: yyyy/mm/dd
	private String fltno;// 航班號
	private ArrayList dataAL;
	private String sect;// 區段
	private String psrEmpno;// 座艙長員工號
	private ArrayList paDutyList;// PA員工號

	// public static void main(String[] args) {
	// String fdate = "2007/03/16";
	// String fltno = "0006";
	// String sect = "TPELAX";
	// String purserEmpno = "628503";
	//
	// fz.pracT.pa.DeleteErrorPAData delPA = new fz.pracT.pa.DeleteErrorPAData(
	// fdate, fltno, sect, purserEmpno);
	// try {
	// delPA.job();
	// } catch (Exception e) {
	// e.printStackTrace();
	//
	// }
	// }

	/**
	 * @param fltd
	 * @param fltno
	 * @param sect
	 * @param psrEmpno
	 *            可為null值
	 * 
	 */
	public DeleteErrorPAData(String fltd, String fltno, String sect,String psrEmpno) 
	{
		this.fltd = fltd;
		this.fltno = fltno;
		this.sect = sect;
		this.psrEmpno = psrEmpno;
	}

	/**
	 * 
	 * 取得PA考評資料
	 */
	public void SelectPAData() throws Exception 
	{
		if (fltd == null | fltno == null | sect == null)
		{
			throw new NullPointerException("Parameter missed!!");
		}

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
			sql = " SELECT seqno,empno FROM egtpadm  where fltd=to_date(?,'yyyy/mm/dd') and fltno=? and sect=? ";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, fltd);
			pstmt.setString(2, fltno);
			pstmt.setString(3, sect);

			ArrayList al = null;
			rs = pstmt.executeQuery();
			while (rs.next()) {
				if (al == null)
					al = new ArrayList();
				PADataObj obj = new PADataObj();
				obj.setSeqno(rs.getString("seqno"));
				obj.setEmpno(rs.getString("empno"));

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

	/**
	 * 取得 Duty 為PA 之組員員工號名單
	 * 
	 */
	public void SelectCrewDutyList() throws Exception 
	{
		if (fltd == null | fltno == null | sect == null)
		{
			throw new NullPointerException("Parameter missed!!");
		}
		
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

			if (psrEmpno != null) 
			{
			    sql = "SELECT * FROM egtcflt WHERE fltd=To_Date(?,'yyyy/mm/dd') "
					+ "AND fltno=? AND sect=? AND psrempn=?";
			    
				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, fltd);
				pstmt.setString(2, fltno);
				pstmt.setString(3, sect);
				pstmt.setString(4, psrEmpno);
			} 
			else 
			{
			    sql = "SELECT * FROM egtcflt WHERE fltd=To_Date(?,'yyyy/mm/dd') "
					+ "AND fltno=? AND sect=? ";
				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, fltd);
				pstmt.setString(2, fltno);
				pstmt.setString(3, sect);

			}

			rs = pstmt.executeQuery();
			ArrayList al = null;
			while (rs.next()) 
			{
				for (int i = 1; i <= 20; i++) 
				{
					if ("PA".equals(rs.getString("duty" + i))) 
					{
						if (al == null)
						{
							al = new ArrayList();
						}
						
						al.add(rs.getString("empn" + i).trim());
					}
				}
			}

			setPADutyList(al);
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

	/**
	 * 
	 * 刪除錯誤（多餘）PA 資料
	 */
	public void DeleteErrorData() throws Exception {

		// 刪除Duty=PA者,剩餘的為錯誤（多餘）的PA資料
		// =>依據dataAL剩餘的資料seqno,刪除PA考評資料

		if (paDutyList != null) {
			for (int i = 0; i < paDutyList.size(); i++) {
				String paEmpno = (String) paDutyList.get(i);
				if (dataAL != null) {

					for (int index = 0; index < dataAL.size(); index++) {
						PADataObj o = (PADataObj) dataAL.get(index);
						if (paEmpno.equals(o.getEmpno())) {
							dataAL.remove(index);

							index--;
						}
					}
				}
			}
		}

		if (dataAL.size() > 0) 
		{ // 刪除資料

			Connection conn = null;
			PreparedStatement pstmt = null;

			ConnDB cn = new ConnDB();
			Driver dbDriver = null;
			try 
			{
				cn.setORP3EGUserCP();
				dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
				conn = dbDriver.connect(cn.getConnURL(), null);
				conn.setAutoCommit(false);

				for (int index = 0; index < dataAL.size(); index++) 
				{
					PADataObj o = (PADataObj) dataAL.get(index);

					pstmt = conn.prepareStatement("delete egtpads where seqno=?");
					pstmt.setString(1, o.getSeqno());

					pstmt.executeUpdate();
					pstmt.close();

					pstmt = conn.prepareStatement("delete egtpadm where seqno=?");
					pstmt.setString(1, o.getSeqno());

					pstmt.executeUpdate();
					pstmt.close();

				}
				conn.commit();

				pstmt.close();
				conn.close();

			} catch (SQLException e) {
				try {
					// 有錯誤時 rollback
					conn.rollback();
				} catch (SQLException e1) {
					System.out.println(e1.getMessage());
				}

			} catch (Exception e) {
				try {
					// 有錯誤時 rollback
					conn.rollback();
				} catch (SQLException e1) {
					System.out.println(e1.getMessage());
				}
			} finally {
				if (pstmt != null)
					try {
						pstmt.close();
					} catch (SQLException e) {
						System.out.println(e.getMessage());
					}
				if (conn != null) {
					try {
						conn.close();
					} catch (SQLException e) {
						System.out.println(e.getMessage());
					}
					conn = null;
				}
			}
		}

	}

	public void job() throws Exception {
		SelectPAData();
		SelectCrewDutyList();
		DeleteErrorData();
	}

	public ArrayList getDataAL() {
		return dataAL;
	}

	private void setDataAL(ArrayList dataAL) {
		this.dataAL = dataAL;
	}

	public ArrayList getPADutyList() {
		return paDutyList;
	}

	private void setPADutyList(ArrayList paDutyList) {
		this.paDutyList = paDutyList;
	}

}

class PADataObj {
	private String seqno;
	private String empno;

	public String getEmpno() {
		return empno;
	}
	public void setEmpno(String empno) {
		this.empno = empno;
	}
	public String getSeqno() {
		return seqno;
	}
	public void setSeqno(String seqno) {
		this.seqno = seqno;
	}

}
