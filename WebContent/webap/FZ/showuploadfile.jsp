<%@ page contentType="text/html; charset=big5" language="java"  %>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
 %>
 <jsp:forward page="sendredirect.jsp" /> 
<%
} 

String yy = request.getParameter("syear");
String mm = request.getParameter("smonth");
String filename = "";
if(mm.equals("01"))
{
	filename = "jan"+yy;
}
else if(mm.equals("02"))
{
	filename = "feb"+yy;
}
else if(mm.equals("03"))
{
	filename = "mar"+yy;
}
else if(mm.equals("04"))
{
	filename = "apr"+yy;
}
else if(mm.equals("05"))
{
	filename = "may"+yy;
}
else if(mm.equals("06"))
{
	filename = "jun"+yy;
}
else if(mm.equals("07"))
{
	filename = "jul"+yy;
}
else if(mm.equals("08"))
{
	filename = "aug"+yy;
}
else if(mm.equals("09"))
{
	filename = "sep"+yy;
}
else if(mm.equals("10"))
{
	filename = "oct"+yy;
}
else if(mm.equals("11"))
{
	filename = "nov"+yy;
}
else if(mm.equals("12"))
{
	filename = "dec"+yy;
}
%>
<html>
<head>
<title>Upload File</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="menu.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style1 {color: #FF0000}
-->
</style>
</head>

<body>
<div align="center">
  <p class="txttitletop">�ɮפU��/Download File</p>
  <p><a href="sample6.jsp?filename=<%=filename%>.xls"><img src="images/floder2.gif" width="31" height="27" border="0"><%=filename%>download</a></p>
  <table width="40%"  border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="txtblue"><span class="style1">*��ĳ�N�ɮפU����Local PC�A�}��, �]�ɮ׸��j�����}�Ҹ��O��</span><br>
	  �Ы�<span class="style1">�k��/�t�s�ؼ�</span>�N�ɮפU���ܱz���q���x�s, �`�N�ƶ��p�U:<br>
	  1.�p�ɮפU���ɵo�Ϳ��~, �i�ର���U������ɮפ��s�b<br>
	  2.�����ɮ�ñ���H���N�H�ɧ�s, ��ĳ�����Z�e�A�U���@����Z��T<br>
	  3.���խ���Z��T�ȨѰѦ�, <span class="style1">���H��ڴ��Z��ɦW�B����</span></td>
    </tr>
  </table>
</div>
</body>
</html>