<%@ page contentType="text/html; charset=big5" language="java" 
    import = "ci.db.*,java.util.*,fz.UnicodeStringParser"%>

<html>
<head>
<title>File Upload</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="crewcar.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style1 {color: #0000FF}
-->
</style>
<script language="JavaScript" type="text/JavaScript">
 function chkBlk()
 {
	if (form1.File1.value ==""){		//若未輸入查詢條件
		alert("請選擇上傳檔案！！\nPlease select uploaded file");
		location.reload();		
		return false;
		
	}
	else{
		//location.reload();		
		return true;
	}
}
</script>
</head>
<body>
<p align="center" class="style1"><b>檔案上傳</b></p>

<form name="form1" enctype="multipart/form-data" method="post" action="updFile.jsp" onSubmit="return chkBlk()" > 
<table align="center">
<tr>
<td><p align="center" class="style1"><b>上傳檔案：</b></p></td>
<td><input name="File1" class="btm" type="file" size="42"></td> 
</tr>
<!--
<tr>
<td><p align="center" class="style1"><b>檔案敘述：</b></p></td> 
<td><input name="File1" type="text" size="50" maxlength="50"></td>
</tr>
-->
</table>
<p align="center"> 
  <input type="submit" class="btm" value="上傳"> 
  <input type="reset" class="btm" value="清除"> </p>
</form>
</body>
</html>