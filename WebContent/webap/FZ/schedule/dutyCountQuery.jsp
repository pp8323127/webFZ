<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login
String pageid = (String) request.getParameter("pageid") ;  
if (session.isNew() || userid == null) 
{		//check user session start first
	response.sendRedirect("../logout.jsp");
} 
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5" />
<link rel="stylesheet" href="../js/jQuery/jquery-ui.css">
<link rel="stylesheet" href="../style.css">
<link rel="stylesheet" href="../menu.css">
<script src="../js/jQuery/jquery.js"  type="text/javascript"></script>
<script src="../js/jQuery/jquery-ui.js"  type="text/javascript"></script>	
<script type="text/javascript">
$(document).ready(init);
function init(){
	$("#rst").click(enableHandler);
}
function clickSub(){
	var empn = $("#empn").val();
	$("#sub").attr({disabled:true});
	if(empn == ""){
		alert("請輸入員工號");
		return false;
	}else{		
		return true;
	}
}
function enableHandler(){
	$("#sub").attr({disabled:false});
}
</script>
<title>任務次數及休假統計</title>
</head>

<body bgcolor="#FFFFFF">

<form  id="form1" action="dutyCount.jsp" method="post" target="mainFrame" class="txtblue" onSubmit="return clickSub();">
<div id="divForm" class="txtblue">
(任務次數及休假統計)
Year 
  <select name="year1" >
  <%
	java.util.Date now = new java.util.Date();
	int year	=now.getYear() + 1900;
	for (int j=year-5; j<=year; j++) 
	{    
  	%>
     <option value="<%=j%>" <%if(year==j) out.println("selected='selected'");%>><%=j%></option>
    <%
	}
  %>
  </select>
  <input type="hidden" name="month1" value="01" />
  <input type="hidden" name="month2" value="12" />
Empno
<input type="hidden" id="empn" name="empn" value="<%=userid%>"/>
<input type="submit" id="sub" value="Query" class="button1" />
<input type="reset" id="rst" value="Reset" class="button1" />
<span id="error" ></span>
</div>

</form>

</body>
</html>
