<%@page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*,java.util.*,ci.tool.*"%>
<%

String userid = (String) session.getAttribute("cs55.usr") ; //get user id if already login
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);

if (session.isNew() | userid == null ) 
{		//check user session start first
  %> <jsp:forward page="sendredirect.jsp" /> <%
} 

String empno = request.getParameter("empno");
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;

Driver dbDriver = null;
String cname = null;
String ename = null;

ConnDB cn = new ConnDB();
int rowCount =0;
 Driver dbDriver = null;
try{
cn.setDFUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);


stmt = conn.createStatement();

rs = stmt.executeQuery("select * from dftcrew where empno='"+empno+"'");
while(rs.next()){
	cname = rs.getString("name");
	ename = rs.getString("ename");
}

rs.close();
stmt.close();
conn.close();

cn.setORT1DFUser();
conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),
	cn.getConnPW());
	
stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
		ResultSet.CONCUR_READ_ONLY);


rs = stmt.executeQuery("SELECT * FROM dftcrec WHERE staff_num='"+empno+"' ORDER BY yy||mm");




%>
<html>
<head>
<title>Crew Record Insert Data</title>
<link href="../menu.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<script language="javascript" type="text/javascript" src="../../js/color.js"></script>
<style type="text/css">
.selected{
background-color: #3d80df;
color: #ffffff;
font-weight: bold;
border-left: 1px solid #346DBE;
border-bottom: 1px solid #7DAAEA;
}

td{
	font-size:10pt;
	font-family:Verdana;
}
</style>
</head>

<body onload="stripe('t1')" >
<center>

<span class="txttitletop"> Crew Record</span><span class="txtxred"> </span><br>
<span class="txtblue"><%=empno%>&nbsp;&nbsp;<%=cname%> &nbsp;&nbsp;&nbsp;<%=ename%>
</span>
<br>
<table width="99%" cellpadding="0" cellspacing="0" border="1" id="t1">
  <tr class="selected">
    <td width="6%">
      <div align="center">RecType</div>
    </td>
    <td width="3%">
      <div align="center">Year</div>
    </td>
    <td width="4%">
      <div align="center">Month</div>
    </td>
    <td width="6%">
      <div align="center">Fleet_cd</div>
    </td>
    <td width="5%">
      <div align="center">CA</div>
    </td>
    <td width="3%">
      <div align="center">FO</div>
    </td>
    <td width="2%">
      <div align="center">FE</div>
    </td>
    <td width="3%">
      <div align="center">Inst</div>
    </td>
    <td width="4%">
      <div align="center">Night</div>
    </td>
    <td width="5%">
      <div align="center">DutyIP</div>
    </td>
    <td width="5%">
      <div align="center">DutySF</div>
    </td>
    <td width="5%">
      <div align="center">DutyCA</div>
    </td>
    <td width="7%">
      <div align="center">DutyFO</div>
    </td>
    <td width="6%">
      <div align="center">DutyIFE</div>
    </td>
    <td width="5%">
      <div align="center">DutyFE</div>
    </td>
    <td width="7%">
      <div align="center">ToDay</div>
    </td>
    <td width="5%">
      <div align="center">ToNit</div>
    </td>
    <td width="7%">
      <div align="center">LdDay</div>
    </td>
    <td width="5%">
      <div align="center">LdNit</div>
    </td>
    <td width="7%" class="selected">
      <div align="center">PIC</div>
    </td>
  </tr>
  <%
  while(rs.next()){

  %>
  <tr>
    <td height="19">
      <div align="center"><%=rs.getString("rectype")%></div>
    </td>
    <td>
      <div align="center"><%=rs.getString("yy")%></div>
    </td>
    <td>
      <div align="center"><%=rs.getString("mm")%></div>
    </td>
    <td>
      <div align="center"><%=rs.getString("fleet_cd")%></div>
    </td>
    <td>
      <div align="center"><%=TimeUtil.hhmmWithColon(TimeUtil.minToHHMM1Zero(rs.getString("ca")))%></div>
    </td>
    <td>
      <div align="center"><%=TimeUtil.hhmmWithColon(TimeUtil.minToHHMM1Zero(rs.getString("fo")))%></div>
    </td>
    <td>
      <div align="center"><%=TimeUtil.hhmmWithColon(TimeUtil.minToHHMM1Zero(rs.getString("fe")))%></div>
    </td>
    <td>
      <div align="center"><%=TimeUtil.hhmmWithColon(TimeUtil.minToHHMM1Zero(rs.getString("inst")))%></div>
    </td>
    <td>
      <div align="center"><%=TimeUtil.hhmmWithColon(TimeUtil.minToHHMM1Zero(rs.getString("night")))%></div>
    </td>
    <td>
      <div align="center"><%=TimeUtil.hhmmWithColon(TimeUtil.minToHHMM1Zero(rs.getString("dutyip")))%></div>
    </td>
    <td>
      <div align="center"><%=TimeUtil.hhmmWithColon(TimeUtil.minToHHMM1Zero(rs.getString("dutysf")))%></div>
    </td>
    <td>
      <div align="center"><%=TimeUtil.hhmmWithColon(TimeUtil.minToHHMM1Zero(rs.getString("dutyca")))%></div>
    </td>
    <td>
      <div align="center"><%=TimeUtil.hhmmWithColon(TimeUtil.minToHHMM1Zero(rs.getString("dutyfo")))%></div>
    </td>
    <td>
      <div align="center"><%=TimeUtil.hhmmWithColon(TimeUtil.minToHHMM1Zero(rs.getString("dutyife")))%></div>
    </td>
    <td>
      <div align="center"><%=TimeUtil.hhmmWithColon(TimeUtil.minToHHMM1Zero(rs.getString("dutyfe")))%></div>
    </td>
    <td>
      <div align="center"><%=TimeUtil.hhmmWithColon(TimeUtil.minToHHMM1Zero(rs.getString("today")))%></div>
    </td>
    <td>
      <div align="center"><%=TimeUtil.hhmmWithColon(TimeUtil.minToHHMM1Zero(rs.getString("tonit")))%></div>
    </td>
    <td>
      <div align="center"><%=TimeUtil.hhmmWithColon(TimeUtil.minToHHMM1Zero(rs.getString("ldday")))%></div>
    </td>
    <td>
      <div align="center"><%=TimeUtil.hhmmWithColon(TimeUtil.minToHHMM1Zero(rs.getString("ldnit")))%></div>
    </td>
    <td>
      <div align="center"><%=TimeUtil.hhmmWithColon(TimeUtil.minToHHMM1Zero(rs.getString("pic")))%></div>
    </td>
  </tr>
<% 
rowCount ++;
} if(rowCount == 0){
%>
  <tr>
    <td height="19" colspan="20">No Data Found!!</td>
    </tr>

<%
}
%>
</table>

</center>
</body>
</html>
<%
}catch (SQLException e){
	  out.print(e.toString());
}catch (Exception e){
	  out.print(e.toString());
}finally{
	if (rs != null)
		try {rs.close();} catch (SQLException e) {}
	if (stmt != null)
		try {stmt.close();} catch (SQLException e) {}
	if (conn != null)
		try {conn.close();}catch (SQLException e) {}
}
if(rowCount == 0){
%>
<jsp:forward page="showmessage.jsp?messagestring=No Data Found">
<%
}
%>