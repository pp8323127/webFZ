<%@ page contentType="text/html; charset=big5" language="java"  %>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null)
{           //check user session start first or not login
%>
<jsp:forward page="sendredirect.jsp" />
<%
}


%>
<html>
<head>
<title>Upload File</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="style.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style1 {color: #FF0000}
-->
</style>
</head>

<body>
<div align="center">
 <p class="txttitletop">Cabin Safety Check List Excel Report<br>
 �ɮפU�� / Download File</p>
 <p><span class="txtblue">STEP1.</span><span class="txtred">Please query the report by select the period of time first. </span></p>
 <p><span class="txtblue">STEP2.</span><span class="txtred">Please select the item and export basis you want to export. </span></p>
 <p><span class="txtblue">STEP3.</span><span class="txtred">Please download the EXCEL report file in you local PC.</span></p>
 <p>&nbsp;</p>
 <p>&nbsp;</p>
 </p>
 </p>
 <table width="50%"  border="0" cellspacing="0" cellpadding="0">
   <tr>
     <td class="txtblue"><div align="center"><span class="style1">*��ĳ�N�ɮפU����Local PC�A�}��, �]�ɮ׸��j�����}�Ҹ��O��</span><br>
       �Ы�<span class="style1">�k��/�t�s�ؼ�</span>�N�ɮפU���ܱz���q���x�s.</div></td>
   </tr>
 </table>
</div>
</body>
</html>
