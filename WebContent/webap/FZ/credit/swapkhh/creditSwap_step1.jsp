<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>�n�I���Z�ӽ�Step1</title>
<script language="javascript" type="text/javascript" src="../../js/showDate.js"></script>
<link href="swap.css" rel="stylesheet" type="text/css">
</head>

<body  >
<div align="center">
  <%
String userid = (String) session.getAttribute("userid") ; 
String unitCd = (String)session.getAttribute("Unitcd");
String powerUser = (String)session.getAttribute("powerUser"); 
String occu =  (String)session.getAttribute("occu");
String sno = (String) request.getParameter("sno");
String goPage = "";

swap3ackhh.ApplyCheck ac = new swap3ackhh.ApplyCheck();
ac.SelectDateAndCount();

if( ac.isLimitedDate()){//�D�u�@��
%>
  <div class="errStyle1"  >�t�Τ��餣���z���Z�A�Щ�u�@��00:01�}�l����<BR>
�i���]���G1.�Ұ���2.���ƬG(�䭷)</div>
<%

}else if( ac.isOverMax()){ //�W�L�B�z�W��
%>
<p  class="errStyle1" >�w�W�L�t�γ��B�z�W��.<br>
�Щ�u�@��17:30�}�l����.</div>
<%	
}
else
{
	goPage = "creditSwap_step2.jsp?sno="+sno;
	
	response.sendRedirect(goPage);
}
	
%>
</div>
</body>
</html>