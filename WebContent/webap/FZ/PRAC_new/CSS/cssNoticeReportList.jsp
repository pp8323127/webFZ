<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.util.*,eg.css.*" %>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) 
{		
	response.sendRedirect("../logout.jsp");
}

String syy	= request.getParameter("syy");
String smm	= request.getParameter("smm");
String eyy	= request.getParameter("eyy");
String emm	= request.getParameter("emm");
String bgColor = "";
%> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>CSS�^�аO��</title>
<style type="text/css">
<!--
.txtblue {
	font-size: 12px;
	line-height: 13.5pt;
	color: #464883;
	font-family:  "Verdana";
}
.fortable{
	border: 1pt solid;
 }
.tablehead3 {
	font-family: "Arial", "Helvetica", "sans-serif";
	background-color: #006699;
	font-size: 10pt;
	text-align: center;
	font-style: normal;
	font-weight: normal;
	color: #FFFFFF;	
}
.style2 {font-size: 16px; line-height: 13.5pt; color: #464883; font-family: "Verdana"; }
-->
</style>
<script language=javascript>
function subwinXY(w,wname,wx,wy){	//�]�w�}�l���������e�A�}�Ҧ�m�b�ù������A�ۭq�}�Ҥj�p
//	wx = 750,wy=210;	
	x =(screen.width - wx) /2;
	y = (screen.height - wy) /2;
	window.open(w,wname,"left="+x+",top="+y+",width="+wx+",height="+wy+",resizable=yes,scrollbars=yes");
}
</script>
</head>

<body>
<table width="95%"  border="0" align="center" cellpadding="2" cellspacing="0">
  <tr>
    <td width="60%">
      <div align="right"><span class="style2">�wñ�\�ȫȨӨ�O���d�� </span></div>
    </td>
	<td><div align="right"><a href="javascript:window.print()"><img src="../../images/print.gif" width="17" height="15" border="0" alt="�C�L"></a></div></td>
  </tr>
</table>
<table width="95%"  border="1" align="center" cellpadding="1" cellspacing="1" class="fortable"> 
	<tr class="txtblue">
	  	<td align="center" class="tablehead3"><strong>#</strong></div></td>
	  	<td align="center" class="tablehead3"><strong>��Z���</strong></div></td>
	  	<td align="center" class="tablehead3"><strong>��Z�s��</strong></div></td>
		<td align="center" class="tablehead3"><strong>��Z�Ϭq</strong></div></td>
    	<td align="center" class="tablehead3"><strong>���פ��</strong></div></td>
    	<td align="center" class="tablehead3"><strong>ñ�\���</strong></div></td>
    	<td align="center" class="tablehead3"><strong>�׸�</strong></div></td>
	</tr>
<%
PURCSSConfirm ccr =  new PURCSSConfirm();
ccr.getConfirmedCSS(userid,syy+smm,eyy+emm);
ArrayList cssobjAL = ccr.getObjAL();
if(cssobjAL.size() >0)
{
	for(int j=0; j<cssobjAL.size(); j++)
	{
		NoticeCSSCloseObj obj  = (NoticeCSSCloseObj) cssobjAL.get(j);

		if(j %2 == 0)
		{
			bgColor="#FFFFFF";		
		}
		else
		{
			bgColor="#ADD8E6";			
		}
%>
		<tr class="txtblue" bgcolor="<%=bgColor%>">
			<td  align="center"><%=(j+1)%></td>
			<td  align="center"><%=obj.getFltd()%></td>
			<td  align="center"><%=obj.getFltno()%></td>
			<td  align="center"><%=obj.getSect()%></td>
			<td  align="center"><%=obj.getClose_date()%></td>
			<td  align="center"><%=obj.getConfirm_date()%></td>
			<td  align="center">
			<a href="#" class="style9"  onClick="subwinXY('viewCssNoticeReport.jsp?caseno=<%=obj.getCaseno()%>','CSS','800','500')"><%=obj.getCaseno()%></a></td>
		</tr>
<%
	}
}
else
{
%>
	<tr class="txtblue">
	  	<td  align="center" colspan="7">NO DATA FOUND!!</td>
	</tr>
<%
}
%>
</table>
</body>
</html>
