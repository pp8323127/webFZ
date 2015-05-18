<%@page import="ftp.MPFilePath"%>
<%@page import="java.io.IOException"%>
<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,fz.pracP.uploadFile.*"  %>
<%
String sernno = request.getParameter("sernno");
String type = request.getParameter("type");
String seq = request.getParameter("seq");
String itemno = request.getParameter("itemno");

String fdate = request.getParameter("fdate");
String fltno = request.getParameter("fltno");
String trip = request.getParameter("trip");
//String src = request.getParameter("src");
String uploadFileName=  request.getParameter("filename");

	String GdYear = fz.pracP.GdYear.getGdYear(fdate);
	
	MPFilePath dd = new MPFilePath(fdate, fltno, trip,uploadFileName);			
	boolean status = false;
	String msg = "";
try {
	//刪除DB內之資料
	dd.DoMCdbDelete();
	//刪除Server上之檔案		
	if(dd.isDelSuccess()){				 
		 dd.DoMPDelete();
		 status = true;     
		if ( !dd.isFileIsExist() ) {
			status = false;
			msg = "檔案不存在!!";
		}
				
	}else{
		status = false;
		msg = "刪除資料失敗!!";
	}
	
} catch (ClassNotFoundException e) {
	msg = e.toString();
} catch (SQLException e) {
	msg = e.toString();
}catch(IOException e){
	msg = e.toString();
}
	 
	 
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>刪除上傳檔案</title>
</head>

<body>
<script language="JavaScript" type="text/JavaScript">
<%


if(status){
%>
alert("檔案刪除成功!!");
//opener.location.reload(true);
opener.location.reload(true);
self.close();

<%
}else{
%>
alert("<%=msg%>");
//opener.location.reload(true);
self.close();
<%

}
%>
</script>
</body>
</html>
