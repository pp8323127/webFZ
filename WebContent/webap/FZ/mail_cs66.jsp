<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.*,java.sql.*"%>
<%
//勾選數個組員後，可直接send mail

response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
  %> <jsp:forward page="sendredirect.jsp" /> <%
} 
String[] to = request.getParameterValues("to");

if(to == null){
%>
		<jsp:forward page="showmessage.jsp">
		<jsp:param name="messagestring" value="No receiver!!<br><a href='javascript:history.back(-1)'>back</a>" />
		</jsp:forward>
<%
}

String subject = request.getParameter("subject");
String message = request.getParameter("message");
String cname = request.getParameter("cname");

String tos=null;

for(int i=0;i<to.length;i++)	//抓多個收件者
{
	if (i==0)
	{
		tos = to[i];	//只有一個時
	}
	else
	{
		tos = tos+","+to[i];//兩個以上，用,格開
	}
}



%>
<script lanquage="javascript">
	function setMsg(){
		document.SendMessage.Message.value="<%=message%>";
	}
</script>
<html>
<head>
<title>Example on using JavaMail</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" href="menu.css" type="text/css">
</head>
<body bgcolor="#FFFFFF" onload='f_onload();setMsg();'>
<p align="center"><b><font color="#FF0000" size="4" class="txttitletop">Send Mail 
  to Crew<%
  if(cname != null){
  	out.print(": "+ cname);
  }
  else  {
  	out.println("");
  }
  
  %>
  </font></b></p>

<form name="SendMessage" Method="post" ONSUBMIT="return f_submit()" action="sendmail.jsp" >
  <table width="43%"  border="1" cellspacing="1" cellpadding="2" align="center">
    <tr> 
      <td class="tablehead">To</td>
      <td>
        <input type="text" name="To" size="50" maxlength="50" value="<%=tos%>" class="t1">
        <span class="cs55text"> </span></td>
    </tr>
    <tr> 
      <td class="tablehead">Subject</td>
      <td>
        <input type="text" name="Subject" size="50" maxlength="50" value="<%=subject%>"  class="t1">
      </td>
    </tr>
    <tr> 
      <td class="tablehead">Message</td>
      <td> <p align="center"> 
          <textarea name="Message" cols=50 rows=10  class="t1"></textarea><br>
          <input name="submit" type="submit" value="SendMail" class="btm">
          &nbsp;&nbsp; 
          <input name="reset" type="reset" value="Reset" class="btm">
          <br>
          <span class="txtblue"> 一次寄送多人時，郵件地址請用<font color="#FF0000">逗號</font><font color="#FF0000">, 
          </font>隔開。若要寄至<br>
          全員信箱，僅輸入員工號即可。系統寄送上限為二十人。</span> <br>
		 <span class="txtxred"><strong>系統寄出之信件皆有紀錄可查，請勿寄送與換班無關之信件。</strong></span>

			</p>
        </td>
    </tr>
  </table>
  <p>&nbsp; </p>
</form>
</body>
</html>
<script language=javascript>
function f_submit()
{  
	if (SendMessage.To.value == "")
	{
	 	alert("Please input mail address !");
		return false;
	}
	else if(SendMessage.Message.value =="")
	{
	 	alert("Please input Message !");
		return false;
	
	}
	else 
	{
		if(confirm("系統寄出之信件皆有紀錄可查 \n請勿寄送與換班無關之信件.\n確定要送出??"))
		return true;
		else
			return false;
	}
		//form1.submit();
}
function f_onload()
{
   document.SendMessage.To.focus();
}
</script>
