<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="al.*"%>
<%
//response.setHeader("Cache-Control","no-cache");
//response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first
	response.sendRedirect("login.jsp");
} 
%>
<html>
<head>
<script language="JavaScript">
function getCalendar(obj){    
	eval("wincal=window.open('Calendar.htm','" + obj +"','width=350,height=200')");
}
</script>
<title>Input offsheet</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<meta http-equiv="pragma" content="no-cache">
</head>
<body bgcolor="#FFFFFF" text="#000000">
<div align="center"> 
  <%
	String cdept = null;
	String cname = null;
	String sern = null;
	String station = null;
	String lastday = null;
	String thisday = null;
	String nextday = null;
	String indate = null;
	String rs = null;
	
	//get crew basic information
	ALInfo ai = new ALInfo();
	rs = ai.setCrewInfo(sGetUsr);
	if("0".equals(rs)){
		cdept = ai.getCdept();
		cname = ai.getCname();
		sern = ai.getSern();
		indate = ai.getIndate();
		station = ai.getStation();
	}
	rs = ai.setALDays(sGetUsr);
	if("0".equals(rs)){
		lastday = ai.getLastdays();
		thisday = ai.getThisdays();
		nextday = ai.getNextdays();
	}
	
	CheckUpdateAl cual = new CheckUpdateAl();
	int cutdate = cual.getCutday(sern);
%>
  <p>&nbsp;</p>
  <p><font face="Comic Sans MS" color="#003399">Input AL offsheet </font></p>
  <table width="70%" border="0">
    <tr> 
      <td width="36%"><font face="Arial, Helvetica, sans-serif" size="2"><%=cdept%></font></td>
      <td width="31%"><font face="Arial, Helvetica, sans-serif" size="2"><%=cname%></font></td>
      <td width="33%"><font face="Arial, Helvetica, sans-serif" size="2"><b>Indate 
        / <%=indate%></b></font></td>
    </tr>
    <tr bgcolor="#CCCCCC"> 
      <td width="36%"><font face="Arial, Helvetica, sans-serif" size="2"><b>Lastdays 
        / <%=lastday%></b></font></td>
      <td width="31%"><font face="Arial, Helvetica, sans-serif" size="2"><b>Thisdays 
        / <%=thisday%></b></font></td>
      <td width="33%"><font face="Arial, Helvetica, sans-serif" size="2"><b>Nextdays 
        / <%=nextday%></b></font></td>
    </tr>
  </table>
  <form name="form1" method="post" action="<%=response.encodeURL("updal.jsp")%>" onSubmit="return f_submit();">
    <table width="70%" border="1" cellpadding="0" cellspacing="1">
      <tr> 
        <td width="26%"><font face="Arial, Helvetica, sans-serif" size="2"><b>EmplNo 
          / <%=sGetUsr%></b></font></td>
        <td width="28%"><font face="Arial, Helvetica, sans-serif" size="2"><b>SerialNo 
          / <%=sern%> 
          <input type="hidden" name="sern" value="<%=sern%>">
          </b></font></td>
        <td width="46%"><font face="Arial, Helvetica, sans-serif" size="2"><b>HomeBase 
          / <%=station%> 
          <input type="hidden" name="station" value="<%=station%>">
          </b></font></td>
      </tr>
      <tr> 
        <td width="26%"><font face="Arial, Helvetica, sans-serif" size="2"><b>OffType 
          /</b> <b><font color="#0000CC">AL </font></b></font></td>
        <td width="28%"><div align="right"><font face="Arial, Helvetica, sans-serif" size="2"><b>From</b></font></div></td>
        <td width="46%" bgcolor="#CCCCCC"> <font face="Arial, Helvetica, sans-serif" size="2">          <span onclick="getCalendar('validfrm')" style="cursor:pointer">
        <input maxlength="10" type="text" name="validfrm" class="text" size="15" onFocus="this.blur()"  style="cursor:pointer"><img src="../FZ/images/p2.gif" width="22" height="22"> </span></font></td>
      </tr>
      <tr> 
        <td width="26%"><font face="Arial, Helvetica, sans-serif" size="2"><b>TotalDays 
          / </b></font></td>
        <td width="28%"><div align="right"><font face="Arial, Helvetica, sans-serif" size="2"><b>To</b></font></div></td>
        <td width="46%" bgcolor="#CCCCCC"> <font face="Arial, Helvetica, sans-serif" size="2">          <span onclick="getCalendar('validto')" style="cursor:pointer">
          <input maxlength="10" type="text" name="validto" class="text" size="15" onFocus="this.blur()"  style="cursor:pointer"><img src="../FZ/images/p2.gif" width="22" height="22"> </span></font></td>
      </tr>
    </table>
    <p>
      <input type="submit" name="Submit" value="Send">
      <input type="reset" name="Submit2" value="Reset">
    </p>
  </form>
  <p align="center">
  <font size="2" face="Arial, Helvetica, sans-serif" color="#FF0000"><b><font size="3">*</font>未扣除特休假總天數:<%=cutdate%>
  <p align="center"><font face="Comic Sans MS" size="2"><A HREF='selectpage.jsp'><strong>Select Page</strong></A></font>
  </p></b></font>
  <p align="right"><img src="logo2.gif" width="165" height="35"></p>

</div>
</body>
<script language=javascript>
function f_submit()
{  
	document.form1.Submit.disabled=1;
	if(document.form1.validfrm.value == "" || document.form1.validto.value == ""){
		alert("Please select the From date and To date !!");
		document.form1.Submit.disabled=0;
		return false;
	}
	else{
		return confirm("Update offsheet ?");
	}
}
</script>
</html>