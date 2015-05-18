package eg.crewbasic;

import java.sql.*;
import ci.db.*;

/**
 * CrewInfo ���o�խ��ӤH�򥻸��.
 * 
 * @author cs66
 * @version 1.0 2006/2/11
 * 
 * Copyright: Copyright (c) 2006
 */
public class CrewInfo 
{
	//
	 public static void main(String[] args) 
	 {
		 CrewInfo c = new CrewInfo("638918");
//		 CrewInfoObj o = c.getCrewInfo();
//		 System.out.println("�O�_����ơH" + c.isHasData());
//		 if (c.isHasData()) 
//		 {
//		     System.out.println(o.getEmpno() + "\t" + o.getEname());
//		 }	
	 }

	private CrewInfoObj crewInfo;
	private String empno;
	private boolean hasData = false;

	/**
	 * @param empno
	 *            �Ǹ��έ��u�����i.�P�_����G����ƫh�����u��
	 */
	public CrewInfo(String empno) {
		this.empno = empno;
		try {
			SelectData();
		} catch (SQLException e) {
			System.out.println(e.toString());
		} catch (Exception e) {
			System.out.println(e.toString());
		}
	}

	public void SelectData() throws SQLException, Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		EGConnDB cn = new EGConnDB();

		Driver dbDriver = null;

		try 
		{
			// User connection pool
			cn.setEGUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);

			// �����s�u

//			 cn.setORP3EGUser();
//			 java.lang.Class.forName(cn.getDriver());
//			 conn = DriverManager.getConnection(cn.getConnURL() ,cn.getConnID() ,cn.getConnPW());

			sql = " SELECT  Trim(empn) staff_num,cname, section grp, sern, ename, station base FROM egtcbas " +
				  " where trim(empn) = ? or sern = ? ";
						// ���o�խ��ӤH���
			pstmt = conn.prepareStatement(sql);

			// �ӽЪ�
			pstmt.setString(1, empno);
			pstmt.setString(2, empno);

			rs = pstmt.executeQuery();

			CrewInfoObj obj = null;
			int totalCr = 0;
			CrewInfoObj o1 = null;
			while (rs.next()) 
			{
				o1 = new CrewInfoObj();
				o1.setEmpno(rs.getString("staff_num"));
				o1.setCname(rs.getString("cname"));
				o1.setEname(rs.getString("ename"));
				o1.setBase(rs.getString("base"));
				o1.setSern(rs.getString("sern"));
				o1.setGrp(rs.getString("grp"));
				setHasData(true);
			}
			setCrewInfo(o1);

		} catch (SQLException e) {
			// e.printStackTrace();
			System.out.print("eg.crewbasic.CrewInfo error: "+e.toString()+"empno="+empno);
		} catch (Exception e) {
			System.out.print("eg.crewbasic.CrewInfo error: "+e.toString());
			// e.printStackTrace();
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


	public CrewInfoObj getCrewInfo() {
		return crewInfo;
	}

	public void setCrewInfo(CrewInfoObj obj) {
		this.crewInfo = obj;
	}

	public boolean isHasData() {
		return hasData;
	}

	public void setHasData(boolean hasData) {
		this.hasData = hasData;
	}
}