<%@page contentType="text/html; charset=big5" language="java"  %>
<%@page import="fz.*,ci.db.*,java.sql.*"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
 %>
 <jsp:forward page="sendredirect.jsp" /> 
<%
} 
//write log
String userip = request.getRemoteAddr();
String userhost = request.getRemoteHost();

writeLog wl = new writeLog();
String wlog = wl.updLog(sGetUsr, userip,userhost, "FZ285");
//variables

String u1 = null;
String u2 = null;
String u3 = null;
String sql = null;
String yymm = null;
int dd = 0;
String ct = null;
int formno = 0;//取得流水號

Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
ResultSet myResultSet = null;
boolean t = false;

try
{
//dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
//conn = dbDriver.connect("jdbc:weblogic:pool:CAL.FZCP02", null);

ConnDB cn = new ConnDB();
cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement();

//modify 2004/02/23
sql = "select to_char(add_months(sysdate,1),'yyyymm') yymm, to_char(sysdate,'dd') dd, substr(to_char(max(formno)),1,6) ct,max(formno) tcount from fztform";
myResultSet = stmt.executeQuery(sql);
if (myResultSet.next())
{
	yymm = myResultSet.getString("yymm");//200403 = today add 1 month
	dd = myResultSet.getInt("dd");//25
	ct = myResultSet.getString("ct");//200402
	formno = myResultSet.getInt("tcount");//2004020001
	if(dd >= 24) //每月24號編號重編
	{
		if(yymm.equals(ct))
		{
			formno = formno + 1;
		}
		else
		{
			formno = Integer.parseInt(yymm + "0001");
		}
	}
	else
	{
		formno = formno + 1;
	}
}

String acname = request.getParameter("cname");
String agroups = request.getParameter("agroups");
String aempno = request.getParameter("sGetUsr");
String asern = request.getParameter("sern");
String atimes = request.getParameter("atimes");
String aqual = request.getParameter("aqual");
String aprjcr = request.getParameter("aprjcr");

String rcname = request.getParameter("rcname");
String rgroups = request.getParameter("rgroups");
String rempno = request.getParameter("rempno");
String rsern = request.getParameter("rsern");
String rtimes = request.getParameter("rtimes");
String rqual = request.getParameter("rqual");
String rprjcr = request.getParameter("rprjcr");

String comm = request.getParameter("comments");
String swap = null;
String overpay = null;
String over_hr = null;

String chg_all = request.getParameter("checkall");
u1 = "insert into fztform values (";
if (chg_all.equals("N"))
{
	String[] atripno = request.getParameterValues("tripno");
	String[] afdate = null;
	String[] afltno = null;
	String[] acr = null;
	String aswaphr = request.getParameter("aSwapHr");
	String afd = request.getParameter("afd");
	String attfly = request.getParameter("attfly");
	if (atripno != null)
	{
		afdate = request.getParameterValues("fdate");
		afltno = request.getParameterValues("fltno");
		acr = request.getParameterValues("cr");
		
	}
	String[] rtripno = request.getParameterValues("rtripno");
	String[] rfdate = null;
	String[] rfltno = null;
	String[] rcr = null;
	String rswaphr = request.getParameter("rSwapHr");
	String rfd = request.getParameter("rfd");
	String rttfly = request.getParameter("rttfly");
	if (rtripno != null)
	{
		rfdate = request.getParameterValues("rfdate");
		rfltno = request.getParameterValues("rfltno");
		rcr = request.getParameterValues("cr2");
	}
	swap = request.getParameter("swap");
	if(swap.equals("0") ||swap.equals("0.0"))
	{
		overpay = "N";
		over_hr = "0000";
	}
	else
	{
		overpay = "Y";
		over_hr = swap;
	}
	u2 = formno+",'"+aempno+"',"+asern+",'"+acname+"','"+agroups+"',"+atimes+",'"+aqual+
	"','"+rempno+"',"+rsern+",'"+rcname+"','"+rgroups+"',"+rtimes+",'"+rqual+"','"+chg_all+
	"','"+aswaphr+"','"+rswaphr+"','"+afd+"','"+rfd+"','"+aprjcr+"','"+rprjcr+"','"+attfly+
	"','"+rttfly+"','"+overpay+"','"+over_hr+"','"+comm+"',null,null,'"+aempno+"',sysdate,null,null)";
	stmt.executeUpdate(u1 + u2);
	if (atripno != null)
	{
		for (int i = 0; i < atripno.length; i++)
		{
			stmt.executeUpdate("insert into fztaply values ("+formno+",'A','"+aempno+"','"+atripno[i]+"','"+afdate[i]+"','"+afltno[i]+"','"+acr[i]+"')");
		}
	}
	if (rtripno != null)
	{
		for (int i = 0; i < rtripno.length; i++)
		{
			stmt.executeUpdate("insert into fztaply values ("+formno+",'R','"+rempno+"','"+rtripno[i]+"','"+rfdate[i]+"','"+rfltno[i]+"','"+rcr[i]+"')");
		}
	}
} 
else //change all duty
{
	u2 = formno+",'"+aempno+"',"+asern+",'"+acname+"','"+agroups+"',"+atimes+",'"+aqual+
	"','"+rempno+"',"+rsern+",'"+rcname+"','"+rgroups+"',"+rtimes+",'"+rqual+"','"+chg_all+
	"',null,null,null,null,'"+aprjcr+"','"+rprjcr+"',null,null,null,null,'"+comm+
	"',null,null,'"+aempno+"',sysdate,null,null)";
	stmt.executeUpdate(u1 + u2);
}
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
      <jsp:forward page="showmessage.jsp">
	  <jsp:param name="messagestring" value="系統目前忙碌中，請稍後再試...................." />
	  </jsp:forward>
<%
}
%>
<html>
<head>
<title>Send Crew Duty</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="menu.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style1 {color: #FF0000}
-->
</style>
</head>
<body>
<p class="txttitletop" align="left">1. 此換班申請單遞出時間若於17:00前，換班作業將於<span class="style1">當天工作日</span>完成，若於17:00後遞出，則為<span class="style1">下一工作日(例假日不算工作日)</span>完成。<br>
2. 因簽派系統(SBS)與班表資訊網為不同系統，換班資料需經由程式轉檔(<span class="style1">至少3~4小時後</span>)始能於班表資訊網中查詢換班後新任務。<br>
3. 無論申請單成功與否，派遣部均會傳送資訊於個人全員信箱(請適時保持信箱可用容量)，在未收到通知前，無法遞出第二次申請單。</p>
<p class="txttitle" align="center"><a href="applyquery.jsp">查詢申請單記錄</a></p>
</body>
</html>
