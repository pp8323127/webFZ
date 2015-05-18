<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=big5" language="java" import="credit.*,fzac.*"%>
<%
//response.setHeader("Cache-Control","no-cache");
//response.setDateHeader ("Expires", 0);
String userid = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || userid == null) 
{		//check user session start first
	response.sendRedirect("../../preCheckAC.jsp");
} 

String asno = (String) request.getParameter("asno");
String year = (String) request.getParameter("year");
String month = (String) request.getParameter("month");
String rEmpno = (String) request.getParameter("rEmpno");
String aEmpno = (String) request.getParameter("aEmpno");
String rsern = "";
String rcname = "";



ArrayList objAL = new ArrayList();
CreditList cl = new CreditList();
/*
	cl.getCreditList("N",rEmpno);
	objAL = cl.getObjAL();
*/
CheckFormTimes ck = new CheckFormTimes();
String result = ck.get3FormTimes(rEmpno, year , month); 
String msg = ck.getErrorstr();
if("Y".equals(result)){
	//當月三次換班>=3,才能用積點
	cl.getCreditList("N",rEmpno);
	objAL = cl.getObjAL();
	//out.println(result+msg);
}else{
	//out.println(result+msg);
}


//CrewInfo c = new CrewInfo(rEmpno);
//CrewInfoObj o = c.getCrewInfo();
eg.EGInfo egi = new eg.EGInfo(rEmpno);
eg.EgInfoObj o = egi.getEGInfoObj(rEmpno); 
%>
<html>
<head>
<title>Credit swap Skj B</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<meta http-equiv="pragma" content="no-cache">
<link href="menu.css" rel="stylesheet" type="text/css">
<style type="text/css">
.no_border
{  
border-bottom: 1.5px solid #808080 ;
border-top: 0px solid #FFFFFF ;
border-left: 0px solid #FFFFFF ;
border-right: 0px solid #FFFFFF ;
font-weight: bold;
font-size: 9pt;
}
.style1 {
	color: #FF0000;
	font-weight: bold;
}
</style>

<script language="javascript">
function conf(formname)
{	
	if(formname=='form1')
	{
		var count = 0;
		for (i=0; i<eval(document.form1.length); i++) 
		{
			if (eval(document.form1.elements[i].checked)) 
			{
				count++;
				document.form1.rsno.value=document.form1.elements[i].value;
			}
		}

		if(count < 1 | count > 1) 
		{
			alert("請勾選一個積點換取換班機會!!");
			return;
		}
		else
		{
			document.form1.btn.disabled=1;
			document.form1.btn2.disabled=1;			
			if(	confirm("確認使用 <%=o.getCname()%> ( <%=o.getSern()%> ) 積點換班 申請？"))
			{
				document.form1.source.value="credit";
				document.form1.action = "creditSwap_step5_credit.jsp";
				document.form1.submit();
			}
			else
			{
				document.form1.btn.disabled=0;
				document.form1.btn2.disabled=0;
				return;
			}
		}
	}

	if(formname=='form2')
	{
		  document.form1.btn.disabled=1;
		  document.form1.btn2.disabled=1;			
		  if(	confirm("確認使用 <%=o.getCname()%> ( <%=o.getSern()%> ) 三次換班 申請？"))
			{
				document.form1.source.value="normal";
				document.form1.action = "creditSwap_step5_normal.jsp";
				document.form1.submit();
			}
			else
			{
				document.form1.btn.disabled=0;
				document.form1.btn2.disabled=0;
				return ;
			}
	}
}
</script>


</head>
<body bgcolor="#FFFFFF" text="#000000">
<form name="form1">
<input name="rsno" type="hidden" value="">
<input type="hidden" name="year" value="<%=year%>">
<input type="hidden" name="month" value="<%=month%>">
<input type="hidden" name="aEmpno" value="<%=aEmpno%>">
<input type="hidden" name="rEmpno" value="<%=rEmpno%>">
<input type="hidden" name="asno" value="<%=asno%>">
<input type="hidden" name="source" value="">

