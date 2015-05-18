package swap3ackhh;

import java.sql.*;

import ci.db.*;

/**
 * 
 * ApplyCheck 檢驗申請單 1.是否有未被核可的申請單 2.當月申請次數 3.限制遞單日 4.當日數量
 * 
 * @author cs66
 * @version 1.0 2006/01/10
 * @version 1.1 2006/06/21 換班次數計算，加入實體換班記錄
 * @version 2.0 2007/01/04 高雄版換班
 * @version 2.1 2008/1/3 下班時間更改為1730
 * 
 * Copyright: Copyright (c) 2005
 */
public class ApplyCheck {

	private String aEmpno;
	private String rEmpno;
	private String year;
	private String month;
	private String limitenddate ="";
	private int aApplyTimes; // 申請者該月已核准之申請單次數
	private int rApplyTimes; // 被換者該月已核准之申請單次數
	private boolean unCheckForm = false; // 是否有尚未被核准之申請單
	private boolean aLocked = false;
	private boolean rLocked = false;
	private boolean isLimitedDate = false;// 是否為限制遞單日
	private boolean isOverMax = false;// 是否超過系統收單上限
	private boolean isNoSwap = false;// 是否限制換班
	private String noSwapStr = "";//限制換班理由

	public static void main(String[] args) 
	{
	    ApplyCheck as = new ApplyCheck("635849","629570", "2011","11");
        as.SelectDateAndCount();
        System.out.println(as.isNoSwap());
        System.out.println(as.getNoSwapStr());
	    System.out.println(as.isUnCheckForm());	   
	}
	CrewSwapSkj csk = new CrewSwapSkj(aEmpno, rEmpno, year, month);

	/**
	 * @param aEmpno
	 *            申請者
	 * @param rEmpno
	 *            被換者
	 * @param year
	 *            年
	 * @param month
	 *            月
	 */
	public ApplyCheck(String aEmpno, String rEmpno, String year, String month) 
	{
		this.aEmpno = aEmpno;
		this.rEmpno = rEmpno;
		this.year = year;
		this.month = month;
		SelectData();
	}

	public ApplyCheck() 
	{

	}

	public void SelectDateAndCount() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ConnDB cn = new ConnDB();
		Driver dbDriver = null;
		String sql = "";
		int count = 0;

		int maxCount = 0;
		try 
		{

			cn.setORP3FZUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);

//			 cn.setORT1FZUser();
//			 java.lang.Class.forName(cn.getDriver());
//			 conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),cn.getConnPW());

//			 當日是否為不收單日
//			pstmt = conn.prepareStatement("select count(*) tcount from fztsetdf where station='KHH' "
//							+ " and setdate=To_Date(to_char(SYSDATE ,'yyyy/mm/dd'),'yyyy/mm/dd')");
//			rs = pstmt.executeQuery();
//
//			while (rs.next()) 
//			{
//				count = rs.getInt("tcount");
//			}
//			pstmt.close();
//			rs.close();
			
			//是否為不收單時段
			pstmt = conn.prepareStatement("select to_char(setedate,'yyyy/mm/dd hh24:mi') edate from fztsetdf "
					+ " where setdate <= sysdate AND setedate >= SYSDATE ");

			rs = pstmt.executeQuery();

			while (rs.next()) 
			{
			    setLimitenddate(rs.getString("edate"));
				count ++;
			}
			pstmt.close();
			rs.close();
			
			// 若當日可送單，再檢查現在是否大於17:30,並隔日為限制遞單日期
//			if (count == 0) {
//				
//
//				pstmt = conn
//						.prepareStatement("select count(*) tcount from fztsetdf "
//								+ "where station='KHH' "
//								+ "AND setdate = To_Date(To_Char(SYSDATE+1,'yyyymmdd'),'yyyymmdd')  "
//								+ "AND  To_Char(SYSDATE,'hh24mi')>1730");
//
//				rs = pstmt.executeQuery();
//
//				while (rs.next()) {
//					count = rs.getInt("tcount");
//				}
//			}

