<%@page import="fz.psfly.PSFlySelfInsObj"%>
<%@page import="ws.prac.SFLY.MP.MPsflySafetyChkAttObj"%>
<%@page import="fz.psfly.PSFlySelfIns"%>
<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*,java.util.*,ci.db.*,java.util.ArrayList" %>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("../logout.jsp");
}

			
String sernno	   = request.getParameter("sernno");
String fltno	   = request.getParameter("fltno");
String fltd        = request.getParameter("fltd");
String sysdate     = request.getParameter("sysdate");
String fdate_y	   = request.getParameter("fdate_y");
String fdate_m     = request.getParameter("fdate_m");
String fdate_d	   = request.getParameter("fdate_d");
String allFltno    = request.getParameter("allFltno");
String purserName  = request.getParameter("purserName");
String inspector   = request.getParameter("inspector");
String sect = request.getParameter("sect");
//out.print(fdate_y+"/"+fdate_m+"/"+fdate_d+"/"+allFltno+"/"+purserName+"/"+inspector+"<br>");
PSFlySelfIns sfly = new PSFlySelfIns();
if(!"".equals(sernno)){
	sfly.getSelfIns(sernno);
	sfly.SelfInsItem(fltd, sect.replace("/", ""), fltno, "");
	//out.println(sfly.getsInsItem().getErrorMsg());
	//session.setAttribute("SILcrewAll", sfly.getsInsItem().getCrewArr());	
}
String fdate = null;

String rmNo = null;
String rmDsc = null;

String reqItemno = null;
String reqSubject = null;

int count=1;

Connection conn = null;
Statement stmt = null;
Statement stmtRm = null;

