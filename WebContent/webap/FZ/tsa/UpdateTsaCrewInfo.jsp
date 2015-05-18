<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*" errorPage="" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%

String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login

response.setHeader("Cache-Control","no-cache");

response.setDateHeader ("Expires", 0);



if (session.isNew() ||sGetUsr == null) 

{		//check user session start first

	response.sendRedirect("sendredirect.jsp");

} 

%>

<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=big5">

<title>Update Tsa Crew Info</title>

<link href="../menu.css" rel="stylesheet" type="text/css">

</head>



<body>

<div align="center">

  <p>

    <%

String empno 		= request.getParameter("empno").trim();

String cname		= request.getParameter("cname").trim();

String lastname		= request.getParameter("lastname").trim();

String firstname	= request.getParameter("firstname").trim();

String passno		= request.getParameter("passno").trim();

String passcountry	= request.getParameter("passcountry").trim();

String birthY 	= request.getParameter("birthY").trim();

String birthM 	= request.getParameter("birthM");

String birthD 	= request.getParameter("birthD");

String mname	= request.getParameter("mname").trim();
String gender	= request.getParameter("gender").trim();
String pilotctry	= request.getParameter("pilotctry").trim();
String pilotno	= request.getParameter("pilotno").trim();
String remark	= request.getParameter("remark").trim();
String doctype	= request.getParameter("doctype").trim();
String tvlstatus	= request.getParameter("tvlstatus").trim();
out.println("*******************"+tvlstatus);
Connection conn = null;

Statement stmt = null;

int count = 0;
 Driver dbDriver = null;
ConnDB cn = new ConnDB();

try{
cn.setDFUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);

stmt = conn.createStatement();



String sql = "update dfttsa set tvlstatus=upper('"+tvlstatus+"'),doctype=upper('"+doctype+"'),remark=upper('"+remark+"'),pilotno=upper('"+pilotno+"'),pilotctry=upper('"+pilotctry+"'),gender=upper('"+gender+"'),mname=upper('"+mname+"'),lastname=upper('"+lastname+"'),firstname=upper('"+firstname+"'),passno=upper('"+passno+"'),"+

			"passcontry=upper('"+passcountry+"'),birthdate=to_date('"+birthY+birthM+birthD+"','yyyymmdd') "+

			"where empno='"+empno+"' and name='"+cname+"'";

//out.print(sql);

stmt.executeQuery(sql);			





%>

    <span class="txtxred"><strong>Update Crew info OK!!

</strong></span></p>

  <p class="txtblue"><a href="tsaCrewInfo.jsp?empno=<%=empno%>"><u>View Edited Data.</u></a> </p>

</div>

</body>

</html>



<%



}

catch (Exception e)

{

	  out.print(e.toString());

}

finally

{

	try{if(stmt != null) stmt.close();}catch(SQLException e){}

	try{if(conn != null) conn.close();}catch(SQLException e){}

	

}



%>