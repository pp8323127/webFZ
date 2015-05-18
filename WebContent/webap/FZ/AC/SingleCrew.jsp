<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*,java.net.URLEncoder"  %>
<%
String userid = (String)session.getAttribute("userid");


if(session.isNew() | null == session.getAttribute("userid")){
	response.sendRedirect("../sendredirect.jsp");
}else if("".equals(request.getParameter("empno")) | null == request.getParameter("empno")){
	out.print("NO DATA!!");
}else{




String empno = request.getParameter("empno");

String sern = null;
String cname	= 	null;
String occu		= 	null;
String base		=	null;
String sess		=	null;//期別
String ename	=	null;
String fleet	=	null;
String mphone	=	null;
String hphone	=	null;
String icq		=	null;
String email	=	null;
String lockStatus = null;

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
ConnDB cn = new ConnDB();
Driver dbDriver = null;
boolean status = false;
int rowCount = 0;
String errMsg = "";
try {
	cn.setORP3FZUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);

	pstmt = conn.prepareStatement("SELECT EMPNO,BOX,SESS,NAME,ENAME,CABIN,OCCU,NVL(FLEET,'&nbsp;') FLEET,"
		+"BASE,EMAIL,NVL(MPHONE,'&nbsp;') MPHONE,NVL(HPHONE,'&nbsp;') HPHONE,NVL(ICQ,'&nbsp;') ICQ ,locked FROM FZTCREW where empno=?");
	pstmt.setString(1,empno);

	rs = pstmt.executeQuery();
	while (rs.next()) {
		sern		=	rs	.getString("BOX");
		sess	=	rs	.getString("SESS");
		ename	=	rs	.getString("ENAME");
		fleet	=	rs	.getString("FLEET");
		mphone	=	rs	.getString("MPHONE");
		hphone	=	rs	.getString("HPHONE");
		icq		=	rs	.getString("ICQ");	
		cname	= 	rs.getString("NAME");
		occu	=	rs.getString("OCCU");	
		base	=	rs.getString("BASE");
		email	= 	rs.getString("EMAIL");
		lockStatus = rs.getString("locked");
		rowCount++;
	}

	status = true;

} catch (SQLException e) {
	//System.out.print(e.toString());
	errMsg = e.toString();
} catch (Exception e) {
	//System.out.print(e.toString());
	errMsg = e.toString();
} finally {

	if ( rs != null ) try {
		rs.close();
	} catch (SQLException e) {}
	if ( pstmt != null ) try {
		pstmt.close();
	} catch (SQLException e) {}
	if ( conn != null ) try {
		conn.close();
	} catch (SQLException e) {}

}



%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" type="text/css" href="../errStyle.css">
<link rel="stylesheet" type="text/css" href="../style2.css">

<title>組員資料</title>
</head>

<body>
<%
if(status &&"Y".equals(lockStatus)){
%>
  
  </div>
    <div class="errStyle1">The Crew didn't open his schedule<BR>該組員未開放班表供他人查詢</div>
<%
}else if(!status){
%>
<div class="errStyle1"><%=errMsg%></div>
<%
}else if( "N".equals(lockStatus)){
%>

<table width="88%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr> 
      <td width="5%">&nbsp;</td>
      <td width="90%">Crew Detail  
       
      </td>
      <td width="5%">
        <div align="right"><a href="javascript:window.print()"> <img src="../images/print.gif" width="17" height="15" border="0" alt="列印"></a> 
        </div>
      </td>
    </tr>
</table>
    <table align="center" cellpadding="1"  cellspacing="1" border="1"  width="88%">
      <tr class="sel3" >
	<td width="79" >EmpNO</td>
        <td width="85" >Name</td>
        <td width="91" >EName</td>
        <td width="50" >Sern</td>
        <td width="40" >Sess</td>
        <td width="34" >Occu</td>
        <td width="39" >Fleet</td>
        <td width="46" >Base</td>
        <td width="150" >EMAIL</td>
        <td width="75" >Mobile</td>
        <td width="76" >Home</td>
        <td width="28" >ICQ</td>
      </tr>

      <tr >
	    <td height="26" ><%=empno %></td>
        <td ><p style="white-space:nowrap "><%= cname%></p></td>
        <td ><p align="left" style="white-space:nowrap ">&nbsp;<%= ename%></p></td>
        <td ><%=sern %></td>
        <td ><%=sess %></td>
        <td ><%=occu%></td>
        <td ><%=fleet %></td>
        <td ><%=base %></td>
        <td ><a href="../mail.jsp?to=<%=email%>&cname=<%=URLEncoder.encode(cname)%> <%=ename%>" target="_blank"><img alt="mail to <%=cname%>" border="0" height="15" src="../images/mail.gif" width="15"></a></td>
        <td ><%=mphone %></td>
        <td ><%=hphone %></td>
        <td ><%=icq %></td>
      </tr>
</table><br>

    <div align="center">
  <input type="button" class="e" onClick="javascript:self.close();" value="CLOSE">
  

  <%
}

%>
</body>
</html>
<%
}
%>