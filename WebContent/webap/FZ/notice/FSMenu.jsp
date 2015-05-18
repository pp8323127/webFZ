<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="java.net.URLEncoder,java.util.ArrayList"%>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login
if (userid == null) 
{		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} 
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5"
><link rel="stylesheet" type="text/css" href = "style.css">
<script language="JavaScript" type="text/JavaScript">
function pageLoad(w1,w2)
{
		parent.topFrame.location.href=w1;
		parent.mainFrame.location.href=w2;
}
</script>

<title>組員</title>
</head>

<body>
<p>&nbsp;</p>
<br>
<center>
<table width="400" border="0" cellspacing="2">
  <tr class="tableInner2">
   <td valign="middle"><div align="left">
<%
		eg.propAganda.PropAganda pad =  new eg.propAganda.PropAganda();
        pad.getunConfirmPropAgandaList(userid);
		ArrayList objAL4 = pad.getObjAL();
%>
		<img src="../images/viewmag.png" width="16" height="16" align="top">
		<a href="#" onClick="pageLoad('../PRAC/agenda/propAgandaQuery.jsp?gopage=FS','../blank.htm')" class="txtblue">檢視已簽閱宣導事項</a>&nbsp;&nbsp;
<%
	    if(objAL4.size()>0)
		{
%>
		( </font><span class="txtxred">請按【檢視完畢】以示完成簽閱 </span><font class="style1">)</font>
<%		
		}

        if(objAL4.size()>0)
		{
%>
	  <table width="80%" border="0"> 
<%
			for(int i=0; i<objAL4.size(); i++)
			{
				eg.propAganda.PropAgandaObj obj = (eg.propAganda.PropAgandaObj) objAL4.get(i);   
%>
				<tr><td width="10%">&nbsp;</td>
				<td width="90%" class="txtblue" align="left">
				<img src="../images/new_0033.gif" width="16" height="16" align="top">&nbsp;<a href="../PRAC/agenda/doAgendaConfirm.jsp?gopage=FS&seq=<%=obj.getSeq()%>"><%=obj.getSubject()%></a></td>
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
