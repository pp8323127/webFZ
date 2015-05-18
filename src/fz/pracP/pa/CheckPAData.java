package fz.pracP.pa;

import java.sql.*;
import java.util.*;
import ci.db.*;

/**
 * CheckPA 組員Duty = 'PA' 時必須輸入PA考評
 * 
 * 
 * @author cs71
 * @version 1.0 2008/07/29
 * 
 * Copyright: Copyright (c) 2008
 */
public class CheckPAData {

	 public static void main(String[] args) 
	 {
		 String[] empno = {"631585", "634492"};
		
		 String[] duty = {"PA", ""};
		 fz.pracP.pa.CheckPAData chkPA = new fz.pracP.pa.CheckPAData("2008/07/29",
		 "0061", "TPEFRA", "631451", null, null);
		 chkPA.SelectData();
	
		 if (chkPA.isHasPA()) 
		 {
		     System.out.println("有PA:" + chkPA.getPaEmpno());
			 if (!chkPA.isPAEvaluated()) 
			 {
			     System.out.println("尚未考評PA");
			 } 
			 else 
			 {
			     System.out.println("ok");
			 }
		
			 chkPA.deleteData();
			 System.out.println("刪除PA資料");
		 } 
		 else 
		 {
		     System.out.println("無PA");
		 }
	 }

	private String fdate;// format: yyyy/mm/dd
	private String fltno;
	private String sect;
	private String purserEmpno;
	private String[] crewEmpno;
	private String[] crewDuty;
	private String paEmpno;
	private boolean hasPA = false;
	private boolean isPAEvaluated = false;
	private String seqno;
	ArrayList seqnoAL = new ArrayList();

	/**
	 * @param fdate
	 *            日期
	 * @param fltno
	 *            班號
	 * @param sect
	 *            航段
	 * @param purserEmpno
	 *            座艙長員工號
	 * @param crewEmpno
	 *            組員員工號陣列
	 * @param crewDuty
	 *            組員Duty陣列
	 */
	public CheckPAData(String fdate, String fltno, String sect,
			String purserEmpno, String[] crewEmpno, String[] crewDuty) 
	{
		this.fdate = fdate;
		this.fltno = fltno;
		this.sect = sect;
		this.purserEmpno = purserEmpno;
		this.crewDuty = crewDuty;
		this.crewEmpno = crewEmpno;
		setHasPA();
	}

	public boolean isHasPA() 
	{
		return hasPA;
	}

	private void setHasPA() 
	{
		if (crewDuty != null) 
		{
			for (int i = 0; i < crewDuty.length; i++) 
			{
				if ("PA".equals(crewDuty[i])) 
				{
					this.hasPA = true;
					setPaEmpno(this.crewEmpno[i]);
				}
			}
		}
	}

	public void SelectData() 
	{
		if (crewDuty == null) 
		{
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			ConnDB cn = new ConnDB();
			Driver dbDriver = null;

			try 
			{
				cn.setORP3EGUserCP();
				dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
				conn = dbDriver.connect(cn.getConnURL(), null);
	

				pstmt = conn.prepareStatement("SELECT * FROM egtpadm "
						+ "WHERE fltd=To_Date(?,'yyyy/mm/dd') "
						+ "AND fltno=? AND sect = ?");

				pstmt.setString(1, fdate);
				pstmt.setString(2, fltno);
				pstmt.setString(3, sect);

				rs = pstmt.executeQuery();
//				if (rs.next()) 
				while (rs.next()) 
				{
					setPAEvaluated(true);
					this.hasPA = true;
					//seqno = rs.getString("seqno");
					setPaEmpno(rs.getString("empno"));
					seqno = rs.getString("seqno");
					seqnoAL.add(rs.getString("seqno"));			
				}

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
						System.out.println(e.toString());
					}
					conn = null;
				}
			}
		} 
		else if (crewDuty != null && isHasPA()) 
		{

			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			ConnDB cn = new ConnDB();
			Driver dbDriver = null;

			try 
			{
				cn.setORP3EGUserCP();
				dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
				conn = dbDriver.connect(cn.getConnURL(), null);

				
				pstmt = conn.prepareStatement("SELECT * FROM egtpadm "
						+ "WHERE fltd=To_Date(?,'yyyy/mm/dd') "
						+ "AND fltno=? AND sect = ? and empno=?");

				pstmt.setString(1, fdate);
				pstmt.setString(2, fltno);
				pstmt.setString(3, sect);
				pstmt.setString(4, paEmpno);

				rs = pstmt.executeQuery();
				while (rs.next()) 
				{
					setPAEvaluated(true);
					seqno = rs.getString("seqno");
					seqnoAL.add(rs.getString("seqno"));			
				}

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
						System.out.println(e.toString());
					}
					conn = null;
				}
			}
		}
	}  

	public void deleteData() {
 
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ConnDB cn = new ConnDB();
		Driver dbDriver = null;

		try 
		{
			cn.setORP3EGUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);


			if (isHasPA()) 
			{
			    for(int i=0; i<seqnoAL.size(); i++)
			    {
					pstmt = conn.prepareStatement("delete egtpads where seqno=?");
					pstmt.setString(1, (String)seqnoAL.get(i));// seqno
	
					pstmt.executeUpdate();
					pstmt.close();
	
					pstmt = conn.prepareStatement("delete egtpadm where seqno=?");
					pstmt.setString(1, (String)seqnoAL.get(i));// seqno
	
					pstmt.executeUpdate();
					pstmt.close();
			    }

			}
			else
			{
				String seqno = null;
				pstmt = conn.prepareStatement("SELECT * FROM egtpadm "
						+ "WHERE fltd=To_Date(?,'yyyy/mm/dd') "
						+ "AND fltno=? AND sect = ?");

				pstmt.setString(1, fdate);
				pstmt.setString(2, fltno);
				pstmt.setString(3, sect);

				rs = pstmt.executeQuery();
				while (rs.next()) 
				{
					seqno = rs.getString("seqno");	
					seqnoAL.add(rs.getString("seqno"));			
				}
				pstmt.close();
				rs.close();
				
				if(seqno != null)
				{
				    for(int i=0; i<seqnoAL.size(); i++)
				    {
						pstmt = conn.prepareStatement("delete egtpads where seqno=?");
						pstmt.setString(1, (String)seqnoAL.get(i));// seqno
	
						pstmt.executeUpdate();
						pstmt.close();
	
						pstmt = conn.prepareStatement("delete egtpadm where seqno=?");
						pstmt.setString(1, (String)seqnoAL.get(i));// seqno
	
						pstmt.executeUpdate();
						pstmt.close();
				    }
				}
				
			}
			pstmt.close();

			conn.close();

		} catch (Exception e) {

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
					System.out.println(e.toString());
				}
				conn = null;
			}
		}

	}

	public boolean isPAEvaluated() {
		return isPAEvaluated;
	}

	private void setPAEvaluated(boolean isPAEvaluated) {
		this.isPAEvaluated = isPAEvaluated;
	}

	public String getPaEmpno() {
		return paEmpno;
	}

	private void setPaEmpno(String paEmpno) {
		this.paEmpno = paEmpno;
	}

}
