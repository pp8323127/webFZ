<%@ page contentType="text/html; charset=big5" language="java"%>
<%@ page  import="java.sql.*,fzAuth.ForgetPW,ci.tool.*,fz.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Forget Password</title>
<style type="text/css">
#msg{
	/*padding:10pt;padding-left:200;padding-right:100;*/
	margin-left:auto;margin-right:auto;width:400px;padding-top:20px;
	font-family:Verdana, "細明體";color:#006699;
	font-size:12px;
	text-align:justify;}
	#msg .r{
	color:#FF0000;font-weight:bold;
	}
	
a:link,a:visited,a:hover,a:active{
	color:#FF0000;font-weight:bold;text-decoration:underline
}

</style>
<p id="msg">
<%
String empno = request.getParameter("empno");
ForgetPW fp = new ForgetPW(empno);
fp.job();
if(fp.isValidAcc() ){
	if(fp.isStatus()){	
//寫入log
writeLog wrtLog = new writeLog();
wrtLog.updLog(empno,request.getRemoteAddr(),request.getRemoteHost(),"FZ339");
		
%>
您的密碼已寄至全員信箱.請至<a href="http://mail.cal.aero" target="_blank">全員信箱</a>收取信件.<br>
Password had been send to  your <a href="http://mail.cal.aero" target="_blank">webmail</a>.<br>
<br>
<a href="sendredirect.jsp" target="_self">重新登入(Login again)</a><br>
<br>

<%		
	}else{
%>
密碼寄送失敗，請<a href="sendredirect.jsp" target="_self">重新再試</a>.<br>
Send Password failed.Please <a href="sendredirect.jsp" target="_self">try again</a>.
<%	
		out.print("密碼寄送失敗，請重新再試");
	}

}else{
%>
<br>
<br>
此帳號不存在,若您有權使用班表資訊網,<br>
前艙組員請洽航務資策部(EXT.6496)建立帳號。<br>
<br>
This account is invalid,if you are authoried,cockpit crew please contact with OV (EXT.6496) to create account.
<%
}
%>
</p>
