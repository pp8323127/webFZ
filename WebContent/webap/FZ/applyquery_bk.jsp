<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.*,java.sql.*"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
String username = (String) session.getAttribute("cname") ; 

if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
  %> <jsp:forward page="sendredirect.jsp" /> <%
} 

try{
//retrieve crew schedule
ConnORA co = new ConnORA();
Statement stmt = co.getConnORA().createStatement();
ResultSet myResultSet = null;


int xCount=0;
String bcolor=null;
String sql="select * from fztform "+
"where aempno = '"+ sGetUsr+"' or rempno='"+ sGetUsr+"' order by formno";

String formno = null;
String rcname = null;
String rempno = null;
String ed_check = null;
String comments = null;
String newdate= null;
String checkdate = null;
String chg_all = null;
String aempno	=null;
String acname	= null;


myResultSet = stmt.executeQuery(sql);
%>
<html>
<head>
<title>Apply Query</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" href="menu.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<div align="center" class="txttitletop">
  <br>申請單記錄<br>

  <form name="form1" method="post" action="delapply.jsp">
    <table width="90%" border="0" cellspacing="0" cellpadding="0">
      <tr> 
        <td>&nbsp;</td>
        <td> </td>
        <td> 
          <div align="right"><a href="javascript:window.print()"> <img src="images/print.gif" width="17" height="15" border="0" alt="列印"></a> 
          </div>
        </td>
      </tr>
    </table>
    <table width="95%" border="0" cellspacing="0" cellpadding="0">
      <tr> 
        <td width="3%" class="tablehead">No</td>
        <td width="7%" class="tablehead">ChgAll</td>
        <td width="7%" class="tablehead">Applicant</td>
        <td width="9%" class="tablehead">Aname</td>
        <td width="7%" class="tablehead">Replacer</td>
        <td width="9%" class="tablehead">Rname</td>
        <td width="5%" class="tablehead">ED</td>
        <td width="10%" class="tablehead">Check Date</td>
        <td width="11%" class="tablehead">Apply Date </td>
        <td width="15%" class="tablehead"> ED Comments </td>
        <td width="4%" class="tablehead">Detail</td>
		<td class="tablehead">Delete</td>
      </tr>
      <%
if (myResultSet != null)
{
		while (myResultSet.next())
	{ 


			formno = myResultSet.getString("formno");
			rcname = myResultSet.getString("rcname");
			rempno = myResultSet.getString("rempno");
			chg_all = myResultSet.getString("chg_all");
			ed_check = myResultSet.getString("ed_check");
			comments = myResultSet.getString("comments");
			newdate = myResultSet.getString("newdate");
			checkdate = myResultSet.getString("checkdate");
			aempno	= myResultSet.getString("aempno");
			acname	= myResultSet.getString("acname");
	
			xCount++;
			if (xCount%2 == 0)
			{
				bcolor = "#C9C9C9";
			}
			else
			{
				bcolor = "#FFFFFF";
			}
%>
      <tr bgcolor="<%=bcolor%>"> 
        <td class="tablebody"><%=formno%></td>
        <td class="tablebody"><%=chg_all%></td>
        <td class="tablebody"><%= aempno%></td>
        <td class="tablebody"><%= acname %></td>
        <td class="tablebody"><%=rempno%></td>
        <td class="tablebody"><%=rcname%></td>
        <td class="tablebody"><%=ed_check%></td>
        <td class="tablebody"><%=checkdate%></td>
        <td class="tablebody"><%=newdate%></td>
        <td class="tablebody"><%=comments%></td>
        <td> 
          <div align="center"><a href="showform.jsp?formno=<%=formno%>" target="_blank"> 
            <img src="images/red.gif" width="15" height="15" border="0" alt="Detail"></a></div>
        </td>
		<td class="tablebody"><input type="checkbox" name="checkapply" value="<%=formno%>"></td>

		<%
		if (ed_check == null)
		{
		%>
        <%
		}
		%>
      </tr>
      <%
	}
}
%>
      <% 
 if (xCount==0)
{
%>
      <jsp:forward page="showmessage.jsp"> 
      <jsp:param name="messagestring" value="目前無申請單記錄<br>No Application record!!" />
      </jsp:forward>
      <%
} 
%>
    </table>
    <p>
      <input type="submit" name="Submit" value="Cancel" class="btm">
</p>
  </form>
  <p>&nbsp; </p>
  
</div>
</body>
</html>
<%
	myResultSet.close();
	stmt.close();
    co.close();
	myResultSet	= null;
	stmt = null;
}
catch (Exception e)
{
%>
      <jsp:forward page="err.jsp" /> 
<%	  
}
 
%>
