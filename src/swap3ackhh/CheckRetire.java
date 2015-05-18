package swap3ackhh;

import java.sql.*;

import ci.db.*;

/**
 * CheckRetire 檢查是否為屆退人員
 * 
 * 
 * @author cs66
 * @version 1.0 2006/5/16
 * 
 * Copyright: Copyright (c) 2006
 */
public class CheckRetire {

	// public static void main(String[] args) {
	// CheckRetire cr = new CheckRetire("593579");
	// try {
	// cr.RetrieveDate();
	// System.out.println(cr.isRetire());
	// cr = new CheckRetire("593579");
	// cr.RetrieveDate();
	// System.out.println(cr.isRetire());
	//			
	// } catch (ClassNotFoundException e) {
	// e.printStackTrace();
	// } catch (SQLException e) {
	// e.printStackTrace();
	// } catch (InstantiationException e) {
	// e.printStackTrace();
	// } catch (IllegalAccessException e) {
	// e.printStackTrace();
	// }
	// }
	private String empno;
	private boolean isRetire = false;

	public CheckRetire(String empno) {
		this.empno = empno;
	}

	public void RetrieveDate() throws ClassNotFoundException, SQLException,
			InstantiationException, IllegalAccessException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ConnDB cn = new ConnDB();
		Driver dbDriver = null;
		if (empno == null | "".equals(empno)) {
			throw new SQLException("empno is null");
		}
		try {

			 cn.setORP3FZUserCP();
			 dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			 conn = dbDriver.connect(cn.getConnURL(), null);

			// 直接連線
			// cn.setORP3FZUser();
//			cn.setORT1FZ();
//			java.lang.Class.forName(cn.getDriver());
//			conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),
//					cn.getConnPW());

			sql = "select * from fztretire where empno=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, empno);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				setRetire(true);
			}

			rs.close();
			pstmt.close();
			conn.close();
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

	public boolean isRetire() {
		return isRetire;
	}

	private void setRetire(boolean isRetire) {
		this.isRetire = isRetire;
	}

}
