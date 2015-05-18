package aircrew;

import java.sql.*;
import java.util.*;

import ci.db.*;

/**
 * CrewCName 取得組員中文姓名 DB:fzvname
 * 
 * 
 * @author cs66
 * @version 1.0 2006/4/24
 * 
 * Copyright: Copyright (c) 2006
 */
public class CrewCName {

	private ArrayList empnoAL;
	private ArrayList cnameAL;

	public CrewCName() {
		SelectData();
	}

	private void SelectData() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ConnDB cn = new ConnDB();
		Driver dbDriver = null;
		try 
		{
//			cn.setORP3FZUserCP();
//			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
//			conn = dbDriver.connect(cn.getConnURL(), null);
			

			cn.setORP3FZUser();
			java.lang.Class.forName(cn.getDriver());
			conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
			pstmt = conn.prepareStatement("Select * from fzvname order by empno");

			rs = pstmt.executeQuery();
			empnoAL = new ArrayList();
			cnameAL = new ArrayList();
			while (rs.next()) {
				empnoAL.add(rs.getString("empno"));
				cnameAL.add(rs.getString("cname"));

			}

		} catch (SQLException e) {
			System.out.println(e.toString());
		} catch (ClassNotFoundException e) {
			System.out.println(e.toString());
		} catch (Exception e) {
			System.out.println(e.toString());
		} finally {
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

	/**
	 * @param empno
	 * @return 中文姓名(已轉碼)
	 */
	public String getCname(String empno) {
		int idx = 0;
		String cname = "";
		idx = empnoAL.indexOf(empno);
		if (idx != -1) {
			cname = (String) cnameAL.get(idx);
		}

		return cname;
	}

}
