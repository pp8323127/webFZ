<%@page language="java" contentType="text/html; charset=big5"  %>
<%@page import="fz.*,java.sql.*"%>
<%

response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
//request.setCharacterEncoding("big5");  
//response.setCharacterEncoding("Big5");
String uid = request.getParameter("uid");
String officeflg = null; //add by cs55 2006/02/09

if(uid == null){
	String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
	officeflg = "N";
	if (session.isNew() || sGetUsr == null) 
	{		//check user session start first or not login
	  %> <jsp:forward page="sendredirect.jsp" /> <%
	} 
}
else{
	session.setAttribute("userid", uid);
	officeflg = "Y";
}
String to = request.getParameter("to");
String subject = request.getParameter("subject");
String message = request.getParameter("message");
//out.print(subject+"<br>");
//out.print(message);
//out.print(message.getBytes());
/*
byte[] b = message.getBytes();
for(int i=0; i<b.length; i++)
{
	out.print(b[i]);
}
*/
//message = java.net.URLEncoder.encode(message,"big5");
//message = java.net.URLDecoder.decode((String) request.getParameter("message"),"big5");

//String message = new String(request.getParameter("message").getBytes("ISO-8859-1"),"big5");
//String message = new String(request.getParameter("message").getBytes("UTF-8"),"big5");
//String message = new String(request.getParameter("message").getBytes("GBK"),"big5");
//String message = new String(request.getParameter("message").getBytes("big5"),"big5");
//String message = new String(request.getParameter("message").getBytes(),"big5");

String cname = request.getParameter("cname");

//Betty adds on 2008/04/18*********************************
if("Y".equals(officeflg))
{
	 fzac.CrewInfo c = new fzac.CrewInfo(to.substring(0,6));
	 fzac.CrewInfoObj o = c.getCrewInfo();
	 c.isHasData();
	 if (c.isHasData()) 
	 {
		cname = o.getCname();
	 }
}
//Betty adds on 2008/04/18*********************************
%>
<script lanquage="javascript"  >
	function setMsg(){
		document.SendMessage.Message.value="<%=message%>";
	}
</script>
<html>
<head>
<title>Mail to Crew</title>
<meta http-equiv="Content-Type" content="text/html; charset=Big5">
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
        <input type="text" name="To" size="50" maxlength="50" value="<%=to%>" class="t1">
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
          <input name="officeflg" type="hidden" value="<%=officeflg%>">        
          <p align="left" class="bu">  �y�p�ɶ��A�H���F�i��y������A<br>
  �Э@�ߵ��ԡA�ŭ��Ƶo�e�P�˫H��!! </p>		  
          <span class="txtblue"> �@���H�e�h�H�ɡA�l��a�}�Х�<font color="#FF0000">�r��</font><font color="#FF0000">, 
          </font>�j�}�C�Y�n�H��<br>
        �����H�c�A�ȿ�J���u���Y�i�C�t�αH�e�W�����G�Q�H�C</span> <br>
          <span class="txtxred"><strong>�t�αH�X���H��Ҧ������i�d�A�ФűH�e�P���Z�L�����H��C</strong></span>
</td>
    </tr>
  </table>
  <p>&nbsp; </p>
</form>
</body>
</html>
<script language=javascript>
function ReplaceAll(strOrg,strFind,strReplace){
	var index = 0;
	while(strOrg.indexOf(strFind,index) != -1){
	strOrg = strOrg.replace(strFind,strReplace);
	index = strOrg.indexOf(strFind,index);
	}
	return strOrg
}
function f_submit(){  
	var receiver = document.SendMessage.To.value;
	var hasWord = false;
	receiver = receiver.replace(/\,/g,"");//�h��,
	receiver = ReplaceAll(receiver,"@cal.aero","");//�h��@cal.aero
	for(var idx = 0;idx <receiver.length;idx++){
		var c = receiver.charAt(idx);
		if ( c >= '0' && c <= '9' ) {		
			continue;
		} else {
		   hasWord = true;
		   break;
		} 
	}
	
	if (document.SendMessage.To.value == "")
	{
	 	alert("Please input mail address !");
		return false;
	}
	else if(document.SendMessage.Message.value =="")
	{
	 	alert("Please input Message !");
		return false;
	
	}
	
	 if(hasWord == true){
		if(confirm("�H�eemail�ܸs�ձb��,�Y�Ѥ��Ȩϥ�.\n���t�αN�|�ԲӰO���H�H�H�B�ɶ��Τ��e,�H�Ѻ޲z����.\n�T�w�n�e�X??")){
				document.SendMessage.submit.disabled=1;
			return true;
			
		}else{
			return false;
		}
	}
	else 
	{
		if(confirm("�t�αH�X���H��Ҧ������i�d \n�ФűH�e�P���Z�L�����H��.\n�T�w�n�e�X??")){
			document.SendMessage.submit.disabled=1;
			return true;
		}else{
			return false;
		}
	}
		//form1.submit();
}
function f_onload()
{
   document.SendMessage.To.focus();
}
</script>
