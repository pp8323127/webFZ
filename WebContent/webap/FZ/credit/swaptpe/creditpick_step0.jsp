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
%>
<html>
<head>
<title>Credit pick Skj</title>
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
			if(eval("document.form1.count"+eval(document.form1.elements[i].value)+".value") == "其它選班單")
			{
				count = count + 3;
			}
			else
			{
				count++;
			}
		}
	}

	if(count < 3) 
	{
		alert("請勾選三個積點換取選班機會!!");
		return false;
	}
	else if(count > 3) 
	{
		alert("請勾選三個積點換取選班機會 或 勾選一個選班單!!");
		return false;
	}
	else
	{
		document.form1.Submit.disabled=1;

		if(	confirm("確認積點選班申請？"))
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
<form name="form1" action="creditPickRequest.jsp" onSubmit="return conf()">
<div width="80%" align="center">
    <font face="Comic Sans MS" color="#003399">可使用積點選班權利</font>
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

%>
	  <tr bgcolor='<%=trbgcolor%>' class="txtblue">
		  <td><%=i+1%></td>
		  <td><%=obj.getEmpno()%>(<%=obj.getSern()%>)</td>
		  <td><%=obj.getCname()%></td>
		  <td><%=obj.getReason()%></td>
		  <td>&nbsp;<%=obj.getEdate()%></td>
		  <td align= "center"><input name="count<%=obj.getSno()%>" type="hidden" id="count<%=obj.getSno()%>" value="<%=obj.getReason()%>"><input name="chkItem" type="checkbox" id="chkItem" value="<%=obj.getSno()%>"></td>
      </tr>
<%
}//for (int i=0; i<objAL()-1 ; i++)
%>
<%
if (objAL.size()<=0)
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
if(objAL.size()>0)
{
%>
	<br>
	<table width="80%" border="0" cellpadding="0" cellspacing="0" align= "center">
	  <tr align="center">
		<td>
	      <div align="center">
	        <input name="Submit" type="submit" value="申請" >			
        </div></td>
	  </tr>
	</table>
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