<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>3�����Z�ӽ�</title>
<script language="javascript" type="text/javascript" src="../js/showDate.js"></script>
<link href="swap.css" rel="stylesheet" type="text/css">
</head>

<body  >
<div align="center">
  <%
String userid = (String) session.getAttribute("userid") ; 
//String unitCd = (String)session.getAttribute("Unitcd");
String goPage = "";

swap3.ApplyCheck ac = new swap3.ApplyCheck();
ac.SelectDateAndCount();

//swap3.applyForm af = new swap3.applyForm();

//if (af.getLimitDate() > 0){	//�D�u�@��
if( ac.isLimitedDate()){
%>
  <p style="color:red">�t�Τ��餣���z���Z�A�Щ�u�@��00:01�}�l����<BR>
�i���]���G1.�Ұ���2.���ƬG(�䭷)</p>
<%

//}else if( !af.checkMax()){ //�W�L�B�z�W��
}else if( ac.isOverMax()){ //�W�L�B�z�W��
%>
<p style="color:#FF0000 ">�w�W�L�t�γ��B�z�W���I<br>
�Щ�u�@��17:00�}�l����.</p>
<%	
}else{
//���ե�
/*	if("176D".equals(unitCd) || "190A".equals(unitCd)){		
		goPage="step1.jsp";
	}else{
		goPage = "step1_2.jsp?userid="+userid;
	}
*/	
	response.sendRedirect("step1_2.jsp");

}
	
%>
</div>
</body>
</html>