 /**
 * @author cs66
 * 【三層選單】<br>
 * modified at 2004/12/14<br>
 * 做成.jsp的檔案，用include的方式在網頁中顯示<br>
 * 傳回javascript的陣列字串，及選單的HTML字串<br>
 * DB:orp3,connection pool
 * modified at 2004/12/30,
 * 新版編碼方式
 * @version 2 2006/2/18 AirCrews版 更改檔案路徑
 * 
 * */
package fz.pracP;


import java.io.*;
import java.sql.*;

import ci.db.*;
public class Select 
{
	
	public static void main(String[] args) 
	{		
		try {
			Select ts = new Select();
			ts.getStatement();
			System.out.println(ts.select1());
			System.out.println(ts.getItem1());
			System.out.println(ts.getItem2());
			System.out.println(ts.getItem3());
			
			ts.closeStatement();
//			System.out.println(ts.getNumber("Z"));
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println(e.toString());
		}
		
	}
	
	
	private static ConnDB cn = new ConnDB();
	private Driver dbDriver = null;

	private static Connection conn = null;
	private static Statement stmt = null;
	private static ResultSet rs = null;	
	private String sql = null;
	private String msg = "";
	private String msg2 = "";
	private String Item = "";
	private String Item2 = "";
	private java.util.ArrayList seqAL = new java.util.ArrayList();
	FileWriter fw = null;
	FileWriter fw1 = null;
	FileWriter fw2 = null;
	FileWriter fw3 = null;
	
	FileWriter fw4 = null;
	FileWriter fw5 = null;
	FileWriter fw6 = null;
	FileWriter fw7 = null;
	
	public Statement getStatement() 
	{
		try {
			//EG Connection pool
			cn.setORP3EGUserCP();
			dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
			
//		    EGConnDB cn = new EGConnDB();
//            cn.setORP3EGUser(); 
////		    cn.setORT1EG();
//	    	java.lang.Class.forName(cn.getDriver());
//	    	conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(), cn.getConnPW());  
//	    	stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
		
//			TODO file path
			fw = new FileWriter("/apsource/csap/projfz/webap/FZ/PRAC/select.jsp",false);
			fw1 = new FileWriter("/apsource/csap/projfz/webap/FZ/PRAC/select1.jsp",false);
			fw2 = new FileWriter("/apsource/csap/projfz/webap/FZ/PRAC/select2.jsp",false);
			fw3 = new FileWriter("/apsource/csap/projfz/webap/FZ/PRAC/select3.jsp",false);
			
			fw4 = new FileWriter("/apsource/csap/projfz/webap/FZ/PRAC/ZC/select.jsp",false);
			fw5 = new FileWriter("/apsource/csap/projfz/webap/FZ/PRAC/ZC/select1.jsp",false);
			fw6 = new FileWriter("/apsource/csap/projfz/webap/FZ/PRAC/ZC/select2.jsp",false);
			fw7 = new FileWriter("/apsource/csap/projfz/webap/FZ/PRAC/ZC/select3.jsp",false);		
			
//			 fw = new FileWriter("C:\\select.jsp",false);
//			 fw1 = new FileWriter("C:\\select1.jsp",false);
//			 fw2 = new FileWriter("C:\\select2.jsp",false);
//			 fw3 = new FileWriter("C:\\select3.jsp",false);
//			 fw4 = new FileWriter("C:\\select_.jsp",false);
//			 fw5 = new FileWriter("C:\\select1_.jsp",false);
//			 fw6 = new FileWriter("C:\\select2_.jsp",false);
//			 fw7 = new FileWriter("C:\\select3_.jsp",false);			
			
			 
			 fw.write("<%@ page contentType=\"text/html; charset=big5\" language=\"java\" %>\r\n<%");
			 fw1.write("<%@ page contentType=\"text/html; charset=big5\" language=\"java\" %>\r\n<%");
			 fw2.write("<%@ page contentType=\"text/html; charset=big5\" language=\"java\" %>\r\n<%");
			 fw3.write("<%@ page contentType=\"text/html; charset=big5\" language=\"java\" %>\r\n<%");
			 fw4.write("<%@ page contentType=\"text/html; charset=big5\" language=\"java\" %>\r\n<%");
			 fw5.write("<%@ page contentType=\"text/html; charset=big5\" language=\"java\" %>\r\n<%");
			 fw6.write("<%@ page contentType=\"text/html; charset=big5\" language=\"java\" %>\r\n<%");
			 fw7.write("<%@ page contentType=\"text/html; charset=big5\" language=\"java\" %>\r\n<%");
			
		} 
		catch (Exception e) 
		{
			e.toString();
		}
		return stmt;
	}

