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
	font-family:Verdana, "�ө���";color:#006699;
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
//�g�Jlog
writeLog wrtLog = new writeLog();
wrtLog.updLog(empno,request.getRemoteAddr(),request.getRemoteHost(),"FZ339");
		
%>
�z���K�X�w�H�ܥ����H�c.�Ц�<a href="http://mail.cal.aero" target="_blank">�����H�c</a>�����H��.<br>
Password had been send to  your <a href="http://mail.cal.aero" target="_blank">webmail</a>.<br>
<br>
<a href="sendredirect.jsp" target="_self">���s�n�J(Login again)</a><br>
<br>

<%		
	}else{
%>
�K�X�H�e���ѡA��<a href="sendredirect.jsp" target="_self">���s�A��</a>.<br>
Send Password failed.Please <a href="sendredirect.jsp" target="_self">try again</a>.
<%	
		out.print("�K�X�H�e���ѡA�Э��s�A��");
	}

}else{
%>
<br>
<br>
���b�����s�b,�Y�z���v�ϥίZ���T��,<br>
�e���խ��Ь���ȸ굦��(EXT.6496)�إ߱b���C<br>
<br>
This account is invalid,if you are authoried,cockpit crew please contact with OV (EXT.6496) to create account.
<%
}
%>
</p>
