<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="java.sql.*,java.sql.Date,fz.*"%>
<%

String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login
/*response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);*/

if (session.isNew() | sGetUsr == null) 
{		
  response.sendRedirect("sendredirect.jsp");
} 


String fleet = request.getParameter("fleet");
String duty =  request.getParameter("duty");
String empno = request.getParameter("empno");

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
String sql = null;
ci.db.ConnDB cn = new ci.db.ConnDB();

 Driver dbDriver = null;
ArrayList empnoAL = new ArrayList();
ArrayList cnameAL = new ArrayList();
ArrayList enameAL = new ArrayList();
 

try {

cn.setDFUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);


if("".equals(request.getParameter("empno")) | null == request.getParameter("empno")){
	sql = "SELECT empno,NAME cname,ename  FROM dftcrew  WHERE fleet=?  and occu=? and flag='Y'  ORDER BY empno";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1,fleet);
	pstmt.setString(2,duty);
	

}else{
	sql = "select empno,NAME cname,ename from dftcrew WHERE empno=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,empno);

}
	
	rs = pstmt.executeQuery();
	while (rs.next()) {
		empnoAL.add(rs.getString("empno"));
		cnameAL.add(rs.getString("cname"));
		enameAL.add(rs.getString("ename"));
	}
	

} catch (SQLException e) {
	System.out.print(e.toString());
} catch (Exception e) {
	System.out.print(e.toString());
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
<html>
<head>
<title>Crew List</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<meta http-equiv="pragma" content="no-cache">
<link href="../menu.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
if(empnoAL.size() == 0){

%>
<div align="center"><span class="txtxred">查無資料<br>
  No Record!! <br>
  </span><span class="txtblue">註：以Fleet及Duty查詢時，僅顯示在職者之資料</span></div>
<% 

}else{

 %>


<div align="center"> 
  <table width="100%" border="0">
    <tr> 
	
      <td width="35%" class="txtblue">
		 Fleet:<%= fleet%> / Duty:<%=duty %>
	 </td>
   
      <td width="65%"> 
        <div align="right"></div>
      </td>
    </tr>
    <tr>
      <td colspan="2" class="txtblue"><div align="center">Click EmpNo to see Crew Record <br>
        點選員工號以檢視Crew Record 
      </div></td>
    </tr>
  </table>
  <form name="form1" method="post" action="">
    <table width="100%" border="0" bordercolor="#666666" class="fortable">
      
      <tr> 

        <td width="25%" > 
        <div align="center" class="tablehead3"><b><font size="2"><font face="Arial, Helvetica, sans-serif">EmpNo</font></font></b></div></td>
        <td width="25%" > 
        <div align="center" class="tablehead3"><b><font size="2"><font face="Arial, Helvetica, sans-serif">Name</font></font></b></div></td>
        <td width="50%" > 
        <div align="center" class="tablehead3"><b><font size="2"><font face="Arial, Helvetica, sans-serif">Ename</font></font></b></div></td>
      </tr>
      <%
	  	for(int i=0;i<empnoAL.size();i++){ 
	  %>
      <tr>

        <td class="tablebody">&nbsp;<a href="crewrecord_detail.jsp?empno=<%=empnoAL.get(i)%>"><%=empnoAL.get(i)%></a></td>
        <td class="tablebody"><div align="left">&nbsp;<%=cnameAL.get(i)%></div></td>
        <td class="tablebody"><div align="left">&nbsp;<%=enameAL.get(i)%></div></td>
      </tr>
	  <%
	  }
	  %>
    </table>
  
  </form>
</div>
<% } %>

</body>
</html>