<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="fz.*,java.sql.*,ci.db.*"%>
<%
//�]�w���̤j���z�ƶq
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
//20130326�W�[**
String occu = (String) session.getAttribute("occu");
String powerUser =(String)session.getAttribute("powerUser");
//**************
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
 %>
 <jsp:forward page="sendredirect.jsp" /> 
<%
} else if(!("ED".equals(occu) | "Y".equals(powerUser))){//���դ�ñ���i�ݦ���20130326�W�[
%>
	<p  class="errStyle1">1.�z�L�v�ϥΦ��\��I<br> 2.���m�L�[�Э��s�n�J�I</p>
<%
	
}
else{

String userid =(String) session.getAttribute("userid") ; 

Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
ResultSet myResultSet = null;
boolean t = false;

try
{
//dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
//conn = dbDriver.connect("jdbc:weblogic:pool:CAL.FZCP02", null);
ConnDB cn = new ConnDB();
cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);

stmt = conn.createStatement();

int maxform = 0;
String sql = "select maxform from fztcmax where station='TPE'";
myResultSet = stmt.executeQuery(sql); 



%>

<html>
<head>
<title>�]�w�����z�ƶq</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="menu.css" rel="stylesheet" type="text/css">
</head>

<body>
<form action="updmax.jsp" method="post" name="form1">

<table width="44%"  border="1" align="center" cellpadding="0" cellspacing="1" class="fortable">
  <tr>
    <td colspan="2" class="tablehead3">�]�w�����z�ƶq</td>
  </tr>
  <tr>
    <td width="37%" class="tablebody">�̤j��</td>
	
    <td width="63%">
	<%
	if(myResultSet != null){
	while (myResultSet.next()){
		maxform = myResultSet.getInt("maxform");
	%>
	<input name="maxcount" type="text" value="<%=maxform%>" size="3" maxlength="3">
	<input name="maxcount" type="hidden" value="<%=maxform%>">
	<%
		}
	}
	
	%>
	</td>
  </tr>
  <tr>
    <td colspan="2"  class="tablebody"><input name="Submit" type="submit" class="btm" value="���"></td>
  </tr>
</table>

</form>
</body>
</html>
<%
}
catch (Exception e)
{
	  t = true;
}
finally
{
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
if(t)
{
%>
      <jsp:forward page="err.jsp" /> 
<%
}
}//end if
%>