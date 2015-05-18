<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>高雄組員換班申請</title>
<script language="javascript" type="text/javascript" src="../js/showDate.js"></script>
<link rel="stylesheet" type="text/css" href="swap.css" >
<link rel="stylesheet" type="text/css" href="style/errStyle.css">
</head>

<body  >
<div align="center">
  <%
String userid = (String) session.getAttribute("userid") ; 
String unitCd = (String)session.getAttribute("Unitcd");
String powerUser = (String)session.getAttribute("powerUser"); 
String occu =  (String)session.getAttribute("occu");
String goPage = "";

swap3ackhh.ApplyCheck ac = new swap3ackhh.ApplyCheck();
ac.SelectDateAndCount();

if( ac.isLimitedDate()){//非工作日
%>
  <div class="errStyle1">系統目前不受理換班，請於<%=ac.getLimitenddate()%>後開始遞件<BR>
可能原因為：1.例假日2.緊急事故(颱風)</p>
<%

}else if( ac.isOverMax()){ //超過處理上限
%>
<p  class="errStyle1" >已超過系統單日處理上限.<br>
請於工作日17:30開始遞件.</div>
<%	
}else{

	goPage = "step1_2.jsp";
	
	response.sendRedirect(goPage);

}
	
%>
</div>
</body>
</html>