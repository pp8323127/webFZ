<%@ page contentType="text/html; charset=big5" language="java"  %>
<%
String userid = (String) session.getAttribute("cs55.usr") ; //get user id if already login
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);

if (session.isNew() | userid == null ) 
{		//check user session start first
  %> <jsp:forward page="sendredirect.jsp" /> <%
} 

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>�L���D���</title>
<style type="text/css">
body{font-family:"Courier New";
font-size:10pt;}
</style>
<script language="javascript" type="text/javascript" src="../js/checkBlank.js"></script>
<script language="javascript" type="text/javascript" src="../js/changeAction.js"></script>
<script language="javascript" type="text/javascript">
	function checkEmpno(){
		var e = document.form1.empno.value;
		if(e.length != 6){
			alert ("�п�J���T�����u��.");
			document.form1.empno.focus();
			return false;
		}else{
			return checkBlank('form1','empno','�п�J���u��');
		}
	}
	function checkForQuery(){
		var e = document.form1.empno.value;
		if(e.length != 6){
			alert ("�п�J���T�����u��.");
			document.form1.empno.focus();
			return false;
		}else{
			preview('form1','crewRdInsData.jsp');
			return true;
		}
	}
	

</script>
</head>

<body onLoad="document.form1.empno.focus()">
<form action="crewRdIns.jsp" method="post" name="form1" onsubmit="return checkEmpno()">
<p style="color:#0000FF ">�i���q�eCrew Record </p>
<p>���u���G
  <input type="text" maxlength="6" size="6" name="empno">
  &nbsp;</p>
<p>&nbsp;
    <input type="submit" value="�s�W">&nbsp;&nbsp;<!-- <input type="button" value="�d��" onClick="return checkForQuery()"> -->
</p>
</form>
</body>
</html>
