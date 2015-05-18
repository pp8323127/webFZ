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
<p align="center" class="txttitletop">檔案上傳</p>

<form name="Form1" enctype="multipart/form-data" method="post" action="doupload.jsp?fdate=<%=fdate%>&fltno=<%=fltno%>&dpt=<%=dpt%>&arv=<%=arv%>&purserEmpno=<%=purserEmpno%>&acno=<%=acno%>"> 
<p align="center" class="txtblue">上傳檔案： 
    <input name="File1" type="file" class="btm" size="42"> 
  </p>
<p align="center"><span class="txtblue">檔案敘述： 
    <input name="File1" type="text" value="N/A" size="50" maxlength="50">
</span> </p>
<!--<p align="center">上傳檔案 2： <input type="file" name="File2" size="20" maxlength="20"> </p>
<p align="center">檔案2敘述： <input type="text" name="File2" size="30" maxlength="50"> </p>
<p align="center">上傳檔案3： <input type="file" name="File3" size="20" maxlength="20"> </p>
<p align="center">檔案3敘述： <input type="text" name="File3" size="30" maxlength="50"> </p>-->
<p align="center"> 
  <input type="submit" class="btm"value="上傳">&nbsp;&nbsp;&nbsp;
  <input type="reset" class="btm" value="清除"> &nbsp;&nbsp;&nbsp;
  <input type="button" name="Submit" value="Close" onClick="self.close()">
</p>
<p align="center" class="txtxred">*上傳檔案大小以5M為限</p>
</form>

</body>
</html>