<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,java.util.*,ci.db.*"  %>
<%
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
Driver dbDriver = null;

String year = request.getParameter("year");
String month = request.getParameter("month");
ArrayList login_timeAL = new ArrayList();
ArrayList useridAL = new ArrayList();
ArrayList sysAL = new ArrayList();


ConnDB cn = new ConnDB();
dz.CrewName crewName = new dz.CrewName();
//顯示OP人員名字
tsa.CIIViewLogUserList vUser = new 	tsa.CIIViewLogUserList();

try{
cn.setDFUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement();
rs = stmt.executeQuery("SELECT To_Char(login_time,'yyyy/mm/dd hh24:mi') login_time,"
		+"userid,sysname FROM dftclog WHERE To_Char(login_time,'yyyymm')='"
		+year+month+"' AND sysname LIKE '100%' order by login_time");
while(rs.next()){
		login_timeAL.add(rs.getString("login_time"));
		useridAL.add(rs.getString("userid"));
		sysAL.add(rs.getString("sysname"));
}		



}catch (SQLException e){
	  out.print(e.toString());
}catch (Exception e){
	  out.print(e.toString());
}finally{
	if (rs != null) try {rs.close();} catch (SQLException e) {}	
	if (stmt != null) try {stmt.close();} catch (SQLException e) {}
	if (conn != null) try { conn.close(); } catch (SQLException e) {}
}


%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>100Hrs Check Log</title>
<link href="../menu.css" rel="stylesheet" type="text/css">
<style type="text/css">
body{
	font-family:Verdana;
	font-size:10pt;
}
</style>
<script language="javascript" type="text/javascript" src="../js/color.js"></script>
</head>

<%
if(login_timeAL.size() > 0){
%>
<body onLoad="stripe('t1')">
<table width="70%%"  border="0" align="center" cellpadding="0" cellspacing="1">
  <tr>
    <td>
      <div align="center" class="txttitletop">100 Hours Check Log </div>
    </td>
  </tr>
</table>
<table width="70%%"  border="0" align="center" cellpadding="0" cellspacing="1" id="t1">
  <tr class="tablehead3" id="selected">
    <td width="23%">
      <div align="center">Login_time</div>
    </td>
    <td width="15%">
      <div align="center">User</div>
    </td>
    <td width="29%">Name</td>
    <td width="12%">Fleet</td>
    <td width="21%">
      <div align="center">System Name </div>
    </td>
  </tr>
  <%
	for(int i=0;i<login_timeAL.size();i++){
	

  %>
  <tr>  
    <td height="16">
      <div align="center"><%=login_timeAL.get(i)%></div>
    </td>	
    <td >
      <div align="center"><%=useridAL.get(i)%></div>
    </td>	
    <td ><%
	  if(!"".equals(crewName.getCname((String)useridAL.get(i)))){
	  	out.print(crewName.getCname((String)useridAL.get(i))+" "+crewName.getEname((String)useridAL.get(i)));
	  }else{
		out.print(vUser.getCname((String)useridAL.get(i)));
	  } 	  
	  
	  %></td>
    <td >
      <div align="center"><%
  	  if(!"".equals(crewName.getFleet((String)useridAL.get(i)))){
	  	out.print(crewName.getFleet((String)useridAL.get(i)));
	  }else{
		out.print(vUser.getFleet((String)useridAL.get(i)));
	  } 			
	%></div>
	
	</td>
    <td >
      <div align="center"><%=sysAL.get(i)%></div>
    </td>	
  </tr>
  <%		} %>
</table>
<div align="center">
  <%
}//end of has data
else{	
	out.print("<body>");
	out.print("<div class=\"txtxred\" align=\"center\">查無資料<br>NO DATA!!</div>");
}
%>
</div>
<p>&nbsp;</p>
</body>
</html>
