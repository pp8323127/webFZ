<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="eg.zcrpt.*"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
//�y�������i--�e�X���i
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
<title>Send Report(�s����Z)</title>
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
//�P�_�O�_���խ��W��
if(crewListobjAL ==null | crewListobjAL.size()<=0)
{
	String astring = "�Х��s��խ��W��õ�����!";
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
//�P�_score = 1, 2, 3, 9, 10�O�_���w��JGDDetail(�Үֶ���)
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
		String astring = "�խ�"+ zccrewobj.getEmpno()+" "+zccrewobj.getSern()+" "+zccrewobj.getCname()+" ���O���Үֶ��� !";
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
  ���i�w�x�s�A�i�A�׭ק�C  <br>
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
	var msg = "�нT�{�A���Z���w�L���󲧱`�ƶ��A�åߧY�e�X���i?\n\n";
	msg +="1.�Y���Z���L���`�ƶ��A�Ы��u�T�w�v�A�e�X���i\n"
	msg +="2.�Y���Z�������󲧱`�ƶ��A�Ы���������A�I��Edit Flt Irregularity.\n";
	msg +="3.���i�@�g�e�X�A�L�k���.\n";
	<%
	if(	ifpasschk == false)
	{
	%>
	alert("�|���d�ֶ��إ���J,���o�e�X.");
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
//egtcflt���|��������....�୶��flightcrew�A�i�JPartI  Report
if(ifpasschk == false)
{
	out.print("alert('���i�|����g�����A���o�e�X!!');");
}
%>
</script>
</body>
</html>
<%
}	
%>