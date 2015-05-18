<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="eg.zcrpt.*,java.sql.*,fz.pracP.*,ci.db.*,		java.net.URLEncoder,eg.flightcheckitem.*"%>
<%
//response.setHeader("Cache-Control","no-cache");
//response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
ArrayList objAL = (ArrayList) session.getAttribute("zcreportobjAL"); 
if ( sGetUsr == null | objAL == null) 
{		//check user session start first or not login
	response.sendRedirect("../../sendredirect.jsp");
}
else
{
String idx = request.getParameter("idx");
ZCReportObj obj = (ZCReportObj) objAL.get(Integer.parseInt(idx));
String directpage = "";
Connection conn = null;
PreparedStatement pstmt = null;
String errMsg = "";
String sql = "";
ArrayList  crewListobjAL = new ArrayList();

if("".equals(obj.getIfsent()) | obj.getIfsent() == null)
{
	//set updated seqno
	ZCReport zcrt = new ZCReport();
	obj.setSeqno(zcrt.getZCReportSeqno(obj.getFdate(),obj.getFlt_num(),obj.getPort(),sGetUsr));
	//*******************************************************************************************
	try
	{
		ConnectionHelper ch = new ConnectionHelper();
		conn = ch.getConnection();

		sql = " insert into egtzcflt (seqno,fltd,fltno,sect,cpname,cpno,acno,psrempn,psrsern,psrname,pgroups,zcempn,zcsern,zcname,zcgrps,ifsent,newuser,newdate) values (?,to_date(?,'yyyy/mm/dd'),?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,sysdate)";

/*
if("634552".equals(sGetUsr))
{
out.println("insert into egtzcflt (seqno,fltd,fltno,sect,cpname,cpno,acno,psrempn,psrsern,psrname,pgroups,zcempn,zcsern,zcname,zcgrps,ifsent,newuser,newdate) values ('"+obj.getSeqno()+"',to_date('"+obj.getFdate()+"','yyyy/mm/dd'),'"+obj.getFlt_num()+"','"+obj.getPort()+"','"+obj.getCpname()+"','"+obj.getCpno()+"','"+obj.getAcno()+"','"+obj.getPsrempn()+"','"+obj.getPsrsern()+"','"+obj.getPsrname()+"','"+obj.getPgroups()+"','"+obj.getZcempn()+"','"+obj.getZcname()+"','"+obj.getZcname()+"','"+obj.getZcgrps()+"','N','"+sGetUsr+"',sysdate)");
}
*/

		pstmt = conn.prepareStatement(sql);  
		int j=1;
		pstmt.setString(j, obj.getSeqno());
		pstmt.setString(++j, obj.getFdate());
		pstmt.setString(++j, obj.getFlt_num());
		pstmt.setString(++j, obj.getPort());
		pstmt.setString(++j, obj.getCpname());
		pstmt.setString(++j, obj.getCpno());
		pstmt.setString(++j, obj.getAcno());
		pstmt.setString(++j, obj.getPsrempn());
		pstmt.setString(++j, obj.getPsrsern());
		pstmt.setString(++j, obj.getPsrname());
		pstmt.setString(++j, obj.getPgroups());
		pstmt.setString(++j, obj.getZcempn());
		pstmt.setString(++j, obj.getZcsern());
		pstmt.setString(++j, obj.getZcname());
		pstmt.setString(++j, obj.getZcgrps());
		pstmt.setString(++j, "N");
		pstmt.setString(++j, sGetUsr);
		pstmt.addBatch();	
		pstmt.executeBatch();				
		pstmt.clearBatch();
		obj.setIfsent("N");
	}
	catch(SQLException e)
	{
		errMsg = e.toString();
	}
	catch (Exception e)
	{
		errMsg = e.toString();
	}
	finally
	{
		if (pstmt != null)
			try {
				pstmt.close();
			} catch (SQLException e) {	errMsg += e.getMessage();}
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
					errMsg += e.getMessage();
			}
			conn = null;
		}
	}
	directpage = "zcCrewScoring.jsp?idx="+idx;
}

crewListobjAL = obj.getZccrewObjAL();
if(crewListobjAL.size()>0)
{
	ZCReportCrewListObj zccrewobj = (ZCReportCrewListObj) crewListobjAL.get(0);
	if("".equals(zccrewobj.getDuty()) | zccrewobj.getDuty() == null)
	{
		directpage = "zcCrewScoring.jsp?idx="+idx;
	}
	else
	{
		//directpage = "zcEditMenu.jsp?idx="+idx;
		directpage = "zcCrewScoring.jsp?idx="+idx;
	}
}

response.sendRedirect(directpage);
}//if ( sGetUsr == null | objAL == null) 
%>