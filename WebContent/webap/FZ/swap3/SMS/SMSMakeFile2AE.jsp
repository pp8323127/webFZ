<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="java.sql.*,fz.*,fz.esms.*,ci.tool.*,java.util.*,java.text.SimpleDateFormat"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
//�s�@������X�ɮ�--> ��@�ҵ{

String userid = (String) session.getAttribute("userid") ; //get user id if already login
/*response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);*/

if (session.isNew() || userid == null) 
{		//check user session start first
  %> <jsp:forward page="sendredirect.jsp" /> <%
} 


ArrayList crewList = (ArrayList)session.getAttribute("crewList");
String classType = request.getParameter("classType");
String requestFdate = request.getParameter("requestFdate");

for(int i=0;i<crewList.size();i++){//���h��������X�D10��ƼƦr��
	CrewListObj obj = (CrewListObj)crewList.get(i);
	String smsphone = obj.getSmsPhone();
	char cc = '0';
	int count=0;
	for (int j = 0; j < smsphone.length(); j++) { //�P�_�O�_�Q��ƼƦr
		cc = smsphone.charAt(j);
		if ("0123456789".indexOf(cc) >= 0) {
			count++;
		}
	}
	if(count != 10){
		crewList.remove(i);
	}

}

StringBuffer phoneList1 = new StringBuffer();
StringBuffer phoneList2 = new StringBuffer();
StringBuffer logFile = new StringBuffer();

GregorianCalendar currentDate = new GregorianCalendar();
java.util.Date curDate = (java.util.Date) currentDate.getTime();
String nowDate = new SimpleDateFormat("yyyy/MM/dd HH:mm", Locale.UK)
		.format(curDate) ;
		
logFile.append("******************************************************");
logFile.append("\r\nWrite file at: " + nowDate+ "\t by " + userid + "\r\n");
logFile.append("Date\t\tFltno\tEmpno\tPhone\r\n");

/*
fwLog
					.write("******************************************************");
			fwLog.write("\r\nWrite file at: " + nowDate + "\t by " + user
				+ "\r\n");
			fwLog.write("Date\t\tFltno\tEmpno\tPhone\r\n");
*/			
			
for(int i=0;i<crewList.size();i++){
	CrewListObj obj = (CrewListObj)crewList.get(i);
	phoneList1.append(obj.getSmsPhone()+"\r\n");
	phoneList2.append(obj.getSmsPhone()+","+obj.getCrewName()+","+classType+"\r\n");
	logFile.append(requestFdate+"\t"+classType+"\t"+obj.getEmpno()
							+"\t"+obj.getSmsPhone()+ "\r\n");
	
/*		fwLog.write(Showfdate + "\t" + dutycode + "\t" + empno
							+ "\t" + smsphone + "\r\n");	
	fw.write(smsphone + "\r\n");
	fw2.write(smsphone + "," + cname + "," + fltno+ "\r\n");
*/	
}				

//TODO  �g�Jlog ��
FileWriter fw = null;

//�¸��X��
try {
	fw = new FileWriter("/apsource/csap/projfz/webap/FZ/tsa/SMS/sms.txt", false);
	fw.write(phoneList1.toString());


} catch (IOException e) {
	out.println(e.toString());
} finally {
	try {
		fw.flush();
	} catch (Exception e) {
		out.println(e.toString());
	}
	try {
		if ( fw != null ) fw.close();
	} catch (Exception e) {
		out.println(e.toString());
	}

}
//�ۭq²�T��
try {
	fw = new FileWriter("/apsource/csap/projfz/webap/FZ/tsa/SMS/sms2.txt", false);
	fw.write(phoneList2.toString());


} catch (IOException e) {
	out.println(e.toString());
} finally {
	try {
		fw.flush();
	} catch (Exception e) {
		out.println(e.toString());
	}
	try {
		if ( fw != null ) fw.close();
	} catch (Exception e) {
		out.println(e.toString());
	}

}

//log��
try {
	fw = new FileWriter("/apsource/csap/projfz/webap/FZ/tsa/SMS/smsLog.txt", true);
	fw.write(logFile.toString());


} catch (IOException e) {
	out.println(e.toString());
} finally {
	try {
		fw.flush();
	} catch (Exception e) {
		out.println(e.toString());
	}
	try {
		if ( fw != null ) fw.close();
	} catch (Exception e) {
		out.println(e.toString());
	}

}


%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Make File</title>
<link href="../menu.css" rel="stylesheet" type="text/css">

</head>

<body>
<div align="center">
  <p><span class="txttitletop">������X�ɮסA�s�@���\!!</span><br>
  
    <span class="txtgray2">1.������X�ɡG</span><a href="../tsa/SMS/sms.txt"><img src="../images/ed4.gif" border="0">�Ы��k��t�s�s��!!</a><br>
      <span class="txtgray2">2.�ӤH��²�T�ɡG</span><a href="../tsa/SMS/sms2.txt"><img src="../images/ed4.gif" border="0">�Ы��k��t�s�s��!!</a>
      </p>
  <p><span class="txtblue">�o�e²�T�A�Ц�<a href="http://km.china-airlines.com/km/" target="_blank"><font color="#FF0000" style="text-decoration:underline ">�د�²�T�A�Ⱥ�eSMS</font></a><br>
    �W�Ǧ��B�s�@��������X�ɮקY�i�C</span>
    </p>
</div>
</body>
</html>