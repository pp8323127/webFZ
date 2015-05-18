<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.*,java.sql.*,ci.db.*"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
String username = (String) session.getAttribute("cname") ; 

if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
  %> <jsp:forward page="sendredirect.jsp" /> <%
} 
String fyy = request.getParameter("fyy");
//String fmm = request.getParameter("fmm");
//String querydate = fyy + fmm;
String querydate = fyy;

Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
ResultSet myResultSet = null;
boolean t = false;
String m = null;
try{
//dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
//conn = dbDriver.connect("jdbc:weblogic:pool:CAL.FZCP02", null);
ConnDB cn = new ConnDB();
cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement();

if (fyy == null) 
{
	myResultSet = stmt.executeQuery("select to_char(sysdate,'yyyy') qdate ,to_char(sysdate,'mmdd') m  from dual");
	if (myResultSet.next())
	{
		querydate = myResultSet.getString("qdate");
		m = myResultSet.getString("m");
		if( Integer.parseInt(m) >= 1225){
			querydate = Integer.toString(Integer.parseInt(querydate)+1);
		}
	}
}

int xCount=0;
String bcolor=null;
String sql="select * from fztform "+
"where (aempno = '"+ sGetUsr+"' or rempno='"+ sGetUsr+"') "
//+"and  to_char(newdate,'yyyy') = '"+querydate+"' "
+"and SubStr(formno,1,4)='"+querydate
+"' order by formno";

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
<style type="text/css">
<!--
.style1 {color: #D4D0C8}
-->
</style>
</head>

<body >

  <form name="form1" method="post" action="delapply.jsp">
    
  <table width="95%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
        
      <td width="5%">&nbsp;</td>
        <td><div align="center" class="txttitletop"><%=querydate%>年申請單記錄</div></td>
        
      <td width="5%"> 
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
			if (ed_check == null) {ed_check = "&nbsp;";}
			comments = myResultSet.getString("comments");
			if (comments == null) {comments = "&nbsp;";}
			newdate = myResultSet.getString("newdate");
			checkdate = myResultSet.getString("checkdate");
			if (checkdate == null) {checkdate = "&nbsp;";}
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
          <div align="center"><a href="swap3/showForm.jsp?formno=<%=formno%>" target="_blank"> 
            <img src="images/red.gif" width="15" height="15" border="0" alt="Detail"></a></div>
        </td>
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
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
%>
      <jsp:forward page="showmessage.jsp"> 
      <jsp:param name="messagestring" value="目前無申請單記錄<br>No Application record!!" />
      </jsp:forward>
      <%
} 
%>
    </table>
  </form>
  <div align="center">
    <p><span class="txtblue">資料庫每兩小時更新一次，若ED已核准申請單，而班表尚未更新，請耐心稍候。</span><span class="txtblue"><br>
    </span><span class="txtxred">    相同申請單，請勿重複遞單！！
謝謝。    </span></p>
</div>
</body>
</html>
<%
}
catch (Exception e)
{
	  t = true;
}
finally
{
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
if(t)
{
%>
      <jsp:forward page="err.jsp" /> 
<%
}
%>
