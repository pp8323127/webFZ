<%@page import="java.io.IOException"%>
<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,fz.pracP.uploadFile.*"  %>
<%
	String fdate=  request.getParameter("fdate");
	String fltno=  request.getParameter("fltno");
	String dpt = request.getParameter("dpt");
	String arv = request.getParameter("arv");
	String uploadFileName=  request.getParameter("uploadFileName");
	String zcEmpno = request.getParameter("zcEmpno");
	String acno = request.getParameter("acno");
	String GdYear = fz.pracP.GdYear.getGdYear(fdate);
	String idx = request.getParameter("idx");
	String sect = dpt+arv;
	//�R��DB�������
	 fz.pracP.uploadFile.DeleteData dd = new 
	 		fz.pracP.uploadFile.DeleteData(fdate, fltno,sect,uploadFileName);
	//�R��Server�W���ɮ�			
	 fz.pracP.uploadFile.DeleteFile df = null;
	  boolean status = false;
	  String msg = "";
try {
		dd.DoZCDelete();//ZC���ifile
	
	if(dd.isDelSuccess()){
		 df = new fz.pracP.uploadFile.DeleteFile(uploadFileName);				
		 df.DoZCDelete();
		 status = true;     
		if ( !df.isFileIsExist() ) {
			status = false;
			msg = "�ɮפ��s�b!!";
		}
				
	}else{
		status = false;
		msg = "�R����ƥ���!!"+dd.getMsg();
	}
	out.println(dd.getMsg());
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
<title>�R���W���ɮ�</title>
</head>

<body>
<script language="JavaScript" type="text/JavaScript">
<%
/*String isZ = "";
if(!"".equals(request.getParameter("isZ")) && null != request.getParameter("isZ")){
	isZ = "Y";
}*/

if(status){
%>
alert("�ɮקR�����\!!");
self.location ="../zcedFltIrr.jsp?idx=<%=idx%>";
//	self.close();

<%
}else{
%>
alert("<%=msg%>");
//self.close();
<%

}
%>
</script>
</body>
</html>
