<%@page contentType="text/html; charset=big5" language="java" import="java.sql.*, java.util.Date"%>
<%
response.setHeader("Pragma","no-cache"); 
response.setHeader("Cache-Control","no-cache"); 
response.setDateHeader("Expires", 0); //prevents caching at the proxy server
String userid = (String) session.getAttribute("userid") ; //get user id if already login
//***************************************
if (session.isNew() || userid == null) 
{		//check user session start first
	response.sendRedirect("../login.jsp");
} 
%>

<html>
<head>
<title>Select Item</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="../style.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript" src="../js/subWindow.js">
function subwin(w,wname){	//設定開始視窗的長寬，開啟位置在螢幕中央
	wx = 700,wy=400;	
	x =(screen.width - wx) /2;
	y = (screen.height - wy) /2;
	window.open(w,wname,"left="+x+",top="+y+",width="+wx+",height="+wy);
}
</script>

<link href="../menu.css" rel="stylesheet" type="text/css">
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
<body bgcolor="#FFFFFF" text="#000000" onLoad="subwinXY('../../BLE93F11.htm','notice','750','400')">
<form name="form1" method="post" action="viewoffsheet.jsp" onsubmit="javascript:document.getElementById('Submit3').disabled=1;">
<table width="40%"  border="1" align="center" cellpadding="2" cellspacing="0" class="fortable">
  <tr class="table_body">
    <td colspan="2">
      <div align="center" class="fonte_dblue2">View Offsheet Record</div>
    </td>
  </tr>
   
  <tr class="table_no_border">
    <td width="28%">
      <div align="center" class="fonte_black">Grade Year </div>
    </td>
    <td width="72%">&nbsp;&nbsp;&nbsp;
      <select name="offyear">
        <option value="<%= yy %>" selected><%= yy %></option>
	  <%
		java.util.Date now = new java.util.Date();
		int syear	=	now.getYear() + 1900;
		for (int i=2001; i<syear+2; i++) 
		{    
	  %>
		 <option value="<%=i%>"><%=i%></option>
	  <%
		}
	  %>
      </select>
      <input name="Submit3" id="Submit3" type="submit"  value="Submit">
    </td>
  </tr>
</table>
</form>
<p>&nbsp;</p>
<form name="form2" method="post" action="alquotacount.jsp" onsubmit="javascript:document.getElementById('Submit2').disabled=1;">
<table width="40%"  border="1" align="center" cellpadding="2" cellspacing="0" class="fortable">
  <tr class="table_body9">
    <td colspan = "2">
      <div align="center" class="fonte_white">AL Quota </div>
    </td>
  </tr>
  <tr class="table_no_border">
    <td width="28%">
      <div align="center" class="fonte_black">Off Year/Month </div>
    </td>
    <td>      
        <div align="center">
		<!--
          <select name="jobitem">
            <option value="FS" selected>FS</option>
            <option value="FA">FA</option>
            <option value="PUR">PUR</option>
            <option value="TYO_CREW">TYO CREW</option>
			<option value="KOR_CREW">KOR CREW</option>
            <option value="ZC">ZONE CHIEF</option>
          </select>
		  -->
          <select name="year">
			  <%
				java.util.Date now2 = new java.util.Date();
				int year	=	now2.getYear() + 1900;
				for (int j=year; j<year+2; j++) 
				{    
			  %>
				 <option value="<%=j%>"><%=j%></option>
			  <%
				}
			  %>
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
          <input type="submit" name="Submit2" id ="Submit2" value="Submit">       
    </td>  </tr>
</table>
</form>
<br>


  <table width="40%"  border="0" align="center" cellpadding="2" cellspacing="0" class="table_no_border">
    <tr>
      <td height="49" colspan="2" valign="top" > 
        <div align="center">
          <a href="aloffsheet.jsp" class="font_hightlight"> Input AL offsheet</a> </div>
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
	  	  <p><a href="../../FZ/sample6.jsp?filename=training.xls"><img src="../../FZ/images/floder2.gif" width="31" height="27" border="0"></a></p>
	  </div>
      </td>
    </tr>
</table>
</body>
</html>
