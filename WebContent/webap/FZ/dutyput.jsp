<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.*,java.sql.*,ci.db.*"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
  %> <jsp:forward page="sendredirect.jsp" /> <%
} 
//write log
String userip = request.getRemoteAddr();
String userhost = request.getRemoteHost();

writeLog wl = new writeLog();
String wlog = wl.updLog(sGetUsr, userip,userhost, "FZ051");

//String cname = (String) session.getAttribute("cname") ;
String myschmm = null;
String tripno = null;
String fdate = null;
String fltno = null;
String qual = null;
String yy = request.getParameter("pyy");
if (!yy.equals(""))
{
	myschmm = request.getParameter("pyy") + "/" + request.getParameter("pmm");
}
else
{
	myschmm = request.getParameter("mydate");
}

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


int xCount=0;
String bcolor=null;
//************************************2.Get live sche table
ctlTable ct = new ctlTable();
ct.doSet();
//out.println(ct.getTable() + "," + ct.getUpdDate());
//****************************************

//retrieve today + 3 工作天
myResultSet = stmt.executeQuery("select rownum, empno, fdate, dutycode, tripno, qual "+
"from "+ct.getTable()+
" where trim(empno)='"+sGetUsr+"' and (dpt = 'TPE' or dpt=' ') and substr(fdate, 1, 7) = '"+myschmm+"' and fdate >= to_char(sysdate + 2, 'yyyy/mm/dd') and remark is null and trim(dutycode) not in ('OFF','REST','AL') "+
"group by empno, fdate, dutycode, tripno, qual, rownum");

//get crew base information
String cname=null;
String sern=null;
String occu=null;
String base=null;
String rowid=null;
int rownum = 0;

chkUser ck = new chkUser();
String rs = ck.findCrew(sGetUsr);
if (rs.equals("1"))
{
	cname = ck.getName();
	sern = ck.getSern();
	occu = ck.getOccu();
	base = ck.getBase();
}
%>
<html>
<head>
<title>Schedule Put</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" href="menu.css" type="text/css">

</head>

<body bgcolor="#FFFFFF" text="#000000"><br>
<table width="60%" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
        <td class="txtblue">資料庫最後更新時間(Last update)：<span class="txtxred">TPE&nbsp;<%=ct.getUpdDate()%><br>
          <strong> The following shedule is for reference only. For official up-to-date schedule information, please contact Scheduling Department. <br>
下列班表僅供參考，請向組員派遣部門確認個人正式班表任務。 </strong>        </span></td>
    </tr>
</table>
<div align="center" class="txttitletop">
  <br><%=myschmm%> Schedule by trip
  <br><span class="txtblue"><%=cname%> <%=sGetUsr%> <%=sern%> <%=occu%> <%=base%></span>
<form name="form1" method="post" action="updput.jsp">
    <table width="60%" border="0" cellspacing="0" cellpadding="0">
      <tr> 
	  	<td class="tablehead">FltDate</td>
		<td class="tablehead">FltNo</td>
        <td class="tablehead">TripNo</td>
        <td class="tablehead">Qual</td>
		<td class="tablehead">Detail</td>
        <td class="tablehead">Put</td>
		<td class="tablehead">Comm</td>
      </tr>
      <%

if (myResultSet != null)
{
		while (myResultSet.next())
	{ 

			tripno = myResultSet.getString("tripno").trim();
			if (tripno.equals("")) {tripno = "0000";}
			fdate = myResultSet.getString("fdate").trim();
			fltno = myResultSet.getString("dutycode").trim();	
			qual = 	myResultSet.getString("qual");
			rownum = myResultSet.getInt("rownum");
			rownum = xCount+1;
			
			if (rownum < 10){
				rowid = "0" + String.valueOf(rownum);
			}
			else{
				rowid = String.valueOf(rownum);
			}
			
			xCount++;
			if (xCount%2 == 0)
			{
				bcolor = "#CCCCCC";
			}
			else
			{
				bcolor = "#999999";
			}
%>
      <tr bgcolor="<%=bcolor%>"> 
	  	<td class="tablebody"><%=fdate%></td>
		<td class="tablebody"><%=fltno%></td>
        <td class="tablebody"><%=tripno%></td>
		<td class="tablebody"><%=qual%></td>
		<td> 
          <div align="center"><a href="schdetail.jsp?fdate=<%=fdate%>&tripno=<%=tripno%>" target="_blank"> 
            <img src="images/red.gif" width="15" height="15" alt="show fly schedule detail" border="0"></a></div>
        </td>
        <td> 
          <div align="center"> 
            <input name="rowid" type="hidden" id="rowid" value="<%=rowid%>">
            <input type="checkbox" name="checkput" value="<%=rowid%><%=fdate%><%=tripno%><%=fltno%>">
          </div>
        </td>
		<td class="tablebody"><input name="comm" type="text" id="comm" value="no comments" size="50" maxlength="50" onfocus="if(this.value==this.defaultValue)this.value=''" onBlur="if(this.value=='')this.value=this.defaultValue"></td>
      </tr>
      <%
	}
}
if (xCount == 0){
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
%>
	<jsp:forward page="showmessage.jsp">
	<jsp:param name="messagestring" value="No Schedule Found !" />
	</jsp:forward>

<%

}
%>
    </table>
    <br><input type="Submit" name="Submit" value="Put the Schedule" class="btm">
  </form>
<center><iframe src="showbook.jsp" width="800" height="400" align="middle"></iframe></center>
</div>
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