	public String closeStatement() {

		try 
		{
			rs.close();
			stmt.close();
			conn.close();
			stmt = null;
			conn = null;
			
			fw.write("\r\n%>");
			fw1.write("\r\n%>");
			fw2.write("\r\n%>");
			fw3.write("\r\n%>");
			
			fw4.write("\r\n%>");
			fw5.write("\r\n%>");
			fw6.write("\r\n%>");
			fw7.write("\r\n%>");
			
			fw.flush();
			fw1.flush();
			fw2.flush();
			fw3.flush();
			fw4.flush();
			fw5.flush();
			fw6.flush();
			fw7.flush();
			
			fw.close();
			fw1.close();
			fw2.close();
			fw3.close();
			fw4.close();
			fw5.close();
			fw6.close();
			fw7.close();				
		} 
		catch (Exception e) 
		{
			return e.toString();
		}
		finally
		{			
		    try{fw.flush();}catch(Exception e){}
	        try{if(fw != null) fw.close();}catch(Exception e){}			
		    try{fw1.flush();}catch(Exception e){}
	        try{if(fw1 != null) fw1.close();}catch(Exception e){}			
		    try{fw2.flush();}catch(Exception e){}
	        try{if(fw2 != null) fw2.close();}catch(Exception e){}			
		    try{fw3.flush();}catch(Exception e){}
	        try{if(fw3 != null) fw3.close();}catch(Exception e){}	
	        
	        try{fw4.flush();}catch(Exception e){}
	        try{if(fw4 != null) fw4.close();}catch(Exception e){}			
		    try{fw5.flush();}catch(Exception e){}
	        try{if(fw5 != null) fw5.close();}catch(Exception e){}			
		    try{fw6.flush();}catch(Exception e){}
	        try{if(fw6 != null) fw6.close();}catch(Exception e){}			
		    try{fw7.flush();}catch(Exception e){}
	        try{if(fw7 != null) fw7.close();}catch(Exception e){}		        
        
			try {if (rs != null)		rs.close();		} catch (SQLException e) {}
			try {if (stmt != null)	stmt.close();	} catch (SQLException e) {}
			try {if (conn != null) 	conn.close();	} catch (SQLException e) {}
		}
		return "ok";
	}

