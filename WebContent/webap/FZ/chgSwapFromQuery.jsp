<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*"  %>
<%
String userid = (String)session.getAttribute("userid");
//20130326�W�[**
String occu = (String) session.getAttribute("occu");
String powerUser =(String)session.getAttribute("powerUser");
//**************
if(userid == null){
	response.sendRedirect("sendredirect.jsp");
}else if(!("ED".equals(occu) | "Y".equals(powerUser))){//���դ�ñ���i�ݦ���20130326�W�[
%>
	<p  class="errStyle1">1.�z�L�v�ϥΦ��\��I<br> 2.���m�L�[�Э��s�n�J�I</p>
<%
	
}else{
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>�ӽг檬�A��s�d��</title>
<script type="text/javascript" language="javascript" src="js/showDate.js"></script>
<link href="menu.css" rel="stylesheet" type="text/css">
<link href="kbd.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript">
function chk(){
	var d = document.form1.num.value;
	if(d == ""){
		alert("�п�J�渹!!");
		document.form1.num.focus()
		return false;
	}else{
		return true;
	}
}
</script>
</head>

<body onLoad="showYM('form1','year','month');document.form1.num.focus()">
<form  action="chgSwapFromList.jsp" method="post" name="form1" target="mainFrame" onsubmit="return chk()">
	<select name="year">
	<jsp:include page="temple/year.htm" />
	</select>
	<select name="month">
	<jsp:include page="temple/month.htm" />
	</select>
	<span class="txtblue">�渹</span>
	<input type="text" size="4" maxlength="4" name="num">
<input type="submit" class="kbd" value="QUERY">
<span class="txtxred">*��s�ӽг�B�z���A.�п�ܦ~.��.�Υӽг渹
</span>
</form>
</body>
</html>
<%
}
%>