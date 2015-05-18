<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.*,java.sql.*,ci.db.*,java.util.*"%>
<html>
<head>
<title>Show Schedule</title>
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
//out.flush();
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
  %> <jsp:forward page="sendredirect.jsp" /> <%
} 

//write log
String userip = request.getRemoteAddr();
String userhost = request.getRemoteHost();

writeLog wl = new writeLog();
String wlog = wl.updLog(sGetUsr, userip,userhost, "FZ272");

String yy = request.getParameter("syear");
String mm = request.getParameter("smonth");
if (mm.length()<2) mm = "0"+mm;
String empno = request.getParameter("empno").trim();
String mydate = yy+"/"+mm+"/01";

//get schedule locked status
chkUser chk = new chkUser();
String chkemp = chk.checkLock(empno);

if (empno.equals("")){
	empno = sGetUsr;
}
else	//若不是自己的帳號，就判斷是否開放班表
{
//out.print(chkemp);
	if(chkemp.equals("Y") ){	//鎖定狀態為Y
		%> 
		<jsp:forward page="showmessage.jsp">
		<jsp:param name="messagestring" value="The Crew didn't open his schedule for query" />
		</jsp:forward>
		<%
		}
 	 if (chkemp.equals("0")){	//鎖定狀態為0
	    %> 
		<jsp:forward page="showmessage.jsp">
		<jsp:param name="messagestring" value="No Crew info" />
		</jsp:forward>
		<%
	    }
}
out.flush();

//Get Today
GregorianCalendar currentDate = new GregorianCalendar();
currentDate.set(currentDate.YEAR, Integer.parseInt(yy)); //Year
currentDate.set(currentDate.MONTH, Integer.parseInt(mm) - 1); //Month 0-11
currentDate.set(currentDate.DATE, 1); //Day 1-31
int myday = currentDate.get(currentDate.DAY_OF_WEEK); //1-7 7 = Saturday 
//out.println("myday : " + myday);
/*java.util.Date curDate = (java.util.Date)currentDate.getTime();

SimpleDateFormat dateFmD = new SimpleDateFormat("MM-dd");
SimpleDateFormat dateFmY = new SimpleDateFormat("yyyy");
String mytoday = dateFmY.format(curDate) + "-" + dateFmD.format(curDate);
String mysdate = mytoday.substring(5, 8) + "01-" + String.valueOf(Integer.parseInt(dateFmY.format(curDate)) - 1).substring(2,4);
//End*/

String cname = null;
String sern = null;
String occu = null;
String base = null;
String bcolor = null;
int cday = 0;

int[] fdd = new int[60];
String[] dutycode = new String[60];
String[] dpt = new String[60];
String[] arv = new String[60];
String[] btime = new String[60];
String[] etime = new String[60];
String[] spcode = new String[60];
String[] tripno = new String[60];
String prjcr = null;
int x = 0;
int dd = 0;
String pstring = null;
String sql = null;
String sp = null;
if (empno.equals("")){empno = sGetUsr;}

Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
ResultSet myResultSet = null;
boolean p = false;

