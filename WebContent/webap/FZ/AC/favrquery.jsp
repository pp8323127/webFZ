<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="fz.*,java.sql.*,ci.db.*"%>
<%
/*   
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
*/
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
 %>
 <jsp:forward page="sendredirect.jsp" /> 
<%
} 

Connection conn = null;
Driver dbDriver = null;

Statement stmt = null;
ResultSet myResultSet = null;
boolean t = false;
try
{
	ConnDB cn = new ConnDB();
	cn.setORP3FZUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);

//dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
//conn = dbDriver.connect("jdbc:weblogic:pool:CAL.FZCP02", null);

stmt = conn.createStatement();
String sql ="select fltno,count(empno) count from fztfavr group by fltno";
myResultSet = stmt.executeQuery(sql); 

String fltno = null;
String count = null;

String bcolor = null;
int xCount = 0;
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>尺痁琩高</title>
<link href="../menu.css" rel="stylesheet" type="text/css">
</head>
<body>
<table width="76%"  border="0" align="center">
  <tr>
    <td><div align="center"><span class="txttitletop">尺痁计参璸琩高 </span></div></td>
  </tr>
  <tr>
    <td><div align="center"><span class="txtblue">click FlightNo to query who like this flight(翴匡FlightNo琩高尺痁)</span></div></td>
  </tr>
</table>
<table width="76%"  border="0" align="center" class="fortable">
  <tr>
    <td width="50%" class="tablehead3">FlightNo</td>
    <td width="50%" class="tablehead3">How many people like it<br>
    尺痁计 </td>
  </tr>
  <%
  if (myResultSet != null){
  	while(myResultSet.next()){
		fltno	=	myResultSet.getString("fltno");
		count	=	myResultSet.getString("count");
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
    <td class="tablebody"><acronym title="show who like <%=fltno%>"><a href="favorfltquery.jsp?fltno=<%=fltno%>"><%=fltno%></a></acronym></td>
    <td class="tablebody"><%=count%></td>
  </tr>
  <%
	  }
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
