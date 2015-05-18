<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="java.sql.*,ci.db.*"%>
<%
//新增Firtst Item
String userid = (String) session.getAttribute("cs55.usr") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("../logout.jsp");
} 

String type  = "MU";
String fdate = request.getParameter("fdate");
String empno   = request.getParameter("empno");
String fltno  = request.getParameter("fltno");
String sec  = request.getParameter("sec");
String dpt  = sec.substring(0,1);
String arv  = sec.substring(5);
String adjmins    = request.getParameter("adjmins");
String adjmins2    = request.getParameter("adjmins2");
if(adjmins2 == null | "".equals(adjmins2))
{
	adjmins2 = "0";
}
/*
if("".equals(adjmins)) adjmins = null;
if("".equals(rpttime)) rpttime = "";
if("".equals(sbtime)) sbtime = "";
*/
int hasItemCount = 0;
String sql = null;
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
Driver dbDriver = null;
ConnDB cn = new ConnDB();

try
{
	cn.setDFUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
	stmt = conn.createStatement();

	//先抓item是否重複
	//sql = "select count(*) as c from dftadjt where type ='"+ type+"' and fdate = '"+ fdate+"' and fltno = '"+fltno+"' and empno = '"+ empno+"' and sect = '"+sec+"'";		

	sql = "select count(*) as c from dftadjt where type ='"+type+"' and fdate = '"+ fdate+"' and empno = '"+ empno+"' ";	
	
	rs = stmt.executeQuery(sql);
	if (rs.next())
	{
		hasItemCount = rs.getInt("c");
	}

	if (hasItemCount>0)
	{
		//sql = "update dftadjt set adjmins = to_number("+adjmins+"), newid = '"+userid+"',newdt = sysdate where type ='"+ type+"' and fdate = '"+ fdate+"' and fltno = '"+fltno+"' and sect='"+sec+"' and empno = '"+ empno+"'"  ;

		sql = "update dftadjt set fltno = '"+fltno+"', sect = '"+sec+"', adjmins = to_number("+adjmins+"), adjmins2 = to_number("+adjmins2+"), newid = '"+userid+"',newdt = sysdate where type ='"+ type+"' and fdate = '"+ fdate+"' and empno = '"+ empno+"'"  ;

		//out.print(sql+"<BR>");
		stmt.executeUpdate(sql);
	%>
		<script language=javascript>
		alert("Update completed!!\n更新成功!!");
		location.replace("editAdjt.jsp");
		</script>
	<%

	}
	else
	{
		//sql = "insert into dftadjt (type,fdate,empno,sbtime,fltno,rpttime,adjmins,newid,newdt) values('"+type+"','"+fdate+"','"+empno+"','"+sbtime+"','"+fltno+"','"+rpttime+"',to_number("+adjmins+"),'"+userid+"',sysdate)"  ;

		sql = "insert into dftadjt (type,fdate,empno,fltno,sect,adjmins,newid,newdt,adjmins2) values('"+type+"','"+fdate+"','"+empno+"','"+fltno+"','"+sec+"',nvl(to_number("+adjmins+"),0),'"+userid+"',sysdate,nvl(to_number("+adjmins2+"),0))"  ;

		//out.print(sql+"<BR>");

		stmt.executeUpdate(sql);

	%>
		<script language=javascript>
		alert("Insert completed!!\n新增成功!!");
		location.replace("editAdjt.jsp");
		</script>
	<%
	}
	
}
catch(Exception e)
{
	out.print(e.toString());
}finally{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}					
%>
