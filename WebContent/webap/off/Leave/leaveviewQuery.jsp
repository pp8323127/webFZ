<%@page contentType="text/html; charset=big5" language="java" import="java.sql.*, java.util.Date"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
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
<form name="form1" method="post" action="viewleavesheet.jsp" onsubmit="javascript:document.getElementById('Submit3').disabled=1;">
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
</body>
</html>
