<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="eg.css.*" %>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String userid = (String) session.getAttribute("userid") ; //get user id if already login
String seq = (String) session.getAttribute("seq") ; 
String caseno = (String) request.getParameter("caseno") ; 
String bgColor= "bgcolor=\"#CCFFFF\"";
int count =0;

if (userid == null) 
{		
	response.sendRedirect("../../../FZ/sendredirect.jsp");
}
if(userid.equals("633020")){
	seq ="84";
	caseno="2012CIWEB04763";
}
PURCSSConfirm ccr =  new PURCSSConfirm();
ccr.getCpsCssRecord(caseno);
//out.println(ccr.getSql());

ArrayList objAL = new ArrayList();
objAL = ccr.getObjAL();
//out.println(ccr.getSql());
%>
<html>
<head>
<title></title>
<link rel="StyleSheet" href="style.css" type="text/css" />
<style type="text/css">
<!--
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
.style5 {color: #006699}
.style6 {font-size: 14pt}
-->
</style>

<script language=javascript>
function s_form()
{
	//alert("檢視完畢後則無法再查詢此份查核報告,欲保留請預先列印");
	flag = confirm("檢視完畢確認?");
	if (flag == true) 
	{
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
<div align="center">
<p align="center" class="style5 style6"><b>CSS Record</b></p>
<table width="90%"  border="1" cellpadding="0" cellspacing="0">
<%
if(objAL.size()>0)
{
	CpsCssObj dispobj = (CpsCssObj) objAL.get(0);
	String tempdesc = dispobj.getDescription();
	String tempinves = dispobj.getInvestigation();
	if(!"".equals(tempdesc) && tempdesc != null)
	{
		tempdesc = tempdesc.replaceAll("\r\n","<br>");
	}

	if(!"".equals(tempinves) && tempinves != null)
	{
		tempinves = tempinves.replaceAll("\r\n","<br>");
	}

	String subject = dispobj.getSubject();
	String result  = dispobj.getRdetail();

	String category  = dispobj.getCategory();
	String dept = dispobj.getDept();
	String item  = dispobj.getItem();
	String detail = dispobj.getDetail();
	String fltd = dispobj.getFlight_date();
	String fltno = dispobj.getFlight_no();
	String sect = dispobj.getOrigin()+"/"+dispobj.getDestination();
%>
	  <tr class="tablehead">
			<td colspan="2">CaseNo</td>
			<td colspan="2">Subject</td>
			<td colspan="3">Result</td>
	  </tr>
	  <tr class="txtblue" <%=bgColor%> >
		<td align="center" colspan="2"><%=caseno%></td>
		<td align="center" colspan="2"><%=subject%></td>
		<td align="center" colspan="3" ><%=result%></td>
	 </tr>
	 <tr class="tablehead">
		<td>Category</td>
		<td>Sub Category </td>
		<td>Group</td>
		<td>Code</td>
		<td>Fltd</td>
		<td>Fltno</td>
		<td>Sect</td>
    </tr>
	  <tr class="txtblue" <%=bgColor%> >
		<td align="center"><%=category%></td>
		<td align="center"><%=dept%></td>
		<td align="center"><%=item%></td>
		<td align="center"><%=detail%></td>
		<td align="center"><%=fltd%></td>
		<td align="center"><%=fltno%></td>
		<td align="center"><%=sect%></td>
	 </tr>
	 <tr class="tablehead">
		<td>Empno</td>
		<td>Sern</td>
		<td>Name</td>
		<td>Group</td>
		<td colspan="3">&nbsp;</td>
    </tr>
<%
	for(int i=0; i<objAL.size(); i++)
	{
		CpsCssObj obj = (CpsCssObj) objAL.get(i);
	
%>
	  <tr class="txtblue" <%=bgColor%> >
		<td align="center"><%=obj.getRid()%></td>
		<td align="center"><%=obj.getRsern()%></td>
		<td align="center"><%=obj.getRname()%></td>
		<td align="center"><%=obj.getRgroup()%></td>
		<td align="center" colspan="3">&nbsp;</td>
	 </tr>
<%
	}	
%>
	 <tr class="txtblue" >
		<td align="center" class="tablehead">事件<br>描述</td>
		<td align="left" colspan="6"><%=tempdesc%></td>
	 </tr>
	 <tr class="txtblue">
		<td align="center" class="tablehead">調查<br>報告</td>
		<td align="left" colspan="6"><%=tempinves%></td>
     </tr>
<%
}
else
{
%>
	<tr align="center">
		<td colspan = "7" class="style4"> No Data found!!</td>
    </tr>
<%
}
%>
</table>

<table width="90%"   align="center"> 
<tr><td align="center">
<form name="form1" method="post" target="mainFrame" action="doCaseConfirm2.jsp" onSubmit="return s_form();">
  <input type="hidden" name="seq" id="seq" value="<%=seq%>">
  <input type="hidden" name="caseno" id="caseno" value="<%=caseno%>">
  <input type="submit" name="Submit" value="檢視完畢">
</form>
</td>
</tr>
</table>
</body>
</html>





