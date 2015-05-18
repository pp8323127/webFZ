<%@page contentType="text/html; charset=big5" language="java"%>
<%@page import="fz.*,java.sql.*,java.util.*,df.overTime.*, java.io.*,java.text.*,df.overTime.ac.*"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String userid = (String) session.getAttribute("userid") ; //get user id if already login
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
<title>�H�e�ӤH�[�Z�O����</title>
<link href="../menu.css" rel="stylesheet" type="text/css">

<link href="menu.css" rel="stylesheet" type="text/css">
</head>

<body>
<%


String year = request.getParameter("year");
String month = request.getParameter("month");
boolean sendSuccess = false;
String rs = null;
//���o���[���G���
df.flypay.PublishCheck pc = new df.flypay.PublishCheck(year, month, userid);

if(pc.isCheckable() && !pc.isPublished())
{	//�@�Ӥ뤺����ơA���ˬd���G��� && �|�����G
%>
<p align="center" >
	<span class="txtxred"><u><%=year+"/"+month%> �[�Z�O���ө|�����G</u></span>
</p>
<%
}
else
{ //�H�e�[�Z�O���Ӭy�{ start
	//SBIREmail s = new SBIREmail(year, month, userid);
	//SBIREmail_For16Hrs s = new SBIREmail_For16Hrs(year, month, userid);
    //s.setEmpnoObj();

	Calendar gc = new GregorianCalendar();  
	//2007/12 ���ϥ�aircrews
	gc.set(2007,11,1);
			
	Calendar gcnow = new GregorianCalendar();  
	//�p����
	gcnow.set(Integer.parseInt(year),Integer.parseInt(month)-1,1);

	String returnstr = "";
	if(gc.after(gcnow))
	{
		//��Flt log �o�e
		//out.println("old");
		SBIREmail_For16Hrs s = new SBIREmail_For16Hrs(year, month, userid);
		s.setEmpnoObj();
		returnstr = s.getReturnStr();
	}
	else
	{
		//��AirCrews �o�e
		//out.println("new");
		SBIREmail_AC s = new SBIREmail_AC(year, month, userid);
		s.setEmpnoObj();
		returnstr = s.getReturnStr();
	}

	if("Y".equals(returnstr))
	{//�H�e���\
		fz.writeLog wl = new fz.writeLog();
		wl.updLog(userid, request.getRemoteAddr(),request.getRemoteHost(), "FZ401");	
	%>
	<script lanquag="JAVASCRIPT">
		alert("�ɮפw�H�X�ܱz�������H�c");
	</script>
	
	<p align="center"><br>
	Open<a href="http://mail.cal.aero" class="txtxred"> cal.aero mail-box</a></p>
	
	<p align="center" ><a href="overTimeQuery.jsp" target="topFrame" ><span class="txtxred"><u>�H�e��L���</u></span></a> </p>	
	<%	
	}
	else if("N".equals(returnstr))
	{//�|�L���[���
	%>
	
	<p align="center" >
		<a href="overTimeQuery.jsp" target="topFrame" ><span class="txtxred"><u>�L <%=year+"/"+month%> �[�Z�O���ӡA�Э��s�������H�e</u></span></a> 
	</p>
	
	<%
	
	}
	else
	{	
	%>
	<p align="center" >
		<a href="overTimeQuery.jsp" target="topFrame" ><span class="txtxred"><u>�H�e���ѡA�Э��s�������H�e</u></span></a> 
	</p>
	<%
	}
}//end of �H�e�[�Z�O���Ӭy�{		
%>

</body>
</html>
