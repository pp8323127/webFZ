package fzAuthP;

import java.sql.*;
import ci.db.*;

/**
 * 取得空管資料 <br>
 * DB: connection pool
 * 
 * @author cs66 at 2005/6/30
 */
public class CheckEG {

	private EGObj egObj;
	private boolean isEGCrew;

	public CheckEG() 
	{
		RetrieveData();
	}

	public void RetrieveData() throws NullPointerException 
	{
		if (UserID.getUserid() == null)
			throw new NullPointerException("User ID is required!");

		ConnDB cn = new ConnDB();
		Connection conn = null;
		PreparedStatement pstmt = null;

		Driver dbDriver = null;
		ResultSet rs = null;
		try 
		{
		    
//		  cn.setORP3FZUser();
//          java.lang.Class.forName(cn.getDriver());
//          conn = DriverManager.getConnection(cn.getConnURL() ,cn.getConnID() ,cn.getConnPW());
		    
			cn.setORP3FZUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);

			pstmt = conn.prepareStatement("select empn,sern,section,cname,ename,"
							+ "jobno,groups,station,status,to_char(birth,'yyyymmdd') birth "
							+ "from egtcbas where trim(empn)=?");

			pstmt.setString(1, UserID.getUserid().trim());

			rs = pstmt.executeQuery();
			EGObj obj = null;
			while (rs.next()) {
				if (obj == null) {
					obj = new EGObj();
				}

				obj.setBirth(rs.getString("birth"));
				obj.setCname(rs.getString("cname"));
				obj.setEmpno(rs.getString("empn"));
				obj.setEname(rs.getString("ename"));
				// jobno: 110:FA, 120:FS, 95=>助理座艙長
				if ("110".equals(rs.getString("jobno"))) {
					obj.setOccu("FA");
				} else if ("120".equals(rs.getString("jobno"))) {
					obj.setOccu("FS");
				} else {
					obj.setOccu("");
				}
				obj.setSection(rs.getString("section"));
				obj.setSern(rs.getString("sern"));
				obj.setStation(rs.getString("station"));
				obj.setJobno(rs.getString("jobno"));
				obj.setGroup(rs.getString("groups"));
				obj.setStatus(rs.getString("status"));

			}
			setEgObj(obj);
			rs.close();
			pstmt.close();
			conn.close();
		} 
		catch (ClassNotFoundException e) 
		{
			System.out.println(e.toString());
		} 
		catch (SQLException e) 
		{
			System.out.println(e.toString());
		} 
		catch (Exception e) 
		{
			System.out.println(e.toString());
		} 
//		catch (InstantiationException e) 
//		{
//			System.out.println(e.toString());
//		} 
//		catch (IllegalAccessException e) 
//		{
//			System.out.println(e.toString());
//		}

		finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {
					System.out.println(e.toString());
				}
			if (pstmt != null)
				try {
					pstmt.close();
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

	public boolean isEGCrew() {
		return isEGCrew;
	}

	private void setEGCrew(boolean isEGCrew) {
		this.isEGCrew = isEGCrew;
	}

	public EGObj getEgObj() {
		if (null == egObj) {
			egObj = new EGObj();
		}
		return egObj;
	}

	private void setEgObj(EGObj egObj) {
		this.egObj = egObj;

		if (egObj == null) {
			setEGCrew(false);
		} else {
			setEGCrew(true);
		}
	}
}