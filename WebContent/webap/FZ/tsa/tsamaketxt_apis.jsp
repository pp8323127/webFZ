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
<%@page import="fz.*,java.sql.*,java.util.*"%>
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
String wfdate = (y+m+d).substring(2);
//String rfdate =y+"/"+m+"/"+d;

String infltno = request.getParameter("fltno").trim();
if (infltno.length() < 4) {infltno = "0" + infltno;}

Connection conn = null;
Statement stmt = null;
ResultSet myResultSet = null;
try{
//retrieve APIS
String classname = "COM.ibm.db2.jdbc.app.DB2Driver";
String jdbcURL = "jdbc:db2:TPEDB2P";
Class.forName(classname);
conn = DriverManager.getConnection(jdbcURL,"cs98","cs98");
stmt = conn.createStatement();


String[] empno = new String[10];
String[] fdate = new String[10];
String fd = null;
String[] fltno = new String[10];
String[] dpt = new String[10];
String[] arv = new String[10];

String sql = "";

sql = "select * from cal.dftapis where substr(fdate,1,6)='"+wfdate+"' and occu not in ('FA','FS','PR') and substr(fltno,1,4)='"+infltno+"' "+
"order by empno";
//out.println(sql);
myResultSet = stmt.executeQuery(sql); 			

int xcount = 0;
if(myResultSet != null){
  	while(myResultSet.next()) {
		empno[xcount] = myResultSet.getString("empno");
		fd = myResultSet.getString("fdate");
		fdate[xcount] = "20"+fd.substring(0,2)+"/"+fd.substring(2,4)+"/"+fd.substring(4,6);
		fltno[xcount] = myResultSet.getString("carrier").trim()+myResultSet.getString("fltno").trim();
		dpt[xcount] = myResultSet.getString("depart");
		arv[xcount] = myResultSet.getString("dest");
		//out.println(empno[xcount]+","+fltno[xcount]+","+fdate[xcount]);
		xcount++;
	}
}
if(xcount == 0){
    try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
  %>
  	<jsp:forward page="../showmessage.jsp">
	<jsp:param name="messagestring" value="No Data!!" />
	</jsp:forward>
  <%
}
//產生檔案
tsaMakeFile_apis mf = new tsaMakeFile_apis();
String rs = mf.makeFile(empno, fdate, fltno, dpt, arv, application.getRealPath("/")+"/tsa_apis.csv");
//寄出檔案
if(!mf.sendFile(y+"/"+m+"/"+d, rs).equals("0")){
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
  %>
  	<jsp:forward page="../showmessage.jsp">
	<jsp:param name="messagestring" value="Send text file error!!" />
	</jsp:forward>
  <%
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
	self.location="/webfz/tsa_apis.csv";
</script>