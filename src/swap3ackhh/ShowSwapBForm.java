package swap3ackhh;

import java.sql.*;
import java.util.*;

import ci.db.*;

/**
 * 【AirCrews正式版】 <br>
 * ShowSwapForm 取得換班申請單資料
 * 
 * @author cs66
 * @version 1.0 2006/01/10
 * 
 * Copyright: Copyright (c) 2005
 */
public class ShowSwapBForm {
	 public static void main(String[] args)
	 {
		 ShowSwapForm sform = new ShowSwapForm("2008060001");
		 SwapFormObj obj = sform.getSwapFormObj();
		 ArrayList aSwapSkjAL = obj.getASwapSkjAL();
		 ArrayList rSwapSkjAL = obj.getRSwapSkjAL();
		 if(aSwapSkjAL != null){
		 for(int i=0;i<aSwapSkjAL.size();i++){
		 CrewSkjObj skjObj = (CrewSkjObj)aSwapSkjAL.get(i);
		 System.out.println(skjObj.getDutycode()+"\t"+skjObj.getCr());
		 }
		 }
	 }

	private int formno;
	private SwapFormObj swapFormObj;

	public ShowSwapBForm(String formno) 
	{
		this.formno = Integer.parseInt(formno);
		SelectData();
	}

	private void SelectData() 
	{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ConnDB cn = new ConnDB();

		Driver dbDriver = null;

		try 
		{
			// User connection pool to FZ
			 cn.setORP3FZUserCP();
			 dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			 conn = dbDriver.connect(cn.getConnURL() ,null);

			// 直接連線
//			cn.setORT1FZ();
//			java.lang.Class.forName(cn.getDriver());
//			conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),
//					cn.getConnPW());

			pstmt = conn.prepareStatement("select * from fztbformf where formno = ?");

			pstmt.setInt(1, formno);
			rs = pstmt.executeQuery();
			SwapFormObj obj = new SwapFormObj();

			while (rs.next()) 
			{
				obj.setFormno(rs.getString("formno"));
				obj.setAEmpno(rs.getString("aempno"));
				obj.setASern(rs.getString("asern"));
				obj.setACname(rs.getString("acname"));
				obj.setAGrps(rs.getString("agroups"));
				obj.setAApplyTimes(rs.getString("atimes"));
				obj.setAQual(rs.getString("aqual"));
				obj.setREmpno(rs.getString("rempno"));
				obj.setRSern(rs.getString("rsern"));
				obj.setRCname(rs.getString("rcname"));
				obj.setRGrps(rs.getString("rgroups"));
				obj.setRApplyTimes(rs.getString("rtimes"));
				obj.setRQual(rs.getString("rqual"));
				obj.setChg_all(rs.getString("chg_all"));
				obj.setASwapHr(rs.getString("aswaphr"));
				obj.setRSwapHr(rs.getString("rswaphr"));
				obj.setASwapDiff(rs.getString("aswapdiff"));
				obj.setRSwapDiff(rs.getString("rswapdiff"));
				obj.setAPrjcr(rs.getString("apch"));
				obj.setRPrjcr(rs.getString("rpch"));
				obj.setASwapCr(rs.getString("attlhr"));
				obj.setRSwapCr(rs.getString("rttlhr"));
				obj.setOverpay(rs.getString("overpay"));
				obj.setOver_hr(rs.getString("over_hr"));
				obj.setCrew_comm(rs.getString("crew_comm"));
				obj.setEd_check(rs.getString("ed_check"));
				obj.setComments(rs.getString("comments"));
				obj.setNewuser(rs.getString("newuser"));
				obj.setNewdate(rs.getString("newdate"));
				obj.setCheckuser(rs.getString("checkuser"));
				obj.setCheckdate(rs.getString("checkdate"));
				obj.setAcount(rs.getString("acount"));
				obj.setAcomm(rs.getString("acomm"));
				obj.setRcount(rs.getString("rcount"));
				obj.setRcomm(rs.getString("rcomm"));
			}
			
			//*********************************************************************************
			pstmt.clearParameters();
			pstmt = conn.prepareStatement("select * from fztbaplyf where formno="
					+ formno + " and therole=?");
			// 申請者
			pstmt.setString(1, "A");
			rs = pstmt.executeQuery();
			ArrayList al = new ArrayList();
			while (rs.next()) 
			{
				CrewSkjObj2 skjObj = new CrewSkjObj2();
				skjObj.setEmpno(rs.getString("empno"));
				skjObj.setTripno(rs.getString("tripno"));
				skjObj.setFdate(rs.getString("fdate"));
				skjObj.setDutycode(rs.getString("fltno"));
				skjObj.setCr(rs.getString("fly_hr"));
				al.add(skjObj);
			}
			obj.setASwapSkjAL(al);

			// 被換者
			ArrayList bl = new ArrayList();
			pstmt.clearParameters();
			pstmt.setString(1, "R");
			rs = pstmt.executeQuery();
			while (rs.next()) 
			{
				CrewSkjObj2 skjObj = new CrewSkjObj2();
				skjObj.setEmpno(rs.getString("empno"));
				skjObj.setTripno(rs.getString("tripno"));
				skjObj.setFdate(rs.getString("fdate"));
				skjObj.setDutycode(rs.getString("fltno"));
				skjObj.setCr(rs.getString("fly_hr"));
				bl.add(skjObj);
			}
			obj.setRSwapSkjAL(bl);

			setSwapFormObj(obj);
		} catch (SQLException e) {
			System.out.print(e.toString());
		} catch (Exception e) {
			System.out.print(e.toString());
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

	public int getFormno() {
		return formno;
	}

	public SwapFormObj getSwapFormObj() {
		return swapFormObj;
	}

	private void setSwapFormObj(SwapFormObj swapFormObj) {
		this.swapFormObj = swapFormObj;
	}
}