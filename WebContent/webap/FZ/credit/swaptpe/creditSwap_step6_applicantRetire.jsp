<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,swap3ac.*" %>
<%
String aEmpno = request.getParameter("aEmpno");
String rEmpno = request.getParameter("rEmpno");
String year = request.getParameter("year");
String month =request.getParameter("month");
String asno =request.getParameter("asno");
String rsno =request.getParameter("rsno");
String source =request.getParameter("source");

//out.print("source >> "+ source+" aEmpno >>"+ aEmpno + " rEmpno >> "+ rEmpno + " year >> "+ year + " month >> "+ month+ " asno >> "+ asno +" rsno >>" + rsno+"<br>");


CheckRetire cr = new CheckRetire(aEmpno);
boolean aRetire = false;
boolean rRetire = false;
try {
	cr.RetrieveDate();
	if(cr.isRetire()){
		aRetire = true;
	}
	
	 cr = new CheckRetire(rEmpno);
	 
	cr.RetrieveDate();
	if(cr.isRetire()){
		rRetire= true;
	}
} catch (ClassNotFoundException e) {
	out.print(e.toString());
} catch (SQLException e) {
	out.print(e.toString());
} catch (InstantiationException e) {
	out.print(e.toString());
} catch (IllegalAccessException e) {
	out.print(e.toString());
}

if(aRetire | rRetire)
{//有一為屆退人員，使用applicantRetire.jsp
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>AirCrews3次換班申請CheckRetire</title>
<script language="javascript" type="text/javascript" src="../js/showDate.js"></script>
<link href="swap.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="../errStyle.css">
</head>
<body >
	<p class="errStyle1">申請者(<%=aEmpno%>) 或 被換者(<%=rEmpno%>)&nbsp; 
			已列為排/換班控管人員名單，請親洽空服派遣部以人工遞單方式處理，謝謝！
	</p>
</body>
</html>
<%
}
else
{
	response.sendRedirect("creditSwap_step6_applicant.jsp?aEmpno="+aEmpno+"&rEmpno="+rEmpno+"&year="+year+"&month="+month+"&asno="+asno+"&rsno="+rsno+"&source="+source);
}

%>
