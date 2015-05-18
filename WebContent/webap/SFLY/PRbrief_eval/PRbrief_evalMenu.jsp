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

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<!--  選擇填寫報告，或者查詢歷史資料   -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>客艙經理任務簡報表現評量 功能選擇</title>
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
      <p class="txttitletop" ><strong>客艙經理任務簡報表現評量 功能選擇：</strong></p>
    </td>
  </tr>
  <tr>
    <td>
      <p class="txtblue">1.<a href="#" onClick="load('PRbrief_evalEditQuery.jsp','blank.htm')" >
	  <u>撰寫/修改 客艙經理任務簡報表現評量</u></a></p>
	  <p class="txtblue">2.<a href="#" onClick="load('PRbrief_evalViewQuery.jsp','blank.htm')" ><u>查詢/列印 客艙經理任務簡報表現評量</u></a></p>
	  <p class="txtblue">3.<a href="#" onClick="load('caseStatusQuery.htm','blank.htm')" ><u>結案作業</u></a></p>
	  <p class="txtblue">4.客艙經理任務簡報表現評量 統計報表<br>
	  &nbsp;&nbsp;&nbsp;&nbsp;
	  <a href="#" onClick="load('blank.htm','PRbrief_evalStatQuery.jsp')">a.評量明細</u></a><br>
	  &nbsp;&nbsp;&nbsp;&nbsp;
	  <a href="#" onClick="load('blank.htm','PRbrief_evalStat2Query.jsp')">b.達成率統計</u></a><br>
	  </p>
	</td>
  </tr>
</table>
</body>
</html>
