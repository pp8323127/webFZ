<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,fz.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%

String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
/*response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);*/

if (session.isNew() || sGetUsr == null) 
{		//check user session start first
  %> <jsp:forward page="sendredirect.jsp" /> <%
} 

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Make File</title>
<link href="../menu.css" rel="stylesheet" type="text/css">

</head>

<body>
<div align="center">
  <%
//************************************Get live sche table
ctlTable ct = new ctlTable();
ct.doSet();
//*************************************

String fdate = request.getParameter("fdate");

//out.print(empnoList);
//out.print(fdate+"<BR>"+fltno);
try{
smsModify makeFile = new smsModify();
makeFile.makeSomeDayflt(fdate,sGetUsr,ct.getTable());

%>
  <span class="txttitletop">手機號碼檔案，製作成功!!</span><br>

  <span class="txtgray2">1.手機號碼檔：</span><a href="../tsa/SMS/sms.txt"><img src="../images/ed4.gif" border="0">請按右鍵另存新檔!!</a><br>
  <span class="txtgray2">2.個人化簡訊檔：</span><a href="../tsa/SMS/sms2.txt"><img src="../images/ed4.gif" border="0">請按右鍵另存新檔!!</a>

<%

}
catch(Exception e){

	out.print(e.toString());

}
%>
<br>
<br>
<span class="txtblue">發送簡訊，請至<a href="http://km.china-airlines.com/km/" target="_blank"><font color="#FF0000" style="text-decoration:underline ">華航簡訊服務網eSMS</font></a><br>
上傳此處製作的手機號碼檔案即可。</span></div>
</body>
</html>
