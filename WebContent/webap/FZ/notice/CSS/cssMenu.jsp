<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="java.util.*"%>
<%

String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (sGetUsr == null) {		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} 

String auth = (String)session.getAttribute("auth");
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>旅客來函</title> 
<link href="style2.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
function pageLoad(w1,w2){
		parent.topFrame.location.href=w1;
		parent.mainFrame.location.href=w2;

}
function oldVersion()
{
	top.leftFrame.location = "../fscreen.jsp";
	top.mainFrame.location='blank.htm';
	top.topFrame.location = 'blank.htm';
}


</script>

<style type="text/css">
<!--
body,tr,td{font-family:Verdana, Arial, Helvetica, sans-serif;font-size:10pt;}
.e4 {	background-color: #edf3fe;
	color: #000000;
	text-align: center;}
.bd1{border-bottom:1pt dashed gray;padding-top:2em;font-weight:bold;color:#333333;}	
img{border:0pt;margin-right:0.5em;margin-left:2em;}
.style1 {color: #0000FF}
.style2 {
	color: #FF0000;
	font-weight: bold;
}
-->
</style>
</head>

<body>
<p>&nbsp;</p>
<table width="552" align="center" > 
	<tr>
		<td><span style="font-weight:bold;color:#003366;font-size:larger; " >旅客來函</span></td>
	</tr>
	<tr>
		<td>


<%
	//if("640790".equals(sGetUsr))	
	//{		
		eg.css.PURCSSConfirm ccr =  new eg.css.PURCSSConfirm();
        ccr.getConfirmCSS(sGetUsr);
		ArrayList objAL3 = ccr.getObjAL();
%>
		<p><img src="../../images/viewmag.png" width="16" height="16" align="top"><a href="#" onClick="pageLoad('cssNoticeReportQuery.jsp','../blank.htm')" class="txtblue">檢視已簽閱旅客來函</a>&nbsp;&nbsp;
<%
	    if(objAL3.size()>0)
		{
%>
		( </font><span class="txtxred">請按【檢視完畢】以示完成簽閱 </span><font class="style1">)</font>
<%		
		}

        if(objAL3.size()>0)
		{
%>
	  <table width="80%" border="0"> 
<%
			for(int i=0; i<objAL3.size(); i++)
			{
				eg.css.NoticeCSSCloseObj obj = (eg.css.NoticeCSSCloseObj) objAL3.get(i);   
%>
				<tr><td width="10%">&nbsp;</td>
				<td width="90%" class="txtblue"><img src="../../images/new_0033.gif" width="16" height="16" align="top">&nbsp;<a href="doCaseConfirm.jsp?seq=<%=obj.getSeq()%>&caseno=<%=obj.getCaseno()%>"> <%=obj.getFltd()%> <%=obj.getFltno()%> <%=obj.getSect()%> </a></td>
				</tr>
<%
			}
%>
	  </table>
<%
		}
	//}	
%>
		</td>
	</tr>
</table>
</body>
</html>
