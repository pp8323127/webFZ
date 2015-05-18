<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="fz.*,java.sql.*"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
 %>
 <jsp:forward page="sendredirect.jsp" /> 
<%
} 
String comments =request.getParameter("comments");
String comm2 = request.getParameter("comm2");

//是否換全月班表
String mymm = request.getParameter("mymm");

String rempno = request.getParameter("rempno");

applyForm af = new applyForm();

//apply empno and name of a & r


String cname=null;
//String sern=null;
String rcname = null;
//String rsern = null;
int limitdate = af.getLimitDate();
if (limitdate > 0){
%>
	<jsp:forward page="showmessage.jsp">
	<jsp:param name="messagestring" value="系統今日暫停收件，請於工作日00:01開始遞件<BR>可能原因為：1.例假日2.緊急事故(颱風)" />
	<jsp:param name="messagelink" value="Back to previous" />
	<jsp:param name="linkto" value="javascript:history.go(-1);" />
	</jsp:forward>


<%
}

if( !af.checkMax()){
%>
	<jsp:forward page="showmessage.jsp">
	<jsp:param name="messagestring" value="已超過系統單日處理上限！" />
	<jsp:param name="messagelink" value="Back to previous" />
	<jsp:param name="linkto" value="javascript:history.go(-1);" />
	</jsp:forward>



<%
}


//不判斷是否已超過2次
int atimes = af.getApplyTimes(sGetUsr);//applicant
int rtimes = af.getApplyTimes(rempno);//replace
if (atimes == 9 || rtimes == 9)
{
	%>
	<jsp:forward page="showmessage.jsp">
	<jsp:param name="messagestring" value="有申請單未被 ED 確認不可再遞單" />
	<jsp:param name="messagelink" value="Back to previous" />
	<jsp:param name="linkto" value="javascript:history.back(-1);" />
	</jsp:forward>
	<%
}

chkUser ck = new chkUser();

String rs = ck.findCrew(sGetUsr);

if (rs.equals("1"))
{
	cname = ck.getName();
	//sern = ck.getSern();

}
rs = ck.findCrew(rempno);
if (rs.equals("1"))
{
	rcname = ck.getName();
	//rsern = ck.getSern();

}

	
//applicant base information
af.setCrewInfo(sGetUsr, mymm);//groups, qual
String agroups = af.getGroups();
String aqual = af.getQual();
String aprjcr = af.getPrjcr();
String sern = af.getSern();
//replace base information
af.setCrewInfo(rempno, mymm);
String rgroups = af.getGroups();
String rqual = af.getQual();
String rprjcr = af.getPrjcr();
String rsern = af.getSern();
//out.print(rcname+","+rgroups +"," + rsern);
%>
<html>
<head>
<title>Send Crew Duty</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="menu.css" rel="stylesheet" type="text/css">



