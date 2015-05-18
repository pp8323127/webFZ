<%@page import="fz.psfly.isNewCheckForSFLY"%>
<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*,ci.db.*,java.net.URLEncoder" %>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login
String uid = (String) request.getParameter("uid");
String from_url = (String) request.getParameter("from_url");
if (userid == null && uid == null) 
{		
	response.sendRedirect("../logout.jsp");
}

if("WEBEG".equals(from_url))
{
	session.setAttribute("userid",uid);
}
isNewCheckForSFLY check = new isNewCheckForSFLY();
boolean isNew = check.checkTime("", "");//yyyy/mm/dd
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<!--  選擇填寫報告，或者查詢歷史資料   -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>自我督察報告 功能選擇</title>
<link href="../style.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
function load(w1,w2){
		parent.topFrame.location.href=w1;
		parent.mainFrame.location.href=w2;

}
</script>

<style type="text/css">
<!--
.style1 {color: #0000FF}
-->
</style>
</head>

<body>
<p>&nbsp;</p>
<table width="70%"  border="0" align="center" cellpadding="2" cellspacing="0">
  <tr>
    <td>
      <p class="txttitletop" ><strong>請選擇功能：</strong></p>
    </td>
  </tr>
  <tr>
    <td>
    	<p class="txtblue">1.<a href="schSelfInspDate.htm" target="topFrame"><u>撰寫/修改 自我督察報告( INSERT / MODIFY SELF INSPECTION LIST Report )</u></a></p>
      	<!-- <a href="#" onClick="load('schSelfInspDate.htm','selfInspRecomm.htm')" > -->
     	<p class="txtblue">2.<a href="schVPSelfInspDate.htm" target="topFrame"><u>查詢/列印 報告(View / Print Report)</u></a></p>
	  <!--<a href="#" onClick="load('schVPSelfInspDate.htm','../blank.htm')" > -->
	  	
     <%if(isNew){%>
      	<p class="txtblue">3.<a href="edIssue.jsp" target="mainFrame"><u>修改/增加 檢核項目(Edit / Add Check Issue)</u></a></p>
      	<p class="txtblue">4.<a href="schExpSILDate.htm" target="topFrame"><u><span class="style1">產生Excel報表(Export Excel Report)</span></u></a></p>
	 <%}else{ %>
		
	  	<p class="txtblue">3.<a href="edIssue.jsp" target="mainFrame"><u>修改/增加 檢核項目(Edit / Add Check Issue)</u></a></p>
      <!-- <a href="#" onClick="load('../blank.htm','edIssue.jsp')" > -->
	  	<p class="txtblue">4.<a href="schExpSILDate.htm" target="topFrame"><u><span class="style1">產生Excel報表(Export Excel Report)</span></u></a></p>
	  <!--  <a href="#" onClick="load('schExpSILDate.htm','../showUploadFile.htm')" > -->     
	
	<%} %>
	</td>
  </tr>
</table>
</body>
</html>
