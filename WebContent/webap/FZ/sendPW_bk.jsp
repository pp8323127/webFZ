<%@ page contentType="text/html; charset=big5" language="java"%>
<%@ page  import="java.sql.*,fz.resetPW,ci.tool.*" %>

<%
String empno = request.getParameter("empno");
String status = null;

resetPW tm = new resetPW(empno);
try {
	status =tm.job();
} catch (Exception e) {
	out.print(e.toString());
}


if("OK".equals(status)){
%>
<script language="JavaScript" type="text/JavaScript">
	alert("Password send to  your webmail(http://mail.cal.aero).\n�K�X�w�H�ܥ����H�c.");
	document.write("Password send to  your <a href='http://mail.cal.aero' target=_blank>webmail(http://mail.cal.aero)</a><br>�K�X�w�H�ܥ����H�c!!<br><a href='sendredirect.jsp'>Back to Login</a>");
</script>
<%

//Write Log
  WriteLog wl = new  WriteLog(application.getRealPath("/")+"/Log/resetPWLog.txt");
String wlMsg = wl.WriteFileWithTime(empno+" reset password");
if(!"0".equals(wlMsg)){
	response.sendRedirect("showMessage.jsp?messagestring="+wlMsg);
}

}else{
%>
<script language="JavaScript" type="text/JavaScript">
	alert("���b�����s�b");
	self.location="requestPW.jsp";
</script>
<%	
}
%>