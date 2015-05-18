<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="java.sql.*,fz.*,ci.db."%>
<%
/*
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
*/
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
 %>
 <jsp:forward page="sendredirect.jsp" /> 
<%
} 

String yy = request.getParameter("pyy");
String mm = request.getParameter("pmm");
String dd = request.getParameter("pdd");
String sel_fltno = request.getParameter("fltno");
String fdatemm = null;

if (yy.equals(""))
{
	fdatemm = "FDATE = '" + request.getParameter("fdate") + "'";
}
else
{
	if(dd.equals("N")){
		fdatemm = "substr(FDATE,1,7) = '" + yy + "/" + mm + "'";
	}
	else{
		fdatemm	= "FDATE = '" + yy + "/" + mm+"/"+ dd + "'";
	}
}

int count = 0;

Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
ResultSet myResultSet = null;
boolean t = false;

try{
//dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
//conn = dbDriver.connect("jdbc:weblogic:pool:CAL.FZCP02", null);
ConnDB cn = new ConnDB();
cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement();

chkUser cu = new chkUser();
cu.findCrew(sGetUsr);
String base = cu.getBase();
String occu = cu.getOccu();
String xwhere = null;
if (occu.equals("FA") || occu.equals("FS") )
{
	xwhere = "in ('FA','FS')";
}
else if(occu.equals("PR")){
	xwhere = "='PR'";

}
else
{
	xwhere = "not in ('FA','FS','PR')";
}

//顯示可選取之班表, 只顯示本站組員   cabin crew/FA,FS,PR  flight crew/CA....  不顯示自己丟的班&已被選取的班
String sql = null;
if ( sel_fltno.equals("")){
 sql = "SELECT empno, sern, cname, fdate, fltno, tripno, homebase, occu, to_char(put_date,'mm/dd') put_date, comments "+
"FROM FZTSPUT "+
"WHERE " + fdatemm + " and homebase = '"+base+"' and occu "+xwhere+
" ORDER BY fdate, fltno";}
else{
 sql ="SELECT empno, sern, cname, fdate, fltno, tripno, homebase, occu, to_char(put_date,'mm/dd') put_date, comments "+
"FROM FZTSPUT "+
"WHERE " + fdatemm + " and homebase = '"+base+
"' and occu "+xwhere+ " and fltno='" + sel_fltno +"'" +
" ORDER BY fdate, fltno";
}

myResultSet = stmt.executeQuery(sql); 

String empno = null;
String sern	= null;
String cname	= null;
String tripno	= null;
String fdate = null;
String fltno = null;
String homebase= null;
String put_date= null;
String comm = null;
String bcolor	= null;
%>

<html>
<head>
<title>Put Schedule Query</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="menu.css" rel="stylesheet" type="text/css">
</head>
<style type=text/css>
<!--
BODY{margin:0px;/*內容貼緊網頁邊界*/}
-->
</style>
<body>
<div align="center">

  <form name="form1" method="post" action="updps_action.jsp">
    <table width="90%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td width="5%" height="47">&nbsp;</td>
      <td width="90%"><div align="center"><span class="txttitletop">Put Schedule Query(可換班表查詢)<br>
        </span><span class="txtblue">You can query the crew by click Name column (點選姓名可查詢該組員資料)<br>
		You can query the crew's favor flight by click Fltno column (點選航班可查詢該組員最愛航班)</span> 
        </div></td>
      <td width="5%" valign="bottom">
        <div align="right"><a href="javascript:window.print()"> <img src="images/print.gif" width="17" height="15" border="0" alt="列印"></a> 
        </div>      </td>
    </tr>
  </table>
    <table width="95%" height="53" border="0" align="center" cellpadding="0" cellspacing="0" valign="middle">
      <tr class="tablehead"> 
        <td height="21" class="tablehead3">Empno</td>
        <td class="tablehead3">Sern</td>
        <td class="tablehead3">Name</td>
        <td class="tablehead3">Fdate</td>
		<td class="tablehead3">Fltno</td>
        <td class="tablehead3">TripNo</td>
        <td class="tablehead3">Occu</td>
		<td class="tablehead3">Comm</td>
        <td class="tablehead3">Put Date</td>
        <td class="tablehead3">Sche</td>
      </tr>
      <%
  
    int xCount=0;
    if(myResultSet != null){
	while (myResultSet.next()){
			xCount++;
	  		empno = myResultSet.getString("empno"); 
		 	sern	= myResultSet.getString("sern");
		 	cname	= myResultSet.getString("cname");
			fdate	= myResultSet.getString("fdate");
			fltno	= myResultSet.getString("fltno");
		 	tripno	= myResultSet.getString("tripno");
		 	homebase= myResultSet.getString("homebase");
		 	occu 	= myResultSet.getString("occu");
		 	put_date= myResultSet.getString("put_date");
			comm = myResultSet.getString("comments");
  
			if (xCount%2 == 0)
			{
				bcolor = "#CCCCCC";
			}
			else
			{
				bcolor = "#FFFFFF";
			}
%>
      <tr bgcolor="<%=bcolor %>"> 
        <td height="26" valign="middle" class="tablebody"> 
        <div align="center"><a href="compare.jsp?empno=<%=empno%>&fyy=<%=yy%>&fmm=<%=mm%>" target="_self"><acronym title="compare schedule"><%=empno %></acronym></a></div>        </td>
        <td valign="middle" class="tablebody"> 
          <div align="center"><%=sern %></div>        </td>
        <td valign="middle" class="tablebody"> 
          <div align="center"><a href="crewquery.jsp?tf_ename=&tf_sess1=&tf_sess2=&tf_empno=<%=empno%>" target="_self"><acronym title="show personal information"><%=cname %></acronym></a></div>        </td>
        <td valign="middle" class="tablebody"> 
          <div align="center"><%=fdate%></div>        </td>
		<td valign="middle" class="tablebody"> 
          <div align="center"><a href="crewdetail.jsp?fdate=<%=fdate%>&fltno=<%=fltno%>&dpt=&arv=" target="_blank"><acronym title="flight crew"><%=fltno%></acronym></a></div>        </td>
        <td valign="middle" class="tablebody"> 
          <div align="center"><%=tripno %></div>        </td>
        <td valign="middle" class="tablebody"> 
          <div align="center"><%= occu%></div>        </td>
		<td valign="middle" class="tablebody"> 
          <div align="center"><%= comm%></div>        </td>
        <td valign="middle" class="tablebody"> 
          <div align="center"><%= put_date%></div>        </td>
		<td valign="middle" class="tablebody">
		  <div align="center"><a href="showsche2.jsp?empno=<%=empno%>&syear=<%=yy%>&smonth=<%=mm%>" target="_blank"><img src="images/search.gif" border="0" alt="show schedule"></a></td>
      </tr>
      <%
  
  }
} 
%>
    </table>
  </form>

</div>
<% 
 if (xCount==0)
{
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
	
	
%>
	<jsp:forward page="showmessage.jsp">
	<jsp:param name="messagestring" value="No Put Schedule found !!<BR>未找到符合條件的丟班資訊" />
	</jsp:forward>
<%
} 
%>
</body>
</html>
<%
}
catch (Exception e)
{
	  t = true;
	  out.print(e.toString());
}
finally
{
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>