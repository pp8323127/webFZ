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
<title>�H�e�ӤH�ݩR�O�ɩ���</title>
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
	{    	//�H�e���\
		fz.writeLog wl = new fz.writeLog();
		wl.updLog(userid, request.getRemoteAddr(),request.getRemoteHost(), "FZ470");	
	%>
		<script lanquag="JAVASCRIPT">
		alert("�ɮפw�H�X�ܱz�������H�c");
		</script>
	
		<p align="center"><br>
		Open<a href="http://mail.cal.aero" class="txtxred"> cal.aero mail-box</a></p>
	
		<p align="center" ><a href="standbyquery.htm" target="topFrame" ><span class="txtxred"><u>�H�e��L���</u></span></a> </p>	
	<%	
	}
	else if("N".equals(returnstr))
	{	//�|�L�ݩR�O�ɸ��
	%>
	
		<p align="center" >
		<a href="standbyloglist.jsp" target="topFrame" ><span class="txtxred"><u>�L <%=year+"/"+month%> �ݩR�O�ɩ��ӡA�Э��s�������H�e</u></span></a> 
		</p>
	
	<%	
	}
	else
	{	
	%>
	<p align="center" >
		<a href="standbyloglist.jsp" target="topFrame" ><span class="txtxred"><u>�H�e���ѡA�Э��s�������H�e</u></span></a> 
	</p>
	<%
	}
  //end of �H�e�ݩR�O�ɩ��Ӭy�{		
%>

</body>
</html>
