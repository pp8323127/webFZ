<%@page import="java.util.ArrayList"%>
<%@page import="eg.report.FleetRec"%>
<%@page import="eg.report.FleetRecObj"%>
<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
<%
String sdate = request.getParameter("year1") + request.getParameter("month1");
String edate = request.getParameter("year2") + request.getParameter("month2");
String fleet = request.getParameter("fleet");
String rank = request.getParameter("rank");
String empn = request.getParameter("empn");
//out.println(sdate+","+edate+","+fleet+","+rank+","+empn);
boolean status = false;
StringBuffer sb = new StringBuffer();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>Fleet Rec</title>
<link rel="stylesheet" type="text/css" href="../../style/errStyle.css">
<link href="../../menu.css" rel="stylesheet" type="text/css">
<link href="style.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript">
	if(top.topFrame.document.getElementById("showMessage") != null){
		top.topFrame.document.getElementById("showMessage").className="hiddenStatus";
	}
	if(top.topFrame.document.getElementById("submit") != null){
		top.topFrame.document.getElementById("submit").disabled=false;
	}
function downreport()
{
	location.replace("../report/report_download.jsp");
}
</script>
</head>
<body>
<%
//out.println(fleet.substring(0,2));//取前兩碼
FleetRec fleetRec = new FleetRec();
status = fleetRec.getUnDoList(fleet.substring(0,2), sdate, edate, empn, rank);
ArrayList dataAL = fleetRec.getObjAL();

if(!status){
out.print("<div class='errStyle3'>"+fleetRec.getStr()+"</div>");
}else if(dataAL == null){
out.print("<div class='errStyle3'>NO DATA!!</div>");
}else{
	
%>
<div align="center">
  <table width="95%" border="0">
    <tr>
	<td width="80%" align="center" class="txttitletop">機型資格紀錄查詢: <%=sdate%> - <%=edate%> <br>未執行: <%=fleet%> </font></td>
	<td width="20%" align="right"><a href="javascript:window.print()"><img src="../../images/print.gif" width="17" height="20" border="0" alt="列印"></a>&nbsp;&nbsp;<input type="button" name="rep" id="rep" class="txtblue" value="Download File" onClick="downreport();"></a></td>
    </tr>
  </table>
</div>
<div align="center">
<table width="90%" border="1">
   <tr> 
	  <td class="tablehead"><font face="Arial, Helvetica, sans-serif" size="2"><b>#</b></font></td> 
	  <td class="tablehead"><font face="Arial, Helvetica, sans-serif" size="2"><b>Empno</b></font></td>
	  <td class="tablehead"><font face="Arial, Helvetica, sans-serif" size="2"><b>Sern</b></font></td>
      <td class="tablehead"><font face="Arial, Helvetica, sans-serif" size="2"><b>CName</b></font></td>      
	  <td class="tablehead"><font face="Arial, Helvetica, sans-serif" size="2"><b>Group</b></font></td>
	  <td class="tablehead"><font face="Arial, Helvetica, sans-serif" size="2"><b>Rank</b></font></td>
	  

<%
	sb.append("機型資格紀錄查詢:"+sdate+" ~ "+edate+"\r\n 未執行 :"+fleet+"\r\n");
	sb.append("#,Empno,Sern,CName,Groups,Rank\r\n");
%>	  
   </tr>
<%
String bgColor = "";
int countRow = 0; 
	if(dataAL.size() > 0){
		for (int i = 0; i < dataAL.size(); i++) {
			countRow ++; 
			if(countRow%2==0)
			{
				bgColor = "#FFFFFF";
			}
			else
			{
				bgColor = "#CCCCCC";
			}
			FleetRecObj obj = (FleetRecObj) dataAL.get(i);
%>
			  	<tr align="center" bgcolor="<%=bgColor%>" class="txtblue">
				<td align="center" ><%=countRow%></td>
				<td align="center" ><%=obj.getEmpno()%></td>
				<td align="center" ><%=obj.getSern()%></td>
				<td align="center" ><%=obj.getCname()%></td>
				<td align="center" ><%=obj.getGroups()%></td>
				<td align="center" ><%=obj.getRank() %></td>
				</tr>
<%
		sb.append((countRow)+","+obj.getEmpno()+","+obj.getSern()+","+obj.getCname()+","+obj.getGroups()+","+obj.getRank()+"\r\n");	
		}//for
		
	}//if(dataAL.size() > 0)
}//else
session.setAttribute("sb",sb);	
%>
</table>
</div>
</body>
</html>
