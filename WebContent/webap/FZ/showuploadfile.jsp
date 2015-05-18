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
  <p class="txttitletop">檔案下載/Download File</p>
  <p><a href="sample6.jsp?filename=<%=filename%>.xls"><img src="images/floder2.gif" width="31" height="27" border="0"><%=filename%>download</a></p>
  <table width="40%"  border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="txtblue"><span class="style1">*建議將檔案下載至Local PC再開啟, 因檔案較大直接開啟較費時</span><br>
	  請按<span class="style1">右鍵/另存目標</span>將檔案下載至您的電腦儲存, 注意事項如下:<br>
	  1.如檔案下載時發生錯誤, 可能為欲下載月份檔案不存在<br>
	  2.當月份檔案簽派人員將隨時更新, 建議欲換班前再下載一次選班資訊<br>
	  3.本組員選班資訊僅供參考, <span class="style1">應以實際換班當時名額為準</span></td>
    </tr>
  </table>
</div>
</body>
</html>