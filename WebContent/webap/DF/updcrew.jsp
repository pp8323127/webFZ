<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="java.sql.*"%>
<%@page import="java.sql.Date"%>
<%@ include file="../Connections/cnORP3DF.jsp" %>
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

<html>
<head>
<title>
Modify Crew Detail Processing
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
   //Date birth_dt = Date.valueOf(request.getParameter("birth_dt").substring(0,10));
   //Date empl_dt = Date.valueOf(request.getParameter("empl_dt").substring(0,10));
   String perm_dt = request.getParameter("perm_dt");
   String retr_dt = request.getParameter("retr_dt");
   String term_dt = request.getParameter("term_dt");
   //Date perm_dt = Date.valueOf(request.getParameter("perm_dt").substring(0,10));
   //Date retr_dt = Date.valueOf(request.getParameter("retr_dt").substring(0,10));
   //Date term_dt = Date.valueOf(request.getParameter("term_dt").substring(0,10));
   String non_crew_ind = request.getParameter("non_crew_ind");
   String sen_num = request.getParameter("sen_num");
   String alias = request.getParameter("alias");
   String remarks = request.getParameter("remarks");
   String last_maintenance_sys_dts = request.getParameter("last_maintenance_sys_dts");
   //Date last_maintenance_sys_dts = Date.valueOf(request.getParameter("last_maintenance_sys_dts").substring(0,10));
   String nationality_cd = request.getParameter("nationality_cd");
   String birth_country = request.getParameter("birth_country");
   String initials = request.getParameter("initials");
   String spouse_employee_cd = request.getParameter("spouse_employee_cd");
   String fleet = request.getParameter("fleet");
   String rank = request.getParameter("rank");
   
   String u1 = "update crew_t set ";
   String u2 = null;
   String u3 = " where staff_num=" + staff_num;
   if (!surname.trim().equals("null")) 
        { u2 = "surname='" + surname + "', "; }
   /*if (!prev_surname.trim().equals("null")) 
        { u2 += "prev_surname='" + prev_surname + "', "; }*/
   if (!first_name.trim().equals("null")) 
        { u2 += "first_name='" + first_name + "', "; }
   /*if (!preferred_name.trim().equals("null")) 
        { u2 += "preferred_name='" + preferred_name + "', "; }
   if (!title.trim().equals("null")) 
        { u2 += "title='" + title + "', "; }*/
   if (!sex.trim().equals("null")) 
        { u2 += "sex='" + sex + "', "; }
   /*if (!birth_dt.trim().equals("")) 
        { u2 += "birth_dt=to_date('" + birth_dt.substring(0,10) + "','yyyy-mm-dd'), "; }*/
   if (!empl_dt.trim().equals("")) 
        { u2 += "empl_dt=to_date('" + empl_dt.substring(0,10) + "','yyyy-mm-dd'), "; }
   /*if (!perm_dt.trim().equals("")) 
        { u2 += "perm_dt=to_date('" + perm_dt.substring(0,10) + "','yyyy-mm-dd'), "; }*/
   if (!retr_dt.trim().equals("")) 
        { u2 += "retr_dt=to_date('" + retr_dt.substring(0,10) + "','yyyy-mm-dd'), "; }
   /*if (!term_dt.trim().equals("")) 
        { u2 += "term_dt=to_date('" + term_dt.substring(0,10) + "','yyyy-mm-dd'), "; }
   if (!non_crew_ind.trim().equals("null")) 
        { u2 += "non_crew_ind='" + non_crew_ind + "', "; }
   if (!sen_num.trim().equals("")) 
        { u2 += "sen_num=" + sen_num + ", "; }
   if (!alias.trim().equals("null")) 
        { u2 += "alias='" + alias + "', "; }
   if (!remarks.trim().equals("null")) 
        { u2 += "remarks='" + remarks + "', "; }*/
   if (!last_maintenance_sys_dts.trim().equals("")) 
        { u2 += "last_maintenance_sys_dts=to_date('" + last_maintenance_sys_dts.substring(0,10) + "','yyyy-mm-dd'), "; }
   /*if (!nationality_cd.trim().equals("null")) 
        { u2 += "nationality_cd='" + nationality_cd + "', "; }
   if (!birth_country.trim().equals("null")) 
        { u2 += "birth_country='" + birth_country + "', "; }
   if (!initials.trim().equals("null")) 
        { u2 += "initials='" + initials + "', "; }
   if (!spouse_employee_cd.trim().equals("null")) 
        { u2 += "spouse_employee_cd='" + spouse_employee_cd + "', "; }*/
        
        
   u2 = u2.substring(0,u2.length() - 2);
   
   String aa = u1 + u2 + u3;
   
   String fleeteffmax = "select max(eff_dt) from crew_fleet_t where staff_num = " + staff_num;
   String updfleet = "update crew_fleet_t set fleet_cd = '" + fleet + "' where staff_num = " + staff_num + " and eff_dt = (" + fleeteffmax + ")";
   String rankeffmax = "select max(eff_dt) from crew_rank_t where staff_num = " + staff_num;
   String updrank = "update crew_rank_t set rank_cd = '" + rank + "' where staff_num = " + staff_num + " and eff_dt = (" + rankeffmax + ")";
   
   Class.forName(MM_cnORP3DF_DRIVER);
   Connection myConn = DriverManager.getConnection(MM_cnORP3DF_STRING,MM_cnORP3DF_USERNAME,MM_cnORP3DF_PASSWORD);  
   Statement stmt = myConn.createStatement();
%>

<% 
   int rowsAffected = stmt.executeUpdate(aa);
   int updf = stmt.executeUpdate(updfleet);
   int updr = stmt.executeUpdate(updrank);
   if (rowsAffected == 1 && updf == 1 && updr == 1)
   {
%>
      <h1>Successful Modification of Crew Information</h1>
      <a href="crewdetail.jsp?empno=<%= staff_num %>">See Crew Detail</a><br>
      <a href="login.jsp" target="_top">Go back to Login page</a>
<%  
   }    
   else
   {
%>
      <h1>Sorry, modification has failed.</h1> 
      <a href="crewdetail.jsp?STAFF_NUM=<%= staff_num %>">Go back to Crew Detail</a>     
<%
   }
   stmt.close();
   myConn.close();
%>
</body>
</html>