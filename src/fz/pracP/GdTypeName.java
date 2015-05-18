package fz.pracP;

import java.sql.*;
import java.util.*;
import ci.db.*;

/**
 * GdTypeName 座艙長報告,個人考評部分的Comments選單及考評項目
 * 
 * 
 * @author cs66
 * @version 1.0 2006/8/10
 * 
 * Copyright: Copyright (c) 2006
 */
public class GdTypeName {

//	public static void main(String[] args) {
//		GdTypeName gn = new GdTypeName();
//		try {
//			gn.SelectData();
//		} catch (InstantiationException e) {
//			e.printStackTrace();
//		} catch (IllegalAccessException e) {
//			e.printStackTrace();
//		} catch (ClassNotFoundException e) {
//			e.printStackTrace();
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//		System.out.println(gn.getCommOptionList());
//		System.out.println("XXXX");
//		System.out.println(gn.getGdTypeOptionList());
//		System.out.println("XXXX");
//		System.out.println(gn.ConverGdTypeToName("GD1"));
//		System.out.println(gn.ConverGdNameToType("CCOM考核"));
//
//	}
	private String commOptionList;
	private String gdTypeOptionList;
	private ArrayList gdTypeAL;
	private ArrayList gdNameAL;
	private ArrayList commAL;

	public void SelectData() throws InstantiationException,
			IllegalAccessException, ClassNotFoundException, SQLException {

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		ConnDB cn = new ConnDB();
		Driver dbDriver = null;

		try {

			cn.setORP3EGUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);

			
			// 取得GDCOMM
			pstmt = conn.prepareStatement("SELECT * FROM egtgdcm");

			ArrayList al = new ArrayList();
			rs = pstmt.executeQuery();
			while (rs.next()) {
				al.add(rs.getString("gdcomm"));
			}

			setCommOptionList(al);
			setCommAL(al);
			pstmt.close();
			rs.close();

			// 取得 gdType;
			pstmt = conn
					.prepareStatement("select * from egtgdtp ORDER BY To_Number(SubStr(gdtype,3))");
			rs = pstmt.executeQuery();
			gdTypeAL = new ArrayList();
			gdNameAL = new ArrayList();
			while (rs.next()) {
				gdTypeAL.add(rs.getString("gdtype"));
				gdNameAL.add(rs.getString("gdname"));
			}
			setGdTypeOptionList(gdTypeAL, gdNameAL);
			pstmt.close();
			rs.close();

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

	public String getCommOptionList() {
		return commOptionList;
	}

	private void setCommOptionList(ArrayList al) {
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < al.size(); i++) {
			sb.append("<option value=\"");
			sb.append(al.get(i));
			sb.append("\">");
			sb.append(al.get(i));
			sb.append("</option>\r\n");
		}

		this.commOptionList = sb.toString();
	}

	public String getGdTypeOptionList() {
		return gdTypeOptionList;
	}

	/**
	 * 
	 * @param gdTypeAL
	 * @param gdNameAL
	 * 
	 */
	private void setGdTypeOptionList(ArrayList gdTypeAL, ArrayList gdNameAL) {
		if (gdTypeAL == null | gdNameAL == null)
			return;
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < gdTypeAL.size(); i++) {
			sb.append("<option value=\"");
			sb.append(gdTypeAL.get(i));
			sb.append("\">");
			sb.append(gdNameAL.get(i));
			sb.append("</option>\r\n");
		}
		this.gdTypeOptionList = sb.toString();
	}
	/**
	 * 將 gdType 轉換成 gdName
	 * 
	 * @param gdType
	 * @return gdName
	 * 
	 */
	public String ConverGdTypeToName(String gdType) {
		String str = "";

		int idx = 0;

		idx = gdTypeAL.indexOf(gdType.toUpperCase());
		if (idx != -1) {
			str = (String) gdNameAL.get(idx);
		}

		return str;
	}

	/**
	 * 將 gdName 轉換成 gdType
	 * 
	 * @param gdName
	 * @return gdType
	 * 
	 */
	public String ConverGdNameToType(String gdName) {
		String str = "";
		int idx = 0;

		idx = gdNameAL.indexOf(gdName.toUpperCase());
		if (idx != -1) {
			str = (String) gdTypeAL.get(idx);
		}
		return str;
	}

	public ArrayList getCommAL() {
		return commAL;
	}

	private void setCommAL(ArrayList commAL) {
		this.commAL = commAL;
	}
}
