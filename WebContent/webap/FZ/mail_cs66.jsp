<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.*,java.sql.*"%>
<%
//�Ŀ�ƭӲխ���A�i����send mail

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

for(int i=0;i<to.length;i++)	//��h�Ӧ����
{
	if (i==0)
	{
		tos = to[i];	//�u���@�Ӯ�
	}
	else
	{
		tos = tos+","+to[i];//��ӥH�W�A��,��}
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
          <span class="txtblue"> �@���H�e�h�H�ɡA�l��a�}�Х�<font color="#FF0000">�r��</font><font color="#FF0000">, 
          </font>�j�}�C�Y�n�H��<br>
          �����H�c�A�ȿ�J���u���Y�i�C�t�αH�e�W�����G�Q�H�C</span> <br>
		 <span class="txtxred"><strong>�t�αH�X���H��Ҧ������i�d�A�ФűH�e�P���Z�L�����H��C</strong></span>

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
		if(confirm("�t�αH�X���H��Ҧ������i�d \n�ФűH�e�P���Z�L�����H��.\n�T�w�n�e�X??"))
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
