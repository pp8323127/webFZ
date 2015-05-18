<%@page contentType="text/html; charset=big5" language="java" errorPage="err.jsp"%>
<%@page import="fz.*,java.sql.*,java.util.*,ci.db.*"%>
<%@ include file="/incChkServer.jsp" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Make Text File</title>
<link href="menu.css" rel="stylesheet" type="text/css">
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


<%
out.flush();
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);

Statement stmt = null;
ResultSet myResultSet = null;
Connection con = null;
Driver dbDriver = null;
ConnDB cn = new ConnDB();

try{

if (!testserverflag)  cn.setDFUserCP();	//Live server//connect ORP3
else  cn.setORT1FZ();            		//Test server

dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
//con = dbDriver.connect(cn.getConnURL(), null);

out.println("<script>"); out.println("//conn db con= "+con); out.println("</script>");

//stmt = con.createStatement();

String[] fleet = new String[5000];
String[] fleet2 = new String[5000];
String[] cname = new String[5000];
String[] occu = new String[5000];
String[] flyhours = new String[5000];
String[] landtime = new String[5000];

/*String sql = "select a.fleet fleet, substr(trim(a.name),1,1)||'ＯＯ' cname, a.occu occu, round((sum(dutyip)+sum(dutyca)+sum(dutyfo)+sum(dutyife)+sum(dutyfe))/60,0) flyhours, "+
             "case "+
      		 "when sum(today+tonit) > sum(ldday+ldnit) then sum(today+tonit) "+
      		 "when sum(today+tonit) < sum(ldday+ldnit) then sum(ldday+ldnit) "+
			 "when sum(today+tonit) = sum(ldday+ldnit) then sum(ldday+ldnit) "+
      		 "end  as landtime, a.fleet2 fleet2 "+
"from dftcrew a, dftcrec b "+
"where a.empno = b.staff_num and a.cabin='A' and b.fleet_cd<>'OPS' and a.flag='Y' "+
"group by a.fleet, a.empno, a.name, a.occu, a.fleet2";*/
String sql = "select a.ac_type fleet, substr(trim(a.c_name),1,1)||'ＯＯ' cname, a.job_type occu, round((sum(dutyip)+sum(dutyca)+sum(dutyfo)+sum(dutyife)+sum(dutyfe))/60,0) flyhours, "+
             "case "+
      		 "when sum(today+tonit) > sum(ldday+ldnit) then sum(today+tonit) "+
      		 "when sum(today+tonit) < sum(ldday+ldnit) then sum(ldday+ldnit) "+
			 "when sum(today+tonit) = sum(ldday+ldnit) then sum(ldday+ldnit) "+
      		 "end  as landtime, a.fleet2 fleet2 "+
"from fzdb.fztckpl a, dfdb.dftcrec b "+
"where a.empno = b.staff_num and b.fleet_cd<>'OPS' "+
"group by a.ac_type, a.empno, a.c_name, a.job_type, a.fleet2";
//out.println(sql);
//myResultSet = stmt.executeQuery(sql); 			
/*
int xcount = 0;
if(myResultSet != null){
  	while(myResultSet.next()) {
		fleet[xcount] = myResultSet.getString("fleet");
		if (fleet[xcount] == null) {fleet[xcount] = "";}
		fleet2[xcount] = myResultSet.getString("fleet2");
		if (fleet2[xcount] == null) {
			fleet2[xcount] = "";
		}
		else{
			fleet2[xcount] = "/" + fleet2[xcount];
		}
		fleet[xcount] = fleet[xcount] + fleet2[xcount];
		cname[xcount] = myResultSet.getString("cname");
		if (cname[xcount] == null) {cname[xcount] = "";}
		occu[xcount] = myResultSet.getString("occu");
		if (occu[xcount] == null) {occu[xcount] = "";}
		flyhours[xcount] = myResultSet.getString("flyhours");
		if (flyhours[xcount] == null) {flyhours[xcount] = "";}
		landtime[xcount] = myResultSet.getString("landtime");
		if (landtime[xcount] == null) {landtime[xcount] = "";}
		xcount++;
	}
}
if(xcount == 0){
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(con != null) con.close();}catch(SQLException e){}
  %>
  	< jsp:forward page="../showmessage.jsp">
	< jsp:param name="messagestring" value="No Data!!" />
	< /jsp:forward>
  <%
}


//產生檔案
crewHour ch = new crewHour();
String rs = null ;
//rs=  ch.makeFile(fleet, cname, occu, flyhours, landtime, application.getRealPath("/")+"/crewhour.txt");
//寄出檔案
String rs2 = null;
//rs2 = ch.sendFile(rs) ;
out.println("<script>"); out.println("//sendFile rs2= "+rs2); out.println("</script>");
if(!rs2.equals("0")){
  %>
  	< jsp:forward page="../showmessage.jsp">
	< jsp:param name="messagestring" value=<%="Send text file error!!"+rs2%> />
	< /jsp:forward>
  <%
}
*/
}
catch (Exception e)
{
	  out.println(e.toString());
}
finally
{
	try { if(myResultSet != null) myResultSet.close();} catch(SQLException e){}
	try { if(stmt != null) stmt.close();} catch(SQLException e){}
	try { if(con != null) con.close();} catch(SQLException e){}
}

%>
</head>
<body>
<div align="center" class="txtblue">
  <p>&nbsp;</p>
</div>

<script lanquag="JAVASCRIPT">
	// tabc;   ();
	//alert("檔案已寄出至TPEOPCI信箱");
	//self.location="/webfz/crewhour.txt";
</script>
</body>
</html>