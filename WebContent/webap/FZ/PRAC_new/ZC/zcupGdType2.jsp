<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=big5" language="java" %><%@ page  import="eg.zcrpt.*,java.sql.*,tool.ReplaceAll,ci.db.*,java.net.URLEncoder"%>
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
	String subsubidx = request.getParameter("subsubidx");
	boolean chkdup = false;
	ZCReportObj obj = (ZCReportObj) objAL.get(Integer.parseInt(idx));
	ArrayList crewListobjAL = new ArrayList();
	crewListobjAL = obj.getZccrewObjAL();
	ZCReportCrewListObj zccrewobj = (ZCReportCrewListObj) crewListobjAL.get(Integer.parseInt(subidx));
	ArrayList crewgradeobjAL = new ArrayList();
	crewgradeobjAL = zccrewobj.getGradeobjAL();
	ZCGradeObj gradeobj = (ZCGradeObj) crewgradeobjAL.get(Integer.parseInt(subsubidx));
	//update seqno
	gradeobj.setSeqno(obj.getSeqno());
	//取代textarea中的換行符號為,
	String gdtype = request.getParameter("gdname");
	String comments = request.getParameter("comm");
	comments = ReplaceAll.replace(comments,"\r\n",",");

	Driver dbDriver = null;
	Connection conn = null;
	PreparedStatement pstmt = null;
	boolean updSuccess = false;
	String msg = "";
	String sql = "";
	try
	{
		ConnectionHelper ch = new ConnectionHelper();
	    conn = ch.getConnection();

		sql = " Update egtzcgddt set gdtype = ?, comments = ? , chguser = ?, chgdate = sysdate where seqno = ? and empno = ? and gdtype = ? ";		
		pstmt = conn.prepareStatement(sql);

		pstmt.setString(1,gdtype);
		pstmt.setString(2,comments);
		pstmt.setString(3,sGetUsr);
		pstmt.setString(4,gradeobj.getSeqno());
		pstmt.setString(5,gradeobj.getEmpno());
		pstmt.setString(6,gradeobj.getGdtype());
		pstmt.executeUpdate();
		//*******************************************
		ZCReport zcr = new ZCReport();
		ArrayList gradeobjAL = zcr.getCrewGrade(gradeobj.getSeqno(), gradeobj.getEmpno());
		zccrewobj.setGradeobjAL(gradeobjAL);
		//*******************************************
		updSuccess=true;
}
catch (Exception e)
{
	//  out.print(e.toString());
	//  System.out.print("更新優點錯誤："+e.toString());
	  msg = "錯誤："+e.toString();
}
finally
{
	try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}

String goPage = "zcedGdType.jsp?idx="+idx+"&subidx="+subidx+"&subsubidx="+subsubidx;
if(updSuccess)
{
%>
<script language="JavaScript" type="text/JavaScript" src="../../../MT/js/close.js"></script>
<script language="JavaScript" type="text/JavaScript">
	close_self("<%=goPage%>");
</script>
<%
}
else
{
goPage = "zcedGdType2.jsp?idx="+idx+"&subidx="+subidx+"&subsubidx="+subsubidx;
%>
<%=msg%><br>
<a href="<%=goPage%>">請重新輸入!!</a>
<%
}
}
%>