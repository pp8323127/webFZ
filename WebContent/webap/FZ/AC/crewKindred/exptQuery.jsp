<%@ page contentType="text/html; charset=big5" language="java"   %>
<%@ page import="java.sql.*,fzac.crewkindred.*,java.text.*"%>
<%
String userid  = (String)session.getAttribute("cs55.usr");

ArrayList dataAL = null;
String errMsg = "";
boolean  status = true;
java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy/MM/dd HH:mm",Locale.TAIWAN);
session.setAttribute("crewLindAL",null);
if(userid == null){
	status = false;
	errMsg = "�����w�L��,�Э��s�n�J";
}else{
	DataMaintain dm = new DataMaintain();
	
	try {
			dm.SelectUnExportedData();
			dataAL = dm.getDataAL();
		if (dataAL == null) {
			status = false;
			errMsg = "<img src='../../images/messagebox_info.png' class='r'>�Ҧ���Ƨ��w�פJ.";
		} else {
			session.setAttribute("crewLindAL",dataAL);
			status = true;
		}
	
	} catch (Exception e) {
		status = false;
		errMsg = "<img src='../../images/messagebox_warning.png'  class='r'>ERROR:"+e.getMessage();
	}
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>��ƶפJ--��ܩ|���פJ���</title>
<link rel="stylesheet" type="text/css" href="../../../style/style1.css">

<link rel="stylesheet" type="text/css" href="../../lightColor.css">
<link rel="stylesheet" type="text/css" href="../../../style/kbd.css">
<link rel="stylesheet" type="text/css" href="../../../style/loadingStatus.css">
<style type="text/css">
.l{margin-left:0.5em;} .r{margin-right:0.5em;}
</style>
</head>

<body>
<%
if(!status){

%>
<div class="paddingTopBottom bgLYellow red center"><%=errMsg%></div>
<%

}else{
//��ܸ��
%>
<script language="javascript" type="text/javascript">
function chkForm(){
	if(confirm("�T�w�n��J��ơH")){
		document.getElementById("s1").disabled=true;
		document.getElementById("showMessage").className="showStatus4";
		return true;
	}else{
		return false;
	}
}
</script>
<fieldset style="width:600pt; ">
<legend class="blue"><img src="../../images/database_save.gif" width="16" height="16">�פJ�խ��a���p�����

</legend>

<form name="form1" method="post" action="exportData.jsp" onSubmit="return chkForm()">
<table width="100%"  border="1" cellspacing="2" cellpadding="2" class="tableStyle1">
<caption class="red">�ثe���H�U��ƫݧ�s</caption>
<tr class="bgLBlue3 center">
	<td width="14%">���O</td>

  <td width="15%">�խ����u��</td>
	<td width="21%" height="24">�a�ݩm�W</td>
	<td width="21%">�a�ݤ��</td>
	<td width="29%">�ӽЮɶ�</td>
	</tr>
<%
	for(int i=0;i<dataAL.size();i++){
		CrewKindredObj  obj = (CrewKindredObj)dataAL.get(i);
%>
<tr class="center<%if(i%2==1){%> bgLBlue<%}%>">
  <td><%
  if(obj.getDelete_ind() == null){
  %>
  <img src="../../images/cancel_16x16.png" width="16" height="16" title="�ӽЧR���p���H" alt="�ӽЧR���p���H">
  <%
  }else{
  %>
  <img src="../../images/accept.png" width="16" height="16" title="�ӽЧ�s���" alt="�ӽЧ�s���">
  <%
  
  }
  %></td>

  <td ><%=obj.getEmpno()%></td>
  <td class="left"><%=obj.getKindred_surName()+"&nbsp;"+obj.getKindred_First_Name()%></td>
  <td><%=obj.getKinddred_Phone_Num()%></td>
  <td><%=formatter.format(obj.getApply_time())%></td>
  </tr>
<%
}
%>
<tr >
  <td colspan="5" class="center"><input type="submit" id="s1" value="��s���" class="kbd bold"><br>
<div id="showMessage" class="hiddenStatus"><img src="../../images/ajax-loader1.gif" width="15" height="15">Loading....</div></td>
  </tr>

</table>
</form>
</fieldset>

<%
}
%>
</body>
</html>
