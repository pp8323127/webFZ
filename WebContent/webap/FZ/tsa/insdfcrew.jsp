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
<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="java.sql.*,java.sql.Date"%>
<html>
<head>
<title>
Insert Crew Information Processing
</title>
<meta http-equiv="pragma" content="no-cache">
<link href="../menu.css" rel="stylesheet" type="text/css">
</head>

<body >

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

   String u1 = "insert into dftcrew (";
   String u2 = null;
   String u3 = ") values(";
   String u4 = null;
   
   if (empno.trim().equals(""))
   {
%>
        <h4>column:Empno</h4>
        <br>These columns can't be null, please check your data!!
<%
        return;
   }

   if (name.trim().equals(""))
   {
%>
        <h4>column:Name</h4>
        <br>These columns can't be null, please check your data!!
<%
        return;
   }
   
   u2 = "empno, ";
   u4 = "'" + empno + "', ";
   
   if (!name.trim().equals("")) 
   { 
        u2 += "name, "; 
        u4 += "'" + name + "', ";
   }
   if (!ename.trim().equals("")) 
   { 
        u2 += "ename, "; 
        u4 += "UPPER('" + ename + "'), ";
   }
   if (!sex.trim().equals("")) 
   { 
        u2 += "sex, "; 
        u4 += "UPPER('" + sex + "'), ";
   }
   if (!flag.trim().equals("")) 
   { 
        u2 += "flag, "; 
        u4 += "'" + flag + "', ";
   }
   u2 += "chgid, chgtime, ";
   u4 += "'" + sGetUsr + "', sysdate, ";
   if (!cabin.trim().equals("")) 
   { 
        u2 += "cabin, "; 
        u4 += "UPPER('" + cabin + "'), ";
   }
   if (!box.trim().equals("")) 
   { 
        u2 += "box, "; 
        u4 += "'" + box + "', ";
   }
   if (!nflrk.trim().equals("")) 
   { 
        u2 += "nflrk, "; 
        u4 += "UPPER('" + nflrk + "'), ";
   }
   if (!oflrk.trim().equals("")) 
   { 
        u2 += "oflrk, "; 
        u4 += "UPPER('" + oflrk + "'), ";
   }
   if (!ovrk.trim().equals("")) 
   { 
        u2 += "ovrk, "; 
        u4 += "'" + ovrk + "', ";
   }
   if (!indt.trim().equals("")) 
   { 
        u2 += "indt, "; 
        u4 += "'" + indt + "', ";
   }
   if (!poid.trim().equals("")) 
   { 
        u2 += "poid, "; 
        u4 += "UPPER('" + poid + "'), ";
   }
   if (!podt.trim().equals("")) 
   { 
        u2 += "podt, "; 
        u4 += "UPPER('" + podt + "'), ";
   }
   if (!pout.trim().equals("")) 
   { 
        u2 += "pout, "; 
        u4 += "UPPER('" + pout + "'), ";
   }
   if (!post.trim().equals("")) 
   { 
        u2 += "post, "; 
        u4 += "UPPER('" + post + "'), ";
   }
   if (!occu.trim().equals("")) 
   { 
        u2 += "occu, "; 
        u4 += "UPPER('" + occu + "'), ";
   }
   if (!fleet.trim().equals("")) 
   { 
        u2 += "fleet, "; 
        u4 += "UPPER('" + fleet + "'), ";
   }
   if (!base.trim().equals("")) 
   { 
        u2 += "base, "; 
        u4 += "UPPER('" + base + "'), ";
   }
   if (!sect.trim().equals("")) 
   { 
        u2 += "sect, "; 
        u4 += "'" + sect + "', ";
   }
   if (!paycode.trim().equals("")) 
   { 
        u2 += "paycode, "; 
        u4 += "UPPER('" + paycode + "'), ";
   }
   if (!brk.trim().equals("")) 
   { 
        u2 += "brk, "; 
        u4 += "'" + brk + "', ";
   }
   if (!brkrate.trim().equals("")) 
   { 
        u2 += "brkrate, "; 
        u4 += brkrate + ", ";
   }
   if (!banknont.trim().equals("")) 
   { 
        u2 += "banknont, "; 
        u4 += "'" + banknont + "', ";
   }
   if (!banknous.trim().equals("")) 
   { 
        u2 += "banknous, "; 
        u4 += "'" + banknous + "', ";
   }
   if (!taxfmin.trim().equals("")) 
   { 
        u2 += "taxfmin, "; 
        u4 += taxfmin + ", ";
   }
   if (!ipcp.trim().equals("")) 
   { 
        u2 += "ipcp, "; 
        u4 += "UPPER('" + ipcp + "'), ";
   }
   if (!traf.trim().equals("")) 
   { 
        u2 += "traf, "; 
        u4 += "UPPER('" + traf + "'), ";
   }
   if (!box.trim().equals("")) 
   { 
        u2 += "sess, "; 
        u4 += "SUBSTR(LPAD('" + box + "',5,'0'),1,3), ";
   }
// add by cs66...start

   if (!birthdate.trim().equals("")) 
   { 
        u2 += "birthdate, "; 
        u4 += "to_date('" + birthdate.substring(0,10) + "','yyyy-mm-dd'), ";
   }
   
   if (!birthplace.trim().equals("")) 
   { 
        u2 += "birthplace, "; 
        u4 += "UPPER('" + birthplace + "'), ";
   }
  if (!passno.trim().equals("")) 
   { 
        u2 += "passno, "; 
        u4 += "UPPER('" + passno + "'), ";
   }
  if (!passcontry.trim().equals("")) 
   { 
        u2 += "passcontry, "; 
        u4 += "UPPER('" + passcontry + "'), ";
   }
 if (!passcon.trim().equals("")) 
   { 
        u2 += "passcon, "; 
        u4 += "UPPER('" + passcon + "'), ";
   }
 if (!nation.trim().equals("")) 
   { 
        u2 += "nation, "; 
        u4 += "UPPER('" + nation + "'), ";
   }
  if (!passvalid.trim().equals("")) 
   { 
        u2 += "passvalid, "; 
        u4 += "to_date('" + passvalid.substring(0,10) + "','yyyy-mm-dd'), ";
   }   
    if (!lastname.trim().equals("")) 
   { 
        u2 += "lastname, "; 
        u4 += "UPPER('" + lastname + "'), ";
   }   
  if (!firstname.trim().equals("")) 
   { 
        u2 += "firstname, "; 
        u4 += "UPPER('" + firstname + "'), ";
   }  
  if (!middlename.trim().equals("")) 
   { 
        u2 += "middlename, "; 
        u4 += "UPPER('" + middlename + "'), ";
   }  
   
    
// add by cs66...end   
        
   u2 = u2.substring(0,u2.length() - 2);     
   u4 = u4.substring(0,u4.length() - 2) + ")";
   
   String aa = u1 + u2 + u3 + u4;
   
 Connection myConn = null;
 Statement stmt = null;
    ci.db.ConnDB cn = new ci.db.ConnDB();

 Driver dbDriver = null;

try{  
	cn.setDFUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	myConn = dbDriver.connect(cn.getConnURL(), null);

   
   stmt = myConn.createStatement();

   int rowsAffected = stmt.executeUpdate(aa);

%>
      <p class="txttitletop">Successful Addition of Crew Information</p>
      <a href="dfcrewdetail.jsp?empno=<%= empno %>">See Crew Detail</a><br>

<%  
   }catch(Exception e) {  

%>
      <p class="txttitletop">Sorry, addition has failed. <br>
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