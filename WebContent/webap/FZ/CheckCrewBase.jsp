<%@ page language="java" contentType="text/html; charset=BIG5"
	pageEncoding="BIG5"%>
<%@page import="java.sql.*,ci.db.*,fzac.*"%>
<%
String userid = (String)session.getAttribute("userid");
fzac.CrewInfo c = new fzac.CrewInfo(userid);
fzac.CrewInfoObj obj = null;
if (c.isHasData()) 
{
	obj = c.getCrewInfo();
}

String goPage = "";
String errMsg = "";
boolean status = false;
if (obj != null && "N".equals(obj.getFd_ind())) {
	//���խ��򥻸��,�B���῵�խ�
	if ("TPE".equals(obj.getBase()) | "TSA".equals(obj.getBase())) {
		//�x�_�խ����Z
		status = true;
		goPage = "swap3ac/step0.jsp";

	}
	 else if ("KHH".equals(obj.getBase())) {
		//�����խ����Z
		status = true;
		goPage = "swapkhh/step0.jsp";

	} 	
	else 
	{
		status = false;
		errMsg = "�|���}��~���խ��ϥδ��Z�\��.";
	}

} 
else 
{
	status = false;
	errMsg = "�z�L�v���ϥδ��Z�\��";

}

if (status) {
	response.sendRedirect(goPage);
} else {
%>
<div style="background-color:#99FFFF;
		color:#FF0000;
		font-family:Verdana;
		font-size:10pt;padding:5pt;
		text-align:center; "><%=errMsg%></div>
<%
}
%>