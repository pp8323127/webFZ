<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.*,java.sql.*,ci.db.*"%>
<%
//pageid= FZ253
String aempno = null;
String asern = null;
String acname = null;
String agroups = null;
String atimes = null;
String aqual = null;
String rempno = null;
String rsern = null;
String rcname = null;
String rgroups = null;
String rtimes = null;
String rqual = null;
String chg_all = null;
String aswaphr = null;
String rswaphr = null;
String aswapdiff = null;
String rswapdiff = null;
String apch = null;
String rpch = null;
String attlhr = null;
String rttlhr = null;
String overpay = null;
String over_hr = null;
String crew_comm = null;
String ed_check = null;
String comments = null;
String newdate = null;
String checkdate = null;
String[] atripno ;
String[] afdate ;
String[] afltno ;
String[] acr ;
String[] rtripno ;
String[] rfdate ;
String[] rfltno ;
String[] rcr ;
String therole = null;
String formno = null;
int x ;
int y ;
%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
String username = (String) session.getAttribute("cname") ; 

if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
  %> <jsp:forward page="sendredirect.jsp" /> <%
} 

atripno = new String[20];
afdate = new String[20];
afltno = new String[20];
acr = new String[20];
rtripno = new String[20];
rfdate = new String[20];
rfltno = new String[20];
rcr = new String[20];

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

formno = request.getParameter("formno");

String sql="select * from fztform where formno = "+formno;


myResultSet = stmt.executeQuery(sql);
if (myResultSet.next())
{
	aempno = myResultSet.getString("aempno");
	asern = myResultSet.getString("asern");
	acname = myResultSet.getString("acname");
	agroups = myResultSet.getString("agroups");
	atimes = myResultSet.getString("atimes");
	aqual = myResultSet.getString("aqual");
	rempno = myResultSet.getString("rempno");
	rsern = myResultSet.getString("rsern");
	rcname = myResultSet.getString("rcname");
	rgroups = myResultSet.getString("rgroups");
	rtimes = myResultSet.getString("rtimes");
	rqual = myResultSet.getString("rqual");
	chg_all = myResultSet.getString("chg_all");
	aswaphr = myResultSet.getString("aswaphr");
	rswaphr = myResultSet.getString("rswaphr");
	aswapdiff = myResultSet.getString("aswapdiff");
	rswapdiff = myResultSet.getString("rswapdiff");
	apch = myResultSet.getString("apch");
	rpch = myResultSet.getString("rpch");
	attlhr = myResultSet.getString("attlhr");
	rttlhr = myResultSet.getString("rttlhr");
	overpay = myResultSet.getString("overpay");
	over_hr = myResultSet.getString("over_hr");
	crew_comm = myResultSet.getString("crew_comm");
	ed_check = myResultSet.getString("ed_check");
	comments = myResultSet.getString("comments");
	newdate = myResultSet.getString("newdate");
	checkdate = myResultSet.getString("checkdate");
}

therole = null;
x = 0;
y = 0;
if (chg_all.equals("N"))
{
	sql = "select * from fztaply where formno = "+formno;//applicant
	myResultSet = stmt.executeQuery(sql);
	if (myResultSet != null)
	{
		while(myResultSet.next())
		{
			therole = myResultSet.getString("therole");
			if (therole.equals("A"))
			{
				atripno[x] = myResultSet.getString("tripno");
				afdate[x] = myResultSet.getString("fdate");
				afltno[x] = myResultSet.getString("fltno");
				acr[x] = myResultSet.getString("fly_hr");
				x++;
			}
			else
			{
				rtripno[y] = myResultSet.getString("tripno");
				rfdate[y] = myResultSet.getString("fdate");
				rfltno[y] = myResultSet.getString("fltno");
				rcr[y] = myResultSet.getString("fly_hr");
				y++;
			}
		}
	}
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
	<jsp:param name="messagestring" value="Connect DB Fail !!" />
	</jsp:forward>
<%
}
%>

<html>
<head>
<title>Show Apply Form</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" href="menu.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<p align="center"><b>客艙組員任務互換申請單 </b></p>
<p align="center"><span class="font1"><font color="#FF0000"><strong>本人及互換者相互同意換班並保證： 
  <br>
  1. 本申請日前兩個曆月內全勤。 2. 本申請單內填寫內容均符合申請規定無誤。 </strong></font></span></p>
<br>
<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
  <tr> 
    <td><font face="Arial, Helvetica, sans-serif" size="2"><b>Form No : <%=formno%></b></font> 
    <td><font face="Arial, Helvetica, sans-serif" size="2"><b>ApplyDate :</b></font> 
      <font face="Arial, Helvetica, sans-serif" size="2"><b><%=newdate%></b></font></td>
    <td> 
      <div align="right"><a href="javascript:window.print()"> <img src="images/print.gif" width="17" height="15" border="0" alt="列印"></a> 
      </div>
    </td>
  </tr>
