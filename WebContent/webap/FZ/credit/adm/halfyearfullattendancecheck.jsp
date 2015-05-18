<%@page contentType="text/html; charset=big5" language="java" import="credit.*"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String userid = (String) session.getAttribute("userid") ; //get user id if already login
String empno = request.getParameter("empno");
if (session.isNew() || userid == null) 
{		//check user session start first
	response.sendRedirect("../../tsa/sendredirect.jsp");
} 

ArrayList halfyearfullAttendAL = new ArrayList();
HalfYearFullAttendanceCheck faps = new HalfYearFullAttendanceCheck(empno);
//faps.getCheckRange();
//halfyearfullAttendAL = faps.getHalfYearFullAttendanceRange();

faps.getCheckRange2();
halfyearfullAttendAL = faps.getHalfYearFullAttendanceRange2();

session.setAttribute("halfyearfullAttendAL", halfyearfullAttendAL);
%>
<html>
<head>
<title>Half year Full Attendance</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<meta http-equiv="pragma" content="no-cache">
<link href="menu.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.no_border
{  
border-bottom: 1.5px solid #808080 ;
border-top: 0px solid #FFFFFF ;
border-left: 0px solid #FFFFFF ;
border-right: 0px solid #FFFFFF ;
font-weight: bold;
font-size: 9pt;
}
.style1 {color: #FF0000}
.navtext { 
width:200px; 
font-size:8pt; 
border: 1px solid #fff; 
background-color:#FFCCFF;
color:#39c; 
} 
-->
</style>
<script language="JavaScript">
function setrange(var1,var2)
{
	window.opener.form1.sdate.value = eval("var1");
	window.opener.form1.edate.value = eval("var2");
	this.window.close();
}
</script>
</head>
<body bgcolor="#FFFFFF" text="#000000">
<div width="90%" align="center">
    <font face="Comic Sans MS" color="#003399">半年全勤記錄</font>
</div>
<div align="center">
<form name="form1" action="" onSubmit="return conf();">
    <table width="90%" border="1" cellspacing="0" cellpadding="0">
	  <tr>
	    <td class="tablehead3" align="center" >#</td>
	    <td class="tablehead3" align="center" >全勤起始日</td>
	    <td class="tablehead3" align="center" >全勤結束日</td>
	    <td class="tablehead3" align="center" >&nbsp;</td>
	  </tr>
<%
	for(int i=0; i<halfyearfullAttendAL.size(); i++)
	{
		FullAttendanceForPickSkjObj obj = (FullAttendanceForPickSkjObj) halfyearfullAttendAL.get(i);
%>
<!--
	  <tr>
	    <td class="txtblue" align="center"><%=i+1%></td>
	    <td class="txtblue" align="center"><%=obj.getCheck_range_final_end()%></td>
	    <td class="txtblue" align="center"> <%=obj.getCheck_range_start()%></td>
		<td class="txtblue" align= "center"><input name="apply<%=i%>" type="button" id="apply<%=i%>" value="Apply" class="txtblue" onclick="setrange('<%=obj.getCheck_range_final_end()%>','<%=obj.getCheck_range_start()%>')"></td>
	  </tr>
-->
	  <tr>
	    <td class="txtblue" align="center"><%=i+1%></td>
	    <td class="txtblue" align="center"><%=obj.getCheck_range_start()%></td>
	    <td class="txtblue" align="center"> <%=obj.getCheck_range_final_end()%></td>
		<td class="txtblue" align= "center"><input name="apply<%=i%>" type="button" id="apply<%=i%>" value="Apply" class="txtblue" onclick="setrange('<%=obj.getCheck_range_start()%>','<%=obj.getCheck_range_final_end()%>')"></td>
	  </tr>
<%		
	}

	if (halfyearfullAttendAL.size()<=0)
	{
%>
	  <tr>
	    <td colspan = "4" align="center" class="txtxred" bgcolor=#CCCCFF>N/A</td>
	  </tr>
<%
	}
%>
   </table>
</form>
</body>
</html>

