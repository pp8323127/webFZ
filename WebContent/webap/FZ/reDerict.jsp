<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*" %>
<%
String msg = null;
int authCase = 0;
try{

authCase = Integer.parseInt(request.getParameter("authCase"));


switch (authCase) {
	case 2 :
		msg = "�K�X���~,�Э��s<a href=\"sendredirect.jsp\">�n�J</a>.";
		msg +="<br>�ѰO�K�X��<a href=\"requestPW.jsp\" target=_self>�I��</a><br>";
		msg +="Password Error!!,Please <a href=\"sendredirect.jsp\">relogin</a>.";
		msg +="<br>Click <a href=\"requestPW.jsp\" target=_self>Here</a> if you forget your password<br>";

		break;
	case 3 :
		msg = "�K�X���~,�Э��s<a href=\"sendredirect.jsp\">�n�J</a>.";
		msg +="<br>�ѰO�K�X��<a href=\"requestPW.jsp\" target=_self>�I��</a><br>";
		//msg +="����Ʀw���ΫO�K,�Y��_ED�ο줽�ǤH��,�Ч�Υ����q�l�H�c���K�X�n�J.<br>";
		msg +="Password Error!!,Please <a href=\"sendredirect.jsp\">relogin</a>.";
		msg +="<br>Click <a href=\"requestPW.jsp\" target=_self>Here</a> if you forget your password<br>";
//		msg +="Please use your password of Aero Mail to login the system.";

		break;
	case 5 :
		msg = "�s�i�e���խ�,�Ь���ȸ굦���إ߱b��<br>";

		break;
	case 6 :
		msg ="�z�L�v�i�J�Z���T��<br>";
		msg += "You are not authorized to login the system.<br><br>";
		msg +="���s<a href=\"sendredirect.jsp\">�n�J</a>.<br>Please <a href=\"sendredirect.jsp\">relogin</a> the system.";
		
		break;
	case 7 :
		msg = "����J�b���K�X,�Э��s<a href=\"sendredirect.jsp\">�n�J</a><br>";
		msg += "User id and password is required.Please <a href=\"sendredirect.jsp\">relogin</a> the system.<br>";
		break;
	case 8 :
		msg = "�n�J����,�Э��s<a href=\"sendredirect.jsp\">�n�J</a><br>";
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
	font-family:Verdana, "�ө���";color:#006699;
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
