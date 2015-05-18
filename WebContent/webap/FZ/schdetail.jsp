<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.*,java.sql.*,ci.db.*"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
  %> <jsp:forward page="sendredirect.jsp" /> <%
} 
String fdate = request.getParameter("fdate");
String tripno = request.getParameter("tripno");
String empno = request.getParameter("empno");
if (empno==null){empno=sGetUsr;}

String cname = null;
String sern = null;
String occu = null;
String base = null;

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

//get crew info
chkUser ck = new chkUser();
String rs = ck.findCrew(empno);
if (rs.equals("1"))
{
	cname = ck.getName();
	sern = ck.getSern();
	occu = ck.getOccu();
	base = ck.getBase();
}

String dutycode=null;
String dpt=null;
String arv=null;
String btime=null;
String etime=null;

int xCount=0;
String bcolor=null;
//************************************2.Get live sche table
ctlTable ct = new ctlTable();
ct.doSet();
//out.println(ct.getTable() + "," + ct.getUpdDate());
//****************************************
myResultSet = stmt.executeQuery("select * "+
"from "+ct.getTable()+" where trim(empno)='"+empno+"' and fdate = '"+fdate+"' and tripno='"+tripno+"'"+
" order by dutycode");
%>
<html>
<head>
<title>Show Schedule Detail</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" href="menu.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<table width="70%" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
        
    <td class="txtblue">資料庫更新時間(Last update)：<span class="txtxred">TPE&nbsp;<%=ct.getUpdDate()%> 班表時間為起迄站之當地時間 </span></td>
    </tr>
</table>
<div align="center" class="txttitletop">
  <%=fdate%> Tripno:<%=tripno%> Schedule Detail  
  <table width="70%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td width="5%">&nbsp;</td>
      <td width="90%"> 
        <div align="center" class="txtblue"> <%=cname%> <%=empno%> <%=sern%> <%=occu%> <%=base%>
        </div>
      </td>
      <td width="5%">
        <div align="right"><a href="javascript:window.print()"> <img src="images/print.gif" width="17" height="15" border="0" alt="列印"></a> 
        </div>
      </td>
    </tr>
  </table>
  <table width="70%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td class="tablehead">Fdate</td>
      <td class="tablehead">DutyCode</td>
      <td class="tablehead">TripNo</td>
      <td class="tablehead">Dpt</td>
      <td class="tablehead">Btime</td>
      <td class="tablehead">Arv</td>
      <td class="tablehead">Etime</td>
	  <td class="tablehead">Crew</td>
    </tr>
<%
if (myResultSet != null)
{
		while (myResultSet.next())
	{ 
			dutycode = myResultSet.getString("dutycode");
			dpt = myResultSet.getString("dpt");
			arv = myResultSet.getString("arv");
			btime = myResultSet.getString("btime");
			etime= myResultSet.getString("etime");
			
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
      <td class="tablebody"><%=dutycode%></td>
      <td class="tablebody"><%=tripno%></td>
      <td class="tablebody"><%=dpt%></td>
      <td class="tablebody"><%=btime%></td>
      <td class="tablebody"><%=arv%></td>
      <td class="tablebody"><%=etime%></td>
	  <td>
        <div align="center"><a href="crewdetail.jsp?fdate=<%=fdate%>&fltno=<%=dutycode%>&dpt=<%=dpt%>&arv=<%=arv%>" target="_blank"> 
          <img src="images/search.gif" width="15" height="15" border="0" alt="who fly with me"></a></div>
      </td>
    </tr>
<%
	}
}
if (xCount == 0){
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}

%>
	<jsp:forward page="showmessage.jsp">
	<jsp:param name="messagestring" value="No Schedule Found or Schedule has beeb transfered!<BR> 查無此資料，或此班已更換!!" />
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