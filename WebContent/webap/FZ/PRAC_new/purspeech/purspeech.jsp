<%@ page contentType="text/html; charset=big5" language="java" import="java.util.*,java.io.*,fz.purspeech.*" %>
<%
/*
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
*/

String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) 
{		
	response.sendRedirect("../sendredirect.jsp");
} 

String formno = request.getParameter("subj");
ArrayList replyAL = new ArrayList();
ArrayList quesAL = new ArrayList();


PurSpeech ps = new PurSpeech();
ps.getAllSubj();
String subject = ps.getSubj(formno); 
String explain = ps.getSubjExpl(formno);
ps.getReply(formno);
quesAL  = ps.getQuesAL();
replyAL = ps.getReplyAL();

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title></title>
<link href="../style3.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
function expl(expid)
{
	if(document.getElementById(expid).style.display=="none")
	{
		document.getElementById(expid).style.display="";
	}	
	else
	{
		document.getElementById(expid).style.display="none";
	}
}

</script>
<style type="text/css">
<!--
.style1 {font-family: Arial, Helvetica, sans-serif}
.style2 {color: #0000FF}
-->
</style>
</head>
<body>
  <div align="center" class="txttitletop">
    <h2><span class="style1"><%=formno.substring(0,4)%>年<%=formno.substring(4,6)%>月份客艙經理發言單查詢</span><br>
    </h2>
</div>
<table width="95%"  border="1" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td colspan="3"><br>
    <span class= "txttitle"> <strong>當月主題 :</strong></span><br>  
		&nbsp;&nbsp;&nbsp;
		<table width="95%"  border="0" align="center">
		<tr align="left">
		<td class= "txtblue"><%=subject%></td>
		</tr>
		</table>
		<br>
	</td>
  </tr>
  <tr>
   <td colspan="3"><br><span class= "txttitle"><strong>背景說明 :</strong></span><br>
		&nbsp;&nbsp;&nbsp;
		<table width="95%"  border="0" align="center">
		<tr align="left">
		<td class= "txtblue"><%=explain.replaceAll("\r\n","<br>")%></td>
		</tr>
		</table>
		<br>
   </td>
  </tr>
  <tr>
   <td colspan="3"><br><span class= "txttitle"><strong>討論點 :</strong></span><br>     
<%
		for(int i = 0; i<quesAL.size(); i++)
		{//for each question
			int first = 1;
			for(int j = 0; j<replyAL.size(); j++)
			{
				PurSpeechObj obj = (PurSpeechObj) replyAL.get(j);
				if(Integer.parseInt((String)quesAL.get(i)) == Integer.parseInt((String)obj.getItemno()))
				{
					if(first == 1)
					{
%>
					&nbsp;&nbsp;&nbsp;
					<table width="95%"  border="0" align="center">
						<tr align="left">
						 <td class= "tablehead5">						 <strong><%=Integer.parseInt((String)quesAL.get(i))%>.<%=obj.getQues()%></strong>
						 </td>
						 <td align="right" width="50" class= "btm"><a href="#" onClick="expl('SubMenu<%=i%>')">Expand/Collapse<!--<img src="fa.gif" width="10" height="10" border="0">--></a>
						 </td>
						</tr>
					</table>

					<div id="SubMenu<%=i%>"  width="95%" align="center" style="display:none;" ><!--*********-->
<%
					}	
%>
					<table width="95%"  border="0" align="center" bgcolor="#C0DDFF" >
					<tr align="left">
					 <td>
						<span class="purple_txt"><strong><%=obj.getEmpno()%>&nbsp;&nbsp;<%=obj.getCname()%>&nbsp;&nbsp;<%=obj.getEname()%></strong></span>
						<br>
						<span class="txtblue">分類 : <%=obj.getItemdsc()%><%=obj.getItemdsc2()%>
						<br>
						<%=obj.getReply().replaceAll("\r\n","<br>")%></span>
						<br>
					 </td>
					</tr>
					</table>
<%
					first ++;
				}//if((String)quesAL.get(i)) ==(String)obj.getItemno())
			}//for(int j = 0; j<replyAL.size(); j++)
%>
		</div><!--*********-->
<%
	    }	//for(int i = 0; i<quesAL.size(); i++)
%>
		<br>
   </td>
  </tr>
</table>
</body>
</html>
