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
<!--  ��ܶ�g���i�A�Ϊ̬d�߾��v���   -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>�ȿ��g�z¾����q �\����</title>
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
      <p class="txttitletop" ><strong>�ȿ��g�z¾����q �\���ܡG</strong></p>
    </td>
  </tr>
  <tr>
    <td>
    <%if(isNew){ %>
    
    <%}else{ %>
    
    <%} %>
      <p class="txtblue">1.<a href="#" onClick="load('PRfunc_evalEditQuery.htm','blank.htm')">
	  <u>���g/�ק� �ȿ��g�z¾����q���i</u></a></p>
	  <p class="txtblue">2.<a href="#" onClick="load('PRfunc_evalViewQuery.htm','blank.htm')"><u>�d��/�C�L �ȿ��g�z¾����q���i</u></a></p>
	  <p class="txtblue">3.<a href="#" onClick="load('blank.htm','edCusTemp.jsp')"><u>�s��ȫȤϬM���� & �M�μ˪O</u></a></p>
	  <p class="txtblue">4.�ȿ��g�z¾����q �έp����<br>
	  &nbsp;&nbsp;&nbsp;&nbsp;
	  <a href="#" onClick="load('blank.htm','PRfunc_evalStatQuery.jsp')">a.���q����</a><br>
	  &nbsp;&nbsp;&nbsp;&nbsp;
	  <a href="#" onClick="load('blank.htm','PRfunc_evalStat2Query.jsp')">b.�F���v�έp</a><br>
	  &nbsp;&nbsp;&nbsp;&nbsp;
	  <a href="#" onClick="load('blank.htm','PRfunc_evalStat3Query.jsp')">c.�ȫȤϬM�ƶ����R</a><br>
	  </p>
	</td>
  </tr>
</table>
</body>
</html>
