<%@page import="java.util.ArrayList"%>
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
<script language="javascript" type="text/javascript">
function pnum(divnum, divname)
{
	var tnum = document.getElementById(divnum).value;

	if(parseInt(tnum) > 0)
	{
		document.getElementById(divname).style.display = "";
	}
	else
	{
		document.getElementById(divname).style.display = "none";
	}
	return
}	

function expcls(divname)
{
	if(document.getElementById(divname).style.display == "none")
	{
		document.getElementById(divname).style.display = "";
	}
	else
	{
		document.getElementById(divname).style.display = "none";
	}
	return
}	

function countcnum_bk(formName,elementName)
{
	var cnum = 0;
	var cstr = "";

　　for(var i = 0; i < document.forms[formName].elements[elementName].length; i++)
	{
		if(document.forms[formName].elements[elementName][i].checked)
		{
　　　　	cnum ++;
			//cstr = cstr + elementName+"-"+document.forms[formName].elements[elementName][i].value+",";
			cstr = cstr + document.forms[formName].elements[elementName][i].value+"-";
		}
    }

	document.getElementById("c"+elementName).value = cnum;
	document.getElementById("duty-"+elementName).value = cstr;
}

function countpnum_bk(formName,elementName)
{
	var pnum = 0;
	var pstr = "";

　　for(var i = 0; i < document.forms[formName].elements[elementName].length; i++)
	{
		if(document.forms[formName].elements[elementName][i].checked)
		{
　　　　	pnum ++;
			//pstr = pstr + elementName+"-"+document.forms[formName].elements[elementName][i].value+",";
			pstr = pstr + document.forms[formName].elements[elementName][i].value+"-";
		}
    }
	document.getElementById("c"+elementName).value = pnum;
	document.getElementById("duty-"+elementName).value = pstr;
}	


function chkall_bk(formName,elementName)
{
　　for(var i = 0; i < document.forms[formName].elements[elementName].length; i++)
	{
		if(document.forms[formName].elements[elementName][i].checked)
		{
			document.forms[formName].elements[elementName][i].checked = false;
		}
		else
		{
			document.forms[formName].elements[elementName][i].checked = true;
		}
    }
	countcnum(formName,elementName);
	countpnum(formName,elementName);

	return;
}	

function countcnum(formName,elementName)
{
	var cnum = 0;
	var cstr = "";

　　for(var i = 0; i < document.getElementsByName(elementName).length; i++)
	{
		if(document.getElementsByName(elementName)[i].checked)
		{
　　　　	cnum ++;
			//cstr = cstr + elementName+"-"+document.forms[formName].elements[elementName][i].value+",";
			cstr = cstr + document.getElementsByName(elementName)[i].value+"-";
		}
    }

	document.getElementById("c"+elementName).value = cnum;
	document.getElementById("duty-"+elementName).value = cstr;
}

function countpnum(formName,elementName)
{
	var pnum = 0;
	var pstr = "";

　　for(var i = 0; i < document.getElementsByName(elementName).length; i++)
	{
		if(document.getElementsByName(elementName)[i].checked)
		{
　　　　	pnum ++;
			//pstr = pstr + elementName+"-"+document.forms[formName].elements[elementName][i].value+",";
			pstr = pstr + document.getElementsByName(elementName)[i].value+"-";
		}
    }
	document.getElementById("c"+elementName).value = pnum;
	document.getElementById("duty-"+elementName).value = pstr;
}	


function chkall(formName,elementName)
{
　　for(var i = 0; i < document.getElementsByName(elementName).length; i++)
	{
		if(document.getElementsByName(elementName)[i].checked)
		{
			document.getElementsByName(elementName)[i].checked = false;
		}
		else
		{
			document.getElementsByName(elementName)[i].checked = true;
		}
    }
	countcnum(formName,elementName);
	countpnum(formName,elementName);

	return;
}	


