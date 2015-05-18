<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="fz.*,java.sql.*,ci.db.*,java.util.Date,java.text.DateFormat"%>
<%
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
String favftno	= request.getParameter("fltno");	//fltno

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

String cname	= 	null;
String occu		= 	null;
String base		=	null;
String box		=   null;
String sess		=	null;
String ename	=	null;
String fleet	=	null;
String mphone	=	null;
String hphone	=	null;
String icq		=	null;
String email	=	null;
String rs_emp	= 	null;

int count = 0;
String bcolor	=null;

//get Date
java.util.Date nowDate = new Date();
int syear	=	nowDate.getYear() + 1900;
int smonth	= 	nowDate.getMonth() + 1;
int sdate	= nowDate.getDate();
if (sdate >=25){	//超過25號，抓下個月的班表
	
	if (smonth == 12){	//超過12月25號，抓明年1月的班表
		smonth = 1;
		syear = syear+1;
	}
	else{
		smonth = smonth+1;
	}
}

String smonth2 =  Integer.toString(smonth);
if (smonth <10){
	smonth2 = "0" + smonth;
}

/*String sql = "select empno,fltno from fztfzvr where fltno = '" +
			 favftno +"' and empno not in('" +sGetUsr+ "') order by fltno,empno";*/

String sql ="SELECT EMPNO,BOX,SESS,NAME,ENAME,CABIN,OCCU,NVL(FLEET,'&nbsp;') "
			+"FLEET,BASE,EMAIL,NVL(MPHONE,'&nbsp;') MPHONE,NVL(HPHONE,'&nbsp;') HPHONE,"
			+"NVL(ICQ,'&nbsp;') ICQ FROM FZTCREW "
			+"where empno in (select empno from fztfavr where fltno ='"+favftno+ "')";

 
myResultSet = stmt.executeQuery(sql); 





%>

<html>
<head>
<title>Favor Flight Query</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="menu.css" rel="stylesheet" type="text/css">
<style type=text/css>
<!--
BODY{margin:0px;/*內容貼緊網頁邊界*/}
-->
</style>


</head>

<body>
<div align="center" class="txttitletop">People who like Fltno: <%=favftno%></div>
<table width="95%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
      <td width="5%">&nbsp;</td>
      <td width="90%" class="txtblue"><div align="center">Click EmpNo to Compare Schedule with that crew (點選員工號可與該組員比對班表） </div></td>
      <td width="5%">
        <div align="right"><a href="javascript:window.print()"> <img src="images/print.gif" width="17" height="15" border="0" alt="列印"></a> 
        </div>
      </td>
  </tr>
</table>
<table width="95%"  border="1" class="fortable" align="center">
  <tr class="tablehead3">
    <td width="13%" >EmpNo</td>
    <td width="20%" >Name</td>
    <td width="8%" >Sern</td>
    <td width="7%" >Occu</td>
    <td width="7%" >Base</td>
    <td width="7%" >EMAIL</td>
    <td width="11%" >Mobile</td>
    <td width="10%" >Home</td>
    <td width="12%" >ICQ</td>
    <td width="5%">Sche</td>
  </tr>
  <%
  int xCount=0;
  if(myResultSet != null){

	while (myResultSet.next()){
		xCount++;
		rs_emp	= 	myResultSet	.getString("EMPNO");
		box		=	myResultSet	.getString("BOX");
		sess	=	myResultSet	.getString("SESS");
		ename	=	myResultSet	.getString("ENAME");
		fleet	=	myResultSet	.getString("FLEET");
		mphone	=	myResultSet	.getString("MPHONE");
		hphone	=	myResultSet	.getString("HPHONE");
		//address	=	myResultSet	.getString("ADDRESS");
		icq		=	myResultSet	.getString("ICQ");	
		cname	= 	myResultSet.getString("NAME");
		occu	=	myResultSet.getString("OCCU");	
		base	=	myResultSet.getString("BASE");
		email	= 	myResultSet.getString("EMAIL");


		count++;
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
    <td class="tablebody" ><acronym title="compare schedule with this crew"><a href="compare.jsp?empno=<%=rs_emp%>&fyy=<%=syear %>&fmm=<%=smonth2%>" target="_blank"><%=rs_emp%></a></acronym></td>
    <td class="tablebody" nowrap><%=cname %></td>
    <td class="tablebody"><%=box %></td>
    <td class="tablebody"><%=occu %></td>
    <td class="tablebody"><%=base %></td>
    <td class="tablebody"><a href="mail.jsp?to=<%=email%>&cname=<%=ename%>" target="_blank"><img src="images/mail.gif" alt="mail to <%=cname%>" border="0"></a></td>
    <td class="tablebody"><%=mphone %></td>
    <td class="tablebody"><%=hphone %></td>
    <td class="tablebody"><%=icq %></td>
    <td class="tablebody"><a href="showsche2.jsp?empno=<%=rs_emp %>&syear=<%=syear %>&smonth=<%=smonth%>" target="_blank"><img src="images/search.gif" border="0" alt="show schedule"></a></td>
  </tr>
  <%
	  }
  }
  
  %>
</table>
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