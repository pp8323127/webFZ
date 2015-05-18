<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="eg.zcrpt.*,java.sql.*,java.net.URLEncoder,fz.pracP.*,ci.db.*" %>
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
	boolean chkdup = false;
	ZCReportObj obj = (ZCReportObj) objAL.get(Integer.parseInt(idx));
	ArrayList crewListobjAL = new ArrayList();
	crewListobjAL = obj.getZccrewObjAL();
	ZCReportCrewListObj zccrewobj = (ZCReportCrewListObj) crewListobjAL.get(Integer.parseInt(subidx));	
	String[] delItem = request.getParameterValues("delgdtype");

	String delItemRange = "";

	for(int i=0;i<delItem.length;i++)
	{
		if(i==0)
		{
			delItemRange = "'"+ delItem[i]+"'";
		}
		else
		{
			delItemRange =delItemRange + ",'"+ delItem[i]+"'";
		}

	}    	

	Driver dbDriver = null;
	Connection conn = null;
	Statement stmt = null;
	try
	{

	ConnectionHelper ch = new ConnectionHelper();
	conn = ch.getConnection();
	stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);

	String sql = "delete egtzcgddt where seqno = to_number("+obj.getSeqno()+") and empno = '"+zccrewobj.getEmpno()+"' and gdtype in ("+delItemRange+")";
	//out.println(sql + "<br>");
	stmt.executeUpdate(sql);
	//*********************************
	ZCReport zcr = new ZCReport();
	ArrayList gradeobjAL = zcr.getCrewGrade(zccrewobj.getSeqno(), zccrewobj.getEmpno());
	zccrewobj.setGradeobjAL(gradeobjAL);
	//*********************************
	String goPage = "zcedGdType.jsp?idx="+idx+"&subidx="+subidx;
	response.sendRedirect(goPage);

	}
	catch (Exception e)
	{
		  out.print(e.toString());
		  //response.sendRedirect("../showMessage.jsp?messagestring="+URLEncoder.encode("系統忙碌中，請稍後再試"));

	}
	finally
	{
		try{if(stmt != null) stmt.close();}catch(SQLException e){}
		try{if(conn != null) conn.close();}catch(SQLException e){}
	}
}
%>