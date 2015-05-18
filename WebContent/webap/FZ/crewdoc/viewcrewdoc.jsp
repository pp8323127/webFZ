<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="eg.crewbasic.*,java.util.*"%>

<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String userid = (String) session.getAttribute("userid") ; //get user id if already login
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
	document.form1.btn.disabled=1;	
	document.form1.btn2.disabled=1;	
	document.form1.action="editcrewdoc.jsp" 
	document.form1.submit();
}

function f_confirm()
{  
	if(confirm("証照資料無誤，送出確認通知?"))
	{
		document.form1.btn.disabled=1;	
		document.form1.btn2.disabled=1;	
		document.form1.action = "correctconifrm.jsp";
		document.form1.submit();
	}
}

</script>
<style type="text/css">
<!--
.style1 {
	font-size: 14pt;
	font-weight: bold;
	color: #FF0000;
}
-->
</style>
</head>
<body>
<p align="center" class="blue">組員証照資料</p>
<form name="form1" method="post">
  <table width="79%" border="1" align="center" cellpadding="1" cellspacing="0" class="tableStyl1">
    <tr> 
      <td width="24%" class="sel3"> <div align="center">繁體姓名</div></td>
      <td class="blue" align="center" ><%=crewobj.getCname()%></td>
      <td width="24%" class="sel3"> <div align="center">簡體姓名</div></td>
      <td class="blue" align="center"><!--<div id="chnname"></div>-->
	   <iframe name="myIframe" id="myIframe" src="<%=nameurl%>" width="80" height="40" frameborder="0" scrolling="no"></iframe>
	  </td>
    </tr>
    <tr> 
      <td  class="sel3"> <div align="center" >員工號</div></td>
      <td width="29%" class="blue" bgcolor="#E6FAFF"><div align="center"><%=userid%></div></td>
      <td width="19%" class="sel3">序號</td>
      <td width="28%" class="blue" bgcolor="#E6FAFF"><div align="center"><%= crewobj.getSern()%></div></td>
    </tr>
<%
	for(int i=0; i<objAL.size(); i++)
	{
		CrewDocObj obj = (CrewDocObj) objAL.get(i);
		String doc_num = obj.getDoc_num();

		if("台胞証".equals(obj.getDoc_type()))
		{
			//if(obj.getDoc_num().length()== 10)
			//{
				//doc_num = obj.getDoc_num().substring(0,8) + "   簽發次數 : "+ //obj.getDoc_num().substring(8) ;
			//}
			//doc_num = doc_num + "(號碼+簽發次數)";
		}

%>
	<tr>
	   <td class="sel3" rowspan="4"> <div align="center"><%=obj.getDoc_type()%></div></td>
	</tr>
<%
	if("台胞証".equals(obj.getDoc_type()))
	{
%>
	<tr>
       <td class="blue"><div align="center">Number</div><div align="center">舊証:首頁右上方含英文字的號碼<br>新証 :頁首右上方號碼+簽發次數(2碼數字) 共10碼數字</div></td>
	   <td colspan="2"><%=doc_num%></td> 
	</tr>
<%
	}
	else
	{
%>
	<tr>
       <td class="blue"> <div align="center">Number</div></td>
	   <td colspan="2"><%=doc_num%></td> 
	</tr>
<%
	}
%>
	<tr>
       <td class="blue"> <div align="center">Issue date</div></td>
	   <td colspan="2"><%=obj.getDoc_issue_date()%></td> 
	</tr>
	<tr>
       <td class="blue"> <div align="center">Expired date</div></td>
	   <td colspan="2"><%=obj.getDoc_due_date()%></td> 
	</tr>
<%
	}	
%>
    <tr> 
      <td height="31" colspan="2" valign="middle" align="right"> 
          <div align="right">
              <input type="button" name="btn" value="更正資訊" class="kbd" onclick="f_submit();">
            &nbsp;&nbsp;&nbsp;
        </div></td>
      <td height="31" colspan="2" valign="middle" align="left"> 
          
          <div align="left">&nbsp;&nbsp;&nbsp;
            <input type="button" name="btn2" value="確認無誤" class="kbd" onclick="f_confirm();">
        </div></td>
    </tr>
  </table>
  <p>
  <table width="79%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td align = "left" rowspan="2" class="red">Note : </td>
	<td class="red"  align="left"><div align="left">X 為無需提供的資訊，其他資訊若有錯誤，請按<input type="button" value="更正資訊" class="kbd">更正。</div></td>
  </tr>
  <tr><td class="red" align="left" ><div align="left">若資訊無誤，請按
          <input type="button" value="確認無誤" class="kbd">回覆
          。</div></td>
  </td>
  </tr>
  </table>
  <!--
 <br>
  <table width="79%" border="0" align="center" cellpadding="0" cellspacing="0" class="fortable">
	<tr>
      <td><p align="center"><span class="red">新版台胞證範例</span></p>
        <p><span class="txtA"><img src="../ngbForm/ipage_1_0.jpg" width="600" height="402"></span></p></td>
    </tr>
  </table>
  -->
</form>
</body>
</html>
<%
}	
%>