	public String select1()
	{
		int rowCount = 0;
		int index = 0;
		int index2  = 0;
		
		
		try 
		{
//			sql = " SELECT ti.itemdsc,ti.itemno,count(*) counts FROM egtcmpi pi,egtcmti ti " +
//				  " WHERE  pi.kin = ti.itemno " +
//				  " GROUP BY ti.itemdsc,ti.itemno  ORDER BY ti.itemno ";
			
			//New Category
			sql = " SELECT ti.itemdsc,ti.itemno,count(*) counts FROM egtcmpi pi,egtcmti ti " +
				  " WHERE  pi.kin = ti.itemno and pi.extflag IS null " +
				  " GROUP BY ti.itemdsc,ti.itemno  ORDER BY ti.itemno ";
			
			rs = stmt.executeQuery(sql);
			if (rs.next()) 
			{
				rs.last();
				rowCount = rs.getRow(); //抓資料筆數				

				msg +="out.println(\"//初始化資料比數\");\r\n";
				msg += "out.println(\"array02 = new Array("+rowCount+");\");\r\n";
				msg += "out.println(\"array03 = new Array("+rowCount+");\");\r\n";	
			}
//			System.out.println();
			while(rs.next())
			{
				msg += "out.println(\"array02["+(rs.getRow()-1)+"] = new Array("+ rs.getString("counts")+");\");\r\n";				
			}
//			System.out.println();
			rs.beforeFirst();	
			while(rs.next())
			{
				msg += "out.println(\"array02["+(rs.getRow()-1)+"] = new Array("+ rs.getString("counts")+");\");\r\n";
				msg += "out.println(\"array03["+(rs.getRow()-1)+"] = new Array("+ rs.getString("counts")+");\");\r\n";
			}	
			rs.close();
//			System.out.println(msg);
//			*******************************************************************************************
			rowCount =0;
//			sql = " SELECT ti.itemdsc,ti.itemno,count(*) counts FROM egtcmpi pi,egtcmti ti " +
//				  " WHERE  pi.kin = ti.itemno and pi.flag = '1' and pi.zcflag = 'Y' " +
//				  " GROUP BY ti.itemdsc,ti.itemno  ORDER BY ti.itemno ";
			
			sql = " SELECT ti.itemdsc,ti.itemno,count(*) counts FROM egtcmpi pi,egtcmti ti " +
				  " WHERE  pi.kin = ti.itemno and pi.flag = '1' and pi.zcflag = 'Y' and pi.extflag IS null " +
				  " GROUP BY ti.itemdsc,ti.itemno  ORDER BY ti.itemno ";
		
			rs = stmt.executeQuery(sql);			
			
			if (rs.next()) 
			{
				rs.last();
				rowCount = rs.getRow(); //抓資料筆數				
	
				msg2 +="out.println(\"//初始化資料比數\");\r\n";
				msg2 += "out.println(\"array02 = new Array("+rowCount+");\");\r\n";
				msg2 += "out.println(\"array03 = new Array("+rowCount+");\");\r\n";			
			}
//		System.out.println();
			while(rs.next())
			{			   
				msg2 += "out.println(\"array02["+(rs.getRow()-1)+"] = new Array("+ rs.getString("counts")+");\");\r\n";			
			}
//		System.out.println();
			rs.beforeFirst();	
			while(rs.next())
			{
				msg2 += "out.println(\"array02["+(rs.getRow()-1)+"] = new Array("+ rs.getString("counts")+");\");\r\n";
				msg2 += "out.println(\"array03["+(rs.getRow()-1)+"] = new Array("+ rs.getString("counts")+");\");\r\n";			
			}	
			rs.close();
			
			sql = " SELECT ti.itemdsc,ti.itemno,count(*) counts FROM egtcmpi pi,egtcmti ti " +
			       " WHERE  pi.kin = ti.itemno and pi.flag = '1' and pi.zcflag = 'Y' and pi.extflag IS null " +
			       " GROUP BY ti.itemdsc,ti.itemno  ORDER BY ti.itemno ";
	
		    rs = stmt.executeQuery(sql);		
			
		    while(rs.next())
		    {
		        seqAL.add(rs.getString("itemno"));
		    }
		    rs.close();
		//*******************************************************************************************
//			sql = "select ti.itemno,ti.itemdsc,pi.itemdsc itemdsc2,pi.itemno, Count(*) counts " +
//					"FROM egtcmti ti, egtcmpi pi, egtcmpd pd " +
//					"WHERE ti.itemno=pi.kin(+) AND pi.itemno=pd.itemno(+) " +
//					"GROUP BY ti.itemno,ti.itemdsc,pi.itemno,pi.itemdsc order by 1,4";
			
//			sql = "select ti.itemno,ti.itemdsc,pi.itemdsc itemdsc2,pi.itemno, Count(*) counts " +
//				  "FROM egtcmti ti, egtcmpi pi, egtcmpd pd " +
//				  "WHERE ti.itemno=pi.kin(+) AND pi.itemno=pd.itemno(+) " +
//				  "and pi.extflag IS null and pd.extflag IS null " +
//				  "GROUP BY ti.itemno,ti.itemdsc,pi.itemno,pi.itemdsc order by 1,4 ";
			
			sql = "select ti.itemno,ti.itemdsc,pi.itemdsc itemdsc2,pi.itemno, Count(*) counts " +
				  "FROM egtcmti ti, egtcmpi pi, egtcmpd pd " +
				  "WHERE ti.itemno=pi.kin(+) AND pi.itemno=pd.itemno(+) " +
				  "and pi.extflag IS null " +
				  "GROUP BY ti.itemno,ti.itemdsc,pi.itemno,pi.itemdsc order by 1,4 ";
			
			rs = stmt.executeQuery(sql);
			msg += "\r\nout.println(\"//第二層陣列\");\r\n\r\n";
			
			while(rs.next())
			{				
				if (!rs.isFirst()) 
				{
					rs.previous();

					String pre = rs.getString("itemno");

					rs.next();
					String aft = rs.getString("itemno");
					if (!pre.equals(aft)) 
					{
						index = 0;
					}					
				} 
				else 
				{
					index = rs.getRow() - 1;
				}						
				
				msg += "out.println(\"array02[" + (this.getNumber(	rs.getString("itemno").substring(0,1) ) - 1) + "][" + index
						+ "]=\\\"" + rs.getString("itemdsc2") + "\\\";\");\r\n";

				msg += "out.println(\"array03[" + (this.getNumber(	rs.getString("itemno").substring(0,1) ) - 1) + "][" + index
						+ "]= new Array(" + rs.getString("counts") + ");\");\r\n";
				index++;
			}	
			rs.close();
			//*******************************************************************************************
			index =0;
//			sql = " select ti.itemno,ti.itemdsc,pi.itemdsc itemdsc2,pi.itemno, Count(*) counts " +
//					"FROM egtcmti ti, egtcmpi pi, egtcmpd pd " +
//					"WHERE ti.itemno=pi.kin(+) AND pi.itemno=pd.itemno(+) and pi.flag = '1' " +
//					"GROUP BY ti.itemno,ti.itemdsc,pi.itemno,pi.itemdsc order by 1,4 ";
			
			sql = " select ti.itemno,ti.itemdsc,pi.itemdsc itemdsc2,pi.itemno, Count(*) counts " +
				  "FROM egtcmti ti, egtcmpi pi, egtcmpd pd " +
				  "WHERE ti.itemno=pi.kin(+) AND pi.itemno=pd.itemno(+) and pi.flag = '1' " +
				  "and pi.zcflag = 'Y' " +
				  "GROUP BY ti.itemno,ti.itemdsc,pi.itemno,pi.itemdsc order by 1,4 ";
			
			
			rs = stmt.executeQuery(sql);
			msg2 += "\r\nout.println(\"//第二層陣列\");\r\n\r\n";
			
			while(rs.next())
			{				
				if (!rs.isFirst()) 
				{
					rs.previous();
					String pre = rs.getString("itemno");

					rs.next();
					String aft = rs.getString("itemno");
					if (!pre.equals(aft)) 
					{
						index = 0;
					}					
				} 
				else 
				{
					index = rs.getRow() - 1;
				}						
				
				msg2 += "out.println(\"array02[" + (this.getNumber2(rs.getString("itemno").substring(0,1) )) + "][" + index
						+ "]=\\\"" + rs.getString("itemdsc2") + "\\\";\");\r\n";

				msg2 += "out.println(\"array03[" + (this.getNumber2(rs.getString("itemno").substring(0,1) )) + "][" + index
						+ "]= new Array(" + rs.getString("counts") + ");\");\r\n";
				index++;
			}
	
			rs.close();			
//			*******************************************************************************************			
			index = 0;
			index2 = 0;
			boolean hasnoneitem = false;//相同的pd.itemno 是否已有 請於附註說明

//			sql = "SELECT ti.itemdsc tdsc,ti.itemno tno,pi.itemdsc pdsc,pi.itemno pno,pd.itemdsc pddsc " +
//				  "FROM egtcmpi pi,egtcmpd pd,egtcmti ti " +
//				  "WHERE pi.itemno = pd.itemno(+) AND pi.kin = ti.itemno " +
//				  "ORDER BY ti.itemno,pi.itemno ";
			
			sql = "SELECT ti.itemdsc tdsc,ti.itemno tno,pi.itemdsc pdsc,pi.itemno pno,pd.itemdsc pddsc, pd.extflag " +
				  "FROM egtcmpi pi,egtcmpd pd,egtcmti ti " +
				  "WHERE pi.itemno = pd.itemno(+) AND ti.itemno = pi.kin (+) " +
//				  "and pi.extflag IS null and pd.extflag IS null " +
				  "and pi.extflag IS null " +
				  "ORDER BY ti.itemno,pi.itemno,pd.itemdsc ";
			
			
			rs = stmt.executeQuery(sql);
			
			msg += "out.println(\"//第三層陣列\");\r\n\r\n";
			while(rs.next())
			{
				if (!rs.isFirst()) 
				{
					rs.previous();
					String pre = rs.getString("pdsc");
					String pre2 = rs.getString("pno");
					String pre3 = rs.getString("tno");
					rs.next();
					String aft = rs.getString("pdsc");
					String aft2 = rs.getString("pno");
					String aft3 = rs.getString("tno");

					if (!pre.equals(aft)) 
					{
						if(!pre3.equals(aft3))
						{
							index = 0;
						}
						else
						{
							index ++;//不一樣就加	
						}						
					}
					
					if(!pre2.equals(aft2))
					{
						index2 = 0;
						hasnoneitem = false;						
					}
					
				} 
				else 
				{
					index = rs.getRow() - 1;
					index2 = rs.getRow()-1;
				}
				
			
				if(null == rs.getString("pddsc") | "N".equals(rs.getString("extflag")))
				{
//					msg +="array03["+(rs.getInt("tno")-1)+"]["+index+"]["+index2+"]= \"請於附註說明\";\r\n";
//					
				    if(hasnoneitem==false)
				    {
				        msg +="out.println(\"array03["+(this.getNumber(rs.getString("tno"))-1)+"]["+index+"]["+index2+"]= \\\"請於附註說明\\\";\");\r\n";
				        hasnoneitem = true;		
				    }
				    else
				    {
				        index2--;
				    }
				}
				else
				{
//					msg +="out.println(\"array03["+(rs.getInt("tno")-1)+"]["+index+"]["+index2+"]= \""+rs.getString("pddsc") +"\";\r\n";
					msg +="out.println(\"array03["+(this.getNumber(rs.getString("tno"))-1)+"]["+index+"]["+index2+"]= \\\""+rs.getString("pddsc") +"\\\";\");\r\n";
				}
				
				index2 ++;
			}
			rs.close();
			
//			*******************************************************************************************			
			index = 0;
			index2 = 0;
			hasnoneitem = false;//相同的pd.itemno 是否已有 請於附註說明
//			sql = "SELECT ti.itemdsc tdsc,ti.itemno tno,pi.itemdsc pdsc,pi.itemno pno,pd.itemdsc pddsc " +
//				  "FROM egtcmpi pi,egtcmpd pd,egtcmti ti " +
//				  "WHERE pi.itemno = pd.itemno(+) AND pi.kin = ti.itemno and pi.flag='1' and pi.zcflag = 'Y' " +
//				  "ORDER BY ti.itemno,pi.itemno";
			
			sql = "SELECT ti.itemdsc tdsc,ti.itemno tno,pi.itemdsc pdsc,pi.itemno pno,pd.itemdsc pddsc, pd.extflag " +
				  "FROM egtcmpi pi,egtcmpd pd,egtcmti ti " +
				  "WHERE pi.itemno = pd.itemno(+) AND pi.kin = ti.itemno and pi.flag='1' and pi.zcflag = 'Y' " +
				  "and pi.extflag IS null " +
//				  "and pd.extflag IS null " +
				  "ORDER BY ti.itemno,pi.itemno";
			
			rs = stmt.executeQuery(sql);
			
			msg2 += "out.println(\"//第三層陣列\");\r\n\r\n";
			while(rs.next())
			{
				if (!rs.isFirst()) 
				{
					rs.previous();
					String pre = rs.getString("pdsc");
					String pre2 = rs.getString("pno");
					String pre3 = rs.getString("tno");
					rs.next();
					String aft = rs.getString("pdsc");
					String aft2 = rs.getString("pno");
					String aft3 = rs.getString("tno");

					if (!pre.equals(aft)) 
					{
						if(!pre3.equals(aft3))
						{
							index = 0;
						}
						else
						{
							index ++;//不一樣就加	
						}						
					}
					
					if(!pre2.equals(aft2))
					{
						index2 = 0;
						hasnoneitem = false;	
					}
					
				} 
				else 
				{
					index = rs.getRow() - 1;
					index2 = rs.getRow()-1;
				}
				
			
				//if(null == rs.getString("pddsc"))
				if(null == rs.getString("pddsc") | "N".equals(rs.getString("extflag"))) 
				{					
//					msg2 +="out.println(\"array03["+(this.getNumber2(rs.getString("tno")))+"]["+index+"]["+index2+"]= \\\"請於附註說明\\\";\");\r\n";
					
					if(hasnoneitem==false)
				    {
					    msg2 +="out.println(\"array03["+(this.getNumber2(rs.getString("tno")))+"]["+index+"]["+index2+"]= \\\"請於附註說明\\\";\");\r\n";
				        hasnoneitem = true;		
				    }
				    else
				    {
				        index2--;
				    }
				}
				else
			    {
					msg2 +="out.println(\"array03["+(this.getNumber2(rs.getString("tno")))+"]["+index+"]["+index2+"]= \\\""+rs.getString("pddsc") +"\\\";\");\r\n";
				}
				
				index2 ++;
			}
			rs.close();

			fw.write(msg);
			fw4.write(msg2);	
//			System.out.println(msg2);
		} catch (Exception e) {
			msg = e.toString();
		}
		
	 	return "0";
	} 

