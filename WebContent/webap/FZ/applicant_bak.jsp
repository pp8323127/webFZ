<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.*,java.sql.*,java.util.*,ci.db.*"%>
<html>
<head>
<title>Schedule Put</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" href="menu.css" type="text/css">

<style type="text/css">
<!--

.bu {
	font-family: "細明體";
	font-size: 10pt;
	color: #996666;
	border: 1px dashed #6699cc ;
	background-color: #F5EFA3;
	margin: 1px;
	padding: 1px;	/*#6983AF*/
	
}
-->
</style>

<script language="JavaScript" type="text/JavaScript">
function chk(){
		//document.form1.target="_blank";
	if (document.form1.checkduty.checked==true){
		
		document.form1.action = "sendapp_all.jsp";
		document.form1.submit();
		
	}
	else{
		document.form1.action = "sendapp.jsp";
//		document.form1.target="_blank";
		document.form1.submit();
	}
}
</script>

</head>
<%
/*response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);*/

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
String empno = request.getParameter("empno");
String fyy = request.getParameter("fyy");
String fmm = request.getParameter("fmm");
String mymm = fyy+"/"+fmm;
int cutday = 0;

//get prjcr
applyForm af = new applyForm();
af.setCrewInfo(sGetUsr, mymm);
String prjcr = af.getPrjcr();
af.setCrewInfo(empno, mymm);
String prjcr2 = af.getPrjcr();
//get schedule locked status
chkUser chk = new chkUser();
String chkemp = chk.checkLock(empno);

	if(chkemp.equals("Y") ){	//鎖定狀態為Y
	%>
		<jsp:forward page="showmessage.jsp">
		<jsp:param name="messagestring" value="The Crew didn't open his schedule " />
		</jsp:forward>

	<%
	}

