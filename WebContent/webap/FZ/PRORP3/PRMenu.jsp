<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="java.sql.*,java.net.URLEncoder"%>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) {		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} 


//String GdYear = "2005";//request.getParameter("GdYear");

String fyy = request.getParameter("fyy");
String fmm = request.getParameter("fmm");
//取得考績年度
String GdYear = fz.pr.orp3.GdYear.getGdYear(fyy+"/"+fmm);

String fdd = request.getParameter("fdd");
String fltno = request.getParameter("fltno").trim();
String acno = (String)session.getAttribute("fz.acno");

String LingPar = "?fyy="+fyy+"&fmm="+fmm+"&fdd="+fdd+"&fltno="+fltno+"&GdYear="+GdYear+"&acno="+acno;
/*
String sqlDa13 = "SELECT da13_acno "+
				"FROM fzdb.v_ittda13_ci WHERE To_Char(da13_stdl,'yyyy/mm/dd')='"+fyy+"/"+fmm+"/"+fdd+"' "+
				"AND da13_fltno=LPad(UPPER('"+fltno+"'),4,'0') "+
				"order by da13_etdu";
				
try{

dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
conn = dbDriver.connect("jdbc:weblogic:pool:CAL.FZCP02", null);
stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
		ResultSet.CONCUR_READ_ONLY);

myResultSet = stmt.executeQuery(sqlDa13);
		*/		
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>PR Menu</title>
<script language="JavaScript" type="text/JavaScript">
function load(w1,w2){
		/*top.topFrame.location.href=w1;
		top.mainFrame.location.href=w2;*/
		parent.topFrame.location.href=w1;
		parent.mainFrame.location.href=w2;


}
</script>

<link href="style2.css" rel="stylesheet" type="text/css">
</head>

<body><br>
<br>


<table width="90%"  border="0" align="center" cellpadding="2" cellspacing="0">
  <tr>
    <td width="7%" class="top">&nbsp;</td>
    <td colspan="2" class="purple_txt"><strong>Purser's Trip Report PartⅠ-PartII</strong></td>
  </tr>
  <tr>
    <td height="105">&nbsp;</td>
    <td width="3%">&nbsp;</td>
    <td width="90%" valign="top">
      <p class="txtblue">1.<a href="FltIrrList.jsp<%=LingPar%>" target="mainFrame"><u>Flt Irregularity (班機異常及其他事項)</u></a></p>
      <p class="txtblue">2.<a href="flightcrew.jsp<%=LingPar%>" target="mainFrame"><u>Cabin Crew Evaluation  &amp; Print  report(組員考核及列印報表)</u></a></p>

    </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td colspan="2"><span class="purple_txt"></span></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
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
	 // response.sendRedirect("../showmessage.jsp?messagestring="+URLEncoder.encode("系統忙碌中，請稍後再試"));
}
finally
{
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
*/
%>