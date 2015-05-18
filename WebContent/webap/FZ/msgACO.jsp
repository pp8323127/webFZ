<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*" errorPage="" %>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
  %> <jsp:forward page="sendredirect.jsp" /> <%
}else{ 

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>意見反應</title>
<link href="swap3/swap.css" rel="stylesheet" type="text/css">
</head>
<script language="javascript" type="text/javascript">
function dis(){
	if(document.form1.msg.value == ""){
		alert("請輸入Message!!");
		document.form1.msg.focus();
		return false;
	}else{
		document.form1.Submit.disabled=1;
		document.form1.r.disabled=1;
		return true;
	}

}
</script>
<body onLoad="document.form1.msg.focus();">
<form method="post" action="updMsgAC.jsp" onsubmit="return dis()" name="form1">
<table width="41%"  border="0" align="center" cellpadding="1" cellspacing="0">
  <tr>
    <td width="25%" class="bt2">Message</td>
    <td width="75%">
      <div align="left">
        <textarea cols="40" name="msg" rows="10"></textarea>
      </div>
    </td>
  </tr>
  <tr>
    <td colspan="2">
      <input name="Submit" type="submit" class="bt" value="Send">
      &nbsp;&nbsp;&nbsp;
      <input name="r" type="reset" class="bt2" value="Clear">
    </td>
    </tr>
</table><br>
<table width="41%"  border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><div align="left" style="color:#FF0000">新進組員請另以電話向組派部門確認是否已加入AirCrews資料，否則無法登入。
	<br>
	New crew please contact crew scheduling dpt. to ensure your data has been added in AirCrews.</div></td>
  </tr>
</table>
<p>&nbsp;</p>
</form>
</body>
<%
}
%>
</html>
