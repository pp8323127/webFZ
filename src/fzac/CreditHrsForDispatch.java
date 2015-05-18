package fzac;

import java.sql.*;

import ci.db.*;

/**
 * @author cs66 ���o�῵�խ� Credit Hours
 * 
 * DB: AirCrews
 * 
 * @version 1.0 2006/3/23
 * 
 * Copyright: Copyright (c) 2006
 */
public class CreditHrsForDispatch 
{
	 public static void main(String[] args) {
	 CreditHrsForDispatch cr = new CreditHrsForDispatch("638185", "200901");
	 cr.SelectSingleCrew();
	 System.out.println("CR (HHMM) = "+cr.getCrewCRinHHMM());
	 System.out.println("CR (Hours)= "+cr.getCrewCRinHours());
	 System.out.println("CR (mins) = "+cr.getCrewCrinMin());
	 }

	private String empno;
	private String yearMonth;
	private String crewCRinHHMM;
	private String crewCRinHours;
	private String crewCrinMin;

	/**
	 * @param empno
	 *            ���u��
	 * @param yearMonth
	 *            format: yyyymm
	 */
	public CreditHrsForDispatch(String empno, String yearMonth) {
		this.empno = empno;
		this.yearMonth = yearMonth;
	}

	/**
	 * 
	 * ���o��@�խ������Credit Hours
	 * 
	 */
	public void SelectSingleCrew() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
//		 ConnAOCI cna = new ConnAOCI();
		ConnDB cn = new ConnDB();
		Driver dbDriver = null;

		try {
			// User connection pool
			cn.setAOCIPRODCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);

			// �����s�u
//			 cna.setAOCIFZUser();
//			 java.lang.Class.forName(cna.getDriver());
//			 conn = DriverManager.getConnection(cna.getConnURL(), cna
//			 .getConnID(), cna.getConnPW());

			sql = " SELECT staff_num, sum(non_std_fly_hours) totalcr FROM crew_cum_hr_cc_v c  " +
				  " WHERE staff_num = ? AND  c.cal_dt  BETWEEN To_Date(?,'yyyymmdd hh24mi')  " +
				  " AND Last_Day(To_Date(?,'yyyymmdd hh24mi')) GROUP BY  staff_num ";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, empno);
			pstmt.setString(2, yearMonth+"01 0000");
			pstmt.setString(3, yearMonth+"01 2359");
			
			rs = pstmt.executeQuery();
			String min = "0";
			while (rs.next()) 
			{
				min = rs.getString("totalcr");
			}
			
			setCrewCrinMin(min);

		} catch (SQLException e) {
			System.out.print(e.toString());
		} catch (Exception e) {
			System.out.print(e.toString());
		} finally {

			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException e) {}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException e) {}

		}

	}
	/**
	 * ���o�Ҧ��խ�����뭸��
	 * 
	 */
	// public void SelectAllData() {
	//
	// }
	/**
	 * 
	 * @return �խ�Credir Hours, format: hhmm
	 * 
	 */
	public String getCrewCRinHHMM() {
		return crewCRinHHMM;
	}

	private void setCrewCRinHHMM(String crewCRinHHMM) {
		this.crewCRinHHMM = crewCRinHHMM;
	}

	/**
	 * 
	 * @return �խ�Credir Hours, format: hours
	 * 
	 */
	public String getCrewCRinHours() {
		return crewCRinHours;
	}

	private void setCrewCRinHours(String crewCRinHours) {
		this.crewCRinHours = crewCRinHours;
	}

	public String getCrewCrinMin() {
		return crewCrinMin;
	}

	/**
	 * 
	 * @param crewCrinMin
	 *            �խ����credit hours in minitues
	 * 
	 */
	private void setCrewCrinMin(String crewCrinMin) {
		this.crewCrinMin = crewCrinMin;
		setCrewCRinHHMM(ci.tool.TimeUtil.minToHHMM(crewCrinMin));
		setCrewCRinHours(ci.tool.TimeUtil.minToHours(3, crewCrinMin));
	}

}
