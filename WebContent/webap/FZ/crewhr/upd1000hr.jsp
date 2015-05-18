<%@ page contentType="text/html; charset=big5" language="java" import="crewhr.updHrCheck"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first
	response.sendRedirect("../sendredirect.jsp");
}
%>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Update 1000hr</title>
<link href="../menu.css" rel="stylesheet" type="text/css">
</head>
<body>
<div align="center">
<p>&nbsp;  </p>
<p>&nbsp;</p>
<p>
<%
String[] empno = request.getParameterValues("empno");
String[] blkhr = request.getParameterValues("blkhr");
String[] nmmhr = request.getParameterValues("nmmhr");
/*out.print(empno.length+" "+blkhr.length+" "+nmmhr.length+"<br>");
for(int i = 0;i<empno.length;i++){
  out.print(empno[i]+" "+blkhr[i]+" "+nmmhr[i]+"<br>");
}*/


String yy = request.getParameter("yy");
String mm = request.getParameter("mm");

String ck = null;

updHrCheck uhc = new updHrCheck();

try{
	//update ORP3 / dftcrec
	ck = uhc.doUpdate(empno, blkhr, nmmhr, yy, mm);
	if("0".equals(ck)){
		out.println("<p class='txttitletop'>資料存檔成功 !</p>");
	}
	else{
		out.println("<p class='txttitletop'>資料存檔失敗 : "+ck+"</p>");
	}
}
catch(Exception e){
	out.println("<p class='txttitletop'>資料存檔失敗 : "+e.toString()+"</p>");
}

%>
</p>
</div>
</body>
</html>