<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=big5" language="java" import="credit.*,java.text.*"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String userid = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || userid == null) 
{		//check user session start first
	response.sendRedirect("../../preCheckAC.jsp");
} 
ArrayList fullAttendAL = new ArrayList();
session.setAttribute("fullAttendAL", null);
FullAttendanceForPickSkj faps = new FullAttendanceForPickSkj(userid);
//faps.getCheckRange();
//fullAttendAL = faps.getFullAttendanceRange();
//faps.getCheckRange2();

SimpleDateFormat f = new SimpleDateFormat("yyyy/MM/dd");
GregorianCalendar cal1 = new GregorianCalendar();//now
String today = f.format(cal1.getTime());        

//faps.getCheckRange2();
faps.getCheckRange3();//since 2012/09/01
fullAttendAL = faps.getFullAttendanceRange2();

session.setAttribute("fullAttendAL", fullAttendAL);
%>
<html>
<head>
<title>Full Attendance pick Skj</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<meta http-equiv="pragma" content="no-cache">
<link href="menu.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.no_border
{  
border-bottom: 1.5px solid #808080 ;
border-top: 0px solid #FFFFFF ;
border-left: 0px solid #FFFFFF ;
border-right: 0px solid #FFFFFF ;
font-weight: bold;
font-size: 9pt;
}
.style1 {color: #FF0000}
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
<script language="javascript">
function conf()
{	
	var count = 0;
	for (i=0; i<eval(document.form1.length); i++) 
	{
		if (eval(document.form1.elements[i].checked)) 
		{
			count++;
		}
	}

	if(count < 1 ) 
	{
		alert("請至少勾選一個全勤資格換取選班機會!!");
		return false;
	}
	else
	{
		if (eval(document.form1.elements[0].checked)== false && eval(document.form1.length) >= 2)
		{
			alert("請勾選最快失效的全勤選項!!");
			return false;
		}
		document.form1.Submit.disabled=1;

		if(	confirm("確認全勤選班申請？"))
		{
			return true;
		}
		else
		{
			document.form1.Submit.disabled=0;
			return false;
		}
	}
}
</script>

</head>
<body bgcolor="#FFFFFF" text="#000000">
<div width="90%" align="center">
    <font face="Comic Sans MS" color="#003399">可全勤選班權利</font>
</div>
<div align="center">
<form name="form1" action="upd_fullattend_step0.jsp" onSubmit="return conf();">
    <table width="90%" border="1" cellspacing="0" cellpadding="0">
	  <tr>
	    <td class="tablehead3" align="center" >次序</td>
	    <td class="tablehead3" align="center" >全勤起始日</td>
	    <td class="tablehead3" align="center" >全勤結束日</td>
	    <td class="tablehead3" align="center" >備註</td>
	    <td class="tablehead3" align="center" >&nbsp;</td>
	  </tr>
<%
	for(int i=0; i<fullAttendAL.size(); i++)
	{
		FullAttendanceForPickSkjObj obj = (FullAttendanceForPickSkjObj) fullAttendAL.get(i);
%>
	  <tr>
	    <td class="txtblue" align="center"><%=i+1%></td>
	    <!--<td class="txtblue" align="center"><%=obj.getCheck_range_final_end()%></td>
	    <td class="txtblue" align="center"> <%=obj.getCheck_range_start()%></td>-->
	    <td class="txtblue" align="center"><%=obj.getCheck_range_start()%></td>
	    <td class="txtblue" align="center"> <%=obj.getCheck_range_final_end()%></td>
	    <td class="txtblue" align="center" >&nbsp;<%=obj.getComments()%></td>
		<td align= "center"><input name="chkItem" type="checkbox" id="chkItem" value="<%=i%>"></td>
	  </tr>
<%		
	}
if (fullAttendAL.size()<=0)
{
%>
	  <tr>
	    <td colspan = "5" align="center" class="txtxred" bgcolor=#CCCCFF>N/A</td>
	  </tr>

<%
}
%>
   </table>
<%
if (fullAttendAL.size()>0)
{
%>
	<br>
	<table width="90%" border="0" cellpadding="0" cellspacing="0" align= "center">
	  <tr align="center">
		<td>
	      <div align="center">
	        <input type="submit"  name="Submit" id="Submit" value="申請" >			
        </div></td>
	  </tr>
	</table>
<%
}
%>
</form>
</div>
<table width="90%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr height ="20">
	<td><font face="Comic Sans MS" class="txtxred" >* 本系統資料係取自於2006年5月份啟用之AirCrews 數據，若對全勤選班資格有異議者,請至組上辦理。</font></td>
  </tr>
</table>
</div>
<hr width="90%">
<div align="center">
<%
ArrayList objAL = new ArrayList();
SkjPickList spl = new SkjPickList();
spl.getSkjPickList("ALL",userid);
objAL = spl.getObjAL();
%>
</div>
<div width="90%" align="center">
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
    <table width="90%" border="0" cellspacing="0" cellpadding="0">
	  <tr height ="20">
	    <td><font face="Comic Sans MS" class="txtxred" >* 申請後,請盡速至簽派進行選班事宜</font></td>
	  </tr>	  
    </table>
</div>
</body>
</html>

