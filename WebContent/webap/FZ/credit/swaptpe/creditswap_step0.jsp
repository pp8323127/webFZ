<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=big5" language="java" import="credit.*"%>
<%
//response.setHeader("Cache-Control","no-cache");
//response.setDateHeader ("Expires", 0);
String userid = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || userid == null) 
{		//check user session start first
	response.sendRedirect("../../preCheckAC.jsp");
} 
ArrayList objAL = new ArrayList();
CreditList cl = new CreditList();
cl.getCreditList("N",userid);
objAL = cl.getObjAL();
session.setAttribute("creditListAL",objAL);

boolean display = false;
/**換班當超過上限問題,由頁面再檢測一次**/
boolean status = false;
String errMsg ="";

swap3ac.ApplyCheck ac = new swap3ac.ApplyCheck();
ac.SelectDateAndCount();
if( ac.isLimitedDate())
{//非工作日
	status = false;
	errMsg = "系統目前不受理換班，請於"+ac.getLimitenddate()+"後開始遞件<BR>可能原因為：1.例假日2.緊急事故(颱風)";
}
else if( ac.isOverMax())
{ //超過處理上限
	status = false;
	errMsg = "已超過系統單日處理上限！";			
}else{
	status = true;
}
%>
<html>
<head>
<title>Credit swap Skj</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<meta http-equiv="pragma" content="no-cache">
<link href="menu.css" rel="stylesheet" type="text/css">
<style type="text/css">
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
</style>

<script language="javascript">
function conf()
{	
	var count = 0;
	for (i=0; i<eval(document.form1.length); i++) 
	{
		if (eval(document.form1.elements[i].checked)) 
		{
			count++;
			document.form1.sno.value=document.form1.elements[i].value;
		}
	}

	if(count < 1 | count > 1) 
	{
		alert("請勾選一個積點換取換班機會!!");
		return false;
	}
	else
	{
		document.form1.Submit.disabled=1;

		if(	confirm("確認積點換班申請？"))
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
<form name="form1" action="creditSwap_step1.jsp" onSubmit="return conf()">

<div width="80%" align="center">
    <font face="Comic Sans MS" color="#003399">可使用積點換班權利</font>
</div>
<div align="center">
    <table width="80%" border="1" cellspacing="0" cellpadding="0">
	  <tr  class="tablehead3" align="center" >
	    <td>SEQNO</td>
	    <td>員工號</td>
	    <td>姓名</td>
	    <td>積點原因</td>
	    <td>積點有效日</td>
		<td>&nbsp;</td>
	  </tr>
<%
String trbgcolor = "";
for (int i=0; i<objAL.size() ; i++)
{
	CreditObj obj = (CreditObj) objAL.get(i);
	if(i%2==0)
	{
		trbgcolor = "#FFCCFF";
	}
	else
	{
		trbgcolor = "#FFFFFF";
	}

	if(!"其它選班單".equals(obj.getReason()))
	{
		display = true;
%>
	  <tr bgcolor='<%=trbgcolor%>' class="txtblue">
		  <td><%=i+1%></td>
		  <td><%=obj.getEmpno()%>(<%=obj.getSern()%>)</td>
		  <td><%=obj.getCname()%></td>
		  <td><%=obj.getReason()%></td>
		  <td>&nbsp;<%=obj.getEdate()%></td>
		  <td align= "center"><input name="chkItem" type="checkbox" id="chkItem" value="<%=obj.getSno()%>"></td>
      </tr>
<%
	}
}//for (int i=0; i<objAL()-1 ; i++)
%>
<%
if (display==false)
{
%>
	  <tr>
	    <td colspan = "6" align="center" class="txtxred" bgcolor=#CCCCFF>N/A</td>
	  </tr>

<%
}
%>
  </table>

<%
if(display==true && status)
{
%>
	<br>
    <input name="sno" type="hidden" value="" >
	<table width="80%" border="0" cellpadding="0" cellspacing="0" align= "center">
	  <tr align="center">
		<td>
	      <div align="center">
	        <input name="Submit" type="submit" value="申請" >			
        </div></td>
	  </tr>
	</table>
<%
}else{
%>
<div style="background-color:#99FFFF;
		color:#FF0000;
		font-family:Verdana;
		font-size:10pt;padding:5pt;
		text-align:center; "><%=errMsg%></div>
<%
}
%>
  </form>
</div>
  <!--********************************************************-->
  <hr>
  <iframe src="creditpickList.jsp" width="100%" height="300" align="middle" frameborder="0" scrolling="auto"></iframe>       
  <!--********************************************************-->
</div>
</body>
</html>