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

	sql = " select cr.sno, cr.empno, cr.reason, Decode(cr.reason,'1','�P�Ⱚ��','2','�B�~���Z��','3','���ɯ}��','4','�䥦���Z��','5','�䥦��Z��' ) reasondesc, cr.comments, To_Char(cr.edate,'yyyy/mm/dd') edate,  cr.intention, Decode(cr.intention,'1','�n�I��Z','2','�n�I���Z','3','���Կ�Z','4','�䥦��Z','') intentiondesc, cr.used_ind, cb.cname, cb.sern from egtcrdt cr, egtcbas cb where Trim(empn)=empno AND sno = "+sno;

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
	    <td align="center" class="tablehead"><strong>�m�W<br>���u��<br>(�Ǹ�)</strong></td>
	    <td align="center" class="tablehead"><strong>�n�I��]</strong></td>
	    <td align="center" class="tablehead"><strong>�n�I���Ĥ�</strong></td>
	    <td align="center" class="tablehead"><strong>�ϥΥت�</strong></td>
	    <td align="center" class="tablehead"><strong>�����P�_</strong></td>
		<td align="center" class="tablehead"><strong>����</strong></td>
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
				<option value="1">�P�Ⱚ��</option>
				<option value="2">�B�~���Z��</option>
				<option value="3">���ɯ}��</option>
				<option value="4">�䥦���Z��</option>
				<option value="5">�䥦��Z��</option>
			  </select></span>
	      </td>
			<td Align="Center" class="txtblue"><span class="style8">
			  <input name="edate" id="edate" type="text" size="10" maxlength="10" class="txtblue" value="<%=edate%>">&nbsp;&nbsp;<br>ex:2008/01/01</span>
	      </td>
			<td Align="Center" class="txtblue"><span class="style8">
			  <select name="intention" class="txtblue">
				<option value="<%=intention%>"><%=intentiondesc%></option>
				<option value="1">�n�I��Z</option>
				<option value="2">�n�I���Z</option>
				<option value="3">���Կ�Z</option>
				<option value="4">�䥦��Z</option>
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

