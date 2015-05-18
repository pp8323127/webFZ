package swap3ac;

import java.sql.*;

import ci.db.*;

/**
 * CheckLockSkj 檢查是否設定鎖住班表
 * 
 * 
 * @author cs66
 * @version 1.0 2007/2/9
 * 
 * Copyright: Copyright (c) 2007
 */
public class CheckLockSkj {

	private String empno;
	private boolean openSkj = false;
	public CheckLockSkj(String empno) {
		this.empno = empno;
	}
	public void SelectData() {
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
					.prepareStatement("SELECT locked FROM fztcrew WHERE empno=?");
			pstmt.setString(1, empno);
			rs = pstmt.executeQuery();

			while (rs.next()) {

				if ("N".equals(rs.getString("locked"))) {
					setOpenSkj(true);
				}
			}
			rs.close();
			pstmt.close();
			conn.close();

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

	public boolean isOpenSkj() {
		return openSkj;
	}

	private void setOpenSkj(boolean openSkj) {
		this.openSkj = openSkj;
	}
}
