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
	//有組員基本資料,且為後艙組員

	if ("TPE".equals(obj.getBase()) |"TSA".equals(obj.getBase())) {
		//台北組員換班
		status = true;
		if("r1".equals(pick))//全勤選班申請
		{
			goPage = "swaptpe/fullattend_step0.jsp";
		}
		else if("r2".equals(pick)) //積點選班申請
		{
			goPage = "swaptpe/creditpick_step0.jsp";
		}
		else//r3 積點換選班申請
		{
			//goPage = "swaptpe/creditswap_step0.jsp";

			//check if reach max quota
			swap3ac.ApplyCheck ac = new swap3ac.ApplyCheck();
			ac.SelectDateAndCount();
			if( ac.isLimitedDate())
			{//非工作日
				status = false;
				errMsg = "系統目前不受理換班，請於"+ac.getLimitenddate()+"後開始遞件<BR>可能原因為：1.例假日2.緊急事故(颱風)";
			}
			else if( ac.isOverMax())
			{ //超過處理上限
				status = false;
				errMsg = "已超過系統單日處理上限！";			
			}
			else
			{
				goPage = "swaptpe/creditswap_step0.jsp";
			}
		}
	}
	 else if ("KHH".equals(obj.getBase())) 
	 {
		//高雄組員換班
		status = true;
		if("r1".equals(pick))//全勤選班申請
		{
			goPage = "swapkhh/fullattend_step0.jsp";
		}
		else if("r2".equals(pick)) //積點選班申請
		{
			goPage = "swapkhh/creditpick_step0.jsp";
		}
		else//r3 積點換選班申請
		{
			//goPage = "swapkhh/creditswap_step0.jsp";
			//check if reach max quota
			swap3ackhh.ApplyCheck ac = new swap3ackhh.ApplyCheck();
			ac.SelectDateAndCount();

			if( ac.isLimitedDate())
			{//非工作日
				status = false;
				errMsg = "系統目前不受理換班，請於"+ac.getLimitenddate()+"後開始遞件<BR>可能原因為：1.例假日2.緊急事故(颱風)";
			}
			else if( ac.isOverMax())
			{ //超過處理上限
				status = false;
				errMsg = "已超過系統單日處理上限！";			
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
		errMsg = "尚未開放外站組員使用選換班功能.";
	}

} else {
	status = false;
	errMsg = "您無權限使用換班功能";

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