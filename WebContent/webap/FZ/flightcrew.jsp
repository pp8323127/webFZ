<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.*,java.sql.*,ci.db.*"%>
<html>
<head>
<title>Flight Query</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" href="menu.css" type="text/css">
</head>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
  %> <jsp:forward page="sendredirect.jsp" /> <%
} 
String fyy = request.getParameter("fyy");
String fmm = request.getParameter("fmm");
String fdd = request.getParameter("fdd");
String fltno = request.getParameter("fltno").trim();
String dpt = request.getParameter("dpt");

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


String fdate=null;
String dutycode=null;
String arv=null;
String btime=null;
String etime=null;
String actp=null;

int xCount=0;
String bcolor=null;
//************************************2.Get live sche table
ctlTable ct = new ctlTable();
ct.doSet();
//out.println(ct.getTable() + "," + ct.getUpdDate());
//****************************************
String sql="select fdate, dutycode, dpt, arv, btime, etime, actp " +
"from  " +ct.getTable()+
" where substr(trim(dutycode),1,1) in ('0','1','2','3','4','5','6','7','8','9','S') ";

String mydate = null;
if (fdd.equals("N"))
{
	mydate = fyy+"/"+fmm;
	sql = sql + "and substr(fdate,1,7)='"+mydate+"' ";
}
else
{
	mydate = fyy+"/"+fmm + "/" + fdd;
	sql = sql + "and fdate='"+mydate+"' ";
}

if (!fltno.equals(""))
{
	sql = sql + "and trim(dutycode)=UPPER('"+fltno+"')"; 
}
if (!dpt.equals(""))
{
	sql = sql + "and dpt=UPPER('"+dpt+"')"; 
}
sql = sql + " group by fdate, dutycode, dpt, arv, btime, etime, actp ";

myResultSet = stmt.executeQuery(sql);
%>


<body bgcolor="#FFFFFF" text="#000000">
<table width="70%" border="0" cellpadding="0" cellspacing="0" align="center">
  <tr>
    <td class="txtblue">資料庫最後更新時間(Last update)：<span class="txtxred">TPE&nbsp;<%=ct.getUpdDate()%> 班表時間為起迄站之當地時間 <br>
      <strong> The following shedule is for reference only. For official up-to-date schedule information, please contact Scheduling Department. <br>
下列班表僅供參考，請向組員派遣部門確認個人正式班表任務。 </strong>    </span></td>
  </tr>
</table>
<div align="center" class="txttitletop">
<table width="70%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td width="5%">&nbsp;</td>
      <td width="90%"> 
        <div align="center" class="txttitletop"> <%=mydate%> <%=fltno%> <%=dpt%> on duty crew </div>
      </td>
      <td width="5%">
        <div align="right"><a href="javascript:window.print()"> <img src="images/print.gif" width="17" height="15" border="0" alt="列印"></a> 
        </div>
      </td>
    </tr>
  </table>
<table width="70%" height="40" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="17%" height="15" class="tablehead">FltDate</td>
    <td width="11%" class="tablehead">Fltno</td>
    <td width="9%" class="tablehead">Dpt</td>
    <td width="9%" class="tablehead">Arv</td>
    <td width="15%" class="tablehead">BTime</td>
    <td width="15%" class="tablehead">ETime</td>
    <td width="14%" class="tablehead">Actp</td>
    <td width="10%" class="tablehead">Crew</td>
  </tr>
  <%
	int c = 0;
if (myResultSet != null)
{
		while (myResultSet.next())
	{ 
	c++;
			fdate = myResultSet.getString("fdate");
			fltno = myResultSet.getString("dutycode");
			dpt = myResultSet.getString("dpt");
			arv = myResultSet.getString("arv");
			btime = myResultSet.getString("btime");
			etime = myResultSet.getString("etime");
			actp = myResultSet.getString("actp");
			
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
    <td class="tablebody"><%=fltno%></td>
    <td class="tablebody"><%=dpt%></td>
    <td class="tablebody"><%=arv%></td>
    <td class="tablebody"><%=btime%></td>
    <td class="tablebody"><%=etime%></td>
    <td class="tablebody"><%=actp%></td>
    <td align="center" valign="middle" class="tablebody"><div align="center"><a href="crewdetail.jsp?fdate=<%=fdate%>&fltno=<%=fltno%>&dpt=<%=dpt%>&arv=<%=arv%>" target="_self">&nbsp;&nbsp;<img src="images/red.gif" width="15" height="15" border="0" alt="see fly crew">&nbsp;&nbsp;</a></div></td>
  </tr>
  <%
	}
}
if(c ==0){
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
%>
  <jsp:forward page="showmessage.jsp">
    <jsp:param name="messagestring" value="No Data Found !!<br>未找到符合查詢資料的航班" />
  </jsp:forward>
  <%
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
}
finally
{
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
if(t)
{
%>
      <jsp:forward page="err.jsp" /> 
<%
}
%>