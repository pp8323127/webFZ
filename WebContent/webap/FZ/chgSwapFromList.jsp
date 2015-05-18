<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>申請單列表</title>
<link href="menu.css" rel="stylesheet" type="text/css">
<link href="kbd.css" rel="stylesheet" type="text/css">
</head>
<body>
<table width="700" border="1" cellpadding="0" cellspacing="0">
  <tr class="tablehead3">
	<td width="96" >Update Form </td> 
	<td width="76" >No</td>
	<td width="57" >Applicant</td>
	<td width="53" >Aname</td>
	<td width="55" >Replacer</td>
	<td width="52" >Rname</td>
	<td width="69" >ED_check</td>
	<td width="98" >Check Date</td>
	<td width="84" > ED <br>
	Comments </td>
	<td width="38" >Detail</td>
   </tr>
<%
String userid = (String)session.getAttribute("userid");
if(userid == null)
{
	response.sendRedirect("sendredirect.jsp");
}
else
{

String year = request.getParameter("year");
String month = request.getParameter("month");
String num = request.getParameter("num");

Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
String sql = null;
ConnDB cn = new ConnDB();
Driver dbDriver = null;

String formno = null;
String rCname = null;
String rEmpno = null;
String ed_check = null;
String comments = null;
String newdate= null;
String checkdate = null;
String chg_all = null;
String aEmpno	=null;
String aCname	= null;
String formtype	= null;

int rowCount = 0;
try
{
//User connection pool 

cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);


//直接連線 ORP3FZ
/*
cn.setORT1FZ();
java.lang.Class.forName(cn.getDriver());
conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),
	cn.getConnPW());
*/

stmt = conn.createStatement();

sql = "select formno,rcname,rempno, ed_check,comments,to_char(checkdate,'yyyy/mm/dd hh24:mi') checkdate,aempno,acname, 'A' formtype from fztform where formno='"+year+month+"'||lpad('"+num+"',4,'04') union all  select formno,rcname,rempno, ed_check,comments,to_char(checkdate,'yyyy/mm/dd hh24:mi') checkdate,aempno,acname, 'B' formtype from fztbform where formno='"+year+month+"'||lpad('"+num+"',4,'04') ";

//out.print(sql +"<br>");
rs = stmt.executeQuery(sql);
while(rs.next())
{
	formno= rs.getString("formno");
	rCname= rs.getString("rcname");
	rEmpno= rs.getString("rempno");
	ed_check= rs.getString("ed_check");
	comments= rs.getString("comments");
	checkdate= rs.getString("checkdate");
	aEmpno	= rs.getString("aempno");
	aCname	= rs.getString("acname");	
	formtype	= rs.getString("formtype");	
	rowCount++;
%>
  <tr>
	<form name="form1<%= formtype%>" action="chgSwapFrom.jsp" method="post" onsubmit="document.form1.sb.disabled=1;">
	<td class="tablebody"><input type="submit" class="kbd" value="更新申請單" name="sb">
	</td> 
	<td class="txtblue"><%= formtype%><%= formno%></td>
	<td class="txtblue"><%= aEmpno%></td>
	<td class="txtblue"><%= aCname %></td>
	<td class="txtblue"><%=rEmpno%></td>
	<td class="txtblue"><%=rCname%></td>
	<td class="txtblue"><%=ed_check%></td>
	<td class="txtblue"><%=checkdate%></td>
	<td class="txtblue"><%=comments%></td>
	<td> 
	<%
	if("A".equals(formtype))
	{	
	%>
		  <div align="center"><a href="swap3/showForm.jsp?formno=<%=formno%>" target="_blank"> 
			<img src="images/red.gif" width="15" height="15" border="0" alt="Detail"></a></div>
	<%
	}
	else
	{
	%>
		  <div align="center"><a href="credit/swaptpe/showBForm.jsp?formno=<%=formno%>" target="_blank"> 
			<img src="images/red.gif" width="15" height="15" border="0" alt="Detail"></a></div>
	<%
	}	
	%>
	</td>
  </tr>
	<input type="hidden" name="formno" value="<%=formno%>">
	<input type="hidden" name="aEmpno" value="<%=aEmpno%>">
	<input type="hidden" name="aCname" value="<%=aCname%>">
	<input type="hidden" name="rEmpno" value="<%=rEmpno%>">
	<input type="hidden" name="rCname" value="<%=rCname%>">			
	<input type="hidden" name="ed_check" value="<%=ed_check%>">		
	<input type="hidden" name="formtype" value="<%=formtype%>">	
  </form>

<%


}//end while

if(rowCount<=0)
{
%>
  <tr>
	<td class="tablebody" colspan="10">N/A</td> 
  </tr>
<%
}

}catch (SQLException e){
	  out.print(e.toString());
}catch (Exception e){
	  out.print(e.toString());
}finally{

	if (rs != null) try {rs.close();} catch (SQLException e) {}	
	if (stmt != null) try {stmt.close();} catch (SQLException e) {}
	if (conn != null) try { conn.close(); } catch (SQLException e) {}
}
}
%>
</table>
</body>
</html>
