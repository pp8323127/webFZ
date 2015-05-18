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

String idx = request.getParameter("idx");
ZCReportObj obj = (ZCReportObj) objAL.get(Integer.parseInt(idx));
String[] delItem = request.getParameterValues("delItem");//Array idx

Driver dbDriver = null;
Connection conn = null;
Statement stmt = null;

try
{

ConnectionHelper ch = new ConnectionHelper();
conn = ch.getConnection();
stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);

for(int i=0;i<delItem.length;i++)
{
	String sql = "delete egtzccmdt where seqkey = to_number("+delItem[i]+")";
	//out.println(sql + "<br>");
	stmt.executeUpdate(sql);
	//**********************************************************************************
	sql = "delete egtzcchk where seqkey = to_number("+delItem[i]+") ";
	//out.println(sql + "<br>");
	stmt.executeUpdate(sql);
}  
//更新flt irr items
//************************************************************
ZCReport zcrt = new ZCReport();
obj.setZcfltirrObjAL(zcrt.getZCFltIrrItem(obj.getSeqno()));            
//************************************************************
String goPage = "zcedFltIrr.jsp?idx="+idx;
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

%>