<%@ page contentType="text/html; charset=big5" errorPage="" %>
<%@ page language="java" %>
<%@ page import="fz.*, java.util.*, java.io.*"%>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="javax.activation.*" %>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
  %> <jsp:forward page="sendredirect.jsp" /> <%
} 
%>
<html>
<link rel="stylesheet" href="menu.css" type="text/css">
<body>

<div align="center">
  <%
String toAddress = request.getParameter("To");
String officeflg = request.getParameter("officeflg");
/*

//**** 檢查是否有文字，只允許寄送員工號 2005/11/29
	//去掉@cal.aero及
String checkAdd = ci.tool.ReplaceAllFor1_3.replace(toAddress ,"@cal.aero" ,"");
checkAdd = ci.tool.ReplaceAllFor1_3.replace(checkAdd ,"," ,"");
boolean hasWord = false;
for ( int index = 0; index < checkAdd.length(); index++) {
	char c = checkAdd.charAt(index);
	if ( c >= '0' && c <= '9' ) {		
		continue;
	} else {
		hasWord = true;
	   break;
	} 
}
if(hasWord){//有非數字,不允許寄送
%>
  <span class="txtxred">本系統只允許寄送個人全員信箱<br>
不支援寄送群組信件.</span><br>
<a href="javascript:history.back(-1)" target="_self">重新寄送</a>
<%
}else{

*/

//****** 檢查是否有文字,有的話寫入log 2005/11/29
String checkAdd = ci.tool.ReplaceAllFor1_3.replace(toAddress ,"@cal.aero" ,"");
checkAdd = ci.tool.ReplaceAllFor1_3.replace(checkAdd ,"," ,"");
checkAdd = ci.tool.ReplaceAllFor1_3.replace(checkAdd ," " ,"");
boolean hasWord = false;
for ( int index = 0; index < checkAdd.length(); index++) {
	char c = checkAdd.charAt(index);
	if ( c >= '0' && c <= '9' ) {		
		continue;
	} else {
		hasWord = true;
	   break;
	} 
}

if(hasWord || "Y".equals(officeflg)){//有非數字 or 空管辦公室人員, 另外寫入log檔
	ci.tool.WriteLog cwl = new ci.tool.WriteLog(application.getRealPath("/")+"/Log/mailLog.txt");
	cwl.WriteFileWithTime(sGetUsr+" send to "+toAddress);
	fz.writeLog wl = new fz.writeLog();
	wl.updLog(sGetUsr, request.getRemoteAddr(),request.getRemoteHost(), "FZ233");

}


Properties props = new Properties();
//props.put("mail.smtp.host", "192.168.2.4");
props.put("mail.smtp.host", "APmailrly2.china-airlines.com");

try {
Session mailSession = Session.getInstance(props,null);

MimeMessage msg = new MimeMessage(mailSession);

String subject = request.getParameter("Subject");
String message = request.getParameter("Message");
InternetAddress from = null;
InternetAddress to = null;
int i = 0;

//mail address 以","隔開
splitString s = new splitString();
String[] tostr = s.doSplit(toAddress, ",");


while(tostr[i] != null)
{	
	if(tostr[i].length() == 6){
		tostr[i] = tostr[i] + "@cal.aero";
	}
	if("Y".equals(officeflg))
	{ //空管辦公室人員
		String tempstr = "";
		tempstr = sGetUsr.substring(0,2);
		if("EE".equals(tempstr))
		{
			from = new InternetAddress("TPEEE@email.china-airlines.com"); //空管共用信箱
		}
		else if("EG".equals(tempstr))
		{
			from = new InternetAddress("TPEEG@email.china-airlines.com"); //空管共用信箱
		}
		else
		{
			from = new InternetAddress("TPEEFCI@email.china-airlines.com"); //空管共用信箱
		}
	}
	else
	{
		from = new InternetAddress(sGetUsr+"@cal.aero");
	}
	msg.setFrom(from);
	
	to = new InternetAddress(tostr[i]);
	msg.addRecipient(Message.RecipientType.TO, to);
	i++;
}	

	msg.setSubject("Mail From Crew Schedule System ["+(String)session.getAttribute("cname")+"]"+subject);
	msg.setContent(message, "text/plain; charset=big5");  // added big5
	
	Transport.send(msg);
	msg = null;
	
	fz.writeLog wl = new fz.writeLog();
	wl.updLog(sGetUsr, request.getRemoteAddr(),request.getRemoteHost(), "FZ231");

%>
	<p align="center"><span class="txttitletop">The message has been sent successfully!</span><br>
	  <span class="txtxred">尖峰時間，信件抵達可能稍有延後，<br>
	  請耐心等候，勿重複發送同樣信件!!
	  </span><br>
	</p>
	<p align="center"><a href="mail.jsp" class="cs55text">Click here to send another</a></p>
<%
} catch(Exception e) {
	out.print("系統忙碌中，請稍後再試!!");
}

//}	//end of toAdd check

%>


</div>
</body>
</html>
