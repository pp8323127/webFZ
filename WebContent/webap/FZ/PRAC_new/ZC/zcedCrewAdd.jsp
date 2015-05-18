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
	String newcrew = request.getParameter("newcrew");
	boolean chkdup = false;
	ZCReportObj obj = (ZCReportObj) objAL.get(Integer.parseInt(idx));
	ArrayList crewListobjAL = new ArrayList();
	crewListobjAL = obj.getZccrewObjAL();
	for(int i=0; i<crewListobjAL.size(); i++)
	{
		ZCReportCrewListObj zccrewobj = (ZCReportCrewListObj) crewListobjAL.get(i);	
		if(newcrew.equals(zccrewobj.getEmpno()) && !"Y".equals(zccrewobj.getIfcheck()))
		{
			chkdup = true;
		}
	}
	if(chkdup == false)
	{
		//*************************************
		//New crew info
		eg.EGInfo egi = new eg.EGInfo(newcrew);
		eg.EgInfoObj cobj = egi.getEGInfoObj(newcrew); 
		ZCReportCrewListObj zccrewobj = new ZCReportCrewListObj();
		zccrewobj.setEmpno(cobj.getEmpn());
		zccrewobj.setSern(cobj.getSern());
		zccrewobj.setCname(cobj.getCname());
		zccrewobj.setGrp(cobj.getGroups());                         
		zccrewobj.setSeqno(obj.getSeqno());
		//*************************************
		crewListobjAL.add(zccrewobj);
		response.sendRedirect("zcCrewScoring.jsp?idx="+idx);
	}
	else
	{
%>
		<SCRIPT LANGUAGE="JavaScript">
			alert("該員工已存在");
			location.replace("zcCrewScoring.jsp?idx=<%=idx%>");
		</SCRIPT>
<%
	}
}
%> 
