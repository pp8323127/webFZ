<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*" %>
<%
String msg = null;
int authCase = 0;
try{

authCase = Integer.parseInt(request.getParameter("authCase"));


switch (authCase) {
	case 2 :
		msg = "密碼錯誤,請重新<a href=\"sendredirect.jsp\">登入</a>.";
		msg +="<br>忘記密碼請<a href=\"requestPW.jsp\" target=_self>點此</a><br>";
		msg +="Password Error!!,Please <a href=\"sendredirect.jsp\">relogin</a>.";
		msg +="<br>Click <a href=\"requestPW.jsp\" target=_self>Here</a> if you forget your password<br>";

		break;
	case 3 :
		msg = "密碼錯誤,請重新<a href=\"sendredirect.jsp\">登入</a>.";
		msg +="<br>忘記密碼請<a href=\"requestPW.jsp\" target=_self>點此</a><br>";
		//msg +="為資料安全及保密,即日起ED及辦公室人員,請改用全員電子信箱之密碼登入.<br>";
		msg +="Password Error!!,Please <a href=\"sendredirect.jsp\">relogin</a>.";
		msg +="<br>Click <a href=\"requestPW.jsp\" target=_self>Here</a> if you forget your password<br>";
//		msg +="Please use your password of Aero Mail to login the system.";

		break;
	case 5 :
		msg = "新進前艙組員,請洽航務資策部建立帳號<br>";

		break;
	case 6 :
		msg ="您無權進入班表資訊網<br>";
		msg += "You are not authorized to login the system.<br><br>";
		msg +="重新<a href=\"sendredirect.jsp\">登入</a>.<br>Please <a href=\"sendredirect.jsp\">relogin</a> the system.";
		
		break;
	case 7 :
		msg = "未輸入帳號密碼,請重新<a href=\"sendredirect.jsp\">登入</a><br>";
		msg += "User id and password is required.Please <a href=\"sendredirect.jsp\">relogin</a> the system.<br>";
		break;
	case 8 :
		msg = "登入失敗,請重新<a href=\"sendredirect.jsp\">登入</a><br>";
		msg += "Login failed.!!Please <a href=\"sendredirect.jsp\">relogin</a> the system.<br>";
		break;

	default:
	break;
}


}catch(NullPointerException e){
	out.print(e.toString());
}catch(NumberFormatException e){
	out.print(e.toString());
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Login Failed!!</title>
<style type="text/css">
#msg{
	/*padding:10pt;padding-left:200;padding-right:100;*/
	margin-left:auto;margin-right:auto;width:550px;padding-top:20;
	font-family:Verdana, "細明體";color:#006699;
	font-size:13px;
	text-align:justify;
}
	#msg .r{
	color:#FF0000;font-weight:bold;
	}
	
a:link,,a:visited,a:hover,a:active{
	color:#FF0000;font-weight:bold;text-decoration:underline
}
</style>
</head>

<body>
<p id="msg" ><%=msg%></p>
</body>
</html>
