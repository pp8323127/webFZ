<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*" errorPage="" %>
<%
//ALLoginCheck.jsp

String userid = (String)session.getAttribute("userid");
String password = (String)session.getAttribute("password");

// EG status, 1=在職
String egStatus = (String)session.getAttribute("EGStatus");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Login AL System</title>
<link rel="stylesheet" type="text/css" href="../FZ/checkStyle1.css">
<link rel="stylesheet" type="text/css" href="../FZ/lightColor.css">
<link rel="stylesheet" type="text/css" href="../FZ/msgStyle.css">
</head>

<body>
<%
if(userid == null ){
%>
<div class="warning2 red">網頁已過期，請重新登入</div>
<%
}else if(!"1".equals(egStatus)){
//不在職
%>
<div class="warning2 red">
  非後艙在職組員，不得使用年假輸入查詢功能.
    <br>
    <br>
    留停後復職組員，
  請洽行政組更新基本資料狀態.<br>
  <br>
Only on duty crew are authorized.<br>
Reinstate  after suspend,
 contact EA to update your personal  information. <br>
</div>
<%
}else if(password == null){
%>
<fieldset style="width:300px; ">
<legend class="blue"><img src="../FZ/images/messagebox_info.png" align="absmiddle" width="22" height="22" style="margin-right:1em; ">請輸入年假系統(班表資訊網)之密碼</legend>

<form name="form1" method="post" action="chkuserFromCIA.jsp" onSubmit="return chkForm()">
<input type="hidden" name="userid" id="userid" value="<%=userid%>">
<label for="password" style="margin-right:1em; ">Password</label><input type="password" id="password"size="10" maxlength="20" name="password" style="margin-right:1em; ">
<input type="submit" value="登入年假查詢" class="buttonLBlue">
</form>
</fieldset>
<script language="javascript" type="text/javascript">
document.getElementById("password").focus();
function chkForm(){
	if(document.getElementById("password").value == ""){
		alert("密碼不得空白");
		document.getElementById("password").focus();
		return false;
	}else{
		return true;
	}
}
</script>
<%
}else{
	response.sendRedirect("chkuser.jsp?userid="+userid+"&password="+password);
}

%>
</body>
</html>
