package swap3ac;

import java.sql.*;
import java.util.*;

import ci.db.*;

/**
 * 【AirCrews正式版】 <br>
 * ApplyCheck 檢驗申請單 1.是否有未被核可的申請單 2.當月申請次數 3.限制遞單日 4.當日數量
 * 
 * @author cs66
 * @version 1.0 2006/01/10
 * @version 1.1 2006/06/21 換班次數計算，加入實體換班記錄
 * @version 1.2 2007/8/28 修改當日換班數量計算方法及隔日為當日遞單日計算SQL: <br>
 * 
 * 超過1700,計算今日1701~現在的數量，< 1700,計算昨日1701~現在的數量<br>
 * 若當日可送單，再檢查現在是否大於17:00,並隔日為限制遞單日期<br>
 * 
 * @version 1.3 2008/1/3 下班時間更改為1730
 * @version 2.0 2010/03/31 下班時間更改為1600
 * 
 * Copyright: Copyright (c) 2005
 */
public class ApplyCheck 
{    
    public static void main(String[] args) 
	{
//        ApplyCheck as = new ApplyCheck("635849","629570", "2011","11");
//        as.SelectDateAndCount();
//        System.out.println(as.isNoSwap());
//        System.out.println(as.getNoSwapStr());
        ApplyCheck ack = new ApplyCheck();
        System.out.println(ack.getRestHour("2012","01","TPE").size());
	}

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

