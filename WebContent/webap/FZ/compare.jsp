<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.*,java.sql.*,java.util.*,ci.db.*"%>
<html>
<head>
<title>Schedule Compare</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" href="menu.css" type="text/css">
<script language="JavaScript" type="text/JavaScript">
function abc() {
if(document.layers) eval('document.layers["load"].visibility="hidden"')
else eval('document.all["load"].style.visibility="hidden"');
}

if(document.layers) document.write('<layer id="load" z-index=1000>');
else document.write('<div id="load" style="position: absolute;width: 100% ; height: 110% ; top: 0px; left: 0px;z-index:1000px;">');
document.write(" <center>");
document.write("  <table border=0 cellpadding=0 cellspacing=0 style='border-collapse: collapse' width='505'>");
document.write("    <tr><br><br><br><br><br> ");
document.write("      <td align='center' width='505' nowrap> ");
document.write("        <p align='center'><font face='Arial, Helvetica, sans-serif' size='3'><b><strong>Data Retrieving, Please wait.....</strong></font></td>");
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
</head>
<%


response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);

String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login


if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
  %>
<jsp:forward page="sendredirect.jsp" />
<%
} 
String empno = request.getParameter("empno").trim();
String fyy = request.getParameter("fyy");
String fmm = request.getParameter("fmm");
String mymm = fyy+"/"+fmm;

//取得該月第一天是星期幾
GregorianCalendar calendar =	new GregorianCalendar(Integer.parseInt(fyy),Integer.parseInt(fmm)-1,1);
int FirstDayOfWeek = calendar.get(GregorianCalendar.DAY_OF_WEEK)-1;
//out.println("FirstDayOfWeek"+FirstDayOfWeek);
String[] week = {"SUN","MON","TUE","WED","THU","FRI","SAT"};



//get schedule locked status
chkUser ck = new chkUser();
String chkemp = ck.checkLock(empno);

	if("Y".equals(chkemp) ){	//鎖定狀態為Y
	%>
		<jsp:forward page="showmessage.jsp">
		<jsp:param name="messagestring" value="The Crew didn't open his schedule " />
		</jsp:forward>

	<%
	}else if (sGetUsr.equals(empno)){
	%>
	<jsp:forward page="showmessage.jsp"> 
	<jsp:param name="messagestring" value="比對者帳號錯誤，請重新選擇<br>You can't compare schedule with yourself" />
	</jsp:forward>
	<%
	}
out.flush();

int dd = 0;
int[] fdd = new int[80];
String[] fltno = new String[80];
String[] dpt = new String[80];
String[] arv = new String[80];
int[] rfdd = new int[80];
String[] rfltno = new String[80];
String[] rdpt = new String[80];
String[] rarv = new String[80];
int dCount = 0;
//ArrayList



Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
ResultSet myResultSet = null;
boolean t = false;

