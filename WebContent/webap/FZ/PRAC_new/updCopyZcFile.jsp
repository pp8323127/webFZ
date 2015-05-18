<%@page import="ci.db.ConnDB"%>
<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="eg.zcrpt.*,ci.db.*,java.sql.*,java.util.ArrayList"%>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
String fltd = request.getParameter("fltd");
String fltno = request.getParameter("fltno");
String sect = request.getParameter("sect");
String acno = request.getParameter("acno");
String purserEmpno = request.getParameter("purserEmpno");
String psrname = request.getParameter("psrname");
String psrsern = request.getParameter("psrsern");
String GdYear = request.getParameter("GdYear");
String src = request.getParameter("src");
String[] file = request.getParameterValues("file");
String[] filenameT = request.getParameterValues("filename");
String[] filedscT = request.getParameterValues("filedsc");


if(sGetUsr != null || (src != null && src.equals("APP")))
{	
	if(file != null){
		String[] filename = new String[file.length];
		String[] filedsc = new String[file.length];
		for(int i=0 ; i<file.length ; i++){			
			filename[i] = filenameT[Integer.parseInt(file[i])];
			filedsc[i] = filedscT[Integer.parseInt(file[i])];
			//out.println(filename[i]+"/"+filedsc[i]);
		}
		/**insert**/
		ReportCopy copy = new ReportCopy();
		copy.copyFileToCM(fltd, fltno, sect, purserEmpno, psrname, psrsern, filename, filedsc);
		String msg = copy.getErrorstr();
		if("Y".equals(msg)){
			out.println(msg);
		%>
			<script>
			alert("Copy to CM report Success!!");
			window.opener.location.reload();
			window.close();
			</script>
		<%	
		}else{
			out.println(msg+"This fun Only for Live System");
		}
	}else{
		out.println("No Data!");
	}
	

}else
{		//check user session start first or not login
	response.sendRedirect("/webfz/FZ/sendredirect.jsp");
}



%>