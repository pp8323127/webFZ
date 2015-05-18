<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.*,ci.db.ConnDB,java.sql.*,java.net.URLEncoder"%>
<html>
<head>
<title>Flight Query</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="style2.css" rel="stylesheet" type="text/css">
</head>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) {		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} 
//session.setAttribute("userid","629250") ;
//String GdYear = "2005";//request.getParameter("GdYear");

String fyy = request.getParameter("fyy");
String fmm = request.getParameter("fmm");
String fdd = request.getParameter("fdd");
String mydate = fyy+"/"+fmm + "/" + fdd;
//取得考績年度
String GdYear = fz.pr.orp3.GdYear.getGdYear(mydate);


String fltno = request.getParameter("fltno").trim();

//fltno補滿三位
if(fltno.length() <3){
	for (int i = 0; i <= 3-fltno.length() ; i++) {
		fltno = "0"+fltno;
	}

}
/*
//add by cs55 2005/01/11
if(fltno.substring(0,1).equals("9") && fltno.length() == 4){
	fltno = fltno.substring(1);
}
*/

String da13_fltno = null;
String fdate_tpelocal = null;
String dpt = null;
String arv = null;
String fdate = null;
String dutycode = null;
String btime = null;
String etime = null;
String actp = null;
String acno = null;
String SBSFltno = null;
String purname = null;
//modify by cs66 2005/2/21
String purEmpno = null;

String sqlPurser = "";

Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
Statement stmt2 = null;
ResultSet myResultSet = null;
ResultSet myResultSet2 = null;
boolean t = false;
int xCount=0;
String bcolor=null;
//************************************2.Get live sche table
ctlTable ct = new ctlTable();
ct.doSet();
String table_name = ct.getTable();

chkUser ck = new chkUser();

String sqlDa13 = "SELECT To_Char(da13_stdu+(8/24),'yyyy/mm/dd') fdate_tpelocal,To_Char(da13_stdl,'yyyy/mm/dd') fdate,"+
				"da13_fltno,da13_pxac,da13_book_f , da13_book_c ,da13_book_y,"+
				"da13_fm_sector,da13_to_sector,to_char(da13_etdl,'mm/dd hh24:mi') da13_etdl,"+
				"to_char(da13_etal,'mm/dd hh24:mi') da13_etal,da13_actp,da13_acno "+
				"FROM fzdb.v_ittda13_ci WHERE To_Char(da13_stdl,'yyyy/mm/dd')='"+mydate+"'"+
				"AND da13_fltno=LPad(UPPER('"+fltno+"'),4,'0') and da13_fm_sector <> da13_to_sector ";
String sqlda13_q = null;

//從SBS抓purser的資料,purser的qual為PM 或 P
String sql = "select * from "+ table_name +" where fdate='"+mydate+"' and dutycode='"+fltno+"' "+
		"AND empno not in ('593027','625303','625304','628484','628539','628997','625296') "+
		"AND substr(Trim(qual),1,1) ='P' and spcode not in ('I','S') and dh <> 'Y' ";
		
try{
ConnDB cn = new ConnDB();
cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
		ResultSet.CONCUR_READ_ONLY);

stmt2 = conn.createStatement();

//modify by cs66 at 2005/02/16 先抓SBS班表資料
myResultSet = stmt.executeQuery(sql);


%>


<body>
<table width="72%" border="0" cellpadding="0" cellspacing="0" align="center">
  <tr>
    <td class="txtblue">&nbsp;</td>
  </tr>
</table>
<div align="center" class="txttitletop">
<table width="72%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td width="5%">&nbsp;</td>
      <td width="90%"> 
        <div align="center" class="txttitletop"> <%=mydate%>&nbsp; Fltno: <%=fltno%></div>
      </td>
      <td width="5%">&nbsp;      </td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td class="txtxred">
        <div align="right">班表時間為起迄站之當地時間 </div>
      </td>
      <td>&nbsp;</td>
    </tr>
  </table>
