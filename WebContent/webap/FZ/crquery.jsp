<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*,fz.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
//查詢飛時

response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
 %>
 <jsp:forward page="sendredirect.jsp" /> 
<%
} 



String year = request.getParameter("fyy");
String month = request.getParameter("fmm");
String date = request.getParameter("fdd");
String fltno = request.getParameter("fltno");
String sql = "select * from fzttrip where strdate='"+
			year +"/"+month +"/"+date+"'";


	if (fltno.equals("")){
		sql = sql+" order by strflt,tripno";
	}
	else{
		sql = sql+" and trim(strflt) ='"+fltno+"' order by strflt,tripno";
	
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

myResultSet = stmt.executeQuery(sql); 

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Flying Time</title>
<link href="menu.css" rel="stylesheet" type="text/css">
</head>
<body>
<div align="center"><span class="txttitletop">Flying Time Query（飛時查詢）<br>

  <%
	if(!fltno.equals("")){
%>
	  <%=year +"/"+month +"/"+date+"&nbsp; Fltno:"+fltno+""%>
  <%
	}
	else{
%>
	  <%=year +"/"+month +"/"+date%>
  <%
	}
%>
  </span>
</div>

<table width="615"  border="0" align="center" class="fortable">
  <tr>
    <td width="162" class="tablehead3">TripNo</td>
    <td width="142" class="tablehead3">FltNo</td>
    <td width="175" class="tablehead3">Date</td>
    <td width="116" class="tablehead3">Flying Time </td>
  </tr>
<%
String bcolor = null;
int xCount = 0;
	if(myResultSet != null){
		while(myResultSet.next()){	
		String tripno	= myResultSet.getString("tripno");
		String strflt	= myResultSet.getString("strflt");
		String strdate	= myResultSet.getString("strdate");
		String cr 		= myResultSet.getString("cr");

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
    <td class="tablebody"><%= tripno%></td>
    <td class="tablebody"><%= strflt%></td>
    <td class="tablebody"><%= strdate%></td>
    <td class="tablebody"><%= cr%></td>
  </tr>
  <%
		}
	}
	
	if(xCount==0){
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
%>
	<jsp:forward page="showmessage.jsp">
	<jsp:param name="messagestring" value="No Data Found!!<br>查無相關資料！！" />
	</jsp:forward>
	<%
	}

%>
</table>


</body>
</html>
<%
}
catch (Exception e)
{
	  t = true;
}
finally
{
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
if(t)
{
%>
      <jsp:forward page="err.jsp" /> 
<%
}
%>