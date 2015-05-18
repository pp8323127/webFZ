<%

String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);

if (session.isNew()) 
{		//check user session start first
  %> <jsp:forward page="sendredirect.jsp" /> <%
} 
if (sGetUsr == null) 
{		//check if not login
  %> <jsp:forward page="sendredirect.jsp" /> <%
} 
%>
<%@page contentType="text/html; charset=big5" language="java" errorPage="err.jsp"%>
<%@page import="fz.*,java.sql.*,java.util.*,ci.db.*" %>
<%@ page import="javax.sql.DataSource,javax.naming.InitialContext" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Make Text File</title>
<link href="../menu.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
function abc() {
if(document.layers) eval('document.layers["load"].visibility="hidden"')
else eval('document.all["load"].style.visibility="hidden"');
}

if(document.layers) document.write('<layer id="load" z-index=1000>');
else document.write('<div id="load" style="position: absolute;width: 100% ; height: 110% ; top: 0px; left: 0px;z-index:1000px;">');
document.write("        <p align='center'><font face='Arial, Helvetica, sans-serif' size='3'><b><strong><br><br>檔案製作中請稍候.........................</strong></font></td>");
var bar = 0
var line = ' |'
var amount =' |'

if(document.layers) document.write('</layer>');
else document.write('</div>');

</script>
<style type="text/css">
<!--
.style1 {
	font-size: 16px;
	color: #0033CC;
	font-family: "細明體", "新細明體", "Courier New";
	font-weight: bold;
}
-->
</style>
</head>

<%
out.flush();
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);

String y = request.getParameter("sely");
String m = request.getParameter("selm");
String d = request.getParameter("seld");
String rfdate =y+"/"+m+"/"+d;

String infltno = request.getParameter("fltno").trim();

Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
ResultSet myResultSet = null;

String[] empno = new String[1000];
String[] fdate = new String[1000];
String[] fltno = new String[1000];
String[] dpt = new String[1000];
String[] arv = new String[1000];
String[] btime = new String[1000];
String[] etime = new String[1000];
String sql = "";
String rs = null;
int xcount = 0;

// DS
ConnDB cn = new ConnDB();


DataSource ds = null;             
InitialContext initialcontext ;  

try{
//dbDriver = (Driver) Class.forName("ci.db.PoolDriver").newInstance();
//conn = dbDriver.connect("CAL.FZDS02", null);


//cn.setORP3FZUser();
//dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
//java.lang.Class.forName(cn.getDriver());
//conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),cn.getConnPW());
//conn = dbDriver.connect(cn.getConnURL(), null);
	//DataSource
	cn.setORP3FZUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn  = dbDriver.connect(cn.getConnURL(), null);


stmt = conn.createStatement();
//get live sche table for use
ctlTable ct = new ctlTable();
ct.doSet();

if(infltno.equals(""))
{
	sql = "select * from "+ct.getTable()+" where fdate='"+rfdate+"' and occu<>'FA' "+
	"and (dpt in (select * from fztustat) OR arv in (select * from fztustat)) and (dpt in ('TPE','TYO') OR arv in ('TPE','TYO'))"+
	"order by dutycode, empno";
}
else
{
	sql = "select * from "+ct.getTable()+" where fdate='"+rfdate+"' and occu<>'FA' and trim(dutycode)='"+infltno+"' "+
	"and (dpt in (select * from fztustat) OR arv in (select * from fztustat)) and (dpt in ('TPE','TYO') OR arv in ('TPE','TYO'))"+
	"order by dutycode, empno";
}

myResultSet = stmt.executeQuery(sql); 			

if(myResultSet != null){
  	while(myResultSet.next()) {
		empno[xcount] = myResultSet.getString("empno");
		//out.println(empno[xcount]);
		fdate[xcount] = myResultSet.getString("fdate");
		fltno[xcount] = myResultSet.getString("dutycode").trim();
		dpt[xcount] = myResultSet.getString("dpt");
		arv[xcount] = myResultSet.getString("arv");
		btime[xcount] = myResultSet.getString("btime");
		etime[xcount] = myResultSet.getString("etime");
		xcount++;
	}
}
}
catch (Exception e)
{
	  out.println(e.toString());
}
finally
{
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
} 
if(xcount == 0){
  %>
  	<jsp:forward page="../showmessage.jsp">
	<jsp:param name="messagestring" value="No Data!!" />
	</jsp:forward>
  <%
}
//產生檔案
tsaMakeFile mf = new tsaMakeFile();
rs = mf.makeFile(empno, fdate, fltno, dpt, arv, btime, etime, application.getRealPath("/")+"/tsa.csv");
//out.println("Total Flight Crews : "+mf.makeFile(empno, fdate, fltno, dpt, arv, btime, etime, application.getRealPath("/")+"/tsa.txt"));
//out.println("sendfile : "+mf.sendFile(fdate));
//寄出檔案
if(!mf.sendFile(rfdate, rs).equals("0")){
  %>
  	<jsp:forward page="../showmessage.jsp">
	<jsp:param name="messagestring" value="Send text file error!!" />
	</jsp:forward>
  <%
}

%>

<body>
<div align="center" class="txtblue">
  <p>&nbsp;</p>
</div>
</body>
</html>
<script lanquag="JAVASCRIPT">
	abc();
	alert("檔案已寄出至TPEOSCI信箱");
	self.location="/webfz/tsa.csv";
</script>
