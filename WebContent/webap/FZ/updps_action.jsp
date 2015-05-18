<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="fz.*"%>
<%
//pageid = FZ291
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
 %>
 <jsp:forward page="sendredirect.jsp" /> 
<%
} 

String[] cb = request.getParameterValues("checkbook");
if (cb == null)
{
	%>
	<jsp:forward page="showmessage.jsp">
	<jsp:param name="messagestring" value="No Schedule been Booking !" />
	</jsp:forward>
	<%
}

String[] empno = new String[cb.length];
String[] fdate = new String[cb.length];
String[] fltno = new String[cb.length];
String mm = null;

putSche ps = new putSche();

for (int i = 0; i < cb.length; i++)
{
	empno[i] = cb[i].substring(0, 6);
	fdate[i] = cb[i].substring(6, 16);
	fltno[i] = cb[i].substring(16);
	mm = cb[i].substring(6, 13);
	//out.println(empno[i]+","+fdate[i]+","+tripno[i]);
}
String rs = ps.doBook(sGetUsr, empno, fdate, fltno);
if (!rs.equals("0"))
{
	%>
	<jsp:forward page="showmessage.jsp">
	<jsp:param name="messagestring" value="<%=rs%>" />
	</jsp:forward>
   <% 
}
%>
<html>
<head>
<title>Send Crew Duty</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="menu.css" rel="stylesheet" type="text/css">
</head>
<body>
<p class="txttitletop" align="center">Booking Schedule Success !</p>
<p class="cs55text" align="center"><a href="psquery_action.jsp?fdate=<%=mm%>&pyy=">chick there to link put 
  Schedule</a></p>
</body>
</html>