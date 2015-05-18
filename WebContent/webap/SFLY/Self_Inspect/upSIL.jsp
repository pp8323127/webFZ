<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="java.sql.*,tool.ReplaceAll,java.net.URLEncoder,ci.db.ConnDB" %>
<%

String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("../logout.jsp");
}

String sernno  = request.getParameter("sernno");
String fltno	= request.getParameter("fltno");
String fltd	    = request.getParameter("fltd");
String upduser = request.getParameter("userid");
String upddate = request.getParameter("sysdate");
String itemno  = request.getParameter("addItemNo");
String[] addItem = request.getParameterValues("addItemNo");
String addStr="";

Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
int hasItemCount = 0;
String forwardPage = "";
String sql = null;
Driver dbDriver = null;
ConnDB cn = new ConnDB();

try{

//ort1
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);


for(int i=0;i<addItem.length;i++)
{
	sql = "INSERT INTO egtstcc (sernno, itemno, upduser, upddate)"+
				 "VALUES ('"+sernno+"', '"+addItem[i]+"', '"+upduser+"', To_Date('"+upddate+"','mm/dd/yy'))";
	//out.print(sql+"<br>");
	stmt.executeUpdate(sql);
}
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