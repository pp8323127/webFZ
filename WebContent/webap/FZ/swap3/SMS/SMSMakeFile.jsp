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
String fdate = request.getParameter("fdate");
String fltno = null;
if(request.getParameter("fltno") != null){
	fltno = request.getParameter("fltno");
}
else{
	fltno = null;
}
String db = request.getParameter("db");
String empnoList = null;
if( request.getParameter("empnoList").trim() != null){
	 empnoList = request.getParameter("empnoList").trim();
}
else{
	empnoList = null;
}
//out.print(empnoList);
//out.print(fdate+"<BR>"+fltno);
try{
smsModify makeFile = new smsModify();

if(fltno == null && empnoList==null){
//out.print("yes");
	makeFile.makeSomeDayflt(fdate,sGetUsr,db);
}
else{
//	makeFile.makeSingleFlt(fdate, fltno,sGetUsr,db);
	makeFile.makeFlt(fdate,fltno,empnoList,sGetUsr);
	//String fdate,String fltno,String empnoList,String user,String db
}

%>
  <span class="txttitletop">������X�ɮסA�s�@���\!!</span><br>

  <span class="txtgray2">1.������X�ɡG</span><a href="../tsa/SMS/sms.txt"><img src="../images/ed4.gif" border="0">�Ы��k��t�s�s��!!</a><br>
  <span class="txtgray2">2.�ӤH��²�T�ɡG</span><a href="../tsa/SMS/sms2.txt"><img src="../images/ed4.gif" border="0">�Ы��k��t�s�s��!!</a>
<%

}
catch(Exception e){

	out.print(e.toString());

}
%>
<br>
<br>
<span class="txtblue">�o�e²�T�A�Ц�<a href="http://km.china-airlines.com/km/" target="_blank"><font color="#FF0000" style="text-decoration:underline ">�د�²�T�A�Ⱥ�eSMS</font></a><br>
�W�Ǧ��B�s�@��������X�ɮקY�i�C</span></div>
</body>
</html>