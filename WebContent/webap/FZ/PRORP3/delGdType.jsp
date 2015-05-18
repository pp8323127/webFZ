<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,fz.pr.orp3.GdType_Name,ci.db.*,java.net.URLEncoder" %>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) {		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} 

String sern  = request.getParameter("sern").trim();
String cname	= request.getParameter("cname");
String ename = request.getParameter("ename");
String fltno = request.getParameter("fltno");
String fdate = request.getParameter("fdate");
String sect  = request.getParameter("sect");
//String GdYear ="2005";// request.getParameter("GdYear");
//取得考績年度
String GdYear = fz.pr.orp3.GdYear.getGdYear(fdate);

String empno = request.getParameter("empno").trim();
String gdtype = request.getParameter("gdname");
//String yearSern = request.getParameter("delYearSern");
String[] yearSern = request.getParameterValues("delYearSern");

String yearSernRange = "";

for(int i=0;i<yearSern.length;i++){
	if(i==0){
		yearSernRange = "'"+ yearSern[i]+"'";
	}
	else{
		yearSernRange =yearSernRange + ",'"+ yearSern[i]+"'";
	}

}    	
Driver dbDriver = null;
Connection conn = null;
Statement stmt = null;
ResultSet myResultSet = null;

try{
	ConnDB cn = new ConnDB();
	cn.setORP3EGUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);

stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
		ResultSet.CONCUR_READ_ONLY);		

String delSql = "delete EGTGDDT where yearSern in("+ yearSernRange+") and newuser='"+sGetUsr+"' ";
	
stmt.executeQuery(delSql);

}
catch (Exception e)
{
	  out.print(e.toString());
}
finally
{
	//try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}

String goPage = "edGdType.jsp?sern="+sern+"&cname="+URLEncoder.encode(cname)+"&ename="+ename+"&fltno="+fltno+"&fdate="+fdate+"&s="+sect+"&g="+GdYear+"&empno="+empno;

response.sendRedirect(goPage);
%>