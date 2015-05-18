<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*, java.util.*, java.text.*, javax.naming.*, ci.db.*" %>
<%
 //Check user already login or not

String s_USER_ID = (String)session.getAttribute("s_USER_ID");
String sGetUsr   = request.getParameter("sGetUsr");
session.setAttribute("sGetUsr",sGetUsr);

Connection conn = null;
Driver dbDriver = null;
Statement stmt  = null;
ResultSet myResultSet = null;
String rptloc  	= "TSA";
String sdate 	= null;
String theday  	= null;
try{	 
	ConnDB cn = new ConnDB();

	cn.setORP3FZUserCP();

	//cn.setDFUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
	stmt = conn.createStatement();		
	myResultSet = stmt.executeQuery("select to_char(sysdate, 'yyyy-mm-dd') from dual");
	if (myResultSet.next()) theday = myResultSet.getString(1);
   }catch (Exception e){
			out.println("Error : " + e.toString());
		       }
    finally{	try{
			if(myResultSet != null) myResultSet.close();
		   }catch(SQLException e){}
   		try{
			if(stmt != null) stmt.close();
		   }catch(SQLException e){}
   		try{
			if(conn != null) conn.close();
		   }catch(SQLException e){}
	   }
%>
<html>
<head>
<link rel="stylesheet" href="format.css" type="text/css">
<title></title>
<script language="Javascript" src="../temple/FieldTools.js">
</script>
<script language=javascript>  
	function getCalendar(obj) { eval("wincal=window.open('../Calendar.htm','" + obj +"','width=350,height=200')");}
	function f_Back(){ history.go(-1);}
</script>
</head>
<body>
<%
	
try{	
%>
<form action="Airworthiness_Check.jsp" method= "post" name= "form1" class="txtblue" target="mainFrame">
<table width="300" align="left">
	<tr class="detail">
		<td class="title">Check Date  :</td>
		<td><span onclick="getCalendar('applydate')" style="cursor:pointer">
			<input name="applydate" type="text" class="text" style="cursor:pointer" onFocus="this.blur()"
			value="<%=theday%>" size="15" maxlength="10"><img src="../images/p2.gif" width="22" height="22">
		    </span>
        	</td>
		<td> <input type="submit"  value="Inquery"></td>
</table>
</form>
<%
	}catch(Exception ex) {out.println(ex.toString());} finally{}
%>
</body>
</html>