package fz.psfly;

import java.sql.*;
import ci.db.*;

/**
 * @author cs71
 * @version 1.0 2008/07/29
 * 
 * Copyright: Copyright (c) 2008
 */
public class CheckPSFLYData {

	 public static void main(String[] args) 
	 {
	     CheckPSFLYData chksfly = new CheckPSFLYData("2008/11/05","0052", "SYDTPE", "631451");
	     System.out.println(chksfly.hasData());
	     
//		 String[] empno = {"631585", "634492"};
//		
//		 String[] duty = {"PA", ""};
//		 fz.pracP.pa.CheckPAData chkPA = new fz.pracP.pa.CheckPAData("2008/07/29",
//		 "0061", "TPEFRA", "631451", null, null);
//		 chkPA.SelectData();
//	
//		 if (chkPA.isHasPA()) 
//		 {
//		     System.out.println("有PA:" + chkPA.getPaEmpno());
//			 if (!chkPA.isPAEvaluated()) 
//			 {
//			     System.out.println("尚未考評PA");
//			 } 
//			 else 
//			 {
//			     System.out.println("ok");
//			 }
//		
//			 chkPA.deleteData();
//			 System.out.println("刪除PA資料");
//		 } 
//		 else 
//		 {
//		     System.out.println("無PA");
//		 }
	 }

	private String fdate;// format: yyyy/mm/dd
	private String fltno;
	private String sect;
	private String purserEmpno;	
	private boolean haspsfly = false;

	/**
	 * @param fdate
	 *            日期
	 * @param fltno
	 *            班號
	 * @param sect
	 *            航段
	 * @param purserEmpno
	 *            座艙長員工號	 
	 */
	public CheckPSFLYData(String fdate, String fltno, String sect,String purserEmpno) 
	{
		this.fdate = fdate;
		this.fltno = fltno;
		this.sect = sect;
		this.purserEmpno = purserEmpno;
	}
	
	public boolean hasData() 
	{ 
		Connection conn = null;
		PreparedStatement pstmt = null;
		Statement stmt = null;
		ResultSet rs = null;
		Driver dbDriver = null;
		String sql = "";
		boolean returnstr = false;

		try 
		{
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();

			sql = " select count(*) c FROM egtprsf  WHERE fltdt = To_Date(?,'yyyy/mm/dd') " +
				  " AND fltno = ? AND sect = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, fdate);
			pstmt.setString(2, fltno);
			pstmt.setString(3, sect);	
			rs = pstmt.executeQuery();
			
			int count =0;
			if(rs.next())
			{
			   count = rs.getInt("c");
			}
			
			if(count > 0 )
			{
			    returnstr = true;
			}
		} 
		catch (Exception e) 
		{
		    return returnstr;
		} 
		finally 
		{
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
					System.out.println(e.toString());
				}
				conn = null;
			}
		}
		
		return returnstr;
	}
	
	public void deleteData() 
	{ 
		Connection conn = null;
		PreparedStatement pstmt = null;
		Statement stmt = null;
		ResultSet rs = null;
		Driver dbDriver = null;
		String sql = "";

		try 
		{
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();	

			sql = " delete FROM egtprsf  WHERE fltdt = To_Date(?,'yyyy/mm/dd') " +
				  " AND fltno = ? AND sect = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, fdate);
			pstmt.setString(2, fltno);
			pstmt.setString(3, sect);	
			pstmt.executeUpdate();
			pstmt.close();	
		} 
		catch (Exception e) 
		{

		} 
		finally 
		{
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException e) {}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					System.out.println(e.toString());
				}
				conn = null;
			}
		}

	}
}
