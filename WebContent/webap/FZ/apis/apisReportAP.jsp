<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="apis.*" %>
<%@page import="java.util.*,java.text.*" %>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" href="style.css" type="text/css">
<script language="JavaScript" type="text/JavaScript">
function abc() 
{
if(document.layers) eval('document.layers["load"].visibility="hidden"')
else eval('document.all["load"].style.visibility="hidden"');
}

if(document.layers) document.write('<layer id="load" z-index=1000>');
else document.write('<div id="load" style="position: absolute;width: 100% ; height: 110% ; top: 0px; left: 0px;z-index:1000px;">');
document.write(" <center>");
document.write("  <table border=0 cellpadding=0 cellspacing=0 style='border-collapse: collapse' width='505'>");
document.write("    <tr><br><br><br><br><br> ");
document.write("      <td align='center' width='505' nowrap> ");
document.write("        <p align='center'><font face='Arial, Helvetica, sans-serif' size='3'><b><strong>APIS Data Retrieving, Please wait.....</strong></font></td>");
document.write("    </tr>");
document.write("    <tr> ");
document.write("      <td align='center' width='505' nowrap> ");
document.write("        <form name='loaded'>");
document.write("          <div align=center> ");
document.write("            <p>");
document.write("              &nbsp;<input name='chart' size='100' style='border:1px ridge #000000; background-color: #FFFFFF; color: #000000; font-family: Arial; font-size:8 pt; padding-left:4; padding-right:4; padding-top:1; padding-bottom:1'>&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name='percent' size='8' style='border:1px ridge #000000; color: #000000; text-align: center; background-color:#FFFFFF'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");

