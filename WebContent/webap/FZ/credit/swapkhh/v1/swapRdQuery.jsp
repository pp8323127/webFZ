<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>查詢申請單</title>
<link href="swap.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="../js/checkBlank.js"></script>
</head>

<body>

  <form name="form1" action="swapRd.jsp" method="post" target="mainFrame" >
   <span class="s1">選擇查詢申請單年份</span>
  <select name="year" >     
    
    	  <%
  java.util.Date curDate = java.util.Calendar.getInstance().getTime();
java.text.SimpleDateFormat dateFmY = new java.text.SimpleDateFormat("yyyy");
for(int i=Integer.parseInt(dateFmY.format(curDate))-1;i<=Integer.parseInt(dateFmY.format(curDate))+1;i++){
	if(i == Integer.parseInt(dateFmY.format(curDate))){
	out.print("<option value=\""+i+"\" selected>"+i+"</option>\r\n");
	}else{
	out.print("<option value=\""+i+"\">"+i+"</option>\r\n");
	}
}	
  %>	
   </select>
 <input type="submit" name="Submit" value="Query">  </p>
  </form>
<span class="txtblue"></span>
</body>
</html>
