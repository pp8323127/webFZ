<%@page contentType="text/html; charset=big5" language="java"%>
<jsp:useBean id="ALInfo" scope="page" class="al.ALInfo"/>
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
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String userid = request.getParameter("userid");
String password = request.getParameter("password");
String errMsg = "";
boolean status = true;
try{	
	String rs = ALInfo.chkUser(userid, password);
	if(!"0".equals(rs)){
		//login fail		
		status = false;
		errMsg = "Login Failed!!";
	}else{
		//login success
		session.setAttribute("password", password) ;
		status = true;				
	}
	
	
}catch(Exception e){
	status = false;
	errMsg = "ERROR:"+e.getMessage();
	
}

if(userid == null ){
%>
<div class="warning2 red">網頁已過期，請重新登入</div>
<%
}
else if(!status){
%>
<div class="warning2 red"><%=errMsg%><br>
</div>
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
}
else
{
	response.sendRedirect("offFrame.htm");
}
%>
</body>
</html>
