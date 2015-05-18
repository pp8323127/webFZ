package df.flypay;

/**
 * SingleCrewFlyPay 個人飛加,寄送至全員信箱,若無資料則不發送
 * 
 * @author cs66
 * @version 1.0 2005/8/18
 * @version 2.0 2005/10/24 可設定append 及log file
 * @version 2.1 2005/12/01 可設定收件者及銀行帳號 by betty
 * @version 2.2 2006/3/20 by cs66 新增超時給付項目
 * @version 2.3	2007/03/15 by cs66  員工號38開頭者,新增Tax及bankNT項目
 * @version 2.4 2009/11/19 by CS27 add prfxdt
 * @V2.5 2011/01/25 CS27 mod nvl()
 * @V2.6 2011/05/07 CS27  add rorpay 
 * @V2.7 2011/05/13 CS27  add oth1_flypay  oth3_flypay oth1_overpay  oth3_overpay
 *                            oth1_stby    sum_oth1    sum_oth3
 * @v2.8 2011/09/15 cs27  add overmin_y    overpay_y
 * @V2.9 2011/10/27 CS27  add xiypay 
 *
 * Copyright: Copyright (c) 2005
 *  call java class
 *     ConnDB
 *     FlyPayObj         <= mail content definition
 *     ReadFile
 *     WriteLog
 *     DeliverMail.class  ci.tool.DeliverMail
 */

import java.sql.*;
import ci.db.*;
import ci.tool.*;

public class SingleCrewFlyPay {

	private String empno;  // empno for select database
	private String year;
	private String month;
	// add by betty
	private String receiver;
	// **********************
	private FlyPayObj obj = null;
	private boolean hasData = false;// 是否有資料
	private String appendFile = null;
	private String logFile;

	public static void main(String[] args) {
		SingleCrewFlyPay s = new SingleCrewFlyPay("635863", "2012", "04","640790"); 
		s.setAppendFile("c:\\noticeFlypay.txt"); //
		// s.setLogFile("C:\\111--.txt");
		System.out.println("是否寄送成功：" + s.sendFlyPayData());
		System.out.println("是否有資料?: " + s.isHasData());
	}

	public SingleCrewFlyPay(String empno, String year, String month) 
	{
		this.empno = empno;
		this.year = year;
		this.month = month;
		// add by betty
		// v02 this.receiver = empno + "@cal.aero";
		// *******************************
	}

	/**
	 * @param empno
	 * @param year
	 * @param month
	 * @param receiver
	 *            收件者
	 * 
	 * add by betty
	 */
	public SingleCrewFlyPay(String empno, String year, String month,String receiver) 
	{
		this.empno = empno;
		this.year = year;
		this.month = month;
		this.receiver = receiver;
	}

	/**
	 * @param appendFile
	 *            信件附的說明檔之絕對路徑與檔名
	 */
	public void setAppendFile(String appendFile) {
		this.appendFile = appendFile;
	}

	/**
	 * @param logFile
	 *            由上層AP設定log檔之絕對路徑與檔名
	 */
	public void setLogFile(String logFile) {
		this.logFile = logFile;
	}

	public void RetrieveData() 
	{
		obj = new FlyPayObj();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;
		ConnDB cn = new ConnDB();
		Driver dbDriver = null;
		try {
//			 cn.setDFUserCP();
//// 			 cn.setORP3FZUserCP();    
//			 dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
//			 conn = dbDriver.connect(cn.getConnURL(), null);

			cn.setORP3DFUser();
			java.lang.Class.forName(cn.getDriver());
			conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),"df1234");
			stmt = conn.createStatement();
			
			sql = "SELECT round(p.paymin/60,3) payhr,  round(p.incmin/60,3) inchr, "
				+ "round(p.decmin/60,3) dechr,round(p.ovrmin/60,3) ovrhr, "
				+ "round(p.intmin/60,3) inthr, c.NAME cname,c.ename, "
				+ "c.box,c.cabin cab,c.banknont banknont, c.banknous banknous, "
				+ "nvl(round(p.ovrmindd/60,4),0) overmindd, nvl(p.ovrpaydd,0) ovrpaydd,nvl(p.ovrpayratedd,0) ovrpayratedd, " //v2.5
				+ " nvl(prfxdt,0) prfxdt , "  //v2.5
                                + " nvl(rorpay,0) rorpay , "  //v2.6
   				+ " nvl(xiypay,0) xiypay , "  //v2.9
                                + " nvl(p.overmin_y,0) overmin_y , "  //v2.8
                                + " nvl(p.overpay_y,0) overpay_y , "  //v2.8
				+ "(nvl(p.pock,0) - nvl(p.tfp3,0)) taxfree, "
				+ "p.* FROM dfdb.dftpock p, dfdb.dftcrew c "
				+ "WHERE p.empno = c.empno AND p.empno='"
				+ empno
				+ "' AND yyyy='" + year + "' AND mm='" + month + "'";

			rs = stmt.executeQuery(sql);

