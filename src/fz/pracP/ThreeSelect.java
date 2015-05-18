 /**
 * @author cs66
 * 【三層選單】<br>
 * 傳回javascript的陣列字串，及選單的HTML字串<br>
 * DB:orp3, connection pool
 * 新版編碼方式
 * */
package fz.pracP;


import java.sql.*;

import ci.db.*;
public class ThreeSelect {
	
/*	public static void main(String[] args) {
		ThreeSelect ts = new ThreeSelect();
		ts.getStatement();
//		System.out.println(ts.select1());
		System.out.println(ts.getItem1());
//		System.out.println(ts.getItem2());
//		System.out.println(ts.getItem3());
////		
		ts.closeStatement();
		
	}*/
	
	
	private static ConnDB cn = new ConnDB();
	private Driver dbDriver = null;
	private static Connection conn = null;
	private static Statement stmt = null;
	private static ResultSet rs = null;	
	public String sql = null;
	public String msg = "";
	public String Item = "";
	
	public Statement getStatement() {
		try {

	      
			cn.setORP3EGUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);			
		

			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
		} catch (Exception e) {
			e.toString();
		}
		return stmt;
	}

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

	public String select1(){
		int rowCount = 0;
		int index = 0;
		int index2  = 0;
		
		
		try {
			sql = "SELECT ti.itemdsc,ti.itemno,count(*) counts FROM egtcmpi pi,egtcmti ti WHERE  pi.kin = ti.itemno "
					+ "GROUP BY ti.itemdsc,ti.itemno  ORDER BY ti.itemno ";
			
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				rs.last();
				rowCount = rs.getRow(); //抓資料筆數
				
				msg +="//初始化資料比數\r\n";
				msg += "array02 = new Array("+rowCount+");\r\n";
				msg += "array03 = new Array("+rowCount+");\r\n";
	
			}
//			System.out.println();
			while(rs.next()){

				msg += "array02["+(rs.getRow()-1)+"] = new Array("+ rs.getString("counts")+");\r\n";
			}
//			System.out.println();
			rs.beforeFirst();	
			while(rs.next()){
				msg += "array02["+(rs.getRow()-1)+"] = new Array("+ rs.getString("counts")+");\r\n";
				msg += "array03["+(rs.getRow()-1)+"] = new Array("+ rs.getString("counts")+");\r\n";
			}	
			rs.close();
//			System.out.println(msg);
			/*sql ="select ti.itemdsc,ti.itemno,b.itemno,a.itemdsc itemdsc2,Count(*) counts FROM egtcmpi a,egtcmpd b,egtcmti ti " +
			"WHERE a.itemno = b.itemno(+) AND a.kin = ti.itemno GROUP BY ti.itemdsc,ti.itemno,b.itemno,a.itemdsc ORDER BY 2"*/;
			sql = "select ti.itemno,ti.itemdsc,pi.itemdsc itemdsc2,pi.itemno,Count(*) counts " +
					"FROM egtcmti ti, egtcmpi pi, egtcmpd pd " +
					"WHERE ti.itemno=pi.kin(+) AND pi.itemno=pd.itemno(+) " +
					"GROUP BY ti.itemno,ti.itemdsc,pi.itemno,pi.itemdsc order by 1,4";
			
			rs = stmt.executeQuery(sql);
			msg += "\r\n//第二層陣列\r\n\r\n";
			while(rs.next()){
				
				if (!rs.isFirst()) {

					rs.previous();

					String pre = rs.getString("itemno");

					rs.next();
					String aft = rs.getString("itemno");
					if (!pre.equals(aft)) {
						index = 0;
					}
					
				} else {
					index = rs.getRow() - 1;
				}						
				
				msg += "array02[" + (this.getNumber(	rs.getString("itemno").substring(0,1) ) - 1) + "][" + index
						+ "]=\"" + rs.getString("itemdsc2") + "\";\r\n";

				msg += "array03[" + (this.getNumber(	rs.getString("itemno").substring(0,1) ) - 1) + "][" + index
						+ "]= new Array(" + rs.getString("counts") + ");\r\n";
				index++;
			}
	
			rs.close();
			
			index = 0;

			sql = "SELECT ti.itemdsc tdsc,ti.itemno tno,pi.itemdsc pdsc,pi.itemno pno,pd.itemdsc pddsc " +
					"FROM egtcmpi pi,egtcmpd pd,egtcmti ti " +
					"WHERE pi.itemno = pd.itemno(+) AND pi.kin = ti.itemno ORDER BY ti.itemno,pi.itemno";
			
			rs = stmt.executeQuery(sql);
			
			msg += "\r\n//第三層陣列\r\n\r\n";
			while(rs.next()){
				if (!rs.isFirst()) {
					rs.previous();
					String pre = rs.getString("pdsc");
					String pre2 = rs.getString("pno");
					String pre3 = rs.getString("tno");
					rs.next();
					String aft = rs.getString("pdsc");
					String aft2 = rs.getString("pno");
					String aft3 = rs.getString("tno");

					if (!pre.equals(aft)) {
						if(!pre3.equals(aft3)){
							index = 0;
						}
						else{
							index ++;//不一樣就加	
						}
						
					}
					
					if(!pre2.equals(aft2)){
						index2 = 0;
					}
					
				} else {
					index = rs.getRow() - 1;
					index2 = rs.getRow()-1;
				}
				
			
				if(rs.getString("pddsc") == null){
//					msg +="array03["+(rs.getInt("tno")-1)+"]["+index+"]["+index2+"]= \"請於附註說明\";\r\n";
//					
					msg +="array03["+(this.getNumber(rs.getString("tno"))-1)+"]["+index+"]["+index2+"]= \"請於附註說明\";\r\n";
				}else{
//					msg +="array03["+(rs.getInt("tno")-1)+"]["+index+"]["+index2+"]= \""+rs.getString("pddsc") +"\";\r\n";
					msg +="array03["+(this.getNumber(rs.getString("tno"))-1)+"]["+index+"]["+index2+"]= \""+rs.getString("pddsc") +"\";\r\n";
				}
				
				index2 ++;
			}
			rs.close();
		} catch (Exception e) {
			msg = e.toString();
		}
		
	 	return msg;
	} 

	/**
	 * 傳回 <option >item</option> 形式的String，用於第一層選單的選項
	 */

	public String getItem1() {
		Item = "";
		try {
			Item = "<!--第一層選單的預設值 -->\r\n";
			sql = "SELECT  itemdsc FROM egtcmti ORDER BY itemno";
			rs = stmt.executeQuery(sql);
			if(rs!= null){
				while(rs.next()){
					Item += "<option value=\""+rs.getString("itemdsc")+"\">"+rs.getString("itemdsc")+"</option>\r\n";
				}
			}
			
			rs.close();	
		} catch (Exception e) {
			return e.toString();
		}
		
		return Item;
	}

	/**
	 * 第二層選單的預設值
	 * 傳回<option>itemdsc</option>
	 * */
	public String getItem2() {
		Item = "";
		try {

			sql = "SELECT pi.itemdsc pdsc,pi.itemno pno FROM egtcmpi pi,egtcmti ti " +
					"WHERE  pi.kin = ti.itemno AND ti.itemno='A' ORDER BY pi.kin,pi.itemno";
		
			rs = stmt.executeQuery(sql);
			Item = "<!--第二層選單的預設值 -->\r\n";
			if(rs != null){
				while (rs.next()){
					Item += "<option value=\""+ rs.getString("pdsc")+"\">"+rs.getString("pdsc")+"</option>\r\n";
				}
			}

			rs.close();
		} catch (Exception e) {
			return e.toString();
		}
		return Item;

	}

	/**
	 * 第三層選單的預設值
	 * */
	public String getItem3() {
		Item = ""; 
		try {

			sql = "SELECT itemdsc FROM egtcmpd WHERE itemno='A01' ORDER BY itemno";
			rs = stmt.executeQuery(sql);
			
			Item = "<!--第三層選單的預設值 -->\r\n";
			int count=0;
			if(rs != null){
				while (rs.next()){
					Item += "<option value=\""+rs.getString("itemdsc")+"\">"+rs.getString("itemdsc")+"</option>\r\n";
					
					count ++;
				}
			}
			if(count ==0){
				Item += "<option value=\"請於附註說明\">請於附註說明</option>\r\n";
			}

			rs.close();
		} catch (Exception e) {
			return e.toString();
		}
		return Item;

	}

	
	/***
	 * 依照順序轉換英文字母與數字
	 * */
	
	public int getNumber(String character) {
		int number = 0;
		String charc = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		number = charc.indexOf(character.toUpperCase()) + 1;

		return number;
	}
}

