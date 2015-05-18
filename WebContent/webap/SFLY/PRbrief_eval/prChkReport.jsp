<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*,java.util.*,ci.db.*,tool.ReplaceAll, eg.prfe.*" %>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (sGetUsr == null) 
{		
	response.sendRedirect("../FZ/sendredirect.jsp");
}

			
String sernno	   = request.getParameter("sernno");
String allFltno   = null;
String purserName = null;
String inspector  = null;
String fdate_y    = null;
String fdate_m    = null;
String fdate_d    = null;
String ciItemno         = null;
String ciSubject        = null;
String ccTcrew          = null;
String ccCorrect        = null;
String ccIncomplete     = null;
String ccCrew_comm      = null;
String ccAcomm          = null;
String sysdate    = null;
String score	  = "0.00";
String sector   =	null;
String fdate	=	null;
String fleet	=	null; 
String acno		=	null;
String qa		=   null;
String comm     =   null;
String process  = null;
String qa_show = null; 
String comm_show =null; 
String process_show = null;
String siNo = null;
String fiNo = null;
String siDsc = null;
String fiDsc = null;
int subcount=1;
int count=1;
int countCi = 0;
Connection conn = null;
Statement stmt = null;
Statement stmt2 = null;
Statement stmt3 = null;
Statement stmt4 = null;

ResultSet rs = null;
ResultSet rs2 = null;
ResultSet rs3 = null;
ResultSet rs4 = null;

String sql = null;
String sql2 = null;
String sql3 = null;
String sql4 = null;

String check0 = null;
String check1 = null;
String check2 = null;
String checked = null;
String remark = null;
String lsflag = null;

