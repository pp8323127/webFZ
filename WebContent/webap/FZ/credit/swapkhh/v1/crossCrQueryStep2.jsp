<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,swap3ackhh.*" %>
<%
//session.setAttribute("aPrjcr","0");
//session.setAttribute("rPrjcr","0");


%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>���ɸպ�Step2</title>
<script language="javascript" type="text/javascript" src="../js/showDate.js"></script>
<link href="swap.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="../errStyle.css">
</head>
<body >
<%

String aEmpno = (String)session.getAttribute("userid");////request.getParameter("aEmpno");
String rEmpno = request.getParameter("rEmpno");
String year   = request.getParameter("year");
String month   = request.getParameter("month");


//�ˬd�Z��O�_����
swap3ackhh.PublishCheck pc = new swap3ackhh.PublishCheck(year, month);

swap3ackhh.ApplyCheck ac = new swap3ackhh.ApplyCheck(aEmpno,rEmpno,year,month);
if(ac.isALocked()){//�ӽЪ̯Z����w,(���`���p���Ӥ��|�o�͡A��w�̬ݤ��촫�Z���\��ﶵ)
%>
<p class="errStyle1">�ӽЪ�(<%=rEmpno%>)&nbsp; 
			�Z����w���A, 		
			���o�d��.<br>
			�]����ݳ]�w�Z���}�񪬺A,��i�ϥέ��ɸպ�d�ߥ\��^.</p>
<%
}else if(ac.isRLocked()){//�Q���̯Z����w
%>
<p  class="errStyle1">�Q����(<%=rEmpno%>)&nbsp; 
			�Z����w���A, 		
			���o�d��.<br>
			�]����ݳ]�w�Z���}�񪬺A,��i�ϥέ��ɸպ�d�ߥ\��^.</p>
<%
}
//�Z��O�_����
else if(!pc.isPublished()){
%>
<p  class="errStyle1"><%=year+"/"+month%> �Z��|�����������A���o�d��.</p>
<%
}

else{


response.sendRedirect("crossCr.jsp?rEmpno="+rEmpno+"&year="
			  +year+"&month="+month);

}

%>

</body>
</html>