var bar = 0
var line = ' |'
var amount =' |'
count()
function count(){
	bar= bar+1
	amount =amount  +  line
	document.loaded.chart.value=amount
	document.loaded.percent.value=bar+'%'
	if (bar<99)
	{setTimeout('count()',5);}
}
document.write("            </p>");
document.write("          </div>");
document.write("        </form>");
document.write("        <p align='center'></p>");
document.write("      </td>");
document.write("    </tr>");
document.write("  </table>");
document.write(" </center>");
if(document.layers) document.write('</layer>');
else document.write('</div>');
</script>
<style type="text/css">
<!--
.style1 {color: #0000FF}
.style4 {
	font-size: 18px;
	color: #FF0000;
	font-weight: bold;
}
-->
</style>
</head>
<body>
<%
out.flush();
String type = "ALL";
java.util.Date curDate = Calendar.getInstance().getTime();
String syyyy = new SimpleDateFormat("yyyy",Locale.UK).format(curDate);
String smm = new SimpleDateFormat("MM",Locale.UK).format(curDate);
String sdd = new SimpleDateFormat("dd",Locale.UK).format(curDate);
Calendar now = new GregorianCalendar();
now.add(Calendar.HOUR_OF_DAY, 6);  
java.util.Date eDate = now.getTime();        
String eyyyy = new SimpleDateFormat("yyyy",Locale.UK).format(eDate);
String emm = new SimpleDateFormat("MM",Locale.UK).format(eDate);
String edd = new SimpleDateFormat("dd",Locale.UK).format(eDate);

String sdt = syyyy+"/"+smm+"/"+sdd;
String edt = eyyyy+"/"+emm+"/"+edd;

ArrayList objAL = new ArrayList();
String bgColor = "";
ChkAPIS2 c = new ChkAPIS2();
c.ChkApisEmpty(sdt,edt,type);
String returnstr = c.getStr();
int total = c.getCount();
%>
<table width="98%"  border="0">
  <tr>
    <td width="72%" align="center"><span class="txttitletop">APIS Check Report</span></td>
	<td width="27%"><span class="txtxred" align="right"><strong> &lt; Red grid means blank &gt;</strong></span></td>
    <td width="1%"></td>
  </tr>
</table>
<table width="70%"  border="0" cellpadding="3" cellspacing="3">
  <tr valign="middle" bgcolor="#60a3bf" class="tablehead">
    <td height="22"><span class="style11">BORDER</span></td>
    <td><span class="style11">FLTNO</span></td>
    <td><span class="style11">FDATE</span></td>
    <td><span class="style11">EMPNO</span></td>
    <td><span class="style11">NAME</span></td>
    <td><span class="style11">DPT</span></td>
    <td><span class="style11">DEST</span></td>
    <td><span class="style11">STATUS</span></td>
    <td><span class="style11">BIRTH</span></td>
    <td><span class="style11">BIRTH<br>CITY</span></td>
    <td><span class="style11">BIRTH<br>CTRY</span></td>
    <td><span class="style11">RESI<br>CTRY</span></td>
    <td><span class="style11">PASSPORT</span></td>
	<td><span class="style11">PASS<br>CTRY</span></td>
    <td><span class="style11">DOC<br>TYPE</span></td>
    <td><span class="style11">PASS<br>EXP</span></td>
    <td><span class="style11">CERTNO</span></td>
    <td><span class="style11">CERTCTRY</span></td>
    <td><span class="style11">CERT<br>DOC<br>TYPE</span></td>
	<td><span class="style11">CERTEXP</span></td>
  </tr>
<%
if("Y".equals(returnstr))
{
	objAL = c.getObjAL();
    if(objAL.size() > 0)
	{
		for(int i=0; i<objAL.size(); i++)
		{ 
			if((i%2)==1)
			{
				bgColor=" bgcolor=\"#FFFFFF\"";
			}
			else
			{
				bgColor=" bgcolor=\"#CCFFFF\"";
			}

			APISObj obj = (APISObj) objAL.get(i);
%>
			<tr valign="middle" class="txtblue" <%=bgColor%> >		
<%	if("ANC,ATL,BNA,BOS,CVG,DEN,DFW,GUM,HNL,HOU,JFK,LAS,LAX,MIA,NYC,ORD,ORL,PDX,SEA,SFO,TPA,YVR,YTO,YYZ,YMX,ROR".indexOf(obj.getDest()) >= 0 | "ANC,ATL,BNA,BOS,CVG,DEN,DFW,GUM,HNL,HOU,JFK,LAS,LAX,MIA,NYC,ORD,ORL,PDX,SEA,SFO,TPA,YVR,YTO,YYZ,YMX,ROR".indexOf(obj.getDepart()) >= 0 )
{
%> 
			<td bgcolor="#FFFF99" align="center"><span class="style4">*</span></td>
<%
}
else if("ICN".indexOf(obj.getDest()) >= 0 | "ICN".indexOf(obj.getDepart()) >= 0)
{
%>
			<td bgcolor="#CCFF99">&nbsp;</td>
<%
}
else if("NKG,XMN,CTU,CKG,PEK,PVG,CAN,SZX,HGH".indexOf(obj.getDest()) >= 0 | "NKG,XMN,CTU,CKG,PEK,PVG,CAN,SZX,HGH".indexOf(obj.getDepart()) >= 0)
{
%>
			<td bgcolor="#C7EDFA">&nbsp;</td>
<%
}
else
{
%>
			<td bgcolor="#FFCCFF">&nbsp;</td>
<%
}	
%>
			<td <%if("".equals(obj.getFltno())){%> bgcolor="#FF0000" <%}%> ><%=obj.getCarrier()%><%=obj.getFltno()%></td>
			<td <%if("".equals(obj.getFdate())){%> bgcolor="#FF0000" <%}%> ><%=obj.getFdate()%></td>
			<td <%if("".equals(obj.getEmpno())){%> bgcolor="#FF0000" <%}%> ><%=obj.getEmpno()%></td>
			<td <%if("".equals(obj.getFname())){%> bgcolor="#FF0000" <%}%> ><%=obj.getLname()%> <%=obj.getFname()%></td>
			<td <%if("".equals(obj.getDepart())){%> bgcolor="#FF0000" <%}%> ><%=obj.getDepart()%></td>
			<td <%if("".equals(obj.getDest())){%> bgcolor="#FF0000" <%}%> ><%=obj.getDest()%></td>
			<td <%if("".equals(obj.getTvlstatus())){%> bgcolor="#FF0000" <%}%> ><%=obj.getTvlstatus()%></td>
			<td <%if("".equals(obj.getBirth())){%> bgcolor="#FF0000" <%}%> ><%=obj.getBirth()%></td>
			<td <%if("".equals(obj.getBirthcity()) || obj.getBirthcity() == null){%> bgcolor="#FF0000" <%}%> ><%=obj.getBirthcity()%></td>
			<td <%if("".equals(obj.getBirthcountry())){%> bgcolor="#FF0000" <%}%> ><%=obj.getBirthcountry()%></td>
			<td <%if("".equals(obj.getResicountry())){%> bgcolor="#FF0000" <%}%> ><%=obj.getResicountry()%></td>
			<td <%if("".equals(obj.getPassport())){%> bgcolor="#FF0000" <%}%> ><%=obj.getPassport()%></td>
			<td <%if("".equals(obj.getPasscountry())){%> bgcolor="#FF0000" <%}%> ><%=obj.getPasscountry()%></td>
			<td <%if("".equals(obj.getDoctype())){%> bgcolor="#FF0000" <%}%> ><%=obj.getDoctype()%></td>
			<td <%if("".equals(obj.getPassexp())){%> bgcolor="#FF0000" <%}%> ><%=obj.getPassexp()%></td>
			<td <%if("".equals(obj.getCertno())){%> bgcolor="#FF0000" <%}%> ><%=obj.getCertno()%></td>
			<td <%if("".equals(obj.getCertctry())){%> bgcolor="#FF0000" <%}%> ><%=obj.getCertctry()%></td>
			<td <%if("".equals(obj.getCertdoctype())){%> bgcolor="#FF0000" <%}%> ><%=obj.getCertdoctype()%></td>
			<td <%if("".equals(obj.getCertexp())){%> bgcolor="#FF0000" <%}%> ><%=obj.getCertexp()%></td>
		</tr>
<%
		}
%>
	  <tr valign="middle" bgcolor="#99FFCC">
		   <td colspan="20">
			   <div align="center" class="txtxred">Total records : <%=total%> , <%=objAL.size()%> data found!! </div>
		   </td>
	  </tr>
<%
	}
	else
	{
%>
	  <tr valign="middle" bgcolor="#99FFCC">
		   <td colspan="20">
			   <div align="center" class="txtxred">Total records : <%=total%> , No blank data found!! </div>
		   </td>
	  </tr>
<%
	}
}
else
{
	%>
	  <tr valign="middle" bgcolor="#99FFCC">
		   <td colspan="20">
			   <div align="center" class="txtxred">Error : <%=returnstr%></div>
		   </td>
	  </tr>
	<%
}
%>
</table>

<table width="95%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="6%" rowspan="5" valign="top"><span class="txtxred style1" align="right">備註 : </span></td>
    <td colspan="2"><span class="txtxred style1" align="right">APIS Check 已實施國家/航站 </span></td>
  </tr>
   <tr>
    <td width="13%" bgcolor="#FFFF99"><span class="txtxred" align="right">美加地區<br>
    (黃色底) </span></td>
    <td width="81%" bgcolor="#FFFF99"><span class="txtxred" align="right">ANC, ATL, BNA, BOS, CVG, DEN, DFW, GUM, HNL, HOU, JFK, LAS, LAX, MIA, NYC, ORD, ORL, PDX, SEA, SFO, TPA, YVR, YTO, YYZ, YMX, BFI, EWR, FAI, IAH, PAE, PTY, MGA, MAJ, TRW, SPN</span></td>
  </tr>
  <tr>
    <td bgcolor="#FFCCFF"><span class="txtxred" align="right">日本地區<br>(粉紅色底) </span></td>
    <td bgcolor="#FFCCFF"><span class="txtxred" align="right">AKJ, AOJ, AXT, CTS, FKS, FUK, GAJ, HIJ, HKD, HNA, HND, IWJ, IZO, KCZ, KIJ, KIX, KKJ, KMI, KMJ, KMQ, KOJ, KUH', 'MMB, MMJ, MMY, MYJ, NGO, NGS, NRT, NTQ', 'OBO, OIT, OKA, OKI, OKJ, ONJ, SDJ, TAK, TKS, TOY, TTJ, UBJ, YGJ </span></td>
  </tr>
  <tr>
    <td width="13%" bgcolor="#CCFF99"><span class="txtxred">韓國地區<br>(粉綠色底)</span></td>
    <td width="81%" bgcolor="#CCFF99"><span class="txtxred" align="right">ICN</span></td>
  </tr>  
  <tr>
    <td width="13%" bgcolor="#C7EDFA"><span class="txtxred">大陸地區<br>(粉藍色底)</span></td>
    <td width="81%" bgcolor="#C7EDFA"><span class="txtxred" align="right">NKG, XMN, CTU, CKG, PEK, PVG, CAN, SZX, HGH</span></td>
  </tr>  
</table>
</body>
</html>

<script language="JAVASCRIPT">
	abc();
</script>


