<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="java.sql.*,java.net.URLEncoder,ci.db.*,java.util.ArrayList"%>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} 

String fyy = request.getParameter("fyy");
String fmm = request.getParameter("fmm");
//取得考績年度
String GdYear = fz.pracP.GdYear.getGdYear(fyy+"/"+fmm);
String fdd = request.getParameter("fdd");
String fltno = request.getParameter("fltno").trim();
String pur_name = "";
String pur_sern = "";
String sector = ""; 
String acno = "";
String LingPar = "?fyy="+fyy+"&fmm="+fmm+"&fdd="+fdd+"&fltno="+fltno+"&GdYear="+GdYear;//+"&acno="+acno;
String LingPar3 = "?fyy="+fyy+"&fmm="+fmm+"&fdd="+fdd+"&fltno="+fltno+"&GdYear="+GdYear+"&src=3";//+"&acno="+acno;

String LingPar4 = "?fyy="+fyy+"&fmm="+fmm+"&fdd="+fdd+"&fltno="+fltno+"&GdYear="+GdYear+"&src=4";//+"&acno="+acno;

String LingPar5 = "?fyy="+fyy+"&fmm="+fmm+"&fdd="+fdd+"&fltno="+fltno+"&GdYear="+GdYear+"&src=5";//+"&acno="+acno;

String LingPar6 = "?fyy="+fyy+"&fmm="+fmm+"&fdd="+fdd+"&fltno="+fltno+"&GdYear="+GdYear+"&src=6";//+"&acno="+acno;
//201306
String occu = (String)session.getAttribute("occu");
String uidg = "PR";
if(occu.equals("ZC")){
	uidg = "MC";//掛ZC acting_rank = 'MC' 才要寫報告
}
//**************************************************************************************
Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
ResultSet rs = null;
String sql = null;
boolean hascflt = false;
try
{
	ConnDB cn = new ConnDB();
	//cn.setORP3FZUserCP();
	cn.setORP3EGUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);	
	stmt = conn.createStatement();
	//201306
	//sql = "select to_char(dps.str_dt_tm_loc,'yyyy/mm/dd') fdate,dps.flt_num fltno,to_char(str_dt_tm_loc,'yyyy/mm/dd hh24:mi') stdDt, to_char(str_dt_tm_loc,'hh24mi') ftime, dps.duty_cd dutycd, dps.act_port_a dpt,dps.act_port_b arv,r.acting_rank qual, r.special_indicator from egdb.duty_prd_seg_v dps, egdb.roster_v r where dps.series_num=r.series_num and dps.delete_ind = 'N' AND r.delete_ind='N' AND flt_num = '"+fltno+"' and r.staff_num ='"+sGetUsr+"' AND dps.act_str_dt_tm_gmt BETWEEN  to_date('"+fyy+fmm+fdd+" 00:00','yyyymmdd hh24:mi') AND  To_Date('"+fyy+fmm+fdd+" 23:59:59','yyyymmdd hh24:mi:ss') AND dps.duty_cd='FLY' AND r.acting_rank='PR' order by str_dt_tm_gmt";
	sql = "select to_char(dps.str_dt_tm_loc,'yyyy/mm/dd') fdate,dps.flt_num fltno,to_char(str_dt_tm_loc,'yyyy/mm/dd hh24:mi') stdDt, to_char(str_dt_tm_loc,'hh24mi') ftime, dps.duty_cd dutycd, dps.act_port_a dpt,dps.act_port_b arv,r.acting_rank qual, r.special_indicator from egdb.duty_prd_seg_v dps, egdb.roster_v r where dps.series_num=r.series_num and dps.delete_ind = 'N' AND r.delete_ind='N' AND flt_num = '"+fltno+"' and r.staff_num ='"+sGetUsr+"' AND dps.act_str_dt_tm_gmt BETWEEN  to_date('"+fyy+fmm+fdd+" 00:00','yyyymmdd hh24:mi') AND  To_Date('"+fyy+fmm+fdd+" 23:59:59','yyyymmdd hh24:mi:ss') AND dps.duty_cd='FLY' AND (r.acting_rank='"+uidg+"'  OR Nvl(r.special_indicator,' ') = 'J')order by str_dt_tm_gmt";
	
	rs = stmt.executeQuery(sql);
	
	if(rs.next())
	{
		sector = rs.getString("dpt")+"/"+rs.getString("arv");
	}

	eg.EGInfo egi = new eg.EGInfo(sGetUsr);
	ArrayList objAL = new ArrayList();
    objAL = egi.getObjAL();
    eg.EgInfoObj obj = new eg.EgInfoObj();
    if(objAL.size()>0)
    {
		obj = (eg.EgInfoObj) objAL.get(0);
	}
	pur_name = obj.getCname();
	pur_sern = obj.getSern();
	rs.close();
