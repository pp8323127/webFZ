<%@ page language="java" contentType="text/html; charset=BIG5"
	pageEncoding="BIG5"%>
<%@page import="java.sql.*,ci.db.*,fzac.*"%>
<%
String userid = (String)session.getAttribute("userid");
fzac.CrewInfo c = new fzac.CrewInfo(userid);
fzac.CrewInfoObj obj = null;
if (c.isHasData()) {

	obj = c.getCrewInfo();
}

String goPageMain = "";
String goPageTop = "";
String errMsg = "";
boolean status = false;
if (obj != null && "N".equals(obj.getFd_ind())) {
	//���խ��򥻸��,�B���῵�խ�

	if ("TPE".equals(obj.getBase())) {
		//�x�_�խ����Z
		status = true;		
		goPageTop = "swap3ac/swapRdQuery.jsp";
		goPageMain="swap3ac/swapRd.jsp";

	}
	 else if ("KHH".equals(obj.getBase())) {
		//�����խ����Z
		status = true;
		goPageTop = "swapkhh/swapRdQuery.jsp";
		goPageMain="swapkhh/swapRd.jsp";

	} 
	
	else {
		status = false;
		errMsg = "�|���}��~���խ��ϥδ��Z�\��.";
	}

} else {
	status = false;
	errMsg = "�z�L�v���ϥδ��Z�\��";

}

if (!status) {
%>
<div style="background-color:#99FFFF;
		color:#FF0000;
		font-family:Verdana;
		font-size:10pt;padding:5pt;
		text-align:center; "><%=errMsg%></div>
<%
}else{
%>
<script language="javascript" type="text/javascript">
	parent.mainFrame.location.href="<%=goPageMain%>";
	parent.topFrame.location.href="<%=goPageTop%>";
</script>
<%
}
%>