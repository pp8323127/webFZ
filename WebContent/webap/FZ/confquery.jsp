<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="java.sql.*, java.util.Date"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>�ӽг�d��</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" type="text/css" href="../style/errStyle.css">
<link rel="stylesheet" type="text/css" href="../style/style1.css">
<link rel="stylesheet" type="text/css" href="../style/lightColor.css">
<link rel="stylesheet" type="text/css" href="../style/kbd.css">
<script language="JavaScript" type="text/JavaScript" src="js/showDate.js"></script>

</head>

<body  onLoad="showYMD('form1','syy','smm','sdd');showYMD('form1','eyy','emm','edd');">
<form name="form1" method="post" action="conf_form.jsp" target="mainFrame">
<span class="blue" style="margin-left:0.5em; ">[���Z��d��]</span>
  <select name="conf">
    <option value="A">ALL</option>
    <option value="Y">Agree</option>
    <option value="N">Reject</option>
  </select>  
  <select name="cdate">
    <option value="C">Check</option>
    <option value="A">Apply</option>
  </select>
  <select name="syy" >
  <jsp:include page="temple/year.htm" />
  </select>
    
  <select name="smm" >
	  <jsp:include page="temple/month.htm" />
  </select>
  <select name="sdd" >
  	<jsp:include page="temple/day.htm" />
  </select>
  ~ 
  <select name="eyy" >
  <jsp:include page="temple/year.htm" />
  </select>
  <select name="emm" >
	  <jsp:include page="temple/month.htm" />
  </select>
  <select name="edd" >
  	<jsp:include page="temple/day.htm" />
  </select>
  <label class="blue" for="empno"  style="margin-left:0.5em; ">���u��</label>
<input type="text" name="empno" size="8" maxlength="6" >
  <input name="Submit" type="submit" class="kbd" value="Query" >
<span style="margin-left:0.5em; ">*�d��<span class="red">�w�B�z</span>�ӽг�</span>
</form>
</body>
</html>
