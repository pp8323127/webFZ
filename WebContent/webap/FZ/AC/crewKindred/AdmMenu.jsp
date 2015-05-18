<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>家屬電話轉檔維護</title>
<link rel="stylesheet" type="text/css" href="../../../style/style1.css">
<link rel="stylesheet" type="text/css" href="../../lightColor.css">
<link rel="stylesheet" type="text/css" href="../../../style/kbd.css">
<style type="text/css">
li{list-style-type:none;}.l{margin-left:0.5em;} .r{margin-right:0.5em;} a{text-decoration:underline;}
</style>
</head>

<body>
<fieldset style="width:500pt; ">
<legend><img src="../../images/phone_sound.gif" width="16" height="16" class="r">組員家屬聯絡電話 資料轉檔/維護</legend>


<ul>
<li><a href="exptQuery.jsp" class="bold"><img src="../../images/database_save.gif" width="16" height="16" align="top" class="r">資料匯入<img src="../../images/bullet_go.gif" width="16" height="16" align="top" class="l"></a>
	<ul>
		<li>顯示未更新紀錄</li>
		<li> 執行轉入動作</li>
	    </ul>
</li>

<li><a href="historyQuery.jsp"  class="bold" target="mainFrame"><img src="../../images/format-justify-fill.png" width="16" height="16" align="top"  class="r">查詢歷史紀錄<img src="../../images/bullet_go.gif" width="16" height="16" align="top" class="l"></a>
	<ul>
	<li>以年/月或員工號查詢</li>
	<li>僅顯示已更新轉檔之資料,尚未轉入之資料請使用「資料匯入」功能察看.</li>
	</ul>
</li>
</ul>
</fieldset>
</body>
</html>
