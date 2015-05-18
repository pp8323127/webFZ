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
<link href="style.css" rel="stylesheet" type="text/css">
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

</head>


<body>
<p>&nbsp;</p>
<br>
<center>
<table width="400" border="0" cellspacing="2">
  <tr class="tableInner2">
   <td valign="middle"><div align="left">
<%
		eg.css.PURCSSConfirm ccr =  new eg.css.PURCSSConfirm();
		ccr.getConfirmCSS(sGetUsr,"crew");
		ArrayList objAL = ccr.getObjAL();
%>
		<img src="../../images/viewmag.png" width="16" height="16" align="top">
		<a href="#" onClick="pageLoad('../PRAC/agenda/propAgandaQuery.jsp?gopage=FS','../blank.htm')" class="txtblue">檢視已簽閱旅客來函</a>&nbsp;&nbsp;
<%
		if(objAL.size()>0)
		{
%>
		( </font><span class="txtxred">請按【檢視完畢】以示完成簽閱 </span><font class="style1">)</font>
<%		
		}
		
		if(objAL.size()>0)
		{
%>
	  <table width="80%" border="0"> 
<%
		for(int i=0; i<objAL.size(); i++)
		{
			eg.css.NoticeCSSCloseObj obj = (eg.css.NoticeCSSCloseObj) objAL.get(i);      
%>
				<tr><td width="10%">&nbsp;</td>
				<td width="90%" class="txtblue" align="left">
					<img src="../../images/new_0033.gif" width="16" height="16" align="top">&nbsp;
					<a href="doCaseConfirm.jsp?seq=<%=obj.getSeq()%>&caseno=<%=obj.getCaseno()%>"> <%=obj.getFltd()%> <%=obj.getFltno()%> <%=obj.getSect()%> </a>
				</td>
				</tr>
<%
			}
%>
	  </table>
<%
		}
%>
  </td></tr>
</table>
</center>

</body>
</html>
