<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="fz.*,java.sql.*,ci.db.*"%>
<%
//ED審核意見
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
//20130326增加**
String occu = (String) session.getAttribute("occu");
String powerUser =(String)session.getAttribute("powerUser");
//**************
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
 %>
 <jsp:forward page="sendredirect.jsp" /> 
<%
} else if(!("ED".equals(occu) | "Y".equals(powerUser))){//本組及簽派可看此頁20130326增加
%>
	<p  class="errStyle1">1.您無權使用此功能！<br> 2.閒置過久請重新登入！</p>
<%
	
}
else{

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

String comm = null;

String sql = "select citem from fztcomm where station='TPE' order by citem";
myResultSet = stmt.executeQuery(sql); 

%>

<html>
<head>
<title>自訂審核Comment</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="menu.css" rel="stylesheet" type="text/css">
</head>

<body>
<form  method="post" name="form1" action="delcomm.jsp">
  <table width="45%"  border="1" align="center" cellpadding="0" cellspacing="1" class="fortable">
    <tr>
      <td colspan="3" class="tablehead3"><div align="center">目前審核意見</div></td>
    </tr>
 <tr>
      <td width="62%" bgcolor="#CCCCCC"  class="tablebody">意見</td>
	   <td width="38%" bgcolor="#CCCCCC"  class="tablebody">刪除</td>
    </tr>

        <div align="center">
          <%
	if(myResultSet != null){
	while (myResultSet.next()){
		comm = myResultSet.getString("citem");
	%>
 <tr>
   <td class="tablebody">
     <div align="left"><%=comm%>
         <input name="tcomm" type="hidden" value="<%=comm%>">
         <br>
   </div></td>
   <td class="tablebody"><input name="checkdel" type="checkbox" id="checkdel" value="<%=comm%>"></td>
      </tr>	  
          <%
		}
	}
	
	%>  
        </div>
   
    <tr>
      <td colspan="3"  class="tablebody"><div align="center">&nbsp;&nbsp;
          <input name="Submit2" type="submit" class="btm" value="確認刪除">
</div></td>
    </tr>
  </table>
</form>
<br>
<form action="updcomm.jsp"  method="post" name="form2" id="form2">
  <table width="45%"  border="1" align="center" cellpadding="0" cellspacing="1" class="fortable">
    <tr>
      <td colspan="2" class="tablehead3"><div align="center">新增審核意見</div></td>
    </tr>

        <div align="center">

 <tr>
   <td class="tablebody">     <div align="left">
         <input name="addcomm" type="text" size="50" maxlength="40">
</div></td>
   </tr>	  
        </div>
   
    <tr>
      <td colspan="2"  class="tablebody"><div align="center">        &nbsp;&nbsp;
        <input name="Submit" type="submit" class="btm" value="確認新增">
      </div></td>
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
