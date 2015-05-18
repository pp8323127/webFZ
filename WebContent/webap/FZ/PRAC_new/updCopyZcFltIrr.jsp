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
String[] irr = request.getParameterValues("irr");
String[] itemnoT = request.getParameterValues("itemno");
String[] comT = request.getParameterValues("com");
String[] dscT = request.getParameterValues("dsc");
String[] flagT = request.getParameterValues("flag");

if ( sGetUsr == null) 
{		//check user session start first or not login
	response.sendRedirect("/webfz/FZ/sendredirect.jsp");
}else{

	if(irr != null && irr.length >0){
		String[] itemno = new String[irr.length];
		String[] com = new String[irr.length];
		String[] dsc = new String[irr.length];
		String[] flag = new String[irr.length];
		for(int i=0 ; i<irr.length ; i++){			
			itemno[i] = itemnoT[Integer.parseInt(irr[i])];
			com[i] = comT[Integer.parseInt(irr[i])];
			dsc[i] = dscT[Integer.parseInt(irr[i])];
			flag[i] = flagT[Integer.parseInt(irr[i])];
			out.println(irr[i]+"/"+itemno[i]+"/"+dsc[i]+"/"+com[i]);
		}
		
		/**insert**/
		ReportCopy copy = new ReportCopy();
		copy.copyIrrToCM(fltd, fltno, sect, acno, purserEmpno, psrname, psrsern, itemno, com, dsc, flag);
		String msg = copy.getErrorstr();
		if("Y".equals(msg)){
		%>
			<script>
			alert("Copy to CM report Success!!");
			//window.opener.location.reload();
	        //window.close();
			</script>
		<%	
		}else{
			out.println(msg);
		}

	}else{
		out.println("NO data!!");
	}
	
}



%>