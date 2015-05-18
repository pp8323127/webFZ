<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="fz.*,java.sql.*,ci.db.*,java.util.*,ci.db.*"%>
<%
//自訂最愛航班
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (sGetUsr == null) {		
	response.sendRedirect("sendredirect.jsp");
} 

Connection conn = null;
Driver dbDriver = null;

Statement stmt = null;
ResultSet myResultSet = null;
boolean t = false;
int count = 0;
String fltno = null;
ArrayList fltnoAL = new ArrayList();

try{

//dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
//conn = dbDriver.connect("jdbc:weblogic:pool:CAL.FZCP02", null);

ConnDB cn = new ConnDB();
cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement();


String sql = "select fltno from fztfavr where empno = '" +sGetUsr +"' order by fltno";
myResultSet = stmt.executeQuery(sql); 
while(myResultSet.next()){
		fltnoAL.add(myResultSet.getString("fltno"));
		count++;
		
}
myResultSet.close();


%>

<html>
<head>
<title>自訂最愛航班</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="menu.css" rel="stylesheet" type="text/css">
<script src="js/checkBlank.js"></script>
<script src="js/checkDel.js"></script>
</head>

<body onload="document.form2.addfavor.focus();">
<%
if(count != 0){
%>
<form  method="post" name="form1" action="delfavor.jsp" onSubmit="return checkDel('form1')">
  <table width="48%"  border="1" align="center" cellpadding="0" cellspacing="1" class="fortable">
    <tr >
      <td colspan="3" class="tablehead3">我最愛的班Favorite Flight
      </td>
    </tr>
 <tr>
      <td width="68%" bgcolor="#CCCCCC"  class="tablebody">Fltno</td>
	   <td width="32%" bgcolor="#CCCCCC"  class="tablebody">刪除(Delete)</td>
    </tr>

        <div align="center">
          <%
		for(int i=0;i< fltnoAL.size();i++){
	%>
 <tr>
   <td class="tablebody">
     <div align="left"><%=(String)fltnoAL.get(i)%>
         <input name="tcomm" type="hidden" value="<%=(String)fltnoAL.get(i)%>">
         <br>
   </div></td>
   <td class="tablebody"><input name="checkdel" type="checkbox" id="checkdel" value="<%=(String)fltnoAL.get(i)%>"></td>
      </tr>	  
        <%
		}

	%>  
        </div>
   
    <tr>
      <td colspan="3"  class="tablebody"><div align="center">&nbsp;&nbsp;
          <input name="Submit2" type="submit" class="btm" value="Delete">
</div></td>
    </tr>
  </table>
</form>
<%
}else{
	out.print("<p class=\"txtblue\" align=\"center\">目前並無設定最愛航班!!</p><hr width=\"45%\" align=\"center\">");
}
%>
<br>

<form action="updfavor.jsp"  method="post" name="form2" id="form2" onSubmit="return checkBlank('form2','addfavor','Flight number is requeired!!\n請輸入航班!!')">
  <table width="45%"  border="1" align="center" cellpadding="0" cellspacing="1" class="fortable">
    <tr>
      <td colspan="2" class="tablehead3">
        新增我最愛的班Add Favorite
      Flight
      </td>
    </tr>

        <div align="center">

 <tr>
   <td class="tablebody">     <div align="left">
         <input name="addfavor" type="text" size="50" maxlength="50">
</div></td>
   </tr>	  
        </div>
   
    <tr>
      <td colspan="2"  class="tablebody"><div align="center">        &nbsp;&nbsp;
        <input name="Submit" type="submit" class="btm" value=" Add ">
      </div></td>
    </tr>
  </table>
</form>
<div align="center">
 <br>
    <span class="txtblue">Tips:丟出班表後，可在我的丟班資訊中，點選Fltno查詢喜好此航班者。</span>
  <span class="txtblue"><br>
  <font color="#FF0000">Fltno請輸滿三位 Ext:006</font><br>
    You can query who like the flights you put in Transfer Record by clicking 
    fltno. </span> 
</div>
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