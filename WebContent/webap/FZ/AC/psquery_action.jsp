<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="java.sql.*,fz.*,ci.db.*"%>
<%
/*
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
*/
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
	//response.sendRedirect("../sendredirect.jsp");
} else{
String sdate =  request.getParameter("sdate");
String edate =  request.getParameter("edate");

String sel_fltno = request.getParameter("fltno");
String fdatemm = null;


//檢查班表是否公布
swap3ac.PublishCheck pc = new swap3ac.PublishCheck(edate.substring(0,4), edate.substring(5,7));

 if(!pc.isPublished()){
%>
<p  style="background-color:#99FFFF;color:#FF0000;font-family:Verdana;font-size:10pt;padding:5pt;text-align:center;"><%=edate.substring(0,7)%> 班表尚未正式公布</p>
<%
}else{



int count = 0;

Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
ResultSet rs = null;
boolean t = false;

ArrayList empnoAL= new ArrayList();
ArrayList sernAL= new ArrayList();
ArrayList cnameAL= new ArrayList();
ArrayList fdateAL= new ArrayList();
ArrayList fltnoAL= new ArrayList();
ArrayList tripnoAL= new ArrayList();
ArrayList homebaseAL= new ArrayList();
ArrayList occuAL= new ArrayList();
ArrayList put_dateAL= new ArrayList();
ArrayList commAL= new ArrayList();

String bcolor = "";
try
{
ConnDB cn = new ConnDB();
cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);

//dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
//conn = dbDriver.connect("jdbc:weblogic:pool:CAL.FZCP02", null);
stmt = conn.createStatement();

chkUser cu = new chkUser();
cu.findCrew(sGetUsr);
String base = cu.getBase();
String occu = cu.getOccu();
String xwhere = null;
 if(occu.equals("PR")){
	xwhere = " occu ='PR' ";

}else{
	xwhere=" occu <> 'PR' ";
}

//顯示可選取之班表, 只顯示本站組員   cabin crew/FA,FS,PR  flight crew/CA.... 
String sql = null;
if("".equals(sel_fltno) ){

	
		sql = "SELECT empno, sern, cname, fdate, fltno, tripno, homebase, occu, to_char(put_date,'mm/dd') put_date, comments "
		+"FROM   fztsput WHERE To_Date(fdate,'yyyy/mm/dd') BETWEEN To_Date('"+sdate+" 0000','yyyy/mm/dd hh24mi') "
		+"AND   To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi')  AND homebase='"+(String)session.getAttribute("base")+"' "
		+"AND "+xwhere+" ORDER BY fdate,fltno ";
	
	
}else{


		sql = "SELECT empno, sern, cname, fdate, fltno, tripno, homebase, occu, to_char(put_date,'mm/dd') put_date, comments "
		+"FROM   fztsput WHERE To_Date(fdate,'yyyy/mm/dd') BETWEEN To_Date('"+sdate+" 0000','yyyy/mm/dd hh24mi') "
		+"AND   To_Date('"+edate+" 2359','yyyy/mm/dd hh24mi')  AND LPad(fltno,4,'0') = LPad('"+sel_fltno+"',4,'0') "
		+"AND homebase='"+(String)session.getAttribute("base")+"' AND "+xwhere+" ORDER BY fdate,fltno ";



}


rs = stmt.executeQuery(sql); 

	while (rs.next()){
			
			empnoAL.add(rs.getString("empno"));
			sernAL.add(rs.getString("sern"));
			cnameAL.add(rs.getString("cname"));
			fdateAL.add(rs.getString("fdate"));
			fltnoAL.add(rs.getString("fltno"));
			tripnoAL.add(rs.getString("tripno"));
			homebaseAL.add(rs.getString("homebase"));
			occuAL.add(rs.getString("occu"));
			put_dateAL.add(rs.getString("put_date"));
			commAL.add(rs.getString("comments"));
		
	}			
}catch (Exception e)
{
	  t = true;
}
finally
{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
	
%>

<html>
<head>
<title>Put Schedule Query</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="../menu.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
if(empnoAL.size() == 0){
%>
<p  style="background-color:#99FFFF;color:#FF0000;font-family:Verdana;font-size:10pt;padding:5pt;text-align:center;">NO DATA!!</p>

<%
}else{

//寫入log

fz.writeLog wl = new fz.writeLog();

wl.updLog((String)session.getAttribute("userid"), request.getRemoteAddr(),request.getRemoteHost(), "FZ420");

%>
<div align="center">

  <form name="form1" method="post" action="updps_action.jsp">
    <table width="90%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td width="5%" height="47">&nbsp;</td>
      <td width="90%"><div align="center"><span class="txttitletop">Put Schedule Query(可換班表查詢)<br>
        </span><span class="txtblue">You can query the crew by click Name column (點選姓名可查詢該組員資料)
        </span><span class="txtblue"><br>
		</span></div>
      </td>
      <td width="5%" valign="bottom">
        <div align="right"><a href="javascript:window.print()"> <img src="../images/print.gif" width="17" height="15" border="0" alt="列印"></a> 
        </div>      </td>
    </tr>
  </table>
    <table width="95%" height="53" border="0" align="center" cellpadding="0" cellspacing="0" valign="middle">
      <tr class="tablehead"> 
        <td height="21" class="tablehead3">Empno</td>
        <td class="tablehead3">Sern</td>
        <td class="tablehead3">Name</td>
        <td class="tablehead3">Fdate</td>
		<td class="tablehead3">Fltno</td>
        <td class="tablehead3">TripNo</td>
        <td class="tablehead3">Occu</td>
		<td class="tablehead3">Comm</td>
        <td class="tablehead3">Put Date</td>
      </tr>
      <%
  for(int i=0;i<empnoAL.size();i++){

	if (i%2 == 0)	{
		bcolor = "#CCCCCC";
	}	else{
		bcolor = "#FFFFFF";
	}
%>
      <tr bgcolor="<%=bcolor %>"> 
        <td height="26" valign="middle" class="tablebody"> 
        <div align="center"><acronym title="compare schedule"><%=empnoAL.get(i) %></acronym></div>        </td>
        <td valign="middle" class="tablebody"> 
          <div align="center"><%=sernAL.get(i) %></div>        </td>
        <td valign="middle" class="tablebody"> 
          <div align="center"><a href="crewquery.jsp?tf_ename=&tf_sess1=&tf_sess2=&tf_empno=<%=empnoAL.get(i)%>" target="_self"><acronym title="show personal information"><%=cnameAL.get(i) %></acronym></a></div>        </td>
        <td valign="middle" class="tablebody"> 
          <div align="center"><%=fdateAL.get(i)%></div>        </td>
		<td valign="middle" class="tablebody"> 
          <div align="center"><acronym title="flight crew"><%=fltnoAL.get(i)%></acronym></div>        </td>
        <td valign="middle" class="tablebody"> 
          <div align="center"><%=tripnoAL.get(i) %></div>        </td>
        <td valign="middle" class="tablebody"> 
          <div align="center"><%= occuAL.get(i)%></div>        </td>
		<td valign="middle" class="tablebody"> 
          <div align="left"><%= commAL.get(i)%></div>        </td>
        <td valign="middle" class="tablebody"> 
          <div align="center"><%= put_dateAL.get(i)%></div>        </td>
	  </tr>
      <%
		  }

%>
    </table>
  </form>

</div>
<%
}
%>
</body>
</html>
<%

}//end of 班表已公布


}//end of has session
%>