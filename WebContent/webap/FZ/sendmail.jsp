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

//**** �ˬd�O�_����r�A�u���\�H�e���u�� 2005/11/29
	//�h��@cal.aero��
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
if(hasWord){//���D�Ʀr,�����\�H�e
%>
  <span class="txtxred">���t�Υu���\�H�e�ӤH�����H�c<br>
���䴩�H�e�s�իH��.</span><br>
<a href="javascript:history.back(-1)" target="_self">���s�H�e</a>
<%
}else{

*/

//****** �ˬd�O�_����r,�����ܼg�Jlog 2005/11/29
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

if(hasWord || "Y".equals(officeflg)){//���D�Ʀr or �ź޿줽�ǤH��, �t�~�g�Jlog��
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

//mail address �H","�j�}
splitString s = new splitString();
String[] tostr = s.doSplit(toAddress, ",");


while(tostr[i] != null)
{	
	if(tostr[i].length() == 6){
		tostr[i] = tostr[i] + "@cal.aero";
	}
	if("Y".equals(officeflg))
	{ //�ź޿줽�ǤH��
		String tempstr = "";
		tempstr = sGetUsr.substring(0,2);
		if("EE".equals(tempstr))
		{
			from = new InternetAddress("TPEEE@email.china-airlines.com"); //�źަ@�ΫH�c
		}
		else if("EG".equals(tempstr))
		{
			from = new InternetAddress("TPEEG@email.china-airlines.com"); //�źަ@�ΫH�c
		}
		else
		{
			from = new InternetAddress("TPEEFCI@email.china-airlines.com"); //�źަ@�ΫH�c
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
	  <span class="txtxred">�y�p�ɶ��A�H���F�i��y������A<br>
	  �Э@�ߵ��ԡA�ŭ��Ƶo�e�P�˫H��!!
	  </span><br>
	</p>
	<p align="center"><a href="mail.jsp" class="cs55text">Click here to send another</a></p>
<%
} catch(Exception e) {
	out.print("�t�Φ��L���A�еy��A��!!");
}

//}	//end of toAdd check

%>


</div>
</body>
</html>
