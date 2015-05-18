<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="al.*,java.sql.*,java.net.URLEncoder,ci.db.ConnDB"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first
	response.sendRedirect("login.jsp");
} 
%>
<html>
<head>
<title>
Update AL offsheet
</title>
<meta http-equiv="pragma" content="no-cache">
<link href="../FZ/menu.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style5 {font-size: 24px}
.style6 {color: #0000FF}
-->
</style>
</head>
<body>
<div align="center"> 
  <p>
    <%
   String sern = request.getParameter("sern");
   String station = request.getParameter("station");
   String syy = request.getParameter("syy");
   String smm = request.getParameter("smm");
   String sdd = request.getParameter("sdd");
   String eyy = request.getParameter("eyy");
   String emm = request.getParameter("emm");
   String edd = request.getParameter("edd");
   String offsdate = syy + "-" + smm + "-" + sdd;
   String offedate = eyy + "-" + emm + "-" + edd;
   
	int offdays = 0;
   
   //***********�ˬd����O�_�i�ؤJ***************************************************************
    Connection con = null;
	Driver dbDriver = null;
	ResultSet rs = null;
	Statement stmt = null;
try {
    ConnDB cn = new ConnDB();
	cn.setORP3EGUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	con = dbDriver.connect(cn.getConnURL(), null);
	stmt = con.createStatement();
    rs = stmt.executeQuery("select (to_date('"+offedate+"','yyyy-mm-dd') - to_date('"+offsdate+
	"','yyyy-mm-dd') + 1) offdays from dual");
    if (rs.next()){
   		offdays = rs.getInt("offdays");
    }
}
catch (Exception e)
{
	 out.println(e.toString());
}  
finally{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(con != null) con.close();}catch(SQLException e){}
}
%>
</p>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <p><span class="txttitletop">�z��J���欰<span class="style6"><%=offsdate%></span>��<span class="style6"><%=offedate%></span>�@</span><span class="txtxred style5"><strong><%=offdays%>��</strong></span></p>
  <p class="txtxred"><strong>* ����p�G���e���\�аȥ��A�T�{���ӬO�_���T</strong></p>
  <form name="form1" method="post" ONSUBMIT="return f_submit()" action="updal.jsp">
    <p>
      <input type="submit" name="Submit" value="�T�{">
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input type="button" name="cancel" value="����" onClick="javascript:history.go(-1);">
</p>
    <p>
      <input name="sern" type="hidden" value="<%=sern%>">
	  <input name="station" type="hidden" value="<%=station%>">
	  <input name="syy" type="hidden" value="<%=syy%>">
	  <input name="smm" type="hidden" value="<%=smm%>">
	  <input name="sdd" type="hidden" value="<%=sdd%>">
	  <input name="eyy" type="hidden" value="<%=eyy%>">
	  <input name="emm" type="hidden" value="<%=emm%>">
	  <input name="edd" type="hidden" value="<%=edd%>">
    </p>
  </form>
</div>
</body>
<script language=javascript>
function f_submit()
{  
	document.form1.Submit.disabled=1;
	return confirm("�e�X���� ?")
	 
}
</script>
</html>