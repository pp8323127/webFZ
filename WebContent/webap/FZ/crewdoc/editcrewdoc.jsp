<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="eg.crewbasic.*,java.util.*"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String userid =(String) session.getAttribute("userid") ; 
if (session.isNew() || userid == null) 
{		//check user session start first or not login
 %>
 <jsp:forward page="../sendredirect.jsp" /> 
<%
} 
else
{
CrewDoc cd = new CrewDoc(userid);
ArrayList objAL = new ArrayList();
objAL = cd.getObjAL();

eg.EGInfo egi = new eg.EGInfo(userid);
eg.EgInfoObj crewobj = egi.getEGInfoObj(userid); 

String userip = request.getRemoteAddr();
String nameurl = null;
if("192.168".equals(userip.substring(0,7)) | "10.16".equals(userip.substring(0,5)))
{
	nameurl = "http://tpecsap03.china-airlines.com/outstn/chnnamecii.aspx?empno="+userid;
}
else
{
	nameurl = "http://ocskj.china-airlines.com/live/outstn/chnnamecii.aspx?empno="+userid;
}

%>
<html>
<head>
<title>組員証照資料</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="../style.css" rel="stylesheet" type="text/css">
<link href="../style2.css" rel="stylesheet" type="text/css">
<link href="../kbd.css" rel="stylesheet" type="text/css">
<script language="JavaScript">
function f_submit()
{  
	document.form1.Submit.disabled=1;	

	 if(confirm("送出修改後之証照資訊?"))
	 {
		return true;
	 }
	 else
	 {
		document.getElementById("Submit").disabled=0;
		return false;
	 }
}
</script>
</head>
<body onload="getChnName();">
<p align="center" class="blue">組員証照資料</p>
<form name="form1" method="post" action="updcrewdoc.jsp" onsubmit="return f_submit();">
  <table width="79%" border="1" align="center" cellpadding="1" cellspacing="0" class="tableStyl1">
    <tr> 
      <td width="24%" class="sel3"> <div align="center">繁體姓名</div></td>
      <td class="blue" align="center" ><%=crewobj.getCname()%></td>
      <td width="24%" class="sel3"> <div align="center">簡體姓名</div></td>
      <td class="blue" align="center" >	   
	  <iframe name="myIframe" id="myIframe" src="<%=nameurl%>" width="80" height="40" frameborder="0" scrolling="no"></iframe></td>
    </tr>
    <tr> 
      <td  class="sel3"> <div align="center" >
          Employee No</div></td>
      <td width="29%" class="blue" bgcolor="#E6FAFF"><div align="center"><%= userid%></div></td>
      <td width="19%" class="sel3">
        Serial No </td>
      <td width="28%" class="blue" bgcolor="#E6FAFF"><div align="center"><%= crewobj.getSern()%></div></td>
    </tr>
<%
	for(int i=0; i<objAL.size(); i++)
	{
		CrewDocObj obj = (CrewDocObj) objAL.get(i);
%>
	<tr>
	   <td class="sel3" rowspan="4"> <div align="center"><%=obj.getDoc_type()%></div></td>
	   <input type="hidden" name="doc_type<%=i%>" value="<%=obj.getDoc_type()%>">
	</tr>
<%
	if("台胞証".equals(obj.getDoc_type()))
	{
%>
	<tr>
       <td class="blue"><div align="center">Number</div><div align="center">舊証:首頁右上方含英文字的號碼<br>新証 :本年度內頁多簽十個數字的通行證號碼</div></td>
<%
	}
	else
	{
%>
	<tr>
       <td class="blue"><div align="center">Number</div></td>
<%
	}
%>
	   <td colspan="2"><input type="text" name="num<%=i%>" id="num<%=i%>" class="txtblue" size="15" maxlength="15"  value="<%=obj.getDoc_num()%>"></td> 
	   <input type="hidden" name="oldnum<%=i%>" value="<%=obj.getDoc_num()%>">
	</tr>
	<tr>
       <td class="blue"> <div align="center">Issue date</div></td>
	   <td colspan="2"><input type="text" name="issuedt<%=i%>" id="issuedt<%=i%>" class="txtblue" size="10" maxlength="10"  value="<%=obj.getDoc_issue_date()%>"></td> 
	   <input type="hidden" name="oldissuedt<%=i%>" value="<%=obj.getDoc_issue_date()%>">
	</tr>
	<tr>
       <td class="blue"> <div align="center">Expired date</div></td>
	   <td colspan="2"><input type="text" name="duedt<%=i%>" id="duedt<%=i%>" class="txtblue" size="10" maxlength="10"  value="<%=obj.getDoc_due_date()%>"></td> 
	   <input type="hidden" name="oldduedt<%=i%>" value="<%=obj.getDoc_due_date()%>">
	</tr>
<%
	}	
%>
    <tr > 
      <td width="24%" class="sel3"> <div align="center">
          Memo</div></td>
      <td colspan="3" class="blue" align="center" ><textarea name="memo" cols="40" rows="4"></textarea></td>
    </tr>
    <tr> 
      <td height="31" colspan="4" valign="middle" align="center"> 
          <input type="submit" name="Submit" value="Submit" class="kbd">
	  </td>
    </tr>
  </table>  
  </form>
  <table width="79%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="50" class="red">Note</span> : </td>
    <td class="red"><div align="left">若繁體或簡體姓名有誤,請於Memo欄位中說明,並主動連絡行政人員修改。</div></td>
  </tr>
  <tr>
	<td >&nbsp; </td>
    <td class="red"><div align="left">其餘資訊若不正確,請直接於欄位中修改並送出正確資訊。</div></td>
  </tr>
  </table>
</body>
</html>
<%
}	
%>