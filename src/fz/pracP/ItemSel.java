 /**
 *  for purser's report part II: Flt Irregularity <br>
 * �Ω�������ʺA��ܿ��<br>
 * 
 * @version 2 2006/2/18 DB: Connection Pool
 * �i��h���j
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
	 * �إ߳s�u
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
	 * �Ǧ^ <option value="itemno">item �Φ���String�A�Ω�Ĥ@�h��檺�ﶵ
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
			if (rs.next()) { //���Ƽƶq�B�H��l�ư}�C
				rs.last();
				rowCount = rs.getRow();
				itemno = new String[rowCount];
				item = new String[rowCount];
				rs.beforeFirst();
			}
			int i = 0;
			while (rs.next()) {
				//�Nitemno,item,��count���ƪ��ȡA��Jitemno[] ,item[]��counts[]��
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
	 * �Ǧ^detail[x]=["xxx","xxx"];���A��javascript�}�C�A �Ω�ĤG�h��檺�ﶵ
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

			if (rs.next()) { //���Ƽƶq�B�H��l�ư}�C
				rs.last();
				rowCount = rs.getRow();
				itemno = new String[rowCount];
				item = new String[rowCount];
				counts = new int[rowCount];
				rs.beforeFirst();
			}

			int i = 0; //itemno[] ��counts[]��length

			while (rs.next()) {
				//�Nitemno,item,��count���ƪ��ȡA��Jitemno[] ,item[]��counts[]��
				itemno[i] = rs.getString("itemno");
				counts[i] = rs.getInt("counts");
				item[i] = rs.getString("itemdsc");
				i++;
			}
			rs.close();

			details = new String[rowCount][];

			for (int j = 0; j < details.length; j++) { //��l��details[]������
				details[j] = new String[counts[j]];
			}

			String sqlB = "select a.itemno itemno,a.itemdsc item,b.itemdsc detail from egtcmpi a , egtcmpd b "
					+ "where b.itemno = a.itemno   ORDER BY 1,3";

			rs = stmt.executeQuery(sqlB);
			String strItemno = null;
			String strItem = null;
			String strDetail = null;

			int jj = 0; //index of details[x][jj]

			while (rs.next()) { //�N�Ȧs�Jdetails[][]
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
	 * �qitemdsc���oflag
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