	/**
	 * 傳回 <option value="item">item</option> 形式的String，用於第一層選單的選項
	 */

	public String getItem1() 
	{
		Item = "";
		Item2 = "";
		try 
		{
			Item = "out.println(\"<!--第一層選單的預設值 -->\");\r\n";
			sql = "SELECT  itemdsc FROM egtcmti ORDER BY itemno";
			rs = stmt.executeQuery(sql);
			if(rs!= null)
			{
				while(rs.next())
				{
					Item += "out.println(\"<option value=\\\""+rs.getString("itemdsc")+"\\\">"+rs.getString("itemdsc")+"</option>\");\r\n";					
				}
			}	
			//*******************************************************************************
			Item2 = "out.println(\"<!--第一層選單的預設值 -->\");\r\n";
//			sql = " SELECT * FROM( SELECT ti.itemdsc, ti.itemno FROM egtcmpi pi, egtcmti ti " +
//				   " WHERE pi.flag = '1' and pi.zcflag = 'Y' AND pi.kin = ti.itemno " +
//				   " GROUP BY ti.itemdsc, ti.itemno ) ORDER BY itemno ";
			
			sql = " SELECT * FROM( SELECT ti.itemdsc, ti.itemno FROM egtcmpi pi, egtcmti ti " +
				   " WHERE pi.flag = '1' and pi.zcflag = 'Y' AND pi.kin = ti.itemno and pi.extflag IS null " +
				   " GROUP BY ti.itemdsc, ti.itemno ) ORDER BY itemno ";
			rs = stmt.executeQuery(sql);
			if(rs!= null)
			{
				while(rs.next())
				{					 
					Item2 += "out.println(\"<option value=\\\""+rs.getString("itemdsc")+"\\\">"+rs.getString("itemdsc")+"</option>\");\r\n";
				}
			}	
			
			fw1.write(Item);
			fw5.write(Item2);			
			rs.close();	
		} 
		catch (Exception e) 
		{
			return e.toString();
		}
		
		return "0";
	}

