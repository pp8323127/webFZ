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
String new_tmst = "";
String valid_ind = "";
String sdate = "";
String edate = "";
String ed_user = "";
String ed_tmst = "";
String ef_user = "";
String ef_tmst = "";
String credit3 = "";
int count =0;

try
{
	ConnectionHelper ch = new ConnectionHelper();
	conn = ch.getConnection();	
	stmt = conn.createStatement();

	sql = "  select pi.sno sno, pi.empno empno, pi.reason reason, Decode(pi.reason,'1','全勤選班','2','積點選班','3','其它選班' ) reasondesc, pi.comments comments, cb.cname cname, cb.sern sern, to_char(new_tmst,'yyyy/mm/dd hh24:mi:ss') new_tmst, pi.valid_ind valid_ind,  to_char(sdate,'yyyy/mm/dd') sdate,  to_char(edate,'yyyy/mm/dd') edate,  pi.ed_user ed_user,  to_char(pi.ed_tmst,'yyyy/mm/dd hh24:mi:ss') ed_tmst,  pi.ef_user ef_user, to_char(pi.ef_tmst,'yyyy/mm/dd hh24:mi:ss') ef_tmst, pi.credit3 credit3 from egtpick pi, egtcbas cb where Trim(empn)=empno AND sno = "+sno;

	rs = stmt.executeQuery(sql);
	while(rs.next())
	{
		empno = rs.getString("empno");
		cname = rs.getString("cname");
		sern = rs.getString("sern");
		reason = rs.getString("reason");
		reasondesc = rs.getString("reasondesc");
		comments = rs.getString("comments");
		new_tmst = rs.getString("new_tmst");
		valid_ind = rs.getString("valid_ind");
		sdate = rs.getString("sdate");
		edate = rs.getString("edate");
		ed_user = rs.getString("ed_user");
		ed_tmst = rs.getString("ed_tmst");
		ef_user = rs.getString("ef_user");
		ef_tmst = rs.getString("ef_tmst");
		credit3 = rs.getString("credit3");
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
.style8 {color: #000000}
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
  <form name="form1" method="post" action="modpick_ef2.jsp">
      <input name="empno" id="empno" type="hidden" value="<%=empno%>">
   <%
if("0".equals(reason))  //1改成0
{
%>
<input name="valid_ind" id="valid_ind" type="hidden" value="<%=valid_ind%>">
<%
}	

if("1".equals(reason))
{
%>
<span class="txtxred">※自2012/09/01起,全勤有效日永久有效,『是否有效』欄位恆為<strong> Y</strong></span>    
<%
}	
%>
<input name="sno" id="sno" type="hidden" value="<%=sno%>">  
<table width="90%" border="1" align="center" class="tablebody2">
    <tr bgcolor="#9CCFFF"  class="txtblue">
	    <td align="center" class="tablehead"><strong>姓名<br>員工號<br>(序號)</strong></td>
	    <td align="center" class="tablehead"><strong>申請日</strong></td>
	    <td align="center" class="tablehead"><strong>資格</strong></td>
	    <td align="center" class="tablehead"><strong>全勤起始日</strong></td>
	    <td align="center" class="tablehead"><strong>全勤結束日</strong></td>
<%
//if("2".equals(reason))
//{
%>
	    <td align="center" class="tablehead"><strong>是否<br>有效</strong></td>
<%
//}	
%>
		<td align="center" class="tablehead"><strong>註解</strong></td>
    </tr>
    <%
	if(count > 0)
	{
%>
		<tr valign="top" bgcolor="#FFFFFF" class="txtblue">
			<td Align="left" class="txtblue">
				  <div align="center">&nbsp;<%=cname%><br><%=empno%><br>(<%=sern%>)</div>
		    </td>
			<td align="center"><%=new_tmst%></td>
			<td align="center"><%=reasondesc%></td>
			<td align="center" class="txtblue"><input name="sdate" id="sdate" type="text" size="10" maxlength="10" class="txtblue" value="<%=sdate%>">&nbsp;&nbsp;<img height="16" src="../img/cal.gif" width="16" onclick="cal1.popup();"><br>ex:2008/01/01</td>
			<td align="center" class="txtblue"><input name="edate" id="edate" type="text" size="10" maxlength="10" class="txtblue" value="<%=edate%>">&nbsp;&nbsp;<img height="16" src="../img/cal.gif" width="16" onclick="cal2.popup();"><br>ex:2008/01/01</td>
<%
//if("2".equals(reason))
//{
%>
			<td Align="Center" class="txtblue"><span class="style8">
			  <select name="valid_ind" class="txtblue">
				<option value="<%=valid_ind%>"><%=valid_ind%></option>
				<option value="Y">Y</option>
				<option value="N">N</option>
			  </select></span>
	      </td>
<%
//}	
%>
		  <td align="center" class="txtblue"><textarea name="comments" cols="20" rows="5" class="txtblue"><%=comments%></textarea></td>
		</tr>
<%
	}
	else
	{
%>
		<tr bgcolor="#FFFFFF">
			<td class="txtblue" colspan="7">No Data</td>
		</tr>
<%		
	}
%>
</table>
<table>
  <tr>
    <td class="txtblue">
      <div align="center">
<%
if("0".equals(reason))  //1改成0 
{
%>
        <input name="Submit" type="submit" class="button1 txtblue" id="Submit" value="修改日期及退還申請">
<%
}	
else
{
%>
        <input name="Submit" type="submit" class="button1 txtblue" id="Submit" value="Modify">
<%
}
%>
	  </div>
    </td>
    </tr>
</table>
</form>


</div>
</body>
</html>

<script language="JavaScript">
var cal1 = new calendar2(document.form1.elements['sdate']);
cal1.year_scroll = true;
cal1.time_comp = false;
var cal2 = new calendar2(document.form1.elements['edate']);
cal2.year_scroll = true;
cal2.time_comp = false;
</script> 
