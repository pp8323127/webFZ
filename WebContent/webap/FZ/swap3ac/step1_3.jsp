<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*"  %>
<%
//2011/12/07 因失常單 新增
response.setHeader("Pragma","no-cache"); 
response.setHeader("Cache-Control","no-cache"); 
response.setDateHeader("Expires", 0); 
//2011/12/07 因失常單 新增

//String aEmpno = (String)session.getAttribute("userid");
String aEmpno = request.getParameter("aEmpno");
String rEmpno = request.getParameter("rEmpno");
String year   = request.getParameter("year");
String month   = request.getParameter("month");

session.setAttribute("aEmpno",aEmpno);
session.setAttribute("rEmpno",rEmpno);

fzac.CrewInfo c = new fzac.CrewInfo(rEmpno);
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

	 if ("TPE".equals(obj.getBase())) {
		//台北組員換班
		status = true;
	}else if ("KHH".equals(obj.getBase())) {
		//高雄組員換班
		status = false;
		errMsg = "不得申請與其他 Base 組員換班.";

	}  else {
		status = false;
		errMsg = "尚未開放外站組員使用換班功能.";
	}

} else {
	status = false;
	errMsg = rEmpno +" 非有效員工號.";

}

//是否禁止換班
swap3ac.ApplyCheck ac = new swap3ac.ApplyCheck();
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
<div   style="color:#BB0000; font-weight:bold; width:150pt; text-align:center; padding:2pt; top: 78px; right: 10px; position: absolute; left: 378px;"><img src="Indicator.gif" width="16" height="16"> 資料載入中...請稍候</div>
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