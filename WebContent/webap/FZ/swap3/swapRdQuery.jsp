<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>�]�w�d�ߥӽг椧���u��</title>
<link href="swap.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="../js/checkBlank.js"></script>
</head>

<body onLoad="document.form1.userid.focus();">

  <form name="form1" action="swapRd.jsp" method="post" target="mainFrame" >
   <span class="s1">��ܬd�ߦ~���έ��u��</span>
  <select name="year" >     
    <option value="2005">2005</option>
   </select>
   Empno:   <input type="text" name="userid" maxlength="6" size="6">
    <input type="submit" name="Submit" value="Query">
 <span class="s1">(���ժ����Ѭd�߫��w�խ����ӽг�)</span>
  </p>
  </form>
<span class="txtblue"></span>
</body>
</html>
