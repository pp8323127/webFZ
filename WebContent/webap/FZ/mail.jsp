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
          <p align="left" class="bu">  尖峰時間，信件抵達可能稍有延後，<br>
  請耐心等候，勿重複發送同樣信件!! </p>		  
          <span class="txtblue"> 一次寄送多人時，郵件地址請用<font color="#FF0000">逗號</font><font color="#FF0000">, 
          </font>隔開。若要寄至<br>
        全員信箱，僅輸入員工號即可。系統寄送上限為二十人。</span> <br>
          <span class="txtxred"><strong>系統寄出之信件皆有紀錄可查，請勿寄送與換班無關之信件。</strong></span>
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
	receiver = receiver.replace(/\,/g,"");//去掉,
	receiver = ReplaceAll(receiver,"@cal.aero","");//去掉@cal.aero
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
		if(confirm("寄送email至群組帳號,係供公務使用.\n本系統將會詳細記錄寄信人、時間及內容,以供管理之用.\n確定要送出??")){
				document.SendMessage.submit.disabled=1;
			return true;
			
		}else{
			return false;
		}
	}
	else 
	{
		if(confirm("系統寄出之信件皆有紀錄可查 \n請勿寄送與換班無關之信件.\n確定要送出??")){
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
