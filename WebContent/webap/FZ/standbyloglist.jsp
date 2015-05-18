<%@page contentType="text/html; charset=big5" language="java"%>
<%@page import="fz.*,java.sql.*,java.util.*,pay.*, java.io.*,java.text.*"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String userid = (String) session.getAttribute("userid") ; //get user id if already login

//  userid = "629947";

if (session.isNew() || userid == null) 
{		//check user session start first or not login
%>
 <jsp:forward page="sendredirect.jsp" /> 
<%
} 
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>寄送個人待命逾時明細</title>
<link href="../menu.css" rel="stylesheet" type="text/css">

<link href="menu.css" rel="stylesheet" type="text/css">
</head>

<body>
<%


String year  = request.getParameter("sely");
String month = request.getParameter("selm");
boolean sendSuccess = false;
String rs = null;

	String returnstr = "";

	//out.println("yesr = " + year + " month = " + month + " userid = " + userid);
	 
	StandByEmail_AC s = new StandByEmail_AC(year, month, userid);
	s.setEmpnoObj();
	returnstr = s.getReturnStr();
	

	if("Y".equals(returnstr))
	{    	//寄送成功
		fz.writeLog wl = new fz.writeLog();
		wl.updLog(userid, request.getRemoteAddr(),request.getRemoteHost(), "FZ470");	
	%>
		<script lanquag="JAVASCRIPT">
		alert("檔案已寄出至您的全員信箱");
		</script>
	
		<p align="center"><br>
		Open<a href="http://mail.cal.aero" class="txtxred"> cal.aero mail-box</a></p>
	
		<p align="center" ><a href="standbyquery.htm" target="topFrame" ><span class="txtxred"><u>寄送其他月份</u></span></a> </p>	
	<%	
	}
	else if("N".equals(returnstr))
	{	//尚無待命逾時資料
	%>
	
		<p align="center" >
		<a href="standbyloglist.jsp" target="topFrame" ><span class="txtxred"><u>無 <%=year+"/"+month%> 待命逾時明細，請重新選取月份寄送</u></span></a> 
		</p>
	
	<%	
	}
	else
	{	
	%>
	<p align="center" >
		<a href="standbyloglist.jsp" target="topFrame" ><span class="txtxred"><u>寄送失敗，請重新選取月份寄送</u></span></a> 
	</p>
	<%
	}
  //end of 寄送待命逾時明細流程		
%>

</body>
</html>
