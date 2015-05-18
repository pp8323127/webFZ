<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="../../FZ/menu.css" rel="stylesheet" type="text/css">
<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="java.sql.*, java.util.*, javax.naming.*, javax.sql.DataSource"%>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);

if (session.isNew() || sGetUsr == null) {		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
	
}
String linkstring = request.getParameter("linkstring");
String fltno = request.getParameter("fltno");
String fdate = request.getParameter("fdate"); //yyyy/mm/dd
String sect  = request.getParameter("sect");
//取得考績年度
String gdyear = request.getParameter("gdyear");
String empno = request.getParameter("empno");
String flag = request.getParameter("flag"); //I : insert  U : update
String[] score = request.getParameterValues("score");
String[] comm = request.getParameterValues("comm");

Context initContext = null;
DataSource ds = null;
Connection dbCon = null;
PreparedStatement pstmt = null;
boolean t = true;
String errMsg = "";
String sql = null;

try{
	initContext = new InitialContext();
	//connect to EGDB ORP3 / ORT1 by Datasource
	ds = (javax.sql.DataSource)initContext.lookup("CAL.EGDS01");
	dbCon = ds.getConnection();
	
	if("I".equals(flag)){ //Insert
		sql = "insert into egtzcdt values(?,to_date(?,'yyyy/mm/dd'),?,?,?,";
		//out.println(gdyear+"<br>"+fdate+"<br>"+fltno+"<br>"+sect+"<br>"+empno+"<br>");
		for(int i=0; i<score.length; i++){
			sql = sql + score[i] + ",";
			if(comm[i] == null || "".equals(comm[i])){
				sql = sql + "null,";
			}
			else{
				sql = sql + "'" + comm[i] + "',";
			}
		}
		sql = sql + "sysdate,'" + sGetUsr + "')";
		pstmt = dbCon.prepareStatement(sql);
		pstmt.setString(1,gdyear);
		pstmt.setString(2,fdate);
		pstmt.setString(3,fltno);
		pstmt.setString(4,sect);
		pstmt.setString(5,empno);
	}
	else{ //Update
		sql = "update egtzcdt set ";
		for(int i=1; i<11; i++){
			sql = sql + "score" + i + "=" + score[i-1] + ",comm" + i + "='" + comm[i-1]+"',";
		}
		sql = sql + "upddate=sysdate, upduser='"+sGetUsr+"' where fltd=to_date(?,'yyyy/mm/dd') and fltno=? and sect=? and empno=?";
		pstmt = dbCon.prepareStatement(sql);
		pstmt.setString(1,fdate);
		pstmt.setString(2,fltno);
		pstmt.setString(3,sect);
		pstmt.setString(4,empno);
	}
	pstmt.execute();
}
catch (Exception e)
{
	  errMsg = "Error : " + e.toString();
	  t = false;
}
finally
{
	try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
	try{if(dbCon != null) dbCon.close();}catch(SQLException e){}
}
if(t){
	response.sendRedirect(linkstring+"&f=s");
}
else{
	out.print("<p align=\"center\" class=\"txtxred\">" + errMsg + "<br>"+sql+"</p>");
	out.print("<p align=\"center\" class=\"txttitle\"><a href=\"" + linkstring + "\">Back</a></p>");
}
%>