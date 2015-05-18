<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="eg.vacancy.*" %>
<%
//response.setHeader("Cache-Control","no-cache");
//response.setDateHeader ("Expires", 0);
String year = request.getParameter("year");
String bgColor = "";
String userid = (String) session.getAttribute("userid") ; //get user id if already login
String unitcd = (String) session.getAttribute("Unitcd") ; 
String userbase = (String) session.getAttribute("userbase") ; 
String sdate = (String) request.getParameter("sdate") ; 
String edate = (String) request.getParameter("edate") ; 
String base = (String) request.getParameter("base") ; 
String serial = (String) request.getParameter("serial") ; 
String q_status = (String) request.getParameter("q_status") ; 
String vacancy = (String) request.getParameter("vacancy") ; 
String khhEA = "628097";//高雄林秀娟(同TPEEA)

if (session.isNew() || userid == null) 
{		//check user session start first
	response.sendRedirect("../../logout.jsp");
}
else
{

int cnt =0;
boolean isea = false;
boolean iseg = true;
boolean ifdisable = false;
/*
if(serial != null && !"".equals(serial))
{
	ifdisable = true;
}
*/

if("1812".equals(unitcd) | "1813".equals(unitcd) | userid.equals(khhEA) | "631A".equals(unitcd))
{
	isea = true;
	iseg = false;
}
if("640790".equals(userid))
{
	isea = false;
	iseg = true;
}

VacancyDispatch vd = new VacancyDispatch();
//String yearsern, String sdate, String edate, String base
vd.getDispVacancy(serial,sdate,edate,base);
ArrayList objAL = new ArrayList();
objAL = vd.getObjAL();
session.setAttribute("vacancyobjAL",objAL);

String userip = request.getRemoteAddr();
String diraddress = null;
if("192".equals(userip.substring(0,3)) | "10".equals(userip.substring(0,2))) 
{
	diraddress = "http://hdqweb03:9901/webfz/FZ/PRORP3/PURreport_part1_v2.jsp";
}
else
{
	diraddress = "http://tpeweb02.china-airlines.com/webfz/FZ/PRORP3/PURreport_part1_v2.jsp";
}

%>
<html>
<head>
<title></title>
<link rel="StyleSheet" href="menu.css" type="text/css" />
<style type="text/css">
<!--
.style1 
{
	font-size: 14px;
	line-height: 15pt;
	color: #0000FF;
	font-family:  Verdana;
}
.txtblue
{
	font-size: 12px;
	line-height: 13.5pt;
	color: #464883;
	font-family:  Verdana;
}
.txtred 
{
	font-size: 13px;
	line-height: 13.5pt;
	color: #FF0000;
	font-family:Verdana;
}
.style4 {font-size: 13px; line-height: 13.5pt; color: #FF0000; font-family: Verdana; font-weight: bold; }
-->
</style>
<script language="Javascript" type="text/javascript" src="../../js/subWindow.js"></script>
<script LANGUAGE="JavaScript">
function crewdisp(var1)
{
	var disp = eval("document.getElementById('"+var1+"').style.display");
	if(disp=='')
	{
		eval("document.getElementById('"+var1+"').style.display='none'");
	}
	else
	{
		eval("document.getElementById('"+var1+"').style.display=''");
	}
}	

function commdisp(var1)
{
	var disp = eval("document.getElementById('"+var1+"').style.display");
	if(disp=='')
	{
		eval("document.getElementById('"+var1+"').style.display='none'");
	}
	else
	{
		eval("document.getElementById('"+var1+"').style.display=''");
	}
}

function confby(var1, var2)
{
	var str = "";
	if("ef" == var1)
	{
		str = "Are you sure to confirm the name list?";
	}
	else if("mag" == var1)
	{
		str = "Are you sure to approve the name list?";
	}
	else
	{
		str = "Are you sure to close the case?";
	}
	if (confirm(str)) 
	{
		document.getElementById("btn"+var1+var2).disabled=1;
	    document.getElementById('confirm_by').value = eval("var1");
	    document.getElementById('idx').value = eval("var2");
		document.form1.submit();
	}
	else
	{
		return;
	}
}	

function f_submit()
{
	var str = "";
	document.form1.Submit.disabled=1;
	if(<%=isea%> == true)
	{
		str = "Are you sure to close the case?";
	}
	else
	{		
		str = "Are you sure to confirm/approve the name list?";
	}

	if (confirm(str)) 
	{
		document.form1.submit();
		return true;
	}
	else
	{
		return false;
	}
}	


</script>
</head>
<body>
<form action="vacancydispConfirm.jsp" method="post" name="form1" target="mainFrame" class="txtblue" onsubmit="return f_submit();">
<input name="confirm_by" id="confirm_by" type="hidden" value="">
<input name="idx" id="idx" type="hidden" value="">
<input name="sdate" id="sdate" type="hidden" value="<%=sdate%>">
<input name="edate" id="edate" type="hidden" value="<%=edate%>">
<input name="base" id="base" type="hidden" value="<%=base%>">
<input name="serial" id="serial" type="hidden" value="<%=serial%>">
<input name="q_status" id="q_status" type="hidden" value="<%=q_status%>">
<input name="vacancy" id="vacancy" type="hidden" value="<%=vacancy%>">

<div align="center">
<p align="center" class="style1"><b><%=sdate%> ~ <%=edate%> 低於服務派遣班次</b></p>
<table width="90%"  border="0">
<tr bgcolor="#66CCCC">
	<th scope="col" width="5%"><span class="style1">#</span></th>
	<th scope="col" width="10%"><span class="style1">Serial_num</span></th>
	<th scope="col" width="10%"><span class="style1">Fltd</span></th>
	<th scope="col" width="5%"><span class="style1">Fltno</span></th>
	<th scope="col" width="5%"><span class="style1">Sector</span></th>
	<th scope="col" width="5%"><span class="style1">Acno</span></th>
	<!--<th scope="col" width="10%"><span class="style1">Captain</span></th>-->
	<th scope="col" width="10%"><span class="style1">CM</span></th>
	<th scope="col" width="5%"><span class="style1">Vacancy</span></th>
	<th scope="col" width="10%"><span class="style1">EF/EG Confirm</span></th>
	<th scope="col" width="10%"><span class="style1">Manager Ratify</span></th>
	<th scope="col" width="10%"><span class="style1">EA Case Close</span></th>
	<th scope="col" width="5%"><span class="style1">Crew</span></th>
	<th scope="col" width="5%"><span class="style1">Email</span></th>
</tr>
<%
if(objAL.size()>0)
{
	for(int i=0; i<objAL.size(); i++)
	{
		bgColor="#CCFFFF";

		/*
		if((i%2)==1)
		{
			bgColor="bgcolor=\"#FFFFFF\"";
		}
		else
		{
			bgColor="bgcolor=\"#CCFFFF\"";
		}
		*/
		VacancyDispatchObj obj = (VacancyDispatchObj) objAL.get(i);
		boolean ifshow = false;
		if("OPEN".equals(q_status) && (obj.getCloseuser() == null | "".equals(obj.getCloseuser())))
		{
			ifshow = true;
		}

		if("CLOSED".equals(q_status) && (obj.getCloseuser() != null &&  !"".equals(obj.getCloseuser())))
		{
			ifshow = true;
		}

		if("ALL".equals(q_status))
		{
			ifshow = true;
		}

		if(ifshow == true)
		{	
			if(!"ALL".equals(vacancy))
			{
				if(!vacancy.equals(obj.getPrvacancy()))
				{
					ifshow = false;
				}
			}			
		}

		if(ifshow == true)
		{
			cnt++;

			if(obj.getCnt()>1)
			{
				bgColor="#FFFF99";
			}
%>
	  <tr class="txtblue" bgcolor="<%=bgColor%>">
		<td align="center" width="5%"><%=cnt%></td>
		<td align="center" width="10%"><%=obj.getYearsern()%></td>
		<td align="center" width="10%"><%=obj.getFltd()%></td>
		<td align="center" width="5%"><%=obj.getFltno()%></td>
		<td align="center" width="5%"><%=obj.getSect()%></td>
		<td align="center" width="5%"><%=obj.getAcno()%></td>
		<!--<td align="center" width="10%"><%=obj.getCpname()%></td>-->
		<td align="center" width="10%"><%=obj.getPsrname()%><br><%=obj.getPsrsern()%></td>
		<td align="center" width="5%">		
		<a href="javascript:subwinXY('<%=diraddress%>?fdate=<%=obj.getFltd()%>&fltno=<%=obj.getFltno()%>&section=<%=obj.getSect()%>&uid=<%=userid%>','wname','800','600')"><%=obj.getPrvacancy()%></a>
		</td>
<%
if("".equals(obj.getEfuser()) | obj.getEfuser() == null)	
{
%>
		<td align="center" width="10%">
		<!--<input name="btnef<%=i%>" id="btnef<%=i%>" type="button" class="txtblue" value=" Confirm " onclick="confby('ef','<%=i%>')" <% if(isea==true){out.print("disabled");}%>>-->
		<input name="chkEFItem" type="checkbox" id="chkEFItem" value="<%=i%>" <% if(isea==true | ifdisable==true){out.print("disabled");}%>>
        </td>
		<td align="center" width="10%">&nbsp;</td>
		<td align="center" width="10%">&nbsp;</td>
<%
}
else
{
	   if(iseg == true)
	   {
%>
		<td align="center" width="10%"><a href="javascript:subwinXY('../../crewEvaluation/GDRecordEdit/gdRecordEdit.jsp?fltd=<%=obj.getFltd()%>&fltno=<%=obj.getFltno()%>&sector=<%=obj.getSect()%>&item=1','wname','800','600')"><%=obj.getEfuser()%><br><%=obj.getEfuser_confirm_dt()%></a></td>
<%
		}
		else
	    {
%>
		<td align="center" width="10%"><%=obj.getEfuser()%><br><%=obj.getEfuser_confirm_dt()%></td>
<%
		}

		//ef confirmed, then msg be able to confirm
		if("".equals(obj.getEfmanager()) | obj.getEfmanager() == null)	
		{
%>
			<td align="center" width="10%">
			<!--<input name="btnmag<%=i%>" id="btnmag<%=i%>" type="button" class="txtblue" value=" Approve " onclick="confby('mag','<%=i%>')" <% if(isea==true){out.print("disabled");}%>>-->

			<input name="chkMAGItem" type="checkbox" id="chkMAGItem" value="<%=i%>" <% if(isea==true | ifdisable==true){out.print("disabled");}%>>
			</td>
			<td align="center" width="10%">&nbsp;</td>
<%
		}
		else
		{
%>
			<td align="center" width="10%"><%=obj.getEfmanager()%><br><%=obj.getEfmanager_confirm_dt()%></td>
<%
			//ef manager confirmed, then ea be able to confirm
			if("".equals(obj.getCloseuser()) | obj.getCloseuser() == null)	
			{
			%>
					<td align="center" width="10%">
					<!--<input name="btnea<%=i%>" id="btnea<%=i%>" type="button" class="txtblue" value=" Close " onclick="confby('ea','<%=i%>')" <% if(iseg==true){out.print("disabled");}%>>-->
					<input name="chkEAItem" type="checkbox" id="chkEAItem" value="<%=i%>" <% if(iseg==true | ifdisable==true){out.print("disabled");}%>>
					</td>
			<%
			}
			else
			{
			%>
					<td align="center" width="5%"><%=obj.getCloseuser()%><br><%=obj.getClose_dt()%></td>
			<%
			}	
		}	
}	
%>
		<td align="center" width="10%"><a href="javascript:crewdisp('crewview<%=i%>')"><img
		height="16" src="../../images/blue_view.gif" width="16" border="0"></a>
<%
boolean hasforeign = false;
//if(!"".equals(obj.getEfuser()) && !"".equals(obj.getEfmanager()) && obj.getEfuser() != null && obj.getEfmanager() != null )
if(!"".equals(obj.getEfuser()) && obj.getEfuser() != null)
{
	ArrayList crewAL2 = new ArrayList();
	crewAL2 = obj.getDispcrewAL();
	for(int j=0; j<crewAL2.size(); j++)
	{
		RewardCrewObj crewobj = (RewardCrewObj) crewAL2.get(j);
		if("TPE".equals(userbase))
		{
			if("KHH".equals(crewobj.getBase()) | "KIX".equals(crewobj.getBase()) |  "TYO".equals(crewobj.getBase()) | "BKK".equals(crewobj.getBase()))
			{
				hasforeign = true;
			}
		}

		if("KHH".equals(userbase))
		{
			if("TPE".equals(crewobj.getBase()) | "KIX".equals(crewobj.getBase()) |  "TYO".equals(crewobj.getBase()) | "BKK".equals(crewobj.getBase()))
			{
				hasforeign = true;
			}
		}
	}
	
	if(hasforeign == true)
	{
		if(!"".equals(obj.getEmailuser()) && obj.getEmailuser() != null)
		{
%>
		<td align="center" width="5%"><%=obj.getEmailuser()%><br><%=obj.getEmail_dt()%></td>
<%
		}
		else
		{
%>
		<td align="center" width="5%"><a href="javascript:subwinXY('emailforeignEA.jsp?idx=<%=i%>&sdate=<%=sdate%>&edate=<%=edate%>&base=<%=base%>&serial=<%=serial%>&q_status=<%=q_status%>','wname','600','600')"><img
		height="16" src="../../images/email_go.png" width="16" border="0"></a>
        </td>
<%
		}
	}
	else
	{
%>
		<td align="center" width="5%">&nbsp;</td>
<%
	}
}
else
{
%>
		<td align="center" width="5%">&nbsp;</td>
<%
}
%>
	  </tr>
	  <!--<tr class="txtblue" bgcolor="#CCFFFF">
		<td colspan="13"><div id="comm<%=i%>" name="comm<%=i%>" style="display:none">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=obj.getComments()%></div>
		</td>
	  </tr>-->
<%
		ArrayList crewAL = new ArrayList();
		crewAL = obj.getDispcrewAL();
		if(crewAL.size()>0)			
		{
%>
		 <tr class="txtblue" bgcolor="#FFFFFF">
			<td align="left" colspan="13" height="0">
			<div id="crewview<%=i%>" name="crewview<%=i%>" style="display:none">
			<table align="right" width="60%" border="1"  cellpadding="0" cellspacing="0" >
<%
			for(int j=0; j<crewAL.size(); j++)
			{
				RewardCrewObj crewobj = (RewardCrewObj) crewAL.get(j);
				if(!"ACM".equals(crewobj.getDuty()))
				{
%>
			  <tr class="txtblue" bgcolor="#FFFFFF">
				<td align="center"  class="tablehead"><%=j+1%></td>
				<td align="center" ><%=crewobj.getEmpno()%></td>
				<td align="center" ><%=crewobj.getSern()%></td>
				<td align="center" ><%=crewobj.getCname()%></td>
				<td align="center" ><%=crewobj.getDuty()%></td>
<%
	if("".equals(crewobj.getBase()) || crewobj.getBase() == null)
	{
		eg.EGInfo egi = new eg.EGInfo(crewobj.getEmpno());
        eg.EgInfoObj egobj = egi.getEGInfoObj(crewobj.getEmpno()); 
		crewobj.setBase(egobj.getStation());
	}
%>
				<td align="center" ><%=crewobj.getBase()%></td>
			  </tr>
<%
				}
			}// end of for(int j=0; j<crewAL.size(); j++)
%>
		     </table>
			 </div>
			 </td>
			 <!--************-->
		  </tr>
<%
		}//if(crewAL.size()>0)	
		  		
		}//if(ifshow == true)
	}// end of for(int i=0; i<objAL.size(); i++)
}
if(cnt<=0)
{
%>
	<tr align="center">
		<td colspan = "13" class="style4"> No Data found!!</td>
    </tr>
<%
}
else
{
%>
	<tr align="center">
		<td colspan = "13" class="style4">
		  <input name="Submit" id="Submit" type="submit" class="txtblue" value="Submit">&nbsp;
		  <input name="btn" type="button" value="Reset" class="txtblue" OnClick="document.form1.Submit.disabled=0;">		
		</td>
    </tr>
<%
}
%>
</table>
</div>
</body>
</form>
</html>

<%
}	
%>



