<%@ page language="java" contentType="text/html; charset=BIG5"
	pageEncoding="BIG5"%>
<%@page import="java.sql.*,ci.db.*,fzac.*"%>
<%
String userid = (String)session.getAttribute("userid");
String pick = request.getParameter("pick");

fzac.CrewInfo c = new fzac.CrewInfo(userid);
fzac.CrewInfoObj obj = null;
if (c.isHasData()) {

	obj = c.getCrewInfo();
}

String goPage = "";
String errMsg = "";
boolean status = false;
if (obj != null && "N".equals(obj.getFd_ind())) {
	//���խ��򥻸��,�B���῵�խ�

	if ("TPE".equals(obj.getBase()) |"TSA".equals(obj.getBase())) {
		//�x�_�խ����Z
		status = true;
		if("r1".equals(pick))//���Կ�Z�ӽ�
		{
			goPage = "swaptpe/fullattend_step0.jsp";
		}
		else if("r2".equals(pick)) //�n�I��Z�ӽ�
		{
			goPage = "swaptpe/creditpick_step0.jsp";
		}
		else//r3 �n�I����Z�ӽ�
		{
			//goPage = "swaptpe/creditswap_step0.jsp";

			//check if reach max quota
			swap3ac.ApplyCheck ac = new swap3ac.ApplyCheck();
			ac.SelectDateAndCount();
			if( ac.isLimitedDate())
			{//�D�u�@��
				status = false;
				errMsg = "�t�Υثe�����z���Z�A�Щ�"+ac.getLimitenddate()+"��}�l����<BR>�i���]���G1.�Ұ���2.���ƬG(�䭷)";
			}
			else if( ac.isOverMax())
			{ //�W�L�B�z�W��
				status = false;
				errMsg = "�w�W�L�t�γ��B�z�W���I";			
			}
			else
			{
				goPage = "swaptpe/creditswap_step0.jsp";
			}
		}
	}
	 else if ("KHH".equals(obj.getBase())) 
	 {
		//�����խ����Z
		status = true;
		if("r1".equals(pick))//���Կ�Z�ӽ�
		{
			goPage = "swapkhh/fullattend_step0.jsp";
		}
		else if("r2".equals(pick)) //�n�I��Z�ӽ�
		{
			goPage = "swapkhh/creditpick_step0.jsp";
		}
		else//r3 �n�I����Z�ӽ�
		{
			//goPage = "swapkhh/creditswap_step0.jsp";
			//check if reach max quota
			swap3ackhh.ApplyCheck ac = new swap3ackhh.ApplyCheck();
			ac.SelectDateAndCount();

			if( ac.isLimitedDate())
			{//�D�u�@��
				status = false;
				errMsg = "�t�Υثe�����z���Z�A�Щ�"+ac.getLimitenddate()+"��}�l����<BR>�i���]���G1.�Ұ���2.���ƬG(�䭷)";
			}
			else if( ac.isOverMax())
			{ //�W�L�B�z�W��
				status = false;
				errMsg = "�w�W�L�t�γ��B�z�W���I";			
			}
			else
			{
				goPage = "swapkhh/creditswap_step0.jsp";
			}
		}

	} 	
	else 
	{
		status = false;
		errMsg = "�|���}��~���խ��ϥοﴫ�Z�\��.";
	}

} else {
	status = false;
	errMsg = "�z�L�v���ϥδ��Z�\��";

}

if (status) 
{
	response.sendRedirect(goPage);
	//out.println(goPage+"<br>");
} 
else
{
%>
<div style="background-color:#99FFFF;
		color:#FF0000;
		font-family:Verdana;
		font-size:10pt;padding:5pt;
		text-align:center; "><%=errMsg%></div>
<%
}
%>