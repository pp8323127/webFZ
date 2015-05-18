<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="al.*,java.sql.*"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first
	response.sendRedirect("login.jsp");
} 
%>
<html>
<head>
<title>
Delete AL offsheet
</title>
<meta http-equiv="pragma" content="no-cache">
</head>
<body>
<div align="center"> 
<%
	String[] instring = request.getParameterValues("checkdel");
	if (instring == null)
	{
%>
	<jsp:forward page="sm2.jsp">
	<jsp:param name="messagestring" value="No Delete Offsheet!!<br><a href='javascript:history.back(-1)'>back</a>" />
	</jsp:forward>
<% 
   }
	String[] offsdate = new String[instring.length]; //yyyy-mm-dd
	String[] offedate = new String[instring.length]; //yyyy-mm-dd
	String[] offno = new String[instring.length];
	String gdyear = request.getParameter("gdyear");
	
	for(int i=0;i<instring.length;i++){
		offsdate[i] = instring[i].substring(0,10);
		offedate[i] = instring[i].substring(10,20);
		offno[i] = instring[i].substring(20);
		out.println(offsdate[i] + "," + offedate[i] + "," + offno + "<br>");
	}
//************************************************************************
   //刪除特休假單
   deleteAl da = new deleteAl();
   String srtn = da.deleteoff(offsdate, offedate, offno, sGetUsr);
   if (srtn.equals("0"))
   {
   //假單刪除成功
%>
	<jsp:forward page="viewoffsheet.jsp">
	<jsp:param name="offyear" value="<%=gdyear%>" />
	</jsp:forward>
<%  
   }    
   else
   {
%>
	<jsp:forward page="showmessage.jsp">
	<jsp:param name="message1" value="假單刪除失敗" />
	<jsp:param name="message2" value="<%=srtn%>" />
	<jsp:param name="gdyear" value="<%=gdyear%>" />
	<jsp:param name="empn" value="<%=sGetUsr%>" />
	</jsp:forward>
<%
   }
%>
</div>
</body>
</html>