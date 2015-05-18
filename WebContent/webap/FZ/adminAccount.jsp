<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>帳號管理</title>
<script type="text/javascript" language="JavaScript">
function load(w1,w2){
		/*top.topFrame.location.href=w1;
		top.mainFrame.location.href=w2;*/
		parent.topFrame.location.href=w1;
		parent.mainFrame.location.href=w2;

}
</script>
<link href="menu.css" rel="stylesheet" type="text/css">
</head>

<body>
<p><a href="#" onClick='load("accountQuery.jsp","blank.htm")'>‧查詢帳號是否存在</a></p>
<p><a href="#" onClick='load("blank.htm","addAccount.jsp")'>‧新增帳號 </a></p>
</body>
</html>
