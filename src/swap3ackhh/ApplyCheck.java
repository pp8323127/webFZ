package swap3ackhh;

import java.sql.*;

import ci.db.*;

/**
 * 
 * ApplyCheck ����ӽг� 1.�O�_�����Q�֥i���ӽг� 2.���ӽЦ��� 3.������ 4.���ƶq
 * 
 * @author cs66
 * @version 1.0 2006/01/10
 * @version 1.1 2006/06/21 ���Z���ƭp��A�[�J���鴫�Z�O��
 * @version 2.0 2007/01/04 ���������Z
 * @version 2.1 2008/1/3 �U�Z�ɶ���אּ1730
 * 
 * Copyright: Copyright (c) 2005
 */
public class ApplyCheck {

	private String aEmpno;
	private String rEmpno;
	private String year;
	private String month;
	private String limitenddate ="";
	private int aApplyTimes; // �ӽЪ̸Ӥ�w�֭㤧�ӽг榸��
	private int rApplyTimes; // �Q���̸Ӥ�w�֭㤧�ӽг榸��
	private boolean unCheckForm = false; // �O�_���|���Q�֭㤧�ӽг�
	private boolean aLocked = false;
	private boolean rLocked = false;
	private boolean isLimitedDate = false;// �O�_��������
	private boolean isOverMax = false;// �O�_�W�L�t�Φ���W��
	private boolean isNoSwap = false;// �O�_����Z
	private String noSwapStr = "";//����Z�z��

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
	 *            �ӽЪ�
	 * @param rEmpno
	 *            �Q����
	 * @param year
	 *            �~
	 * @param month
	 *            ��
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

//			 ���O�_���������
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
			
			//�O�_��������ɬq
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
			
			// �Y���i�e��A�A�ˬd�{�b�O�_�j��17:30,�ùj�鬰�������
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
			// �ˬd�O�_�W�L��馬���
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

			// �Y�W�L1700,�p�⤵��1701~����1700�ƶq�A
			// �Y<1700,�p��Q��1701~����1700�ƽ�

			// 20070828 �ק綠��
			// �W�L1700,�p�⤵��1701~�{�b���ƶq�A
			// < 1700,�p��Q��1701~�{�b���ƶq

			//20080103 �ק�U�Z�ɶ���1730
			if (hh > 1700) 
			{		
				// �W�L17300,�p�⤵��1731~�{�b���ƶq�A
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
				
				// < 1730,�p��Q��1731~�{�b���ƶq
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
			
			//�O�_�Q�Y�T���Z
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
			    setNoSwapStr(rs.getString("empno")+" �T��Z��� From "+rs.getString("eff_dt")+" To "+rs.getString("exp_dt"));
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

			/* �O�_�����Q�֭㪺�ӽг� */

//			pstmt = conn.prepareStatement("select count(*) tcount from fztformf "
//							+ "where  station='KHH' and (aempno=? or rempno=?) "
//							+ "and ed_check is null");
			
			sql = " SELECT Sum(tcount) tcount FROM ( " +
			  " select count(*) tcount from fztformf where (aempno=? or rempno=?) and ed_check is NULL " +
			  " UNION ALL " +
			  " select count(*) tcount from fztbformf where (aempno=? or rempno=?) and ed_check is null )" ;

			pstmt = conn.prepareStatement(sql);			

			// �ӽЪ�
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
			// �Q����
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

			/* ���Z���ƭ��� */
			// pstmt = conn
			// .prepareStatement("select count(*) tcount from fztform "
			// + "where (aempno=? or rempno=?) and ed_check='Y' "
			// + "and to_char(newdate,'yyyy/mm')=to_char(sysdate,'yyyy/mm')");
			// �[�J���鴫�Z�O��
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
			
			// �ӽЪ�
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

			// �Q����
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
			/* �Z��O�_��w */
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