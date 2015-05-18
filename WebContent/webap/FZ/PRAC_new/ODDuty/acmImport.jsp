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
ACMDutyCrewImport oi = null;
CheckACMImported chkIpt = null;

java.util.GregorianCalendar cal = new java.util.GregorianCalendar();
String fileName = year+month+(new java.text.SimpleDateFormat("yyyyDHHmmSS")).format(cal.getTime())+"ACMImport.htm";

String filePath = "/apsource/csap/projfz/webap/Log/"+fileName;


try {
	chkIpt = new CheckACMImported(year,month);

	oi = new ACMDutyCrewImport(year, month);
	oi.SelectACMData();//取得座艙長報告中Duty Code = ACM 者
	oi.setACMCrew();

	oi.MatchLog();//比對LOG資料
	
	if(oi.getAcmAL() == null || oi.getAcmAL().size() == 0)
	{
		errMsg = year+month+" 座艙長報告無 Duty 為 ACM 資料.不需更新.";
	
	}
	else
	{
		
		oi.RemoveNeednotUpdateLog();//移除不需update M Code
		
		
		oi.UpdateMCode();	//update M Code in DFTLOGC
			
		ci.tool.DeliverMail cm = new DeliverMail();
		oi.composeLogFormat();//組織email format
		
		
		FileWriter fw = new FileWriter(filePath);
		fw.write(oi.getMailContent().toString());
		fw.close();//寫成檔案
	
		//寄送email 
		cm.DeliverMailWithAttach("ACM Import", userid,
				"The Result of ACM Import is attach file.", filePath,
				year+month+"ACMImport.htm");
		cm.DeliverMailWithAttach("ACM Import", "tpecsci",
				"The Result of ACM Import is attach file.", filePath,
				year+month+"ACMImport.htm");				
/*		File f = new File(filePath);
		if(f.exists()){
			f.delete();
		}				
		f = null;
*/		

	//寫入 Log
	ci.tool.WriteFZUseLog wfzLog 
		= new ci.tool.WriteFZUseLog(userid,request.getRemoteAddr(),"EG","2",
					year,month,"Y","匯入"+year+month+"資料共"+oi.getUpdateRows()+"筆");

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
<title>ACM Import Result</title>
</head>

<body>
<%
if(status){
%>
	<div  class="errStyle2">匯入完成!!<br><br>

	<%
		if(chkIpt.isImported()){
			out.print(year+month+"資料曾經執行匯入動作,可能導致本次更新資料為 0 筆.");
		}else{
			out.print(year+month+"資料未曾匯入.");
		}	
	%>

	<br><br>本次共更新<%=oi.getUpdateRows()%>筆資料.<br><br>	

	
	資料比對/匯入狀況，請至<a href="http://mail.cal.aero" target="_blank">全員信箱</a>收取EMAIL.<br>	
	或 <a href="/webfz/Log/<%=fileName%>" target="_blank">線上檢視結果</a><br>
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