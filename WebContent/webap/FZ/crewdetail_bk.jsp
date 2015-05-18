<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.*,java.sql.*,ci.db.*,java.util.Date,java.text.DateFormat"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
request.setCharacterEncoding("big5");  
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
  %> <jsp:forward page="sendredirect.jsp" /> <%
} 

String fdate = request.getParameter("fdate");
String fltno = request.getParameter("fltno").trim();
String dpt = request.getParameter("dpt").trim();
String arv = request.getParameter("arv").trim();

Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
ResultSet myResultSet = null;
boolean t = false;

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


try{
//dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
//conn = dbDriver.connect("jdbc:weblogic:pool:CAL.FZCP02", null);

ConnDB cn = new ConnDB();
cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement();

String tripno=null;
String dh=null;
String base=null;
String occu=null;
String cname=null;
String empno=null;
String sern=null;
String qual =null;
String ename = null;
String groups = null;
String spcode = null;
String u1 = "";

int xCount=0;
String bcolor=null;
//************************************2.Get live sche table
ctlTable ct = new ctlTable();
ct.doSet();
//out.println(ct.getTable() + "," + ct.getUpdDate());
//****************************************
if (!dpt.equals("") && !arv.equals(""))
{
	u1 = " and a.dpt=UPPER('" + dpt + "') and a.arv=UPPER('"+arv+"') ";
}
else if (!dpt.equals(""))
{
		u1 = " and a.dpt=UPPER('" + dpt + "')";
		fdate = request.getParameter("fyy")+"/"+request.getParameter("fmm")+"/"+request.getParameter("fdd");
}

String sql="select a.empno empno,a.qual qual, a.groups groups, b.ename ename,b.name cname, b.box sern, a.tripno tripno, a.dh dh, a.homebase base, a.occu occu, a.spcode spcode "+
"from "+ct.getTable()+" a, fztcrew b "+
"where a.empno=b.empno and a.fdate='"+fdate+"' and trim(a.dutycode)='"+fltno+"' ";

sql = sql + u1 + " order by a.posncode, a.empno";
//out.println(sql);
myResultSet = stmt.executeQuery(sql);
%>
<html>
<head>
<title>Flight Query</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" href="menu.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<table width="74%" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
        <td class="txtblue">資料庫最後更新時間(Last update)：<span class="txtxred">TPE&nbsp;<%=ct.getUpdDate()%><br>
          <strong> The following shedule is for reference only. For official up-to-date schedule information, please contact Scheduling Department. <br>
下列班表僅供參考，請向組員派遣部門確認個人正式班表任務。 </strong>        </span></td>
    </tr>
</table>
<div align="center" class="txttitletop">
  <table width="74%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td width="5%">&nbsp;</td>
      <td width="90%" class="txttitletop">
        <div align="center"><%=fdate%> <%=fltno%> <%=dpt%> <%=arv%> on duty crew</div>
      </td>
      <td width="5%">
        <div align="right"><a href="javascript:window.print()"> <img src="images/print.gif" width="17" height="15" border="0" alt="列印"></a> 
        </div>
      </td>
    </tr>
    <tr>
      <td height="22">&nbsp;</td>
      <td class="txtblue">click Empno to Query this crew's schedule.(點選員工號可查該組員之班表) </td>
      <td>&nbsp;</td>
    </tr>
  </table>
  <form name="form1" method="post" action="mail_cs66.jsp">
  <table width="82%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="9%" class="tablehead">Empno</td>
	  <td width="6%" class="tablehead">Sern</td>
      <td width="11%" class="tablehead">Name</td>
	  <td width="15%" class="tablehead">EName</td>
	  <td width="7%" class="tablehead">Group</td>
      <td width="7%" class="tablehead">TripNo</td>
      <td width="5%" class="tablehead">Base</td>
      <td width="7%" class="tablehead">Occu</td>
	  <td width="6%" class="tablehead">DH</td>
  	  <td width="7%" class="tablehead">Qual</td>
	  <td width="7%" class="tablehead">Spcode</td>
	  <td width="6%" class="tablehead">EMail</td>
  	  <td width="7%" class="tablehead">MailTo</td>

    </tr>
    <%
if (myResultSet != null)
{
		while (myResultSet.next())
	{ 
			empno = myResultSet.getString("empno");
			cname = myResultSet.getString("cname");
			sern = myResultSet.getString("sern");
			groups = myResultSet.getString("groups");
			tripno = myResultSet.getString("tripno");
			dh = myResultSet.getString("dh");
			base = myResultSet.getString("base");
			occu = myResultSet.getString("occu");
			qual = myResultSet.getString("qual");
			spcode = myResultSet.getString("spcode");
			ename = myResultSet.getString("ename");
			
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
	  <td class="tablebody"><acronym title="Show crew's schedule"><a href="showsche2.jsp?empno=<%=empno %>&syear=<%=syear %>&smonth=<%=smonth%>" target="_blank"><%=empno%></a></acronym></td>
      <td class="tablebody"><%=sern%></td>
	  <td class="tablebody"><a href="crewquery.jsp?tf_ename=&tf_sess1=&tf_sess2=&tf_empno=<%=empno%>" target="_self" ><%=cname%></a></td>
	  <td class="tablebody" nowrap><div align="left">&nbsp;<%=ename%></div></td>
	  <td class="tablebody"><%=groups%></td>
      <td class="tablebody"><%=tripno%></td>
      <td class="tablebody"><%=base%></td>
      <td class="tablebody"><%=occu%></td>
	  <td class="tablebody"><%=dh%></td>
	  <td class="tablebody"><%=qual%></td>
	  <td class="tablebody"><%=spcode%></td>
	  <td  class="tablebody">
        <div align="center"><a href="mail.jsp?to=<%=empno%>@cal.aero&subject=Schedule&message=<%=fdate%> <%=fltno%>\n<%=empno%> <%=ename%> <%=base%> <%=occu%>\n<%=tripno%> <%=dpt%> <%=arv%>&cname=<%=ename%>" target="_blank"  > 
          <img src="images/mail.gif" width="15" height="15" alt="send mail to crew" border="0"></a></div>
      </td>
	  <td  class="tablebody">
	    <input type="checkbox" name="to" value="<%=empno%>">
      </td>
    </tr>
    <%
	}
}
%>
  </table>
  <br>
  <input type="submit" name="Submit" value="Send Mail to these crews" class="btm">
  </form>
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
