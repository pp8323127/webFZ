<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="fz.*,java.sql.*,ci.db.*"%>
<%

response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);

String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
//20130326增加**
String occu = (String) session.getAttribute("occu");
String powerUser =(String)session.getAttribute("powerUser");
//**************
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
 %>
 <jsp:forward page="sendredirect.jsp" /> 
<%
}else if(!("ED".equals(occu) | "Y".equals(powerUser))){//本組及簽派可看此頁20130326增加
%>
	<p  class="errStyle1">1.您無權使用此功能！<br> 2.閒置過久請重新登入！</p>
<%
	
}else{

String userid =(String) session.getAttribute("userid") ; 
java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMdd");
//String showsdate = formatter.format(new java.util.Date()) ;
Calendar c1 = Calendar.getInstance();
String showsdate = formatter.format(c1.getTime()) ;
c1.add(Calendar.DATE,1);
String showedate = formatter.format(c1.getTime()) ;

Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
ResultSet myResultSet = null;
boolean t = false;
int cnt=0;

try{

ConnDB cn = new ConnDB();
cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement();

String comm = null;
String setdate = null;
String setedate = null;
String tempbgcolor = "";
String sql = "select to_char(setdate,'YYYY/MM/DD hh24:mi') setdate, to_char(setedate,'YYYY/MM/DD hh24:mi') setedate from fztsetd where station='TPE' order by setdate";
myResultSet = stmt.executeQuery(sql); 
%>

<html>
<head>
<title>自訂不收單時段</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="menu.css" rel="stylesheet" type="text/css">
<link href="style2.css" rel="stylesheet" type="text/css">
<link href="style3.css" rel="stylesheet" type="text/css">
</head>

<body>
<form  method="post" name="form1" action="delappdate.jsp">
  <table width="60%"  border="1" align="center" cellpadding="0" cellspacing="1" class="fortable">
    <tr>
      <td colspan="4" class="tablehead3"><div align="center">目前不收單時段</div></td>
    </tr>
 <tr>
      <td  class="tablebody" bgcolor="#CCCCCC">#</td>
      <td  class="tablebody" colspan ="2" bgcolor="#CCCCCC">時段</td>
	  <td  class="tablebody" bgcolor="#CCCCCC">刪除</td>
    </tr>

        <div align="center">
    <%
	if(myResultSet != null)
	{
		while (myResultSet.next())
		{
			if(cnt%2==0)
			{
				tempbgcolor = "#FFFFFF";
			}
			else
			{
				tempbgcolor = "#CCFFFF";
			}

		   setdate = myResultSet.getString("setdate");
		   setedate = myResultSet.getString("setedate");
	%>
 <tr bgcolor="<%=tempbgcolor%>">
   <td class="tablebody" align="center"><%=++cnt%></td>
   <td class="tablebody" align="center"><%=setdate%></td>
   <td class="tablebody" align="center"><%=setedate%></td>
   <td class="tablebody"><input name="checkdel" type="checkbox" id="checkdel"  value="<%=setdate%>"></td>
 </tr>	  
    <%
		}
	}
	%>  
    <tr>
      <td colspan="4"  class="tablebody" align="center">&nbsp;&nbsp;
          <input name="Submit2" type="submit" class="btm" value="確認刪除">
      </td>
    </tr>
  </table>
</form>
<br>
<form action="updappdate.jsp"  method="post" name="form2" id="form2">
  <table width="60%"  border="1" align="center" cellpadding="0" cellspacing="1" class="fortable">
    <tr>
      <td colspan="2" class="tablehead3"><div align="center">新增不收單時段（ex:2003/01/05 22:00）時間為24小時制</div></td>
    </tr>
	<tr>
     <td class="tablebody"> From&nbsp;
	   <table border="0" align="center" cellpadding="1" cellspacing="1" >
		  <tr class="e2 txtblue" align="center">
			<td>年</td>
			<td>月</td>
			<td>日</td>
			<td>時</td>
			<td>分</td>
		  </tr>
		  <tr align="center" valign="middle">
			<td><input name="sdateyyyy" type="text" id="sdateyyyy" size="4" maxlength="4" value="<%=showsdate.substring(0,4)%>">
			</td>
			<td><input name="sdatemm" type="text" id="sdatemm" size="2" maxlength="2" value="<%=showsdate.substring(4,6)%>" >
			</td>
			<td><input name="sdatedd" type="text" id="sdatedd" size="2" maxlength="2" value="<%=showsdate.substring(6,8)%>" ></td>
			<td><input name="sdatehh" type="text" id="sdatehh" size="2" maxlength="2" value="00" ></td>
			<td><input name="sdatemi" type="text" id="sdatemi" size="2" maxlength="2" value="00" ></td>
		  </tr>
		</table>
     </td>
     <td class="tablebody">To&nbsp;
	   <table border="0" align="center" cellpadding="1" cellspacing="1" >
		  <tr class="e2 txtblue" align="center">
			<td>年</td>
			<td>月</td>
			<td>日</td>
			<td>時</td>
			<td>分</td>
		  </tr>
		  <tr align="center" valign="middle">
			<td><input name="edateyyyy" type="text" id="edateyyyy" size="4" maxlength="4" value="<%=showedate.substring(0,4)%>">
			</td>
			<td><input name="edatemm" type="text" id="edatemm" size="2" maxlength="2" value="<%=showedate.substring(4,6)%>" >
			</td>
			<td><input name="edatedd" type="text" id="edatedd" size="2" maxlength="2" value="<%=showedate.substring(6,8)%>" ></td>
			<td><input name="edatehh" type="text" id="edatehh" size="2" maxlength="2" value="00" ></td>
			<td><input name="edatemi" type="text" id="edatemi" size="2" maxlength="2" value="00" ></td>
		  </tr>
		</table>
     </td>
   </tr>	  
   <tr>
      <td colspan="2"  class="tablebody"><div align="center">        &nbsp;&nbsp;
        <input name="Submit" type="submit" class="btm" value="確認新增">
      </div></td>
    </tr>
  </table>
</form>


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

}//end if
%>
