<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=big5" language="java"  errorPage="" %>
<%@ page import="eg.zcrpt.*,java.sql.*,ci.db.*"%>
<%
//�s��w�s�b��GdType
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);

String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
ArrayList objAL = (ArrayList) session.getAttribute("zcreportobjAL"); 
if ( sGetUsr == null | objAL == null) 
{		//check user session start first or not login
	response.sendRedirect("/webfz/FZ/sendredirect.jsp");
}
else
{
	String idx = request.getParameter("idx");
	String subidx = request.getParameter("subidx");
	String subsubidx = request.getParameter("subsubidx");
	boolean chkdup = false;
	ZCReportObj obj = (ZCReportObj) objAL.get(Integer.parseInt(idx));
	ArrayList crewListobjAL = new ArrayList();
	crewListobjAL = obj.getZccrewObjAL();
	ZCReportCrewListObj zccrewobj = (ZCReportCrewListObj) crewListobjAL.get(Integer.parseInt(subidx));	ArrayList crewgradeobjAL = new ArrayList();
	crewgradeobjAL = zccrewobj.getGradeobjAL();
	ZCGradeObj gradeobj = (ZCGradeObj) crewgradeobjAL.get(Integer.parseInt(subsubidx));
	//�ҵ�����
	fz.pracP.GdTypeName gn = new fz.pracP.GdTypeName();
	try {
		gn.SelectData();
	} catch (InstantiationException e) {
		out.print(e.toString());
	} catch (IllegalAccessException e) {
		out.print(e.toString());
	} catch (ClassNotFoundException e) {
		out.print(e.toString());
	} catch (SQLException e) {
		out.print(e.toString());
	}
	ArrayList CommAL = gn.getCommAL();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>�s��Үֶ���</title>
<link href="../style2.css" rel="stylesheet" type="text/css">
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
function checkCharacter()
{
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
function clearcomm(){

	var comm = document.form1.gdname.value;
	if(comm == "GD17"){
		document.form1.gdComm.length=<%=CommAL.size()%>+1;
		document.form1.gdComm.options[0] = new Option("","");
		document.form1.gdComm.options[0].selected;
		<%
		for(int i=0;i<CommAL.size();i++){
		out.print("document.form1.gdComm.options["+(i+1)+"] = new Option(\""+CommAL.get(i)+"\",\""+CommAL.get(i)+"\");\r\n");
		}		
		%>		
		
	}else if(comm == "GD20"){
		document.form1.gdComm.length=2;
		document.form1.gdComm.options[0] = new Option("YES","YES");
		document.form1.gdComm.options[1] = new Option("NO","NO");
	}else{
		document.form1.gdComm.length=<%=CommAL.size()%>;
		<%
		for(int i=0;i<CommAL.size();i++){
		out.print("document.form1.gdComm.options["+i+"] = new Option(\""+CommAL.get(i)+"\",\""+CommAL.get(i)+"\");\r\n");
		}		
		%>		
		//document.form1.gdComm.value = "�u�@�q�~�B�{�u";
	}
}


</script>
</head>

<body onLoad="javascript:document.form1.comm.focus()">
<div align="center">

    <span class="txttitletop">Edit In-Flight Service Grade</span>
</div>
<form name="form1" method="post" action="zcupGdType2.jsp" onSubmit="return checkCharacter()">
  <table width="78%"  border="0" align="center" cellpadding="2" cellspacing="0" >
    <tr>
      <td class="txtblue">Date:<span class="txtred"><%=obj.getFdate()%></span></td>
      <td class="txtblue">Fltno:<span class="txtred"><%=obj.getFlt_num()%></span></td>
      <td class="txtblue">Sern:<span class="txtred"><%=zccrewobj.getSern()%></span></td>
      <td class="txtblue">&nbsp;</td>
    </tr>
    <tr>
      <td colspan="4" class="txtblue">Name:<span class="txtred"><%=zccrewobj.getCname()%></span></td>
    </tr>
  </table>
  <table width="78%"  border="0" align="center" cellpadding="2" cellspacing="0" class="fortable">
    <tr >
      <td width="13%" class="y">
        <div align="center">Grade </div>
      </td>
      <td width="87%" class="fortable">
        <select name="gdname" OnChange="clearcomm();">
<%
	if("GD3".equals(gradeobj.getGdtype()))
	{
%>
		<option value="GD3" selected>�u�I</option>
		<option value="GD17">���O(REC)</option>
		<option value="GD20">CCOM�Ү�</option>				
		<option value="GD18">��L</option>
		
		
<%
}
else if("GD17".equals(gradeobj.getGdtype()))
{
%>		
		<option value="GD3">�u�I</option>
		<option value="GD17" selected>���O(REC)</option>
		<option value="GD20">CCOM�Ү�</option>					
		<option value="GD18">��L</option>
<%
}
else if("GD20".equals(gradeobj.getGdtype()))
{
%>
		<option value="GD3">�u�I</option>
		<option value="GD17">���O(REC)</option>
		<option value="GD20" selected>CCOM�Ү�</option>
		<option value="GD18" >��L</option>

<%
}
else 
{
%>
		<option value="GD3">�u�I</option>
		<option value="GD17">���O(REC)</option>
		<option value="GD20">CCOM�Ү�</option>						
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
		<%
		if("GD20".equals(gradeobj.getGdtype()))
	    {
		out.print("<option value=\"YES\">YES</option>");
		out.print("<option value=\"NO\">NO</option>");		
		}
		else
		{
		%>
			<%=gn.getCommOptionList()%>
 		<%
		}
		%>			
       </select>	
		<input type="button" onclick="addComm2()"  name="addToComm"  value="Add to comments" >
        <br>	
          <textarea name="comm" cols="50" rows="4"><%=gradeobj.getComments()%></textarea>
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
		<input type="hidden" name="idx" value="<%=idx%>">
		<input type="hidden" name="subidx" value="<%=subidx%>">
		<input type="hidden" name="subsubidx" value="<%=subsubidx%>">
    </div>
</form>

</body>
</html>
<%
}	
%>

