<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page  import="java.sql.*,ci.db.*,df.flypay.*,ci.tool.*"%>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if ( sGetUsr == null | session.isNew()) 
{		//check user session start first or not login
 response.sendRedirect("sendredirect.jsp");
}

String yyyy = request.getParameter("yyyy");
String mm = request.getParameter("mm");



%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>寄送定額飛加</title>
<link href="menu.css" rel="stylesheet" type="text/css">
</head>
<%



FixPay fp = new FixPay(yyyy,mm,sGetUsr);
//FixPay fp =  new FixPay(yyyy,mm,"640073");
WriteLog wl = new WriteLog(application.getRealPath("/")+"/Log/reqFixedPayLog.txt");
try {

fp.GetFixPay();

if(fp.allData.size() != 0){//有資料才發送

DeliverMail dm = new DeliverMail();


	ArrayList al = fp.allData;

	
	for (int index = 0; index < al.size(); index++) {
	
		FixPayObj obj = (FixPayObj) al.get(index);
	
	//				寄送mail 				
		dm.Deliver(fp.getTitle(), sGetUsr, obj.toString());
	//			寫入Log
		
		wl.WriteFileWithTime(sGetUsr+"\t"+obj.getCname()+"\trequest "+yyyy+mm);		

	}
fz.writeLog fzwl = new fz.writeLog();
fzwl.updLog(sGetUsr, request.getRemoteAddr(),request.getRemoteHost(), "FZ349");
%>



<script lanquag="JAVASCRIPT">
	alert("檔案已寄出至您的全員信箱");
</script>
<body>
<p align="center" class="txtxred" >定額飛加清單已寄至您的全員信箱!!</p>
<p align="center" class="txtblue" ><a href="https://mail.cal.aero" >開啟全員信箱 Open cal.aero mail-box</a> </p>
<p align="center" ><a href="reqFixpayQuery.htm" target="topFrame" ><span class="txtxred"><u>寄送其他月份</u></span></a> </p>
<%
}else{
%>
<body>
<p align="center" class="txtxred" ><%=yyyy+"/"+mm%>無定額飛加資料</p>
<%	
}
} catch (Exception e) {
	wl.WriteFileWithTime(e.toString());
}



%>
</body>
</html>
