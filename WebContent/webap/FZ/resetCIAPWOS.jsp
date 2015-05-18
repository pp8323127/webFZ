<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="java.sql.*"%>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() ) {		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} 
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Reset CIA Password</title>
<link href="PRORP3/style2.css" rel="stylesheet" type="text/css">
<script language="javascript">
function check(){
	if(document.form1.empno.value==""){
		alert("請輸入員工號");
		document.form1.empno.focus();
		return false;
	}else 	if(confirm("Do you want to reset password of CIA ?\n確定要重新設定密碼？")){
		return true;
	}
	else{
		return false;
	}
}
</script>
</head>

<body onLoad="document.form1.empno.focus()">
<div align="left"><span class="txtblue">Reset CIA Password to default value.
  </span>
</div>
<form name="form1" method="post" action="updResetCIAPWOS.jsp" onSubmit="return check()">
  <div align="left"><span class="txtblue">Empno</span>
    <input type="text" name="empno" size="6" maxlength="6">
    <br>
    <br>
    <input type="submit" class="delButon" value="Reset CIA Password" >
  </div>
</form>
<p align="left" class="txtblue">&nbsp;</p>
</p>
</body>
</html>
