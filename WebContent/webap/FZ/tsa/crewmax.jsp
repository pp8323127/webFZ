<%@page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.ConnDB"%>
<html>
<head>
<title>Crew ReqFlt AL Max Edit</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="../menu.css" rel="stylesheet" type="text/css">
</head>
<%
String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);

if (session.isNew() || sGetUsr == null) 
{		//check user session start first
	response.sendRedirect("sendredirect.jsp");
} 

String empno1 = request.getParameter("empno1").trim();
String fleet = request.getParameter("fleet");
String job = request.getParameter("job");
//判斷資料是否update success
String t = request.getParameter("t");
if(t != null){
%>
	<script>
		alert("Update Success !");
	</script>
<%
}

Connection conn = null;
Statement stmt = null;
ResultSet myResultSet = null;
String sql = null;
String empno = null;
String cmax = null;
String cname = null;
String ename = null;
String fj = null;

try{
	ConnDB cn = new ConnDB();
	cn.setORP3FZAP();
	Class.forName(cn.getDriver());
	conn = DriverManager.getConnection(cn.getConnURL(),cn.getConnID(),cn.getConnPW());
	stmt = conn.createStatement();

	if(empno1.equals("")){
		sql = "select distinct empno, ac_type, job_type, reqfltalmax, c_name, l_name||' '||f_name ename from fztckpl where ac_type='"+fleet+"' " +
		"and job_type='"+job+"' and valid=0 order by empno";
	}
	else{
		sql = "select distinct empno, ac_type, job_type, reqfltalmax, c_name, l_name||' '||f_name ename from fztckpl where empno='"+empno1+"' " +
		"order by empno";
	}
	myResultSet = stmt.executeQuery(sql); 

%>

<body>
<form  method="post" name="form1" action="updcrewmax.jsp">
  <table width="45%"  border="1" align="center" cellpadding="0" cellspacing="1" class="fortable">
    <tr>
      <td colspan="4" class="tablehead3"><div align="center">Crew ReqFlt + AL max</div></td>
    </tr>
 <tr>
      <td bgcolor="#CCCCCC"  class="tablebody">EmpNo</td>
	  <td bgcolor="#CCCCCC"  class="tablebody">Name</td>
	  <td bgcolor="#CCCCCC"  class="tablebody">Fleet/Job</td>
	  <td bgcolor="#CCCCCC"  class="tablebody">Max</td>
 </tr>

<div align="center">
<%
	if(myResultSet != null){
		while (myResultSet.next()){
			empno = myResultSet.getString("empno");
			cmax = myResultSet.getString("reqfltalmax");
			cname = myResultSet.getString("c_name");
			ename = myResultSet.getString("ename");
			fj = myResultSet.getString("ac_type")+"/"+myResultSet.getString("job_type");
%>
 <tr>
   <td class="tablebody"><%=empno%>
     <input name="empno" type="hidden" id="empno" value="<%=empno%>"></td>
   <td class="tablebody"><div align="left"><%=cname%>/<%=ename%></div></td>
   <td class="tablebody"><%=fj%></td>
   <td class="tablebody"><input name="cmax" type="text" id="cmax" value="<%=cmax%>" size="5" maxlength="1"></td>
 </tr>	  
<%
		}
	}
	
%>  
</div>
   
    <tr>
      <td colspan="4"  class="tablebody"><div align="center">&nbsp;&nbsp;
		    <input name="Submit" type="submit" class="btm" value="Save">
		    <input name="empno1" type="hidden" value="<%=empno1%>">
		    <input name="fleet" type="hidden" value="<%=fleet%>">
		    <input name="job" type="hidden" value="<%=job%>">
          <div class="txtxred">*同一組員如有多機隊時請修改最後一筆資料，其餘Record將會同時更新。</div>
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
	  out.println(e.toString());
}
finally
{
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>