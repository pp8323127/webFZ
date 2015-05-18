<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,fz.pr.orp3.uploadFile.*"  %>
<%
	String fdate=  request.getParameter("fdate");
	String fltno=  request.getParameter("fltno");
	String dpt = request.getParameter("dpt");
	String arv = request.getParameter("arv");
	String uploadFileName=  request.getParameter("uploadFileName");
	String purserEmpno = request.getParameter("purserEmpno");
	String acno = request.getParameter("acno");
	String GdYear = fz.pr.orp3.GdYear.getGdYear(fdate);
	//刪除DB內之資料
	 fz.pr.orp3.uploadFile.DeleteData dd = new 
	 		fz.pr.orp3.uploadFile.DeleteData(fdate, fltno,dpt+arv,uploadFileName);
	//刪除Server上之檔案			
	 fz.pr.orp3.uploadFile.DeleteFile df = null;
	  boolean status = false;
	  String msg = "";
try {
		dd.DoDelete();
	
	if(dd.isDelSuccess()){
		 df = new fz.pr.orp3.uploadFile.DeleteFile(uploadFileName);				
		 df.DoDelete();
		 status = true;     
		if ( !df.isFileIsExist() ) {
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
self.location ="../edFltIrr.jsp?fdate=<%=fdate%>&fltno=<%=fltno%>&dpt=<%=dpt%>&arv=<%=arv%>&purserEmpno=<%=purserEmpno%>&acno=<%=acno%>&pur=<%=purserEmpno%>";

//window.opener.location.href="../edFltIrr.jsp?fdate=<%=fdate%>&fltno=<%=fltno%>&dpt=<%=dpt%>&arv=<%=arv%>&purserEmpno=<%=purserEmpno%>&acno=<%=acno%>&pur=<%=purserEmpno%>";
	//window.opener.location.href="../FltIrrList.jsp?fyy=<%=fdate.substring(0,4)%>&fmm=<%=fdate.substring(5,7)%>&fdd=<%=fdate.substring(8)%>&fltno=<%=fltno%>&GdYear=<%=GdYear%>";
//	self.close();

<%
}else{
%>
alert("檔案刪除失敗：<%=msg%>");
self.location ="../edFltIrr.jsp?fdate=<%=fdate%>&fltno=<%=fltno%>&dpt=<%=dpt%>&arv=<%=arv%>&purserEmpno=<%=purserEmpno%>&acno=<%=acno%>&pur=<%=purserEmpno%>";

<%

}
%>
</script>
</body>
</html>
