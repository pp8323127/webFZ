<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*" %>
<%
String userid = (String)session.getAttribute("userid");
if(userid == null){
	response.sendRedirect("/webfz/FZ/sendredirect.jsp");
}else{



String year = request.getParameter("year");
String month = request.getParameter("month");
String num = request.getParameter("num");


Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
String sql = null;
ci.db.ConnDB cn = new ci.db.ConnDB();
Driver dbDriver = null;

String formno = null;
String rCname = null;
String rEmpno = null;
String ed_check = null;
String comments = null;
String newdate= null;
String checkdate = null;
String chg_all = null;
String aEmpno	=null;
String aCname	= null;
int rowCount = 0;
try{
//User connection pool 

cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);


//直接連線 ORP3FZ
/*
cn.setORT1FZ();
java.lang.Class.forName(cn.getDriver());
conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),
	cn.getConnPW());
*/

stmt = conn.createStatement();

sql = "select formno,rcname,rempno, ed_check,"
	+"comments,to_char(checkdate,'yyyy/mm/dd hh24:mi') checkdate,"
	+"aempno,acname from fztformf where station='KHH' and  formno='"+year+month+"'||lpad('"+num+"',4,'04')";
rs = stmt.executeQuery(sql);
	while(rs.next()){
		formno= rs.getString("formno");
		rCname= rs.getString("rcname");
		rEmpno= rs.getString("rempno");
		ed_check= rs.getString("ed_check");
		comments= rs.getString("comments");
		checkdate= rs.getString("checkdate");
		aEmpno	= rs.getString("aempno");
		aCname	= rs.getString("acname");	
		rowCount++;
	}

}catch (SQLException e){
	  out.print(e.toString());
}catch (Exception e){
	  out.print(e.toString());
}finally{

	if (rs != null) try {rs.close();} catch (SQLException e) {}	
	if (stmt != null) try {stmt.close();} catch (SQLException e) {}
	if (conn != null) try { conn.close(); } catch (SQLException e) {}
}

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>申請單列表</title>
<link href="../realSwap/realSwap.css" rel="stylesheet" type="text/css">
<link href="../style/kbd.css" rel="stylesheet" type="text/css">
<link href="../style/errStyle.css" rel="stylesheet" type="text/css">
</head>

<body>
<%
if(rowCount == 0){
%>
<div class="errStyle1">查無符合條件之資料</div>
<%
}else{


%>
<span class="r">Step 2.確認是否更新該申請單</span>
<form name="form1" action="chgSwapFrom.jsp" method="post" onsubmit="document.form1.sb.disabled=1;">
  <table width="100%" cellspacing="1" cellpadding="1" class="tableBorder1" >
      <tr class="tableh5" >
        <td width="98" >Update </td> 
        <td width="86" >No</td>
        <td width="84" >Applicant</td>
        <td width="92" >Aname</td>
        <td width="88" >Replacer</td>
        <td width="71" >Rname</td>
        <td width="79" >ED_check</td>
        <td width="120" >Check Date</td>
        <td width="143" >ED Comments </td>
        <td width="50" >Detail</td>
    </tr>

      <tr >
        <td ><input type="submit" class="kbd" value="更新申請單" name="sb" id="sb">
        </td> 
        <td ><%= formno%></td>
        <td ><%= aEmpno%></td>
        <td ><%= aCname %></td>
        <td ><%=rEmpno%></td>
        <td ><%=rCname%></td>
        <td ><%=ed_check%></td>
        <td ><%=checkdate%></td>
        <td ><div align="left"><%=comments%></div></td>
        <td><a href="../showForm.jsp?formno=<%=formno%>" target="_blank"> 
         <img src="img/view.gif" width="16" height="16" border="0" align="View Detail"></a></td>
      </tr>

  </table><input type="hidden" name="formno" value="<%=formno%>">
	<input type="hidden" name="aEmpno" value="<%=aEmpno%>">
	<input type="hidden" name="aCname" value="<%=aCname%>">
	<input type="hidden" name="rEmpno" value="<%=rEmpno%>">
	<input type="hidden" name="rCname" value="<%=rCname%>">			
	<input type="hidden" name="ed_check" value="<%=ed_check%>">			
</form>
<%

}
%>
</body>
</html>
<%
}
%>