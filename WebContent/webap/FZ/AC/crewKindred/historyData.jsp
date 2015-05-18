<%@ page contentType="text/html; charset=big5" language="java"   %>
<%@ page import="java.sql.*,fzac.crewkindred.*,java.text.*"%>
<%
String userid  = (String)session.getAttribute("cs55.usr");

String errMsg = "";
boolean  status = true;
String year = request.getParameter("year");
String month = request.getParameter("month");
String empno = request.getParameter("empno");
if("".equals(empno)){
	empno = null;
}
String selAll = request.getParameter("selAll");//��ܥ���
String selDeleted = request.getParameter("selDeleted");//�]�t�w�R��
java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy/MM/dd HH:mm",Locale.TAIWAN);


DataMaintain dm = new DataMaintain();
ArrayList dataAL = null;
if(userid == null){
	status = false;
	errMsg = "�����w�L��,�Э��s�n�J";

}else{
	
	
	try {
			dm.setYear(year);	
			dm.setMonth(month);
			dm.setEmpno(empno);
			if("Y".equals(selDeleted)){
				dm.setSelectDeletedData(true);
			}
			if("Y".equals(selAll)){
				dm.setSelectCrewAllData(true);
			}
			dm.SelectHistoryData();
			
			dataAL = dm.getDataAL();
		if (dataAL == null) {
			status = false;
			errMsg = "�d�L�ŦX�����";
		} else {
			
			status = true;
		}
	
	} catch (Exception e) {
		status = false;
		errMsg = "ERROR:"+e.getMessage();
	}	
}

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>���v����</title>
<link rel="stylesheet" type="text/css" href="../../../style/style1.css">
<link rel="stylesheet" type="text/css" href="../../lightColor.css">
<link rel="stylesheet" type="text/css" href="../../../style/kbd.css">
<link rel="stylesheet" type="text/css" href="../../../style/loadingStatus.css">

</head>

<body>
<%
if(!status){

%>
<div class="paddingTopBottom bgLYellow red center"><%=errMsg%></div>
<%

}else{

%>



<fieldset style="width:600pt; ">
  <legend class="blue"><img src="../../images/format-justify-fill.png" width="16" height="16">�խ��a�ݹq�� ���v�ӽи��
  
</legend>
<table width="100%"  border="1" cellspacing="2" cellpadding="2" class="tableStyle1">
  <caption>&nbsp;
  </caption>
  <tr class="bgBlue2 center">
 	 <td width="11%">���O</td>
    <td width="14%">�խ����u��</td>
    <td width="16%" height="24">�a�ݩm�W</td>
    <td width="13%">�a�ݤ��</td>
    <td width="18%">�ӽЮɶ�</td>
    <td width="18%">�פJ�ɶ�</td>
    <td width="9%">�פJ��</td>
	
  </tr>
  <%
	for(int i=0;i<dataAL.size();i++){
		CrewKindredObj  obj = (CrewKindredObj)dataAL.get(i);
%>
  <tr class="left<%if(i%2==1){%> bgLGray<%}%>">
   <td class="center">
   <%if(null ==obj.getDelete_ind()){
	%>
	  <img src="../../images/cancel_16x16.png" width="16" height="16" align="top" class="center" alt="�ӽЧR��" title="�ӽЧR��">
	<%	}	else if("Y".equals( obj.getDelete_ind())){%>
  <img src="../../images/delete_gray.gif" width="16" height="16" align="top" class="center" alt="�ӽШ���" title="�ӽШ���">
    <%}else if("Y".equals( obj.getExport_ind())){
	%>
	  <img src="../../images/accept.png" width="16" height="16" align="top" class="center" alt="��Ƥw�פJ" title="��Ƥw�פJ">
	<%
	}%>
   </td>
    <td class="center"><%=obj.getEmpno()%></td>
    <td><%=obj.getKindred_surName()+"&nbsp;"+obj.getKindred_First_Name()%></td>
    <td class="center"><%=obj.getKinddred_Phone_Num()%></td>
    <td><%=formatter.format(obj.getApply_time())%></td>
  <td><%if(obj.getExport_time() != null){out.print(formatter.format(obj.getExport_time()));}%></td>
    <td class="center"><%=obj.getExport_Empno()%></td>
	
  </tr>
  <%
}
%>
<tr >
  <td colspan="7" class="bgLGray left">
    <p><img src="../../images/accept.png" width="16" height="16" align="top">�G�ӽзs�W / �ק惡���p���H��T<br>
        <%if("Y".equals(selDeleted)){%><img src="../../images/delete_gray.gif" width="16" height="16" align="top">�G�b�����J�e�A�խ��w�ۦ�������ӽ�<br><%}%>
        <img src="../../images/cancel_16x16.png" width="16" height="16" align="top" >�G�ӽЧR���w�ͮĤ��p���H��T</p>
    <div class="center"> 
	      <input type="button" class="kbd" onClick="self.location.href='historyQuery.jsp';" value=" �� �s �d �� ">
    </div></td>
  </tr>
   

</table>
</fieldset>
<%
}
%>
</body>
</html>
