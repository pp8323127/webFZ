<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,java.sql.Date,fz.*" errorPage="" %>
<%
String userid = (String) session.getAttribute("cs55.usr");
//String ourTeam = (String)session.getAttribute("CSOZEZ");
fzAuth.UserID userID = new fzAuth.UserID(userid,null);
fzAuth.CheckPowerUser ck = new fzAuth.CheckPowerUser();
// ck.isHasPowerUserAccount()  ���ˬd�O�_���b���A���ˬd�K�X

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<script language="javascript" type="text/javascript" src="linkTo.js"></script>
<title>Overtime Menu</title>
<style type="text/css">
<!--
.style1 {
	font-size: 14pt;
	font-weight: bold;
}
-->
</style>
</head>

<body>
<p>&nbsp;</p>
<table width="90%"  border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td>&nbsp;</td>
    <td>
	<%
	if (ck.isHasPowerUserAccount()  || "631931".equals(userid))
	{
	%>
        <!--<p class="txtblue"><img src="../../FZ/images/point.gif" width="10" height="10" border="0">&nbsp;&nbsp;<a href="#" onClick="linkTo('blank.htm','editAdjt.jsp')">�����u�ɽվ� ( Flight Log ��)</a></p>-->
	<%
	}
	%>

		<p class="txtblue"><img src="../../FZ/images/point.gif" width="10" height="10" border="0">&nbsp;&nbsp;<a href="#" onClick="linkTo('blank.htm','editAdjt_ac.jsp')">�����u�ɽվ�(AirCrews��) Since December, 2007</a></p>
        <p class="txtblue"><img src="../../FZ/images/point.gif" width="10" height="10" border="0">&nbsp;&nbsp;<a href="#" onClick="linkTo('blank.htm','transferfltlist.jsp')">�V�v�u���I���@</a></p>
        <p class="txtblue">&nbsp;</p>		
    </td>
    <td>&nbsp;</td>
  </tr>
</table>
<p>&nbsp;</p>
</body>
</html>