	/**
	 * 第二層選單的預設值
	 * 傳回<option value="itemdsc">itemdsc</option>
	 * */
	public String getItem2() 
	{
		Item = "";
		Item2 = "";
		try 
		{
//			sql = "SELECT pi.itemdsc pdsc,pi.itemno pno FROM egtcmpi pi,egtcmti ti " +
//					"WHERE  pi.kin = ti.itemno AND ti.itemno='A'  " +
//					"ORDER BY pi.kin,pi.itemno";
			
			sql = "SELECT pi.itemdsc pdsc,pi.itemno pno FROM egtcmpi pi,egtcmti ti " +
				  "WHERE  pi.kin = ti.itemno AND ti.itemno='A' and pi.extflag IS null " +
				  "ORDER BY pi.kin,pi.itemno";
		
			rs = stmt.executeQuery(sql);
			Item = "out.println(\"<!--第二層選單的預設值 -->\");\r\n";
			if(rs != null)
			{
				while (rs.next())
				{					
					Item += "out.println(\"<option value=\\\""+rs.getString("pdsc")+"\\\">"+rs.getString("pdsc")+"</option>\");\r\n";					
				}
			}
			
			//*************************************************************************************
			rs.close();
			
//			sql = "SELECT pi.itemdsc pdsc,pi.itemno pno FROM egtcmpi pi,egtcmti ti " +
//				  "WHERE  pi.kin = ti.itemno AND ti.itemno='A' and pi.flag = '1' and pi.zcflag = 'Y' " +
//				  "ORDER BY pi.kin,pi.itemno";
			
			sql = "SELECT pi.itemdsc pdsc,pi.itemno pno FROM egtcmpi pi,egtcmti ti " +
				  "WHERE  pi.kin = ti.itemno AND ti.itemno='A' and pi.flag = '1' and pi.zcflag = 'Y' " +
				  "and pi.extflag IS null " +
				  "ORDER BY pi.kin,pi.itemno";

			rs = stmt.executeQuery(sql);
			Item2 = "out.println(\"<!--第二層選單的預設值 -->\");\r\n";
			if(rs != null)
			{
				while (rs.next())
				{					
					Item2 += "out.println(\"<option value=\\\""+rs.getString("pdsc")+"\\\">"+rs.getString("pdsc")+"</option>\");\r\n";					
				}
			}
			
			fw2.write(Item);
			fw6.write(Item2);
			rs.close();
		} catch (Exception e) {
			return e.toString();
		}
		return "0";

	}

