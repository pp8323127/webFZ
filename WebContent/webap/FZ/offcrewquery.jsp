<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,fz.*,ci.db.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
//查詢OFF組員資料
/*
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
*/
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
 %>
 <jsp:forward page="sendredirect.jsp" /> 
<%
} 

String yy	= request.getParameter("fyy");
String mm	= request.getParameter("fmm");
String dd	= request.getParameter("fdd");
String myoccu = request.getParameter("occu");
String fdate = yy+"/"+mm+"/"+dd;


//************************************2.Get live sche table
ctlTable ct = new ctlTable();
ct.doSet();
//****************************************
String sql = "select * from fztcrew where empno not in "+
			 "(select empno from "+ct.getTable()+" where fdate='"+fdate+
			 "') and locked='N' and trim(occu)='"+myoccu+"' order by empno";
			
Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
ResultSet myResultSet = null;
boolean t = false;

try{
//dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
//conn = dbDriver.connect("jdbc:weblogic:pool:CAL.FZCP02", null);
ConnDB cn = new ConnDB();
cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement();

myResultSet = stmt.executeQuery(sql); 

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Off Crew</title>
<link href="menu.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style2 {
	color: #FF0000;
	font-size: small;
}
-->
</style>
</head>
<style type="text/css">
<!--

BODY{margin:0px;}/*內容貼緊網頁邊界*/

.style1 {font-size: 16px; line-height: 22px; color: #464883; font-family: "Arial";}
-->
</style>
<body>
<div align="center">
<span class="txttitletop"><%=fdate%>&nbsp;&nbsp;Off Crew：<%=myoccu%>
      <br>
  </span><span class="style1"><span class="txtblue">You can query the crew by click Name column (點選姓名可查詢該組員資料)</span></span>
<br>
<span class="txtxred">Fltno:001、003、005、007、011、015、031、062以上航班可能有UTC跨日問題,建議確認該組員個人班表為準</span></div>
<table width="80%"  border="0" align="center" class="fortable">
  <tr>
    <td class="tablehead3">EmpNo</td>
    <td class="tablehead3">Name</td>
    <td class="tablehead3">EName</td>
    <td class="tablehead3">Sern</td>
    <td class="tablehead3">Occu</td>
    <td class="tablehead3">Fleet</td>
    <td class="tablehead3">Base</td>
    <td class="tablehead3">EMAIL</td>
  </tr>
<%
String bcolor = null;
int xCount = 0;
	if(myResultSet != null){
		while(myResultSet.next()){	
			String rs_emp	= 	myResultSet	.getString("EMPNO");
			String box		=	myResultSet	.getString("BOX");
			String sess		=	myResultSet	.getString("SESS");
			String ename	=	myResultSet	.getString("ENAME");
			String fleet	=	myResultSet	.getString("FLEET");
			String mphone	=	myResultSet	.getString("MPHONE");
			String hphone	=	myResultSet	.getString("HPHONE");
			String icq		=	myResultSet	.getString("ICQ");	
			String cname	= 	myResultSet.getString("NAME");
			String occu		=	myResultSet.getString("OCCU");	
			String base		=	myResultSet.getString("BASE");
			String email	= 	myResultSet.getString("EMAIL");
			
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
  <tr bgcolor="<%= bcolor%>">
    <td height="22" class="tablebody"><%=rs_emp%></td>
    <td  class="tablebody"><p style="white-space:nowrap" align="center"><a href="crewquery.jsp?tf_ename=&tf_sess1=&tf_sess2=&tf_empno=<%=rs_emp%>" target="_self" ><%=cname%></a></p></td>
    <td  class="tablebody"><div align="left" style="white-space:nowrap">&nbsp;<%=ename%></div></td>
    <td class="tablebody"><%=box%></td>
    <td class="tablebody"><%=occu%></td>
    <td class="tablebody"><%=fleet%></td>
    <td class="tablebody"><%=base%></td>
    <td class="tablebody"><a href="mail.jsp?to=<%=email%>&cname=<%=ename%>" target="_blank"><img src="images/mail.gif" alt="mail to <%=cname%>" border="0"></a></td>
  </tr>
<%
  		}
	}
	
	if(xCount==0){
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
%>
	<jsp:forward page="showmessage.jsp">
	<jsp:param name="messagestring" value="No Data Found!!<br>查無相關資料！！" />
	</jsp:forward>
	<%
	}

%>
</table>
</body>
</html>
<%
}
catch (Exception e)
{
	  out.println(e.toString());
}
finally
{
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>