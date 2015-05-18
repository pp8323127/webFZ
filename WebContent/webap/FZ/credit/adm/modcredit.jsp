<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*,java.util.*" %>
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
String edate = "";
String intention = "";
String intentiondesc = "";
String used_ind = "";
String formno = "";
int count =0;

try
{
	ConnectionHelper ch = new ConnectionHelper();
	conn = ch.getConnection();	
	stmt = conn.createStatement();

	sql = " select cr.sno, cr.empno, cr.reason, Decode(cr.reason,'1','銷售高手','2','額外換班單','3','飛時破百','4','其它換班單','5','其它選班單' ) reasondesc, cr.comments, To_Char(cr.edate,'yyyy/mm/dd') edate,  cr.intention, Decode(cr.intention,'1','積點選班','2','積點換班','3','全勤選班','4','其它選班','') intentiondesc, cr.used_ind, cb.cname, cb.sern from egtcrdt cr, egtcbas cb where Trim(empn)=empno AND sno = "+sno;

	rs = stmt.executeQuery(sql);
	while(rs.next())
	{
		empno = rs.getString("empno");
		cname = rs.getString("cname");
		sern = rs.getString("sern");
		reason = rs.getString("reason");
		reasondesc = rs.getString("reasondesc");
		comments = rs.getString("comments");
		edate = rs.getString("edate");
		intention = rs.getString("intention");
		intentiondesc = rs.getString("intentiondesc");
		used_ind = rs.getString("used_ind");
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
<title>Modify credit</title>
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
<form name="form1" method="post" action="modcredit2.jsp">
<input name="sno" id="sno" type="hidden" value="<%=sno%>">
<input name="empno" id="empno" type="hidden" value="<%=empno%>">
  <table width="90%" border="0" align="center" class="tablebody2">
    <tr bgcolor="#9CCFFF"  class="txtblue">
	    <td align="center" class="tablehead"><strong>姓名<br>員工號<br>(序號)</strong></td>
	    <td align="center" class="tablehead"><strong>積點原因</strong></td>
	    <td align="center" class="tablehead"><strong>積點有效日</strong></td>
	    <td align="center" class="tablehead"><strong>使用目的</strong></td>
	    <td align="center" class="tablehead"><strong>扣除與否</strong></td>
		<td align="center" class="tablehead"><strong>註解</strong></td>
    </tr>
    <%
	if(count > 0)
	{
%>
		<tr valign="top" bgcolor="#FFFFFF" class="txtblue">
			<td Align="left" class="txtblue">
				  <div align="center" class="style8">&nbsp;<%=cname%><br><%=empno%><br>(<%=sern%>)</div>
		  </td>
			<td Align="Center" class="txtblue"><span class="style8">
			  <select name="reason" class="txtblue">
				<option value="<%=reason%>"><%=reasondesc%></option>
				<option value="1">銷售高手</option>
				<option value="2">額外換班單</option>
				<option value="3">飛時破百</option>
				<option value="4">其它換班單</option>
				<option value="5">其它選班單</option>
			  </select></span>
	      </td>
			<td Align="Center" class="txtblue"><span class="style8">
			  <input name="edate" id="edate" type="text" size="10" maxlength="10" class="txtblue" value="<%=edate%>">&nbsp;&nbsp;<br>ex:2008/01/01</span>
	      </td>
			<td Align="Center" class="txtblue"><span class="style8">
			  <select name="intention" class="txtblue">
				<option value="<%=intention%>"><%=intentiondesc%></option>
				<option value="1">積點選班</option>
				<option value="2">積點換班</option>
				<option value="3">全勤選班</option>
				<option value="4">其它選班</option>
			  </select></span>
	      </td>
			<td Align="Center" class="txtblue"><span class="style8">
			  <!--<input name="used_ind" id="used_ind" type="hidden" value="<%=used_ind%>"><%=used_ind%>-->
			  <select name="used_ind" class="txtblue">
				<option value="<%=used_ind%>"><%=used_ind%></option>
				<option value="Y">Y</option>
				<option value="N">N</option>
			  </select>
			  </span>
	      </td>
		  <td align="center" class="txtblue"><textarea name="comments" cols="20" rows="5" class="txtblue"><%=comments%></textarea></td>
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
        <input name="Submit" type="submit" class="button1 txtblue" id="Submit" value="Modify">
		&nbsp;&nbsp;&nbsp;
		<input name="reset" type="reset" class="button1 txtblue" value="Reset">
	  </div>
    </td>
    </tr>
</table>
</form>


</div>
</body>
</html>

