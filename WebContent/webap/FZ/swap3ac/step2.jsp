<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,swap3ac.*" %>
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
<title>AirCrews3�����Z�ӽ�Step2</title>
<script language="javascript" type="text/javascript" src="../js/showDate.js"></script>
<link href="swap.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="../errStyle.css">
</head>
<body >
<%

//String aEmpno = (String)session.getAttribute("userid"); //request.getParameter("aEmpno");
String aEmpno = (String)request.getParameter("aEmpno");
String rEmpno = (String)request.getParameter("rEmpno");
String year   = request.getParameter("year");
String month   = request.getParameter("month");
session.setAttribute("aEmpno",aEmpno);
session.setAttribute("rEmpno",rEmpno);

swap3ac.ApplyCheck ac1 = new swap3ac.ApplyCheck();
ac1.SelectDateAndCount();

if( ac1.isLimitedDate()){//�D�u�@��
%>
  <p  class="errStyle1">�t�Υثe�����z���Z�A�Щ�<%=ac1.getLimitenddate()%>��}�l����<BR>
�i���]���G1.�Ұ���2.���ƬG(�䭷)</p>
<%

}else if( ac1.isOverMax()){ //�W�L�B�z�W��
%>
<p  class="errStyle1">�w�W�L�t�γ��B�z�W���I</p>
<%	
}

//�ˬd�Z��O�_����
swap3ac.PublishCheck pc = new swap3ac.PublishCheck(year, month);
swap3ac.ApplyCheck ac = new swap3ac.ApplyCheck(aEmpno,rEmpno,year,month);
//add by Betty on 20080512
//***********************************************************************
//�ӽЪ̬O�_����
CheckFullAttendance acs = new CheckFullAttendance(aEmpno, year+month);
String a_isfullattendance = acs.getCheckMonth();
//�Q���̬O�_����
CheckFullAttendance rcs = new CheckFullAttendance(rEmpno, year+month);
String r_isfullattendance = rcs.getCheckMonth();
String displaystr = "";
if(!"Y".equals(a_isfullattendance))
{
	displaystr = a_isfullattendance;
}
if(!"Y".equals(r_isfullattendance))
{
	displaystr = r_isfullattendance;
}
//***********************************************************************
if(ac.isUnCheckForm()){	//���ӽг�|���֥i�A���i�ӽ�
%>
<p  class="errStyle1">�ӽЪ�(<%=aEmpno%>)&nbsp;
			�γQ����(<%=rEmpno%>)&nbsp;���ӽг�|���gED�֥i, <br>		
�t�Τ����z����.</p>
<%
//add by Betty on 20080512
//***********************************************************************
}
else if (!"Y".equals(a_isfullattendance) | !"Y".equals(r_isfullattendance) )
{
%>
<p  class="errStyle1"><%=displaystr%> </p>
<%
//***********************************************************************
}
else if (ac.getAApplyTimes() >=3 )
{ // �ӽЪ̷��ӽЦ��ư���3���A���i�ӽ�
%>
<p  class="errStyle1">�ӽЪ�(<%=aEmpno%>)&nbsp; 
			 <%=year+"/"+month %>�ӽЦ��Ƥw�W�L�T��, <br>		
			�t�Τ����z����.</p>
<%

}else if (ac.getRApplyTimes() >=3 ){ // �Q���̷��ӽЦ��ư���3���A���i�ӽ�
%>
<p  class="errStyle1">�Q����(<%=rEmpno%>)&nbsp; 
			 <%=year+"/"+month %>�ӽЦ��Ƥw�W�L�T��, <br>		
			�t�Τ����z����.</p>
<%

}else if(ac.isALocked()){//�ӽЪ̯Z����w,(���`���p���Ӥ��|�o�͡A��w�̬ݤ��촫�Z���\��ﶵ)
%>
<p class="errStyle1">�ӽЪ�(<%=rEmpno%>)&nbsp; 
			�Z����w���A, <br>		
			�t�Τ����z����.<br>
			�]���Z����ݳ]�w�Z���}�񪬺A,��i�ϥδ��Z�\��^.</p>
<%
}else if(ac.isRLocked()){//�Q���̯Z����w
%>
<p  class="errStyle1">�Q����(<%=rEmpno%>)&nbsp; 
			�Z����w���A, <br>		
			�t�Τ����z����.<br>
			�]���Z����ݳ]�w�Z���}�񪬺A,��i�ϥδ��Z�\��^.</p>
<%
}
//�Z��O�_����
else if(!pc.isPublished()){
%>
<p  class="errStyle1"><%=year+"/"+month%> �Z��|�����������A�t�Τ����z����.</p>
<%
}

else
{

//�]�w�w������
session.setAttribute("aApplyTimes",Integer.toString(ac.getAApplyTimes()));
session.setAttribute("rApplyTimes",Integer.toString(ac.getRApplyTimes()));

/*response.sendRedirect("applicant.jsp?aEmpno="+aEmpno+"&rEmpno="+rEmpno+"&year="
			  +year+"&month="+month);
*/
response.sendRedirect("checkRetire.jsp?aEmpno="+aEmpno+"&rEmpno="+rEmpno+"&year="
			  +year+"&month="+month);

}

%>

</body>
</html>