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
 檔案下載 / Download File</p>
 <p><span class="txtblue">STEP1.</span><span class="txtred">Please query the report by select the period of time first. </span></p>
 <p><span class="txtblue">STEP2.</span><span class="txtred">Please select the item and export basis you want to export. </span></p>
 <p><span class="txtblue">STEP3.</span><span class="txtred">Please download the EXCEL report file in you local PC.</span></p>
 <p>&nbsp;</p>
 <p>&nbsp;</p>
 </p>
 </p>
 <table width="50%"  border="0" cellspacing="0" cellpadding="0">
   <tr>
     <td class="txtblue"><div align="center"><span class="style1">*建議將檔案下載至Local PC再開啟, 因檔案較大直接開啟較費時</span><br>
       請按<span class="style1">右鍵/另存目標</span>將檔案下載至您的電腦儲存.</div></td>
   </tr>
 </table>
</div>
</body>
</html>
