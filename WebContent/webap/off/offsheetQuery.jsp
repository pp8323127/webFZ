<%@page contentType="text/html; charset=big5" language="java" import="java.sql.*, java.util.Date"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String userid = (String) session.getAttribute("userid") ; //get user id if already login
//***************************************
if (session.isNew() || userid == null) 
{		//check user session start first
	response.sendRedirect("sendredirect.jsp");
} 
%>

<html>
<head>
<title>Select Item</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="style.css" rel="stylesheet" type="text/css">
<script src="js/subWindow.js"></script>
<script LANGUAGE="JavaScript">
function f_submit()
{	
	document.form1.Submit.disabled=1;
	var t = document.form1.offtype.value;
	if(t == "a")
	{
		document.form1.action="AL/viewoffsheet.jsp";
	}
	else
	{
		document.form1.action="Leave/viewleavesheet.jsp";
	}
	return true;
}

</script>

<link href="menu.css" rel="stylesheet" type="text/css">
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
<body bgcolor="#FFFFFF" text="#000000">
<form name="form1" method="post" action = "" onsubmit = "f_submit();">
<table width="60%"  border="1" align="center" cellpadding="2" cellspacing="0" class="fortable">
  <tr class="table_body">
    <td colspan="2">
      <div align="center" class="fonte_dblue2">Enquery Off Records</div>
    </td>
  </tr>
  <tr class="table_no_border">
    <td width="28%" class="fonte_dblue2">
      <div align="center" class="fonte_black">Off Year </div>
    </td>
    <td width="72%">&nbsp;&nbsp;&nbsp;
      <select name="offyear">
        <option value="<%= yy %>" selected><%= yy %></option>
	  <%
		java.util.Date now = new java.util.Date();
		int syear	=	now.getYear() + 1900;
		for (int i=syear+1; i>=2001; i--) 
		{    
	  %>
		 <option value="<%=i%>"><%=i%></option>
	  <%
		}
	  %>
      </select>
    </td>
  </tr>
    <tr class="table_no_border">
    <td width="28%" class="fonte_dblue2">
      <div align="center" class="fonte_black">Off Type</div>
    </td>
    <td width="72%">&nbsp;&nbsp;&nbsp;
      <select name="offtype">
        <option value="a" selected>AL/XL/LVE/LSW/OL</option>
		<!--<option value="b" >SL/PL/CL/EL/FCL/HNSL/HNEL/HNCL/HNI</option>-->
		<option value="b" >SL/PL/CL/EL/FCL/HNSL/HNEL/HNCL/HNI/CNSL/CNCL</option>		
		<option value="c" >Others</option>	 
      </select>
    </td>
  </tr>
  <tr class="table_no_border">
    <td colspan = "2" align = "center">     
      <input name="Submit" type="submit" id="Submit" value="Query">
    </td>
  </tr>
</table>
</form>
<br>

<table width="60%"  border="0" align="center" cellpadding="2" cellspacing="0" class="table_no_border"> 
<tr>
  <td width="33%" valign="top" >
	<div align="center" class="font_hightlight" onClick="subwin('AL/al.htm','al')" style="text-decoration:underline;cursor:hand "><u>特休假計算標準</u></div>
  </td>
  <td width="33%" valign="top" >
	<div align="center" class="font_hightlight" onClick="subwin('AL/alpre.htm','al')" style="text-decoration:underline;cursor:hand "><u>特休假保留標準</u></div>
  </td>
    <td width="33%" valign="top" >
	<div align="center" class="font_hightlight" onClick="subwinXY('BLE93F11.htm','al','800','600')" style="text-decoration:underline;cursor:hand "><u>特休假請假規則</u></div>
  </td>

</tr>
<tr>
  <td height ="10" colspan="2">&nbsp;
  </td>
</tr>
  <tr bgcolor="#CCCCCC">
  <td height="49" colspan="3" valign="top" bgcolor="#FFFFCC" > 
	<div align="center">
	  <p class="txttitletop">Training 檔案下載</p>
	  <p><a href="../FZ/sample6.jsp?filename=training.xls"><img src="../FZ/images/floder2.gif" width="31" height="27" border="0"></a></p>
  </div>
  </td>
</tr>
</table>
</body>
</html>
