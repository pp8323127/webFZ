<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*" errorPage="" %>
<%
String fdate = request.getParameter("sdt"); //YYYYMMDDHH24MI 
out.print(fdate);
%>
<html><head><title></title><meta http-equiv="Content-Type" content="text/html; charset=big5">
<style type="text/css">
body
{
font-size: 9pt;
font-family: Courier;
}

input.st1
{
	border-bottom: 1.5px solid #808080 ;
	border-top: 0px solid #FFFFFF ;
	border-left: 0px solid #FFFFFF ;
	border-right: 0px solid #FFFFFF ;
	vertical-align: bottom;
	font-size: 9pt;
}

input.st2
{
	border-bottom: 0px solid #FFFFFF ;
	border-top: 0px solid #FFFFFF ;
	border-left: 0px solid #FFFFFF ;
	border-right: 0px solid #FFFFFF ;
	vertical-align: bottom;
	font-size: 9pt;
}
.style2 {
	font-size: 12;
	color: #FF0000;
}
</style>
</head><body>
<%
String fleet = "343";
%>
<table width="100%"  border="0" cellspacing="0" cellpadding="0">
</td><td>
<input name="acno" type="text" value="B18207" size="8" maxlength="8" class="st1" 
onkeyup="javascript:this.value=this.value.toUpperCase();"></td></tr>
</table>
Outer Value <br>
fleet<input type="text" name="fleet" id="fleet" value=<%=fleet%> readonly>
empno<input type="text" name="empno" id="empno">
<input type="button" name="disp_empno" id="disp_empno" value="Disp Empno" onClick="f_outerval()">
<hr>
<table><tr valign="baseline">
<td>
<input type="checkbox" name="prehdl" id="prehdl"> 
<input type="text" name="fltno" id="fltno">
<input type="button" name="disp_fltno" id="disp_fltno" value="Disp Fltno" onClick="f_formval()">
</td></tr></table>
</body></html>

<%
String s1 = "1";
%>

<script language="javascript" type="text/javascript">
//alert("JSP Value = <%=s1%>");
</script>

<script language="javascript" type="text/javascript">
function f_outerval() {
    alert(document.getElementById("fleet").value);
}//if

function f_formval() {
	alert(document.form1.fltno.value);
}//if
</script>