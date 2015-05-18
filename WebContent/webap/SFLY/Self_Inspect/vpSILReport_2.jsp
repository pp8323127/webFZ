<%@page import="ws.prac.SFLY.MP.MPsflySelfCrewObj"%>
<%@page import="ws.prac.SFLY.MP.MPsflySelfCrew"%>
<%@page import="fz.psfly.PSFlySelfInsObj"%>
<%@page import="fz.psfly.PSFlySelfIns"%>
<%@page import="ws.prac.SFLY.MP.MPsflySelfInsObj"%>
<%@page import="org.apache.commons.collections.iterators.ArrayListIterator"%>
<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*,java.util.*,ci.db.*,tool.ReplaceAll" %>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("../logout.jsp");
}

			
String sernno	   = request.getParameter("sernno");
String allFltno   = null;
String fdate      = null;
String purserName = null;
String inspector  = null;
String fdate_y    = null;
String fdate_m    = null;
String fdate_d    = null;
StringBuffer sb = new StringBuffer();

PSFlySelfIns ins = new PSFlySelfIns();
ins.getSelfIns(sernno);
ArrayList objAL = new ArrayList();
objAL= ins.getObjAL();

Connection conn = null;
Statement stmt = null;
String sql = null;
ResultSet rs = null;
ConnDB cn = new ConnDB();
Driver dbDriver = null;

