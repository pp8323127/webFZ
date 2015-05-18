<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="java.sql.*,ci.db.*,java.util.*"%>
<%
String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);

if (sGetUsr == null) 
{		//check if not login
  %> <jsp:forward page="sendredirect.jsp" /> <%
} 

ConnDB cn = new ConnDB();

Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
String sql = null;
ArrayList sysname = new ArrayList();
 Driver dbDriver = null;
try{

cn.setDFUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);

stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
					
sql	="select distinct sysname from dftclog order by sysname";
rs = stmt.executeQuery(sql);
while(rs.next()){
	sysname.add(rs.getString("sysname"));
}

}catch(Exception e){
	out.print(e.toString());
}finally{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}

}
%>
<html>
<head>
<title>Crew REC</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<script language="JavaScript" type="text/JavaScript" src="../js/showDate.js"></script>

<link href="../menu.css" rel="stylesheet" type="text/css">
</head>

<body onLoad="showYMD('form1','year','month','day')">

<form name="form1" method="post" action="viewLog.jsp" class="txtblue" target="mainFrame">
  <select name="year" id="year">
  <script language="javascript" type="text/javascript">
  	var nowDate = new Date();
  	for(var i=2004;i<= nowDate.getFullYear()+2;i++){
		document.write("<option value='"+i+"'>"+i+"</option>");
	}
  </script>

  </select>
  <span class="txtblue">/</span>  
  <select name="month" id="month">
    <option value="01">01</option>
    <option value="02">02</option>
    <option value="03">03</option>
    <option value="04">04</option>
    <option value="05">05</option>
    <option value="06">06</option>
    <option value="07">07</option>
    <option value="08">08</option>
    <option value="09">09</option>
    <option value="10">10</option>
    <option value="11">11</option>
    <option value="12">12</option>
  </select>
  /
  <select name="day">
  	<option value="N">ALL</option>
    <option value="01">01</option>
    <option value="02">02</option>
    <option value="03">03</option>
    <option value="04">04</option>
    <option value="05">05</option>
    <option value="06">06</option>
    <option value="07">07</option>
    <option value="08">08</option>
    <option value="09">09</option>
    <option value="10">10</option>
    <option value="11">11</option>
    <option value="12">12</option>
    <option value="13">13</option>
    <option value="14">14</option>
    <option value="15">15</option>
    <option value="16">16</option>
    <option value="17">17</option>
    <option value="18">18</option>
    <option value="19">19</option>
    <option value="20">20</option>
    <option value="21">21</option>
    <option value="22">22</option>
    <option value="23">23</option>
    <option value="24">24</option>
    <option value="25">25</option>
    <option value="26">26</option>
    <option value="27">27</option>
    <option value="28">28</option>
    <option value="29">29</option>
    <option value="30">30</option>
    <option value="31">31</option>
  </select>
  <span class="txtblue">  </span>
  Empno&nbsp;
  <input name="empno" type="text" id="empno" size="10" maxlength="6">
  &nbsp;&nbsp;function:
  <select name="sysname">
  <option value="N" >ALL</option>
  <%
  for(int i=0;i<sysname.size();i++){
  	out.print("<option value=\""+(String)sysname.get(i)+"\">"+(String)sysname.get(i)+"</option>");
   }
  %>
  </select>

  <input name="Submit" type="submit" class="btm" value="Query">
</form>
</body>
</html>
