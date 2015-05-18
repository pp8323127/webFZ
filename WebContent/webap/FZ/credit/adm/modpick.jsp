<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*,java.util.*, credit.*" %>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) 
{		
	response.sendRedirect("../../tsa/sendredirect.jsp");
} 

String returnstr = "Y";
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
String sql = null;
String bgColor=null;
String sno = request.getParameter("sno");
String empno = "";
String cname = "";
String sern = "";
String reason = "";
String reasondesc = "";
String comments = "";
String new_tmst = "";
String formno = "";
int count =0;
String rank = "";
try
{
	ConnectionHelper ch = new ConnectionHelper();
	conn = ch.getConnection();	
	stmt = conn.createStatement();

	sql = " select pi.sno, pi.empno, pi.reason, Decode(pi.reason,'1','全勤選班','2','積點選班','3','其它選班' ) reasondesc, replace(pi.comments,'<br>','') comments, cb.cname, cb.sern, to_char(new_tmst,'yyyy/mm/dd hh24:mi:ss') new_tmst from egtpick pi, egtcbas cb where Trim(empn)=empno AND sno = "+sno;

	rs = stmt.executeQuery(sql);
	while(rs.next())
	{
		empno = rs.getString("empno");
		GetRank ca = new GetRank(empno);
		rank = ca.getRank(empno);
		cname = rs.getString("cname");
		sern = rs.getString("sern");
		reason = rs.getString("reason");
		reasondesc = rs.getString("reasondesc");
		comments = rs.getString("comments");
		new_tmst = rs.getString("new_tmst");

		count ++;
	}
}
catch(Exception e)
{
	out.print(e.toString());
}
finally
{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Handle pick skj request</title>
<link href="../menu.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="../calendar2.js"></script>
<style type="text/css">
<!--
.style2 {
	font-family: "Courier New", Courier, mono;
	font-size: 12pt;
}
.style8 {color: #000000}
.style10 {font-size: 14px; color: #000000; font-weight: bold; }
-->
</style>
<script language="javascript" type="text/javascript">
function chkInpt()
{
	//var v1 = document.form1.itemno.value;
	//var v2 = document.form1.item.value;

}	
</script>
</head>

<body>
<div align="center">
<form name="form1" method="post" action="modpick2.jsp">
<input name="sno" id="sno" type="hidden" value="<%=sno%>">
<input name="empno" id="empno" type="hidden" value="<%=empno%>">
  <table width="90%" border="0" align="center" class="tablebody2">
    <tr bgcolor="#9CCFFF"  class="txtblue">
	    <td align="center" class="tablehead"><strong>員工號<br>(序號)</strong></td>
	    <td align="center" class="tablehead"><strong>姓名</strong></td>
	    <td align="center" class="tablehead"><strong>RANK</strong></td>
	    <td align="center" class="tablehead"><strong>申請日</strong></td>
		<td align="center" class="tablehead"><strong>備註</td>
		<td width="5%" align="center" class="tablehead"><a href="javascript:window.print()"><img src="../../images/print.gif" width="17" height="15" border="0" alt="列印"></a></strong></td>
    </tr>
    <%
	if(count > 0)
	{
%>
		<tr valign="top" bgcolor="#FFFFFF" class="txtblue">
			<td Align="left" class="txtblue">
				  <div align="center" class="style8">&nbsp;<%=empno%><br>(<%=sern%>)</div>
		    </td>
			<td Align="left" class="txtblue">
				  <div align="center" class="style8">&nbsp;<%=cname%></div>
		    </td>
			<td Align="left" class="txtblue">
				  <div align="center" class="style8">&nbsp;<%=rank%></div>
			</td>
			<td Align="Center" class="txtblue"><span class="style8"
			   class="txtblue"><%=new_tmst%></span>
	      </td>
		  <td align="center" class="txtblue" colspan = "2"><textarea name="comments" cols="30" rows="5" class="txtblue"><%=comments%></textarea></td>
		</tr>
<%
	}
	else
	{
%>
		<tr bgcolor="#FFFFFF">
			<td class="txtblue" colspan="6">No Data</td>
		</tr>
<%		
	}
%>
</table>
<table>
  <tr>
    <td class="txtblue">
      <div align="center">
        <input name="Submit" type="submit" class="button1 txtblue" id="Submit" value="處理完成">
	  </div>
    </td>
    </tr>
</table>
<table width="90%" border="0" align="center" class="tablebody2">
  <tr>
      <td class="txtblue" align ="right">&nbsp;</td>
      <td class="txtblue" align ="right">&nbsp;</td>
      <td class="txtblue" align ="right">&nbsp;</td>
      <td class="txtblue" align ="right">&nbsp;</td>
      <td class="txtblue" align ="right">組員簽名 : ____________</td>
  </tr>
</table>

</form>
</div>
</body>
</html>