try
{
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt   = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
	
	sql = "select fltno, purname, instname, to_char(fltd,'yyyymmdd') as fltd, "+
	             "to_char(fltd,'yyyy') as fdate_y, to_char(fltd,'mm') as fdate_m, "+ 
				 "to_char(fltd,'dd') as fdate_d "+
		  "from egtstti where sernno = '"+ sernno+ "'";
	rs = stmt.executeQuery(sql); 
	while(rs.next())
	{

		allFltno = rs.getString("fltno");
		fdate = rs.getString("fltd");
		purserName = rs.getString("purname");
		inspector = rs.getString("instname");
		fdate_y = rs.getString("fdate_y");
		fdate_m = rs.getString("fdate_m");
		fdate_d = rs.getString("fdate_d");
	}

%>
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

<%
sb.append("<html>"+"\r\n");	
sb.append("<head>"+"\r\n");	
sb.append("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=big5\">"+"\r\n");	
sb.append("<title>Insert Self Inspection List Report</title>"+"\r\n");	
sb.append("<style type=\"text/css\">"+"\r\n");	
sb.append("<!--"+"\r\n");	
sb.append(".style1 {color: #000000}"+"\r\n");	
sb.append(".tablehead3 {"+"\r\n");	
sb.append("	font-family: \"Arial\", \"Helvetica\", \"sans-serif\";"+"\r\n");	
sb.append("background-color: #006699;"+"\r\n");	
sb.append("font-size: 10pt;"+"\r\n");	
sb.append("text-align: center;"+"\r\n");	
sb.append("font-style: normal;"+"\r\n");	
sb.append("font-weight: normal;"+"\r\n");	
sb.append("color: #FFFFFF;	"+"\r\n");	
sb.append("}"+"\r\n");	
sb.append(".txtblue {"+"\r\n");	
sb.append("	font-size: 12px;"+"\r\n");	
sb.append("	line-height: 13.5pt;"+"\r\n");	
sb.append("	color: #464883;"+"\r\n");	
sb.append("	font-family:  \"Verdana\";"+"\r\n");	
sb.append("}"+"\r\n");	
sb.append(".table_border2{	border: 1pt solid; border-collapse:collapse  }"+"\r\n");	
sb.append(".txttitletop {"+"\r\n");	
sb.append("	font-family:Verdana, Arial, Helvetica, sans-serif;"+"\r\n");	
sb.append("	font-size: 16px;"+"\r\n");	
sb.append("	line-height: 22px;"+"\r\n");	
sb.append("	color: #464883;"+"\r\n");	
sb.append("	font-weight: bold;"+"\r\n");	
sb.append("}"+"\r\n");	
sb.append(".style2 {line-height: 13.5pt; font-family: \"Verdana\"; font-size: 12px;}"+"\r\n");	
sb.append(".style3 {color: #FF0000}"+"\r\n");	
sb.append("-->"+"\r\n");	
sb.append("</style>"+"\r\n");	
sb.append("</head>"+"\r\n");	
%>
<body>
<br>
<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
 	<tr>
		<td width="20%">&nbsp;</td>
		<td width="60%"><div align="center" class="txttitletop"><span class="style14"><strong>Self Inspection List Report </strong></div></td>
 		<td width="20%"> 
		<div align="right"><a href="javascript:window.print()"> <img src="../images/print.gif" width="17" height="15" border="0" alt="¦C¦L">&nbsp;&nbsp;<input type="button" name="rep" id="rep" value="Download File" onClick="downreport();"></div></a> 
        </div></td>
  	</tr>
</table>
<table width="95%"  border="1" align="center" cellpadding="1" cellspacing="1" class="table_border2">        
	<tr class="txtblue">
	  	<td width="25%"><div align="left" class="style1">&nbsp;<span class="style3"><span class="style1"><strong>Date</strong>:</span><span class="style2"><%=fdate_y%></span><span class="style1"><strong>Y</strong></span><span class="style2">&nbsp;<%=fdate_m%>&nbsp;</span><span class="style1"><strong>M</strong></span><span class="style2"><%=fdate_d%>&nbsp;</span><span class="style1"><strong>D</strong></span></span></div></td>
    	<td width="25%"><div align="left" class="style3">&nbsp;<span class="style1"><strong>Flt</strong>:</span><span class="style2"><%=allFltno%> </span>¡@</div></td>
    	<td width="25%"><div align="left" class="style1">&nbsp;<span class="style3"><span class="style1"><strong>CM</strong>:</span><span class="style2"><%=purserName%></span></span></div></td>
    	<td width="25%"><div align="left" class="style3">&nbsp;<span class="style1"><strong>Inspector</strong>:</span><span class="style2"><%=inspector%></span></div></td>
  </tr> 
</table>
<table width="95%" border="1" align="center" cellpadding="1" cellspacing="1" class="table_border2">
  	<tr class="tablehead3">
   	   <td width="4%" align="center" valign="middle">&nbsp;</td>
   	   <td width="4%" align="center" valign="middle"><strong>No.</strong></td>
   	   <td width="26%" align="center" valign="middle"><strong>Issue</strong></td>
       <td width="9%" align="center" valign="middle"><strong>No.
   	   <br>Checked</strong></td>
   	   <td width="9%" align="center" valign="middle"><strong>Correctly<br>Answer/<br>Perform</strong></td>
       <td width="10%" align="center" valign="middle"><strong>Incorrectly<br>Answer/<br>Perform</strong></td>
       <td width="20%" align="center" valign="middle"><strong>Crew/Feedback</strong></td>		  
  	</tr>
<%
sb.append("<body>"+"\r\n");	
sb.append("<br>"+"\r\n");	
sb.append("<table width=\"95%\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">"+"\r\n");	
sb.append("<tr>"+"\r\n");	
sb.append("<td width=\"20%\">&nbsp;</td>"+"\r\n");	
sb.append("<td width=\"60%\"><div align=\"center\" class=\"txttitletop\"><span class=\"style14\"><strong>Self Inspection List Report </strong></div></td>"+"\r\n");	
sb.append("<td width=\"20%\"> "+"\r\n");	
sb.append("¡@</div></td>"+"\r\n");	
sb.append("</tr>"+"\r\n");	
sb.append("</table>"+"\r\n");	
sb.append("<table width=\"95%\"  border=\"1\" align=\"center\" cellpadding=\"1\" cellspacing=\"1\" class=\"table_border2\">"+"\r\n");	
sb.append("<tr class=\"txtblue\">"+"\r\n");	
sb.append("<td width=\"25%\"><div align=\"left\" class=\"style1\">&nbsp;<span class=\"style3\"><span class=\"style1\"><strong>Date</strong>:</span><span class=\"style2\">"+fdate_y+"</span><span class=\"style1\"><strong>Y</strong></span><span class=\"style2\">&nbsp;"+fdate_m+"&nbsp;</span><span class=\"style1\"><strong>M</strong></span><span class=\"style2\">"+fdate_d+"&nbsp;</span><span class=\"style1\"><strong>D</strong></span></span></div></td>"+"\r\n");	
sb.append("<td width=\"25%\"><div align=\"left\" class=\"style3\">&nbsp;<span class=\"style1\"><strong>Flt</strong>:</span><span class=\"style2\">"+allFltno+" </span>¡@</div></td>"+"\r\n");	
sb.append("<td width=\"25%\"><div align=\"left\" class=\"style1\">&nbsp;<span class=\"style3\"><span class=\"style1\"><strong>CM</strong>:</span><span class=\"style2\">"+purserName+"</span></span></div></td>"+"\r\n");	
sb.append("<td width=\"25%\"><div align=\"left\" class=\"style3\">&nbsp;<span class=\"style1\"><strong>Inspector</strong>:</span><span class=\"style2\">"+inspector+"</span></div></td>"+"\r\n");	
sb.append("</tr> "+"\r\n");	
sb.append("</table>"+"\r\n");	
sb.append("<table width=\"95%\" border=\"1\" align=\"center\" cellpadding=\"1\" cellspacing=\"1\" class=\"table_border2\">"+"\r\n");	
sb.append("<tr class=\"tablehead3\">"+"\r\n");	
sb.append("<td width=\"4%\" align=\"center\" valign=\"middle\">&nbsp;</td>"+"\r\n");	
sb.append("<td width=\"4%\" align=\"center\" valign=\"middle\"><strong>No.</strong></td>"+"\r\n");	
sb.append("<td width=\"26%\" align=\"center\" valign=\"middle\"><strong>Issue</strong></td>"+"\r\n");	
sb.append("<td width=\"9%\" align=\"center\" valign=\"middle\"><strong>No.<br>Checked</strong></td>"+"\r\n");	
sb.append("<td width=\"9%\" align=\"center\" valign=\"middle\"><strong>Correctly<br>Answer/<br>Perform</strong></td>"+"\r\n");	
sb.append("<td width=\"10%\" align=\"center\" valign=\"middle\"><strong>Incorrectly<br>Answer/<br>Perform</strong></td>"+"\r\n");	
sb.append("<td width=\"20%\" align=\"center\" valign=\"middle\"><strong>Crew/Feedback</strong></td>"+"\r\n");		
sb.append("</tr>"+"\r\n");	

if(objAL!=null && objAL.size() > 0){
	for(int i=0;i<objAL.size();i++){
		PSFlySelfInsObj obj = (PSFlySelfInsObj) objAL.get(i);
		%>
	  	<tr class="txtblue">
	    	<td align="center" class="txtred" ><span class="style3"><strong><%=i+1%></strong></span></td>
	    	<td align="center" ><span class="style1"><%=obj.getItemno()%></span></td>
	    	<td align="left" ><span class="style1"><%=obj.getSubject()%></span></td>
	    	<td align="center" ><span class="style1"><%=obj.getTcrew()%></span></td>
	    	<td align="center" ><span class="style1"><%=obj.getCorrect()%></span></td>
	    	<td align="center" ><span class="style1"><%=obj.getIncomplete()%></span></td>
	    	<td align="left" ><span class="style1">
	    	<%
sb.append("<tr class=\"txtblue\">"+"\r\n");
sb.append("<td align=\"center\" class=\"txtred\" ><span class=\"style3\"><strong>"+(i+1)+"</strong></span></td>"+"\r\n");
sb.append("<td align=\"center\" ><span class=\"style1\">"+obj.getItemno()+"</span></td>"+"\r\n");
sb.append("<td align=\"left\" ><span class=\"style1\">"+obj.getSubject()+"</span></td>"+"\r\n");
sb.append("<td align=\"center\" ><span class=\"style1\">"+obj.getTcrew()+"</span></td>"+"\r\n");
sb.append("<td align=\"center\" ><span class=\"style1\">"+obj.getCorrect()+"</span></td>"+"\r\n");
sb.append("<td align=\"center\" ><span class=\"style1\">"+obj.getIncomplete()+"</span></td>"+"\r\n");
sb.append("<td align=\"left\" ><span class=\"style1\">\r\n");  
		    if(null != obj.getCrew()){	
	    		for(int j=0;j<obj.getCrew().length;j++){
	    		MPsflySelfCrewObj objc = obj.getCrew()[j];
	    	%>
	    	<%=objc.getEmpno()%>:<%=objc.getCrew_comm()%><br>	
	    	<%
sb.append(objc.getEmpno()+":"+objc.getCrew_comm()+"<br>\r\n");
	    		}	  
	    	}
	    	%>
	    	</span></td>
	 	 </tr>
<%
sb.append("</span></td>"+"\r\n");	  
sb.append("</tr>"+"\r\n");	  	
	}
}
%>
</table>
<%
sb.append("</table>"+"\r\n");
%>
<%
}
catch(Exception e){
	out.print(e.toString());
}
finally{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>    
</p>
</body>
</html>
<script language="javascript" type="text/javascript">
function downreport()
{
	location.replace("viewSIL_download.jsp");
}
</script>

<%
sb.append("</p>"+"\r\n");
sb.append("</body>"+"\r\n");
sb.append("</html>"+"\r\n");
session.setAttribute("sb",sb);
%>
