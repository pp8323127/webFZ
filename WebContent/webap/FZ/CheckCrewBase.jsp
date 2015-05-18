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
	//有組員基本資料,且為後艙組員
	if ("TPE".equals(obj.getBase()) | "TSA".equals(obj.getBase())) {
		//台北組員換班
		status = true;
		goPage = "swap3ac/step0.jsp";

	}
	 else if ("KHH".equals(obj.getBase())) {
		//高雄組員換班
		status = true;
		goPage = "swapkhh/step0.jsp";

	} 	
	else 
	{
		status = false;
		errMsg = "尚未開放外站組員使用換班功能.";
	}

} 
else 
{
	status = false;
	errMsg = "您無權限使用換班功能";

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