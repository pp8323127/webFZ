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
<title>�խ����Ӹ��</title>
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
	if(confirm("���Ӹ�ƵL�~�A�e�X�T�{�q��?"))
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
<p align="center" class="blue">�խ����Ӹ��</p>
<form name="form1" method="post">
  <table width="79%" border="1" align="center" cellpadding="1" cellspacing="0" class="tableStyl1">
    <tr> 
      <td width="24%" class="sel3"> <div align="center">�c��m�W</div></td>
      <td class="blue" align="center" ><%=crewobj.getCname()%></td>
      <td width="24%" class="sel3"> <div align="center">²��m�W</div></td>
      <td class="blue" align="center"><!--<div id="chnname"></div>-->
	   <iframe name="myIframe" id="myIframe" src="<%=nameurl%>" width="80" height="40" frameborder="0" scrolling="no"></iframe>
	  </td>
    </tr>
    <tr> 
      <td  class="sel3"> <div align="center" >���u��</div></td>
      <td width="29%" class="blue" bgcolor="#E6FAFF"><div align="center"><%=userid%></div></td>
      <td width="19%" class="sel3">�Ǹ�</td>
      <td width="28%" class="blue" bgcolor="#E6FAFF"><div align="center"><%= crewobj.getSern()%></div></td>
    </tr>
<%
	for(int i=0; i<objAL.size(); i++)
	{
		CrewDocObj obj = (CrewDocObj) objAL.get(i);
		String doc_num = obj.getDoc_num();

		if("�x�M��".equals(obj.getDoc_type()))
		{
			//if(obj.getDoc_num().length()== 10)
			//{
				//doc_num = obj.getDoc_num().substring(0,8) + "   ñ�o���� : "+ //obj.getDoc_num().substring(8) ;
			//}
			//doc_num = doc_num + "(���X+ñ�o����)";
		}

%>
	<tr>
	   <td class="sel3" rowspan="4"> <div align="center"><%=obj.getDoc_type()%></div></td>
	</tr>
<%
	if("�x�M��".equals(obj.getDoc_type()))
	{
%>
	<tr>
       <td class="blue"><div align="center">Number</div><div align="center">�µ�:�����k�W��t�^��r�����X<br>�s�� :�����k�W�踹�X+ñ�o����(2�X�Ʀr) �@10�X�Ʀr</div></td>
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
              <input type="button" name="btn" value="�󥿸�T" class="kbd" onclick="f_submit();">
            &nbsp;&nbsp;&nbsp;
        </div></td>
      <td height="31" colspan="2" valign="middle" align="left"> 
          
          <div align="left">&nbsp;&nbsp;&nbsp;
            <input type="button" name="btn2" value="�T�{�L�~" class="kbd" onclick="f_confirm();">
        </div></td>
    </tr>
  </table>
  <p>
  <table width="79%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td align = "left" rowspan="2" class="red">Note : </td>
	<td class="red"  align="left"><div align="left">X ���L�ݴ��Ѫ���T�A��L��T�Y�����~�A�Ы�<input type="button" value="�󥿸�T" class="kbd">�󥿡C</div></td>
  </tr>
  <tr><td class="red" align="left" ><div align="left">�Y��T�L�~�A�Ы�
          <input type="button" value="�T�{�L�~" class="kbd">�^��
          �C</div></td>
  </td>
  </tr>
  </table>
  <!--
 <br>
  <table width="79%" border="0" align="center" cellpadding="0" cellspacing="0" class="fortable">
	<tr>
      <td><p align="center"><span class="red">�s���x�M�ҽd��</span></p>
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