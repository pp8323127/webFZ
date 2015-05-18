<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="java.sql.*"%>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) {		//check user session start first or not login
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
	if(confirm("Do you want to reset password of CIA ?\n確定要重新設定密碼？")){
		return true;
	}
	else{
		return false;
	}
}
</script>
</head>

<body>
<div align="center"><span class="txtblue">Reset CIA Password
  </span>
</div>
<form name="form1" method="post" action="updResetCIAPW.jsp" onSubmit="return check()">
  <div align="center">
    <input type="submit" class="delButon" value="Reset CIA Password" >
  </div>
</form>
<p class="txtblue">1.Reset CIA Password to default value.The default password in CIA is &quot;<span class="txtxred">$1688$</span>&quot;. (case sensitive) <br>
(將CIA密碼還原成預設值:&quot;<span class="txtxred">$1688$</span>&quot;,請注意大小寫)</p>
<p class="txtblue"><span class="txtxred">2.復飛組員需待AirCrews生效日後，方可使用CIA.</span><br>
  <br>
  <input type="button"  onClick="javascript:window.open('http://cia.china-airlines.com');" value=" CIA 班表查詢" style="background-color: #edf3fe;color: #000000;text-align: center; "  >
</p>
</body>
</html>