</table>
<div align="center"></div>
<table width="90%"  border="1" cellpadding="0" cellspacing="0" align="center">
  <tr > 
    <td width="18%" class="tablehead2"> 
      <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">說 
        明 </font></b></div>
    </td>
    <td width="38%" colspan="2" class="tablehead2"> 
      <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">Applicant</font></b></div>
    </td>
    <td width="44%" colspan="2" class="tablehead2"> 
      <div align="center"><b><font face="Arial, Helvetica, sans-serif">Substitute</font></b></div>
    </td>
  </tr>
  <tr > 
    <td class="t1"> 
      <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">Name/Group</font></b></div>
    </td>
    <td class="tablebody"> 
      <div align="center"><%=acname%></div>
    </td>
    <td class="tablebody"> 
      <div align="center"><%=agroups%> </div>
    </td>
    <td class="tablebody"> 
      <div align="center"><%=rcname%> </div>
    </td>
    <td class="tablebody"> 
      <div align="center"><%=rgroups%> </div>
    </td>
  </tr>
  <tr > 
    <td class="t1"> 
      <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">Empno/Serial</font></b></div>
    </td>
    <td class="tablebody"> 
      <div align="center"><%=aempno%> </div>
    </td>
    <td class="tablebody"> 
      <div align="center"><%=asern%> </div>
    </td>
    <td class="tablebody"> 
      <div align="center"><%=rempno%> </div>
    </td>
    <td class="tablebody"> 
      <div align="center"><%=rsern%> </div>
    </td>
  </tr>
  <tr > 
    <td class="t1"> 
      <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">Times</font></b></div>
    </td>
    <td colspan="2" class="tablebody"> 
      <div align="center"><%=atimes%> </div>
    </td>
    <td colspan="2" class="tablebody"> 
      <div align="center"><%=rtimes%> </div>
    </td>
  </tr>
  <tr class="tablebody"> 
    <td class="t1"> 
      <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">Qual</font></b></div>
    </td>
    <td colspan="2" class="tablebody"> 
      <div align="center"><%=aqual%> </div>
    </td>
    <td colspan="2" class="tablebody"> 
      <div align="center"><%=rqual%> </div>
    </td>
  </tr>
</table>
<br>
<%
if (chg_all.equals("N"))
{
%>
<table width="90%"  border="1" cellpadding="0" cellspacing="0" align="center">
  <tr > 
    <td colspan="4" class="tablehead2"> 
      <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">Applicant</font></b></div>
    </td>
  </tr>
  <tr > 
    <td width="25%" class="tablehead2"> 
      <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">TripNo</font></b></div>
    </td>
    <td class="tablehead2"> 
      <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">Flight 
        Date </font></b></div>
    </td>
    <td class="tablehead2"> 
      <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">FlightNo</font></b></div>
    </td>
    <td class="tablehead2"> 
      <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">Fly 
        Hour </font></b></div>
    </td>
  </tr>
  <%
x = 0;
while(atripno[x] != null)
{
%>
  <tr > 
    <td class="tablebody"> 
      <div align="center"><%=atripno[x]%> </div>
    </td>
    <td class="tablebody"> 
      <div align="center"><%=afdate[x]%> </div>
    </td>
    <td class="tablebody"> 
      <div align="center"><%=afltno[x]%> </div>
    </td>
    <td class="tablebody"> 
      <div align="center"><%=acr[x]%> </div>
    </td>
  </tr>
  <%
	x++;
}
%>
</table>
<br>
<table width="90%"  border="1" cellpadding="0" cellspacing="0" align="center">
  <tr> 
    <td colspan="4" class="tablehead2"> 
      <div align="center"><font face="Arial, Helvetica, sans-serif">Substitute</font></div>
    </td>
  </tr>
  <tr> 
    <td width="25%" class="tablehead2"> 
      <div align="center"><font face="Arial, Helvetica, sans-serif">TripNo</font></div>
    </td>
    <td class="tablehead2"> 
      <div align="center"><font face="Arial, Helvetica, sans-serif">Flight Date 
        </font></div>
    </td>
    <td class="tablehead2"> 
      <div align="center"><font face="Arial, Helvetica, sans-serif">FlightNo</font></div>
    </td>
    <td class="tablehead2"> 
      <div align="center"><font face="Arial, Helvetica, sans-serif">Fly Hour </font></div>
    </td>
  </tr>
<%
y = 0;
while(rtripno[y] != null)
{
%>
  <tr > 
    <td class="tablebody"> 
      <div align="center"><%=rtripno[y]%> </div>
    </td>
    <td class="tablebody"> 
      <div align="center"><%=rfdate[y]%> </div>
    </td>
    <td class="tablebody"> 
      <div align="center"><%=rfltno[y]%> </div>
    </td>
    <td class="tablebody"> 
      <div align="center"><%=rcr[y]%> </div>
    </td>
  </tr>
  <%
	y++;
}
%>
</table>
<%
}
%>
<br>
<table width="90%"  border="1" cellpadding="0" cellspacing="0" align="center">
  <%