<table width="80%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="9%" height="15" class="tablehead3">FDate      <br>
      </td>
    <td class="tablehead3">Fltno</td>
    <td class="tablehead3">Dpt</td>
    <td class="tablehead3">Arv</td>
    <td class="tablehead3">BTime</td>
    <td class="tablehead3">ETime</td>
    <td class="tablehead3">Acno</td>
	<td class="tablehead3">PurName</td>
    <td class="tablehead3">Flt<br>
      Irregularity</td>
	</tr>
  <%
	int count = 0;
if (myResultSet != null)
{
		while (myResultSet.next())
	{ 
	count++;
			
			//modify by cs66 2005/2/21
			purEmpno = 	myResultSet.getString("empno");
						
			ck.findCrew(myResultSet.getString("empno"));
			purname = ck.getName();
								
			fdate = myResultSet.getString("fdate");
			dpt = myResultSet.getString("dpt");
			arv =  myResultSet.getString("arv");
			btime = myResultSet.getString("btime");
			etime = myResultSet.getString("etime");
			actp = myResultSet.getString("actp");			
			SBSFltno = myResultSet.getString("dutycode");		
			
			//modify by cs55 2005/03/22 加入DPT, 才可抓取正確該班的ACNO
			sqlda13_q = sqlDa13 + "and da13_fm_sector = '" + dpt + "' order by da13_etdu";
			
			//modify by cs66 at 2005/02/16  再match AirOps班表取得acno
			myResultSet2 = stmt2.executeQuery(sqlda13_q);
			if(myResultSet2.next()){
				acno = myResultSet2.getString("da13_acno");


			}
			xCount++;
			if (xCount%2 == 0)
			{
				bcolor = "#C9C9C9";
			}
			else
			{
				bcolor = "#FFFFFF";
			}

%>
  <tr bgcolor="<%=bcolor%>">
    <td class="tablebody"><%=fdate%></td>
    <td class="tablebody"><%=SBSFltno%></td>
    <td class="tablebody"><%=dpt%></td>
    <td class="tablebody"><%=arv%></td>
    <td class="tablebody"><%=btime%></td>
    <td class="tablebody"><%=etime%></td>
    <td class="tablebody"><%=acno%></td>
	<td class="tablebody"><%=purname%></td>
    <td align="center" valign="middle" class="tablebody"><div align="center"><a href="edFltIrr.jsp?fdate=<%=fdate%>&fltno=<%=fltno%>&dpt=<%=dpt%>&arv=<%=arv%>&GdYear=<%=GdYear%>&acno=<%=acno%>&pur=<%=purEmpno%>" target="_self"><img src="../images/ed3.gif" width="22" height="22" border="0" alt="Edit Report"></a></div></td>
	</tr>
  <%
	}
}/*
if(!purEmpno.equals(sGetUsr)){
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
	response.sendRedirect("../showmessage.jsp?messagestring="+URLEncoder.encode("非本班機座艙長，不得編輯報告") );
	
}
else 
*/if(count ==0){
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}

	response.sendRedirect("../showmessage.jsp?messagestring="+URLEncoder.encode("No Data Found !!<br>未找到符合查詢資料的航班") );


}
else if(count ==1){
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
	
	response.sendRedirect("edFltIrr.jsp?fdate="+fdate+"&fltno="+fltno+"&dpt="+dpt+"&arv="+arv+"&GdYear="+GdYear+"&acno="+acno+"&pur="+purEmpno);
}

%>
</table>
</div>
</body>
</html>

<%
}
catch (Exception e)
{
	  t = true;
	 out.print(e.toString());
	  //response.sendRedirect("../showmessage.jsp?messagestring="+URLEncoder.encode("系統忙碌中，請稍後再試"));
}
finally
{
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(myResultSet2 != null) myResultSet2.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(stmt2 != null) stmt2.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}

%>