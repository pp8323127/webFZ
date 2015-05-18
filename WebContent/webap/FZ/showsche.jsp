<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.*,java.sql.*,ci.db.*"%>
<html>
<head>
<title>Show Schedule</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" href="menu.css" type="text/css">
<script language="JavaScript" type="text/JavaScript">
/*function abc() {
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
else document.write('</div>');*/

</script>
</head>
<%
//out.flush();
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
String forwardFlag = "";


if ( sGetUsr == null) 
{		//check user session start first or not login
  // page="sendredirect.jsp"
  forwardFlag = "1";
} 
String yy = request.getParameter("syear");
String mm = request.getParameter("smonth");
if (mm.length() == 1){mm = "0" + mm;}
String empno = request.getParameter("empno").trim();
String ff = "";//退後再聘人員
if(null != request.getParameter("forwardFlag") | !"".equals(request.getParameter("forwardFlag")) ){
	ff = request.getParameter("forwardFlag");
}
//檢查是否有fztcrew帳號
/*
	fzAuth.UserID uid = new fzAuth.UserID(empno,null);
	fzAuth.CheckSkj ckhSkj = new fzAuth.CheckSkj();
*/


String cname = null;
String sern = null;
String occu = null;
String base = null;



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

		//showmessage.jsp?messagestring=The Crew didn't open his schedule for query
		//
		forwardFlag = "2";
		}
 	 if (chkemp.equals("0")){	//鎖定狀態為0
		
		//showmessage.jsp?messagestring=No Crew info
		//
		//判斷是否有班表
			//if(ckhSkj.isHasSkj()){
			 if("5".equals(ff)){
				forwardFlag="5";
			}else{
				forwardFlag = "3";			
			}
		
	    }
	
}


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

//~~YN0~//

//get crew info
chkUser ck = new chkUser();
String rs = ck.findCrew(empno);
if (rs.equals("1"))
{
	cname = ck.getName();
	sern = ck.getSern();
	occu = ck.getOccu();
	base = ck.getBase();
}else if("5".equals(ff)){//if(ckhSkj.isHasSkj()){
	cname = "";
    sern = "";
	occu = "";
	base = "";
}
else
{
	empno = "Crew not found";
	cname = "";
    sern = "";
	occu = "";
	base = "";
}

String fdate=null;
String dutycode=null;
String tripno=null;
String dpt=null;
String arv=null;
String btime=null;
String etime=null;
String qual = null;
String actp=null;
String spcode=null;

int xCount=0;
String bcolor=null;
String sql=null;

//************************************2.Get live sche table
ctlTable ct = new ctlTable();
ct.doSet();
//out.println(ct.getTable() + "," + ct.getUpdDate());
//****************************************

if (empno.length()<6)
{
	sql = "select * "+
//	"from "+ct.getTable()+" where trim(sern)='"+empno+
	"from "+ct.getTable()+" where sern='"+empno+
	"' and substr(fdate, 1, 7) = '"+yy+"/"+mm+"'"+
	" AND dutycode IS NOT null "+	//cs66 add at 2004/10/29 去掉dutycode is null
	" order by fdate, dutycode, tripno";
}
else
{
	sql = "select * "+
	"from "+ct.getTable()+" where empno='"+empno+
	"' and substr(fdate, 1, 7) = '"+yy+"/"+mm+"'"+
	" AND dutycode IS NOT null "+	//cs66 add at 2004/10/29 去掉dutycode is null
	" order by fdate, dutycode, tripno";
}
//out.print(sql);
myResultSet = stmt.executeQuery(sql);
%>

<body bgcolor="#FFFFFF" text="#000000">
<div align="center" class="txttitletop">
  <table width="70%" border="1" cellspacing="0" cellpadding="0">
    <tr> 
      <td class="tablehead">Fdate</td>
      <td class="tablehead">DutyCode</td>
      <td class="tablehead">Dpt</td>
      <td class="tablehead">Btime</td>
      <td class="tablehead">Arv</td>
      <td class="tablehead">Etime</td>
	  <td class="tablehead">TripNo</td>
	  <td class="tablehead">Actp</td>
	  <td class="tablehead">Qual</td>
	  <td class="tablehead">SpCode</td>
	  <td class="tablehead">Crew</td>
  </tr>
<%

if (myResultSet != null)
{
		while (myResultSet.next())
	{ 
			fdate = myResultSet.getString("fdate");
			dutycode = myResultSet.getString("dutycode");
			tripno = myResultSet.getString("tripno");
				//if("".equals(tripno) || null == tripno) {tripno = "&nbsp;";}
			dpt = myResultSet.getString("dpt");
				//if("".equals(dpt) || null == dpt) {dpt = "&nbsp;";}
			arv = myResultSet.getString("arv");
				//if("".equals(arv) || null == arv) {arv = "&nbsp;";}
			btime = myResultSet.getString("btime");
				//if("".equals(btime) || null == btime) {btime = "&nbsp;";}
			etime= myResultSet.getString("etime");
				//if("".equals(etime) || null == etime) {etime = "&nbsp;";}
			qual = myResultSet.getString("qual");
				//if("".equals(qual) || null == qual) {qual = "&nbsp;";}
			actp = myResultSet.getString("actp");
				//if("".equals(actp) || null == actp) {actp = "&nbsp;";}
			spcode = myResultSet.getString("spcode");
				//if("".equals(spcode) || null == spcode) {spcode = "&nbsp;";}
			
			xCount++;
			if (xCount%2 == 0)
			{
				bcolor = "#C9C9C9";
			}
			else
			{
				bcolor = "#FFFFFF";
			}
%>
    <tr bgcolor="<%=bcolor%>"> 
      <td class="tablebody"><%=fdate%></td>
      <td class="tablebody"><%=dutycode%></td>
      <td class="tablebody"><%=dpt%></td>
      <td class="tablebody"><%=btime%></td>
      <td class="tablebody"><%=arv%></td>
      <td class="tablebody"><%=etime%></td>
	  <td class="tablebody"><%=tripno%></td>
	  <td class="tablebody"><%=actp%></td>
	  <td class="tablebody"><%=qual%></td>
	  <td class="tablebody"><%=spcode%></td>
	  <td>
        <div align="center"><a href="crewdetail.jsp?fdate=<%=fdate%>&fltno=<%=dutycode%>&dpt=<%=dpt%>&arv=<%=arv%>" target="_blank"> 
          <img src="images/search.gif" width="15" height="15" border="0" alt="who fly with me"></a></div>
      </td>
    </tr>
<%
	}
}

%>
  </table>
</div>
</body>
</html>
<script lanquag="JAVASCRIPT">
	//abc();
</script>
<%
}
catch (Exception e)
{
	  t = true;
	// System.out.print("showsche exception:"+e.toString());
}
finally
{
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
if(t)
{
	//forwardFlag = "4";
	//err.jsp
}
%>
<script>
<%
	if("1".equals(forwardFlag)){
		out.println("self.location='sendredirect.jsp';");
	}else if("2".equals(forwardFlag)){
		out.println("self.location='showmessage.jsp?messagestring=The Crew did not open his schedule for query';");
	}else if("3".equals(forwardFlag)){
		out.println("self.location='showmessage.jsp?messagestring=No Crew info';");
	}else if("4".equals(forwardFlag)){
		out.println("self.location='err.jsp';");
	}
	
%>
</script>