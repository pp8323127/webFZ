<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page  import="java.sql.*,fz.pr.orp3.DelReport,java.net.URLEncoder"%>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (sGetUsr == null) {		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} 
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>刪除報告</title>
<link href="../errStyle.css" rel="stylesheet" type="text/css">
</head>

<body>
<div align="center">
  <%
String sect 	= request.getParameter("dpt")+request.getParameter("arv");
String fdate	= request.getParameter("fdate");
String fltno	= request.getParameter("fltno");
//String GdYear	= request.getParameter("GdYear");
//取得考績年度
String GdYear = fz.pr.orp3.GdYear.getGdYear(fdate);

String purserEmpno	= request.getParameter("purserEmpno");
//out.print("sect="+sect+"<BR>fdate="+fdate+"<BR>fltno="+fltno+"<BR>GdYear="+GdYear+"<BR>purserEmpno="+purserEmpno);
//String fdate, String fltno, String sect, String pempn, String gdyear, String userid
DelReport dr = new DelReport();

String msg = dr.doDel(fdate,fltno,sect,purserEmpno,GdYear,sGetUsr);
boolean status = false;
String errMsg= "";

//刪除登機準時資訊
fz.pr.orp3.DeleteBordingOnTime dbot = new fz.pr.orp3.DeleteBordingOnTime(fdate,fltno,sect,purserEmpno);
//fz.pr.DeleteBordingOnTime dbot = new fz.pr.DeleteBordingOnTime(fdate,fltno,sect,purserEmpno);
dbot.DeleteData();

//刪除上傳檔案
fz.pr.orp3.uploadFile.DeleteData dd = new fz.pr.orp3.uploadFile.DeleteData(fdate,fltno,sect);
fz.pr.orp3.uploadFile.DeleteReportUploadFile du = new fz.pr.orp3.uploadFile.DeleteReportUploadFile(fdate,fltno,sect);
ArrayList fileNameAL = null;
try {
	du.initData();
	fileNameAL = du.getFileNameList();
	//刪除DB Data
	dd.DoDelete();
	for ( int i = 0; i < fileNameAL.size(); i++) {
		fz.pr.orp3.uploadFile.DeleteFile df = new fz.pr.orp3.uploadFile.DeleteFile((String) fileNameAL.get(i));
		try {
			df.DoDelete();			
		} catch (IOException e1) {
			errMsg = e1.toString();
		}
	}
status = true;

} catch (ClassNotFoundException e) {
	errMsg = e.toString();
} catch (SQLException e) {
	errMsg = e.toString();
} catch (InstantiationException e) {
	errMsg = e.toString();
} catch (IllegalAccessException e) {
	errMsg = e.toString();
}


if(msg.equals("0") ){
	if(status){
	%>
	<script>
		alert("報表已刪除");
	</script>
	<div class="errStyle1">報表已刪除!!</div>  
	<%	
	}else{
	out.print("<div class=\"errStyle1\">Delete Upload File Fail: " + errMsg+"</div>");		
	}
}
else{
	out.print("<div class=\"errStyle1\">Delete Report Fail : " + msg+"</div>");
}
%>
</div>
</body>
</html>
