<%@ page contentType="text/html; charset=big5" language="java" import="java.util.*,java.io.*,fsrpt.*" %>
<%
/*
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
*/

String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) 
{		
	response.sendRedirect("../sendredirect.jsp");
} 

ArrayList fsrptAL = new ArrayList();
FSRpt fsr = new FSRpt();
fsr.getFSRptList(userid);
fsrptAL  = fsr.getObjAL();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title></title>
<link href="style.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
function expl(expid)
{
	if(document.getElementById(expid).style.display=="none")
	{
		document.getElementById(expid).style.display="";
	}	
	else
	{
		document.getElementById(expid).style.display="none";
	}
}

</script>
<style type="text/css">
<!--
.style1 {font-family: Arial, Helvetica, sans-serif}
.style2 {color: #0000FF}
-->
</style>
</head>
<body>
<%
if(fsrptAL.size()>0)
{
	for(int i = 0; i<fsrptAL.size(); i++)
	{
		FSRptObj obj = (FSRptObj) fsrptAL.get(i);
		if(i==0)
		{
%>
			<div align="center" class="txttitletop">
				<h2><span class="style1"><%=obj.getNew_user_name()%> (<%=obj.getNew_user()%>)自願報告</span><br>
				</h2>
			</div>
			<table width="85%"  border="1" align="center" cellpadding="0" cellspacing="0">
				<tr align="left" class="tablehead">
				 <td align="center" width="5%"><strong>#</strong></td>
				 <td align="center" width="15%"><strong>Event/Flight<br>Date</strong></td>
				 <td align="center" width="75%"><strong>Subject</strong></td>
				 <td align="center" width="5%"><strong>Detail</strong></td>
				</tr>
			</table>
<%		
		}
%>
		<table width="85%"  border="1" align="center" cellpadding="0" cellspacing="0">
			<tr align="left">
			 <td class= "txtblue" align="center" width="5%"><strong><%=(i+1)%></strong></td>
			 <td class= "txtblue" align="center" width="15%"><strong><%=obj.getEvent_date()%></strong></td>
			 <td class= "txtblue" align="left" width="75%"><strong><%=obj.getRpt_subject()%></strong></td>
			 <td class= "txtblue" align="center" width="5%"><a href="#" onClick="expl('SubMenu<%=i%>')"><!--Expand/Collapse--><img src="img/messagebox_info.png" width="10" height="10" border="0"></a></td>
			</tr>
		</table>
		<div id="SubMenu<%=i%>"  width="85%" align="center" style="display:none;" ><!--*********-->
		<table width="85%"  border="1" align="center" cellpadding="0" cellspacing="0">
		<tr>
		<td class="txtblue" align="center"  bgcolor="#C0DDFF" width="12.5%">Fltno</td>
		<td class="txtblue" align="center" width="12.5%"><%=obj.getCarrier()%><%=obj.getFltno()%></td>
		<td class="txtblue" align="center"  bgcolor="#C0DDFF" width="12.5%">Sector</td>
		<td class="txtblue" align="center" width="12.5%"><%=obj.getSect()%></td>
		<td class="txtblue" align="center"  bgcolor="#C0DDFF" width="12.5%">A/C Type</td>
		<td class="txtblue" align="center" width="12.5%"><%=obj.getActype()%></td>
		<td class="txtblue" align="center"  bgcolor="#C0DDFF" width="12.5%">A/C No.</td>		
		<td class="txtblue" align="center" width="12.5%"><%=obj.getAcno()%></td>		
		</tr>
		<tr>
		 <td colspan="2" class="txtblue" align="center"bgcolor="#C0DDFF" >Description</td>
		 <td colspan="6" class="txtblue" align="left"><%=obj.getRpt_desc()%></td>
		</tr>
		<tr>
		 <td colspan="2" class="txtblue" align="center" bgcolor="#C0DDFF" >Potential<br>Consequence</td>
		 <td colspan="6" class="txtblue" align="left"><%=obj.getPotential_consequence()%></td>
		</tr>
		</table>
	</div><!--*********-->
<%
	}	//for(int i = 0; i<fsrptAL.size(); i++)
}
else
{
%>
<div align="center" class="txttitletop">
    <h2><span class="style1">No data found!</span><br></h2>
</div>
<%
}
%>
<br>
</body>
</html>