//*************************************************************************
	sql = "SELECT count(*) c from egtcflt WHERE fltd BETWEEN To_Date('"+fyy+fmm+fdd+" 00:00','yyyymmdd hh24:mi') AND To_Date('"+fyy+fmm+fdd+" 2359','yyyymmdd hh24mi') and fltno = '"+fltno+"' AND psrempn='"+sGetUsr+"'";
	
	rs = stmt.executeQuery(sql);
	
	if(rs.next())
	{
		if(rs.getInt("c") >0)
		{
			hascflt = true;
		}
	}
}
catch (Exception e)
{
	  out.print(e.toString());
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
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>PR Menu</title>
<script language="JavaScript" type="text/JavaScript">
function load(w1,w2)
{
		parent.topFrame.location.href=w1;
		parent.mainFrame.location.href=w2;
}
</script>

<link href="style2.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style1 {
	font-size: 24px;
	font-weight: bold;
}
.style3 {color: #000000}
.style4 {font-size: 18pt}
-->
</style>
</head>

<body>
<br>
<br>

<table width="60%"  border="0" align="center" cellpadding="2" cellspacing="0">
  <tr class="tablehead2">
    <td colspan="7" align="center"><span class="style4">Edit Report</span></td>
  </tr>
  <tr>
    <td colspan="7" align="center">&nbsp;</td>
  </tr>
  <tr class="txttitletop">
    <td align="left" colspan="3" width="36%">Cabin Manager : <%=pur_name%></td><!-- Purser -->
    <td width="32%" colspan="2" align="left">Serial No : <%=pur_sern%></td>
	<td width="32%" colspan="2" align="left">&nbsp;</td>
  </tr>
  <tr class="txttitletop">
    <td align="left" colspan="3" width="36%">Flight No : <%=fltno%></td>
    <td width="32%" colspan="2" align="left">Sector : <%=sector%></td>
	<td width="32%" colspan="2" align="left">Date : <%=fyy+"/"+fmm+"/"+fdd%></td>
  </tr>
  <tr>
    <td colspan="7" align="center">&nbsp;</td>
  </tr>
  <tr>
	<td width="6%" class="txtblue"><div align="left">1. </div></td>
    <td colspan="6"><a href="FltIrrList.jsp<%=LingPar%>" target="mainFrame"><u>班機經常事務</u></a></td>
  </tr>
  <tr>
	<td width="6%" class="txtblue"><div align="left">2. </div></td>
    <td colspan="6"><a href="flightcrew.jsp<%=LingPar%>" target="mainFrame"><u>組員考核</u></a></td>
  </tr>
<%
if(hascflt == true)
{
%>
  <tr>
	<td width="6%" class="txtblue"><div align="left">3. </div></td>
    <td colspan="6"><a href="FltIrrList.jsp<%=LingPar3%>" target="mainFrame"><u>組員事宜</u></a></td>
  </tr>
   <tr>
	<td width="6%" class="txtblue"><div align="left">4. </div></td>
    <td colspan="6"><a href="FltIrrList.jsp<%=LingPar4%>" target="mainFrame"><u>設備\系統</u></a></td>
   </tr>
   <tr>
	<td width="6%" class="txtblue"><div align="left">5. </div></td>
    <td colspan="6"><a href="FltIrrList.jsp<%=LingPar5%>" target="mainFrame"><u>客艙服務</u></a></td>
   </tr>
   <tr>  
	<td width="6%" class="txtblue"><div align="left">6. </div></td>
    <td colspan="6"><a href="FltIrrList.jsp<%=LingPar6%>" target="mainFrame"><u>異常報告</u></a></td>
   </tr>   
<%
}	
else
{
%>
  <tr>
	<td width="6%" class="txtblue"><div align="left">3. </div></td>
    <td colspan="6" class="txtblue"><u>組員事宜</u></td>
  </tr>
   <tr>
	<td width="6%" class="txtblue"><div align="left">4. </div></td>
    <td colspan="6" class="txtblue"><u>設備\系統</u></td>
   </tr>
   <tr>
	<td width="6%" class="txtblue"><div align="left">5. </div></td>
    <td colspan="6" class="txtblue"><u>客艙服務</u></td>
   </tr>
   <tr>  
	<td width="6%" class="txtblue"><div align="left">6. </div></td>
    <td colspan="6" class="txtblue"><u>異常報告</u></td>
   </tr>   
<%
}
%>
</table>
</body>
</html>
<%
/*
}
catch (Exception e)
{
	  t = true;
	  out.print(e.toString());
	 // response.sendRedirect("../showMessage.jsp?messagestring="+URLEncoder.encode("系統忙碌中，請稍後再試"));
}
finally
{
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
*/
%>