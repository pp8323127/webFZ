package fz.pracP.zc;

import java.sql.*;
import java.util.*;

import ci.db.*;

/**
 * DeleteErrorZCData �R���h�l��ZC���
 * 
 * 
 * @author cs66
 * @version 1.0 2007/3/16
 * 
 * Copyright: Copyright (c) 2007
 */
public class DeleteErrorZCData {
	private String fltd;// ���,format: yyyy/mm/dd
	private String fltno;// ��Z��
	private ArrayList dataAL;
	private String sect;// �Ϭq
	private String psrEmpno;// �y�������u��
	private ArrayList zcDutyList;// ZC���u��

	// public static void main(String[] args) {
	// String fdate = "2007/03/16";
	// String fltno = "0006";
	// String sect = "TPELAX";
	// String purserEmpno = "628503";
	//
	// fz.pracT.zc.DeleteErrorZCData delZC = new fz.pracT.zc.DeleteErrorZCData(
	// fdate, fltno, sect, purserEmpno);
	// try {
	// delZC.job();
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
	public DeleteErrorZCData(String fltd, String fltno, String sect,
			String psrEmpno) {
		this.fltd = fltd;
		this.fltno = fltno;
		this.sect = sect;
		this.psrEmpno = psrEmpno;
	}

	/**
	 * 
	 * ���oZC�ҵ����
	 */
	public void SelectZCData() throws Exception {
		if (fltd == null | fltno == null | sect == null)
			throw new NullPointerException("Parameter missed!!");

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ConnDB cn = new ConnDB();
		Driver dbDriver = null;
		try {
			cn.setORP3EGUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);

			pstmt = conn
					.prepareStatement("SELECT seqno,empno "
							+ "FROM egtzcdm  "
							+ "where fltd=to_date(?,'yyyy/mm/dd') and fltno=? and sect=? ");

			pstmt.setString(1, fltd);
			pstmt.setString(2, fltno);
			pstmt.setString(3, sect);

			ArrayList al = null;
			rs = pstmt.executeQuery();
			while (rs.next()) {
				if (al == null)
					al = new ArrayList();
				ZCDataObj obj = new ZCDataObj();
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
	 * ���o Duty ��ZC ���խ����u���W��
	 * 
	 */
	public void SelectCrewDutyList() throws Exception {
		if (fltd == null | fltno == null | sect == null)
			throw new NullPointerException("Parameter missed!!");

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ConnDB cn = new ConnDB();
		Driver dbDriver = null;
		try {
			cn.setORP3EGUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);

			if (psrEmpno != null) {
				pstmt = conn
						.prepareStatement("SELECT * FROM egtcflt WHERE fltd=To_Date(?,'yyyy/mm/dd') "
								+ "AND fltno=? AND sect=? AND psrempn=?");

				pstmt.setString(1, fltd);
				pstmt.setString(2, fltno);
				pstmt.setString(3, sect);
				pstmt.setString(4, psrEmpno);
			} else {
				pstmt = conn
						.prepareStatement("SELECT * FROM egtcflt WHERE fltd=To_Date(?,'yyyy/mm/dd') "
								+ "AND fltno=? AND sect=? ");

				pstmt.setString(1, fltd);
				pstmt.setString(2, fltno);
				pstmt.setString(3, sect);

			}

			rs = pstmt.executeQuery();
			ArrayList al = null;
			while (rs.next()) {
				for (int i = 1; i <= 20; i++) {
					if ("ZC".equals(rs.getString("duty" + i))) {
						if (al == null)
							al = new ArrayList();

						al.add(rs.getString("empn" + i).trim());

					}
				}
			}

			setZcDutyList(al);
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
	 * �R�����~�]�h�l�^ZC ���
	 */
	public void DeleteErrorData() throws Exception {

		// �R��Duty=ZC��,�Ѿl�������~�]�h�l�^��ZC���
		// =>�̾�dataAL�Ѿl�����seqno,�R��ZC�ҵ����

		if (zcDutyList != null) {
			for (int i = 0; i < zcDutyList.size(); i++) {
				String zcEmpno = (String) zcDutyList.get(i);
				if (dataAL != null) {

					for (int index = 0; index < dataAL.size(); index++) {
						ZCDataObj o = (ZCDataObj) dataAL.get(index);
						if (zcEmpno.equals(o.getEmpno())) {
							dataAL.remove(index);

							index--;
						}
					}
				}
			}
		}

		if (dataAL.size() > 0) { // �R�����

			Connection conn = null;
			PreparedStatement pstmt = null;

			ConnDB cn = new ConnDB();
			Driver dbDriver = null;
			try {
				cn.setORP3EGUserCP();
				dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
				conn = dbDriver.connect(cn.getConnURL(), null);

				conn.setAutoCommit(false);

				for (int index = 0; index < dataAL.size(); index++) {
					ZCDataObj o = (ZCDataObj) dataAL.get(index);

					pstmt = conn
							.prepareStatement("delete egtzcds where seqno=?");
					pstmt.setString(1, o.getSeqno());

					pstmt.executeUpdate();
					pstmt.close();

					pstmt = conn
							.prepareStatement("delete egtzcdm where seqno=?");
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
		SelectZCData();
		SelectCrewDutyList();
		DeleteErrorData();
	}

	public ArrayList getDataAL() {
		return dataAL;
	}

	private void setDataAL(ArrayList dataAL) {
		this.dataAL = dataAL;
	}

	public ArrayList getZcDutyList() {
		return zcDutyList;
	}

	private void setZcDutyList(ArrayList zcDutyList) {
		this.zcDutyList = zcDutyList;
	}

}

class ZCDataObj {
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
