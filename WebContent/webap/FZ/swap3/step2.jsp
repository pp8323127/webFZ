<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,swap3.*" %>
<%
//session.setAttribute("aPrjcr","0");
//session.setAttribute("rPrjcr","0");
session.setAttribute("aEmpno",null);
session.setAttribute("rEmpno",null);
session.setAttribute("aApplyTimes",null);
session.setAttribute("rApplyTimes",null);


%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>3�����Z�ӽ�Step2</title>
<script language="javascript" type="text/javascript" src="../js/showDate.js"></script>
<link href="swap.css" rel="stylesheet" type="text/css">
</head>
<body >
<%
//String userid = (String) session.getAttribute("userid") ; 

String aEmpno = (String) session.getAttribute("userid");//request.getParameter("aEmpno");
String rEmpno = request.getParameter("rEmpno");
String year   = request.getParameter("year");
String month   = request.getParameter("month");
session.setAttribute("aEmpno",aEmpno);
session.setAttribute("rEmpno",rEmpno);


swap3.ApplyCheck ac = new swap3.ApplyCheck(aEmpno,rEmpno,year,month);
if(ac.isUnCheckForm()
){	//���ӽг�|���֥i�A���i�ӽ�
%>
<p style="color:red;text-align:center ">�ӽЪ�(<%=aEmpno%>)&nbsp;
			�γQ����(<%=rEmpno%>)&nbsp;���ӽг�|���gED�֥i, <br>		
�t�Τ����z����.</p>
<%
}else if (ac.getAApplyTimes() >=3 ){ // �ӽЪ̷��ӽЦ��ư���3���A���i�ӽ�
%>
<p style="color:red;text-align:center ">�ӽЪ�(<%=aEmpno%>)&nbsp; 
			���ӽЦ��Ƥw�W�L�T��, <br>		
			�t�Τ����z����.</p>
<%

}else if (ac.getRApplyTimes() >=3 ){ // �Q���̷��ӽЦ��ư���3���A���i�ӽ�
%>
<p style="color:red;text-align:center ">�Q����(<%=rEmpno%>)&nbsp; 
			���ӽЦ��Ƥw�W�L�T��, <br>		
			�t�Τ����z����.</p>
<%

}else if(ac.isALocked()){//�ӽЪ̯Z����w,(���`���p���Ӥ��|�o�͡A��w�̬ݤ��촫�Z���\��ﶵ)
%>
<p style="color:red;text-align:center ">�ӽЪ�(<%=rEmpno%>)&nbsp; 
			�Z����w���A, <br>		
			�t�Τ����z����.<br>
			�]���Z����ݳ]�w�Z���}�񪬺A,��i�ϥδ��Z�\��^.</p>
<%
}else if(ac.isRLocked()){//�Q���̯Z����w
%>
<p style="color:red;text-align:center ">�Q����(<%=rEmpno%>)&nbsp; 
			�Z����w���A, <br>		
			�t�Τ����z����.<br>
			�]���Z����ݳ]�w�Z���}�񪬺A,��i�ϥδ��Z�\��^.</p>
<%
}


else{

//�]�w�w������
session.setAttribute("aApplyTimes",Integer.toString(ac.getAApplyTimes()));
session.setAttribute("rApplyTimes",Integer.toString(ac.getRApplyTimes()));


response.sendRedirect("applicant.jsp?rEmpno="+rEmpno+"&year="
			  +year+"&month="+month);
}
%>
</body>
</html>