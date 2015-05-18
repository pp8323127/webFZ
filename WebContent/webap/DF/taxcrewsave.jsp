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
<title>DFFP034</title>
<meta http-equiv="pragma" content="no-cache">
</head>

<body background="clearday.jpg">
<h2><font face="Arial, Helvetica, sans-serif" size="3" color="#000099">Update 
  Crew Flypay</font></h2>
<%
    String payid = request.getParameter("payid");
	String empno = request.getParameter("empno");
	String yyyy = request.getParameter("year");
	String mm = request.getParameter("month");
	String tflypay = request.getParameter("tflypay");
	String tover = request.getParameter("tover");
	String stby = request.getParameter("stby");
	String rew = request.getParameter("rew");
	String mgr = request.getParameter("mgr");
	String disp = request.getParameter("disp");
	String crus = request.getParameter("crus");
	String othb = request.getParameter("othb");
	String wine = request.getParameter("wine");
	String sale = request.getParameter("sale");
	
    String updsql = "Update dftpock set " + 
                    "tflypay = " + tflypay +
                    ", tover = " + tover +
                    ", stby = " + stby +
                    ", rew = " + rew +
                    ", mgr = " + mgr +
                    ", disp = " + disp +
                    ", crus = " + crus +
                    ", othb = " + othb +
                    ", wine = " + wine +
                    ", sale = " + sale +
                    ", tsum = " + tflypay + "+" + tover + "+" + stby + "+" + rew + "+" + mgr + "+" + disp + "+" + crus + "+" + othb + "+" + wine + "+" + sale +
                    " where empno = '" + empno + "' and yyyy = '" + yyyy + "' and mm = '" + mm + "'";
try
{	
   Class.forName(MM_cnORP3DF_DRIVER);
   Connection myConn = DriverManager.getConnection(MM_cnORP3DF_STRING,MM_cnORP3DF_USERNAME,MM_cnORP3DF_PASSWORD);
   Statement stmt = myConn.createStatement();  
   int rowsAffected = stmt.executeUpdate(updsql);
   if (rowsAffected == 1)
   {
%>
      
<h1><font face="Arial, Helvetica, sans-serif" size="2" color="#000099">Successful 
  Modification of Crew Record</font></h1>
      <a href="taxcrew.jsp?EMPNO=<%=empno%>&year=<%=yyyy%>&month=<%=mm%>&payid=<%=payid%>">See Crew Flypay Taxable List</a><br>
      <a href="login.jsp" target="_top">Go back to Login page</a>
<%  
   }    
   stmt.close();
   myConn.close();
}
catch (Exception e)
{
%>
       
<h1><font size="2" face="Arial, Helvetica, sans-serif" color="#FF0000">Sorry, 
  modification has failed.</font></h1>
<a href="taxcrew.jsp?EMPNO=<%=empno%>&year=<%=yyyy%>&month=<%=mm%>&payid=<%=payid%>">Go 
back to Crew Flypay Taxable List</a><br>  
<%
		System.out.println(e.toString());
} 
%>

</body>
</html>