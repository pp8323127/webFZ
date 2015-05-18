<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="java.sql.*,java.net.URLEncoder,ci.db.ConnDB" %>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("../logout.jsp");
}

String sernno  = request.getParameter("sernno");
String fltno	= request.getParameter("fltno");
String fltd	    = request.getParameter("fltd");
String[] delItemNo = request.getParameterValues("delItemNo");

String delItemNoRange = "";

for(int i=0;i<delItemNo.length;i++){
	if(i==0){
		delItemNoRange = "'"+ delItemNo[i]+"'";
	}
	else{
		delItemNoRange =delItemNoRange + ",'"+ delItemNo[i]+"'";
	}

}    	

Connection conn = null;
Statement stmt = null;
ConnDB cn = new ConnDB();
Driver dbDriver = null;

try{

cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);

stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);

String sql = "delete egtstcc where sernno='"+sernno+"' and itemno in("+delItemNoRange+") ";
stmt.executeUpdate(sql);

String goPage = "edSIL.jsp?sernno="+sernno+"&fltno="+fltno+"&fltd="+fltd+" ";
response.sendRedirect(goPage);

}
catch (Exception e)
{
	  out.print(e.toString());
}
finally
{
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}

%>