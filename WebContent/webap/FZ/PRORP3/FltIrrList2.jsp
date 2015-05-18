<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.*,ci.db.ConnDB,java.sql.*,java.net.URLEncoder"%>
<%
/*add by cs66 at 2005/5/16
空管建立航班資料後，因已無班表，故不檢查SBS，直接進入編輯畫面
*/

%>
<html>
<head>
<title>Flight Query</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="style2.css" rel="stylesheet" type="text/css">
</head>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (sGetUsr == null) {		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} 

//String GdYear = request.getParameter("GdYear");

String fdate = request.getParameter("fdate");
//取得考績年度
String GdYear = fz.pr.orp3.GdYear.getGdYear(fdate);

String fltno = request.getParameter("fltno").trim();
String purEmpno = request.getParameter("purEmpno");

//fltno補滿三位
if(fltno.length() <3){
	for (int i = 0; i <= 3-fltno.length() ; i++) {
		fltno = "0"+fltno;
	}

}

String dpt = null;
String arv = null;
String acno = null;
String purname = null;

Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
ResultSet myResultSet = null;

boolean t = false;
String bcolor=null;

//從空管抓航班資料
String sql = "select * from egtcflt where fltno='"+fltno
			+"' and fltd=to_date('"+fdate+"','yyyy/mm/dd') and psrempn='"
			+sGetUsr+"' ";		
			
try{
ConnDB cn = new ConnDB();
//EG
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
		ResultSet.CONCUR_READ_ONLY);

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
        <div align="center" class="txttitletop"> <%=fdate%>&nbsp; Fltno: <%=fltno%></div>
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
	
			
			//modify by cs66 2005/2/21
			dpt = myResultSet.getString("sect").substring(0,3);
			arv =  myResultSet.getString("sect").substring(3);
			acno = myResultSet.getString("acno");						
			purname = myResultSet.getString("psrname");	
		

			if (count%2 == 0)
			{
				bcolor = "#C9C9C9";
			}
			else
			{
				bcolor = "#FFFFFF";
			}
	count++;
%>
  <tr bgcolor="<%=bcolor%>">
    <td class="tablebody"><%=fdate%></td>
    <td class="tablebody"><%=fltno%></td>
    <td class="tablebody"><%=dpt%></td>
    <td class="tablebody"><%=arv%></td>
    <td class="tablebody"><%=acno%></td>
	<td class="tablebody"><%=purname%></td>
    <td align="center" valign="middle" class="tablebody"><div align="center"><a href="edFltIrr.jsp?fdate=<%=fdate%>&fltno=<%=fltno%>&dpt=<%=dpt%>&arv=<%=arv%>&GdYear=<%=GdYear%>&acno=<%=acno%>&pur=<%=purEmpno%>" target="_self"><img src="../images/ed3.gif" width="22" height="22" border="0" alt="Edit Report"></a></div></td>
	</tr>
  <%
	}
}
if(count ==0){
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
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}

%>