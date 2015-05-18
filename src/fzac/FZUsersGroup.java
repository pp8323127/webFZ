package fzac;

import java.sql.*;
import java.util.*;

import ci.db.*;

/**
 * FZUsersGroup 取得User所屬之群組
 * 
 * TABLE: FZDB.FZTUIDG
 * 
 * @author cs66
 * @version 1.0 2007/1/10
 * 
 * Copyright: Copyright (c) 2007
 */
public class FZUsersGroup {

//	public static void main(String[] args) {
//		FZUsersGroup fzUser = new FZUsersGroup("640073");
//		ArrayList al =null;
//		try {
//			fzUser.SelectData();
//			al =fzUser.getGroupAL(); 
//			
//		} catch (SQLException e) {
//			e.printStackTrace();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//
//		 
//		if (al != null) {
//
//			for (int i = 0; i < al.size(); i++) {
//				System.out.println(al.get(i));
//
//			}
//		} else {
//
//			System.out.println("no data!!");
//		}
//	
//	}

	private String userid;
	private ArrayList groupAL;

	public FZUsersGroup(String userid) {
		this.userid = userid;

	}

	public void SelectData() throws SQLException, Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		ConnDB cn = new ConnDB();

		Driver dbDriver = null;

		try {

			cn.setORP3FZUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);

			pstmt = conn
					.prepareStatement("SELECT gid FROM fztuidg WHERE userid=? ");

			pstmt.setString(1, userid);

			rs = pstmt.executeQuery();

			ArrayList al = null;
			while (rs.next()) {

				if (al == null) {
					al = new ArrayList();
				}
				al.add(rs.getString("gid"));

			}
			setGroupAL(al);

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
	 * 
	 * @return 所屬群組
	 * 
	 */
	public ArrayList getGroupAL() {
		return groupAL;
	}

	private void setGroupAL(ArrayList groupAL) {
		this.groupAL = groupAL;
	}

	/**
	 * 
	 * @param group
	 *            群組名稱(upper case)
	 * @return
	 * 
	 */
	public boolean isBelongGroup(String group) {
		boolean isBelong = false;
		if (getGroupAL() != null) {
			int idx = -1;
			idx = getGroupAL().indexOf(group.toUpperCase());
			if (idx != -1) {
				isBelong = true;
			}

		}
		return isBelong;
	}

}
