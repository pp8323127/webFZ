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
<title>寄送個人加班費明細</title>
<link href="../menu.css" rel="stylesheet" type="text/css">

<link href="menu.css" rel="stylesheet" type="text/css">
</head>

<body>
<%


String year = request.getParameter("year");
String month = request.getParameter("month");
boolean sendSuccess = false;
String rs = null;
//取得飛加公佈日期
df.flypay.PublishCheck pc = new df.flypay.PublishCheck(year, month, userid);

if(pc.isCheckable() && !pc.isPublished())
{	//一個月內的資料，需檢查公佈日期 && 尚未公佈
%>
<p align="center" >
	<span class="txtxred"><u><%=year+"/"+month%> 加班費明細尚未公佈</u></span>
</p>
<%
}
else
{ //寄送加班費明細流程 start
	//SBIREmail s = new SBIREmail(year, month, userid);
	//SBIREmail_For16Hrs s = new SBIREmail_For16Hrs(year, month, userid);
    //s.setEmpnoObj();

	Calendar gc = new GregorianCalendar();  
	//2007/12 份使用aircrews
	gc.set(2007,11,1);
			
	Calendar gcnow = new GregorianCalendar();  
	//計算當月
	gcnow.set(Integer.parseInt(year),Integer.parseInt(month)-1,1);

	String returnstr = "";
	if(gc.after(gcnow))
	{
		//依Flt log 發送
		//out.println("old");
		SBIREmail_For16Hrs s = new SBIREmail_For16Hrs(year, month, userid);
		s.setEmpnoObj();
		returnstr = s.getReturnStr();
	}
	else
	{
		//依AirCrews 發送
		//out.println("new");
		SBIREmail_AC s = new SBIREmail_AC(year, month, userid);
		s.setEmpnoObj();
		returnstr = s.getReturnStr();
	}

	if("Y".equals(returnstr))
	{//寄送成功
		fz.writeLog wl = new fz.writeLog();
		wl.updLog(userid, request.getRemoteAddr(),request.getRemoteHost(), "FZ401");	
	%>
	<script lanquag="JAVASCRIPT">
		alert("檔案已寄出至您的全員信箱");
	</script>
	
	<p align="center"><br>
	Open<a href="http://mail.cal.aero" class="txtxred"> cal.aero mail-box</a></p>
	
	<p align="center" ><a href="overTimeQuery.jsp" target="topFrame" ><span class="txtxred"><u>寄送其他月份</u></span></a> </p>	
	<%	
	}
	else if("N".equals(returnstr))
	{//尚無飛加資料
	%>
	
	<p align="center" >
		<a href="overTimeQuery.jsp" target="topFrame" ><span class="txtxred"><u>無 <%=year+"/"+month%> 加班費明細，請重新選取月份寄送</u></span></a> 
	</p>
	
	<%
	
	}
	else
	{	
	%>
	<p align="center" >
		<a href="overTimeQuery.jsp" target="topFrame" ><span class="txtxred"><u>寄送失敗，請重新選取月份寄送</u></span></a> 
	</p>
	<%
	}
}//end of 寄送加班費明細流程		
%>

</body>
</html>
