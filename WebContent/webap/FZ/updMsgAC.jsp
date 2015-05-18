<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.tool.*"  %>
<%
String userid = (String) session.getAttribute("userid") ; 
String msg = request.getParameter("msg");


if (session.isNew() || userid == null) {
	response.sendRedirect("sendredirect.jsp");
} else{

	WriteLog wl = new WriteLog(application.getRealPath("/")+"/Log/msgAC.txt");
	wl.WriteFileWithTime(request.getRemoteAddr()+"\t"+userid+(String)session.getAttribute("cname")
		+"\t"+(String)session.getAttribute("occu")+"\t"+msg);
}

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Update Msg AC</title>

</head>

<body>
<div style="color:red;text-align:center;font-family:Verdana;font-size:10pt;background-color:#CCFFFF;padding:2pt;"><br>
  Update Success!!<br>
</div>
</body>
</html>
