package fz.pracP;

import java.sql.*;

import ci.db.*;

/**
 * GetFltnoWithSuffix loccal date delay至隔天班次，班次+Z
 * 
 * 
 * @author cs66
 * @version 1.0 2006/8/20
 * 
 * Copyright: Copyright (c) 2006
 */
public class GetFltnoWithSuffix {
	private String fltno;
	private String flightDate;
	private String sector;
	private String actualDepatureDateTime; // format yyyy/mm/dd hh24mi
	private String fltnoWithSuffix;
	
	public static void main(String[] args)
    {
	    fz.pracP.GetFltnoWithSuffix gf = new fz.pracP.GetFltnoWithSuffix("20131028","0004Z","TPESFO","2013/10/28 00:05");
	    System.out.println(gf.getFltnoWithSuffix());
    }
	
	
	 
	public GetFltnoWithSuffix(String flightDate, String fltno, String sector,String actualDepatureDateTime) 
	{
		this.fltno = fltno;
		this.flightDate = flightDate;
		this.sector = sector;
		this.actualDepatureDateTime = actualDepatureDateTime;
		SelectData();		
	}

	public void SelectData() 
	{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		 ConnDB cn = new ConnDB();
		 Driver dbDriver = null;

		try {

//			 cn.setAOCIPRODCP();
//			 dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
//			 conn = dbDriver.connect(cn.getConnURL() ,null);
			 
			 cn.setAOCIPRODFZUser();
			 java.lang.Class.forName(cn.getDriver());
			 conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());
			 
			 //******************************************************************
			StringBuffer sb = new StringBuffer();		
			sb.append("SELECT count(*) c ");
			sb.append("FROM v_ittda13_ci da13 ");
			sb.append("WHERE  da13.da13_scdate_u   between ");
			sb.append("to_date(?,'yyyymmdd hh24:mi')-2 ");
			sb.append("AND To_Date(?,'yyyymmdd hh24:mi')+2 ");
			sb.append("AND da13.da13_etdl between ");
			sb.append("to_date(?,'yyyymmdd hh24:mi') ");
			sb.append("AND To_Date(?,'yyyymmdd hh24:mi') ");
//			sb.append("AND da13.da13_etdl = To_Date(?,'yyyy/mm/dd hh24:mi') ");
			sb.append("AND da13.da13_fltno=? ");
			sb.append("AND da13.da13_fm_sector||da13.da13_to_sector=? ");
//			
    		pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, flightDate + " 0000");
			pstmt.setString(2, flightDate + " 2359");
			pstmt.setString(3, flightDate + " 0000");
			pstmt.setString(4, flightDate + " 2359");
			//pstmt.setString(5, actualDepatureDateTime);
			pstmt.setString(5, fltno);
			pstmt.setString(6, sector);
		
			rs = pstmt.executeQuery();	
			int count =0;
			if(rs.next())
			{
			    count = rs.getInt("c");
			}			
		
			pstmt.clearParameters();
			sb = new  StringBuffer();		
			//******************************************************************
//			StringBuffer sb = new StringBuffer();
			sb.append("SELECT da13.da13_fltno|| ");
			sb.append("(CASE WHEN to_char(da13.da13_stdl,'dd') ");
			sb.append("<> to_char(da13.da13_atdl,'dd') ");
			sb.append("THEN 'Z'  ELSE ''   END) fltonZ ");
			sb.append("FROM v_ittda13_ci da13 ");
			sb.append("WHERE  da13.da13_scdate_u   between ");
			sb.append("to_date(?,'yyyymmdd hh24:mi')-2 ");
			sb.append("AND To_Date(?,'yyyymmdd hh24:mi')+2 ");
			sb.append("AND da13.da13_etdl between ");
			sb.append("to_date(?,'yyyymmdd hh24:mi') ");
			sb.append("AND To_Date(?,'yyyymmdd hh24:mi') ");
			sb.append("AND da13.da13_etdl = To_Date(?,'yyyy/mm/dd hh24:mi') ");
			sb.append("AND da13.da13_fltno=? ");
			sb.append("AND da13.da13_fm_sector||da13.da13_to_sector=? ");

			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, flightDate + " 0000");
			pstmt.setString(2, flightDate + " 2359");
			pstmt.setString(3, flightDate + " 0000");
			pstmt.setString(4, flightDate + " 2359");
			pstmt.setString(5, actualDepatureDateTime);
			pstmt.setString(6, fltno);
			pstmt.setString(7, sector);
//System.out.println(sb.toString());			
//System.out.println("suffix flightDate= "+ flightDate+" actualDepatureDateTime= "+actualDepatureDateTime+" fltno ="+ fltno);				
			rs = pstmt.executeQuery();			
			
			String f = fltno;
			while (rs.next()) 
			{
			    if(count >1)
			    {
			        f = rs.getString("fltonZ");
			    }
			}

			setFltnoWithSuffix(f);
		} catch (Exception e) {
			System.out.println(e.toString());
			e.printStackTrace();
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
	private void setFltnoWithSuffix(String fltnoWithSuffix) {
		this.fltnoWithSuffix = fltnoWithSuffix;
	}
	public String getFltnoWithSuffix() {
		return fltnoWithSuffix;
	}

}
