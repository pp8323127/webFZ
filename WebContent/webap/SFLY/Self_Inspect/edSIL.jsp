<%@page import="fz.psfly.isNewCheckForSFLY"%>
<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*,java.util.*,ci.db.*,tool.ReplaceAll,java.util.ArrayList,java.net.URLEncoder" %>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("../logout.jsp");
}

String sernno	= request.getParameter("sernno");
String fltno	= request.getParameter("fltno");
String fltd	    = request.getParameter("fltd");

boolean hasRecord = false;
String sysdate    = null;
String allFltno   = null;
String fdate      = null;
String purserName = null;
String inspector  = null;
String fdate_y    = null;
String fdate_m    = null;
String fdate_d    = null;
String trip = null;

int count = 0;
int countCi = 0;   
Connection conn   = null;

List ciItemNoAL   = new ArrayList();
List ciSubjectAL  = new ArrayList();
List ccItemNoAL   = new ArrayList();
List ccSubjectAL  = new ArrayList();

String sql = null;
ResultSet rs = null;
Statement stmt = null;
String sql2 = null;
ResultSet rs2 = null;
String sql3 = null;
ResultSet rs3 = null;
String sql4 = null;
ResultSet rs4 = null;
String sql5 = null;
ResultSet rs5 = null;

ConnDB cn = new ConnDB();
Driver dbDriver = null;

try
{
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
	stmt   = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);

	sql = "select To_Char(SYSDATE, 'mm/dd/yy') AS rundate, fltno ,trip , purname, instname, to_char(fltd,'yyyymmdd') as fltd, to_char(fltd,'yyyy') as fdate_y, to_char(fltd,'mm') as fdate_m, to_char(fltd,'dd') as fdate_d from egtstti where sernno = '"+ sernno+ "'";
	rs = stmt.executeQuery(sql); 
	while(rs.next())
	{
		sysdate = rs.getString("rundate");
		allFltno = rs.getString("fltno");
		fdate = rs.getString("fltd");
		trip = rs.getString("trip");
		purserName = rs.getString("purname");
		inspector = rs.getString("instname");
		fdate_y = rs.getString("fdate_y");
		fdate_m = rs.getString("fdate_m");
		fdate_d = rs.getString("fdate_d");
	}
	
	sql2 = "select cc.sernno, cc.itemno "+
	       "from egtstcc cc, egtstci ci "+
		   "where cc.sernno ='"+ sernno+ "' and cc.itemno=ci.itemno ";

          //out.print("sql2="+sql2+"<br>");
    rs2 = stmt.executeQuery(sql2);
	
	if(rs2.next()){
		rs2.last();
		count = rs2.getRow();//取得筆數
		rs2.beforeFirst();
	}

if(count >0){
	hasRecord = true;
	
}
//out.print("hasRecord="+hasRecord+"<br>");
isNewCheckForSFLY check = new isNewCheckForSFLY();
boolean isNew = check.checkTime("", "");//yyyy/mm/dd
%> 

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>自我督察報告事項編輯</title>
<link href="../style.css" rel="stylesheet" type="text/css">
<script src="../js/checkDel.js" type="text/javascript"></script>
<script src="../js/CheckAll.js" language="javascript" type="text/javascript"></script>
<script src="../js/subWindow.js" language="javascript" type="text/javascript"></script>
<script language="JavaScript" type="text/JavaScript">

function checkAdd(){	
	count = 0;
	for (i=0; i<eval(document.form2.length); i++) {
		if (eval(document.form2.elements[i].checked)) count++;
	}
	if(count ==0 ) {
		alert("Please select the issue you need! \n尚未勾選要需要的項目!!");
		return false;
	}
	else{
				return true;
	}
}

function editReport(){
	var isNew = <%=isNew%>;
	if(isNew){
		document.form1.action="insSILReport_2.jsp";
	}else{
		document.form1.action="insSILReport.jsp";
	}
	document.form1.submit();

}
	
