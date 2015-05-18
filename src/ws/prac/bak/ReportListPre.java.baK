package ws.prac;

import java.sql.Connection;
import java.sql.Driver;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import ci.db.ConnDB;

public class ReportListPre {
	private String empno = null;
	private String yy = null;
	private String mm = null;
			
	private boolean check_pre_mm_done = true;// 前個月是否完成
	private boolean noticeQA = false;
	private String errorMsg = "";
	private String resultMsg = "";
	
	public ReportListPre(String empno,String yy,String mm){
		this.empno = empno;
		this.yy = yy;
		this.mm = mm;
		getPreMonthDone();
	}

	public void getPreMonthDone() {
		Driver dbDriver = null;
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;	
		try {
			ConnDB cn = new ConnDB();
			cn.setORP3EGUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);
			stmt = conn.createStatement();
			// check 前一個月是否完成
			sql = " SELECT Count(*) c FROM egtcrpt WHERE empno = '" + empno	+ "' AND fltd BETWEEN trunc(To_Date('" + yy + "/" + mm+ "/01','yyyy/mm/dd')-32,'mm') AND To_Date('" + yy + "/"+ mm + "/01','yyyy/mm/dd')-1 AND flag <> 'Y' ";
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				if (rs.getInt("c") > 0) {
					setCheck_pre_mm_done(false);
				}
			}

			// ************************************************************************************
			rs.close();
			// notice QA
			sql = "SELECT Count(*) c FROM dual WHERE SYSDATE BETWEEN To_Date('20130707','yyyymmdd') AND To_Date('20130807 2359','yyyymmdd hh24mi') OR SYSDATE BETWEEN To_Date('20121214','yyyymmdd') AND To_Date('20121221 2359','yyyymmdd hh24mi') ";
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				if (rs.getInt("c") > 0) {
					setNoticeQA(true);
				}
			}
			// ************************************************************************************
			setResultMsg("1");
		} catch (Exception e) {
			setResultMsg("0");
            setErrorMsg("error preMon: " + e.toString());
		} finally {
			try {
				if (rs != null)
					rs.close();
			} catch (SQLException e) {
			}
			try {
				if (stmt != null)
					stmt.close();
			} catch (SQLException e) {
			}
			try {
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
			}
		}
	}
	
	public boolean isCheck_pre_mm_done() {
		return check_pre_mm_done;
	}

	public void setCheck_pre_mm_done(boolean check_pre_mm_done) {
		this.check_pre_mm_done = check_pre_mm_done;
	}

	public boolean isNoticeQA() {
		return noticeQA;
	}

	public void setNoticeQA(boolean noticeQA) {
		this.noticeQA = noticeQA;
	}
	
	public String getErrorMsg() {
		return this.errorMsg;
	}

	public void setErrorMsg(String errorMsg) {
		this.errorMsg = errorMsg;
	}

	public String getResultMsg() {
		return this.resultMsg;
	}

	public void setResultMsg(String resultMsg) {
		this.resultMsg = resultMsg;
	}
}
