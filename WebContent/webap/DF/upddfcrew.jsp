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
<html>
<head>
<title>
DFCrew detail Information update
</title>
<meta http-equiv="pragma" content="no-cache">
</head>

<body background="clearday.jpg">
<h2>Update Crew Record</h2>
<%
	String empno = request.getParameter("empno");
	String name = request.getParameter("name");
	String ename = request.getParameter("ename");
	String sex = request.getParameter("sex");
	String flag = request.getParameter("flag");
	String cabin = request.getParameter("cabin");
	String box = request.getParameter("box");
	String nflrk = request.getParameter("nflrk");
	String oflrk = request.getParameter("oflrk");
	String ovrk = request.getParameter("ovrk");
	String indt = request.getParameter("indt");
	String poid = request.getParameter("poid");
	String podt = request.getParameter("podt");
	String pout = request.getParameter("pout");
	String post = request.getParameter("post");
	String occu = request.getParameter("occu");
	String fleet = request.getParameter("fleet");
	String base = request.getParameter("base");
	String sect = request.getParameter("sect");
	String paycode = request.getParameter("paycode");
	String brk = request.getParameter("brk");
	String brkrate = request.getParameter("brkrate");
	String banknont = request.getParameter("banknont");
	String banknous = request.getParameter("banknous");
	String taxfmin = request.getParameter("taxfmin");
	String ipcp = request.getParameter("ipcp");
	String traf = request.getParameter("traf");
    String updsql = "Update dftcrew set " + 
                    "name = '" + name + "'" +
                    ", ename = UPPER('" + ename + "')" +
                    ", sex = UPPER('" + sex + "')" +
                    ", flag = '" + flag + "'" +
                    ", chgid = '" + sGetUsr + "'" +
                    ", chgtime = sysdate" + 
                    ", cabin = UPPER('" + cabin + "')" +
                    ", box = '" + box + "'" +
                    ", nflrk = UPPER('" + nflrk + "')" +
                    ", oflrk = UPPER('" + oflrk + "')" +
                    ", ovrk = '" + ovrk + "'" +
                    ", indt = '" + indt + "'" +
                    ", poid = UPPER('" + poid + "')" +
                    ", podt = UPPER('" + podt + "')" +
                    ", pout = UPPER('" + pout + "')" +
                    ", post = UPPER('" + post + "')" +
					", occu = UPPER('" + occu + "')" +
					", fleet = UPPER('" + fleet + "')" +
					", base = UPPER('" + base + "')" +
					", sect = '" + sect + "'" +
					", paycode = UPPER('" + paycode + "')" +
					", brk = '" + brk + "'" +
					", brkrate = " + brkrate +
					", banknont = '" + banknont + "'" +
					", banknous = '" + banknous + "'" +
					", taxfmin = " + taxfmin + 
					", ipcp = UPPER('" + ipcp + "')" +
					", traf = UPPER('" + traf + "')" +
					", sess = SUBSTR(LPAD('" + box + "',5,'0'),1,3)" + 
                    " where empno = '" + empno + "'";
   Class.forName(MM_cnORP3DF_DRIVER);
   Connection myConn = DriverManager.getConnection(MM_cnORP3DF_STRING,MM_cnORP3DF_USERNAME,MM_cnORP3DF_PASSWORD);  
   Statement stmt = myConn.createStatement();  
   int rowsAffected = stmt.executeUpdate(updsql);
   if (rowsAffected == 1)
   {
%>
      <h1>Successful Modification of Crew Record</h1>
      <a href="dfcrewdetail.jsp?EMPNO=<%=empno%>">See Crew Record</a><br>
      <a href="login.jsp" target="_top">Go back to Login page</a>
<%  
   }    
   else
   {
%>
      <h1>Sorry, modification has failed.</h1> 
      <a href="dfcrewdetail.jsp?EMPNO=<%=empno%>">Go back to Crew Records</a>     
<%
   }
   stmt.close();
   myConn.close();
%>

</body>
</html>