<%

String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);

if (session.isNew()) 
{		//check user session start first
  %> <jsp:forward page="sendredirect.jsp" /> <%
} 
if (sGetUsr == null) 
{		//check if not login
  %> <jsp:forward page="sendredirect.jsp" /> <%
} 
%>
<%@page contentType="text/html; charset=big5" language="java" import="java.sql.*"%>
<html>
<head>
<title>
DFCrew detail Information update
</title>
<meta http-equiv="pragma" content="no-cache">
<link href="../menu.css" rel="stylesheet" type="text/css">
</head>

<body background="clearday.jpg">
<p class="txttitletop">Update Crew Record</p>
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
	// add by cs66...start

	String birthdate= request.getParameter("birthdate");
	String birthplace	= request.getParameter("birthplace");
	String passno	= request.getParameter("passno");
	String passcontry	= request.getParameter("passcontry");
	String passcon	= request.getParameter("passcon");
	String nation	= request.getParameter("nation");
	String passvalid	= request.getParameter("passvalid");
	String lastname	= request.getParameter("lastname");
	String firstname	= request.getParameter("firstname");
	String middlename	= request.getParameter("middlename");
	// add by cs66...end
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
					", brkrate = '" + brkrate + "'" +
					", banknont = '" + banknont + "'" +
					", banknous = '" + banknous + "'" +
					", taxfmin = '" + taxfmin + "'" + 
					", ipcp = UPPER('" + ipcp + "')" +
					", traf = UPPER('" + traf + "')" +
					", sess = SUBSTR(LPAD('" + box + "',5,'0'),1,3)" + 
				//--- add by cs66---start
				//birthdate = to_date('1977-08-03','yyyy-mm-dd')
					", birthdate = to_date('" + birthdate + "','yyyy-mm-dd')" +
					", birthplace = UPPER('" + birthplace + "')" +
					", passno = UPPER('" + passno + "')" +
					", passcontry = UPPER('" + passcontry + "')" +
					", passcon = UPPER('" + passcon + "')" +
					", nation = UPPER('" + nation + "')" +
					", passvalid = to_date('" + passvalid + "','yyyy-mm-dd')" +
					", lastname = UPPER('" + lastname + "')" +
					", firstname = UPPER('" + firstname + "')" +
					", middlename = UPPER('" + middlename + "') " +
				//--- add by cs66---end
                    " where empno = '" + empno + "'";
//out.print(updsql);					


   if (name.trim().equals(""))
   {
%>
        <h4>column:Name</h4>
        <br>These columns can't be null, please check your data!!
<%
        return;
   }
  Connection myConn = null;
   Statement stmt = null;				
   
   ci.db.ConnDB cn = new ci.db.ConnDB();

 Driver dbDriver = null;

try{

	cn.setDFUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	myConn = dbDriver.connect(cn.getConnURL(), null);


   stmt = myConn.createStatement();  
   int rowsAffected = stmt.executeUpdate(updsql);
   
 if (rowsAffected == 1)
   {
%>
      <p class="txtxred">Successful Modification of Crew Record!!!</p>
      <a href="dfcrewdetail.jsp?empno=<%=empno%>" class="txtblue">See Crew Record</a><br>
   <%
   }
   else
   {
   
   %>  

      <p class="txtxred">Sorry, modification has failed.</p> 
      <a href="dfcrewdetail.jsp?empno=<%=empno%>" >Go back to Crew Records</a>     
<%
  }
 
  }
  
   catch(Exception e) {  

%>
      <p class="txttitletop">Sorry, modify has failed. <br>
      <%=e.toString()%></p>
<%
   }
   finally
{
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(myConn != null) myConn.close();}catch(SQLException e){}
}
%>

</body>
</html>