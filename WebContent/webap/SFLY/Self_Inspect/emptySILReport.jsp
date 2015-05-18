<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*,java.util.*,ci.db.* " %>
<%
/*
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("../logout.jsp");
}
*/
			
String fdate_y  =   request.getParameter("fdate_y");
String fdate_m  =   request.getParameter("fdate_m");
String fdate_d  =   request.getParameter("fdate_d");
String allFltno =	request.getParameter("allFltno");
String purserName	= request.getParameter("purserName");
String inspector	= request.getParameter("inspector");

String ciItemno         = null;
String ciSubject        = null;

int count=1;

Connection conn = null;
Statement stmt = null;

String sql2 = null;
ResultSet rs2 = null;

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
<title>Insert Self Inspection List Report</title>
<link href="../style.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style1 {color: #000000}
.style2 {line-height: 13.5pt; font-family: "Verdana"; font-size: 12px;}
.style3 {color: #FF0000}
-->
</style>
</head>

<body>

<br>
<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
 	<tr>
		<td width="20%">&nbsp;</td>
		<td width="60%"><div align="center" class="txttitletop"><span class="style14"><strong>Self Inspection List Report </strong></div></td>
 		<td width="20%"> 
		<div align="right"><a href="javascript:window.print()"> <img src="../images/print.gif" width="17" height="15" border="0" alt="列印"></a> 
        　</div></td>
  	</tr>
</table>
<table width="95%"  border="1" align="center" cellpadding="1" cellspacing="1" class="fortable">        
	<tr class="txtblue">
	  	<td width="25%"><div align="left" class="style1">&nbsp;<span class="style3"><span class="style1"><strong>Date</strong>:</span><span class="style2"><%=fdate_y%></span><span class="style1"><strong>Y</strong></span><span class="style2">&nbsp;<%=fdate_m%>&nbsp;</span><span class="style1"><strong>M</strong></span><span class="style2"><%=fdate_d%>&nbsp;</span><span class="style1"><strong>D</strong></span></span></div></td>
    	<td width="25%"><div align="left" class="style3">&nbsp;<span class="style1"><strong>Flt</strong>:</span><span class="style2"><%=allFltno%> </span>　</div></td>
    	<td width="25%"><div align="left" class="style1">&nbsp;<span class="style3"><span class="style1"><strong>Purser</strong>:</span><span class="style2"><%=purserName%></span></span></div></td>
    	<td width="25%"><div align="left" class="style3">&nbsp;<span class="style1"><strong>Inspector</strong>:</span><span class="style2"><%=inspector%></span></div></td>
  </tr> 
</table>
<table width="95%" border="1" align="center" cellpadding="1" cellspacing="1" class="fortable">
  	<tr class="tablehead3">
   	   <td width="4%" align="center" valign="middle">&nbsp;</td>
   	   <td width="4%" align="center" valign="middle"><strong>No.</strong></td>
   	   <td width="26%" align="center" valign="middle"><strong>Issue</strong></td>
       <td width="9%" align="center" valign="middle"><strong>No.
   	   <br>Checked</strong></td>
   	   <td width="9%" align="center" valign="middle"><strong>Correctly<br>Answer/<br>Perform</strong></td>
       <td width="10%" align="center" valign="middle"><strong>Incorrectly<br>Answer/<br>Perform</strong></td>
       <td width="11%" align="center" valign="middle"><strong>Crew</strong></td>
       <td width="27%" align="center" valign="middle"><strong>Feedback</strong></td>		  
  	</tr>
  	<%
	
	//可以看到所有的SIL
  	sql2 = "select * from egtstci order by itemno ";
  
    //out.print("sql2="+sql2+"<br>");		  
  	rs2 = stmt.executeQuery(sql2); 
 	while(rs2.next())
	{		
		ciItemno = rs2.getString("itemno");
	  	ciSubject = rs2.getString("subject");		 
		
  	%>
  	<tr class="txtblue">
    	<td align="center" class="txtred" ><span class="style3"><strong><%=count%></strong></span></td>
    	<td align="center" ><span class="style1"><%=ciItemno%></span></td>
    	<td align="left" ><span class="style1"><%=ciSubject%></span></td>
    	<td align="center" >&nbsp;</td>
    	<td align="center" >&nbsp;</td>
    	<td align="center" >&nbsp;</td>
    	<td align="center" >&nbsp;</td>
    	<td align="left" >&nbsp;</td>

  </tr>
	<%
		count++ ; 
    }
   %>
</table>
<%
}
catch(Exception e){
	out.print(e.toString());
}
finally{
	try{if(rs2 != null) rs2.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>
    
</p>

</body>
</html>
