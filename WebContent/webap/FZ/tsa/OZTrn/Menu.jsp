<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*"%>
<%
String userid = (String) session.getAttribute("cs55.usr");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Menu</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
function show(w1){
		parent.topFrame.location.href=w1;
//		parent.mainFrame.location.href=w2;
}
</script>

</head>
<body>
<table width="50%"  border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="30" colspan="2" bgcolor="#99CCFF">
      <p align="center" class="fonte_dblue2">�~�׽ưV</p>
    </td>
  </tr>
   <tr >
    <td width="2%" height="30" >&nbsp;</td>
    <td ><span class="txtblue"><a href="#" onClick="show('allQuery.jsp')" >�E���ͦU���V�m�I�V�W��( PC/PT/CRM/SS/FM/ES/RC )</a><br>
    </span></td>
  </tr>
  <% if ("634319".equals(userid) || "634069".equals(userid)) { %>
     <tr><td width="2%" height="30" >&nbsp;</td>       
     <td><span class="txtblue"><a href="#" onClick="show('allQuery_new.jsp')" >�E<font color="#FF0000"><strong>(New)</strong></font>���ͦU���V�m�I�V�W��( 
      PC/PT/CRM/SS/FM/ES/RC )</a><br></span></td></tr>
  <% } //if %>
  <tr >
    <td height="30" bgcolor="#CCFFFF">&nbsp;</td>
    <td bgcolor="#CCFFFF"><span class="txtblue"><a href="#" onClick="show('NewQuery.jsp')" >�E�d�߷s�i�|�������V������</a><br>
    </span></td>
  </tr>
  <tr >
    <td height="30"  >&nbsp;</td>
    <td class="txtblue"  >*���G�w�]�C�~��2.7.8.12��������u�A�i�̹�ڪ��p��ʽվ�C </td>
  </tr> 
<%
//if("640073".equals(userid)){
%>
  <tr bgcolor="#CCFFFF">
    <td height="30">&nbsp;</td>
    <td class="txtblue"><a href="#" onClick="show('RecurrentRecordQuery.jsp')" >�E�U���V�m�O��</a>[���\����դ�...]</td>
  </tr>
  <%
  //}
  %>
  
</table>
</body>
</html>
