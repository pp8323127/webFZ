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
//out.println(session.getAttribute("cs55.auth"));
%>

<html>
<head>
<title>
Insert Crew Detail
</title>
<meta http-equiv="pragma" content="no-cache">
</head>

<body background="clearday.jpg">
<center>
<%
if (session.getAttribute("cs55.auth").equals("R"))
{
        %><jsp:forward page="notauth.jsp" /><%
}
else
{
%>
<h2>Insert Crew Imformation</h2>
<form method="post" action="inscrew.jsp">
<table border="1">
<tr>
    <td><b>STAFF_NUM</b></td><td><input name="staff_num" type="text" width="12"></td>
</tr>
<tr>
    <td><b>SURNAME</b></td><td><input name="surname" type="text" width="30"></td>
</tr>
<tr>
    <td><b>PREV_SURNAME</b></td><td><input name="prev_surname" type="text" width="30"></td>
</tr>
<tr>
    <td><b>FIRST_NAME</b></td><td><input name="first_name" type="text" width="30"></td>
</tr>
<tr>
    <td><b>PREFERRED_NAME</b></td><td><input name="preferred_name" type="text" width="30"></td>
</tr>
<tr>
    <td><b>TITLE</b></td><td><input name="title" type="text" width="20"></td>
</tr>
<tr>
    <td><b>SEX</b></td><td><input name="sex" type="text" width="1"></td>
</tr>
<tr>
    <td><b>BIRTH_DT</b></td><td><input name="birth_dt" type="text" width="20"></td>
</tr>
<tr>
    <td><b>EMPL_DT</b></td><td><input name="empl_dt" type="text" width="20"></td>
</tr>
<tr>
    <td><b>PERM_DT</b></td><td><input name="perm_dt" type="text" width="20"></td>
</tr>
<tr>
    <td><b>RETR_DT</b></td><td><input name="retr_dt" type="text" width="20"></td>
</tr>
<tr>
    <td><b>TERM_DT</b></td><td><input name="term_dt" type="text" width="20"></td>
</tr>
<tr>
    <td><b>NON_CREW_IND</b></td><td><input name="non_crew_ind" type="text" width="1"></td>
</tr>
<tr>
    <td><b>SEN_NUM</b></td><td><input name="sen_num" type="text" width="6"></td>
</tr>
<tr>
    <td><b>ALIAS</b></td><td><input name="alias" type="text" width="30"></td>
</tr>
<tr>
    <td><b>REMARKS</b></td><td><input name="remarks" type="text" width="30"></td>
</tr>
<tr>
    <td><b>LAST_MAINTENANCE_SYS_DTS</b></td><td><input name="last_maintenance_sys_dts" type="text" width="20"></td>
</tr>
<tr>
    <td><b>NATIONALITY_CD</b></td><td><input name="nationality_cd" type="text" width="3"></td>
</tr>
<tr>
    <td><b>BIRTH_COUNTRY</b></td><td><input name="birth_country" type="text" width="40"></td>
</tr>
<tr>
    <td><b>INITIALS</b></td><td><input name="initials" type="text" width="3"></td>
</tr>
<tr>
    <td><b>SPOUSE_EMPLOYEE_CD</b></td><td><input name="spouse_employee_cd" type="text" width="12"></td>
</tr>
<tr>
    <td colspan="2">
         <center>
              <input type="submit" value="Update Insert">
         </center> 
</tr>
</table>
</form>
<%
}
%>
</center>
</body>
</html>
