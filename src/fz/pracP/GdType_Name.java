 /**
 * @author cs66 for �y�������i <br>
 *             1.���Ʈw��gdtype�Pgdname���ഫ <br>
 *             2.�Ǧ^�U�Ԧ���檺html�r��
 *  DB:orp3,connection pool
 * 	at:2004/12/30
 */
package fz.pracP;

import java.sql.*;
import ci.db.ConnDB;

public class GdType_Name {

/*		public static void main(String[] args){
		GdType_Name gd = new GdType_Name();
		gd.setStatement();
		System.out.println(gd.getComm());
		System.out.println(gd.getGdName("GD11"));
		System.out.println(gd.getGdType("���I"));
		System.out.println(gd.closeStatement());
		
	}*/

	private static ConnDB cn = new ConnDB();
	private Driver dbDriver = null; 
	private static Connection conn = null;
	private static Statement stmt = null;
	private static ResultSet rs = null;
	private static String gdName = null;
	private static String gdType = null;
	private String name_Type = "";
	private String comm = "";

	/**
	 * �إ߳s�u�A�Ǧ^Statement
	 * */
	public Statement setStatement() {
		try {
			cn.setORP3EGUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);

			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);

		} catch (Exception e) {

			e.printStackTrace();
			
		}
		return stmt;
	}

	/**
	 * �����s�u
	 */
	public String closeStatement() {

		try {
			try {if (rs != null)		rs.close();		} catch (SQLException e) {}
			try {if (stmt != null)	stmt.close();	} catch (SQLException e) {}
			try {if (conn != null) 	conn.close();	} catch (SQLException e) {}

		} catch (Exception e) {
			return e.toString();
		}finally{
			try {if (rs != null)		rs.close();		} catch (SQLException e) {}
			try {if (stmt != null)	stmt.close();	} catch (SQLException e) {}
			try {if (conn != null) 	conn.close();	} catch (SQLException e) {}			
		}
		return "ok";
	}

	/**
	 * @return Returns the comm. <br>
	 *            �Ǧ^ <option value="comm">comm</option> �Φ���String�A�Ω�HTML��檺�ﶵ
	 */
	public String getComm() {
		try {

			rs = stmt.executeQuery("SELECT * FROM egtgdcm");

			int rowCount = 0;
			String[] commArray = null;

			if (rs.next()) { //���Ƽƶq�B�H��l�ư}�C
				rs.last();
				rowCount = rs.getRow();
				commArray = new String[rowCount];
				rs.beforeFirst();
			}

			rowCount = 0;
			if (rs != null) {
				while (rs.next()) {
					//�Nitemno,item,��count���ƪ��ȡA��Jitemno[] ,item[]��counts[]��
					commArray[rowCount] = rs.getString("gdcomm");
					rowCount++;
				}
			}
			rs.close();
			for (int i = 0; i < commArray.length; i++) {
				comm += "<option value=\"" + commArray[i] + "\">"
						+ commArray[i]+"</option>\r\n";

			}

		} catch (Exception e) {
			comm = e.toString();
		}
		return comm;
	}
	/**
	 * @return name_Type <br>
	 *            �Ǧ^ <option value="gdtype">gdname �Φ���String�A�Ω�HTML��檺�ﶵ
	 */
	public String getName_Type() {

		try {

			rs = stmt
					.executeQuery("select * from egtgdtp ORDER BY To_Number(SubStr(gdtype,3))");

			int rowCount = 0;
			String[] gdtype = null;
			String[] gdname = null;

			if (rs.next()) { //���Ƽƶq�B�H��l�ư}�C
				rs.last();
				rowCount = rs.getRow();
				gdtype = new String[rowCount];
				gdname = new String[rowCount];
				rs.beforeFirst();
			}

			rowCount = 0;
			if (rs != null) {
				while (rs.next()) {
					//�Nitemno,item,��count���ƪ��ȡA��Jitemno[] ,item[]��counts[]��
					gdtype[rowCount] = rs.getString("gdtype");
					gdname[rowCount] = rs.getString("gdname");
					rowCount++;
				}
			}
			rs.close();
			for (int i = 0; i < gdtype.length; i++) {
				name_Type += "<option value=\"" + gdtype[i] + "\">" + gdname[i]
						+ "</optoin>\r\n";

			}

		} catch (Exception e) {
			name_Type = e.toString();
		}
		return name_Type;
	}
	/**
	 * �NGdType�ରGdName
	 * 
	 * @param GdType
	 * @return
	 */
	public String getGdName(String GdType) {

		try {

			String sql = "select * from egtgdtp where gdtype=upper('" + GdType
					+ "')";
			rs = stmt.executeQuery(sql);
			if (rs != null) {
				while (rs.next()) {
					gdName = rs.getString("gdname");
				}
			}

		} catch (Exception e) {
			gdName = e.toString();
		}

		return gdName;
	}

	/**
	 * @param GdName
	 *                �ǤJGdName
	 * @return gdType �Ǧ^GdType
	 */
	public String getGdType(String GdName) {

		try {
			String sql = "select * from egtgdtp where gdname=trim('" + GdName
					+ "')";
			rs = stmt.executeQuery(sql);
			if (rs != null) {
				while (rs.next()) {
					gdType = rs.getString("gdtype");
				}
			}

		} catch (Exception e) {
			gdType = e.toString();
		}

		return gdType;
	}
}