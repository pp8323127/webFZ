package swap3ac;

import java.sql.*;
import java.text.*;
import java.util.*;

import ci.db.*;

/**
 * CrewSuspendForSwap 取得組員前兩月留停記錄及計算是否全勤的月份,換班申請用.
 * 
 * 
 * @author cs66
 * @version 1.0 2008/3/9
 * 
 * Copyright: Copyright (c) 2008
 */
public class CrewSuspendForSwap {

	public static void main(String[] args) {
		CrewSuspendForSwap cs = new CrewSuspendForSwap("636750", "200803");
		ArrayList al = null;
		CleanMonthObj obj = null;
		try {
			cs.SelectData();
			 obj = cs.getCleanMonthObj();
			al = cs.getSuspendAL();
			 if (obj != null) {
				 System.out.println("無留停資料,計算月份為");
				System.out.println(obj.getCleanMonthStart());
				System.out.println(obj.getCleanMonthEnd());
			}
			 if(al != null){
				 System.out.println("留停資料共 "+al.size());
			 }
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private String empno;// 員工號
	private String swapYearAndMonth;// 換班年月,format: yyyymm
	private CleanMonthObj cleanMonthObj;// 全勤基準月份
	private ArrayList suspendAL;// 留停資料,儲存 SuspendObjForSwap
	/**
	 * @param empno
	 *            組員員工號
	 * @param swapYearAndMonth
	 *            換班年月,format: yyyymm
	 */
	public CrewSuspendForSwap(String empno, String swapYearAndMonth) {
		this.empno = empno;
		this.swapYearAndMonth = swapYearAndMonth;
	}

	/**
	 * 取得資料,並計算全勤基準月份
	 * 
	 * @throws Exception
	 * 
	 */
	public void SelectData() throws Exception {
		if (!isValidateDate(getSwapYearAndMonth())) {
			throw new Exception("換班月份格式不正確");
		}
		if (empno == null) {
			throw new NullPointerException("缺乏組員員工號");
		}

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		ConnDB cn = new ConnDB();

		try {
			// connection Pool
			// Driver dbDriver = null;
			// cn.setORP3EGUserCP();
			// dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			// conn = dbDriver.connect(cn.getConnURL(), null);

			// 直接連線
			cn.setORP3EGUser();
			java.lang.Class.forName(cn.getDriver());
			conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),
					cn.getConnPW());

			StringBuffer sqlSB = new StringBuffer();
			sqlSB.append("SELECT To_Char(s.ssdate,'yyyymm') stYM,");
			sqlSB.append("To_Char(s.sedate,'yyyymm') edYM, ");
			sqlSB.append("s.* FROM EGTSUSP s ");
			sqlSB.append("WHERE Trim(empn)=? ");
			sqlSB
					.append("AND ((ssdate <= Add_Months(To_Date(?,'yyyymm'),-2) AND  ");
			
			
			sqlSB.append("sedate BETWEEN Add_Months(To_Date(?,'yyyymm'),-2) ");
			sqlSB.append("AND Add_Months(Last_Day(To_Date(?,'yyyymm hh24mi')),-1) ) ");

			

			sqlSB.append("OR ( ");

			sqlSB.append("ssdate BETWEEN Add_Months(To_Date(?,'yyyymm'),-2) ");
			sqlSB
					.append("AND Add_Months(Last_Day(To_Date(?,'yyyymm hh24mi')),-1) ");
			sqlSB.append("	)	) ");
			sqlSB.append("ORDER BY ssdate");
			pstmt = conn.prepareStatement(sqlSB.toString());

			pstmt.setString(1, getEmpno());
			pstmt.setString(2, getSwapYearAndMonth());
			pstmt.setString(3, getSwapYearAndMonth());
			pstmt.setString(4, getSwapYearAndMonth() + " 2359");
			pstmt.setString(5, getSwapYearAndMonth());
			pstmt.setString(6, getSwapYearAndMonth() + " 2359");
			rs = pstmt.executeQuery();
			ArrayList al = null;
			while (rs.next()) {
				if (al == null) {
					al = new ArrayList();
				}
				SuspendObjForSwap obj = new SuspendObjForSwap();
				obj.setSuspendMonthStart(rs.getString("stYM"));
				obj.setSuspendMonthEnd(rs.getString("edYM"));
				al.add(obj);

			}
			setSuspendAL(al);

			// 前兩個月無留停資料
			if (getSuspendAL() == null) {
				setCleanMonthObj();
				//TODO 檢查請假記錄
			} else {
				// 前兩個月有留停,檢查留停時間，再往前推算,取得未留停的月份
				System.out.println("TODO 前兩個月有留停,檢查留停時間，再往前推算,取得未留停的月份");
				// TODO
			}

			rs.close();
			pstmt.close();
			conn.close();

		} catch (Exception e) {
			throw e;
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
	 * 檢查日期格式是否正確
	 * 
	 * @param validDate
	 * @return
	 * 
	 */
	public boolean isValidateDate(String validDate) {
		SimpleDateFormat format = new SimpleDateFormat("yyyyMM");

		try {
			java.util.Date date = format.parse(validDate);
			GregorianCalendar cal = new GregorianCalendar();
			cal.setTime(date);
			String strYear = validDate.substring(0, 4);
			String strMon = validDate.substring(4);

			if (cal.get(Calendar.YEAR) != Integer.parseInt(strYear)
					|| cal.get(Calendar.MONTH) + 1 != Integer.parseInt(strMon)) {
				return false;
			}

			return true;
		} catch (ParseException e) {
			return false;
		}

	}

	public String getEmpno() {
		return empno;
	}

	public void setEmpno(String empno) {
		this.empno = empno;
	}

	public String getSwapYearAndMonth() {
		return swapYearAndMonth;
	}

	public void setSwapYearAndMonth(String swapYearAndMonth) {
		this.swapYearAndMonth = swapYearAndMonth;
	}

	public CleanMonthObj getCleanMonthObj() {
		return cleanMonthObj;
	}

	public void setCleanMonthObj(CleanMonthObj cleanMonthObj) {
		this.cleanMonthObj = cleanMonthObj;
	}

	/**
	 * 
	 * 換班前兩個月無留停資料者,計算全勤基礎則為換班的前兩個月
	 * 
	 */
	public void setCleanMonthObj() {
		SimpleDateFormat format = new SimpleDateFormat("yyyyMM");
		CleanMonthObj obj = new CleanMonthObj();
		try {
			java.util.Date date = format.parse(getSwapYearAndMonth());
			GregorianCalendar cal = new GregorianCalendar();
			cal.setTime(date);

			cal.add(Calendar.MONTH, -1);
			obj.setCleanMonthEnd(format.format(cal.getTime()));

			cal.add(Calendar.MONTH, -1);
			obj.setCleanMonthStart(format.format(cal.getTime()));

		} catch (ParseException e) {

		}
		this.cleanMonthObj = obj;

	}
	public ArrayList getSuspendAL() {
		return suspendAL;
	}

	public void setSuspendAL(ArrayList suspendAL) {
		this.suspendAL = suspendAL;
	}
}
/**
 * SuspendObjForSwap, 留停資料物件,換班申請用
 * 
 * 
 * @author cs66
 * @version 1.0 2008/3/9
 * 
 * Copyright: Copyright (c) 2008
 */
class SuspendObjForSwap {
	private String suspendMonthStart;// 留停起始月份,format yyyymm
	private String suspendMonthEnd;// 留停結束月份,format yyyymm

	public String getSuspendMonthStart() {
		return suspendMonthStart;
	}
	public void setSuspendMonthStart(String suspendMonthStart) {
		this.suspendMonthStart = suspendMonthStart;
	}
	public String getSuspendMonthEnd() {
		return suspendMonthEnd;
	}
	public void setSuspendMonthEnd(String suspendMonthEnd) {
		this.suspendMonthEnd = suspendMonthEnd;
	}

}
