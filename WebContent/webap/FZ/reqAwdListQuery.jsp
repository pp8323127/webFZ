<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*"  %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>�H�eaward list </title>
<script language="JavaScript" type="text/JavaScript" src="js/showDate.js"></script>

<script language="javascript" type="text/javascript">
 function disableButon(){	//��ưe�X��A�Nsubmit button disable
 	document.form1.Submit.disabled=1;
	document.form1.resend.disabled=0;
	return true;
 }

</script>

<link href="menu.css" rel="stylesheet" type="text/css">

</head>

<body onload="showYM('form1','year','month')">
<form method="post" name="form1" target="mainFrame" class="txtblue" id="form1" action="reqAwdList.jsp" onSubmit="return disableButon()">
        <select name="year" class="t1">
			<jsp:include page="temple/year.htm" />		   
        </select>
        �~
	<select name="month" class="t1">
		<jsp:include page="temple/month.htm" />		   
	</select>	
	��
    <input name="Submit" type="submit" class="btm" value="Send" >  
    &nbsp;
	<input name="resend" type="button" disabled   onClick="document.form1.Submit.disabled=0;this.disabled=1" value="�H�e��L���"> 
	��ܱ��H�eAward List���~.��
</form>

</body>
</html>
