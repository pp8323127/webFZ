<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="fz.*,java.sql.*,java.util.Date,java.text.DateFormat,ci.db.*"%>
<%
//設我為好友者
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
 %>
 <jsp:forward page="../sendredirect.jsp" /> 
<%
} 

String userid =(String) session.getAttribute("userid") ; 

Connection conn = null;
Driver dbDriver = null;

Statement stmt = null;
ResultSet myResultSet = null;
boolean t = false;
try
{

ConnDB cn = new ConnDB();
cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);


//dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
//conn = dbDriver.connect("jdbc:weblogic:pool:CAL.FZCP02", null);

stmt = conn.createStatement();

String bf_empno = null;
/*

select empno,name,ename,box,sess,cabin,occu,base,email
from fztcrew
where empno in (select bf_empno from fztfrid where empno='640073')
*/

//String sql = "select bf_empno from fztfrid where empno='"+sGetUsr +"' order by bf_empno";
String sql = "select empno,name,ename,box,sess,cabin,occu,base,email from fztcrew "
			+"where empno in (select empno from fztfrid where bf_empno='"+sGetUsr +"') order by empno";
//out.print(sql);
myResultSet = stmt.executeQuery(sql); 

String cname = null;
String ename = null;
String box = null;
String sess = null;
String cabin = null;
String occu = null;
String base = null;
String email = null;

//get Date
java.util.Date nowDate = new Date();
int syear	=	nowDate.getYear() + 1900;
int smonth	= 	nowDate.getMonth() + 1;
int sdate	= nowDate.getDate();
if (sdate >=25){	//超過25號，抓下個月的班表
	
	if (smonth == 12){	//超過12月25號，抓明年1月的班表
		smonth = 1;
		syear = syear+1;
	}
	else{
		smonth = smonth+1;
	}
}

%>

<html>
<head>
<title>設我為好友者</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="../menu.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style1 {color: #FFFFFF}
.dele {
	font-family: "細明體";
	font-size: 10pt;
	color: #FFFF00;
	background-color: #FF0000;
	border: #006666;
}
-->
</style>
<script language="javascript" type="text/javascript">
function viewCrewInfo(empno){

		document.formC.tf_empno.value = empno;	
		document.formC.submit();
	}
</script>
</head>

<body>
<form name="formC" method="post" action="crewInfo.jsp">
<input type="hidden" name="tf_empno" id="tf_empno" >
<input type="hidden" name="tf_sess1"  >
<input type="hidden" name="tf_sess2"  >
<input type="hidden" name="tf_ename"  >
</form>
<div align="center">&nbsp;&nbsp;&nbsp;<span class="style1"><span class="txtblue">You can query the crew by click Name column (點選姓名可查詢該組員資料)</span></span></div>
<form  method="post" name="form1" action="../mail_cs66.jsp" target="_self">
  <table width="92%"  border="1" align="center" cellpadding="0" cellspacing="1" class="fortable">
    <tr>
      <td colspan="12" class="tablehead3"><div align="center">設我為好友者（I am in his friend list） </div></td>
    </tr>
    <tr>
      <td width="13%" bgcolor="#999999"  class="tablebody style1">Empno</td>
      <td width="10%" bgcolor="#999999"  class="tablebody style1">Sern</td>
      <td width="13%" bgcolor="#999999"  class="tablebody style1">Name</td>
      <td width="23%" bgcolor="#999999"  class="tablebody style1">EName</td>
      <td width="11%" bgcolor="#999999"  class="tablebody style1">Email</td>
      <td width="12%" bgcolor="#999999"  class="tablebody style1">SendMail</td>
    </tr>
    <div align="center">
      <%
	  int xCount = 0;
	  
	if(myResultSet != null){
	while (myResultSet.next()){
		bf_empno 	= 	myResultSet.getString("empno");
		cname 		= 	myResultSet.getString("name");
		ename		=	myResultSet.getString("ename");
		box 		= 	myResultSet.getString("box");
		sess 		= 	myResultSet.getString("sess");
		cabin 		= 	myResultSet.getString("cabin");
		occu 		=	myResultSet.getString("occu");
		base 		= 	myResultSet.getString("base");
		email		= 	myResultSet.getString("email");
		xCount++;
	%>
      <tr>
        <td class="tablebody">
          <div align="center"><a href="javascript:viewCrewInfo('<%=bf_empno%>')" ><%=bf_empno%></a>
              <input name="friend" type="hidden" value="<%=bf_empno%>">
              <br>
          </div></td>
        <td class="tablebody"><div align="center"><%=box%>&nbsp;</div></td>
        <td class="tablebody"><div align="center"><%=cname%></div></td>
        <td class="tablebody"><div align="left">&nbsp;<%=ename%></div></td>
        <td class="tablebody"><div align="center"><a href="../mail.jsp?to=<%=email%>&cname=<%=ename%>" target="_blank"><img src="../images/mail.gif" alt="mail to <%=cname%>" border="0"></a></div></td>
        <td class="tablebody"><div align="center">
          <input type="checkbox" name="to" value="<%=bf_empno%>">
        </div></td>
      </tr>
      <%
		}
	}
	
	%>
    </div>
    <tr>
      <td colspan="12"  class="tablebody"><div align="center">&nbsp;&nbsp;              &nbsp;&nbsp;
              <input name="Submit3" type="submit" class="btm" value="SendMail" >&nbsp;&nbsp;&nbsp;
              <input type="button" name="close" value="Close window" onclick="window.close()">
      </div></td>
    </tr>
  </table>
</form>
<%
if(xCount ==0){
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
%>
		<jsp:forward page="../showmessage.jsp">
		<jsp:param name="messagestring" value="No Data!!<br>目前無人將你設為好友<BR><a href='javascript:window.close()'>Close Window</a>" />
		</jsp:forward>

<%
}
%>
<br>
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
      <jsp:forward page="../err.jsp" /> 
<%
}
%>