try{
//dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
//conn = dbDriver.connect("jdbc:weblogic:pool:CAL.FZCP02", null);
ConnDB cn = new ConnDB();
cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement();

int xCount=0;
String bcolor=null;
//************************************2.Get live sche table
ctlTable ct = new ctlTable();
ct.doSet();
//out.println(ct.getTable() + "," + ct.getUpdDate());
//****************************************
String sql2 = "";
String sql1 = "select to_char(last_day(to_date(fdate,'yyyy/mm/dd')), 'dd') dd, substr(fdate,9,10) fdd, dutycode, dpt, arv "+
"from   "+ct.getTable()+
" where trim(empno)='"+sGetUsr+"' and substr(fdate, 1, 7) = '"+mymm+"' "+
"order by fdate, btime";
//out.print(sql1);
if (empno.length()<6) {
	sql2 = "select substr(fdate,9,10) fdd, dutycode, dpt, arv "+
	"from  "+ct.getTable()+
	" where trim(sern)='"+empno+"' and substr(fdate, 1, 7) = '"+mymm+"' "+
	"order by fdate, btime";
}
else{
	sql2 = "select substr(fdate,9,10) fdd, dutycode, dpt, arv "+
	"from  "+ct.getTable()+
	" where trim(empno)='"+empno+"' and substr(fdate, 1, 7) = '"+mymm+"' "+
	"order by fdate, btime";
}
dCount = 0;
myResultSet = stmt.executeQuery(sql1);
if (myResultSet != null)
{
	while (myResultSet.next())
	{ 
		dd = myResultSet.getInt("dd");
		fdd[dCount] = myResultSet.getInt("fdd");
		fltno[dCount] = myResultSet.getString("dutycode");
		dpt[dCount] = myResultSet.getString("dpt");
		arv[dCount] = myResultSet.getString("arv");
		//out.print(dCount + ":"+dd + ","+fdd[dCount] + "," + fltno[dCount]+"<br>");
		dCount++;
		
	}
}
//out.print("<hr>");
dCount = 0;
myResultSet.close();
myResultSet = stmt.executeQuery(sql2);
if (myResultSet != null)
{
	while (myResultSet.next())
	{ 
		rfdd[dCount] = myResultSet.getInt("fdd");
		rfltno[dCount] = myResultSet.getString("dutycode");
		rdpt[dCount] = myResultSet.getString("dpt");
		rarv[dCount] = myResultSet.getString("arv");
		//out.print(rfdd[dCount] + "," + rfltno[dCount]+"<br>");
		dCount++;
		
	}
}


//get crew base information
String cname=null;
String sern=null;
String occu=null;
String base=null;
String rcname=null;
String rsern=null;
String roccu=null;
String rbase=null;

//get prjcr
applyForm af = new applyForm();
af.setCrewInfo(sGetUsr, mymm);
String prjcr = af.getPrjcr();
af.setCrewInfo(empno, mymm);
String prjcr2 = af.getPrjcr();

String rs = ck.findCrew(sGetUsr);
if ("1".equals(rs))
{
	cname = ck.getName();
	sern = ck.getSern();
	occu = ck.getOccu();
	base = ck.getBase();
}
rs = ck.findCrew(empno);
if ("1".equals(rs))
{
	rcname = ck.getName();
	rsern = ck.getSern();
	roccu = ck.getOccu();
	rbase = ck.getBase();
}

%>
<body bgcolor="#FFFFFF" text="#000000">
<table width="80%" border="0" cellpadding="0" cellspacing="0" align="center">
  <tr>
        <td class="txtblue">資料庫最後更新時間(Last update)：<span class="txtxred">TPE&nbsp;<%=ct.getUpdDate()%><br>
          <strong> The following shedule is for reference only. For official up-to-date schedule information, please contact Scheduling Department. <br>
下列班表僅供參考，請向組員派遣部門確認個人正式班表任務。 </strong>        </span></td>
  </tr>
</table>
<div align="center" class="txttitletop"> 
   
  <table width="80%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td width="5%">&nbsp;</td>
      <td width="20%"> 
        <div align="center"><font size="2"><b><%=mymm%></b></font></div>
      </td>
      <td width="5%"> 
        <div align="right"><a href="javascript:window.print()"><img src="images/print.gif" width="17" height="15" border="0" alt="列印"></a> 
        </div>
      </td>
    </tr>
  </table>
  <table width="80%" border="1" cellspacing="0" cellpadding="0" align="center">
    <tr bgcolor='#C9C9C9'> 
	  <td width="20%" class="tablehead2">Date</td>
      <td width="38%" class="tablehead2"> 
        <div align="center"><%=sern%> <%=cname%> CR:<%=prjcr%></div>
      </td>
      <td width="42%" colspan="2" class="tablehead2"> 
        <div align="center"><%=rsern%> <%=rcname%>  CR:<%=prjcr2%></div>
      </td>
    </tr>
<%
String s1 = null;
String s2 = null;

for (int i=0; i<dd; i++)
{
	s1="&nbsp;";
	for (int x=0; x<fdd.length; x++)
	{
		if ((i+1) == fdd[x] && fdd[x] != 0)
		{
			if (s1.equals("&nbsp;")){
				s1 = fltno[x]+dpt[x]+""+arv[x];
			}else{
				s1 = s1+","+fltno[x]+dpt[x]+""+arv[x];
			}
		}
	}
	s2="&nbsp;";
	for (int x=0; x<fdd.length; x++)
	{
		if ((i+1) == rfdd[x] && rfdd[x] != 0)
		{
			if (s2.equals("&nbsp;")){
				s2 = rfltno[x]+rdpt[x]+""+rarv[x];
			}else{
				s2 = s2+","+rfltno[x]+rdpt[x]+""+rarv[x];
			}
		}
	}
	
	if (week[(i+FirstDayOfWeek)%7].equals("SUN") || week[(i+FirstDayOfWeek)%7].equals("SAT")){
		bcolor = "#FF99FF";
	}
	else if ((i+FirstDayOfWeek)%2 == 0){
		bcolor = "#C9C9C9";
	}
	else{
		bcolor = "#FFFFFF";
	}
	
%>
    <tr bgcolor="<%=bcolor%>"> 
	<td>
        <div align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <b><%=i+1%><span class="txtblue">&nbsp;</span></b><span class="txtblue">(<%=week[(i+FirstDayOfWeek)%7]%>)</span></div>
      </td>
      <td> 
        <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=s1%></font></div>
      </td>
      <td> 
        <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=s2%></font></div>
      </td>
    </tr>
    <%

}
%>
  </table>
</div>
</body>
</html>
<script lanquag="JAVASCRIPT">
	abc();
</script>
<%
}
catch (Exception e)
{
	 // t = true;
	 out.print(e.toString());
}
finally
{
	try{if(myResultSet != null) myResultSet.close();}catch(Exception e){}
	try{if(stmt != null) stmt.close();}catch(Exception e){}
	try{if(conn != null) conn.close();}catch(Exception e){}
}
%>
