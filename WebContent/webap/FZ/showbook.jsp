<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="fz.*,java.sql.*,ci.db.*"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
 %>
 <jsp:forward page="sendredirect.jsp" /> 
<%
} 
String bcolor = null;
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

String sql = "select fdate,fltno,tripno,put_date putdate from fztsput where empno = '"+ sGetUsr+ "'" ;

String fdate= null;
String fltno = null;
String tripno = null;
String putdate = null;


myResultSet = stmt.executeQuery(sql); 
%>


<html>
<head>
<title>交換班表記錄</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="menu.css" rel="stylesheet" type="text/css">
</head>

<body>
<table width="70%" border="0" align="center">
  <tr>
	<td width="8%" height="40"></td>
	<td width="87%"><div align="center" class="txttitletop">我的丟班資訊 Put Schedule
	    record </div>
	  <div align="center"><br>
          <span class="txtblue">Tips:點選FltNo可查詢喜愛此航班的組員資訊<br>
You can query who like the flights you put in Transfer Record by clicking fltno.</span></div></td>
	<td width="5%"><div align="right"><a href="javascript:window.print()"><img src="images/print.gif" border="0"></a></div></td>
</tr>
</table>
<form name="form1" method="post" action="upddelete.jsp">
  <table width="70%" border="1" align="center" cellpadding="0" cellspacing="0">
    <tr class="tablehead3"> 
      <td>FltDate</td>
      <td>FltNo</td>
      <td>TripNo</td>
      <td>Put Date </td>
      <td>Detail</td>
      <td>cancel</td>
    </tr>
    <%
  
int xCount=0;
  if(myResultSet != null){

	while (myResultSet.next()){
	xCount++;
	 fdate= myResultSet.getString("fdate");
	 fltno = myResultSet.getString("fltno");
	 tripno =myResultSet.getString("tripno");
	 putdate = myResultSet.getString("putdate");
	
			if (xCount%2 == 0)
			{
				bcolor = "#C9C9C9";
			}
			else
			{
				bcolor = "#FFFFFF";
			}
%>
    <tr   bgcolor="<%=bcolor %>"> 
      <td class="tablebody"><%=fdate %></td>
      <td class="tablebody"><a href="favorfltquery.jsp?fltno=<%=fltno %>" target="_self"><%=fltno %></a></td>
      <td class="tablebody"><%=tripno %></td>
      <td class="tablebody"><%=putdate %></td>
      <td > 
        <div align="center"><a href="schdetail.jsp?fdate=<%=fdate%>&tripno=<%=tripno %>" target="_blank"><img src="images/red.gif" border="0" alt="show Schedule Detail"></a></div>
      </td>
      <td> 
        <div align="center"> 
          <input type="checkbox" name="checkdelete" value="<%=fdate%><%=tripno%><%=fltno%>">
        </div>
      </td>
    </tr>
    <%
	}
}
  %>
  </table>
  <p align="center" class="txtblue">
    <input type="submit" name="Submit" value="Cancel" class="btm">
    <br>
    <span class="txtxred">*若丟出的班已更換成功，或status為Q ，請將該班cancel.</span><br>
  </p>
</form>
</body>
</html>
<%

	if (xCount == 0){
		try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
		try{if(stmt != null) stmt.close();}catch(SQLException e){}
		try{if(conn != null) conn.close();}catch(SQLException e){}

	%>
		<jsp:forward page="showmessage.jsp">
		<jsp:param name="messagestring" value="No Put Schedule Record Found !!<br>您沒有任何丟出班的紀錄" />
		</jsp:forward>
	<%	
		}

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
