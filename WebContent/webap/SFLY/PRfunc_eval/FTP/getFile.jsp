<%@ page contentType="text/html; charset=big5" language="java"  %>
<%
	String filename = request.getParameter("filename");
%>
<html>
<head>
<title>File Upload</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="../../style.css" rel="stylesheet" type="text/css">
</head>
<body>
<p align="center" class="txttitletop">�ɮפW��</p>

<form name="Form1" enctype="multipart/form-data" method="post" action="doupload.jsp?filename=<%=filename%>" onsubmit="document.form1.Submit.disabled=1;"> 
<p align="center" class="txtblue">�W���ɮסG 
    <input name="File1" type="file" class="btm" size="50" maxlength="50">
  </p>
<!--<p align="center"><span class="txtblue">�ɮױԭz�G 
    <input name="File1" type="text" value="N/A" size="50" maxlength="50">
</span> </p>-->
<p align="center"> 
  <input type="submit" name = "Submit" value="�W��">&nbsp;&nbsp;&nbsp;
  <input type="reset" value="�M��"> &nbsp;&nbsp;&nbsp;
  <input type="button" name="colsebutton" value="Close" onClick="self.close()">
</p>
<p width="25%" align="center" class="txtred">
<table align="center" border="0">
<tr><td align="left" class="txtred">
*�W���ɮפj�p�H5MB����<br>
*�ɮ׫��A�Цs��JPG<br>
*�ɮצW�ٽХH�^��R�W<br>
</td>
</tr>
</table>
</form>

</body>
</html>