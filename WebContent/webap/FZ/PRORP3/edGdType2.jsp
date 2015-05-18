<%@ page contentType="text/html; charset=big5" language="java"  errorPage="" %>
<%@ page import="java.sql.*,fz.pr.orp3.GdType_Name,ci.db.*"%>
<%
//�s��w�s�b��GdType
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);

String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if ( sGetUsr == null) {		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
	
}


String cname	= request.getParameter("cname");
String ename = request.getParameter("ename");
if (ename == null) {ename = "&nbsp;";}
String fdate = request.getParameter("fdate");
String yearSern = request.getParameter("yearSern");

String sern  = null;
String fltno = null;
String sect  = null;
String GdYear= null;
String empno = null;
String comm = null;
String gdName = null;
String gdType = null;

ArrayList gdNameAL = new ArrayList();
ArrayList gdTypeAL = new ArrayList();
ArrayList gdComm	= new ArrayList();

//�ഫGdType & GdName
GdType_Name myGdType = new GdType_Name();
myGdType.setStatement();

Driver dbDriver = null;
Connection conn = null;
Statement stmt = null;
ResultSet myResultSet = null;
String sql = "";

try{
	ConnDB cn = new ConnDB();
	cn.setORP3EGUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
	stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
		ResultSet.CONCUR_READ_ONLY);
sql ="SELECT * FROM EGTGDDT WHERE yearsern='"+yearSern+"'";
myResultSet = stmt.executeQuery(sql);
	if(myResultSet.next()){
			sern  = myResultSet.getString("sern");
			fltno = myResultSet.getString("fltno");
			sect  = myResultSet.getString("sect");
			GdYear= myResultSet.getString("gdyear");
			empno = myResultSet.getString("empn");	
			comm = myResultSet.getString("comments");
			gdName = myGdType.getGdName(myResultSet.getString("gdtype"));//�NgdType�ରgdName
			gdType = myResultSet.getString("gdtype");
	}
	
myResultSet.close();

//��w�]comments���
String selectStr = myGdType.getComm();
//�����s�u
myGdType.closeStatement();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>�s��Үֶ���</title>
<link href="style2.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.y {
	background-color: #FFFFCC;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size:10pt;
	color: #000099;
	border: 1px solid;
}
-->
</style>
<script language="JavaScript" type="text/JavaScript">
function checkCharacter(){

	var message = document.form1.comm.value;
	var len = document.form1.comm.value.length;
		//alert(len);
	if(len >800){
		alert("Comments�r���ƭ��1000�Ӧr���A\n�ҿ�J�r�ƶW�L"+(len-800)+"�Ӧr���A�Э��s��J");
		document.form1.comm.focus();
		return false;
	}
	else if(len == ""){
		if(confirm("�|�����Comments�ԭz�A�T�w�n�e�X�H")){
			document.form1.Submit.disabled=1;
			document.form1.addToComm.disabled=1;
			return true;
		}
		else{
			document.form1.comm.focus();
			return false;
		}
	}
	else{
		document.form1.Submit.disabled=1;
		document.form1.addToComm.disabled=1;
	
		return true;
	}
}
/*
//������w�]comments��A�N�ȱa���J���A�i���ƪ��[
function addComments(){
    var addcomm = document.form1.gdComm.value;
	var originalComm = document.form1.comm.value;
	originalComm +=  ","+addcomm;	//��,�j�}
	if(document.form1.comm.value == ""){	
		document.form1.comm.value = addcomm;	//��J���L���e�A�����[�J�����comments
	}
	else{
		document.form1.comm.value = originalComm;	//��J���w�����e�A���[�����comments�å�,�j�}
	}
	
}
*/

function addComm2(){//�N�Ĥ@��comments���ﶵ�ȱa���J���A�i���ƪ��[
    var addcomm = document.form1.gdComm.value;
	var originalComm = document.form1.comm.value;
	originalComm +=  ","+addcomm;	//��,�j�}
	if(document.form1.comm.value == ""){	
		document.form1.comm.value = addcomm;	//��J���L���e�A�����[�J�����comments
	}
	else{
		document.form1.comm.value = originalComm;	//��J���w�����e�A���[�����comments�å�,�j�}
	}
}


</script>
</head>

<body onLoad="javascript:document.form1.comm.focus()">
<div align="center">

    <span class="txttitletop">Edit In-Flight Service Grade</span>
</div>
<form name="form1" method="post" action="upGdType2.jsp" onSubmit="return checkCharacter()">
  <table width="78%"  border="0" align="center" cellpadding="2" cellspacing="0" >
    <tr>
      <td class="txtblue">Date:<span class="txtred"><%=fdate%></span></td>
      <td class="txtblue">Fltno:<span class="txtred"><%=fltno%></span></td>
      <td class="txtblue">Sern:<span class="txtred"><%=sern%></span></td>
      <td class="txtblue">&nbsp;</td>
    </tr>
    <tr>
      <td colspan="4" class="txtblue">Name:<span class="txtred"><%=cname%>&nbsp;<%=ename%></span></td>
    </tr>
  </table>
  <table width="78%"  border="0" align="center" cellpadding="2" cellspacing="0" class="fortable">
    <tr >
      <td width="13%" class="y">
        <div align="center">Grade </div>
      </td>
      <td width="87%" class="fortable">
        <select name="gdname" >
<%
	if(gdType.equals("GD3")){
%>
		<option value="GD3" selected>�u�I</option>
		<option value="GD17">���O(REC)</option>
		<option value="GD18">��L</option>
		
		
<%
}else if(gdType.equals("GD17")){
%>		
		<option value="GD3">�u�I</option>
		<option value="GD17" selected>���O(REC)</option>
		<option value="GD18">��L</option>
<%
}else{
%>
		<option value="GD3">�u�I</option>
		<option value="GD17">���O(REC)</option>
		<option value="GD18" selected>��L</option>

<%
}
%>		
        </select>
</td>
    </tr>
    <tr >
      <td height="59"class="y">
        <div align="center">Comments</div>
      </td>
      <td class="fortable">
        <p>
        <select name="gdComm" >
			<%=selectStr%>
       </select>	
		<input type="button" onclick="addComm2()"  name="addToComm"  value="Add to comments" >
        <br>	
          <textarea name="comm" cols="50" rows="4"><%=comm%></textarea>
        </p>
      </td>
    </tr>
  </table>
  <div align="center">
      <input type="submit" name="Submit" value="Save (�x�s)" class="addButton">
      &nbsp;&nbsp;&nbsp;
		  <input name="reset" type="reset" value="Reset (�M�����g)">
		&nbsp;&nbsp;&nbsp;
          <input name="button" type="button"  onClick="javascript:self.close()" value="Exit (���})">
&nbsp;&nbsp;&nbsp;
 		    <input type="hidden" name="fltno" value="<%=fltno%>">
		    <input type="hidden" name="fdate" value="<%=fdate%>">
		    <input type="hidden" name="sern" value="<%=sern%>">
		    <input type="hidden" name="cname" value="<%=cname%>">
		    <input type="hidden" name="ename" value="<%=ename%>">
		    <input type="hidden" name="sect" value="<%=sect%>">
		    <input type="hidden" name="GdYear" value="<%=GdYear%>">
		    <input type="hidden" name="empno" value="<%=empno%>">
			<input type="hidden" name="yearSern" value="<%=yearSern%>">
    </div>
</form>

</body>
</html>


<%
}
catch (Exception e)
{
	  out.print(e.toString());
}
finally
{
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>