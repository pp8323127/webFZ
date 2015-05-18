<%@ page language="java" contentType="text/html; charset=BIG5"
	pageEncoding="BIG5"%>
<%@page import="java.sql.*,ci.db.*,fzac.*"%>
<%
String userid = (String)session.getAttribute("userid");
//Betty add on 2008/04/15*******************
if (session.isNew() || userid == null) 
{
	response.sendRedirect("sendredirect.jsp");
}
//*******************
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
	//有組員基本資料,且為後艙組員

	if ("KHH".equals(obj.getBase())) {
		//高雄組員換班
		status = true;
		goPageTop = "blank.htm";
		goPageMain="swapkhh/crossCrQueryStep1.jsp";

	} else 
	/*if ("TPE".equals(obj.getBase())) */
	{
		//台北組員換班
		status = true;		
		goPageTop = "blank.htm";
		goPageMain="AC/crossCrQueryStep1.jsp";

	}/*
	  
	
	else {
		status = false;
		errMsg = "尚未開放外站組員使用飛時試算功能.";
	}*/

} else {
	status = false;
	errMsg = "您無權限使用本功能";

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