try{
//dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
//conn = dbDriver.connect("jdbc:weblogic:pool:CAL.FZCP02", null);

ConnDB cn = new ConnDB();
cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement();

//get crew info
chkUser ck = new chkUser();
String rs = ck.findCrew(empno);
if (rs.equals("1"))
{
	cname = ck.getName();
	sern = ck.getSern();
	occu = ck.getOccu();
	base = ck.getBase();
	if(occu.equals("FS") || occu.equals("FA") || occu.equals("PR")){
		sp = ck.getSpcode();
		if(sp.equals("")) sp = "N";
	}
}
else
{
	empno = "Crew not found";
	cname = "";
    sern = "";
	occu = "";
	base = "";
	sp = "";
}

myResultSet = stmt.executeQuery("select to_char(last_day(to_date('"+mydate+"','yyyy/mm/dd')), 'dd') dd from dual");
if(myResultSet.next()) {dd = myResultSet.getInt("dd");}//get last day of retrieve month
//************************************2.Get live sche table
ctlTable ct = new ctlTable();
ct.doSet();
//out.println(ct.getTable() + "," + ct.getUpdDate());
//****************************************

if (empno.length()<6)
{
	sql = "select fdate, dutycode, dpt, arv, btime, etime, spcode, tripno, prjcr "+
	"from "+ ct.getTable() +" where trim(sern)='"+empno+
	"' and substr(fdate, 1, 7) = '"+yy+"/"+mm+"'"+
	" group by fdate, dutycode, btime, dpt, arv, etime, spcode, tripno, prjcr";
}
else
{
	sql = "select fdate, dutycode, dpt, arv, btime, etime, spcode, tripno, prjcr "+
	"from "+ ct.getTable() +" where trim(empno)='"+empno+
	"' and substr(fdate, 1, 7) = '"+yy+"/"+mm+"'"+
	" group by fdate, dutycode, btime, dpt, arv, etime, spcode, tripno, prjcr";
}
myResultSet = stmt.executeQuery(sql);

if (myResultSet != null)
{
		while (myResultSet.next())
	{ 
			fdd[x] = Integer.parseInt(myResultSet.getString("fdate").substring(8,10));
			dutycode[x] = myResultSet.getString("dutycode").trim();
			dpt[x] = myResultSet.getString("dpt");
			arv[x] = myResultSet.getString("arv");
			btime[x] = myResultSet.getString("btime");
			etime[x] = myResultSet.getString("etime");
			spcode[x] = myResultSet.getString("spcode");
			tripno[x] = myResultSet.getString("tripno");
			if (prjcr == null) {prjcr = myResultSet.getString("prjcr");}
			//CI001/003/005/011/031/062  +1
            //CI007  +2 (28/MAR夏令改+1)
			if (dutycode[x].equals("001") || dutycode[x].equals("003") || dutycode[x].equals("005") || dutycode[x].equals("011") || dutycode[x].equals("031") || dutycode[x].equals("062"))
			{
				dutycode[x+1] = "REST";
				fdd[x+1] = fdd[x] + 1;
				x++;
			}
			if (dutycode[x].equals("007") || dutycode[x].equals("015"))
			{
				/*dutycode[x+1] = "REST";
				dutycode[x+2] = "REST";
				fdd[x+1] = fdd[x] + 1;
				fdd[x+2] = fdd[x] + 2;
				x = x + 2;*/
				//夏令改+1
				dutycode[x+1] = "REST";
				fdd[x+1] = fdd[x] + 1;
				x++;
			}
			x++;
	}
}
%>


<body bgcolor="#FFFFFF" text="#000000">
<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
        
    <td class="txtblue">資料庫更新時間(Last update)：<span class="txtxred">TPE&nbsp;<%=ct.getUpdDate()%> 班表時間為起迄站之當地時間<br>
      <strong>The following shedule is for reference only. For official up-to-date schedule information, please contact Scheduling Department. 
下列班表僅供參考，請向組員派遣部門確認個人正式班表任務。 </strong>    </span></td>
    </tr>
</table>
<div align="center" class="txttitletop">
  <table width="90%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td width="5%"><font size="2"><b><font face="Arial, Helvetica, sans-serif"><%=yy%>/<%=mm%></font></b></font></td>
      <td width="20%"> 
        <div align="center"><font size="2"><b><font face="Arial, Helvetica, sans-serif"><%=cname%> <%=empno%> <%=occu%> <%=base%> SP:<%=sp%> CR:<%=prjcr%> </font></b></font></div>
      </td>
      <td width="5%">
        <div align="right"><a href="javascript:window.print()"><font face="Arial, Helvetica, sans-serif" size="2" class="txtblue">請設為橫印</font><img src="images/print.gif" width="17" height="15" border="0" alt="列印"></a> 
        </div>
      </td>
    </tr>
  </table>
  <table width="90%" border="1" cellspacing="0" cellpadding="0" height="90%">
    <tr> 
      <td class="tablehead2">Sunday</td>
      <td class="tablehead2">Monday</td>
      <td class="tablehead2">Tuesday</td>
      <td class="tablehead2">Wednesday</td>
      <td class="tablehead2">Thursday</td>
      <td class="tablehead2">Friday</td>
      <td class="tablehead2">Saturday</td>
    </tr>
    <%
int keepvalue = 0;
for (int i=1;i<=7;i++)
{
	%>
    <tr align="left"> 
    <%
	cday = 0;
	if (i == 1){
		for (int z=1;z<myday;z++) {out.println("<td>&nbsp;</td>");}
		cday = myday - 1;
	}
	
	for(int t = keepvalue + 1; t <= keepvalue + 7 - cday; t++)
	{
		bcolor = "#FFFFFF";
		if (t == (keepvalue + 1) || t == (keepvalue + 7 - cday)) {bcolor = "#CCCCCC";}
		if (t == 1 && myday != 1 && myday != 7) {bcolor = "#FFFFFF";}
		if (t<=dd)
		{
			pstring = "";
			for(int j=0;j<x;j++)
			{
				if (t == fdd[j])
				{
					if (dutycode[j].trim().equals("REST")) 
					{
						pstring = "------>";
					}
					else
					{ pstring = pstring+dutycode[j]+dpt[j]+arv[j]+"*"+tripno[j]+"<br>"+btime[j]+"/"+etime[j]+spcode[j]+"<br>";}
				}
			}
	%>
      <td width="10%" valign="top" bgcolor="<%=bcolor%>" height="20%"> 
        <div align="left"><b><font face="Arial, Helvetica, sans-serif" size="2"><%=t%></font></b><br>
          <font face="Arial, Helvetica, sans-serif" size="1"><%=pstring%></font></div>
      </td>
      <%
		}
	}
	%>
    </tr>
    <%
	keepvalue = keepvalue + 7 - cday;
	if(keepvalue > dd) {
	keepvalue = dd;
	i=9;}
}
%>
  </table>
<iframe src="showsche.jsp?syear=<%=yy%>&smonth=<%=mm%>&empno=<%=empno%>" width="100%" height="100%" align="middle" frameborder="0" scrolling="auto"></iframe>
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
	  p = true;
}
finally
{
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
if(p)
{
%>
      <jsp:forward page="err.jsp" /> 
<%
}
%>
