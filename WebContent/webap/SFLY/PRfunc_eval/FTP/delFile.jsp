<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,fz.pracP.uploadFile.*"  %>
<%
String filename=  request.getParameter("filename");
String saveDirectory = application.getRealPath("/")+"/SFLY/PRfunc_eval/FTP/file/";
File f1 = new File(saveDirectory,filename+".jpg");
boolean b1 = false;
b1 = f1.exists();
if(b1==true)
{
	f1.delete();
}
%>
<script language="JavaScript" type="text/JavaScript">	 
	self.close();	
</script>
