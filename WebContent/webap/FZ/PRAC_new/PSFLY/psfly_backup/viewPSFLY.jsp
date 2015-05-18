<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.pracP.*,java.sql.*,ci.db.ConnDB,fz.psfly.*"%>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
	response.sendRedirect("../../sendredirect.jsp");
} 
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title></title>
<link href="../style2.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style1 {
	font-size: x-large;
	font-weight: bold;
}
.style4 {font-size: medium}
.style5 {
	font-size: x-small;
	font-weight: bold;
}
.style6 {font-size: small}
.style8 {color: #000000}
.style10 {font-size: small; font-weight: bold; color: #000000; }
.style12 {font-size: medium; font-weight: bold; }
.style13 {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 10px;
	font-weight: bold;
}
.style15 {font-size: 12px; font-weight: bold; }
.style16 {font-size: 12px}
.style21 {font-family: Arial, Helvetica, sans-serif; font-size: 14px; }
-->
</style>
</head>
<%
String fltdt = request.getParameter("fltdt");//yyyy/mm/dd
String fltno = request.getParameter("fltno");//006
String sect = request.getParameter("sect");//TPELAX
String fleet = "";
String acno = "";

PRSFlyIssue psf = new PRSFlyIssue();
ArrayList objAL = new ArrayList();
psf.getPRSFLY(fltdt, fltno, sect,sGetUsr);
objAL = psf.getBankObjAL();      
if(objAL.size()>0)
{
	PRSFlyFactorObj obj = (PRSFlyFactorObj) objAL.get(0);
	fleet = obj.getFleet();
	acno = obj.getAcno();
}
%>
<body>
<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0" >
	<tr>
	  <td><div class = "txtblue" align="center">Fltdt : <%=fltdt%></div></td>
	  <td><div class = "txtblue" align="center">Fltno : <%=fltno%></div></td>
	  <td><div class = "txtblue" align="center">Sect  : <%=sect%></div></td>
	  <td><div class = "txtblue" align="center">Fleet : <%=fleet%></div></td>
	  <td><div class = "txtblue" align="center">Acno  : <%=acno%></div></td>
	</tr>
</table>
<table width="95%" border="1" align="center" cellpadding="0" cellspacing="0" >
	<tr class="tablehead2">
	  <td width = "4%"><div class = "txtblue" align="center">Seq.</div></td>
	  <td width = "5%"><div class = "txtblue" align="center">Issue<br>No</div></td>
	  <td width = "16%"><div class = "txtblue" align="center">Issue<br>Description</div></td>
	  <td width = "35%"><div class = "txtblue" align="center">Crew duty<br>Satisfied Num.</div></td>
	  <td width = "35%"><div class = "txtblue" align="center">Crew duty<br>Need to improve Num.</div></td>
	</tr>
</table>
<%
int c = 1;
for(int i=0; i<objAL.size(); i++)
//for(int i=0; i<0; i++)
{
	PRSFlyFactorObj obj = (PRSFlyFactorObj) objAL.get(i);
	if(i==0)
	{
%>
<table width="95%" border="1" align="center" cellpadding="0" cellspacing="0" >
	<tr>
	  <td width = "4%"><div class = "txtblue" align="center"><%=(c++)%></div></td>
	  <td width = "5%"><div class = "txtblue" align="center"><%=obj.getTopic_no()%>-<%=obj.getItemno()%></div></td>
	  <td width = "16%"><div class = "txtblue" align="left">&nbsp;<%=obj.getItemdesc()%></div></td>
	  <td width = "35%"><div class = "txtblue" align="left">&nbsp;<%=obj.getDuty_satisfy()%>
		&nbsp;&nbsp;&nbsp;<span class="txtxred">Count: <%=obj.getNum_satisfy()%></span>
      </div></td>
	  <td width = "35%"><div class = "txtblue" align="left">&nbsp;<%=obj.getDuty_needtoimprove()%>
		&nbsp;&nbsp;&nbsp;<span class="txtxred">Count: <%=obj.getNum_needtoimprove()%></span>
		</div></td>
	</tr>
</table>
<%
	}
	else
	{
		PRSFlyFactorObj obj1 = (PRSFlyFactorObj) objAL.get(i-1);
		PRSFlyFactorObj obj2 = (PRSFlyFactorObj) objAL.get(i);
		if(!(obj1.getTopic_no()+"-"+obj1.getItemno()).equals(obj2.getTopic_no()+"-"+obj2.getItemno()))
		{
%>
<table width="95%" border="1" align="center" cellpadding="0" cellspacing="0" >
	<tr>
	  <td width = "4%"><div class = "txtblue" align="center"><%=(c++)%></div></td>
	  <td width = "5%"><div class = "txtblue" align="center"><%=obj.getTopic_no()%>-<%=obj.getItemno()%></div></td>
	  <td width = "16%"><div class = "txtblue" align="left">&nbsp;<%=obj.getItemdesc()%></div></td>
	  <td width = "35%"><div class = "txtblue" align="left">&nbsp;<%=obj.getDuty_satisfy()%>
		&nbsp;&nbsp;&nbsp;<span class="txtxred">Count: <%=obj.getNum_satisfy()%></span>
      </div></td>
	  <td width = "35%"><div class = "txtblue" align="left">&nbsp;<%=obj.getDuty_needtoimprove()%>
		&nbsp;&nbsp;&nbsp;<span class="txtxred">Count: <%=obj.getNum_needtoimprove()%></span>
		</div></td>
	</tr>
</table>
<%
		}
	}

if(Integer.parseInt(obj.getNum_needtoimprove())>0)
{
%>
<!--
<table width="95%" border="1" align="center" cellpadding="0" cellspacing="0" bgcolor = "#ECF2F6">
<tr>
<td width="5%" class ="txtblue" align = "center">原<br>因</td>
<td>
-->
<!--Main table-->
<table width="95%" border="1" align="center" cellpadding="0" cellspacing="0" bgcolor = "#ECF2F6">
<%
		if(i==0)
		{	
%>
		  <tr class="tablehead3">
			<td width="6%" class="tablehead3"><strong><%=obj.getFactor_no()%></strong></td>
			<td width="64%" class="tablehead3"><div align="left"><strong><%=obj.getFactor_desc()%></strong></div></td>
			<td width="30%" class="tablehead3"><div align="left"><strong>Description</strong></div></td>
		  </tr>
  <%
		}
		else
		{
			PRSFlyFactorObj obj1 = (PRSFlyFactorObj) objAL.get(i-1);
			PRSFlyFactorObj obj2 = (PRSFlyFactorObj) objAL.get(i);
			if(!obj1.getFactor_no().equals(obj2.getFactor_no()) | !(obj1.getTopic_no()+"-"+obj1.getItemno()).equals(obj2.getTopic_no()+"-"+obj2.getItemno()) )
			{
%>
			  <tr class="tablehead3">
				<td width="6%" class="tablehead3"><strong><%=obj.getFactor_no()%></strong></td>
				<td width="64%" class="tablehead3"><div align="left"><strong><%=obj.getFactor_desc()%></strong></div></td>
				<td width="30%" class="tablehead3"><div align="left"><strong>Description</strong></div></td>
			  </tr>
  <%
			}
		}	
%>
  <tr>
		<td width="6%" class="txtblue" align = "right"><strong><%=obj.getFactor_sub_no()%></strong></td>
		<td width="64%"class="txtblue"><div align="left"><strong><%=obj.getFactor_sub_desc()%></strong></div></td>		
		<td width="30%"class="txtblue"><div align="left"><strong>&nbsp;<%=obj.getDesc_needtoimprove()%></strong></div></td>		
  </tr>
</table>
<!--Main table-->
<!--
</td>
</tr>
</table>
</div>
-->
<%
}//if(obj.getNum_needtoimprove()>0)


}//for(int i=0; i<objAL.size(); i++)	
%>
<p>
</body>
</html>
