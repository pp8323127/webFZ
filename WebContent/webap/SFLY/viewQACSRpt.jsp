<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*,java.util.*,java.io.*,ci.db.*,tool.ReplaceAll,java.util.ArrayList" %>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("logout.jsp");
}

String flsd = request.getParameter("sdate");
String fled = request.getParameter("edate");

String syy = request.getParameter("syy");
String smm = request.getParameter("smm");
String sdd = request.getParameter("sdd");
String eyy = request.getParameter("eyy");
String emm = request.getParameter("emm");
String edd = request.getParameter("edd");

session.setAttribute("syy",syy);
session.setAttribute("smm",smm);
session.setAttribute("sdd",sdd);
session.setAttribute("eyy",eyy);
session.setAttribute("emm",emm);
session.setAttribute("edd",edd);

int count = 1;

String bgColor=null;   

Connection conn   = null;

ArrayList fltdAL   = new ArrayList();
ArrayList purnameAL  = new ArrayList();
ArrayList instnameAL  = new ArrayList();
ArrayList qaAL  = new ArrayList();
ArrayList commAL  = new ArrayList();

String sql = null;
ResultSet rs = null;
Statement stmt = null;

ConnDB cn = new ConnDB();
Driver dbDriver = null;

try
{
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
	stmt   = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);

%> 

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Report of QA & Comment and Suggestion for CABIN SAFETY CHECK LIST </title>
<link href ="style.css" rel="stylesheet" type="text/css">

<style type="text/css">
<!--
.style8 {color: #000000}
.style17 {font-size: 14}
.style31 {
	color: #339999;
	font-size: 16px;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-weight: bold;
}
-->
</style>
</head>

<body>
<table width="90%"  border="0" align="center" cellpadding="2" cellspacing="0">
  <tr>
    <td width="93%">
      <div align="center"> <span class="style31">Report of Q&amp;A 、Comment Suggestion for </span><span class="txttitletop">  CABIN SAFETY CHECK LIST </span></div>
    </td>
    <td><div align="right"><a href="javascript:window.print()"> <img src="images/print.gif" width="17" height="15" border="0" alt="列印"></a></td>
  </tr>
</table>

<table width="90%"  border="1" align="center" cellpadding="1" cellspacing="1" class="fortable">
    <tr class="tablehead3">
      <td width="5%"></td>
      <td width="11%"><span class="style17">Date</span></td>
      <td width="8%"><span class="style17">Purser</span></td>
      <td width="8%"><span class="style17">Inspector</span></td>
      <td width="34%"><span class="style17">Q&amp;A</span></td>
      <td width="34%"><span class="style17">Comment and Suggestion </span></td>
  </tr>
  	<%
  	sql = "select to_char(fltd,'yyyy/mm/dd') as fltd, purname, instname, "
	     +     "nvl(qa,'NIL') as qa, "
		 +     "nvl(comm, 'NIL') as comm "
		 + "from egtstti "
	     + "where fltd between to_date('"+flsd+"','yyyy/mm/dd') and to_date('"+fled+"','yyyy/mm/dd') " 
		 + "order by fltd";
	//out.print("sql="+sql+"<br>");	
	rs = stmt.executeQuery(sql); 
	
	while(rs.next())
	{		
	  	String qa = rs.getString("qa");
		String comm = rs.getString("comm");
		qa = ReplaceAll.replace(qa, "\r\n", "<br>"); 		//使用者可看到分行	
		comm = ReplaceAll.replace(comm, "\r\n", "<br>");		//使用者可看到分行	
		fltdAL.add(rs.getString("fltd"));
		purnameAL.add(rs.getString("purname"));
		instnameAL.add(rs.getString("instname"));
		qaAL.add(qa);
		commAL.add(comm);						
	}
  
  	if(fltdAL.size() != 0)
  	{
		for(int i=0;i<fltdAL.size();i++)
		{
			if(i%2 ==0)
				bgColor="#FFFFFF";
			else
				bgColor="#CCCCCC";		

  		%>
    	<tr bgcolor="<%=bgColor%>">
      		<td align="center" class="txtred"><div align="center"><strong><%=count%></strong></div></td>
      		<td align="center" class="txtblue"><div align="center" class="style8"><%=fltdAL.get(i)%></div></td>
   		  <td align="center" class="txtblue" ><div align="center" class="style8">&nbsp;<%=purnameAL.get(i)%></div></td>
   		  <td align="left" class="txtblue"  ><div align="center" class="style8">&nbsp;<%=instnameAL.get(i)%></div></td>
    	    <td align="left" class="txtblue style8" >&nbsp;<%=qaAL.get(i)%></td>
    	    <td align="left" class="txtblue style8" >&nbsp;<%=commAL.get(i)%></td>
    	</tr>
		<%
		count++;
		}

	}
	else
	{
		out.print("<tr bgcolor='#CC99FF'><td colspan=6 class='txtblue style8'><div align='center'><strong>NO DATA !!</strong></div></td>");
	}
	
	%>

</table>

<br>
<div align="center">&nbsp;&nbsp;&nbsp;</div>
	<p align="center" class="txtblue">&nbsp;</p>

</body>
</html>

<%
}
catch (Exception e)
{
	 out.print(e.toString());
}
finally
{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}						
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>