Driver dbDriver = null;
ConnDB cn = new ConnDB();
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
.style3 {color: #000000}
.txtblue {
	font-size: 12px;
	line-height: 13.5pt;
	color: #464883;
	font-family:  "Verdana";
}
.txtred {
	font-size: 12px;
	line-height: 13.5pt;
	color: red;
	font-family:  "Verdana";
}
.fortable{
	border: 1pt solid;
 }
 .table_border2{	border: 1pt solid; border-collapse:collapse  }

.tablehead3 {
	font-family: "Arial", "Helvetica", "sans-serif";
	background-color: #006699;
	font-size: 10pt;
	text-align: center;
	font-style: normal;
	font-weight: normal;
	color: #FFFFFF;	
}
.style6 {font-size: 12px; font-weight: bold; }
.style23 {color: #FF0000}
.style24 {color: #000000}
.style25 {color: #000000; font-size: 12px; }
-->
</style>
</head>
<body>
<%
fdate_y  =   null;
fdate_m  =   null;
fdate_d  =   null;
allFltno =	null;
sector   =	null;
fdate	=	null;
fleet	=	null; 
acno		=	null;
purserName	= null;
inspector	= null;
qa		=   null;
comm     =   null;
process  = null;
qa_show = null; 
comm_show =null; 
process_show = null;

siNo = null;
fiNo = null;
siDsc = null;
fiDsc = null;
subcount=1;
count=1;


conn = null;
stmt = null;
stmt2 = null;
stmt3 = null;
stmt4 = null;

rs = null;
rs2 = null;
rs3 = null;
rs4 = null;

sql = null;
sql2 = null;
sql3 = null;
sql4 = null;

check0 = null;
check1 = null;
check2 = null;
checked = null;
remark = null;
lsflag = null;

cn = new ConnDB();
dbDriver = null;
try
{
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);

stmt   = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
stmt2  = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
stmt3  = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
stmt4  = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);

sql = "select fltno, trip, fleet, acno, purname, instname, to_char(fltd,'yyyymmdd') as fltd, to_char(fltd,'yyyy') as fdate_y, to_char(fltd,'mm') as fdate_m, to_char(fltd,'dd') as fdate_d, NVL(qa, '　') qa, NVL(comm, '　') comm, NVL(process, '　') process from egtstti where sernno = '"+ sernno+ "'";

rs = stmt.executeQuery(sql); 
while(rs.next())
{
	 	allFltno = rs.getString("fltno");
		sector = rs.getString("trip");
		fdate = rs.getString("fltd");
	 	fleet = rs.getString("fleet");
		acno = rs.getString("acno");
		purserName = rs.getString("purname");
	 	inspector = rs.getString("instname");
		fdate_y = rs.getString("fdate_y");
		fdate_m = rs.getString("fdate_m");
		fdate_d = rs.getString("fdate_d");
		qa = rs.getString("qa");
		comm = rs.getString("comm");
		process= rs.getString("process");

	//使用者可看到分行	
	    qa_show = ReplaceAll.replace(qa, "\r\n", "<br>"); 
		comm_show = ReplaceAll.replace(comm, "\r\n", "<br>"); 
		process_show = ReplaceAll.replace(process, "\r\n", "<br>");
}
%>
 
 <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
 	<tr>
	<td width="20%">&nbsp;</td>
	<td width="60%"><div align="center" class="txttitletop"><span class="style14"><strong>Cabin Safety Check List </strong></div></td>
 	<td width="20%"><div align="right"><a href="javascript:window.print()"><img src="images/print.gif" width="17" height="15" border="0" alt="列印"></div></a> 
        </div></td>
  </tr>
</table>
<table width="90%"  border="2" align="center" cellpadding="0" cellspacing="0" class="table_border2">
  <tr class="txtblue">
 	<td width="62%"><div align="left" class="style24">&nbsp;Flight：<%=allFltno%> 　Sector：<%=sector%> </div></td>
    <td width="38%"><div align="left" class="style24">&nbsp;Date：<%=fdate_y%>Y <%=fdate_m%>M<%=fdate_d%>D</div></td>
  </tr> 
  <tr class="txtblue">
 	<td width="62%"><div align="left" class="style24">&nbsp;A/C：<%=fleet%>　(<%=acno%>)　　　　Purser：<%=purserName%></div></td>
    <td width="38%"><div align="left" class="style24">&nbsp;Inspector：<%=inspector%></div></td>
  </tr> 
</table>
  <table width="90%" border="2" align="center" cellpadding="0" cellspacing="0" class="table_border2">
  <tr class="tablehead3">
    <td height="5" colspan="2"><div align="center"><strong>Item</strong></div></td>
    <td width="4%" ><div align="center"><strong>Yes</strong></div></td>
    <td width="4%" ><div align="center"><strong>No</strong></div></td>
    <td width="4%" ><div align="center"><strong>N/A</strong></div></td>
    <td width="28%" ><div align="center"><strong>Remark</strong></div></td>
  </tr>
<%
sql2 = "select * from egtstfi where flag='Y' "+ 
       "AND itemno IN (SELECT kin  FROM egtstsi  WHERE  itemno IN (SELECT itemno  FROM egtstdt WHERE sernno='"+sernno+"')) "+ 
	   "order by itemno";
//out.print("sql2= "+sql2+"<br>");
rs2 = stmt2.executeQuery(sql2); 
	  	  
if(rs2 != null)
{
	while(rs2.next())
	{
		fiNo = rs2.getString("itemno");
	  	fiDsc = rs2.getString("itemDsc");
%>
	  	<tr class="txtblue">
    		<td colspan="6"><div align="left" class="style24"><strong>&nbsp;<%=count%>.<%=fiDsc%></strong></div></td>
	    </tr>  
<% 
		sql3 = "select * from egtstsi where kin='"+fiNo+"' and sflag= 'Y' AND itemno IN (SELECT itemno FROM egtstdt WHERE sernno='"+sernno+"') order by itemdsc";
		rs3 = stmt3.executeQuery(sql3); 
					  
		if(rs3 != null)
		{
					    
	  		while(rs3.next())
			{
				siNo = rs3.getString("itemno");
	  			siDsc = rs3.getString("itemdsc");
				String siNo2 = count +"."+ subcount;
                //remark欄內如值為 null 則轉為全形空白字元
				sql4 = "select sernno, itemno, flag, NVL(remark, '　')　remark from egtstdt where sernno ='"+sernno+"' and itemno = '"+siNo+"'";
				rs4 = stmt4.executeQuery(sql4);
				
				check1 = "";
				check2 = "";
				check0 = "";
				checked = "<img src='images/check.gif' width='17' height='15' border='0' >";
				String checkedforfile = "V";
				String check1forfile = "";
				String check2forfile = "";
				String check0forfile = "";
				remark = "　";

				while(rs4.next())
				{	
					lsflag = rs4.getString("flag");
					if( lsflag.equals("1"))
						{
							check1=" "+checked+"";
							check1forfile=" "+checkedforfile+"";
					    }
					if( lsflag.equals("2"))
						{
							check2=" "+checked+"";
							check2forfile=" "+checkedforfile+"";
						}
					if( lsflag.equals("0"))
						{
							check0=" "+checked+"";
							check0forfile=" "+checkedforfile+"";
						}
					remark = rs4.getString("remark");
				}
%>
		  <tr class="txtblue">
			<td width="4%"><div align="center" class="style24"><%=siNo2%></div></td>
			<td width="56%"><div align="left" class="style24"><%=siDsc%></div></td>
			<td width="4%" ><div align="center" class="style24"><%=check1%>&nbsp;</div>
			<div align="center" class="style24"></div></td>
			<td width="4%" ><div align="center" class="style24"><%=check2%>&nbsp;</div>
			<div align="center" class="style24"></div></td>
			<td width="4%" ><div align="center" class="style24"><%=check0%>&nbsp;</div>
			<div align="center" class="style24"></div></td>
			<td width="28%" >
			  <div align="left" class="style24"><%= remark%>
			</div></td>
		  </tr>  
<%		
			subcount++;
			}
		}
		subcount=1;
	 count++;
	}
}
%>		
</table>
<table width="90%" border="2" align="center" cellpadding="0" cellspacing="0" class="table_border2">
  <tr class="tablehead">
    <td height="5" colspan="5"><div align="left"><strong>&nbsp;Q&amp;A </strong></div>
    </td>
  </tr>
  <tr class="tablebody">
    <td height="10" colspan="5" bgcolor="#FFFFFF" class="txtblue">
          <div align="left" class="txtblue style24"><%=qa_show%>
      </div></td>
  </tr>
  <tr class="tablehead3">
    <td height="5" colspan="5"><div align="left"><strong>&nbsp;Comment and Suggestion</strong></div>
    </td>
  </tr>
  <tr class="tablebody">
    <td height="20" colspan="5" bgcolor="#FFFFFF" class="txtblue">
        <div align="left" class="txtblue style24"><%=comm_show%>
      </div></td>
  </tr>
</table>
<%
}
catch(Exception e){
	out.print(e.toString());
}
finally{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(rs2 != null) rs2.close();}catch(SQLException e){}
	try{if(rs3 != null) rs3.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(stmt2 != null) stmt2.close();}catch(SQLException e){}
	try{if(stmt3 != null) stmt3.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>
<p>
<hr>
<!--*********************************************************************-->
<!--自我督察-->
<%
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
<br>
<table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
 	<tr>
		<td width="90%"><div align="center" class="txttitletop"><span class="style14"><strong>Self Inspection List Report </strong></div></td> 		
  	</tr>
</table>
<table width="90%"  border="1" align="center" cellpadding="1" cellspacing="1" class="table_border2">        
	<tr class="txtblue">
	  	<td width="25%"><div align="left" class="style1">&nbsp;<span class="style3"><span class="style1"><strong>Date</strong>:</span><span class="style2"><%=fdate_y%></span><span class="style1"><strong>Y</strong></span><span class="style2">&nbsp;<%=fdate_m%>&nbsp;</span><span class="style1"><strong>M</strong></span><span class="style2"><%=fdate_d%>&nbsp;</span><span class="style1"><strong>D</strong></span></span></div></td>
    	<td width="25%"><div align="left" class="style3">&nbsp;<span class="style1"><strong>Flt</strong>:</span><span class="style2"><%=allFltno%> </span>　</div></td>
    	<td width="25%"><div align="left" class="style1">&nbsp;<span class="style3"><span class="style1"><strong>Purser</strong>:</span><span class="style2"><%=purserName%></span></span></div></td>
    	<td width="25%"><div align="left" class="style3">&nbsp;<span class="style1"><strong>Inspector</strong>:</span><span class="style2"><%=inspector%></span></div></td>
  </tr> 
</table>
<table width="90%" border="1" align="center" cellpadding="1" cellspacing="1" class="table_border2">
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
  	sql2 = "select ci.itemno as itemno, ci.subject as subject, "+
			       "NVL(cc.tcrew, 0) as tcrew, NVL(cc.correct, 0) as correct, NVL(cc.incomplete, 0) as incomplete, "+
				   "NVL(cc.crew_comm, '　') as crew_comm, NVL(cc.acomm, '　') as acomm  "+
	      "from egtstcc cc, egtstci ci "+
		  "where cc.sernno='"+sernno+"' and cc.itemno=ci.itemno "+
		  "order by ci.itemno ";		  
    //out.print("sql2="+sql2+"<br>");		  
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

		//使用者可看到分行	
        
        ccCrew_comm = ReplaceAll.replace(ccCrew_comm, "\r\n", "<br>"); 
		ccAcomm = ReplaceAll.replace(ccAcomm, "\r\n", "<br>");
		 
		
  	%>
  	<tr class="txtblue">
    	<td align="center" class="txtred" ><span class="style3"><strong><%=count%></strong></span></td>
    	<td align="center" ><span class="style1"><%=ciItemno%></span></td>
    	<td align="left" ><span class="style1"><%=ciSubject%></span></td>
    	<td align="center" ><span class="style1"><%=ccTcrew%></span></td>
    	<td align="center" ><span class="style1"><%=ccCorrect%></span></td>
    	<td align="center" ><span class="style1"><%=ccIncomplete%></span></td>
    	<td align="center" ><span class="style1"><%=ccCrew_comm%></span></td>
    	<td align="left" ><span class="style1"><%=ccAcomm%></span></td>
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
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(rs2 != null) rs2.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>    
</p>
<!--*********************************************************************-->
<!--職能評量-->
<hr>
<%
sysdate    = null;
allFltno   = null;
fdate      = null;
purserName = null;
inspector  = null;
fdate_y    = null;
fdate_m    = null;
fdate_d    = null;
score	  = "0.00";
count = 0;
countCi = 0;   

 PRFuncEval prfe = new PRFuncEval();
 prfe.getPRFuncEval(sernno);
 ArrayList objAL = prfe.getObjAL();	
 ArrayList memoAL = prfe.getObjAL();	
 if(objAL.size()>1)
 {
	 PRFuncEvalObj obj =(PRFuncEvalObj) objAL.get(1);  
	 score = obj.getKpi_score();
	 memoAL = obj.getMemoAL();
 }

sql = null;
rs = null;
stmt = null;
cn = new ConnDB();
dbDriver = null;
conn   = null;

try
{
	cn.setORP3EGUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
	stmt   = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);

	sql = "select To_Char(SYSDATE, 'mm/dd/yy') AS rundate, fltno, purname, instname, to_char(fltd,'yyyymmdd') as fltd, to_char(fltd,'yyyy') as fdate_y, to_char(fltd,'mm') as fdate_m, to_char(fltd,'dd') as fdate_d from egtstti where sernno = '"+ sernno+ "'";
	rs = stmt.executeQuery(sql); 
	while(rs.next())
	{
		sysdate = rs.getString("rundate");
		allFltno = rs.getString("fltno");
		fdate = rs.getString("fltd");
		purserName = rs.getString("purname");
		inspector = rs.getString("instname");
		fdate_y = rs.getString("fdate_y");
		fdate_m = rs.getString("fdate_m");
		fdate_d = rs.getString("fdate_d");
	}	
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
<table width="90%"  border="0" align="center" cellpadding="2" cellspacing="0">
  <tr>
    <td>
      <div align="center"><span class="txttitletop">座艙長職能評量表 </span></div>
    </td>
  </tr>
</table>
<table width="90%"  border="1" align="center" cellpadding="1" cellspacing="1" class="fortable"> 
	<tr class="txtblue">
	  	<td width="25%"><div align="left" class="style1">&nbsp;<span class="style3"><strong>Date</strong>:</span><span class="txtred"><%=fdate_y%>&nbsp;</span><span class="style3"><strong>Y</strong></span><span class="txtred">&nbsp;<%=fdate_m%>&nbsp;</span><span class="style3"><strong>M</strong></span><span class="txtred">&nbsp;<%=fdate_d%>&nbsp;</span><span class="style3"><strong>D</strong></span></div>
		</td>
	  	<td width="25%"><span align="left" class="style1">&nbsp;&nbsp;&nbsp;<span class="style3"><strong>Flt</strong>:</span><span class="txtred"><%=allFltno%> </span>
		</td>
    	<td width="16%"><div align="left" class="style1">&nbsp;<span class="style3"><strong>Purser</strong>:</span><span class="txtred"><%=purserName%></span></div></td>
    	<td width="17%"><div align="left" class="style1">&nbsp;<span class="style3"><strong>Inspector</strong>:</span><span class="txtred"><%=inspector%></span></div></td>
    	<td width="17%"><div align="left" class="style1">&nbsp;<span class="style3"><strong>Score : </strong></span><span class="txtred"><%=score%></span></div></td>
  	</tr> 
</table>

<table width="90%" border="1" align="center" cellpadding="1" cellspacing="1" class="fortable">
  	<tr class="tablehead3">
   	   <td align="center" valign="middle"  rowspan= "2">&nbsp;</td>
   	   <td align="center" valign="middle"  rowspan= "2"><strong>評估項目</strong></td>
   	   <td align="center" valign="middle"  rowspan= "2"><strong>子標</strong></td>
       <td align="center" valign="middle"  rowspan= "2"><strong>指標KPI</strong></td>
   	   <td align="center" valign="middle"  colspan="3"><strong>評分</strong></td>
    </tr>
	 <tr class="tablehead3">
       <td align="center" valign="middle"><strong>NDIP</strong></td>
       <td align="center" valign="middle"><strong>AVRG</strong></td>
       <td align="center" valign="middle"><strong>GOOD</strong></td>		  
  	</tr>
  	<%
	int mi_seq = 1;
	for(int j=1;j<objAL.size();j++)
	{		
		PRFuncEvalObj objp =(PRFuncEvalObj) objAL.get(j-1);        
		PRFuncEvalObj obj =(PRFuncEvalObj) objAL.get(j);  
    %>
  	<tr class="txtblue">
<%
		if(!objp.getMitemno().equals(obj.getMitemno()))
		{//評估項目不同
%>
			<td align="left" ><span class="style6"><%=mi_seq%>.</span></td>
			<td align="center" ><span class="style6"><%=obj.getMitemdesc()%></span></td>
<%
			mi_seq++;
	    }
		else
		{
%>
			<td align="center" >&nbsp;</td>
			<td align="center" >&nbsp;</td>
<%
		}
%>

<%
		//********************************************************
		if(!objp.getSitemno().equals(obj.getSitemno()))
		{//子標不同
%>
			<td align="left" ><%=obj.getSitemdesc()%>(<%=obj.getGrade_percentage()%>%)</td>
<%
	    }
		else
		{
%>
			<td align="center" >&nbsp;</td>
<%
		}
%>

<%
		//********************************************************
		String eval50str = "";
		String eval75str = "";
		String eval100str = "";
		if("50".equals(obj.getKpi_eval())){eval50str="<img src='images/check.gif' width='17' height='15' border='0' >";}
		if("75".equals(obj.getKpi_eval())){eval75str="<img src='images/check.gif' width='17' height='15' border='0' >";}
		if("100".equals(obj.getKpi_eval())){eval100str="<img src='images/check.gif' width='17' height='15' border='0' >";}

		String eval50str2 = "";
		String eval75str2 = "";
		String eval100str2 = "";
		if("50".equals(obj.getKpi_eval())){eval50str2="<span>V</span>";}
		if("75".equals(obj.getKpi_eval())){eval75str2="<span>V</span>";}
		if("100".equals(obj.getKpi_eval())){eval100str2="<span>V</span>";}

%>
		<td align="left" ><%=obj.getKpidesc()%></td>
		<td align="center" >&nbsp;<%=eval50str%></td>
		<td align="center" >&nbsp;<%=eval75str%></td>
		<td align="center" >&nbsp;<%=eval100str%></td>
   	</tr>
    <%
	}
	%>  
</table>
<table width="90%"  border="1" align="center" cellpadding="1" cellspacing="1" class="fortable"> 
	<tr class="txtblue">
	  	<td width="5%"><div align="center" class="style1">座<br>艙<br>長<br>客<br>艙<br>管<br>理<br>觀<br>察</div>
		</td>
<%
	String tempmemo1 ="";
	String tempmemo2 ="";
	for(int k=0; k<memoAL.size(); k++)
	{
		PRFuncEvalObj2 memoobj =(PRFuncEvalObj2) memoAL.get(k);
		if("A".equals(memoobj.getMemo_type()))
		{
			tempmemo1 = memoobj.getMemo();
			if(tempmemo1 == null)
			{
				tempmemo1 = "";
			}
		}
		if("B".equals(memoobj.getMemo_type()))
		{
			tempmemo2 = memoobj.getMemo();
			if(tempmemo2 == null)
			{
				tempmemo2 = "";
			}
		}		
	}
%>
	  	<td width="90%" align="left" valign="top" class="style1">&nbsp;<%=tempmemo1%></td>
  	</tr> 
</table>
</body>
</html>
