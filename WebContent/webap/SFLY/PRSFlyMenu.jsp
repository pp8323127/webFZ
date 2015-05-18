<%@page import="fz.psfly.isNewCheckForSFLY"%>
<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*,ci.db.*,java.net.URLEncoder" %>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login
String uid = (String) request.getParameter("uid");
String from_url = (String) request.getParameter("from_url");

if (userid == null && uid == null) 
{		
	response.sendRedirect("logout.jsp");
}
if("WEBEG".equals(from_url))
{
	session.setAttribute("userid",uid);
}
isNewCheckForSFLY check = new isNewCheckForSFLY();
boolean isNew = check.checkTime("", "");//yyyy/mm/dd  default 2014/11/01
%>
<!--  選擇填寫報告，或者查詢歷史資料   -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Cabin Safety Check List 功能選擇</title>
<link href = "style.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
function load(w1,w2)
{
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
      <p class="txttitletop"><strong>Cabin Safety Check List 功能選擇：</strong></p>
    </td>
  </tr>
  <tr>
    <td>
      <%if(isNew){%>
      <p class="txtblue">1.<a href="#" onClick="load('blank.htm','schQuery.jsp')"><u>Insert/Modify  List</u></a></p>    	
      <%}else{ %>
	  <p class="txtblue">1.<a href="#" onClick="load('blank.htm','fltInfo.jsp')"><u>Insert/Modify  List</u></a></p>
	  <%} %>
	  <p class="txtblue">2.<a href="#" onClick="load('schFltDate.htm','blank.htm')"><u>View/Print  List</u></a></p>
	  <p class="txtblue">3.Cabin Safety Check List 統計報表<br>&nbsp;&nbsp;&nbsp;&nbsp;
	  <a href="#" onClick="load('schExpDate.htm','showUploadFile.jsp')">a.Export Excel File</u></a><br>
	  &nbsp;&nbsp;&nbsp;&nbsp;
	  <a href="#" onClick="load('schExpDateQA.htm','blank.htm')">b.QA, Suggestion Report</u></a><br>  
	  <p class="txtblue">4.<a href="#" onClick="load('blank.htm','edItem.jsp')"><u>Edit Check Item</u></a></p>
	  <p class="txtblue">5.<a href="#" onClick="load('blank.htm','edRemark.jsp')"><u>Edit Remark Value</u></a></p>
	  
	</td>
  </tr>
</table>
</body>
</html>
