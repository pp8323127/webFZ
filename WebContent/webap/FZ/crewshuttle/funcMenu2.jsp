<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*" errorPage="" %>
<%
//String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login
/*
if ( sGetUsr == null) 
{	//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} 
*/
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>CrewShuttle Menu</title>
<link rel="stylesheet" href="menu.css" type="text/css">
<script language="JavaScript" type="text/JavaScript">
function load(w1,w2)
{
		parent.topFrame.location.href=w1;
		parent.mainFrame.location.href=w2;
}

function openTSAcrew() {
	wTSAcrew = window.open('http://10.16.50.86:8080/apex/f?p=104:8:387183685200953:::::', 'TSAcrew', config='height=400,width=800')
}
</script>

<style type="text/css">
<!--
.style1 {font-size: 14pt}
-->
</style>
</head>

<body>
<p>&nbsp;</p>
<table width="90%"  border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="20%">&nbsp;</td>
    <td width="50%">
      <blockquote>
        <p class="txtblue">�E&nbsp;<a href="#" onClick="load('blank.html','../crewcar/crewcar_indate.jsp')">�խ��C�鱵�����</a></p>        
		<p class="txtblue">�E&nbsp;<a href="#" onClick="load('cnt_indate.jsp','blank.html')">����TPE��Z�խ��H��</a></p>
        <p class="txtblue">�E&nbsp;<a href="#" onClick="load('blank.html','getFile.jsp')">�խ�����ɶ�����</a></p>
        <p class="txtblue">�E&nbsp;<a href="#" onClick="load('sndsec_indate.jsp','blank.html')">�򭸲խ��W��</a></p>
		<p class="txtblue">�E&nbsp;<a href="#" onClick="load('blank.html','../crewcar/uvcar_indate.jsp')">(���A��)�խ�BOT�V�m���ȦW��</a></p>        
		<p class="txtblue">�E&nbsp;<a href="#" onClick="load('blank.html','http://10.16.50.86:8080/apex/f?p=104:8:387183685200953:::::')">(���A��)TSA�Q�s��Z TAO���խ��W��(���72�p�ɤ���Z)</a></p>        
		<p class="txtblue">�E&nbsp;<a href="#" onClick="openTSAcrew()">(���A��)TSA�Q�s��Z TAO���խ��W��(���72�p�ɤ���Z)</a></p>        
	
		<%
		if("640790".equals(sGetUsr))
		{
		%>
		<p class="txtblue">�E&nbsp;<a href="#" onClick="load('../crewmeal/mealQuery.jsp','blank.html')">Crew Meal</a></p>
		<%
		}
		%>
		</blockquote>
    </td>
  </tr>
</table>
<p>&nbsp;</p>
</body>
</html>
