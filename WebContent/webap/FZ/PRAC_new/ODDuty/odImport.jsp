<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*" %>
<%@ page import ="eg.purserreport.*,eg.db.*,ci.tool.*"%>
<%
String userid = (String)session.getAttribute("userid");
if (userid == null) {		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} else{

String year = request.getParameter("year");
String month = request.getParameter("month");

String errMsg = "";
boolean status = false;
ODDutyCrewImport oi = null;
CheckODImported chkIpt = null;

java.util.GregorianCalendar cal = new java.util.GregorianCalendar();
String fileName = year+month+(new java.text.SimpleDateFormat("yyyyDHHmmSS")).format(cal.getTime())+"ODImport.htm";

String filePath = "/apsource/csap/projfz/webap/Log/"+fileName;


try {
	chkIpt = new CheckODImported(year,month);

	oi = new ODDutyCrewImport(year, month);
	oi.SelectODData();//���o�y�������i��Duty Code = OD ��
	oi.setODCrew();

	oi.MatchLog();//���LOG���
	
	if(oi.getOdAL() == null || oi.getOdAL().size() == 0){
		errMsg = year+month+" �y�������i�L Duty �� OD ���.���ݧ�s.";
	
	}else{
		
		oi.RemoveNeednotUpdateLog();//��������update Z Code
		
		
		oi.UpdateZCode();	//update Z Code in DFTLOGC
			
		ci.tool.DeliverMail cm = new DeliverMail();
		oi.composeLogFormat();//��´email format
		
		
		FileWriter fw = new FileWriter(filePath);
		fw.write(oi.getMailContent().toString());
		fw.close();//�g���ɮ�
	
		//�H�eemail 
		cm.DeliverMailWithAttach("OD Import", userid,
				"The Result of OD Import is attach file.", filePath,
				year+month+"ODImport.htm");
		cm.DeliverMailWithAttach("OD Import", "tpecsci",
				"The Result of OD Import is attach file.", filePath,
				year+month+"ODImport.htm");				
/*		File f = new File(filePath);
		if(f.exists()){
			f.delete();
		}				
		f = null;
*/		

	//�g�J Log
	ci.tool.WriteFZUseLog wfzLog 
		= new ci.tool.WriteFZUseLog(userid,request.getRemoteAddr(),"EG","1",
					year,month,"Y","�פJ"+year+month+"��Ʀ@"+oi.getUpdateRows()+"��");

	wfzLog.InsertData();
	
		status = true;			
	}		
}catch(Exception e){
	errMsg +="<br>ERROR"+ e.toString();
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" type="text/css" href="../style2.css">
<link rel="stylesheet" type="text/css" href="../errStyle.css">
<title>OD Import Result</title>
</head>

<body>
<%
if(status){
%>
	<div  class="errStyle2">�פJ����!!<br><br>

	<%
		if(chkIpt.isImported()){
			out.print(year+month+"��ƴ��g����פJ�ʧ@,�i��ɭP������s��Ƭ� 0 ��.");
		}else{
			out.print(year+month+"��ƥ����פJ.");
		}	
	%>

	<br><br>�����@��s<%=oi.getUpdateRows()%>�����.<br><br>	

	
	��Ƥ��/�פJ���p�A�Ц�<a href="http://mail.cal.aero" target="_blank">�����H�c</a>����EMAIL.<br>	
	�� <a href="/webfz/Log/<%=fileName%>" target="_blank">�u�W�˵����G</a><br>
</div>
<%
}else{
%>
	<div  class="errStyle2"><%=errMsg%></div>
<%

}
%>

</body>
</html>
<%
}
%>