			if (count > 0) 
			{
				setLimitedDate(true);
			}
			pstmt.close();
			rs.close();
			// 檢查是否超過當日收單數
			count = 0;
			int hh = 0;
			pstmt = conn
					.prepareStatement("select maxform from fztcmaxf where  station='KHH' ");
			rs = pstmt.executeQuery();
			while (rs.next()) 
			{
				maxCount = rs.getInt("maxform");
			}

			pstmt = conn.prepareStatement("select to_char(sysdate,'HH24MI') hh from dual");
			rs = pstmt.executeQuery();
			while (rs.next()) 
			{
				hh = rs.getInt("hh");
			}
			pstmt.close();
			rs.close();

			// 若超過1700,計算今日1701~明日1700數量，
			// 若<1700,計算昨日1701~今日1700數輛

			// 20070828 修改公式
			// 超過1700,計算今日1701~現在的數量，
			// < 1700,計算昨日1701~現在的數量

			//20080103 修改下班時間為1730
			if (hh > 1700) 
			{		
				// 超過17300,計算今日1731~現在的數量，
//				pstmt = conn.prepareStatement("select count(*) tcount from fztformf "
//								+ "where  station='KHH' "
//								+ "AND newdate BETWEEN  "
//								+ "To_Date(to_char(SYSDATE,'yyyymmdd')||' 1731','yyyymmdd hh24mi') "
//								+ "AND sysdate");				
				
				sql = " SELECT Sum(tcount) tcount FROM ( " +
			    	  " select count(*) tcount from fztformf where " +
			    	  " newdate BETWEEN To_Date(to_char(SYSDATE,'yyyymmdd')||' 1731','yyyymmdd hh24mi') and SYSDATE " +
			    	  " UNION ALL " +
			    	  " select count(*) tcount from fztbformf where " +
			    	  " newdate BETWEEN To_Date(to_char(SYSDATE,'yyyymmdd')||' 1731','yyyymmdd hh24mi') and SYSDATE ) ";
				pstmt = conn.prepareStatement(sql);

			} 
			else 
			{
				
				// < 1730,計算昨日1731~現在的數量
//				pstmt = conn.prepareStatement("select count(*) tcount from fztformf "
//								+ "where  station='KHH' and "
//								+ "newdate BETWEEN "
//								+ "To_Date(to_char(SYSDATE-1,'yyyymmdd')||' 1731','yyyymmdd hh24mi') "
//								+ "and sysdate");
				
				sql = " SELECT Sum(tcount) tcount FROM ( " +
			    	  " select count(*) tcount from fztformf where " +
			    	  " newdate BETWEEN To_Date(to_char(SYSDATE-1,'yyyymmdd')||' 1731','yyyymmdd hh24mi') and sysdate " +
			    	  " UNION ALL " +
			    	  " select count(*) tcount from fztbformf where " +
			    	  " newdate BETWEEN To_Date(to_char(SYSDATE-1,'yyyymmdd')||' 1731','yyyymmdd hh24mi') and sysdate ) ";
				pstmt = conn.prepareStatement(sql);

			}

			rs = pstmt.executeQuery();
			while (rs.next()) 
			{
				count = rs.getInt("tcount");
			}

			if (count >= maxCount) 
			{
				setOverMax(true);
			}
			pstmt.close();
			rs.close();
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
	
