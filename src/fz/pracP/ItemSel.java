 /**
 *  for purser's report part II: Flt Irregularity <br>
 * 用於網頁中動態顯示選單<br>
 * 
 * @version 2 2006/2/18 DB: Connection Pool
 * 【兩層選單】
 */
package fz.pracP;

import java.sql.*;

import ci.db.*;
public class ItemSel {

	private static ConnDB cn = new ConnDB();
	private static Connection conn = null;
	private static Statement stmt = null;
	private static ResultSet rs = null;
	private static Driver dbDriver = null;

	private String Item = "";

		public static void main(String[] args) {
	
	                    ItemSel sl = new ItemSel();
	                    sl.getStatement();
//	                    System.out.println(sl.getItem());
	                    System.out.println(sl.getItemStr());
	                   
	                   
	                   sl.closeStatement();
	            }

	/**
	 * 建立連線
	 */
	public Statement getStatement() {
		try {
//			cn.setORT1EG();
//			java.lang.Class.forName(cn.getDriver());
//
//			conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),
//					cn.getConnPW());
		    cn.setORP3EGUserCP();
		    dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
		    conn = dbDriver.connect(cn.getConnURL(), null);


			stmt = conn.createStatement();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return stmt;
	}

	/**
	 * 關閉連線
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
	 * 傳回 <option value="itemno">item 形式的String，用於第一層選單的選項
	 */

	public String getItem() {
		Item = "";
		try {

			String sqlsta = "select b.itemno,a.itemdsc,Count(*) counts FROM egtcmpi a,egtcmpd b "
					+ "WHERE a.itemno = b.itemno  GROUP BY b.itemno,a.itemdsc ORDER BY 1";

			rs = stmt.executeQuery(sqlsta);
			int rowCount = 0;
			String[] itemno = null;
			String[] item = null;
			if (rs.next()) { //抓資料數量、以初始化陣列
				rs.last();
				rowCount = rs.getRow();
				itemno = new String[rowCount];
				item = new String[rowCount];
				rs.beforeFirst();
			}
			int i = 0;
			while (rs.next()) {
				//將itemno,item,及count次數的值，塞入itemno[] ,item[]及counts[]中
				itemno[i] = rs.getString("itemno");
				item[i] = rs.getString("itemdsc");
				i++;
			}

			for (int j = 0; j < itemno.length; j++) {
				Item += "<option value=\"" + itemno[j] + "\">" + item[j]+"</option>\r\n";

			}

		} catch (Exception e) {
			return e.toString();
		}

		return Item;
	}

	/*
	 * 傳回detail[x]=["xxx","xxx"];型態的javascript陣列， 用於第二層選單的選項
	 */

	public String getItemStr() {
		Item = "";
		try {

			String sqlsta = "select b.itemno,a.itemdsc,Count(*) counts FROM egtcmpi a,egtcmpd b "
					+ "WHERE a.itemno = b.itemno  GROUP BY b.itemno,a.itemdsc ORDER BY 1";

			rs = stmt.executeQuery(sqlsta);

			int rowCount = 0;

			String[] itemno = null;
			String[] item = null;
			int[] counts = null;
			String[][] details = null;

			if (rs.next()) { //抓資料數量、以初始化陣列
				rs.last();
				rowCount = rs.getRow();
				itemno = new String[rowCount];
				item = new String[rowCount];
				counts = new int[rowCount];
				rs.beforeFirst();
			}

			int i = 0; //itemno[] 及counts[]的length

			while (rs.next()) {
				//將itemno,item,及count次數的值，塞入itemno[] ,item[]及counts[]中
				itemno[i] = rs.getString("itemno");
				counts[i] = rs.getInt("counts");
				item[i] = rs.getString("itemdsc");
				i++;
			}
			rs.close();

			details = new String[rowCount][];

			for (int j = 0; j < details.length; j++) { //初始化details[]的長度
				details[j] = new String[counts[j]];
			}

			String sqlB = "select a.itemno itemno,a.itemdsc item,b.itemdsc detail from egtcmpi a , egtcmpd b "
					+ "where b.itemno = a.itemno   ORDER BY 1,3";

			rs = stmt.executeQuery(sqlB);
			String strItemno = null;
			String strItem = null;
			String strDetail = null;

			int jj = 0; //index of details[x][jj]

			while (rs.next()) { //將值存入details[][]
				strItemno = rs.getString("itemno");
				strItem = rs.getString("item");
				strDetail = rs.getString("detail");

				for (i = 0; i < itemno.length; i++) {
					if (strItemno.equals(itemno[i])) {
						jj++;
						break;
					}
				}
				details[i][jj - 1] = strDetail;
				if (jj == counts[i])
					jj = 0;

			}

			String StrA = "";

			for (int d = 0; d < details.length; d++) {

				for (int e = 0; e < details[d].length; e++) {

					if (e == 0) {
						StrA = "\"" + details[d][e].toString() + "\"";
					} else {
						StrA += ",\"" + details[d][e].toString() + "\"";
					}

				}
				Item += "detail[" + d + "] =[" + StrA + "];\r\n";

			}

		} catch (Exception e) {
			return e.toString();
		}
		return Item;

	}

	/**
	 * 從itemdsc取得flag
	 * 
	 * @return itemFlag
	 */
	public String getItemFlag(String itemdsc) {
		Item = "";

		try {

			rs = stmt.executeQuery("select flag from egtcmpi where itemdsc='"
					+ itemdsc + "'");
			if (rs != null) {
				while (rs.next()) {
					Item = rs.getString("flag");
				}
			}

		} catch (Exception e) {
			return e.toString();
		}
		return Item;
	}
}