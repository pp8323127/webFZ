<%@page contentType="text/html; charset=big5" language="java" import="java.sql.*"%>
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
<html>
<head>
<title>
Edit Crew Record Detail
</title>
<meta http-equiv="pragma" content="no-cache">
<link href="../menu.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=big5"></head>

<body background="clearday.jpg">
<center>
<span class="txttitletop">Edit Crew Record</span><br>

<%
   String empno = request.getParameter("empno");
   String empname = request.getParameter("empname");
   session.putValue("MM_empno", empno);
   String fleet = request.getParameter("fleet");
   String rectype = request.getParameter("rectype");
   String mm = request.getParameter("mm");
   String yy = request.getParameter("yy");
   String c = "&fleet="+fleet+"&rectype="+rectype+"&mm="+mm+"&yy="+yy ;
 //  out.println("TTTTTT" + c +"<br>"); 
 //  session.putValue("MM_crew_detail","&fleet="+fleet+"&rectype="+rectype+"&mm="+mm+"&yy="+yy);
   session.putValue("MM_crew_detail",c);
   
   Connection conn = null;
   Statement stmt = null;
   ResultSet rs = null;
   ci.db.ConnDB cn = new ci.db.ConnDB();

	 Driver dbDriver = null;

   try
   {
	cn.setDFUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
	
   stmt = conn.createStatement();
  
   //    out.println("TTTTTT" + c +"<br>"); 
   //    out.println("select * from DFTCREC where rectype = '"+rectype+"' and yy = "+yy+" and mm = "+mm+" and staff_num = "+empno+" and fleet_cd = '"+fleet+"'");
  
  rs = stmt.executeQuery("select * from DFTCREC f where rectype = '"+rectype+"' and yy = "+yy+" and mm = "+mm+" and staff_num = "+empno+" and fleet_cd = '"+fleet+"'");
  int count =0;
   if (rs != null)
   {
        while (rs.next())
   	{
	count ++;
   	        String ca = rs.getString("ca");
	        String fo = rs.getString("fo");
	        String fe = rs.getString("fe");
	        String inst = rs.getString("inst");
	        String night = rs.getString("night");
	        String dutyip = rs.getString("dutyip");
	        String dutysf = rs.getString("dutysf");
	        String dutyca = rs.getString("dutyca");
	        String dutyfo = rs.getString("dutyfo");
	        String dutyife = rs.getString("dutyife");
	        String dutyfe = rs.getString("dutyfe");
	        String today = rs.getString("today");
	        String tonit = rs.getString("tonit");
	        String ldday = rs.getString("ldday");
	        String ldnit = rs.getString("ldnit");
	        String pic = rs.getString("pic");
		String pic2 = rs.getString("pic2");
	        session.putValue("MM_Where"," where rectype = '"+rectype+"' and yy = "+yy+" and mm = "+mm+" and staff_num = "+empno+" and fleet_cd = '"+fleet+"'");
 //		out.println("BBBBB = " + pic2 +"<br>");
%>
<span class="txtblue">Name : <%=empname%></span>
<form method="post" action="updcrewrec.jsp">
<table border="1" class="fortable">
<tr>
    <td width="79" class="tablehead3"><div align="left"><b>RecType</b></div></td>
    <td width="50" class="tablebody"><div align="left"><%= rectype %></div></td>
</tr>
<tr>
    <td class="tablehead3"><div align="left"><b>YY</b></div></td>
    <td class="tablebody"><div align="left"><%= yy %></div></td>
</tr>
<tr>
    <td class="tablehead3"><div align="left"><b>MM</b></div></td>
    <td class="tablebody"><div align="left"><%= mm %></div></td>
</tr>
<tr>
    <td class="tablehead3"><div align="left"><b>Staff_num</b></div></td>
    <td class="tablebody"><div align="left"><%= empno %></div></td>
</tr>
<tr>
    <td class="tablehead3"><div align="left"><b>Fleet_cd</b></div></td>
    <td class="tablebody"><div align="left"><%= fleet %></div></td>
</tr>
<tr>
    <td class="tablehead3"><div align="left"><b>CA</b></div></td>
    <td class="tablebody"><div align="left">
      <input name="ca" type="text" width="10" value="<%= ca %>">
    </div></td>
</tr>
<tr>
    <td class="tablehead3"><div align="left"><b>FO</b></div></td>
    <td class="tablebody"><div align="left">
      <input name="fo" type="text" width="10" value="<%= fo %>">
    </div></td>
</tr>
<tr>
    <td class="tablehead3"><div align="left"><b>FE</b></div></td>
    <td class="tablebody"><div align="left">
      <input name="fe" type="text" width="10" value="<%= fe %>">
    </div></td>
</tr>
<tr>
    <td class="tablehead3"><div align="left"><b>Inst</b></div></td>
    <td class="tablebody"><div align="left">
      <input name="inst" type="text" width="10" value="<%= inst %>">
    </div></td>
</tr>
<tr>
    <td class="tablehead3"><div align="left"><b>Night</b></div></td>
    <td class="tablebody"><div align="left">
      <input name="night" type="text" width="10" value="<%= night %>">
    </div></td>
</tr>
<tr>
    <td class="tablehead3"><div align="left"><b>DutyIP</b></div></td>
    <td class="tablebody"><div align="left">
      <input name="dutyip" type="text" width="10" value="<%= dutyip %>">
    </div></td>
</tr>
<tr>
    <td class="tablehead3"><div align="left"><b>DutySF</b></div></td>
    <td class="tablebody"><div align="left">
      <input name="dutysf" type="text" width="10" value="<%= dutysf %>">
    </div></td>
</tr>
<tr>
    <td class="tablehead3"><div align="left"><b>DutyCA</b></div></td>
    <td class="tablebody"><div align="left">
      <input name="dutyca" type="text" width="10" value="<%= dutyca %>">
    </div></td>
</tr>
<tr>
    <td class="tablehead3"><div align="left"><b>DutyFO</b></div></td>
    <td class="tablebody"><div align="left">
      <input name="dutyfo" type="text" width="10" value="<%= dutyfo %>">
    </div></td>
</tr>
<tr>
    <td class="tablehead3"><div align="left"><b>DutyIFE</b></div></td>
    <td class="tablebody"><div align="left">
      <input name="dutyife" type="text" width="10" value="<%= dutyife %>">
    </div></td>
</tr>
<tr>
    <td class="tablehead3"><div align="left"><b>DutyFE</b></div></td>
    <td class="tablebody"><div align="left">
      <input name="dutyfe" type="text" width="10" value="<%= dutyfe %>">
    </div></td>
</tr>
<tr>
    <td class="tablehead3"><div align="left"><b>ToDay</b></div></td>
    <td class="tablebody"><div align="left">
      <input name="today" type="text" width="5" value="<%= today %>">
    </div></td>
</tr>
<tr>
    <td class="tablehead3"><div align="left"><b>ToNit</b></div></td>
    <td class="tablebody"><div align="left">
      <input name="tonit" type="text" width="5" value="<%= tonit %>">
    </div></td>
</tr>
<tr>
    <td class="tablehead3"><div align="left"><b>LdDay</b></div></td>
    <td class="tablebody"><div align="left">
      <input name="ldday" type="text" width="5" value="<%= ldday %>">
    </div></td>
</tr>
<tr>
    <td class="tablehead3"><div align="left"><b>LdNit</b></div></td>
    <td class="tablebody"><div align="left">
      <input name="ldnit" type="text" width="5" value="<%= ldnit %>">
    </div></td>
</tr>
<tr>
    <td class="tablehead3"><div align="left"><b>PIC</b></div></td>
    <td class="tablebody"><div align="left">
      <input name="pic" type="text" width="10" value="<%= pic %>">
    </div></td>
</tr>
<tr>
    <td class="tablehead3"><div align="left"><b>PIC(U/S)</b></div></td>
    <td class="tablebody"><div align="left">
      <input name="pic2" type="text" width="10" value="<%= pic2 %>">
    </div></td>
</tr>
<tr>
    <td colspan="2">
         <center>
              
      <input type="submit" value="Update Change" >
         </center> 
</tr>
<tr>
</table>
<div align="left"></div>
</form>
<%        
    	}  
   }
   if(count ==0){
   %>
   <jsp:forward page="showmessage.jsp">
   <jsp:param name="messagestring" value="查無資料<br>No Record!!" />
   </jsp:forward>
   <%
   }
}catch (Exception e)
{
	  out.println(e.toString());
}
finally
{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>
</center>
</body>
</html>