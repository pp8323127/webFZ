<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*"  %>
<%

String aEmpno = (String)session.getAttribute("userid");
String rEmpno = request.getParameter("rEmpno");
String year   = request.getParameter("year");
String month   = request.getParameter("month");
session.setAttribute("aEmpno",aEmpno);
session.setAttribute("rEmpno",rEmpno);

fzac.CrewInfo c = new fzac.CrewInfo(rEmpno);
fzac.CrewInfoObj obj = null;
if (c.isHasData()) {

	obj = c.getCrewInfo();
}

String goPage = "";
String errMsg = "";
boolean status = false;
if (obj != null && "N".equals(obj.getFd_ind())) {
	//���խ��򥻸��,�B���῵�խ�

	 if ("KHH".equals(obj.getBase())) {
		//�����խ����Z
		status = true;
	}else if ("TPE".equals(obj.getBase())) {
		//�x�_�խ����Z
		status = false;
		errMsg = "���o�ӽлP��L Base �խ����Z.";

	}  else {
		status = false;
		errMsg = "�|���}��~���խ��ϥδ��Z�\��.";
	}

} else {
	status = false;
	errMsg = rEmpno +" �D���ĭ��u��.";

}

//�O�_�T��Z
swap3ackhh.ApplyCheck ac = new swap3ackhh.ApplyCheck();
ac.swapRulesCheck(aEmpno, rEmpno, year, month) ;
if(ac.isNoSwap())
{
	status = false;
	errMsg = ac.getNoSwapStr();
}
//***********************************************

if (!status) {
%>
<div style="background-color:#99FFFF;
		color:#FF0000;
		font-family:Verdana;
		font-size:10pt;padding:5pt;
		text-align:center; "><%=errMsg%><br>
<a href="javascript:history.back(-1);">Back</a>
</div>
<%

	
} else {
%>
<div   style="color:#BB0000; font-weight:bold; width:150pt; text-align:center; padding:2pt; top: 78px; right: 10px; position: absolute; left: 378px;"><img src="Indicator.gif" width="16" height="16"> ��Ƹ��J��...�еy��</div>
<form name="form1" action="step2.jsp" method="post" target="_self">
	<input type="hidden" name="year" value="<%=year%>">
	<input type="hidden" name="month" value="<%=month%>">
	<input type="hidden" name="aEmpno" value="<%=aEmpno%>">
	<input type="hidden" name="rEmpno" value="<%=rEmpno%>">
</form>
<script language="javascript" type="text/javascript">
	document.form1.submit();
</script>
<%
}
%>