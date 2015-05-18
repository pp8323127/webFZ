<%@ page contentType="text/html; charset=big5" language="java" import="java.util.*" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>索取個人加班費明細</title>
<link href="menu.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript" src="js/showDate.js"></script>
<script language="javascript">
function disa()
{
	document.form1.Submit.disabled=1;
	document.form1.resend.disabled=0;

	return true;
}
 

</script>
</head>

<body onload="showYM('form1','year','month')">
<form method="post" name="form1" target="mainFrame" class="txtblue" id="form1" action="overTimeStatement.jsp" onsubmit="return disa()">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td valign="middle" class="txtblue">&nbsp;&nbsp;
        <select name="year" class="t1">
	  <%
		java.util.Date now = new Date();
		int syear	=	now.getYear() + 1900;
		for (int i=syear-1; i<syear+2; i++) 
		{    
	  %>
		 <option value="<%=i%>"><%=i%></option>
	  <%
		}
	  %>
	  </select>
        年
	  <select name="month" class="t1">
		<option value="01">01</option>
		<option value="02">02</option>
		<option value="03">03</option>
		<option value="04">04</option>
		<option value="05">05</option>
		<option value="06">06</option>
		<option value="07">07</option>
		<option value="08">08</option>
		<option value="09">09</option>
		<option value="10">10</option>
		<option value="11">11</option>
		<option value="12">12</option>
	</select>	
	月
    <input type="submit" name="Submit" value="Query" class="btm">    
		<input name="resend" type="button" disabled   onClick="document.form1.Submit.disabled=0;this.disabled=1" value="Reset"> 
		輸入欲寄送加班費明細月份</td>
    </tr>
  </table>
</form>
</body>
</html>
