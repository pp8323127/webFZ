<%@ page contentType="text/html; charset=big5" language="java" import="fz.*"%>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //Check if logined
if ((sGetUsr == null) || (session.isNew()) )
{		//check user session start first or not login
	response.sendRedirect("sendredirect.jsp");
} 
//***********for test*******************
//2013/6/6 insert CS80 
if("637299".equals(sGetUsr) | "643937".equals(sGetUsr)){
	sGetUsr = "633237";		//sGetUsr = "310686";
	session.setAttribute("userid", sGetUsr) ;
}
//**************************************
chkUser cu = new chkUser();
try{cu.findCrew(sGetUsr);}catch(Exception e){}
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<meta name="GENERATOR" content="Microsoft FrontPage Express 2.0">
<title>Crew Reporting Check System</title>
<link href="../menu.css" rel="stylesheet" type="text/css">
<script language="javascript" src="js/frameset.js" type="text/javascript"></script>
<style type="text/css">
<!--
body {
	background-color: #99ccff;
}
-->
</style>
</head>

<body>
<p><a href="http://www.china-airlines.com" target="_blank"><img src="../images/logo2.gif" border="0" alt="www.china-airlines.com" width="165" height="35"></a>
<ul>
    <li><a href="#" class="txtblue" onClick='javascript:load("CRCStop.jsp?msg=Flight Duty","CRCSmain.jsp")'>Flight Duty</a></li>
	<p>
	<li><a href="#" class="txtblue" onClick='javascript:load("CRCStop.jsp?msg=Licence","updlog.jsp?linkpage=../tsa/LIC/crewlic.jsp?empno=<%=sGetUsr%>&sysname=licence")'>Licence check</a></li>
	<P>
	<li><a href="#" class="txtblue" onClick='javascript:load("CRCStop.jsp?msg=E-Learning","http://tpeweb03.china-airlines.com:9901/webdz/eLearning/eLearningList.jsp?empno=<%=sGetUsr%>")'>E-Learning</a></li>
	<P>
	<li><a href="#" class="txtblue" onClick='javascript:load("CRCStop.jsp?msg=CATII/IIIa","updlog.jsp?linkpage=http://tpeweb03.china-airlines.com:9901/webdz/catiii/cat_report.jsp?empno=<%=sGetUsr%>&sysname=CATII/IIIa")'>CATII/IIIa check</a></li>
	<P>
	<li><a href="#" class="txtblue" onClick='load("crewrecquery.jsp","../blank.htm")'>CrewRec</a></li>
	<P>
	<li><a href="#" class="txtblue" onClick='javascript:load("CRCStop.jsp?msg=Personal Info","../tsa/crewquery.jsp?empno=<%=sGetUsr%>")'>Personal Info</a></li>
	<P>
	<li>
	  <form name="form1" method="post" target="mainFrame" onSubmit="javascript:sub('form1', 'blank.htm', '../tsa/daily/landing90day.jsp')">
	    <span class="txtblue">Landing Times</span><br>
	    <select name="theday" id="theday">
	      <option value="30">30</option>
	      <option value="60">60</option>
	      <option value="90">90</option>
        </select>
        <input type="submit" name="Submit" value="Check"> 
        <input name="empno" type="hidden" id="empno" value="<%=sGetUsr%>">  
		<input name="cname" type="hidden" id="cname" value="<%=cu.getName()%>">  
	  </form>
	</li>
	<P>
	<li><img src="../images/ed1.gif" width="22" height="22"><a href="#" class="txtblue" onClick='javascript:load("next1.jsp","notice.htm")'>Check In</a></li>
	<P>
	<li><a href="#" class="txtblue" onClick='load("crewcheckquery.jsp","../blank.htm")'>Crew Qualifications</a></li>
	<P>
	<li>  <a href="sendredirect.jsp" class="txtblue">Log out</a></li>
	</ul>
</body>
</html>
