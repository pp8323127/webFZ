<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*,java.util.*,java.io.*,ci.db.*,tool.ReplaceAll,java.util.ArrayList,java.net.URLEncoder" %>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("../logout.jsp");
}

String flsd  =   request.getParameter("sdate");
String fled  =   request.getParameter("edate");

String syy  =   flsd.substring(0,4);
String smm  =   flsd.substring(5,7);
String sdd  =   flsd.substring(8,10);

String eyy  =   fled.substring(0,4);
String emm  =   fled.substring(5,7);
String edd  =   fled.substring(8,10);

int count = 0;
int countCi = 1;
String bgColor=null;   

Connection conn   = null;

ArrayList ciItemNoAL   = new ArrayList();
ArrayList ciSubjectAL  = new ArrayList();

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
<title>SELF INSPCTION LIST REPORT EXCEL ITEM SELECT EDIT</title>
<link href ="../style.css" rel="stylesheet" type="text/css">
<script src="../js/CheckAll.js" language="javascript" type="text/javascript"></script>
<script language="JavaScript" type="text/JavaScript">

function checkAdd(){	
	count = 0;
	for (i=0; i<eval(document.form1.length); i++) {
		if (eval(document.form1.elements[i].checked)) count++;
	}
	if(count ==0 ) {
		alert("Please select the item you need!\n尚未勾選要需要的項目!!");
		return false;
	}
	else{
		return true;
	}
}


</script>
<style type="text/css">
<!--
.style5 {color: #FF0000; font-weight: bold; }
.style7 {
	color: #0000FF;
	font-weight: bold;
}
.style8 {color: #000000}
-->
</style>
</head>

<body>
<table width="90%"  border="0" align="center" cellpadding="2" cellspacing="0">
  <tr>
    <td>
      <div align="center"> <span class="fontbige_dblue">Select Item for</span><span class="txttitletop"> SELF INSPECTION LIST REPORT </span><span class="fontbige_dblue">EXCEL Report</span></div>
    </td>
  </tr>
</table>
<br>

<form action="expExcelSILRpt.jsp" method="post" name="form1" id="form1" onsubmit=" return checkAdd()">
<input name="flsd" type="Hidden" value="<%=flsd%>">
<input name="fled" type="Hidden" value="<%=fled%>">
<input name="syy" type="Hidden" value="<%=syy%>">
<input name="smm" type="Hidden" value="<%=smm%>">
<input name="sdd" type="Hidden" value="<%=sdd%>">
<input name="eyy" type="Hidden" value="<%=eyy%>">
<input name="emm" type="Hidden" value="<%=emm%>">
<input name="edd" type="Hidden" value="<%=edd%>">

<table width="70%"  border="1" align="center" cellpadding="1" cellspacing="1" class="fortable">
    <tr class="table_body">
      <td width="14%"><span class="style8">
        <input name="allchkbox" type="checkbox" onClick="CheckAll('form1','allchkbox')">
        <strong class="txtblue">Select</strong></span></td>
      <td width="11%"><div align="center" class="txtblue"><strong>IssueNo</strong></div></td>
      <td width="75%"><div align="center" class="txtblue"><strong>Issue</strong></div></td>
    </tr>
  	<%
  	sql = "select * from egtstci order by itemno";	
	rs = stmt.executeQuery(sql); 
	
	while(rs.next())
	{		
	  	ciItemNoAL.add(rs.getString("itemno"));
		ciSubjectAL.add(rs.getString("subject"));
	}
  
  	if(rs != null )
  	{
		for(int i=0;i<ciItemNoAL.size();i++)
		{
			if(i%2 ==0)
				bgColor="#FFFFFF";
			else
				bgColor="#CCCCCC";

  		%>
    	<tr bgcolor="<%=bgColor%>">
      		<td align="center" class="fortable"><input name="ciItemNo" type="checkbox" id="ciItemNo" value="<%=ciItemNoAL.get(i)%>"></td>
			<td align="center" class="txtblue" ><span class="style7"><%=ciItemNoAL.get(i) %></span></td>
    		<!-- <%=countCi%> -->
    		<td align="left" class="txtblue style8" >&nbsp;<%=ciSubjectAL.get(i)%></td>
    	</tr>
		<%
		countCi++;
		}
		
		
	}else
	{
		out.print("<tr bgcolor='#F2B9F1'><td colspan=3 class='table_head'><div align='center'>NO DATA !!</div></td>");
	}
	
	%>

</table>

<br>
	<div align="center">      
    	<input name="submit" type="submit" class="button1" value="Select" >
		&nbsp;&nbsp;&nbsp;
		<input name="reset" type="reset" class="button1" value="Reset">		
  </div>
	<p align="center" class="txtblue">Please select the <span class="style5"> Issue</span> you want to export.</p>
</form>
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