<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="eg.crewbasic.AirToEG"%>
<%
String sGetUsr = (String) session.getAttribute("cs55.usr") ; //Check if logined
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
if (session.isNew() || sGetUsr == null) {		//check user session start first
    %> <jsp:forward page="../sendredirect.jsp" /> <%
}else{
	AirToEG visa = new AirToEG();
	visa.AirCrewPassPortToEG();
	String passprot = visa.getReturnstr();
/* 	out.println(passprot+"<BR>");
	out.println(visa.getSql()+"<BR>");
	out.println(visa.getSql2()+"<BR>");
	out.println("***************************"+"<BR>"); */
	
	visa.AirCrewVisaToEG();
	String USA = visa.getReturnstr();
/* 	out.println(USA+"<BR>");
 	out.println(visa.getSql()+"<BR>");
	out.println(visa.getSql2()+"<BR>");
	out.println("done"+"<BR>"); */
	if(passprot.equals("Y") && USA.equals("Y")){
		//out.println("yes"+"<BR>");
%>
		<SCRIPT LANGUAGE="JavaScript">
			alert('更新成功!!!');
			window.location.href = "http://hdqfjuap01:9901/webfz/FZ/mcl/mcl_cond.jsp";
		</SCRIPT> 
<%
	}else{
		//out.println("no"+"<BR>");
%>	
		<SCRIPT LANGUAGE="JavaScript">
			alert('更新失敗!!!');
			window.location.href = "http://hdqfjuap01:9901/webfz/FZ/mcl/mcl_cond.jsp";
		</SCRIPT>
<%		
	}
	
}


%>
