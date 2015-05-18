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
<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="java.sql.*"%>
<%@page import="java.sql.Date"%>
<%@ include file="../Connections/cnORP3DF.jsp" %>
<html>
<head>
<title>
Insert Crew Detail Processing
</title>
<meta http-equiv="pragma" content="no-cache">
</head>

<body background="clearday.jpg">

<%
   
   String staff_num = request.getParameter("staff_num");
   String surname = request.getParameter("surname");
   String prev_surname = request.getParameter("prev_surname");
   String first_name = request.getParameter("first_name");
   String preferred_name = request.getParameter("preferred_name");
   String title = request.getParameter("title");
   String sex = request.getParameter("sex");
   String birth_dt = request.getParameter("birth_dt");
   String empl_dt = request.getParameter("empl_dt");
   String perm_dt = request.getParameter("perm_dt");
   String retr_dt = request.getParameter("retr_dt");
   String term_dt = request.getParameter("term_dt");
   String non_crew_ind = request.getParameter("non_crew_ind");
   String sen_num = request.getParameter("sen_num");
   String alias = request.getParameter("alias");
   String remarks = request.getParameter("remarks");
   String last_maintenance_sys_dts = request.getParameter("last_maintenance_sys_dts");
   String nationality_cd = request.getParameter("nationality_cd");
   String birth_country = request.getParameter("birth_country");
   String initials = request.getParameter("initials");
   String spouse_employee_cd = request.getParameter("spouse_employee_cd");

   String u1 = "insert into crew_t (";
   String u2 = null;
   String u3 = ") values(";
   String u4 = null;
   
   if (staff_num.trim().equals("") || surname.trim().equals("") || first_name.trim().equals("")
       || sex.trim().equals("") || empl_dt.trim().equals("") || retr_dt.trim().equals("") ||
        last_maintenance_sys_dts.trim().equals(""))
   {
%>
        <h4>column:staff_num, surname, first_name, sex, empl_dt, retr_dt, last_maintenance_sys_dts</h4>
        <br>These columns are not NULL value, please check your data!!
<%
        return;
   }
   
   u2 = "staff_num, surname, prev_surname, first_name, preferred_name, title, sex, ";
   u4 = staff_num+", '"+surname+"', '"+prev_surname+"', '"+first_name+"', '"+preferred_name+"', '"+title+"', '"+sex+"', ";
   
   if (!birth_dt.trim().equals("")) 
   { 
        u2 += "birth_dt, "; 
        u4 += "to_date('" + birth_dt.substring(0,10) + "','yyyy-mm-dd'), ";
   }
   if (!empl_dt.trim().equals("")) 
   { 
        u2 += "empl_dt, "; 
        u4 += "to_date('" + empl_dt.substring(0,10) + "','yyyy-mm-dd'), ";
   }
   if (!perm_dt.trim().equals("")) 
   { 
        u2 += "perm_dt, "; 
        u4 += "to_date('" + perm_dt.substring(0,10) + "','yyyy-mm-dd'), ";
   }
   if (!retr_dt.trim().equals("")) 
   { 
        u2 += "retr_dt, "; 
        u4 += "to_date('" + retr_dt.substring(0,10) + "','yyyy-mm-dd'), ";
   }
   if (!term_dt.trim().equals("")) 
   { 
        u2 += "term_dt, "; 
        u4 += "to_date('" + term_dt.substring(0,10) + "','yyyy-mm-dd'), ";
   }
   u2 += "non_crew_ind, "; 
   u4 += "'" + non_crew_ind + "', ";
   if (!sen_num.trim().equals("")) 
   { 
        u2 += "sen_num, "; 
        u4 += sen_num + ", ";
   }
   u2 += "alias, remarks, "; 
   u4 += "'" + alias + "', '" + remarks + "', ";
   if (!last_maintenance_sys_dts.trim().equals("")) 
   { 
        u2 += "last_maintenance_sys_dts, "; 
        u4 += "to_date('" + last_maintenance_sys_dts.substring(0,10) + "','yyyy-mm-dd'), ";
   }
   u2 += "nationality_cd, birth_country, initials, spouse_employee_cd, "; 
   u4 += "'"+nationality_cd+"', '"+birth_country+"', '"+initials+"', '"+spouse_employee_cd+"', ";
        
   u2 = u2.substring(0,u2.length() - 2);     
   u4 = u4.substring(0,u4.length() - 2) + ")";
   
   String aa = u1 + u2 + u3 + u4;
try{   
   Class.forName(MM_cnORP3DF_DRIVER);
   Connection myConn = DriverManager.getConnection(MM_cnORP3DF_STRING,MM_cnORP3DF_USERNAME,MM_cnORP3DF_PASSWORD);
   Statement stmt = myConn.createStatement();

   int rowsAffected = stmt.executeUpdate(aa);
   /*if (rowsAffected == 1)
   {*/
%>
      <h1>Successful Addition of Crew Information</h1>
      <a href="crewdetail.jsp?STAFF_NUM=<%= staff_num %>">See Crew Detail</a><br>
      <a href="login.jsp" target="_top">Go back to Login page</a>
<%  
	stmt.close();
    myConn.close();
   } catch(Exception e) {   
   //else
   //{
%>
      <h1>Sorry, addition has failed.</h1> 
      <a href="crewlist.jsp"><%=e.toString()%></a>     
<%
   }
   /*stmt.close();
   myConn.close();*/
%>
</body>
</html>