</script>
<style type="text/css">
<!--
.style3 {color: #FF0000}
.style4 {color: #0000FF}
.style5 {color: #000000}
.style6 {line-height: 13.5pt; font-family: "Verdana"; font-size: 12px;}
-->
</style>
</head>

<body>
<form name="form1" onSubmit="return checkDel('form1');" action="delCcItem.jsp">
<table width="90%"  border="0" align="center" cellpadding="2" cellspacing="0">
  <tr>
    <td>
      <div align="center"><span class="txttitletop">Self Inspection List </span></div>
    </td>
  </tr>
</table>
<table width="90%"  border="1" align="center" cellpadding="1" cellspacing="1" class="table_border2">        
	<tr class="txtblue">
	  <td width="25%"><div align="left" class="style3">&nbsp;<span class="style5"><strong>Date</strong>:</span><span class="style6"><%=fdate_y%></span><span class="style5"><strong>Y</strong></span><span class="style6">&nbsp;<%=fdate_m%>&nbsp;</span><span class="style5"><strong>M</strong></span><span class="style6">&nbsp;<%=fdate_d%></span><span class="style5"><strong>D</strong></span></div></td>
    	<td width="25%"><div align="left" class="style3">&nbsp;<span class="style5"><strong>Flt</strong>:</span><span class="style6"><%=allFltno%> 　</span></div></td>
    	<td width="25%"><div align="left" class="style3">&nbsp;<span class="style5"><strong>CM</strong>:</span><span class="style6"><%=purserName%></span></div></td>
    	<td width="25%"><div align="left" class="style3">&nbsp;<span class="style5"><strong>Inspector</strong>:</span><span class="style6"><%=inspector%></span></div></td>
  	</tr> 
</table>
<%
//有資料才show
if(hasRecord){
%>

<table width="90%" border="1" align="center" cellpadding="1" cellspacing="1" class="table_border2">
  	<tr class="tablehead3">
      <td width="11%"><div align="center">
        <input name="allchkbox" type="checkbox" onClick="CheckAll('form1','allchkbox')"> 
      <strong>Select</strong></div></td>
   	   <td width="10%" align="center" valign="middle"><strong>No.</strong></td>
   	   <td width="79%" align="center" valign="middle"><strong>Issue</strong></td>

    </tr>
  	<%
  	sql3 = "select cc.itemno as itemno, ci.subject as subject "+
	       "from egtstcc cc, egtstci ci "+
		   "where cc.sernno='"+ sernno+ "' and cc.itemno=ci.itemno "+
		   "order by cc.itemno";
    //out.print("SQL3="+sql3+"<br>");		   
  	rs3 = stmt.executeQuery(sql3); 

  	while(rs3.next())
	{		
		ccItemNoAL.add(rs3.getString("itemno"));
	  	ccSubjectAL.add(rs3.getString("subject"));	
	}
	
	for(int j=0;j<ccItemNoAL.size();j++)
	{		
    %>
  	<tr>
    	<td align="center" ><input name="delItemNo" type="checkbox" id="delItemNo" value="<%=ccItemNoAL.get(j)%>"></td>
    	<td align="center" class="txtblue" ><a href="#" class="style4" onClick="subwin('modIssue.jsp?issueNo=<%=ccItemNoAL.get(j)%>','SIL_issue')"><%=ccItemNoAL.get(j)%></a></td>
    	<td align="left" class="txtblue style5" ><%=ccSubjectAL.get(j)%></td>
   	</tr>
    <%
	}
	%>  
	  	<tr>
		<td colspan="8"><div align="center">
           	<input name="Submit" type="submit" class="delButon" value="Delete Selected" >
			&nbsp;&nbsp;&nbsp;
			<input name="EditReport" type="button" class="addButton" value="Next" onClick="return editReport()">		
			<br>
			<span class="txtred"><strong>*Click Item to Edit the Issue <br>
			<span class="txtred"><strong>*Click&nbsp;</strong></span></strong></span><span class="style3"><strong class="tablebody ">Next</strong></span></span><span class="txtred"><strong><span class="txtred"><strong>&nbsp;Button to edit the report.</strong></span></strong></span></div>
			<span class="txtred">
		   	</div>
		   	<input type="hidden" name="sernno" value="<%=sernno%>">
		   	<input type="hidden" name="fltno" value="<%=fltno%>">	
			<input type="hidden" name="fltd" value="<%=fltd%>">
		    <input type="hidden" name="userid" value="<%=userid%>">	
		    <input type="hidden" name="sysdate" value="<%=sysdate%>">
		    <input type="hidden" name="fdate_y" value="<%=fdate_y%>"> 
		    <input type="hidden" name="fdate_m" value="<%=fdate_m%>"> 
		    <input type="hidden" name="fdate_d" value="<%=fdate_d%>"> 	
		   	<input type="hidden" name="allFltno" value="<%=allFltno%>">									
		    <input type="hidden" name="purserName" value="<%=purserName%>"> 	
		   	<input type="hidden" name="inspector" value="<%=inspector%>">		
		   	<input type="hidden" name="sect" value="<%=trip%>">						
		    </span>				
	 	</td>
    </tr> 
</table>

<%
} //End of if have record 

%>
</form>

<hr  width="90%" noshade>

<form name="form2" method="post" action="upSIL.jsp" onsubmit="return checkAdd()">
<table width="90%"  border="1" align="center" cellpadding="1" cellspacing="1" class="table_border2">
    <tr class="tablehead3 fortable">
      <td width="11%"><div align="center">
        <input name="allchkbox" type="checkbox" onClick="CheckAll('form2','allchkbox')"> 
      <strong>Select</strong></div></td>
      <td width="10%"><div align="center"><strong>No</strong></div></td>
      <td width="79%"><div align="center"><strong>Issue</strong></div></td>
    </tr>
  	<%
  	sql4 = "select itemno, subject from egtstci where itemno not in (select itemno from egtstcc where sernno='"+ sernno+"') and flag = 'Y' order by itemno";	
  	//sql4 = "select itemno, subject from egtstci order by itemno";
	rs4 = stmt.executeQuery(sql4); 

	
	while(rs4.next())
	{		
		ciItemNoAL.add(rs4.getString("itemno"));
	  	ciSubjectAL.add(rs4.getString("subject"));
	}
  
  	if(rs4 != null )
  	{
		for(int i=0;i<ciItemNoAL.size();i++)
		{

  		%>
    	<tr class="fortable">
      		<td align="center" class="fortable">		  <input name="addItemNo" type="checkbox" id="addItemNo" value="<%=ciItemNoAL.get(i)%>"></td>
    		<td align="center" class="txtblue style5" ><%=ciItemNoAL.get(i)%></td>
    		<td align="left" class="txtblue style5" ><%=ciSubjectAL.get(i)%></td>
    	</tr>
	
		<%
		}
	}else
	{
			out.print("NO DATA!!");
	}
	%>

</table>
<%
sql5="select count(*) count from (select * from egtstci where itemno not in (select itemno from egtstcc where sernno='"+ sernno+"')) ";	
//out.print("SQL5="+sql5+"<br>");		
rs5 = stmt.executeQuery(sql5);
while(rs5.next())
{
	countCi= Integer.parseInt(rs5.getString("count")); 
	//out.print("countCi="+countCi+"<br>");
}
if (countCi>0)
{
%>
	<div align="center">      
    	<input name="submit" type="submit" value="Select" >
		&nbsp;&nbsp;&nbsp;
		<input name="reset" type="reset" value="Reset">		

	</div>
		<%
}
else{}
%><br>
		<div align="center" class="txtblue"><span class="txtred"><strong>Step1.</strong></span><strong> Select the issue you need.</strong></div>
		<div align="center" class="txtblue"><span class="txtred"><strong>Step2. </strong></span><strong>Click <u>Next</u> Button to edit the report.</strong></div>
						<br>
	    <input type="hidden" name="sernno" value="<%=sernno%>">	
	    <input type="hidden" name="fltno" value="<%=fltno%>">	
	    <input type="hidden" name="fltd" value="<%=fltd%>">		
	    <input type="hidden" name="userid" value="<%=userid%>">	
	    <input type="hidden" name="sysdate" value="<%=sysdate%>"> 
  </div>

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
	try{if(rs2 != null) rs2.close();}catch(SQLException e){}
	try{if(rs3 != null) rs3.close();}catch(SQLException e){}	
	try{if(rs4 != null) rs4.close();}catch(SQLException e){}	
	try{if(rs5 != null) rs5.close();}catch(SQLException e){}	
	try{if(stmt != null) stmt.close();}catch(SQLException e){}						
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>