//Get Today************************
GregorianCalendar currentDate = new GregorianCalendar();
int hh = currentDate.get(currentDate.HOUR); //1-12
//int mm = currentDate.get(currentDate.MINUTE); //0-59
int check_day = currentDate.get(currentDate.AM_PM); //0 : AM , 1 : PM
//End******************************
if (hh >= 5 && check_day == 1){ //是否以超過下班時間 17:00
	cutday = 3;//3個工作天
}
else
{
	cutday = 2;//2個工作天
}
//out.println("cutday : " + cutday);
String tripno = null;
String fdate = null;
String fltno = null;
if (empno.equals(sGetUsr)){
%>
	<jsp:forward page="showmessage.jsp">
	<jsp:param name="messagestring" value="被換者帳號錯誤，請重新選擇<br>You can't replace schedule with yourself!!" />
	</jsp:forward>

<%

}
//ConnORA co = null;
Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
Statement stmt2 = null;
ResultSet myResultSet = null;
ResultSet myResultSet2 = null;
boolean t = false;
try{
//retrieve crew schedule
//dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
//conn = dbDriver.connect("jdbc:weblogic:pool:CAL.FZCP02", null);
ConnDB cn = new ConnDB();
cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement();
stmt2 = conn.createStatement();
String citem = null;

int xCount=0;
String bcolor=null;

//************************************2.Get live sche table
ctlTable ct = new ctlTable();
ct.doSet();
//out.println(ct.getTable() + "," + ct.getUpdDate());
//****************************************

//retrieve today + cutday 工作天
myResultSet = stmt.executeQuery("select empno, fdate, dutycode, tripno "+
"from "+ct.getTable()+
" where trim(empno)='"+sGetUsr+"' and (dpt = 'TPE' or dpt=' ') and substr(fdate, 1, 7) = '"+mymm+"' and fdate >= to_char(sysdate + "+cutday+", 'yyyy/mm/dd') and trim(dutycode) not in ('OFF','REST','AL') "+
"group by empno, fdate, dutycode, tripno");

//get crew base information
String cname=null;
String sern=null;
String occu=null;
String base=null;
String sp=null;
String rcname=null;
String rsern=null;
String roccu=null;
String rbase=null;
String rsp=null;

chkUser ck = new chkUser();
String rs = ck.findCrew(sGetUsr);
if (rs.equals("1"))
{
	cname = ck.getName();
	sern = ck.getSern();
	occu = ck.getOccu();
	base = ck.getBase();
	sp = ck.getSpcode();
	if(sp.equals("")) sp = "N";
}
rs = ck.findCrew(empno);
if (rs.equals("1"))
{
	rcname = ck.getName();
	rsern = ck.getSern();
	roccu = ck.getOccu();
	rbase = ck.getBase();
	rsp = ck.getSpcode();
	if(rsp.equals("")) rsp = "N";
}
else
{
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(myResultSet2 != null) myResultSet2.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(stmt2 != null) stmt2.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
	%>
		<jsp:forward page="showmessage.jsp">
		<jsp:param name="messagestring" value="Can not find Substitute Crew<br>無此員工號之資料，請重新輸入被換者員工號" />
		</jsp:forward>
	<%
}
if(occu.equals("FA") || occu.equals("FS")){
	if(!roccu.equals("FA") && !roccu.equals("FS")){
		try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
		try{if(myResultSet2 != null) myResultSet2.close();}catch(SQLException e){}
		try{if(stmt != null) stmt.close();}catch(SQLException e){}
		try{if(stmt2 != null) stmt2.close();}catch(SQLException e){}
		try{if(conn != null) conn.close();}catch(SQLException e){}
		%>
			<jsp:forward page="showmessage.jsp">
			<jsp:param name="messagestring" value="You just can switch duty with FA or FS<br>只可與 FA 或 FS 換班" />
			</jsp:forward>
		<%
	}
}
%>

<body bgcolor="#FFFFFF" text="#000000">

  <form name="form1" method="post"  onSubmit="chk()" >

            
  <div align="center"><span class="txtblue"> </span>
<table width="70%" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td class="txtblue">資料庫最後更新時間(Last update)：<span class="txtxred">TPE&nbsp;<%=ct.getUpdDate()%> </span><a href="apply_readme.htm" target="_blank" class="bu" >&nbsp;填申請單流程說明&nbsp;</a><br>
          <strong></span><span class="txtxred">
		The following shedule is for reference only. For official up-to-date schedule information, please contact Scheduling Department.
            <br>
        下列班表僅供參考，請向組員派遣部門確認個人正式班表任務。        </span></strong> </td>
    </tr>
  </table>
    <span class="txtblue"><b><br>
    Applicant</b></span><br>
                <span class="txtblue"><%=cname%> <%=sGetUsr%> <%=sern%> <%=occu%> <%=base%> SP:<%=sp%> CR:<%=prjcr%></span>
                <table width="65%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td class="tablehead">FltDate</td>
          <td class="tablehead">FltNo</td>
          <td class="tablehead">TripNo</td>
          <td class="tablehead">Detail</td>
          <td class="tablehead">Put</td>
        </tr>
        <%
		int c = 0;
if (myResultSet != null)
{
		while (myResultSet.next())
	{ 	c++;
			tripno = myResultSet.getString("tripno").trim();
			if (tripno.equals("")) {tripno = "0000";}
			fdate = myResultSet.getString("fdate").trim();
			fltno = myResultSet.getString("dutycode").trim();			
			xCount++;
			if (xCount%2 == 0)
			{
				bcolor = "#CCCCCC";
			}
			else
			{
				bcolor = "#FFFFFF";
			}
%>
        <tr bgcolor="<%=bcolor%>">
          <td class="tablebody"><%=fdate%></td>
          <td class="tablebody"><%=fltno%></td>
          <td class="tablebody"><%=tripno%></td>
          <td class="tablebody">
            <div align="center"><a href="schdetail.jsp?fdate=<%=fdate%>&tripno=<%=tripno%>" target="_blank"> <img src="images/red.gif" width="15" height="15" alt="show fly schedule detail" border="0"></a> </div></td>
          <td class="tablebody">
            <div align="center">
              <input type="checkbox" name="checkput" value="<%=fdate%><%=tripno%><%=fltno%>">
          </div></td>
        </tr>
        <%
	}
}
%>
    </table>
              <br>
    <span class="txtblue"><b>Substitute</b></span><br>
                <span class="txtblue"><%=rcname%> <%=empno%> <%=rsern%> <%=roccu%> <%=rbase%> SP:<%=rsp%>  CR:<%=prjcr2%></span>
              <table width="65%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td class="tablehead">FltDate</td>
          <td class="tablehead">FltNo</td>
          <td class="tablehead">TripNo</td>
          <td class="tablehead">Detail</td>
          <td class="tablehead">Put</td>
        </tr>
        <%
myResultSet = stmt.executeQuery("select empno, fdate, dutycode, tripno "+
"from "+ct.getTable()+
" where trim(empno)='"+empno+"' and (dpt = 'TPE' or dpt=' ') and substr(fdate, 1, 7) = '"+mymm+"' and fdate >= to_char(sysdate + "+cutday+", 'yyyy/mm/dd') and trim(dutycode) not in ('OFF','REST','AL') "+
"group by empno, fdate, dutycode, tripno");

int c1 =0;
if (myResultSet != null)
{
		while (myResultSet.next())
	{ 
			c1++;
			tripno = myResultSet.getString("tripno").trim();
			if (tripno.equals("")) {tripno = "0000";}
			fdate = myResultSet.getString("fdate").trim();
			fltno = myResultSet.getString("dutycode").trim();			
			xCount++;
			if (xCount%2 == 0)
			{
				bcolor = "#CCCCCC";
			}
			else
			{
				bcolor = "#FFFFFF";
			}
%>
        <tr bgcolor="<%=bcolor%>">
          <td class="tablebody"><%=fdate%></td>
          <td class="tablebody"><%=fltno%></td>
          <td class="tablebody"><%=tripno%></td>
          <td class="tablebody">
            <div align="center"><a href="schdetail.jsp?fdate=<%=fdate%>&tripno=<%=tripno%>&empno=<%=empno%>" target="_blank"> <img src="images/red.gif" width="15" height="15" alt="show fly schedule detail" border="0"></a></div></td>
          <td class="tablebody">
            <div align="center">
              <input type="checkbox" name="checkput2" value="<%=fdate%><%=tripno%><%=empno%><%=fltno%>">
          </div></td>
        </tr>
        <%
	}
}

%>
    </table>
              <table width="65%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="38%">            <input type="checkbox" name="checkduty" value="Y">
          <span class="small"> <b><font face="Arial, Helvetica, sans-serif" color="#0000FF">Replace 
          all duty&nbsp;(全月互換)</font></b></span> 
          
          <input type="hidden" name="rempno" value="<%=empno%>"> <input type="hidden" name="mymm" value="<%=mymm%>"></td>
          
        <td width="62%"> 
          <div align="left"><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#FF0000">Comments 
            for TPEED</font></b></font><br>
           <!-- <input type="text" name="comments" size="50" value="N" maxlength="50">	-->
			 <input name="comm2" type="text" size="10" maxlength="10">
			 <select name="comments">
			 <option value="已自行查詢，責任自負">已自行查詢，責任自負</option>
			<%
			 myResultSet2 = stmt2.executeQuery("select * from fztccom"); //crew comm
			 
			 if (myResultSet2 != null)
			  {
					while (myResultSet2.next())
				    { 
						
					     citem = myResultSet2.getString("citem");
			 %>
              <option value="<%=citem%>"><%=citem%></option>
			  <%
			  		}
			  }
			  %>
            </select>
          </div>
        </td>
        </tr>
        <tr>
          <td colspan="2"><p class="txtblue">放棄特休假，請在Comments輸入申請者（A）或被換者（R
            )+日期<br>
            Example:A12/17表示申請者放棄12/17特休假,&nbsp;R12/25表示被換者放棄12/25特休假</p>          </td>
          </tr>
    </table>
    </div>          
        
  <p align="center"> 
    <input type="Submit" name="Submit" value="送出任務互換資訊" class="btm">
    </p>
  </form>
</body>
</html>
<%
}
catch (SQLException se)
{
	t = true;
}
finally
{
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(myResultSet2 != null) myResultSet2.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(stmt2 != null) stmt2.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
if(t){
%>
      <jsp:forward page="err.jsp" /> 
<%
}
%>
