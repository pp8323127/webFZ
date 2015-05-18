package swap3ac;

import java.sql.*;
import java.text.*;
import java.util.*;

import ci.db.*;

/**
 * CrewSuspendForSwap ���o�խ��e���d���O���έp��O�_���Ԫ����,���Z�ӽХ�.
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
				 System.out.println("�L�d�����,�p������");
				System.out.println(obj.getCleanMonthStart());
				System.out.println(obj.getCleanMonthEnd());
			}
			 if(al != null){
				 System.out.println("�d����Ʀ@ "+al.size());
			 }
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private String empno;// ���u��
	private String swapYearAndMonth;// ���Z�~��,format: yyyymm
	private CleanMonthObj cleanMonthObj;// ���԰�Ǥ��
	private ArrayList suspendAL;// �d�����,�x�s SuspendObjForSwap
	/**
	 * @param empno
	 *            �խ����u��
	 * @param swapYearAndMonth
	 *            ���Z�~��,format: yyyymm
	 */
	public CrewSuspendForSwap(String empno, String swapYearAndMonth) {
		this.empno = empno;
		this.swapYearAndMonth = swapYearAndMonth;
	}

	/**
	 * ���o���,�íp����԰�Ǥ��
	 * 
	 * @throws Exception
	 * 
	 */
	public void SelectData() throws Exception {
		if (!isValidateDate(getSwapYearAndMonth())) {
			throw new Exception("���Z����榡�����T");
		}
		if (empno == null) {
			throw new NullPointerException("�ʥF�խ����u��");
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

			// �����s�u
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

			// �e��Ӥ�L�d�����
			if (getSuspendAL() == null) {
				setCleanMonthObj();
				//TODO �ˬd�а��O��
			} else {
				// �e��Ӥ릳�d��,�ˬd�d���ɶ��A�A���e����,���o���d�������
				System.out.println("TODO �e��Ӥ릳�d��,�ˬd�d���ɶ��A�A���e����,���o���d�������");
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
	 * �ˬd����榡�O�_���T
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
	 * ���Z�e��Ӥ�L�d����ƪ�,�p����԰�¦�h�����Z���e��Ӥ�
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
 * SuspendObjForSwap, �d����ƪ���,���Z�ӽХ�
 * 
 * 
 * @author cs66
 * @version 1.0 2008/3/9
 * 
 * Copyright: Copyright (c) 2008
 */
class SuspendObjForSwap {
	private String suspendMonthStart;// �d���_�l���,format yyyymm
	private String suspendMonthEnd;// �d���������,format yyyymm

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
