package fzac;

import java.sql.*;

import ci.db.*;
import ci.tool.*;

/**
 * CrewInfo ���o�խ��ӤH�򥻸��.
 * 
 * @author cs66
 * @version 1.0 2006/2/11
 * 
 * Copyright: Copyright (c) 2006
 */
public class CrewInfo {
	//
	 public static void main(String[] args) {
	 CrewInfo c = new CrewInfo("635863");
	 CrewInfoObj o = c.getCrewInfo();
	 System.out.println("�O�_����ơH" + c.isHasData());
	 if (c.isHasData()) {
	 System.out.println(o.getEmpno() + "\t" + o.getEname());
	 }
	
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
		ConnDB cn = new ConnDB();
		 ConnAOCI cna = new ConnAOCI();

		Driver dbDriver = null;

		try {
			// User connection pool
			 cn.setAOCIPRODCP();
			 dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			 conn = dbDriver.connect(cn.getConnURL(), null);

			// �����s�u
//			 cna.setAOCIFZUser();
//			 java.lang.Class.forName(cna.getDriver());
//			 conn = DriverManager.getConnection(cna.getConnURL() ,cna.getConnID() ,cna.getConnPW());

			sql = "SELECT  c.staff_num,c.preferred_name cname,"
					+ "c.section_number grp,LTrim(c.seniority_code,'0') sern,"
					+ "c.other_surname||' '||c.other_first_name ename,crank.Rank_cd rank_cd ,base.base base ,"
					+ "c.section_number grp,p.fd_ind  "
					+ "FROM crew_rank_v crank, crew_v c, rank_tp_v p,crew_base_v base "
					+ "WHERE c.staff_num = crank.staff_num "
					+ "AND c.staff_num = base.staff_num "
					+ "AND crank.rank_cd= p.display_rank_cd "
					+ "AND (base.exp_dt>SYSDATE OR base.exp_dt IS NULL) "
					+"AND base.eff_dt<= sysdate "
					+ "AND base.prim_base='Y' ";
			if (empno.length() != 6) {// �H�Ǹ��d��
				sql += "AND lTrim(c.seniority_code,'0')=?";
			} else {
				sql += "AND c.staff_num=?";
			}
			
//System.out.println(sql);			
			// ���o�խ��ӤH���
			pstmt = conn.prepareStatement(sql);

			// �ӽЪ�
			pstmt.setString(1, empno);

			rs = pstmt.executeQuery();

			CrewInfoObj obj = null;
			int totalCr = 0;
			CrewInfoObj o1 = null;
			while (rs.next()) 
			{
				o1 = new CrewInfoObj();
				o1.setEmpno(rs.getString("staff_num"));
				o1.setCname(UnicodeStringParser.removeExtraEscape(rs.getString("cname")));
				o1.setEname(rs.getString("ename"));
				o1.setBase(rs.getString("base"));
				o1.setOccu(rs.getString("rank_cd"));
				o1.setSern(rs.getString("sern"));
				o1.setGrp(rs.getString("grp"));
				o1.setFd_ind(rs.getString("fd_ind"));
				setHasData(true);
			}
			setCrewInfo(o1);

		} catch (SQLException e) {
			// e.printStackTrace();
			System.out.print("fzac.CrewInfo error: "+e.toString()+"empno="+empno);
		} catch (Exception e) {
			System.out.print("fzac.CrewInfo error: "+e.toString());
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