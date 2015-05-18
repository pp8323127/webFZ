<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="eg.zcrpt.*,java.util.*"%>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
ArrayList objAL = (ArrayList) session.getAttribute("zcreportobjAL"); 
if ( sGetUsr == null | objAL == null) 
{		//check user session start first or not login
	response.sendRedirect("/webfz/FZ/sendredirect.jsp");
}
else
{
	String idx = request.getParameter("idx");
	String subidx = request.getParameter("subidx");
	String attri = request.getParameter("attri");
	String para = request.getParameter("para1");
	ZCReportObj obj = (ZCReportObj) objAL.get(Integer.parseInt(idx));
	ArrayList crewListobjAL = new ArrayList();
	crewListobjAL = obj.getZccrewObjAL();
	ZCReportCrewListObj zccrewobj = (ZCReportCrewListObj) crewListobjAL.get(Integer.parseInt(subidx));
	if("duty".equals(attri))
	{
		zccrewobj.setDuty(para);
	}
	if("score".equals(attri))
	{
		zccrewobj.setScore(para);
	}

	if("bp".equals(attri))
	{
		zccrewobj.setBest_performance(para);
	}

	if("del".equals(attri))
	{
		zccrewobj.setIfcheck(para);
	}


%>
	<SCRIPT LANGUAGE="JavaScript">
	window.close();
	</SCRIPT>
<%
}
%> 
