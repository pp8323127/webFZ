package fz.pracP.pa;

import java.sql.*;
import java.util.*;
import ci.db.*;

/**
 * DeleteErrorPAData �R���h�l��PA���
 * 
 * 
 * @author cs71
 * @version 1.0 2008/07/10
 * 
 * Copyright: Copyright (c) 2008
 */
public class DeleteErrorPAData {
	private String fltd;// ���,format: yyyy/mm/dd
	private String fltno;// ��Z��
	private ArrayList dataAL;
	private String sect;// �Ϭq
	private String psrEmpno;// �y�������u��
	private ArrayList paDutyList;// PA���u��

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
	 *            �i��null��
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
	 * ���oPA�ҵ����
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
	 * ���o Duty ��PA ���խ����u���W��
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
	 * �R�����~�]�h�l�^PA ���
	 */
	public void DeleteErrorData() throws Exception {

		// �R��Duty=PA��,�Ѿl�������~�]�h�l�^��PA���
		// =>�̾�dataAL�Ѿl�����seqno,�R��PA�ҵ����

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
		{ // �R�����

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
					// �����~�� rollback
					conn.rollback();
				} catch (SQLException e1) {
					System.out.println(e1.getMessage());
				}

			} catch (Exception e) {
				try {
					// �����~�� rollback
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
