<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="java.sql.*,ci.db.*"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
 %>
 <jsp:forward page="sendredirect.jsp" /> 
<%
} 

String userid =(String) session.getAttribute("userid") ; 

Connection conn = null;
Driver dbDriver = null;

Statement stmt = null;
ResultSet myResultSet = null;
String rptloc = "TSA";
String sdate = null;
String theday = null;
try
{
	 ConnDB cn = new ConnDB();
	 cn.setORP3EGUserCP();
	 dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	 conn = dbDriver.connect(cn.getConnURL(), null);
	 stmt = conn.createStatement();
	
	String sql = "select rptloc, to_char(sdate, 'yyyy/mm/dd') from egtchkin where empno = '"+userid+
	"' and sdate <= to_date(sysdate) and edate >= to_date(sysdate)";
	myResultSet = stmt.executeQuery(sql); 
	if(myResultSet != null){
		while (myResultSet.next()){
		rptloc = myResultSet.getString(1);
		sdate = myResultSet.getString(2);
		}
	}
	myResultSet.close();
	myResultSet = stmt.executeQuery("select to_char(sysdate + 2, 'yyyy-mm-dd') from dual");
	if (myResultSet.next()) theday = myResultSet.getString(1);
}
catch (Exception e)
{
	  out.println("Error : " + e.toString());
}
finally
{
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Crew Report Location</title>
<link href="menu.css" rel="stylesheet" type="text/css">
<script src="js/subWindow.js"></script>
<script language="JavaScript">
function getCalendar(obj){    
	eval("wincal=window.open('Calendar.htm','" + obj +"','width=350,height=200')");
}
</script>
</head>

<body>
<form  method="post" name="form1" action="upd_checkin.jsp">
  <table width="48%"  border="1" align="center" cellpadding="0" cellspacing="1" class="fortable">
    <tr>
      <td height="28" bgcolor="#CCCCCC"  class="tablebody"><div align="center">
	  目前你的報到地點：<span class="txtxred"><strong><%=rptloc%><%=sdate%>
        <input name="rptloc" type="hidden" id="rptloc" value="<%=rptloc%>">
		<input name="sdate" type="hidden" id="sdate" value="<%=sdate%>"></strong></span>
		<a href="#" onClick="subwinXY('../EG/rpt/checkin.jsp?empno=<%=sGetUsr%>','','600','300')">詳細資料</a></div></td>
    </tr>
    <div align="center">
      <tr>
        <td>
          <div align="center" class="txttitle"><strong>
      <input name="setloc" type="radio" value="TSA">
      TSA/松山
      <input type="radio" name="setloc" value="TAO">
      TAO/桃園</strong><br>
	  生效日
	  <span onclick="getCalendar('applydate')" style="cursor:pointer">
	  <input name="applydate" type="text" class="text"  style="cursor:pointer" onFocus="this.blur()" value="<%=theday%>" size="15" maxlength="10">
	  <img src="images/p2.gif" width="22" height="22"> </span>
          </div></td>
      </tr>
    </div>

   <tr>
      <td colspan="2" class="tablebody"><div align="center" class="txtxred">
	  台北原有接車者得另行取消接車申請</div></td>
    </tr>

    <tr>
      <td colspan="2"  class="tablebody">
        <input name="Submit" type="submit" class="btm" value="確認更改"></td>
    </tr>
  </table>
</form>
<table width="48%"  border="0" align="center" cellpadding="0" cellspacing="1" >
    <div align="center">

    </div>
    <tr>
      <td colspan="2" class="tablebody"><div align="left" class="txtxred">
	  1. 修改報到地點生效日期不得少於兩個工作天<br>
	  2. 一個月只允許修改一次</div></td>
    </tr>
</table>
</body>
</html>