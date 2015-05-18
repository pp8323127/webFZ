<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*,java.util.*,ci.db.*,tool.ReplaceAll,java.util.ArrayList" %>
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
String sysdate    = null;

String ciItemno = null;
String ciSubject = null;
String ccTcrew          = null;
String ccCorrect        = null;
String ccIncomplete     = null;
String ccCrew_comm      = null;
String ccAcomm          = null;
String ccItemnoRm       = null;
String ccCrew_comm_show = null;
String ccAcomm_show     = null;

int count=1;

Connection conn = null;
Statement stmt = null;
Statement stmtRm= null;

String sql = null;
ResultSet rs = null;
String sql2 = null;
ResultSet rs2 = null;
String sqlRm = null;
ResultSet rsRm = null;

String rmNo = null;
String rmDsc = null;


ConnDB cn = new ConnDB();
Driver dbDriver = null;

try
{
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt   = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
stmtRm   = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
	
	sql = "select fltno, purname, instname, to_char(fltd,'yyyymmdd') as fltd, "+
	             "to_char(fltd,'yyyy') as fdate_y, to_char(fltd,'mm') as fdate_m, "+ 
				 "to_char(fltd,'dd') as fdate_d , To_Char(SYSDATE, 'mm/dd/yy') AS rundate "+
		  "from egtstti where sernno = '"+ sernno+ "'";
		  //out.print("sql="+sql+"<br>");
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
		sysdate = rs.getString("rundate");
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Modify Self Inspection List Report</title>
<link href ="../style.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style1 {color: #FF0000}
.style3 {color: #000000}
-->
</style>
</head>

<body>

<br>
<form name="form1" method="post" action="mdSILReportSave.jsp" onSubmit="">
<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
 	<tr>
		<td width="20%">&nbsp;</td>
		<td width="60%"><div align="center" class="txttitletop"><span class="style14">
			<strong>Self Inspection List Report <span class="style1">
			<MARQUEE BEHAVIOR=ALTERNATE>(Modify)</MARQUEE>
			</span></strong></div></td>
 		<td width="20%">&nbsp;</td>
  	</tr>
</table>

<table width="95%"  border="1" align="center" cellpadding="1" cellspacing="1" class="fortable">        
	<tr class="txtblue">
	  	<td width="25%"><div align="left" class="style1">&nbsp;<span class="style3"><strong>Date</strong>:</span><span class="txtred"><%=fdate_y%>&nbsp;</span><span class="style3"><strong>Y</strong></span><span class="txtred">&nbsp;<%=fdate_m%>&nbsp;</span><span class="style3"><strong>M</strong></span><span class="txtred">&nbsp;<%=fdate_d%>&nbsp;</span><span class="style3"><strong>D</strong></span></div></td>
    	<td width="25%"><div align="left" class="style1">&nbsp;<span class="style3"><strong>Flt</strong>:</span><span class="txtred"><%=allFltno%> </span>　</div></td>
    	<td width="25%"><div align="left" class="style1">&nbsp;<span class="style3"><strong>CM</strong>:</span><span class="txtred"><%=purserName%></span></div></td>
    	<td width="25%"><div align="left" class="style1">&nbsp;<span class="style3"><strong>Inspector</strong>:</span><span class="txtred"><%=inspector%></span></div></td>
  	</tr> 
</table>

<table width="95%" border="1" align="center" cellpadding="1" cellspacing="1" class="fortable">
  	<tr class="tablehead3">
   	   <td width="4%" align="center" valign="middle">&nbsp;</td>
   	   <td width="4%" align="center" valign="middle"><strong>No.</strong></td>
   	   <td  align="center" valign="middle"><strong>Issue</strong></td>
       <td width="9%" align="center" valign="middle"><strong>No.
   	   <br>Checked</strong></td>
   	   <td width="9%" align="center" valign="middle"><strong>Correctly<br>Answer/<br>Perform</strong></td>
       <td width="10%" align="center" valign="middle"><strong>Incorrectly<br>Answer/<br>Perform</strong></td>
       <td width="11%" align="center" valign="middle"><strong>Crew</strong></td>
       <td width="15%" align="center" valign="middle"><strong>Feedback</strong></td>		  
  	   <td width="6%" align="center" valign="middle"><strong>Attribute</strong></td>
  	</tr>
  	<%
	/*可以看到自己的
  	sql2 = "select ci.itemno as itemno, ci.subject as subject, "+
			       "NVL(cc.tcrew, 0) as tcrew, NVL(cc.correct, 0) as correct, NVL(cc.incomplete, 0) as incomplete, "+
				   "NVL(cc.crew_comm, '　') as crew_comm, NVL(cc.acomm, '　') as acomm  "+
	      "from egtstcc cc, egtstci ci "+
		  "where cc.sernno='"+sernno+"' and upduser='"+userid+"' and cc.itemno=ci.itemno "+
		  "order by ci.itemno ";
	*/
	
	//可以看到別人的
  	sql2 = "select ci.itemno as itemno, ci.subject as subject, "+
			       "NVL(cc.tcrew, 0) as tcrew, NVL(cc.correct, 0) as correct, NVL(cc.incomplete, 0) as incomplete, "+
				   "NVL(cc.crew_comm, '　') as crew_comm, NVL(cc.acomm, '　') as acomm , cc.itemno_rm "+
	      "from egtstcc cc, egtstci ci "+
		  "where cc.sernno='"+sernno+"' and cc.itemno=ci.itemno "+
		  "order by ci.itemno ";		  
    //out.print("sql="+sql+"<br>");		  
  	rs2 = stmt.executeQuery(sql2); 
	
 	while(rs2.next())
	{		
		ciItemno = rs2.getString("itemno");
	  	ciSubject = rs2.getString("subject");
		ccTcrew = rs2.getString("tcrew");
		ccCorrect = rs2.getString("correct");
		ccIncomplete = rs2.getString("incomplete");
		ccCrew_comm = rs2.getString("crew_comm");
		ccAcomm = rs2.getString("acomm");
		ccItemnoRm = rs2.getString("itemno_rm");
				
		//使用者可看到分行	
       /* 
        ccCrew_comm = ReplaceAll.replace(ccCrew_comm, "\r\n", "<br>"); 
		ccAcomm = ReplaceAll.replace(ccAcomm, "\r\n", "<br>");
		*/
  	%>
  	<tr>
    	<td align="center" class="txtred" ><strong><%=count%></strong></td>
    	<td align="center" class="txtblue style3"><%=ciItemno%></td>
    	<td align="left" class="txtblue style3" ><%=ciSubject%></td>
    	<td align="center" ><input name="<%=ciItemno%>tcrew" type="text" id="tcrew" value="<%=ccTcrew%>" size="2"></td>
    	<td align="center" ><input name="<%=ciItemno%>correct" type="text" id="correct" value="<%=ccCorrect%>" size="2" maxlength="2"></td>
    	<td align="center" ><input name="<%=ciItemno%>incomplete" type="text" id="incorrect" value="<%=ccIncomplete%>" size="2" maxlength="2"></td>
    	<td align="center" ><textarea name="<%=ciItemno%>crew_comm" cols="10%" id="crewComm"><%=ccCrew_comm%></textarea></td>
    	<td align="left" ><textarea name="<%=ciItemno%>acomm" cols="15%" id="acomm"><%=ccAcomm%></textarea></td>
 	    <td align="left" ><div align="left"><span class="style3">
 	      <select name="<%=ciItemno%>rm" id="<%=ciItemno%>rm">
            <%
				sqlRm = "select * from egtstrm order by itemno ";
				rsRm = stmtRm.executeQuery(sqlRm);
				
				if (rsRm != null)
			  	{
					while (rsRm.next())
				   	{ 
					 	rmNo = rsRm.getString("itemno");
						rmDsc = rsRm.getString("itemdsc");
						 
			%>
            <option value="<%=rmNo%>" <%=((rmNo.toString().equals(ccItemnoRm))?"SELECTED":"")%>><%=rmDsc%></option>
            <%
					}
				}
			%>
          </select>
 	    </span></div>
		</td>
  	</tr>
	<%
		count++ ; 
   }

   %>
  	<tr>
		<td colspan="9"><div align="center">
    		<input type="submit" name="Submit" value="Submit">　　
    		<input type="reset" name="Reset" value="Reset"></div>
	 	</td>
   </tr>
</table>

	<input name="sernno" type="hidden" value="<%=sernno%>">
    <input name="itemno" type="Hidden" value="<%=ciItemno%>">
    <input name="upduser" type="Hidden" value="<%=userid%>">
    <input name="upddate" type="Hidden" value="<%=sysdate%>">	  
</form>
<%
}
catch(Exception e){
	out.print(e.toString());
}
finally{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(rs2 != null) rs2.close();}catch(SQLException e){}
	try{if(rsRm != null) rsRm.close();}catch(SQLException e){}	
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(stmtRm != null) stmtRm.close();}catch(SQLException e){}	
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>
    
</p>

</body>
</html>