<style type="text/css">
<!--
.style1 {	font-size: 16px;
	font-weight: bold;
}
.style2 {font-size: 12}
.style3 {color: #FF0000}
.style4 {font-size: 12; color: #FF0000; }

-->
</style>
<script language="JavaScript" type="text/JavaScript">

		function openwindow(){
		newopen=window.open('note.htm','note','height=250,width=470,top=100,left=200');

		}
	function disa(){
		document.form1.Send.disabled=1;
		return true;
	}

</script>
</head>
<body onLoad="openwindow()">
<form name="form1" method="post" action="upd_form.jsp" onsubmit="return disa()">
  <p align="center"><span class="style1">Swap Application Form</span></p>
  <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td width="3%" height="110">&nbsp;</td>
      <td width="94%" class="font1 style2"><p class="style2 style3">The Applicant and
          the Substitute hereby agree to exchange the designated flights as outlined
          in this form, and duly represent the following, </p>
          <ul>
            <li class="style4">Full duty attendance for two consecutive calendar
              months prior to applying </li>
            <li class="style4">All contents present hereunder are in compliance
              with the applicable rules </li>
        </ul></td>
      <td width="3%">
        <div align="right"><a href="javascript:window.print()"> </a> </div></td>
    </tr>
  </table>
  <p align="center"><span class="font1"><font color="#FF0000"></font></span></p>
<br>


  <table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr> 
      <td width="5%">&nbsp;</td>
      <td width="90%" class="font1">&nbsp;</td>
      <td width="5%">
        <div align="right"><a href="javascript:window.print()"> <img src="images/print.gif" width="17" height="15" border="0" alt="列印"></a> 
        </div>
      </td>
    </tr>
  </table>
  <table width="90%"  border="1" cellpadding="0" cellspacing="1" align="center">
    <tr > 
      <td width="18%" class="tablehead2"> 
        <div align="center">說 明 </div>
      </td>
      <td colspan="2" class="tablehead2"> 
        <div align="center">Applicant</div>
      </td>
      <td colspan="2" class="tablehead2"> 
        <div align="center">Substitute</div>
      </td>
    </tr>
    <tr >
      <td class="tablebody"><b><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"> Name
            / Section</font></b></td> 
      <td width="17%" class="tablebody"><%=cname%> 
        <input type="hidden" name="cname" value="<%=cname%>">
      </td>
      <td width="21%" class="tablebody"><%=agroups%> 
        <input type="hidden" name="agroups" value="<%=agroups%>">
      </td>
      <td width="22%" class="tablebody"><%=rcname%> 
        <input type="hidden" name="rcname" value="<%=rcname%>">
      </td>
      <td width="22%" class="tablebody"><%=rgroups%> 
        <input type="hidden" name="rgroups" value="<%=rgroups%>">
      </td>
    </tr>
    <tr >
      <td class="tablebody"><b><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"> ID.
            No. / Serial No </font></b></td> 
      <td width="17%" class="tablebody"><%=sGetUsr%> 
        <input type="hidden" name="sGetUsr" value="<%=sGetUsr%>">
      </td>
      <td width="21%" class="tablebody"><%=sern%> 
        <input type="hidden" name="sern" value="<%=sern%>">
      </td>
      <td width="22%" class="tablebody"><%=rempno%> 
        <input type="hidden" name="rempno" value="<%=rempno%>">
      </td>
      <td width="22%" class="tablebody"><%=rsern%> 
        <input type="hidden" name="rsern" value="<%=rsern%>">
      </td>
    </tr>
    <tr >
      <td class="tablebody"><b><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF">Exchange
            Count</font></b></td> 
      <td colspan="2" class="tablebody"><%=atimes%> 
        <input type="hidden" name="atimes" value="<%=atimes%>">
      </td>
      <td colspan="2" class="tablebody"><%=rtimes%> 
        <input type="hidden" name="rtimes" value="<%=rtimes%>">
      </td>
    </tr>
    <tr class="tablebody">
      <td><b><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF">Qualification</font></b></td> 
      <td colspan="2" class="tablebody"><%=aqual%> 
        <input type="hidden" name="aqual" value="<%=aqual%>">
      </td>
      <td colspan="2" class="tablebody"><%=rqual%> 
        <input type="hidden" name="rqual" value="<%=rqual%>">
      </td>
    </tr>
  </table>
<br>

  <table width="90%"  border="1" cellpadding="0" cellspacing="1" align="center">
    <tr> 
      <td width="23%" class="tablebody"> 
        <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#0000FF">Projected 
          Credit Hour </font></b></font></div>
      </td>
      <td width="15%" class="txttitle"><b>Applicant:</b></td>
      <td width="20%" class="tablebody"><%= aprjcr%> 
        <input type="hidden" name="aprjcr" value="<%= aprjcr%>">
      </td>
      <td width="19%" class="txttitle"><b>Substitute:</b></td>
      <td width="23%" class="tablebody"><%= rprjcr%> 
        <input type="hidden" name="rprjcr" value="<%= rprjcr%>">
      </td>
    </tr>
  </table>
  <br>
  <table width="90%"  border="1" cellpadding="0" cellspacing="1" align="center">
    <tr>
      <td width="24%" class="tablebody"> 
        <div align="left" class="txttitle"><b>Comments</b></div>
      </td>
    <td width="76%" class="tablebody">&nbsp;<%
	if (!comments.equals("")){
		out.print(comm2+"&nbsp;"+comments);
	}
	else{
		out.print("No comments");
	}
	
	%>
      <input type="hidden" name="comments" value="<%=(comm2+comments)%>"></td>
  </tr>
</table>
<div align="center">    <span class="font1"><font color="#FF0000"><strong><br>
    Whole month exchange(全月互換) </strong></font></span>
    <br>
    <br>
    <br>
    <input name="Cancel" type="button"  onClick="javascript:history.back(-1);" value="Cancel" class="btm">
    &nbsp;&nbsp;&nbsp;
    <input name="Send" type="submit" value="Send" class="btm">    
	<input type="hidden" name="checkall" value="Y"><br>
</div>
</form>

</body>
</html>
<script language="JavaScript" type="text/JavaScript">
function showmess(){
alert("Please Query Again！！\n請重新查詢！");
self.location="blank.htm";

}
</script>