String sql = null;
ResultSet rs = null;
ResultSet myResultSetRm = null;

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
.style2 {color: #000000}
.style5 {line-height: 13.5pt; font-family: "Verdana"; font-size: 12px;}
.style7 {color: #FF0000; }
.style8 {color: #333333}
-->
</style>
<script src="../js/subWindow.js" type="text/javascript"></script>
</head>

<body>

<br>
<form name="form1" method="post" action="upSILReportSave.jsp" onSubmit="">
<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
 	<tr>
		<td width="20%">&nbsp;</td>
		<td width="60%"><div align="center" class="txttitletop"><span class="style14"><strong>Self Inspection List Report </strong></div></td>
 		<td width="20%">&nbsp;</td>
  	</tr>
</table>

<table width="95%"  border="1" align="center" cellpadding="1" cellspacing="1" class="fortable">        
	<tr class="txtblue">
	  	<td width="25%"><div align="left" class="style7">&nbsp;<span class="style5"><span class="style2"><strong>Date</strong>:</span><%=fdate_y%><span class="style2"><strong>Y</strong></span>&nbsp;<%=fdate_m%>&nbsp;<span class="style2"><strong>M</strong></span><%=fdate_d%>&nbsp;<span class="style2"><strong>D</strong></span></span></div></td>
    	<td width="25%" class="txtblue"><div align="left" class="style7">&nbsp;<span class="style2"><strong>Flt</strong>:</span><span class="style5"><%=allFltno%> </span>　</div></td>
    	<td width="25%"><div align="left" class="style7">&nbsp;<span class="style8"><strong>CM</strong>:</span><span class="style5"><%=purserName%></span></div></td>
    	<td width="25%"><div align="left" class="style7">&nbsp;<span class="style2"><strong>Inspector</strong>:</span><span class="style5"><%=inspector%></span></div></td>
  	</tr> 
</table>
<table width="95%" border="1" align="center" cellpadding="1" cellspacing="1" class="fortable">
  	<tr class="tablehead3">
   	   <td width="4%" align="center" valign="middle">&nbsp;</td>
   	   <td width="4%" align="center" valign="middle"><strong>No.</strong></td>
   	   <td align="center" valign="middle"><strong>Issue</strong></td>
       <td width="9%" align="center" valign="middle"><strong>No.
   	   <br>Checked</strong></td>
   	   <td width="9%" align="center" valign="middle"><strong>Correctly<br>Answer/<br>Perform</strong></td>
       <td width="10%" align="center" valign="middle"><strong>Incorrectly<br>Answer/<br>Perform</strong></td>
       <td width="11%" align="center" valign="middle"><strong>Crew</strong></td>
       <!--  <td width="15%" align="center" valign="middle"><strong>Feedback</strong></td>		-->  
  	   <td width="6%" align="center" valign="middle"><strong>ATtribute</strong></td>
  	</tr>
<%
  	ArrayList objAL = sfly.getObjAL();
  	
	if(null!=objAL && objAL.size()>0){
		for(int i=0;i<objAL.size();i++){	
			PSFlySelfInsObj obj = (PSFlySelfInsObj) objAL.get(i);							
			//使用者可看到分行	
	       /* 
	        ccCrew_comm = ReplaceAll.replace(ccCrew_comm, "\r\n", "<br>"); 
			ccAcomm = ReplaceAll.replace(ccAcomm, "\r\n", "<br>");
			*/
			
			if(Integer.parseInt(obj.getItemno())>=159 && Integer.parseInt(obj.getItemno())<=189)
			{
				obj.setTcrew("1");
				obj.setCorrect("1");
				obj.setIncomplete("0");
			}
	  	%>
	  	<tr>
	    	<td align="center" class="txtred" ><strong><%=i+1%></strong></td>
	    	<td align="center" class="txtblue style3"><%=obj.getItemno()%></td>
	    	<td align="left" class="txtblue style3" ><%=obj.getSubject()%></td>
	    	<td align="center" ><input name="<%=obj.getItemno()%>tcrew" type="text" id="tcrew" value="<%=obj.getTcrew()%>" size="2"></td>
	    	<td align="center" ><input name="<%=obj.getItemno()%>correct" type="text" id="correct" value="<%=obj.getCorrect()%>" size="2" maxlength="2"></td>
	    	<td align="center" ><input name="<%=obj.getItemno()%>incomplete" type="text" id="incorrect" value="<%=obj.getIncomplete()%>" size="2" maxlength="2"></td>
	    	<td align="center" ><a href="#" onClick="subwinXY('mdSILReportCrew.jsp?sect=<%=sect%>&fltd=<%=fdate%>&fltno=<%=fltno%>&itemno=<%=obj.getItemno()%>&sernno=<%=sernno%>','edit','600','600');"><img src="../images/list.gif" width="22" height="22" border="0" alt="Modify Crew"></a></td>
	    	<!-- <td align="left" >
	    	<input type="hidden" name="<%=obj.getItemno()%>crew_comm" cols="10%" id="crewComm"/>
	    	<textarea name="<%=obj.getItemno()%>acomm" cols="15%" id="acomm"><%=obj.getAcomm()%></textarea>
	    	</td>-->
	 	    <td align="left" ><div align="left"><span class="style3">
	 	    <select name="<%=obj.getItemno()%>rm" id="<%=obj.getItemno()%>rm">
            <%
            if(sfly.getsInsItem()!=null && sfly.getsInsItem().getAttributeArr()!=null && sfly.getsInsItem().getAttributeArr().length > 0){
            	for(int j=0;j<sfly.getsInsItem().getAttributeArr().length;j++){
            		MPsflySafetyChkAttObj attObj = sfly.getsInsItem().getAttributeArr()[j];
            	
           	%>
           		 <option value="<%=attObj.getItemNo()%>" <%=((attObj.getItemNo().equals(obj.getItemno_rm()))?"SELECTED":"")%>><%=attObj.getItemdsc()%></option>
           	<%
           		}
            }
			%>
            </select>
	 	    </span></div>
			</td>
	  	</tr>
		<%

   		}
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
    <input name="reqItemno" type="Hidden" value="<%=reqItemno%>">
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
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(stmtRm != null) stmtRm.close();}catch(SQLException e){}	
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>
    
</p>

</body>
</html>
