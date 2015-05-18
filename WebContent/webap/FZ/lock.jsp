<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="fz.*,java.sql.*,ci.db.*"%>
<%
//ED審核意見
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
boolean t = false;
try{

//dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
//conn = dbDriver.connect("jdbc:weblogic:pool:CAL.FZCP02", null);
ConnDB cn = new ConnDB();
cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement();
String lockstatus = null;

String sql = "select locked from fztcrew where empno = '"+userid+"'";
myResultSet = stmt.executeQuery(sql); 

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Lock or Open Schedule for query</title>
<link href="menu.css" rel="stylesheet" type="text/css">
</head>

<body>
<form  method="post" name="form1" action="upd_lock.jsp">
  <table width="48%"  border="1" align="center" cellpadding="0" cellspacing="1" class="fortable">
    <tr>
      <td height="28" bgcolor="#CCCCCC"  class="tablebody"><div align="center">目前你的班表狀態(Status)：   
          <%
	if(myResultSet != null){
		while (myResultSet.next()){
		lockstatus = myResultSet.getString("locked");
			if ("Y".equals(lockstatus)){
				out.println("<font color=\"red\">鎖定不讓他人查詢(Locked)</font>");
			}
			else{
				out.println("<font color=\"blue\">開放他人查詢(Open)</font>");
			}

		}
	}
	
	%>
	  </div></td>
    </tr>
    <div align="center">

      <tr>
        <td class="tablebody">
          <div align="left">       
            <input type="radio" name="setlock" value="N">
    開放班表(Open schedule for query)<br>
    <label>
    <input type="radio" name="setlock" value="Y">
    鎖住班表(Lock schedule)</label>
    <br>
          </div>          </td>
      </tr>

    </div>
    <tr>
      <td height="21" colspan="2"   class="tablebody"><div align="left">&nbsp;&nbsp;更改狀態後，系統會自動登出，請重新登入<br>
  &nbsp;System will  logout automatically after you hange
  the status.Please login
  again.</div></td>
    </tr>
    <tr>
      <td colspan="2"  class="tablebody">
        <input name="Submit2" type="submit" class="btm" value="確認更改"></td>
    </tr>
  </table>
</form>
<table width="48%"  border="0" align="center" cellpadding="0" cellspacing="1" >
    <div align="center">

    </div>
    <tr>
      <td height="21" colspan="2"  class="tablebody"><div align="left" class="txtxred">基於資訊交流公平性原則，選擇鎖住班表者，僅能查詢個人月班表，<br>
        無法使用換班及查詢他人班表等功能。<br>
        If
          you lock your schedule, you can only query your schedule. 
        You cannot apply to transfer schedule or query other people's schedule.</div></td>
    </tr>
</table>
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
%>