<%@ page contentType="text/html; charset=big5" language="java"  %>
<%
	String fdate = request.getParameter("fdate");
	String fltno = request.getParameter("fltno");
	String dpt = request.getParameter("dpt");
	String arv = request.getParameter("arv");
	String acno = request.getParameter("acno");
	String purserEmpno = request.getParameter("purserEmpno");
%>
<html>
<head>
<title>File Upload</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="../../menu.css" rel="stylesheet" type="text/css">
</head>
<body>
<p align="center" class="txttitletop">�ɮפW��</p>

<form name="Form1" enctype="multipart/form-data" method="post" action="doupload.jsp?fdate=<%=fdate%>&fltno=<%=fltno%>&dpt=<%=dpt%>&arv=<%=arv%>&purserEmpno=<%=purserEmpno%>&acno=<%=acno%>"> 
<p align="center" class="txtblue">�W���ɮסG 
    <input name="File1" type="file" class="btm" size="42"> 
  </p>
<p align="center"><span class="txtblue">�ɮױԭz�G 
    <input name="File1" type="text" value="N/A" size="50" maxlength="50">
</span> </p>
<!--<p align="center">�W���ɮ� 2�G <input type="file" name="File2" size="20" maxlength="20"> </p>
<p align="center">�ɮ�2�ԭz�G <input type="text" name="File2" size="30" maxlength="50"> </p>
<p align="center">�W���ɮ�3�G <input type="file" name="File3" size="20" maxlength="20"> </p>
<p align="center">�ɮ�3�ԭz�G <input type="text" name="File3" size="30" maxlength="50"> </p>-->
<p align="center"> 
  <input type="submit" class="btm"value="�W��">&nbsp;&nbsp;&nbsp;
  <input type="reset" class="btm" value="�M��"> &nbsp;&nbsp;&nbsp;
  <input type="button" name="Submit" value="Close" onClick="self.close()">
</p>
<p align="center" class="txtxred">*�W���ɮפj�p�H5M����</p>
</form>

</body>
</html>