package fz.pracP.pa;

import java.sql.*;
import ci.db.*;

/**
 * @author cs71 Created on  2008/8/15
 */
public class GetPADuty_cd
{

    public static void main(String[] args)
    {
    }
    
	public String getDuty_cd(String empno, String fdate, String fltno, String sect) 
	{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ConnDB cn = new ConnDB();
		Driver dbDriver = null;
		String sql = "";
		String dutycd = "";
		try 
		{
			cn.setORP3EGUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);

			sql = " SELECT score FROM egtpads " +
				  " WHERE seqno = ( SELECT seqno FROM egtpadm WHERE fltd=To_Date('"+fdate+"','yyyy/mm/dd') " +
				  " AND fltno='"+fltno+"' AND sect = '"+sect+"' AND empno = '"+empno+"') AND scoretype =1 ";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			if (rs.next()) 
			{
				dutycd = rs.getString("score");
			}

			pstmt.close();
			rs.close();
			conn.close();
			return dutycd;

		} 
		catch (Exception e) 
		{
			System.out.println(e.toString());
			return e.toString();
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
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {

				}
				conn = null;
			}
		}
	}
}
