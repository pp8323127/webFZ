<%@ page contentType="text/html; charset=" language="java" %>
<%@ page  import="java.sql.*,fz.pracP.DelReport,java.net.URLEncoder"%>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (sGetUsr == null) 
{		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} 
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=">
<link rel="stylesheet" type="text/css" href="errStyle.css">
<title>刪除報告</title>
</head>

<body>
<%
String sect 	= request.getParameter("dpt")+request.getParameter("arv");
String fdate	= request.getParameter("fdate");
String fltno	= request.getParameter("fltno");
//String GdYear	= request.getParameter("GdYear");
//取得考績年度
String GdYear = fz.pracP.GdYear.getGdYear(fdate);

String purserEmpno	= request.getParameter("purserEmpno");
//out.print("sect="+sect+"<BR>fdate="+fdate+"<BR>fltno="+fltno+"<BR>GdYear="+GdYear+"<BR>purserEmpno="+purserEmpno);
//String fdate, String fltno, String sect, String pempn, String gdyear, String userid
DelReport dr = new DelReport();
//String msg="a";
String msg = dr.doDel(fdate,fltno,sect,purserEmpno,GdYear,sGetUsr);
boolean status = false;
String errMsg = "";
//刪除登機準時資訊
fz.pracP.DeleteBordingOnTime dbot = new fz.pracP.DeleteBordingOnTime(fdate,fltno,sect,purserEmpno);
dbot.DeleteData();

//刪除ZC
fz.pracP.CheckZCData chkZC = new fz.pracP.CheckZCData(fdate,fltno,sect,purserEmpno,null,null);
chkZC.SelectData();
chkZC.deleteData();

//刪除PA
fz.pracP.pa.CheckPAData chkPA = new fz.pracP.pa.CheckPAData(fdate,fltno,sect,purserEmpno,null,null);
chkPA.SelectData();
chkPA.deleteData();

//刪除PSFLY
fz.psfly.CheckPSFLYData chksfly = new fz.psfly.CheckPSFLYData(fdate,fltno,sect,purserEmpno);
chksfly.deleteData();

//刪除查核項目
eg.flightcheckitem.CheckItemKeyValue ckKey = new eg.flightcheckitem.CheckItemKeyValue();
	ckKey.setFltd(fdate);
	ckKey.setFltno(fltno);
	ckKey.setSector(sect);
	ckKey.setPsrEmpn(purserEmpno);
eg.flightcheckitem.DeleteFlightCheckRecord delFltChkItem = new eg.flightcheckitem.DeleteFlightCheckRecord(ckKey);
	try{
		delFltChkItem.DeleteData();
	}catch(Exception e){
		
	}

//刪除上傳檔案
fz.pracP.uploadFile.DeleteData dd = new fz.pracP.uploadFile.DeleteData(fdate, fltno, sect);
fz.pracP.uploadFile.DeleteReportUploadFile du = new fz.pracP.uploadFile.DeleteReportUploadFile(fdate, fltno, sect);
ArrayList fileNameAL = null;
try {
	du.initData();
	fileNameAL = du.getFileNameList();
	//刪除DB Data
	dd.DoDelete();

	for ( int i = 0; i < fileNameAL.size(); i++) {
		fz.pracP.uploadFile.DeleteFile df = new fz.pracP.uploadFile.DeleteFile((String) fileNameAL.get(i));
		try {
			df.DoDelete();

		} catch (IOException e1) {
			errMsg	 = e1.toString();
		}
	}
status = true;

} catch (ClassNotFoundException e) {
	errMsg	 = e.toString();
} catch (SQLException e) {
	errMsg	 = e.toString();
}


if(msg.equals("0")){
	%>
	<script>
		alert("報表已刪除");
	</script>
	<%	
	
	out.print("<div class=\"errStyle1\">"+fdate+"&nbsp;"+fltno+" 報表已刪除!!</div>");
}
else{
	out.print("<div class=\"errStyle1\">Delete Report Fail : " + msg+"</div>");
}
%>
</body>
</html>