function submitfun()
{
	document.form1.Submit.disabled=1;
}	

</script>

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
String topic_no = request.getParameter("topic_no");
String fleet = request.getParameter("fleet");
String acno = request.getParameter("acno");
//***********************************************
ArrayList dutyAL = new ArrayList();
//out.print(dutyAL.size());
//***********************************************
//out.println(topic_no+"  **  "+fltdt+"  **  "+fltno+"  **  "+ sect.substring(0,3)+"  **  "+sect.substring(3)+"  **  "+sGetUsr+"  **  "+fleet+"  **  "+acno);
PRSFlyIssue psf = new PRSFlyIssue();
ArrayList bankItemobjAL = new ArrayList();
ArrayList objAL = new ArrayList();
psf.getBankItemno(topic_no);//blank 
bankItemobjAL = psf.getBankObjAL();
//out.println(bankItemobjAL.size());
psf.getBankItemno(topic_no,fltdt, fltno, sect.substring(0,3),sect.substring(3),sGetUsr,fleet,acno);
objAL = psf.getBankObjAL();      
//out.println(objAL.size());
//out.println(bankItemobjAL.size());


//get Crew List*************************************************************************
ArrayList crewcnameAL = new ArrayList();
ArrayList crewempnAL = new ArrayList();
ArrayList crewsernAL = new ArrayList();

Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
ResultSet rs = null;
String sql = null;
try
{
	ConnDB cn = new ConnDB();
	cn.setORP3EGUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
	stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);

	//抓取該班組員名單
	sql = "select * from egtcflt where fltd=to_date('"+fltdt+"','yyyy/mm/dd') and fltno='"+fltno+"' and sect=upper('"+sect+"')";
	rs	= stmt.executeQuery(sql);
	if(rs != null)
	{
		while(rs.next())
		{
			for(int i=0; i<20; i++)
			{
				if(!rs.getString("sern"+String.valueOf(i+1)).equals("0") && null !=rs.getString("sern"+String.valueOf(i+1)) )
				{
					crewsernAL.add(rs.getString("sern"+String.valueOf(i+1)));
					crewcnameAL.add(rs.getString("crew"+String.valueOf(i+1)));
					crewempnAL.add(rs.getString("empn"+String.valueOf(i+1)));
				}
			}
		}
	}
} 
catch (SQLException e) 
{
	System.out.print(e.toString());
} 
catch (Exception e) 
{
	System.out.print(e.toString());
}
finally
{
	try{if(rs != null) rs.close();}catch (Exception e){}
	try{if(stmt != null) stmt.close();}catch (Exception e){}
	try{if(conn != null) conn.close();}catch (Exception e){}        	
}
%>
<body>
<form name="form1" method="post" action="updPSFLY.jsp" onsubmit="return submitfun();">
<input type="hidden" id="fltdt" name="fltdt" value ="<%=fltdt%>" > 
<input type="hidden" id="fltno" name="fltno" value ="<%=fltno%>"> 
<input type="hidden" id="sect" name="sect" value ="<%=sect%>"> 
<input type="hidden" id="topic_no" name="topic_no" value ="<%=topic_no%>"> 
<input type="hidden" id="fleet" name="fleet" value ="<%=fleet%>"> 
<input type="hidden" id="acno" name="acno" value ="<%=acno%>"> 
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
//for(int i=0; i<objAL.size(); i++)
for(int i=0; i<bankItemobjAL.size(); i++)
{
	//PRSFlyFactorObj obj = (PRSFlyFactorObj) objAL.get(i);
	PSFlyIssueObj obj = (PSFlyIssueObj) bankItemobjAL.get(i);	
	//******************************************************
	dutyAL.clear();
	if("738".equals(fleet))
	{
		dutyAL.add("PUR");
		dutyAL.add("1R");
		//dutyAL.add("2L");
		//dutyAL.add("2R");
		dutyAL.add("3L");
		dutyAL.add("3R");
		dutyAL.add("3RA");
		dutyAL.add("Z2");
		dutyAL.add("FLIGHT CREW");
	}
	else if("333".equals(fleet))
	{
		dutyAL.add("PUR");
		for(int d=1; d<=4; d++)
		{
			dutyAL.add(d+"L");
			dutyAL.add(d+"R");
		}
		dutyAL.add("Z1");
		dutyAL.add("Z2");
		dutyAL.add("Z3");
		dutyAL.add("FLIGHT CREW");
	}
	else if("343".equals(fleet))
	{
		dutyAL.add("PUR");
		for(int d=1; d<=4; d++)
		{
			dutyAL.add(d+"L");
			dutyAL.add(d+"R");
		}
		dutyAL.add("Z1");
		dutyAL.add("Z3");
		dutyAL.add("FLIGHT CREW");
	}
	else if("74C".equals(fleet))
	{
		dutyAL.add("PUR");
		for(int d=1; d<=5; d++)
		{
			dutyAL.add(d+"L");
			dutyAL.add(d+"R");
		}
		dutyAL.add("3LA");
		dutyAL.add("3RA");
		dutyAL.add("Z1");
		dutyAL.add("Z3");
		dutyAL.add("UDL");
		dutyAL.add("UDR");
		dutyAL.add("UDZ");
		dutyAL.add("UDA"); 
		dutyAL.add("DFA"); 
		dutyAL.add("FLIGHT CREW");
	}
	else
	{
		dutyAL.add("PUR");
		for(int d=1; d<=5; d++)
		{
			dutyAL.add(d+"L");
			dutyAL.add(d+"R");
		}
		dutyAL.add("3LA");
		dutyAL.add("3RA");
		dutyAL.add("Z1");
		dutyAL.add("Z2");
		dutyAL.add("Z3");
		dutyAL.add("UDL");
		dutyAL.add("UDR");
		dutyAL.add("UDZ");
		dutyAL.add("DFA"); 
		dutyAL.add("FLIGHT CREW");
	}
    //**********************************************

	if(!"".equals(obj.getCheck_duty()) && obj.getCheck_duty() !=null)
	{//代表有preset check_duty
		dutyAL.clear();
		tool.splitString p = new tool.splitString();
	    dutyAL = p.doSplit2(obj.getCheck_duty(),"/");
	}
%>
<table width="95%" border="1" align="center" cellpadding="0" cellspacing="0" >
	<tr>
	  <td width = "4%"><div class = "txtblue" align="center"><%=(i+1)%></div></td>
	  <td width = "5%"><div class = "txtblue" align="center"><%=obj.getTopic_no()%>-<%=obj.getItemno()%></div></td>
	  <td width = "16%"><div class = "txtblue" align="left">&nbsp;<%=obj.getItemdesc()%></div></td>
<%
if("A".equals(obj.getPsfm_itemno()))
{	
%>
	  <td width = "35%"><div class = "txtblue" align="left"> 
<%
	   String tempcnum = "0";
	   String tempdutycnum = "";
	   //initial duty total 20
	   for(int d=0; d<dutyAL.size(); d++)
	   {
		 String ifcheck1 = "";
		 //check inserted duty 
		 for(int o=0; o<objAL.size(); o++)
		 {
			 PRSFlyFactorObj insertedobj = (PRSFlyFactorObj) objAL.get(o);
			 if(obj.getTopic_no().equals(insertedobj.getTopic_no()) && obj.getItemno().equals(insertedobj.getItemno()))
			 {//Same Topic
			     tempcnum = insertedobj.getNum_satisfy();
				 tempdutycnum = insertedobj.getDuty_satisfy();
				 if(insertedobj.getDuty_satisfy() != null && !"".equals(insertedobj.getDuty_satisfy()))
				 {
					if(insertedobj.getDuty_satisfy().indexOf(((String)dutyAL.get(d))+"-") >= 0 )
					{
						ifcheck1 = "checked";
					}
				 }
			 }
		 }//for(int o=0; o<objAL.size(); o++)
%>
		<input type="checkbox" name="cnum<%=obj.getTopic_no()%>-<%=obj.getItemno()%>"  id="cnum<%=obj.getTopic_no()%>-<%=obj.getItemno()%>" value = "<%=dutyAL.get(d)%>" onclick= "countcnum('form1','cnum<%=obj.getTopic_no()%>-<%=obj.getItemno()%>')" <%=ifcheck1%>> <%=dutyAL.get(d)%>
<%
	   }//for(int d=0; d<dutyAL.size(); d++)	
%>
		&nbsp;<a href="javascript:chkall('form1','cnum<%=obj.getTopic_no()%>-<%=obj.getItemno()%>');"><img src="../../images/ed1.gif" width="16" height="16" border="0" alt="Check/UnCheck ALL" title="Check/UnCheck ALL"></a>
		&nbsp;&nbsp;<span class="txtxred">Count:
		<input name="ccnum<%=obj.getTopic_no()%>-<%=obj.getItemno()%>" type="text" id="ccnum<%=obj.getTopic_no()%>-<%=obj.getItemno()%>" size="2" maxlength="2" value="<%=tempcnum%>" readonly></span>
		<input type="hidden" id="duty-cnum<%=obj.getTopic_no()%>-<%=obj.getItemno()%>" name="duty-cnum<%=obj.getTopic_no()%>-<%=obj.getItemno()%>" value="<%=tempdutycnum%>"> 
      </div></td>

	  <td width = "35%"><div class = "txtblue" align="left">
<%
	   String temppnum = "0";
	   String tempdutypnum = "";
	   for(int d=0; d<dutyAL.size(); d++)
	   {
		 String ifcheck2 = "";
		 //check inserted duty 
		 for(int o=0; o<objAL.size(); o++)
		 {
			 PRSFlyFactorObj insertedobj = (PRSFlyFactorObj) objAL.get(o);
			 if(obj.getTopic_no().equals(insertedobj.getTopic_no()) && obj.getItemno().equals(insertedobj.getItemno()))
			 {//Same Topic
				 temppnum = insertedobj.getNum_needtoimprove();
				 tempdutypnum = insertedobj.getDuty_needtoimprove();
				 if(insertedobj.getDuty_needtoimprove() != null && !"".equals(insertedobj.getDuty_needtoimprove()))
				 {
					if(insertedobj.getDuty_needtoimprove().indexOf(((String)dutyAL.get(d))+"-") >= 0 )
					{
						ifcheck2 = "checked";
					}
				 }
			 }
		 }//for(int d=0; d<dutyAL.size(); d++)
%>
		<input type="checkbox" name="pnum<%=obj.getTopic_no()%>-<%=obj.getItemno()%>"  id="pnum<%=obj.getTopic_no()%>-<%=obj.getItemno()%>" value = "<%=dutyAL.get(d)%>" onclick= "countpnum('form1','pnum<%=obj.getTopic_no()%>-<%=obj.getItemno()%>');pnum('cpnum<%=obj.getTopic_no()%>-<%=obj.getItemno()%>','factor<%=obj.getTopic_no()%>-<%=obj.getItemno()%>')" <%=ifcheck2%>><%=dutyAL.get(d)%>
<%
	   }//for(int d=0; d<dutyAL.size(); d++)	
%>
		&nbsp;<a href="javascript:chkall('form1','pnum<%=obj.getTopic_no()%>-<%=obj.getItemno()%>');"><img src="../../images/ed1.gif" width="16" height="16" border="0" alt="Check/UnCheck ALL" title="Check/UnCheck ALL"></a>
		&nbsp;&nbsp;<span class="txtxred">Count: 
	    <input name="cpnum<%=obj.getTopic_no()%>-<%=obj.getItemno()%>" type="text" id="cpnum<%=obj.getTopic_no()%>-<%=obj.getItemno()%>" size="2" maxlength="2" value="<%=temppnum%>" readonly>
		<a href="javascript:expcls('factor<%=obj.getTopic_no()%>-<%=obj.getItemno()%>');"><img src="../../images/d2.gif" width="16" height="16" border="0" alt="Expand/Close" title="Expand/Close"></a>
		<input type="hidden" id="duty-pnum<%=obj.getTopic_no()%>-<%=obj.getItemno()%>" name="duty-pnum<%=obj.getTopic_no()%>-<%=obj.getItemno()%>" value="<%=tempdutypnum%>"> 
		</div></td>
<%
}
else
{//服儀自我督察
%>
	  <td width = "35%"><div class = "txtblue" align="left"> 
<%
	   String tempcnum = "0";
	   String tempdutycnum = "";
	   //initial duty total 20
	   for(int d=0; d<crewempnAL.size(); d++)
	   {
		 String ifcheck1 = "";
		 //check inserted duty 
		 for(int o=0; o<objAL.size(); o++)
		 {
			 PRSFlyFactorObj insertedobj = (PRSFlyFactorObj) objAL.get(o);
			 if(obj.getTopic_no().equals(insertedobj.getTopic_no()) && obj.getItemno().equals(insertedobj.getItemno()))
			 {//Same Topic
			     tempcnum = insertedobj.getNum_satisfy();
				 tempdutycnum = insertedobj.getDuty_satisfy();
				 if(insertedobj.getDuty_satisfy() != null && !"".equals(insertedobj.getDuty_satisfy()))
				 {
					//if(insertedobj.getDuty_satisfy().indexOf(((String)crewempnAL.get(d))+"-") >= 0 )
				    if(insertedobj.getDuty_satisfy().indexOf(((String)crewsernAL.get(d))+"-") >= 0 )
					{
						ifcheck1 = "checked";
					}
				 }
			 }
		 }//for(int o=0; o<objAL.size(); o++)
%>
		<input type="checkbox" name="cnum<%=obj.getTopic_no()%>-<%=obj.getItemno()%>"  id="cnum<%=obj.getTopic_no()%>-<%=obj.getItemno()%>" value = "<%=crewsernAL.get(d)%>" onclick= "countcnum('form1','cnum<%=obj.getTopic_no()%>-<%=obj.getItemno()%>')" <%=ifcheck1%>><%=crewsernAL.get(d)%> <%=crewcnameAL.get(d)%>
<%
		if((d+1)%3==0)
		{
			out.println("<br>");
		}

	   }//for(int d=0; d<crewempnAL.size(); d++)	
%>
		&nbsp;<a href="javascript:chkall('form1','cnum<%=obj.getTopic_no()%>-<%=obj.getItemno()%>');"><img src="../../images/ed1.gif" width="16" height="16" border="0" alt="Check/UnCheck ALL" title="Check/UnCheck ALL"></a>
		&nbsp;&nbsp;<span class="txtxred">Count:
		<input name="ccnum<%=obj.getTopic_no()%>-<%=obj.getItemno()%>" type="text" id="ccnum<%=obj.getTopic_no()%>-<%=obj.getItemno()%>" size="2" maxlength="2" value="<%=tempcnum%>" readonly></span>
		<input type="hidden" id="duty-cnum<%=obj.getTopic_no()%>-<%=obj.getItemno()%>" name="duty-cnum<%=obj.getTopic_no()%>-<%=obj.getItemno()%>" value="<%=tempdutycnum%>"> 
      </div></td>

	  <td width = "35%"><div class = "txtblue" align="left">
<%
	   String temppnum = "0";
	   String tempdutypnum = "";
	   for(int d=0; d<crewsernAL.size(); d++)
	   {
		 String ifcheck2 = "";
		 //check inserted duty 
		 for(int o=0; o<objAL.size(); o++)
		 {
			 PRSFlyFactorObj insertedobj = (PRSFlyFactorObj) objAL.get(o);
			 if(obj.getTopic_no().equals(insertedobj.getTopic_no()) && obj.getItemno().equals(insertedobj.getItemno()))
			 {//Same Topic
				 temppnum = insertedobj.getNum_needtoimprove();
				 tempdutypnum = insertedobj.getDuty_needtoimprove();
				 if(insertedobj.getDuty_needtoimprove() != null && !"".equals(insertedobj.getDuty_needtoimprove()))
				 {
					if(insertedobj.getDuty_needtoimprove().indexOf(((String)crewsernAL.get(d))+"-") >= 0 )
					{
						ifcheck2 = "checked";
					}
				 }
			 }
		 }//for(int d=0; d<crewsernAL.size(); d++)
%>
		<input type="checkbox" name="pnum<%=obj.getTopic_no()%>-<%=obj.getItemno()%>"  id="pnum<%=obj.getTopic_no()%>-<%=obj.getItemno()%>" value = "<%=crewsernAL.get(d)%>" onclick= "countpnum('form1','pnum<%=obj.getTopic_no()%>-<%=obj.getItemno()%>');pnum('cpnum<%=obj.getTopic_no()%>-<%=obj.getItemno()%>','factor<%=obj.getTopic_no()%>-<%=obj.getItemno()%>')" <%=ifcheck2%>><%=crewsernAL.get(d)%> <%=crewcnameAL.get(d)%>
<%
		if((d+1)%3==0)
		{
			out.println("<br>");
		}
	   }//for(int d=0; d<crewsernAL.size(); d++)	
%>
		&nbsp;<a href="javascript:chkall('form1','pnum<%=obj.getTopic_no()%>-<%=obj.getItemno()%>');"><img src="../../images/ed1.gif" width="16" height="16" border="0" alt="Check/UnCheck ALL" title="Check/UnCheck ALL"></a>
		&nbsp;&nbsp;<span class="txtxred">Count: 
	    <input name="cpnum<%=obj.getTopic_no()%>-<%=obj.getItemno()%>" type="text" id="cpnum<%=obj.getTopic_no()%>-<%=obj.getItemno()%>" size="2" maxlength="2" value="<%=temppnum%>" readonly>
		<a href="javascript:expcls('factor<%=obj.getTopic_no()%>-<%=obj.getItemno()%>');"><img src="../../images/d2.gif" width="16" height="16" border="0" alt="Expand/Close" title="Expand/Close"></a>
		<input type="hidden" id="duty-pnum<%=obj.getTopic_no()%>-<%=obj.getItemno()%>" name="duty-pnum<%=obj.getTopic_no()%>-<%=obj.getItemno()%>" value="<%=tempdutypnum%>"> 
		</div></td>
<%
}//服儀自我督察end
%>
	</tr>
</table>
<%
     //**************************************
	 ArrayList factorAL = new ArrayList();
	 PSFlyFactor psff = new PSFlyFactor();
	 psff.getFactorList("Y", obj.getPsfm_itemno());
	 factorAL = psff.getFactorAL();
	 if(factorAL.size()>0)
	 {
%>
<div width="95%" align = "center" id="factor<%=obj.getTopic_no()%>-<%=obj.getItemno()%>" style="display:none;">
<table width="95%" border="1" align="center" cellpadding="0" cellspacing="0" bgcolor = "#ECF2F6">
<tr>
<td width="5%" class ="txtblue" align = "center">請<br>勾<br>選<br>原<br>因</td>
<td>
<!--Main table-->
<table width="100%" border="1" align="center" cellpadding="0" cellspacing="0" bgcolor = "#ECF2F6">
<%
	for(int m=0; m<factorAL.size(); m++)
	{
		PSFlyFactorObj objf = (PSFlyFactorObj) factorAL.get(m);
		if(m==0)
		{	
%>
		  <tr class="tablehead3">
			<td width="5%" class="tablehead3"><strong><%=objf.getFactor_no()%></strong></td>
			<td width="60%" class="tablehead3"><div align="left"><strong><%=objf.getFactor_desc()%></strong></div></td>
			<td width="5%" class="tablehead3"><div align="center"><strong>Check</strong></div></td>
			<td width="30%" class="tablehead3"><div align="center"><strong>Description</strong></div></td>
		  </tr>
  <%
		}
		else
		{
			PSFlyFactorObj obj1 = (PSFlyFactorObj) factorAL.get(m-1);
			PSFlyFactorObj obj2 = (PSFlyFactorObj) factorAL.get(m);
			if(!obj1.getFactor_no().equals(obj2.getFactor_no()))
			{
%>
			  <tr class="tablehead3">
				<td width="5%" class="tablehead3"><strong><%=objf.getFactor_no()%></strong></td>
				<td width="60%" class="tablehead3"><div align="left"><strong><%=objf.getFactor_desc()%></strong></div></td>
				<td width="5%" class="tablehead3"><div align="center"><strong>Check</strong></div></td>
			    <td width="30%" class="tablehead3"><div align="center"><strong>Description</strong></div></td>
			  </tr>
  <%
			}
		}	

		String  iffactorcheck = "";		
		String  iffactor_desc = "";		
		//check inserted data 
		for(int o=0; o<objAL.size(); o++)
		{
			PRSFlyFactorObj insertedobj = (PRSFlyFactorObj) objAL.get(o);
			if(obj.getTopic_no().equals(insertedobj.getTopic_no()) && obj.getItemno().equals(insertedobj.getItemno()))
			{//Same Topic
				if(objf.getFactor_sub_no().equals(insertedobj.getFactor_sub_no()) && objf.getFactor_no().equals(insertedobj.getFactor_no()) && (insertedobj.getFactor_sub_no() != null && !"".equals(objf.getFactor_sub_no())))
				{
					iffactorcheck = "checked";
					iffactor_desc = insertedobj.getDesc_needtoimprove();
				}
			}
		}//for(int o=0; o<objAL.size(); o++)
%>
	  <tr>
			<td width="5%" class="txtblue" align = "right"><strong><%=objf.getFactor_sub_no()%></strong></td>
			<td width="60%"class="txtblue"><div align="left"><strong><%=objf.getFactor_sub_desc()%></strong></div></td>
			<td width="5%"><div align="center" class="style8"><input type="checkbox" name="checkfactor"  id="checkfactor" value="<%=obj.getTopic_no()%>-<%=obj.getItemno()%>/<%=objf.getFactor_no()%>-<%=objf.getFactor_sub_no()%>" <%=iffactorcheck%>></div></td>
			<td width="5%"><div align="center" class="style8"><input type="text" size = "50" maxlength = "100" name="desc-<%=obj.getTopic_no()%>-<%=obj.getItemno()%>/<%=objf.getFactor_no()%>-<%=objf.getFactor_sub_no()%>"  id="desc-<%=obj.getTopic_no()%>-<%=obj.getItemno()%>/<%=objf.getFactor_no()%>-<%=objf.getFactor_sub_no()%>" value="<%=iffactor_desc%>"></div></td>
	  </tr>
<%
	}//for(int m=0; m<factorAL.size(); m++)
%>	
</table>
<!--Main table-->
</td>
</tr>
</table>
</div>
<%
    }//if(factorAL.size())
}//for(int i=0; i<bankItemobjAL.size(); i++)	
%>
<p>
<div width="95%" align = "center">
<input type="submit" value="&nbsp;&nbsp;&nbsp;&nbsp;Save&nbsp;&nbsp;&nbsp;&nbsp;" name="Submit" id="Submit" >
</div>

</form>
</body>
</html>
