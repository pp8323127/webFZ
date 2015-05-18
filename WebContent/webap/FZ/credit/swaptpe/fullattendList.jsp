<%@page contentType="text/html; charset=big5" language="java" import="credit.*"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String userid = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || userid == null) 
{		//check user session start first
	response.sendRedirect("../../preCheckAC.jsp");
} 
ArrayList objAL = new ArrayList();
%>
<html>
<head>
<title>Full Attendance Lisst</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="menu.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.navtext { 
width:200px; 
font-size:8pt; 
border: 1px solid #fff; 
background-color:#FFCCFF;
color:#39c; 
} 
-->
</style>
<script type="text/javascript" src="../alttxt.js"></script> 
</head>

<body bgcolor="#FFFFFF" text="#000000" align = "center">
<div align="center">
<%
SkjPickList spl = new SkjPickList();
spl.getSkjPickList("ALL",userid);
objAL = spl.getObjAL();
%>
</div>
<div width="80%" align="center">
	<font face="Comic Sans MS" color="#003399">已申請選班紀錄</font>
</div>
<div align="center">
    <table width="90%" border="1" cellspacing="0" cellpadding="0">
	  <tr height ="20">
	    <td class="tablehead3" align="center" colspan= "1">次序</td>
	    <td class="tablehead3" align="center" colspan= "1">員工號</td>
	    <td class="tablehead3" align="center" colspan= "1">姓名</td>
	    <td class="tablehead3" align="center" colspan= "1">資格</td>
	    <td class="tablehead3" align="center" colspan= "1">全勤起始日</td>
	    <td class="tablehead3" align="center" colspan= "1">全勤結束日</td>
	    <td class="tablehead3" align="center" colspan= "1">是否有效</td>
	    <td class="tablehead3" align="center" colspan= "1">申請日</td>
	    <td class="tablehead3" align="center" colspan= "1">是否處理</td>
	    <td class="tablehead3" align="center" colspan= "1">選班資訊</td>
	  </tr>
  <%
int count=0;
if(objAL.size()>0)
{
	String trbgcolor = "";
	for (int i=0; i<objAL.size() ; i++)
	{
		SkjPickObj obj = (SkjPickObj) objAL.get(i);
		if("".equals(obj.getEd_user()) | obj.getEd_user() ==null )
		{
			trbgcolor = "#FFCCFF";
		}
		else
		{
			trbgcolor = "#FFFFFF";
		}

%>
		  <tr bgcolor="<%=trbgcolor%>" class="txtblue" align= "center">
			  <td><%=i+1%></td>
			  <td><%=obj.getEmpno()%>(<%=obj.getSern()%>)</td>
			  <td><%=obj.getCname()%></td>
			  <td><%=obj.getReason()%></td>
			  <td>&nbsp;<%=obj.getSdate()%></td>
			  <td>&nbsp;<%=obj.getEdate()%></td>
			  <td align="center"><%=obj.getValid_ind()%></td>
			  <td><%=obj.getNew_tmst()%></td>
<%
	if("".equals(obj.getEd_user()) | obj.getEd_user() == null)
	{
%>
			  <td align="center">N</td>
<%
	}
	else
	{
%>
			 <td align="center">Y</td>
<%
	}
	
	String getComments = "";
	if(obj.getComments() != null)
	{
		getComments = obj.getComments().replaceAll("\r\n","<br>");
		getComments = getComments.replaceAll("'"," ");
		getComments = getComments.replaceAll("\""," ");
%>
			<td align="center"><a href="#" onmouseover="writetxt('<%=getComments%>')" onmouseout="writetxt(0)"><img src="../../images/red.gif" width="15" height="15" border="0"></a>
			</td>
			<div id="navtxt" class="navtext" style="position:absolute; top:-100px; left:10px; visibility:hidden">
			</div> 
<%
	}
	else
	{
%>
			<td align="center" class= "txtblue">N/A</td>
<%	
	}
%>	 
      </tr>
  <%
	}//for (int i=0; i<objAL()-1 ; i++)
}
else
{
%>
	  <tr>
	  <td colspan="10" align="center" valign="middle" class="btm">No data found!!<td>
	  </tr>
  <%
}
%>
    </table>
</div>

<div align="center">
    <table width="80%" border="0" cellspacing="0" cellpadding="0">
	  <tr height ="20">
	    <td><font face="Comic Sans MS" class="txtxred" >* 請於申請日後30天內至簽派進行選班事宜</font></td>
	  </tr>
    </table>
</div>
</body>
</html>