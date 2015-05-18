<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="java.sql.*,fz.*,fz.esms.*,ci.tool.*,java.util.*,java.text.SimpleDateFormat"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
//製作手機號碼檔案--> 單一課程

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

for(int i=0;i<crewList.size();i++){//先去掉手機號碼非10位數數字者
	CrewListObj obj = (CrewListObj)crewList.get(i);
	String smsphone = obj.getSmsPhone();
	char cc = '0';
	int count=0;
	for (int j = 0; j < smsphone.length(); j++) { //判斷是否十位數數字
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

//TODO  寫入log 檔
FileWriter fw = null;

//純號碼檔
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
//自訂簡訊檔
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

//log檔
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
  <p><span class="txttitletop">手機號碼檔案，製作成功!!</span><br>
  
    <span class="txtgray2">1.手機號碼檔：</span><a href="../tsa/SMS/sms.txt"><img src="../images/ed4.gif" border="0">請按右鍵另存新檔!!</a><br>
      <span class="txtgray2">2.個人化簡訊檔：</span><a href="../tsa/SMS/sms2.txt"><img src="../images/ed4.gif" border="0">請按右鍵另存新檔!!</a>
      </p>
  <p><span class="txtblue">發送簡訊，請至<a href="http://km.china-airlines.com/km/" target="_blank"><font color="#FF0000" style="text-decoration:underline ">華航簡訊服務網eSMS</font></a><br>
    上傳此處製作的手機號碼檔案即可。</span>
    </p>
</div>
</body>
</html>