package fzac;

import java.sql.*;
import java.util.*;

import ci.db.*;

/**
 * UpdatePutSkj 更新丟班資訊
 * 
 * 
 * @author cs66
 * @version 1.0 2006/4/16
 * 
 * Copyright: Copyright (c) 2006
 */
public class UpdatePutSkj {


	private CrewPutSkjObj obj;
	private int[] updIdx;
	
	/**
	 * @param obj
	 *            CrewPutSkjObj
	 * @param updIdx
	 *            需更新的筆數
	 */
	public UpdatePutSkj(CrewPutSkjObj obj, String[] updIdx) {
		this.obj = obj;
		setUpdIdx(updIdx);

	}

	public void UpdateData() throws SQLException, Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ConnDB cn = new ConnDB();

		Driver dbDriver = null;
		// 取得中文姓名
		aircrew.CrewCName cc = new aircrew.CrewCName();
		try {
			
			cn.setORP3FZUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);

			sql = "insert into fztsput (empno, sern, cname, fdate, fltno, tripno "
					+ ", occu, put_date, comments,homebase) values(?,?,?,?,?,?,?,sysdate,?,?)";

			pstmt = conn.prepareStatement(sql);
			ArrayList skjObj = obj.getSkjObj();
			ArrayList commAL = obj.getCommentAL();

			for (int i = 0; i < updIdx.length; i++) {
				pstmt.setString(1, obj.getEmpno());
				pstmt.setString(2, obj.getSern());
				// pstmt.setString(3, obj.getCname());
				pstmt.setString(3, cc.getCname(obj.getEmpno()));
				pstmt.setString(7, obj.getOccu());

				swap3ac.CrewSkjObj scObj = (swap3ac.CrewSkjObj) skjObj
						.get(updIdx[i]);

				pstmt.setString(4, scObj.getFdate());
				pstmt.setString(5, scObj.getDutycode());
				pstmt.setString(6, scObj.getTripno());
				pstmt.setString(8, (String) commAL.get(i));
				pstmt.setString(9, obj.getBase());

				pstmt.executeUpdate();

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

	private void setUpdIdx(String[] updIdx) {
		int[] updIdx1 = new int[updIdx.length];
		for (int i = 0; i < updIdx.length; i++) {
			updIdx1[i] = Integer.parseInt(updIdx[i]);
		}
		this.updIdx = updIdx1;
	}
}
