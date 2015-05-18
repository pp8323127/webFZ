<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="eg.zcrpt.*"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
//座艙長報告--送出報告
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
ArrayList objAL = (ArrayList) session.getAttribute("zcreportobjAL"); 
if ( sGetUsr == null | objAL == null) 
{		//check user session start first or not login
	response.sendRedirect("/webfz/FZ/sendredirect.jsp");
}
else
{
	boolean ifpasschk = true;
	String idx = request.getParameter("idx");
	ZCReportObj obj = (ZCReportObj) objAL.get(Integer.parseInt(idx));
	ArrayList crewListobjAL = new ArrayList();
	crewListobjAL = obj.getZccrewObjAL();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Send Report(存成草稿)</title>
<link href="../style2.css" rel="stylesheet" type="text/css">
<style type="text/css">
body,form,input,select,textarea{
	font-family:Verdana, Arial, Helvetica, sans-serif;
	font-size:10pt;
}

</style>
<script src="../../../MT/js/subWindow.js" language="javascript" type="text/javascript"></script>

<script language="javascript" src="../changeAction.js" type="text/javascript"></script>
</head>

<body>

<%
//判斷是否有組員名單
if(crewListobjAL ==null | crewListobjAL.size()<=0)
{
	String astring = "請先編輯組員名單並給分數!";
	%>
	<script>
		alert("<%=astring%>" );
		location.replace("zcCrewScoring.jsp?idx=<%=idx%>");
	</script>
	<%	
	ifpasschk = false;
}
else
{
//判斷score = 1, 2, 3, 9, 10是否均已輸入GDDetail(考核項目)
for(int i=0; i<crewListobjAL.size(); i++)
{
	ZCReportCrewListObj zccrewobj = (ZCReportCrewListObj) crewListobjAL.get(i);	
	if("".equals(zccrewobj.getScore()) | zccrewobj.getScore()==null)
	{
		zccrewobj.setScore("0");
	}

	if((Integer.parseInt(zccrewobj.getScore()) <=3 && Integer.parseInt(zccrewobj.getScore()) > 0) | Integer.parseInt(zccrewobj.getScore()) >=9)
	{
		int count = zccrewobj.getGradeobjAL().size();
		String astring = "組員"+ zccrewobj.getEmpno()+" "+zccrewobj.getSern()+" "+zccrewobj.getCname()+" 須記錄考核項目 !";
		if(count<=0)
		{
		%>
			<script>
				alert("<%=astring%>" );
				history.back(-1);
			</script>
		<%	
			ifpasschk = false;
		}
	}
}//for(int i=0; i<crewListobjAL.size(); i++)
}
//***********************************************************************
%>
<form name="form1" method="post" action="zcSendReport.jsp"  onSubmit="return warn()">
 <table width="70%" cellpadding="0" cellspacing="1" style="border-collapse:collapse; " align="center">
<caption style="color:#FF0000;font-weight:bold;line-height:1;text-align:center;padding-bottom:0.5em;padding-top:0.5em;">
  報告已儲存，可再度修改。  <br>
 Report is Saved and can be modified!!<br>
</caption>
<tr>
  <td width="13%" height="35">&nbsp;</td>
	<td width="87%" style="text-align:left;">
		<input name="Submit" type="button"  value="Modify Report" onClick="preview('form1','zcCrewScoring.jsp?idx=<%=idx%>')" style="background-color:#F0F8FF; ">&nbsp;&nbsp;&nbsp;
		<input type="button" value="Edit Flt Irregularity"  onClick="preview('form1','zcedFltIrr.jsp?idx=<%=idx%>')" style="background-color:#F0F8FF; ">
	</td>
</tr>
<tr>
  <td height="51">&nbsp;</td>
	<td style="text-align:left;">
	<input type="button" value="View Report"  onClick="javascript:window.open('ZCreport_print.jsp?idx=<%=idx%>')"  style="background-color:#F0F8FF; ">
	</td>
</tr>    
<tr>
  <td>&nbsp;</td>
<td style="text-align:left;">
 <input type="submit" value="Send Report" style="background-color:#FFCCCC; " ></td>
</tr>  
</table>
		<input type="hidden" name="idx" value="<%=idx%>">
 </form>

<script  language="javascript"  type="text/javascript">
function warn()
{
	var msg = "請確認，本班次已無任何異常事項，並立即送出報告?\n\n";
	msg +="1.若本班次無異常事項，請按「確定」，送出報告\n"
	msg +="2.若本班次有任何異常事項，請按取消之後，點選Edit Flt Irregularity.\n";
	msg +="3.報告一經送出，無法更改.\n";
	<%
	if(	ifpasschk == false)
	{
	%>
	alert("尚有查核項目未輸入,不得送出.");
	return false;
	<%	
	}
	else
	{
	%>
		if( confirm(msg))
		{
			return true;
		}
		else
		{
			return false;
		}
	<%
	}
	%>	
}
<%
//if(!goPage.equals("")){
//egtcflt中尚未有紀錄....轉頁至flightcrew，進入PartI  Report
if(ifpasschk == false)
{
	out.print("alert('報告尚未填寫完畢，不得送出!!');");
}
%>
</script>
</body>
</html>
<%
}	
%>