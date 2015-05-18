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
boolean isNew = check.checkTime("", "");//yyyy/mm/dd  default 2014/11/01
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<!--  選擇填寫報告，或者查詢歷史資料   -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>客艙經理職能評量 功能選擇</title>
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
      <p class="txttitletop" ><strong>客艙經理職能評量 功能選擇：</strong></p>
    </td>
  </tr>
  <tr>
    <td>
    <%if(isNew){ %>
    
    <%}else{ %>
    
    <%} %>
      <p class="txtblue">1.<a href="#" onClick="load('PRfunc_evalEditQuery.htm','blank.htm')">
	  <u>撰寫/修改 客艙經理職能評量報告</u></a></p>
	  <p class="txtblue">2.<a href="#" onClick="load('PRfunc_evalViewQuery.htm','blank.htm')"><u>查詢/列印 客艙經理職能評量報告</u></a></p>
	  <p class="txtblue">3.<a href="#" onClick="load('blank.htm','edCusTemp.jsp')"><u>編輯旅客反映項目 & 套用樣板</u></a></p>
	  <p class="txtblue">4.客艙經理職能評量 統計報表<br>
	  &nbsp;&nbsp;&nbsp;&nbsp;
	  <a href="#" onClick="load('blank.htm','PRfunc_evalStatQuery.jsp')">a.評量明細</a><br>
	  &nbsp;&nbsp;&nbsp;&nbsp;
	  <a href="#" onClick="load('blank.htm','PRfunc_evalStat2Query.jsp')">b.達成率統計</a><br>
	  &nbsp;&nbsp;&nbsp;&nbsp;
	  <a href="#" onClick="load('blank.htm','PRfunc_evalStat3Query.jsp')">c.旅客反映事項分析</a><br>
	  </p>
	</td>
  </tr>
</table>
</body>
</html>
