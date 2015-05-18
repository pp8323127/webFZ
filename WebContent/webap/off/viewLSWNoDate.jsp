<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="ci.db.*,java.sql.*" %>
<%
Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
ResultSet myResultSet = null;
boolean t = false;
int cnt=0;

try
{
ConnectionHelper ch = new ConnectionHelper();
conn = ch.getConnection();
stmt = conn.createStatement();	

String comm = null;
String seq = null;
String sdate = null;
String edate = null;
String tempbgcolor = "";
String sql = "select seq, to_char(sdate,'YYYY/MM/DD') sdate, to_char(edate,'YYYY/MM/DD') edate from egtnolsw order by sdate";
myResultSet = stmt.executeQuery(sql); 
%>

<html>
<head>
<title>LSW �ި��d��</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="StyleSheet" href = "menu.css" type="text/css" />
</head>

<body>
  <p align="center" class="txtxred"> ���P���Ұ���T�w���ި��A��l�ި��W�C�p�U�C</p>
  <table width="60%"  border="1" align="center" cellpadding="0" cellspacing="1" class="fortable">
    <tr>
      <td colspan="4" class="tablehead3"><div align="center">LSW �ި��</div></td>
    </tr>
    <tr>
      <td  class="tablebody" bgcolor="#CCCCCC">#</td>
      <td  class="tablebody" bgcolor="#CCCCCC">�ި��</td>
    </tr>

        <div align="center">
    <%
	if(myResultSet != null)
	{
		while (myResultSet.next())
		{
			if(cnt%2==0)
			{
				tempbgcolor = "#FFFFFF";
			}
			else
			{
				tempbgcolor = "#CCFFFF";
			}

		   sdate = myResultSet.getString("sdate");
		   edate = myResultSet.getString("edate");		   
	%>
 <tr bgcolor="<%=tempbgcolor%>">
   <td class="tablebody" align="center"><%=++cnt%></td>
   <td class="tablebody" align="center"><%=sdate%> ~ <%=edate%></td>
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
	 out.println(e.toString());
}
finally
{
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>
