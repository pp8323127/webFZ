<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>3�����Z�ӽ�Step0</title>
<script language="javascript" type="text/javascript" src="../js/showDate.js"></script>
<link href="swap.css" rel="stylesheet" type="text/css">
</head>

<body  >
<div align="center">
  <%
String userid = (String) session.getAttribute("userid") ; 
String unitCd = (String)session.getAttribute("Unitcd");
String powerUser = (String)session.getAttribute("powerUser"); 
String occu =  (String)session.getAttribute("occu");
String goPage = "";

swap3ac.ApplyCheck ac = new swap3ac.ApplyCheck();
ac.SelectDateAndCount();



if( ac.isLimitedDate()){//�D�u�@��
%>
  <p style="color:red">�t�Υثe�����z���Z�A�Щ�<%=ac.getLimitenddate()%>��}�l����<BR>
�i���]���G1.�Ұ���2.���ƬG(�䭷)</p>
<%

}else if( ac.isOverMax()){ //�W�L�B�z�W��
%>
<p style="color:#FF0000 ">�w�W�L�t�γ��B�z�W���I<br>
�Щ�u�@��16:00�}�l����.</p>
<%	
}else{

	goPage = "step1_2.jsp";
	
	response.sendRedirect(goPage);

}
	
%>
</div>
</body>
</html>