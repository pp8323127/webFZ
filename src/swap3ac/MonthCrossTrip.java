package swap3ac;

import java.sql.*;

import ci.db.*;

/**
 * MonthCrossTrip ���o���Z���󥻤몺����(�H�խ��C�魸�ɸ�Ƭ���ǡA����trip�ɼ�)
 * 
 * @author cs66
 * @version 1.0 2006/2/7
 * @version 1.1 2008/1/29 Credit hour�ܧ���쬰 crew_cum_hr_cc_v.Sum(non_std_fly_hours),�쬰 rem_fh_28
 * 
 * Copyright: Copyright (c) 2006
 */
public class MonthCrossTrip {

	public static void main(String[] args) {
		MonthCrossTrip mct = new MonthCrossTrip("2012", "06", "2181300", "630397");
		try {
			mct.initData();
			System.out.println("�O�_�����G" + mct.isCrossMonth());
			if (mct.isCrossMonth()) {
				System.out.println("����CR:" + mct.getTripInthisMonthCr());
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private String tripno;
	private String year;
	private String month;
	private String empno;
	private boolean isCrossMonth = false; // �O�_���
	private String tripInthisMonthCr;// ��trip�b���뤺������

	public MonthCrossTrip(String year, String month, String tripno, String empno) 
	{
		this.tripno = tripno;
		this.year = year;
		this.month = month;
		this.empno = empno;
	}

	public void initData() throws SQLException, Exception 
	{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
//		ConnAOCI ca = new ConnAOCI();
		ConnDB cn = new ConnDB();
		Driver dbDriver = null;
		try 
		{

			// �����s�u
//			ca.setAOCIFZUser();	
//			java.lang.Class.forName(ca.getDriver());
//			conn = DriverManager.getConnection(ca.getConnURL(), ca.getConnID(),	ca.getConnPW());
			
//			cn.setAOCIPROD();
//			java.lang.Class.forName(cn.getDriver());
//			conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),	cn.getConnPW());
			
			cn.setAOCIPRODCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);
			
			// ���P�_�O�_���,�YcrMthCt>0 ,�h�����
			pstmt = conn.prepareStatement("SELECT Count(*) crMthCt FROM ( "
					+ "SELECT Max(end_dt_tm_gmt) dt FROM  duty_prd_seg_v  r "
					+ "WHERE r.series_num=? "
					+ "AND duty_cd NOT IN ('RST' ,'LO','TVL')) a "
					+ "WHERE a.dt >  Last_Day(To_Date('" + year + month
					+ "01 2359','yyyymmdd hh24mi'))");
			
//System.out.println("SELECT Count(*) crMthCt FROM ( "
//		+ "SELECT Max(end_dt_tm_gmt) dt FROM  duty_prd_seg_v  r "
//		+ "WHERE r.series_num='"+tripno+"' "
//		+ "AND duty_cd NOT IN ('RST' ,'LO','TVL')) a "
//		+ "WHERE a.dt >  Last_Day(To_Date('" + year + month
//		+ "01 2359','yyyymmdd hh24mi'))");			

			pstmt.setString(1, tripno);

			rs = pstmt.executeQuery();
			int crMthCt = 0;
			while (rs.next()) 
			{
				crMthCt = rs.getInt("crMthCt");
			}

			if (crMthCt > 0) {
				setCrossMonth(true);
				String str_dt = null;
				// �����o��trip�Ĥ@�q���_���ɶ��]tpe time�^
				pstmt = conn.prepareStatement("SELECT To_Char(str_dt_tm_gmt,'yyyymmdd') str_dt "
								+ "FROM  duty_prd_seg_v   r WHERE r.series_num=?  AND duty_seq_num=1 AND item_seq_num=1");
				
//System.out.println("SELECT To_Char(str_dt_tm_gmt,'yyyymmdd') str_dt "
//		+ "FROM  duty_prd_seg_v   r WHERE r.series_num='"+tripno+"'  AND duty_seq_num=1 AND item_seq_num=1");
				
				pstmt.setString(1, tripno);
				rs = pstmt.executeQuery();
				while (rs.next()) 
				{
					str_dt = rs.getString("str_dt");
				}

				// �A���o��trip�Ĥ@�q�ܤ멳��total cr (in min)
				pstmt = conn.prepareStatement("SELECT Sum(non_std_fly_hours) cr FROM crew_cum_hr_cc_v "
								+ "WHERE staff_num =? AND  cal_dt BETWEEN To_Date('"
								+ str_dt
								+ " 0000','yyyymmdd hh24mi') AND   Last_Day(To_Date('"
								+ year
								+ month
								+ "01 2359','yyyymmdd hh24mi')) ORDER BY cal_dt");
				
				pstmt.setString(1, empno);
//System.out.println("SELECT Sum(non_std_fly_hours) cr FROM crew_cum_hr_cc_v "
//		+ "WHERE staff_num ='"+empno+"' AND  cal_dt BETWEEN To_Date('"
//		+ str_dt
//		+ " 0000','yyyymmdd hh24mi') AND   Last_Day(To_Date('"
//		+ year
//		+ month
//		+ "01 2359','yyyymmdd hh24mi')) ORDER BY cal_dt");	
			
				//***********************************************************************************
				//�Htrip �d��CR
				//���L�k����
//				pstmt = conn.prepareStatement("SELECT Sum(act_fl_hr) cr FROM trip_duty_prd_v WHERE trip_num = ? "
//				        + "AND act_str_dt_tm_gmt BETWEEN To_Date('"
//						+ str_dt
//						+ " 0000','yyyymmdd hh24mi') AND   Last_Day(To_Date('"
//						+ year
//						+ month
//						+ "01 2359','yyyymmdd hh24mi')) ORDER BY act_str_dt_tm_gmt ");
//				
//				pstmt.setString(1, tripno);
				
//System.out.println("SELECT Sum(act_fl_hr) cr FROM trip_duty_prd_v WHERE trip_num = '"+tripno+"' "
//        + "AND act_str_dt_tm_gmt BETWEEN To_Date('"
//		+ str_dt
//		+ " 0000','yyyymmdd hh24mi') AND   Last_Day(To_Date('"
//		+ year
//		+ month
//		+ "01 2359','yyyymmdd hh24mi')) ORDER BY cal_dt");	
				//***********************************************************************************
				rs = pstmt.executeQuery();
				while (rs.next()) 
				{
					setTripInthisMonthCr(rs.getString("cr"));
//System.out.println(getTripInthisMonthCr()+ " sql  "+rs.getString("cr"));
				}
			}

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

	public boolean isCrossMonth() {
		return isCrossMonth;
	}

	public void setCrossMonth(boolean isCrossMonth) {
		this.isCrossMonth = isCrossMonth;
	}

	public String getTripInthisMonthCr() {
		return tripInthisMonthCr;
	}

	public void setTripInthisMonthCr(String tripInthisMonthCr) {
		this.tripInthisMonthCr = tripInthisMonthCr;
	}
}