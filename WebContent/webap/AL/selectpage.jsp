<%@page contentType="text/html; charset=big5" language="java" import="java.sql.*, java.util.Date"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first
	response.sendRedirect("login.jsp");
} 
%>

<html>
<head>
<title>Select Item</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="style.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript" src="../FZ/js/subWindow.js">
function subwin(w,wname){	//設定開始視窗的長寬，開啟位置在螢幕中央
	wx = 700,wy=400;	
	x =(screen.width - wx) /2;
	y = (screen.height - wy) /2;
	window.open(w,wname,"left="+x+",top="+y+",width="+wx+",height="+wy);
}
</script>

<link href="../FZ/menu.css" rel="stylesheet" type="text/css">
</head>
<%
	Date mydate = new Date();
	int yy = mydate.getYear() + 1900;
	int mm = mydate.getMonth() + 1;
	String mymm = Integer.toString(mm);
	if (mymm.length() == 1)
	{
		mymm = "0" + mymm;
	}
	else if (mm >= 11)
	{
		yy++;
	}
%>
<body bgcolor="#FFFFFF" text="#000000" onLoad="subwinXY('../BLE93F11.htm','notice','750','400')">
<form name="form1" method="post" action="viewoffsheet.jsp">
<table width="40%"  border="1" align="center" cellpadding="2" cellspacing="0" class="fortable">
  <tr class="table_body">
    <td colspan="2">
      <div align="center" class="fonte_dblue2">View Offsheet list</div>
    </td>
  </tr>
   
  <tr class="table_no_border">
    <td width="28%">
      <div align="center" class="fonte_black">Grade Year </div>
    </td>
    <td width="72%">&nbsp;&nbsp;&nbsp;
      <select name="offyear">
        <option value="<%= yy %>" selected><%= yy %></option>
        <option value="2001">2001</option>
        <option value="2002">2002</option>
        <option value="2003">2003</option>
        <option value="2004">2004</option>
        <option value="2005">2005</option>
        <option value="2006">2006</option>
		<option value="2007">2007</option>
		<option value="2008">2008</option>
		<option value="2009">2009</option>
      </select>
      <input name="Submit3" type="submit"  value="Submit">
	  <input type="hidden" name="empn" value="<%=sGetUsr%>">
    </td>
  </tr>
</table>
</form>
<p>&nbsp;</p>
<form name="form2" method="post" action="alquotacount.jsp">
<table width="40%"  border="1" align="center" cellpadding="2" cellspacing="0" class="fortable">
  <tr class="table_body9">
    <td >
      <div align="center" class="fonte_white">AL Quota </div>
    </td>
  </tr>
  <tr class="table_no_border">
    <td>      
        <div align="center">
          <select name="jobitem">
            <option value="FS" selected>FS</option>
            <option value="FA">FA</option>
            <option value="PUR">PUR</option>
            <option value="TYO_CREW">TYO_CREW</option>
			<option value="KOR_CREW">KOR_CREW</option>
            <option value="ZC">ZONE CHIEF</option>
          </select>
          <select name="year">
            <option value="<%= yy %>" selected><%= yy %></option>
            <option value="2006">2006</option>
			<option value="2007">2007</option>
			<option value="2008">2008</option>
			<option value="2009">2009</option>
          </select>
          <select name="month">
            <option value="<%= mymm %>" selected><%= mymm %></option>
            <option value="01"><font face="Arial, Helvetica, sans-serif" size="2">01</font></option>
            <option value="02"><font face="Arial, Helvetica, sans-serif" size="2">02</font></option>
            <option value="03"><font face="Arial, Helvetica, sans-serif" size="2">03</font></option>
            <option value="04"><font face="Arial, Helvetica, sans-serif" size="2">04</font></option>
            <option value="05"><font face="Arial, Helvetica, sans-serif" size="2">05</font></option>
            <option value="06"><font face="Arial, Helvetica, sans-serif" size="2">06</font></option>
            <option value="07"><font face="Arial, Helvetica, sans-serif" size="2">07</font></option>
            <option value="08"><font face="Arial, Helvetica, sans-serif" size="2">08</font></option>
            <option value="09"><font face="Arial, Helvetica, sans-serif" size="2">09</font></option>
            <option value="10"><font face="Arial, Helvetica, sans-serif" size="2">10</font></option>
            <option value="11"><font face="Arial, Helvetica, sans-serif" size="2">11</font></option>
            <option value="12"><font face="Arial, Helvetica, sans-serif" size="2">12</font></option>
          </select>
          <input type="submit" name="Submit2" value="Submit">       
    </td>  </tr>
</table>
</form>
<br>


  <table width="40%"  border="0" align="center" cellpadding="2" cellspacing="0" class="table_no_border">
    <tr>
      <td height="49" colspan="2" valign="top" > 
        <div align="center">
          <a href="inputal.jsp" class="font_hightlight">          Input AL offsheet</a> </div>
      </td>
    </tr>
	<tr>
      <td width="50%" valign="top" >
        <div align="center" class="font_hightlight" onClick="subwin('al.htm','al')" style="text-decoration:underline;cursor:hand "><u>特休假計算標準</u></div>
      </td>
      <td width="50%" valign="top" >
        <div align="center" class="font_hightlight" onClick="subwin('alpre.htm','al')" style="text-decoration:underline;cursor:hand "><u>特休假保留標準</u></div>
      </td>
    </tr>
	<tr bgcolor="#CCCCCC">
      <td height="49" colspan="2" valign="top" > 
        <div align="center">
          <p class="txttitletop">Trainging 檔案下載 <span class="txtxred">New</span></p>
	  	  <p><a href="../FZ/sample6.jsp?filename=training.xls"><img src="../FZ/images/floder2.gif" width="31" height="27" border="0"></a></p>
	  </div>
      </td>
    </tr>
</table>


<div align="left">  </div>
  <table width="17%"  border="0" align="right" cellpadding="2" cellspacing="0" class="table_no_border">
    <tr>
      <td valign="top" >        
        <div align="center">
          <input name="logout" type="button" class="button_y2" onClick='self.location.href="sendredirect.jsp"' value="Logout">
        </div>
      </td>
    </tr>
    <tr>
      <td valign="top" >
        <div align="right"><img src="logo2.gif" width="165" height="35"></div>
      </td>
    </tr>
  </table>
  <p align="right">&nbsp;</p>
</body>
</html>
