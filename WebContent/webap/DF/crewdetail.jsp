<%
String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login
if (session.isNew()) 
{		//check user session start first
  %> <jsp:forward page="login.jsp" /> <%
} 
if (sGetUsr == null) 
{		//check if not login
  %> <jsp:forward page="login.jsp" /> <%
} 
%>
<%@page contentType="text/html; charset=big5" language="java" import="java.sql.*"%>
<%@ include file="../Connections/cnORP3DF.jsp" %>
<%@ page errorPage="error.jsp" %>
<html>
<head>
<title>
Edit Crew Detail
</title>
<meta http-equiv="pragma" content="no-cache">
</head>

<body background="clearday.jpg">
<center>
<h2>Edit Crew Imformation</h2>

<%
   String myempn = request.getParameter("empno");
   String fleet = request.getParameter("fleet");
   String duty = request.getParameter("duty");

   Class.forName(MM_cnORP3DF_DRIVER);
   Connection myConn = DriverManager.getConnection(MM_cnORP3DF_STRING,MM_cnORP3DF_USERNAME,MM_cnORP3DF_PASSWORD);
   Statement stmt = myConn.createStatement();
   
   ResultSet myResultSet = stmt.executeQuery("select * from crew_t where staff_num = " + myempn);
   if (myResultSet != null)
   {
   	while (myResultSet.next())
   	{
	   String surname = myResultSet.getString("surname");
	   String prev_surname = myResultSet.getString("prev_surname");
	   if (prev_surname == null) 
	      { prev_surname = ""; }
	   String first_name = myResultSet.getString("first_name");
           String preferred_name = myResultSet.getString("preferred_name");
           if (preferred_name == null) 
	      { preferred_name = ""; }
           String title = myResultSet.getString("title");
           if (title == null) 
	      { title = ""; }
           String sex = myResultSet.getString("sex");
           String birth_dt = myResultSet.getString("birth_dt");
           if (birth_dt == null) 
           { birth_dt = ""; }
           else
           { birth_dt = myResultSet.getString("birth_dt").substring(0,10); }
           String empl_dt = myResultSet.getString("empl_dt").substring(0,10);
           String perm_dt = myResultSet.getString("perm_dt");
           if (perm_dt == null) 
	   { perm_dt = ""; }
	   else
           { perm_dt = myResultSet.getString("perm_dt").substring(0,10); }
           String retr_dt = myResultSet.getString("retr_dt").substring(0,10);
           String term_dt = myResultSet.getString("term_dt");
           if (term_dt == null) 
	   { term_dt = ""; }
	   else
           { term_dt = myResultSet.getString("term_dt").substring(0,10); }
           String non_crew_ind = myResultSet.getString("non_crew_ind");
           if (non_crew_ind == null) 
	      { non_crew_ind = ""; }
           String sen_num = myResultSet.getString("sen_num");
           if (sen_num == null) 
	      { sen_num = ""; }
           String alias = myResultSet.getString("alias");
           if (alias == null) 
	      { alias = ""; }
           String remarks = myResultSet.getString("remarks");
           if (remarks == null) 
	      { remarks = ""; }
           String last_maintenance_sys_dts = myResultSet.getString("last_maintenance_sys_dts").substring(0,10);
           String nationality_cd = myResultSet.getString("nationality_cd");
           if (nationality_cd == null) 
	      { nationality_cd = ""; }
           String birth_country = myResultSet.getString("birth_country");
           if (birth_country == null) 
	      { birth_country = ""; }
           String initials = myResultSet.getString("initials");
           if (initials == null) 
	      { initials = ""; }
           String spouse_employee_cd = myResultSet.getString("spouse_employee_cd");
           if (spouse_employee_cd == null) 
	      { spouse_employee_cd = ""; }
%>
<form name="form1" method="post" action="updcrew.jsp">
<table border="1">
<tr>
    <td><b>STAFF_NUM</b></td><td><input name="staff_num" type="text" width="12" value="<%= myempn %>"></td>
</tr>
<tr>
    <td><b>SURNAME</b></td><td><input name="surname" type="text" width="30" value="<%= surname %>"></td>
</tr>
<!--<tr>
    <td><b>PREV_SURNAME</b></td><td><input name="prev_surname" type="text" width="30" value="<%= prev_surname %>"></td>
</tr>-->
<tr>
    <td><b>FIRST_NAME</b></td><td><input name="first_name" type="text" width="30" value="<%= first_name %>"></td>
</tr>
<!--<tr>
    <td><b>PREFERRED_NAME</b></td><td><input name="preferred_name" type="text" width="30" value="<%= preferred_name %>"></td>
</tr>
<tr>
    <td><b>TITLE</b></td><td><input name="title" type="text" width="20" value="<%= title %>"></td>
</tr>-->
<tr>
    <td><b>SEX</b></td><td><input name="sex" type="text" width="1" value="<%= sex %>"></td>
</tr>
<!--<tr>
    <td><b>BIRTH_DT</b></td><td><input name="birth_dt" type="text" width="20" value="<%= birth_dt %>"></td>
</tr>-->
<tr>
    <td><b>EMPL_DT</b></td><td><input name="empl_dt" type="text" width="20" value="<%= empl_dt %>"></td>
</tr>
<!--<tr>
    <td><b>PERM_DT</b></td><td><input name="perm_dt" type="text" width="20" value="<%= perm_dt %>"></td>
</tr>-->
<tr>
    <td><b>RETR_DT</b></td><td><input name="retr_dt" type="text" width="20" value="<%= retr_dt %>"></td>
</tr>
<!--<tr>
    <td><b>TERM_DT</b></td><td><input name="term_dt" type="text" width="20" value="<%= term_dt %>"></td>
</tr>
<tr>
    <td><b>NON_CREW_IND</b></td><td><input name="non_crew_ind" type="text" width="1" value="<%= non_crew_ind %>"></td>
</tr>
<tr>
    <td><b>SEN_NUM</b></td><td><input name="sen_num" type="text" width="6" value="<%= sen_num %>"></td>
</tr>
<tr>
    <td><b>ALIAS</b></td><td><input name="alias" type="text" width="30" value="<%= alias %>"></td>
</tr>
<tr>
    <td><b>REMARKS</b></td><td><input name="remarks" type="text" width="30" value="<%= remarks %>"></td>
</tr>-->
<tr>
    <td><b>LAST_MAINTENANCE_SYS_DTS</b></td><td><input name="last_maintenance_sys_dts" type="text" width="20" value="<%= last_maintenance_sys_dts %>"></td>
</tr>
<!--<tr>
    <td><b>NATIONALITY_CD</b></td><td><input name="nationality_cd" type="text" width="3" value="<%= nationality_cd %>"></td>
</tr>
<tr>
    <td><b>BIRTH_COUNTRY</b></td><td><input name="birth_country" type="text" width="40" value="<%= birth_country %>"></td>
</tr>
<tr>
    <td><b>INITIALS</b></td><td><input name="initials" type="text" width="3" value="<%= initials %>"></td>
</tr>
<tr>
    <td><b>SPOUSE_EMPLOYEE_CD</b></td><td><input name="spouse_employee_cd" type="text" width="12" value="<%= spouse_employee_cd %>"></td>
</tr>-->
<tr>
    <td><b>Fleet</b></td><td><input name="fleet" type="text" width="20" value="<%= fleet %>"></td>
</tr>
<tr>
	<td><b>Rank</b></td><td><input name="rank" type="text" width="20" value="<%= duty %>"></td>
</tr>
<tr>
    <td colspan="2">
         <center>
              
      <input type="submit" value="Update Change" >
         </center> 
</tr>
<tr>
    <td colspan="2">
         <center>
              <a href="deletecrew.jsp?staff_num=<%= myempn %>">Delete Crew Information</a>   
         </center> 
</tr>
</table>
</form>
<%        
    	}  
   }
   stmt.close();
   myConn.close();
%>
</center>
</body>
</html>