	/**
	 * 第三層選單的預設值
	 * */
	public String getItem3() 
	{
		Item = "";
		Item2 = "";
		try 
		{
//			sql = "SELECT itemdsc FROM egtcmpd WHERE itemno='A01' ORDER BY itemno";
			sql = "SELECT itemdsc FROM egtcmpd WHERE itemno='A01' and extflag IS null ORDER BY itemno";
			rs = stmt.executeQuery(sql);
			
			Item = "out.println(\"<!--第三層選單的預設值 -->\");\r\n";
			int count=0;
			if(rs != null){
				while (rs.next()){
					
					Item += "out.println(\"<option value=\\\""+rs.getString("itemdsc")+"\\\">"+rs.getString("itemdsc")+"</option>\");\r\n";					
					
					count ++;
				}
			}
			if(count ==0)
			{
				Item += "out.println(\"<option value=\\\"請於附註說明\\\">請於附註說明</option>\");\r\n";
			}
			
			rs.close();
			//*******************************************************************************************
//			sql = "SELECT itemdsc FROM egtcmpd WHERE itemno='A01' ORDER BY itemno";
			sql = "SELECT itemdsc FROM egtcmpd WHERE itemno='A01' and extflag IS null ORDER BY itemno";
			rs = stmt.executeQuery(sql);
			
			Item2 = "out.println(\"<!--第三層選單的預設值 -->\");\r\n";
			count=0;
			if(rs != null)
			{
				while (rs.next())
				{
					
					Item2 += "out.println(\"<option value=\\\""+rs.getString("itemdsc")+"\\\">"+rs.getString("itemdsc")+"</option>\");\r\n";					
					
					count ++;
				}
			}
			if(count ==0)
			{
				Item2 += "out.println(\"<option value=\\\"請於附註說明\\\">請於附註說明</option>\");\r\n";
			}
			
			fw3.write(Item);
			fw7.write(Item2);
			rs.close();
		} catch (Exception e) {
			return e.toString();
		}
		return "0";

	}

	
	/***
	 * 依照順序轉換英文字母與數字
	 * */
	
	public int getNumber(String character) 
	{
		int number = 0;
		String charc = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		number = charc.indexOf(character.toUpperCase()) + 1;

		return number;
	}
	
	public int getNumber2(String character) 
	{
		int number = 0;
		for(int s=0; s<seqAL.size(); s++)
		{
		    String str = (String) seqAL.get(s);
		    if(str.trim().equals(character))
		    {
		        number = s;
		    }		    
		}
		return number;
	}
}