	public void swapRulesCheck(String aEmpno, String rEmpno, String year, String month) 
	{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ConnDB cn = new ConnDB();
		Driver dbDriver = null;
		String sql = "";
		int count = 0;
		try 
		{
			cn.setORP3FZUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);

//			 cn.setORT1FZUser();
//			 java.lang.Class.forName(cn.getDriver());
//			 conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),cn.getConnPW());
			
			//是否被嚴禁換班
			 sql = " SELECT empno, To_Char(eff_dt,'yyyy/mm') eff_dt, To_Char(exp_dt,'yyyy/mm') exp_dt, " +
		 	   " reason FROM fztnoswap " +
		 	   " WHERE empno IN ('"+aEmpno+"','"+rEmpno+"') " +
			   " and eff_dt <= To_Date('"+year+month+"01','yyyymmdd') " +
			   " AND exp_dt >= To_Date('"+year+month+"01','yyyymmdd') ";
			pstmt = conn.prepareStatement(sql);
	//System.out.println(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) 
			{
			    setNoSwapStr(rs.getString("empno")+" 禁止換班月份 From "+rs.getString("eff_dt")+" To "+rs.getString("exp_dt"));
			    if(!"".equals(getNoSwapStr()) && getNoSwapStr() != null)
			    {
			        setNoSwap(true);
			    }
			}
			pstmt.close();
			rs.close();	
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

	public void SelectData() {

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ConnDB cn = new ConnDB();
		Driver dbDriver = null;
		int dataCount = 0;
		try 
		{

			cn.setORP3FZUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);

			// cn.setORP3FZUser();
//			 cn.setORT1FZUser();
//			 java.lang.Class.forName(cn.getDriver());
//			 conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),cn.getConnPW());

			/* 是否有未被核准的申請單 */

//			pstmt = conn.prepareStatement("select count(*) tcount from fztformf "
//							+ "where  station='KHH' and (aempno=? or rempno=?) "
//							+ "and ed_check is null");
			
			sql = " SELECT Sum(tcount) tcount FROM ( " +
			  " select count(*) tcount from fztformf where (aempno=? or rempno=?) and ed_check is NULL " +
			  " UNION ALL " +
			  " select count(*) tcount from fztbformf where (aempno=? or rempno=?) and ed_check is null )" ;

			pstmt = conn.prepareStatement(sql);			

			// 申請者
			pstmt.setString(1, aEmpno);
			pstmt.setString(2, aEmpno);
			pstmt.setString(3, aEmpno);
			pstmt.setString(4, aEmpno);

			rs = pstmt.executeQuery();

			while (rs.next()) 
			{
				dataCount = rs.getInt("tcount");
			}
			if (dataCount >= 1) 
			{
				setUnCheckForm(true);
			}

			pstmt.clearParameters();
			dataCount = 0;
			// 被換者
			pstmt.setString(1, rEmpno);
			pstmt.setString(2, rEmpno);
			pstmt.setString(3, rEmpno);
			pstmt.setString(4, rEmpno);
			rs = pstmt.executeQuery();

			while (rs.next()) 
			{
				dataCount = rs.getInt("tcount");
			}
			
			if (dataCount >= 1) 
			{
				setUnCheckForm(true);
			}
			pstmt.close();
			rs.close();
			dataCount = 0;

			/* 換班次數限制 */
			// pstmt = conn
			// .prepareStatement("select count(*) tcount from fztform "
			// + "where (aempno=? or rempno=?) and ed_check='Y' "
			// + "and to_char(newdate,'yyyy/mm')=to_char(sysdate,'yyyy/mm')");
			// 加入實體換班記錄
//			pstmt = conn.prepareStatement("SELECT (select count(*) tcount from fztformf "
//							+ "where  station='KHH' and (aempno=? or rempno=?) and ed_check='Y' "
//							+ "and substr(formno,1,6)=?  )+("
//							+ "SELECT Count(*) c FROM fztrformf "
//							+ "WHERE  station='KHH' and yyyy=? AND mm=? AND ( (aempno=? AND aCount='Y') "
//							+ "OR (rempno=? AND rCount='Y'))  ) tcount FROM dual");
			
			sql = " SELECT (select count(*) tcount from fztformf where (aempno=? or rempno=?) " +
				  " and ed_check='Y' and substr(formno,1,6)=?)+(SELECT Count(*) c FROM fztrformf " +
				  " WHERE yyyy=? AND mm=? AND ( (aempno=? AND aCount='Y') OR (rempno=? AND rCount='Y'))) " +
				  " +(select count(*) tcount from fztbformf where ((aempno=? AND aCount='Y') OR (rempno=? AND rCount='Y')) " +
				  " and ed_check='Y' and substr(formno,1,6)=?)" + 
				  " tcount FROM dual ";
			pstmt = conn.prepareStatement(sql);
			
			// 申請者
			pstmt.setString(1, aEmpno);
			pstmt.setString(2, aEmpno);
			pstmt.setString(3, year + month);
			pstmt.setString(4, year);
			pstmt.setString(5, month);
			pstmt.setString(6, aEmpno);
			pstmt.setString(7, aEmpno);
			pstmt.setString(8, aEmpno);
			pstmt.setString(9, aEmpno);
			pstmt.setString(10, year + month);
			

			rs = pstmt.executeQuery();

			while (rs.next()) 
			{
				dataCount = rs.getInt("tcount");
			}
			setAApplyTimes(dataCount);

			// 被換者
			pstmt.clearParameters();
			dataCount = 0;
			pstmt.setString(1, rEmpno);
			pstmt.setString(2, rEmpno);
			pstmt.setString(3, year + month);
			pstmt.setString(4, year);
			pstmt.setString(5, month);
			pstmt.setString(6, rEmpno);
			pstmt.setString(7, rEmpno);
			pstmt.setString(8, rEmpno);
			pstmt.setString(9, rEmpno);
			pstmt.setString(10, year + month);
			rs = pstmt.executeQuery();

			while (rs.next()) 
			{
				dataCount = rs.getInt("tcount");
			}
			setRApplyTimes(dataCount);
			pstmt.close();
			rs.close();
			/* 班表是否鎖定 */
			pstmt = conn.prepareStatement("SELECT locked FROM fztcrew WHERE empno=?");
			pstmt.setString(1, aEmpno);
			rs = pstmt.executeQuery();

			while (rs.next()) 
			{
				if ("Y".equals(rs.getString("locked"))) 
				{
					setALocked(true);
				}
			}

			pstmt.setString(1, rEmpno);
			rs = pstmt.executeQuery();

			while (rs.next()) 
			{
				if ("Y".equals(rs.getString("locked"))) 
				{
					setRLocked(true);
				}
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

	public boolean isUnCheckForm() {
		return unCheckForm;
	}

	private void setUnCheckForm(boolean unCheckForm) {
		this.unCheckForm = unCheckForm;
	}

	public int getAApplyTimes() {
		return aApplyTimes;
	}

	private void setAApplyTimes(int applyTimes) {
		aApplyTimes = applyTimes;
	}

	public int getRApplyTimes() {
		return rApplyTimes;
	}

	private void setRApplyTimes(int applyTimes) {
		rApplyTimes = applyTimes;
	}

	public boolean isALocked() {
		return aLocked;
	}

	private void setALocked(boolean locked) {
		aLocked = locked;
	}

	public boolean isRLocked() {
		return rLocked;
	}

	private void setRLocked(boolean locked) {
		rLocked = locked;
	}

	private void setLimitedDate(boolean isLimitedDate) {
		this.isLimitedDate = isLimitedDate;
	}

	private void setOverMax(boolean isOverMax) {
		this.isOverMax = isOverMax;
	}

	public boolean isLimitedDate() {
		return isLimitedDate;
	}

	public boolean isOverMax() {
		return isOverMax;
	}
	
	 public String getLimitenddate()
    {
        return limitenddate;
    }
    
    public void setLimitenddate(String limitenddate)
    {
        this.limitenddate = limitenddate;
    }
    
    
    public boolean isNoSwap()
    {
        return isNoSwap;
    }
    public void setNoSwap(boolean isNoSwap)
    {
        this.isNoSwap = isNoSwap;
    }
    public String getNoSwapStr()
    {
        return noSwapStr;
    }
    public void setNoSwapStr(String noSwapStr)
    {
        this.noSwapStr = noSwapStr;
    }
}