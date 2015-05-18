<%@ page contentType="text/html; charset=big5" language="java" %><%@ page  import="java.sql.*,tool.ReplaceAll,ci.db.*,java.net.URLEncoder"%><%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) {		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} 


String sern  = (String) request.getParameter("sern");
String cname = (String) request.getParameter("cname");
String ename = (String) request.getParameter("ename");
String fltno = (String) request.getParameter("fltno");
String fdate = (String) request.getParameter("fdate");
String sect  = (String) request.getParameter("sect");
//取得考績年度

//out.println("fdate  "+fdate+"<br>");
String GdYear = fz.pracP.GdYear.getGdYear(fdate);
//String GdYear = "2012";

/*
String oGdYear = "2005";//request.getParameter("GdYear");
//Modified by cs66 at 2005/01/03: gdYear不加1000
//int GdYear = 1000+Integer.parseInt(oGdYear);
int GdYear = Integer.parseInt(oGdYear);
*/

String empno = request.getParameter("empno");
String gdtype = request.getParameter("gdname");
String comments = request.getParameter("comm");

//取代textarea中的換行符號為,
//comments = ReplaceAll.replace(comments,"\r\n",",");

String NewDataInSql = "newuser,newdate";

Driver dbDriver = null;
Connection conn = null;
PreparedStatement pstmt = null;
boolean updSuccess = false;
String msg = "";
try{
ConnDB cn = new ConnDB();
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);

String sqlInsertData = "INSERT INTO EGTGDDT ( yearsern,gdyear,empn,sern,fltd,fltno,sect,gdtype,score,comments,"+
						NewDataInSql+") values(EGQGDYS.nextval,'"+GdYear+"','"+empno+"','"+sern+"',"+
						"to_date('"+fdate+"','yyyy/mm/dd'),'"+fltno+"','"+sect+"','"+gdtype+"',null,?,'"+sGetUsr+"',sysdate)";		
pstmt = conn.prepareStatement(sqlInsertData);		
pstmt.setString(1,comments);

pstmt.executeUpdate();
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


//String goPage = "edGdType.jsp?sern="+sern+"&ename="+ename+"&fltno="+fltno+"&fdate="+fdate+"&s="+sect+"&empno="+empno;

String goPage = "edGdType.jsp?sern="+sern+"&fltno="+fltno+"&fdate="+fdate+"&s="+sect+"&empno="+empno+"&cname="+URLEncoder.encode(cname)+"&ename="+ename;
if(updSuccess)
{
	response.sendRedirect(goPage);
}
else
{
%>
<%=msg%><br>
<a href="<%=goPage%>">請重新輸入!!</a>

<%

}

%>