if(chg_all.equals("N"))
{
%>
  <tr> 
    <td width="23%" class="t1"> 
      <div align="center">互換班次之總飛時 </div>
    </td>
    <td class="txttitle"><b><font face="Arial, Helvetica, sans-serif" size="2">A 
      </font></b></td>
    <td class="tablebody"> 
      <div align="center"><%=aswaphr%> </div>
    </td>
    <td class="txttitle"><b><font size="2">B </font></b></td>
    <td class="tablebody"> 
      <div align="center"><%=rswaphr%> </div>
    </td>
  </tr>
  <tr> 
    <td width="23%" class="t1"> 
      <p align="center">互換班次飛時差額<br>
        (X 必須小於12hrs ) </p>
    </td>
    <td class="txttitle"><b><font face="Arial, Helvetica, sans-serif" size="2">A-B=X :
      </font></b></td>
    <td class="tablebody"> 
      <div align="center"><%=aswapdiff%> </div>
    </td>
    <td class="txttitle"><b><font size="2">A-B=X :</font></b></td>
    <td class="tablebody"> 
      <div align="center"><%=rswapdiff%> </div>
    </td>
  </tr>
  <%
}
%>
  <tr> 
    <td class="t1"> 
      <div align="center">Projected Credit Hour </div>
    </td>
    <td class="txttitle"><b><font face="Arial, Helvetica, sans-serif" size="2">Applicant:</font></b></td>
    <td class="tablebody"> 
      <div align="center"><%= apch%> </div>
    </td>
    <td class="txttitle"><b><font size="2">Substitute:</font></b></td>
    <td class="tablebody"> 
      <div align="center"><%= rpch%> </div>
    </td>
  </tr>
  <%
if (chg_all.equals("N"))
{
%>
  <tr> 
    <td width="23%" class="t1"> 
      <div align="center">互換後本月總飛時 </div>
    </td>
    <td width="15%" class="txttitle"><b><font face="Arial, Helvetica, sans-serif" size="2">C 
      ±X=</font></b></td>
    <td width="20%" class="tablebody"> 
      <div align="center"><%=attlhr%> </div>
    </td>
    <td width="19%" class="txttitle"><b><font size="2">D ±X=</font></b></td>
    <td width="23%" class="tablebody"> 
      <div align="center"><%=rttlhr%> </div>
    </td>
  </tr>
  <%
  if(overpay != null){
  %>
  <tr> 
    <td class="t1"> 
      <div align="center">是否產生超時給付</div>
    </td>
    <td colspan="4" class="tablebody"> 
      <div align="center" class="tablebody"> 
        <%
	if (overpay.equals("Y"))
	{
		out.println("Yes&nbsp;total hours:"+over_hr);
	}
	else
	{
		out.println("No");
	}
	%>
      </div>
    </td>
  </tr>
  <%
  }//end of overpay != null
}
if(chg_all.equals("Y")){
%>
<tr>
  <td colspan="5" class="txtxred">
    <div align="center">Whole Month Exchange 全月互換
    </div></td>
</tr>

<%
}

%>
</table>
<br>
<table width="90%"  border="1" cellpadding="0" cellspacing="0" align="center">
  <tr> 
    <td class="txtblue"> 
      <div align="left"><b>Crew Comments</b></div>
    </td>
    <td class="tablebody" colspan="3">
      <div align="left"><%=crew_comm%> </div>
    </td>
  </tr>
  <tr> 
    <td class="txtblue"><b>ED Confirm</b></td>
    <td class="tablebody">
      <div align="left"><%=ed_check%></div>
    </td>
    <td class="txtblue"><b>Confirm Date</b></td>
    <td class="tablebody">
      <div align="left"><%=checkdate%></div>
    </td>
  </tr>
  <tr>
    <td class="txtblue"> 
      <div align="left"><b>ED Comments</b></div>
    </td>
    <td class="tablebody" colspan="3">
      <div align="left"><%=comments%></div>
    </td>
  </tr>
</table>
</body>
</html>