	public void SelectDateAndCount() 
	{
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
//			 conn = DriverManager.getConnection(cn.getConnURL(), "fzap","FZ921002");
			
			// 當日是否為不收單日
//			pstmt = conn.prepareStatement("select count(*) tcount from fztsetd "
//							+ "where setdate = "
//							+ "To_Date(to_char(SYSDATE ,'yyyy/mm/dd'),'yyyy/mm/dd')");
			//是否為不收單時段
			pstmt = conn.prepareStatement("select to_char(setedate,'yyyy/mm/dd hh24:mi') edate from fztsetd "
					+ "where setdate <= sysdate AND setedate >= SYSDATE ");

			rs = pstmt.executeQuery();

			while (rs.next()) 
			{
			    setLimitenddate(rs.getString("edate"));
				count ++;
			}
			pstmt.close();
			rs.close();
			// 若當日可送單，再檢查現在是否大於17:30,並隔日為限制遞單日期
//			if (count == 0) 
//			{
//				// pstmt = conn
//				// .prepareStatement("select count(*) tcount from fztsetd "
//				// + "where to_char(setdate,'yyyy/mm/dd') = "
//				// + "to_char(sysdate+(7/24),'yyyy/mm/dd')");
//				pstmt = conn
//						.prepareStatement("select count(*) tcount from fztsetd "
//								+ "WHERE setdate = To_Date(To_Char(SYSDATE+1,'yyyymmdd'),'yyyymmdd') "
////								+ "AND  To_Char(SYSDATE,'hh24mi')>1730 ");
//								+ "AND  To_Char(SYSDATE,'hh24mi')>1600 ");
//				
//
//				rs = pstmt.executeQuery();
//
//				while (rs.next()) 
//				{
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
			pstmt = conn.prepareStatement("select maxform from fztcmax");
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

			// 若超過1700,計算今日1701~明日1700數量，
			// 若<1700,計算昨日1701~今日1700數輛

			// 20070828 修改公式
			// 超過1700,計算今日1701~現在的數量，
			// < 1700,計算昨日1701~現在的數量
			
//			 20100331 修改公式
			// 超過1600,計算今日1601~現在的數量，
			// < 1600,計算昨日1601~現在的數量
			pstmt.close();
			rs.close();
			
			if (hh > 1600) 
			{			
				// 超過1700,計算今日1701~現在的數量，
//			    sql = " SELECT Sum(tcount) tcount FROM ( " +
//			    	  " select count(*) tcount from fztform where " +
//			    	  " newdate BETWEEN To_Date(to_char(SYSDATE,'yyyymmdd')||' 1731','yyyymmdd hh24mi') and SYSDATE " +
//			    	  " UNION ALL " +
//			    	  " select count(*) tcount from fztbform where " +
//			    	  " newdate BETWEEN To_Date(to_char(SYSDATE,'yyyymmdd')||' 1731','yyyymmdd hh24mi') and sysdate ) ";
//				pstmt = conn.prepareStatement(sql);
				
//				 超過1600,計算今日1601~現在的數量，
			    sql = " SELECT Sum(tcount) tcount FROM ( " +
			    	  " select count(*) tcount from fztform where " +
			    	  " newdate BETWEEN To_Date(to_char(SYSDATE,'yyyymmdd')||' 1601','yyyymmdd hh24mi') and SYSDATE " +
			    	  " UNION ALL " +
			    	  " select count(*) tcount from fztbform where " +
			    	  " newdate BETWEEN To_Date(to_char(SYSDATE,'yyyymmdd')||' 1601','yyyymmdd hh24mi') and sysdate ) ";
				pstmt = conn.prepareStatement(sql);

			} 
			else 
			{
				// < 1730,計算昨日1731~現在的數量
//			    sql = " SELECT Sum(tcount) tcount FROM ( " +
//			    	  " select count(*) tcount from fztform where " +
//			    	  " newdate BETWEEN To_Date(to_char(SYSDATE-1,'yyyymmdd')||' 1730','yyyymmdd hh24mi') and sysdate " +
//			    	  " UNION ALL " +
//			    	  " select count(*) tcount from fztbform where " +
//			    	  " newdate BETWEEN To_Date(to_char(SYSDATE-1,'yyyymmdd')||' 1730','yyyymmdd hh24mi') and sysdate ) ";
//			    pstmt = conn.prepareStatement(sql);
			    
                //< 1600,計算昨日1601~現在的數量
			    sql = " SELECT Sum(tcount) tcount FROM ( " +
			    	  " select count(*) tcount from fztform where " +
			    	  " newdate BETWEEN To_Date(to_char(SYSDATE-1,'yyyymmdd')||' 1601','yyyymmdd hh24mi') and sysdate " +
			    	  " UNION ALL " +
			    	  " select count(*) tcount from fztbform where " +
			    	  " newdate BETWEEN To_Date(to_char(SYSDATE-1,'yyyymmdd')||' 1601','yyyymmdd hh24mi') and sysdate ) ";
			    pstmt = conn.prepareStatement(sql);
			}

			rs = pstmt.executeQuery();
			while (rs.next()) 
			{
				count = rs.getInt("tcount");
//				System.out.println(count);
			}

			if (count >= maxCount) {
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

	public void SelectData() 
	{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ConnDB cn = new ConnDB();
		Driver dbDriver = null;
		int dataCount = 0;
		try {

			cn.setORP3FZUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);

			// cn.setORP3FZUser();
//			 cn.setORT1FZUser();
//			 java.lang.Class.forName(cn.getDriver());
//			 conn = DriverManager.getConnection(cn.getConnURL(), "fzap",
//			 "FZ921002");

			/* 是否有未被核准的申請單 */
			 
//			sql = "select count(*) tcount from fztform where (aempno=? or rempno=?) and ed_check is null";
			//modify by Betty on 2008/06/01
			sql = " SELECT Sum(tcount) tcount FROM ( " +
				  " select count(*) tcount from fztform where (aempno=? or rempno=?) and ed_check is NULL " +
				  " UNION ALL " +
				  " select count(*) tcount from fztbform where (aempno=? or rempno=?) and ed_check is null )" ;

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
//				System.out.println(dataCount);
			}
			
			if (dataCount >= 1) 
			{
				setUnCheckForm(true);
			}

			// 被換者
			//****************************************************************************
			pstmt.clearParameters();
			dataCount = 0;
			pstmt.setString(1, rEmpno);
			pstmt.setString(2, rEmpno);
			pstmt.setString(3, rEmpno);
			pstmt.setString(4, rEmpno);
			rs = pstmt.executeQuery();

			while (rs.next()) 
			{
				dataCount = rs.getInt("tcount");
//				System.out.println(dataCount);
			}
			
			if (dataCount >= 1) 
			{
				setUnCheckForm(true);
			}
			pstmt.close();
			rs.close();
			
			//****************************************************************************
			/* 換班次數限制 */
			// pstmt = conn
			// .prepareStatement("select count(*) tcount from fztform "
			// + "where (aempno=? or rempno=?) and ed_check='Y' "
			// + "and to_char(newdate,'yyyy/mm')=to_char(sysdate,'yyyy/mm')");
			// 加入實體換班記錄
			
			sql = " SELECT (select count(*) tcount from fztform where (aempno=? or rempno=?) " +
				  " and ed_check='Y' and substr(formno,1,6)=?)+(SELECT Count(*) c FROM fztrform " +
				  " WHERE Yyyy=? AND mm=? AND ( (aempno=? AND aCount='Y') OR (rempno=? AND rCount='Y'))) " +
				  " +(select count(*) tcount from fztbform where ((aempno=? AND aCount='Y') OR (rempno=? AND rCount='Y')) " +
				  " and ed_check='Y' and substr(formno,1,6)=?)" + 
				  " tcount FROM dual ";
			pstmt = conn.prepareStatement(sql);
//			pstmt = conn
//					.prepareStatement("SELECT (select count(*) tcount from fztform "
//							+ "where (aempno=? or rempno=?) and ed_check='Y' "
//							+ "and substr(formno,1,6)=?  )+("
//							+ "SELECT Count(*) c FROM fztrform "
//							+ "WHERE Yyyy=? AND mm=? AND ( (aempno=? AND aCount='Y') "
//							+ "OR (rempno=? AND rCount='Y'))  ) tcount FROM dual");
			// 申請者
			pstmt.clearParameters();
			dataCount = 0;
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
//				System.out.println(dataCount);
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
//				System.out.println(dataCount);
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

			pstmt.clearParameters();
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
	
	public ArrayList getRestHour(String yyyy, String month, String base) 
	{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;		
		Driver dbDriver = null;
		String sql = "";
		ArrayList resthrAL = new ArrayList();
		int count = 0;
		try 
		{
		    ConnDB cn = new ConnDB();
			cn.setORP3FZUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);

//			 cn.setORT1FZUser();
//			 java.lang.Class.forName(cn.getDriver());
//			 conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),cn.getConnPW());
			
			 if(!"".equals(yyyy) && yyyy != null)
			 {
				 sql = " SELECT seq, condi_col, condi_val, resthr, To_Char(expdt,'yyyy/mm/dd') expdt, base, " +
				 	   " newuser, To_Char(newdate,'yyyy/mm/dd hh24:mi') newdate, upduser, " +
				 	   " To_Char(upddate,'yyyy/mm/dd hh24:mi') upddate FROM fztresthr " +
				 	   " WHERE (To_Date('"+yyyy+"/"+month+"/01','yyyy/mm/dd') <= expdt " +
				 	   " or expdt IS NULL) AND base = '"+base+"' ORDER BY condi_col, resthr, condi_val ";
			 }
			 else
			 {//get all setting
			     sql = " SELECT seq, condi_col, condi_val, resthr, To_Char(expdt,'yyyy/mm/dd') expdt, base, " +
			 	   	   " newuser, To_Char(newdate,'yyyy/mm/dd hh24:mi') newdate, upduser, " +
			 	       " To_Char(upddate,'yyyy/mm/dd hh24:mi') upddate FROM fztresthr WHERE base = '"+base+"' " +
			 	       " ORDER BY condi_col, resthr, condi_val";			     
			 }
			 
//			System.out.println(sql);			 
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) 
			{
			    RestHourObj obj = new RestHourObj();
			    obj.setSeq(rs.getString("seq"));
			    obj.setCondi_col(rs.getString("condi_col"));
			    obj.setCondi_val(rs.getString("condi_val"));
			    obj.setResthr(rs.getString("resthr"));
			    obj.setExpdt(rs.getString("expdt"));
			    obj.setBase(rs.getString("base"));
			    obj.setNewuser(rs.getString("newuser"));
			    obj.setNewdate(rs.getString("newdate"));
			    obj.setUpduser(rs.getString("upduser"));
			    obj.setUpddate(rs.getString("upddate"));
			    resthrAL.add(obj);
			}
		} 
		catch (SQLException e) 
		{
			System.out.println(e.toString());
		} 
		catch (ClassNotFoundException e) 
		{
			System.out.println(e.toString());
		} 
		catch (Exception e) 
		{
			System.out.println(e.toString());
		} 
		finally 
		{
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
		return resthrAL;
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