<%
if("N".equals(result)){
 %>
<div width="80%" align="center">
    <font face="Comic Sans MS" color="#003399">使用</font><font face="Comic Sans MS"><span class="style1">三次換班</span></font><font face="Comic Sans MS" color="#003399">權利</font>
</div>
<div align="center">
    <table width="80%" border="1" cellspacing="0" cellpadding="0">
	  <tr  class="tablehead3" align="center" >
	    <td>員工號</td>
	    <td>姓名</td>
	  </tr>
	  <tr bgcolor="#FFCCFF" class="txtblue" align="center">
		  <td><%=rEmpno%>(<%=o.getSern()%>)</td>
		  <td><%=o.getCname()%></td>
      </tr>
   </table>
	<br>
	<table width="80%" border="0" cellpadding="0" cellspacing="0" align= "center">
	  <tr align="center">
		<td>
	      <div align="center">
	        <input name="btn2" type="button" value="三次換班申請" onClick="conf('form2')" >			
        </div></td>
	  </tr>
	</table>
<br>
<br>
<hr>
<br>
<br>
<%
}else if("Y".equals(result)){
 %>
<div width="80%" align="center">
    <font face="Comic Sans MS" color="#003399">使用</font><font face="Comic Sans MS"><span class="style1">積點換班</span></font><font face="Comic Sans MS" color="#003399">權利</font>
</div>
<div align="center">
    <table width="80%" border="1" cellspacing="0" cellpadding="0">
	  <tr  class="tablehead3" align="center" >
	    <td>SEQNO</td>
	    <td>員工號</td>
	    <td>姓名</td>
	    <td>積點原因</td>
	    <td>積點有效日</td>
		<td>&nbsp;</td>
	  </tr>
<%
String trbgcolor = "";
for (int i=0; i<objAL.size() ; i++)
{
	CreditObj obj = (CreditObj) objAL.get(i);
	rcname = obj.getCname();
	rsern = obj.getSern();
	if(i%2==0)
	{
		trbgcolor = "#FFCCFF";
	}
	else
	{
		trbgcolor = "#FFFFFF";
	}

%>
	  <tr bgcolor="<%=trbgcolor%>" class="txtblue">
		  <td><%=i+1%></td>
		  <td><%=obj.getEmpno()%>(<%=obj.getSern()%>)</td>
		  <td><%=obj.getCname()%></td>
		  <td><%=obj.getReason()%></td>
		  <td>&nbsp;<%=obj.getEdate()%></td>
		  <td align= "center"><input name="chkItem" type="checkbox" id="chkItem" value="<%=obj.getSno()%>"></td>
      </tr>
<%
}//for (int i=0; i<objAL()-1 ; i++)
%>
<%
if (objAL.size()<=0)
{
%>
	  <tr>
	    <td colspan = "6" align="center" class="txtxred" bgcolor=#CCCCFF>N/A</td>
	  </tr>

<%
}
%>
  </table>

	<br>
	<table width="80%" border="0" cellpadding="0" cellspacing="0" align= "center">
	  <tr align="center">
		<td>
	      <div align="center">
<%
if(objAL.size()>0)
{
%>
	        <input name="btn" type="button" value="積點換班申請" onClick="conf('form1')" >			
<%
}
else
{
%>
	       <input name="btn" type="button" value="積點換班申請" disabled>			
<%
}	
%>
        </div></td>
	  </tr>
	</table>
</form>
<%
}else{
out.println(result);
}
 %>	
 <!-- <div align="center">
    <table width="80%" border="0" cellspacing="0" cellpadding="0">
	  <tr height ="20">
	    <td><font face="Comic Sans MS" class="txtxred" size="10pt">*  請選擇使用『積點換班權利』或『三次換班權利』</font></td>
	  </tr>
    </table>
</div> -->
</body>
</html>