<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="fz.*"%>
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

String[] cd = request.getParameterValues("checkdelete");

if (cd == null)
{
	%>
	<jsp:forward page="showmessage.jsp">
	<jsp:param name="messagestring" value="No Schedule been Cancel !" />
	</jsp:forward>
	<%
}

String[] fdate = new String[cd.length];
String[] tripno = new String[cd.length];
String[] fltno = new String[cd.length];

delSche ds = new delSche();

for (int i = 0; i < cd.length; i++)
{
	fdate[i] = cd[i].substring(0, 10);
	tripno[i] = cd[i].substring(10, 14);
	fltno[i] = cd[i].substring(14);
	//out.println(fdate[i]+","+tripno[i]);
}

String rs = ds.doDel(sGetUsr, fdate, fltno, tripno);

if (!rs.equals("0"))
{
	%>
	<jsp:forward page="showmessage.jsp">
	<jsp:param name="messagestring" value="<%=rs%>" />
	</jsp:forward>
   <% 
}
%><jsp:forward page="showbook.jsp" />
<html>
<head>
<title>Cancel Sche Put</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="menu.css" rel="stylesheet" type="text/css">
</head>
<body>
<p class="txttitletop" align="center">Cancel Schedule Success !</p>
<p class="cs55text" align="center"><a href="showbook.jsp">chick there to link put 
  Schedule</a></p>
</body>
</html>