			//System.out.println(sql);
			while (rs.next()) {

				obj.setYear(year);
				obj.setMonth(month);
				obj.setEmpno(rs.getString("empno"));
				obj.setCname(rs.getString("cname"));
				obj.setEname(rs.getString("ename"));
				obj.setSern(rs.getString("box"));
				obj.setBase(rs.getString("base"));
				obj.setSect(rs.getString("sect"));
				obj.setPost(rs.getString("post"));
				obj.setNflrk(rs.getString("nflrk"));
				obj.setCabin(rs.getString("cab"));
				obj.setPayhr(rs.getString("payhr"));
				obj.setInchr(rs.getString("inchr"));
				obj.setDechr(rs.getString("dechr"));
				obj.setOvrhr(rs.getString("ovrhr"));
				obj.setInthr(rs.getString("inthr"));
				obj.setPock(rs.getString("pock"));
				obj.setFlypay2(rs.getString("flypay2"));
				obj.setPock2(rs.getString("pock2"));
				obj.setOver(rs.getString("over"));
				obj.setIpcp(rs.getString("ipcp"));
				obj.setCrus(rs.getString("crus"));
				obj.setMgr(rs.getString("mgr"));
				obj.setStby(rs.getString("stby"));
				obj.setRew(rs.getString("rew"));
				obj.setDisp(rs.getString("disp"));
				obj.setLwop(rs.getString("lwop"));
				obj.setPen(rs.getString("pen"));
				obj.setOtha(rs.getString("otha"));
				obj.setOthb(rs.getString("othb"));
				obj.setWine(rs.getString("wine"));
				obj.setSale(rs.getString("sale"));
				obj.setSale2(rs.getString("sale2"));
				obj.setNetnt(rs.getString("netnt"));
				obj.setUperd(rs.getString("uperd"));
				obj.setUdfs(rs.getString("udfs"));
				obj.setUotha(rs.getString("uotha"));
				obj.setUothb(rs.getString("uothb"));
				obj.setNetus(rs.getString("netus"));

				// add by betty
				obj.setBanknont(rs.getString("banknont"));
				obj.setBanknous(rs.getString("banknous"));

				// add by cs66 over pay
				obj.setOvertmHr(rs.getString("overmindd"));
				obj.setOverPay(rs.getString("ovrpaydd"));
				obj.setOverRate(rs.getString("ovrpayratedd"));

				// add by cs66 tax
				obj.setTaxable(rs.getString("tsum"));
				obj.setTaxfree(rs.getString("taxfree"));

				
				//add  by cs66 2007/03/15 員工號38開頭者
				obj.setTax(rs.getString("tax"));
				obj.setBankNT(rs.getString("bankNT"));
				
				//add by CS27 2009/11/19
				obj.setPrfxdt(rs.getString("prfxdt"));  //v2.4

                               //add by CS27 2011/05/07
				obj.setRorpay(rs.getString("rorpay"));  //v2.6
                               
				//add by CS27 2011/10/27
				obj.setXiypay(rs.getString("xiypay"));  //v2.9

                               //add by CS27 2011/05/13
				obj.setOth1_flypay(rs.getString("oth1_flypay"));  //v2.7
				obj.setOth3_flypay(rs.getString("oth3_flypay"));  //v2.7
				obj.setOth1_overpay(rs.getString("oth1_overpay"));  //v2.7
				obj.setOth3_overpay(rs.getString("oth3_overpay"));  //v2.7
				obj.setOth1_stby(rs.getString("oth1_stby"));  //v2.7
				obj.setSum_oth1(rs.getString("sum_oth1"));  //v2.7
				obj.setSum_oth3(rs.getString("sum_oth3"));  //v2.7

                               //add by CS27 2011/09/15
				obj.setOvermin_y(rs.getString("overmin_y"));  //v2.8
				obj.setOverpay_y(rs.getString("overpay_y"));  //v2.8

				setHasData(true);
			}
			rs.close();
			stmt.close();

			// 取得是否使用2006/08之後新版飛加清單
			stmt = conn.createStatement();
			rs = stmt.executeQuery("SELECT (CASE WHEN To_Date('" + year + month
					+ "','yyyymm') >=To_Date('200608','yyyymm') THEN 'N' "
					+ "ELSE 'O' END) tax FROM dual");
			while (rs.next()) {
				if ("N".equals(rs.getString("tax").trim())) {
					obj.setNewVersionWithTaxItem(true);
				} else {
					obj.setNewVersionWithTaxItem(false);
				}

			}

			rs.close();
			stmt.close();
			return;
		} catch (ClassNotFoundException e) {
			System.out.println(e.toString());
		} catch (SQLException e) {
			System.out.println(e.toString());
		}
		
//		  catch (InstantiationException e) { System.out.println(e.toString()); }
//		  catch (IllegalAccessException e) { System.out.println(e.toString()); }
		 finally {
			if (stmt != null)
				try {
					stmt.close();
				} catch (SQLException e) {
					System.out.println(e.toString());
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException e) {
					System.out.println(e.toString());
				}
		}
	}

	public boolean sendFlyPayData() {

		boolean isSuccess = true;
		if (obj == null) 
		{
			RetrieveData();    // call function get DATABASE
		}
		if (hasData) 
		{ // 有資料
			String str = "";

			// append file
			if (appendFile != null) 
			{
				ReadFile rf = new ReadFile();
				str = rf.getFileString(appendFile);
			}
			// 寫入log
			WriteLog wl = null;
			if (logFile != null) 
			{
				wl = new WriteLog(logFile);
			}
			String mailConent = obj.getFlyPayContent() + str;
 
			DeliverMail dm = new DeliverMail();

			try {
				// dm.DeliverMailWithBackup(year + "/" + month
				// + " Flight Payment List" ,obj.getEmpno() ,mailConent);
				// ,"tpecsci" ,mailConent);

				// add by betty
				dm.DeliverMailWithBackup(year + "/" + month	+ " Flight Payment List", receiver, mailConent);

				// 寫入log
				if (wl != null) 
				{
					wl.WriteFileWithTime(obj.getEmpno() + "\t" + year + "/"
							+ month);
				}

			} 
			catch (Exception e) 
			{
				System.out.println(e.toString());
				isSuccess = false;
			}
		} 
		else 
		{
			isSuccess = false;
		}

		return isSuccess;

	}

	public boolean isHasData() {
		return hasData;
	}

	public void setHasData(boolean hasData) {
		this.hasData = hasData;
	}
}