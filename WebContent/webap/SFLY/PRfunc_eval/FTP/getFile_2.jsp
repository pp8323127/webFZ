<%@ page contentType="text/html; charset=big5" language="java"  %>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("../logout.jsp");
}

String sernno = request.getParameter("sernno");
String type = request.getParameter("type");
String seq = request.getParameter("seq");
String itemno = request.getParameter("itemno");

String fdate = request.getParameter("fdate");
String fltno = request.getParameter("fltno");
String trip = request.getParameter("trip");

%>
<html>
<head>
<title>File Upload</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="../../style.css" rel="stylesheet" type="text/css">
</head>
<body>
<p align="center" class="txttitletop">檔案上傳</p>

<form name="Form1" enctype="multipart/form-data" method="post" action="doupload_2.jsp?sernno=<%=sernno%>&type=<%=type%>&seq=<%=seq%>&itemno=<%=itemno%>&fdate=<%=fdate%>&fltno=<%=fltno%>&trip=<%=trip%>" onsubmit="document.form1.Submit.disabled=1;"> 
<p align="center" class="txtblue">上傳檔案： 
    <input name="File1" type="file" class="btm" size="50" maxlength="50">
  </p>
<!--<p align="center"><span class="txtblue">檔案敘述： 
    <input name="File1" type="text" value="N/A" size="50" maxlength="50">
</span> </p>-->
<p align="center"> 
  <input type="submit" name = "Submit" value="上傳">&nbsp;&nbsp;&nbsp;
  <input type="reset" value="清除"> &nbsp;&nbsp;&nbsp;
  <input type="button" name="colsebutton" value="Close" onClick="self.close()">
</p>
<p width="25%" align="center" class="txtred">
<table align="center" border="0">
<tr><td align="left" class="txtred">
*上傳檔案大小以5MB為限<br>
*檔案型態請存為JPG<br>
*檔案名稱請以英文命名<br>
</td>
</tr>
</table>
</form>

</body>
</html>