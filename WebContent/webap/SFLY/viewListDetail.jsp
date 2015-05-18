<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*,java.util.*,ci.db.*,tool.ReplaceAll,java.util.ArrayList" %>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) 
{		
	response.sendRedirect("logout.jsp");
}

String sernno	=	request.getParameter("sernno");
String fdate_y  =   null;
String fdate_m  =   null;
String fdate_d  =   null;
String allFltno =	null;
String sector   =	null;
String fdate	=	null;
String fleet	=	null; 
String acno		=	null;
String purserName	= null;
String inspector	= null;
String qa		=   null;
String comm     =   null;
String process  = null;
String qa_show = null; 
String comm_show =null; 
String process_show = null;

StringBuffer sb = new StringBuffer();
String siNo = null;
String fiNo = null;
String siDsc = null;
String fiDsc = null;
int subcount=1;
int count=1;


Connection conn = null;
Statement stmt = null;
Statement stmt2 = null;
Statement stmt3 = null;
Statement stmt4 = null;

ResultSet rs = null;
ResultSet rs2 = null;
ResultSet rs3 = null;
ResultSet rs4 = null;

String sql = null;
String sql2 = null;
String sql3 = null;
String sql4 = null;

String check0 = null;
String check1 = null;
String check2 = null;
String checked = null;
String remark = null;
String lsflag = null;

ConnDB cn = new ConnDB();
Driver dbDriver = null;
try
{
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);

stmt   = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
stmt2  = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
stmt3  = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
stmt4  = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);

sql = "select fltno, trip, fleet, acno, purname, instname, to_char(fltd,'yyyymmdd') as fltd, to_char(fltd,'yyyy') as fdate_y, to_char(fltd,'mm') as fdate_m, to_char(fltd,'dd') as fdate_d, NVL(qa, '　') qa, NVL(comm, '　') comm, NVL(process, '　') process from egtstti where sernno = '"+ sernno+ "'";

rs = stmt.executeQuery(sql); 
while(rs.next())
{
	 	allFltno = rs.getString("fltno");
		sector = rs.getString("trip");
		fdate = rs.getString("fltd");
	 	fleet = rs.getString("fleet");
		acno = rs.getString("acno");
		purserName = rs.getString("purname");
	 	inspector = rs.getString("instname");
		fdate_y = rs.getString("fdate_y");
		fdate_m = rs.getString("fdate_m");
		fdate_d = rs.getString("fdate_d");
		qa = rs.getString("qa");
		comm = rs.getString("comm");
		process= rs.getString("process");

	//使用者可看到分行	
	    qa_show = ReplaceAll.replace(qa, "\r\n", "<br>"); 
		comm_show = ReplaceAll.replace(comm, "\r\n", "<br>"); 
		process_show = ReplaceAll.replace(process, "\r\n", "<br>");
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>View Check List</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script language="Javascript" type="text/javascript" src="../FZ/js/subWindow.js"></script>
<style type="text/css">
<!--
.style23 {color: #FF0000}
.style24 {color: #000000}
.style25 {color: #000000; font-size: 12px; }
-->
</style>
<script language="javascript" type="text/javascript">
function downreport()
{
	location.replace("viewListDetail_download.jsp");
}
</script>
</head>

<%
sb.append("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">"+"\r\n");	
sb.append("<html>"+"\r\n");	
sb.append("<head>"+"\r\n");	
sb.append("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=big5\">"+"\r\n");	
sb.append("<title>View Check List</title>"+"\r\n");	
sb.append("<style type=\"text/css\">"+"\r\n");	
sb.append("<!--"+"\r\n");	
sb.append(".style23 {color: #FF0000}"+"\r\n");	
sb.append(".style24 {color: #000000}"+"\r\n");	
sb.append(".style25 {color: #000000; font-size: 12px;}"+"\r\n");	
sb.append(".txttitletop {font-family:Verdana, Arial, Helvetica, sans-serif;	font-size: 16px; line-height: 22px; color: #464883; font-weight: bold;}"+"\r\n");	
sb.append(".txtblue {font-size: 12px; line-height: 13.5pt; color: #464883; font-family: Verdana;}"+"\r\n");	
sb.append(".txtred {font-size: 12px;line-height: 13.5pt;color: red;	font-family: Verdana;}"+"\r\n");
sb.append(".tablehead {font-family: Arial, Helvetica, sans-serif; background-color: #006699; font-size: 12px; text-align: center;font-style: normal;	font-weight: bold;	color: #FFFFFF;}"+"\r\n");	
sb.append(".tablebody {font-family:細明體, 新細明體, Courier New; font-size: 10pt; text-align: center;	border: 1px solid;}"+"\r\n");	
sb.append(".tablehead3 {font-family: Arial, Helvetica, sans-serif;background-color: #006699;	font-size: 10pt;text-align: center;	font-style: normal;	font-weight: normal;color: #FFFFFF;}"+"\r\n");	
sb.append("-->"+"\r\n");	
sb.append("</style>"+"\r\n");	
sb.append("</head>"+"\r\n");	

%>
<body>
<BR>
<%
sb.append("<body><BR>"+"\r\n");	
%>

 <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
 	<tr>
	<td width="20%">&nbsp;</td>
	<td width="60%"><div align="center" class="txttitletop"><span class="style14"><strong>Cabin Safety Check List </strong></div></td>
 		<td width="20%">
 <div align="right"><a href="javascript:window.print()"> <img src="images/print.gif" width="17" height="15" border="0" alt="列印"></a>&nbsp;&nbsp;<input type="button" name="rep" id="rep" value="Download File" onClick="downreport();">
        　</div>
      </td>
  </tr>
</table>
<%
sb.append("<table width=\"90%\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">"+"\r\n");
sb.append("<tr>"+"\r\n");	
sb.append("<td width=\"20%\">&nbsp;</td>"+"\r\n");	
sb.append("<td width=\"60%\"><div align=\"center\" class=\"txttitletop\"><span class=\"style14\"><strong>Cabin Safety Check List </strong></div></td>"+"\r\n");	
sb.append("<td width=\"20%\">&nbsp;"+"\r\n");	
sb.append("</td>"+"\r\n");	
sb.append("</tr>"+"\r\n");	
sb.append("</table>"+"\r\n");	
%>
  <table width="90%"  border="2" align="center" cellpadding="0" cellspacing="0" class="table_border2">        
  <tr class="txtblue">
 	<td width="62%"><div align="left" class="style24">&nbsp;Flight：<%=allFltno%> 　Sector：<%=sector%> </div></td>
    <td width="38%"><div align="left" class="style24">&nbsp;Date：<%=fdate_y%>Y <%=fdate_m%>M<%=fdate_d%>D</div></td>
  </tr> 
  <tr class="txtblue">
 	<td width="62%"><div align="left" class="style24">&nbsp;A/C：<%=fleet%>　(<%=acno%>)　　　　CM：<%=purserName%></div></td>
    <td width="38%"><div align="left" class="style24">&nbsp;Inspector：<%=inspector%></div></td>
  </tr> 
</table>
<%
sb.append("<table width=\"90%\"  border=\"2\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" class=\"table_border2\"> "+"\r\n");
sb.append("<tr class=\"txtblue\">"+"\r\n");	
sb.append("<td width=\"62%\"><div align=\"left\" class=\"style24\">&nbsp;Flight："+allFltno+"　Sector："+sector+"</div></td>"+"\r\n");	
sb.append("<td width=\"38%\"><div align=\"left\" class=\"style24\">&nbsp;Date："+fdate_y+"Y"+fdate_m+"M"+fdate_d+"D</div></td>"+"\r\n");	
sb.append("</tr>"+"\r\n");	
sb.append("<tr class=\"txtblue\">"+"\r\n");	
sb.append("<td width=\"62%\"><div align=\"left\" class=\"style24\">&nbsp;A/C："+fleet+"  ("+acno+")　　　　CM："+purserName+"</div></td>"+"\r\n");	
sb.append("<td width=\"38%\"><div align=\"left\" class=\"style24\">&nbsp;Inspector："+inspector+"</div></td>"+"\r\n");	
sb.append("</tr>"+"\r\n");	
sb.append("</table>"+"\r\n");	
%>
<%
GregorianCalendar cal1 = new GregorianCalendar();
GregorianCalendar cal2 = new GregorianCalendar();

//2009/07/20 後項目異動
cal1.set(Calendar.YEAR,2009);
cal1.set(Calendar.MONTH,7-1);
cal1.set(Calendar.DATE,20);

//Fltdt
cal2.set(Calendar.YEAR,Integer.parseInt(fdate_y));
cal2.set(Calendar.MONTH,Integer.parseInt(fdate_m)-1);
cal2.set(Calendar.DATE,Integer.parseInt(fdate_d));
%>

  <table width="90%" border="2" align="center" cellpadding="0" cellspacing="0" class="table_border2">
  <tr class="tablehead3">
    <td height="5" colspan="2"><div align="center"><strong>Item</strong></div></td>
    <td width="4%" ><div align="center"><strong>Yes</strong></div></td>
<%
if(cal2.before(cal1))
{
%>
    <td width="4%" ><div align="center"><strong>No</strong></div></td>
<%
}
else
{
%>
    <td width="4%" ><div align="center"><strong>NDIP</strong></div></td>
<%
}
%>    
    <td width="4%" ><div align="center"><strong>N/A</strong></div></td>
    <td width="28%" ><div align="center"><strong>Remark</strong></div></td>
  </tr>
<%

sb.append("<table width=\"90%\" border=\"2\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" class=\"table_border2\">"+"\r\n");	
sb.append("<tr class=\"tablehead3\">"+"\r\n");	
sb.append("<td height=\"5\" colspan=\"2\"><div align=\"center\"><strong>Item</strong></div></td>"+"\r\n");	
sb.append("<td width=\"4%\" ><div align=\"center\"><strong>Yes</strong></div></td>"+"\r\n");	

if(cal2.before(cal1))
{
sb.append("<td width=\"4%\" ><div align=\"center\"><strong>No</strong></div></td>"+"\r\n");	
}
else
{
sb.append("<td width=\"4%\" ><div align=\"center\"><strong>NDIP</strong></div></td>"+"\r\n");	
}
sb.append("<td width=\"4%\" ><div align=\"center\"><strong>N/A</strong></div></td>"+"\r\n");	
sb.append("<td width=\"28%\" ><div align=\"center\"><strong>Remark</strong></div></td>"+"\r\n");	
sb.append("</tr>"+"\r\n");	

sql2 = "select * from egtstfi where flag='Y' "+ 
       "AND itemno IN (SELECT kin  FROM egtstsi  WHERE  itemno IN (SELECT itemno  FROM egtstdt WHERE sernno='"+sernno+"')) "+ 
	   "order by itemno";
//out.print("sql2= "+sql2+"<br>");
rs2 = stmt2.executeQuery(sql2); 
	  	  
if(rs2 != null)
{
	while(rs2.next())
	{
		fiNo = rs2.getString("itemno");
	  	fiDsc = rs2.getString("itemDsc");
%>
	  	<tr class="txtblue">
    		<td colspan="6"><div align="left" class="style24"><strong>&nbsp;<%=count%>.<%=fiDsc%></strong></div></td>
	    </tr>  
<% 
		sb.append("<tr class=\"txtblue\">"+"\r\n");	
		sb.append("<td colspan=\"6\"><div align=\"left\" class=\"style24\"><strong>&nbsp;"+count+"."+fiDsc+"</strong></div></td>"+"\r\n");	
		sb.append("</tr> "+"\r\n");	

		sql3 = "select * from egtstsi where kin='"+fiNo+"' and sflag= 'Y' AND itemno IN (SELECT itemno FROM egtstdt WHERE sernno='"+sernno+"') order by itemdsc";
		rs3 = stmt3.executeQuery(sql3); 
					  
		if(rs3 != null)
		{
					    
	  		while(rs3.next())
			{
				siNo = rs3.getString("itemno");
	  			siDsc = rs3.getString("itemdsc");
				String siNo2 = count +"."+ subcount;
                //remark欄內如值為 null 則轉為全形空白字元
				sql4 = "select sernno, itemno, flag, NVL(remark, '　')　remark from egtstdt where sernno ='"+sernno+"' and itemno = '"+siNo+"'";
				rs4 = stmt4.executeQuery(sql4);
				
				check1 = "";
				check2 = "";
				check0 = "";
				checked = "<img src='images/check.gif' width='17' height='15' border='0' >";
				String checkedforfile = "V";
				String check1forfile = "";
				String check2forfile = "";
				String check0forfile = "";
				remark = "　";

				while(rs4.next())
				{	
					lsflag = rs4.getString("flag");
					if( lsflag.equals("1"))
						{
							check1=" "+checked+"";
							check1forfile=" "+checkedforfile+"";
					    }
					if( lsflag.equals("2"))
						{
							check2=" "+checked+"";
							check2forfile=" "+checkedforfile+"";
						}
					if( lsflag.equals("0"))
						{
							check0=" "+checked+"";
							check0forfile=" "+checkedforfile+"";
						}
					remark = rs4.getString("remark");
				}
%>
		  <tr class="txtblue">
			<td width="4%"><div align="center" class="style24"><%=siNo2%></div></td>
			<td width="56%"><div align="left" class="style24"><%=siDsc%></div></td>
			<td width="4%" ><div align="center" class="style24"><%=check1%>&nbsp;</div>
			<div align="center" class="style24"></div></td>
			<td width="4%" ><div align="center" class="style24"><%=check2%>&nbsp;</div>
			<div align="center" class="style24"></div></td>
			<td width="4%" ><div align="center" class="style24"><%=check0%>&nbsp;</div>
			<div align="center" class="style24"></div></td>
			<td width="28%" >
			  <div align="left" class="style24"><%= remark%>
			</div></td>
		  </tr>  
<%		
			sb.append("<tr class=\"txtblue\">"+"\r\n");	
			sb.append("<td width=\"4%\"><div align=\"center\" class=\"style24\">"+siNo2+"</div></td>"+"\r\n");	
			sb.append("<td width=\"56%\"><div align=\"left\" class=\"style24\">"+siDsc+"</div></td>"+"\r\n");	
			sb.append("<td width=\"4%\" ><div align=\"center\" class=\"txtred\">"+check1forfile+"&nbsp;</div><div align=\"center\" class=\"style24\"></div></td>"+"\r\n");	
			sb.append("<td width=\"4%\" ><div align=\"center\" class=\"txtred\">"+check2forfile+"&nbsp;</div><div align=\"center\" class=\"txtred\"></div></td>"+"\r\n");	
			sb.append("<td width=\"4%\" ><div align=\"center\" class=\"txtred\">"+check0forfile+"&nbsp;</div><div align=\"center\" class=\"txtred\"></div></td>"+"\r\n");	
			sb.append("<td width=\"28%\" >"+"\r\n");	
			sb.append("<div align=\"left\" class=\"style24\">"+remark+"</div></td>"+"\r\n");	
			sb.append("</tr> "+"\r\n");	
			
			subcount++;
			}
		}
		subcount=1;
	 count++;
	}
}
%>		
</table>
<%
sb.append("</table>"+"\r\n");	
%>

<%
if(cal2.before(cal1))
{
%>
<table width="90%" border="2" align="center" cellpadding="0" cellspacing="0" class="table_border2">
  <tr class="tablehead">
    <td height="5" colspan="5"><div align="left"><strong>&nbsp;Q&amp;A </strong></div>
    </td>
  </tr>
  <tr class="tablebody">
    <td height="10" colspan="5" bgcolor="#FFFFFF" class="txtblue">
          <div align="left" class="txtblue style24"><%=qa_show%>
      </div></td>
  </tr>
</table>
<%
}	
%>
<table width="90%" border="2" align="center" cellpadding="0" cellspacing="0" class="table_border2">
  <tr class="tablehead3">
    <td height="5" colspan="5"><div align="left"><strong>&nbsp;Comment and Suggestion</strong></div>
    </td>
  </tr>
  <tr class="tablebody" height="50">
    <td height="20" colspan="5" bgcolor="#FFFFFF" class="txtblue" valign="top">
        <div align="left" class="txtblue style24">&nbsp;<%=comm_show%>
      </div></td>
  </tr>
</table>
<%
if(cal2.before(cal1))
{
%>
<table width="90%" border="2" align="center" cellpadding="0" cellspacing="0" class="table_border2">
  <tr class="tablebody">
    <td width="7%" height="1" bgcolor="#FFFFFF"><div align="center" class="style11 style12 style23">收文
    </div></td>
    <td width="34%" bgcolor="#FFFFFF"><div align="center" class="style11 style12 style23">擬辦</div></td>
    <td width="26%" bgcolor="#FFFFFF"><div align="center" class="style13 style23">複核</div></td>
    <td width="26%" bgcolor="#FFFFFF"><div align="center" class="style13 style23">批示</div></td>
    <td width="7%" bgcolor="#FFFFFF"><div align="center" class="style13 style23">複閱</div></td>
  </tr>
  <tr class="tablebody">
        <td width="7%" height="150" bgcolor="#FFFFFF">&nbsp;</td>
        <td width="34%" height="150" bgcolor="#FFFFFF">
          <div align="left" class="style25"><%=process_show%>
        </div></td>
        <td width="26%" height="150" bgcolor="#FFFFFF">&nbsp;</td>
        <td width="26%" height="150" bgcolor="#FFFFFF">&nbsp;</td>
        <td width="7%" height="150" bgcolor="#FFFFFF">&nbsp;</td>
  </tr>
</table>
<%
}	
%>
<%
if(cal2.before(cal1))
{
sb.append("<table width=\"90%\" border=\"2\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" class=\"table_border2\">"+"\r\n");	
sb.append("<tr class=\"tablehead\">"+"\r\n");	
sb.append("<td height=\"5\" colspan=\"5\"><div align=\"left\"><strong>&nbsp;Q&amp;A </strong></div></td>"+"\r\n");	
sb.append("</td>"+"\r\n");	
sb.append("</tr>"+"\r\n");	
sb.append("<tr class=\"tablebody\">"+"\r\n");	
sb.append("<td height=\"10\" colspan=\"5\" bgcolor=\"#FFFFFF\" class=\"txtblue\">"+"\r\n");	
sb.append("<div align=\"left\" class=\"txtblue style24\">"+qa_show+"\r\n");	
sb.append("</div></td>"+"\r\n");	
sb.append("</tr>"+"\r\n");	
sb.append("</table>"+"\r\n");	
}
sb.append("<table width=\"90%\" border=\"2\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" class=\"table_border2\">"+"\r\n");	
sb.append("<tr class=\"tablehead3\">"+"\r\n");	
sb.append("<td height=\"5\" colspan=\"5\"><div align=\"left\"><strong>&nbsp;Comment and Suggestion</strong></div></td>"+"\r\n");	
sb.append("</tr>"+"\r\n");	
sb.append("<tr class=\"tablebody\" height=\"50\">"+"\r\n");	
sb.append("<td height=\"20\" colspan=\"5\" bgcolor=\"#FFFFFF\" class=\"txtblue\" valign=\"top\">"+"\r\n");	
sb.append("<div align=\"left\" class=\"txtblue style24\">&nbsp;"+comm_show+"\r\n");	
sb.append("</div></td>"+"\r\n");	
sb.append("</tr>"+"\r\n");	
sb.append("</table>"+"\r\n");	

if(cal2.before(cal1))
{
sb.append("<table width=\"90%\" border=\"2\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" class=\"table_border2\">"+"\r\n");	
sb.append("<tr class=\"tablebody\">"+"\r\n");	
sb.append("<td width=\"7%\" height=\"1\" bgcolor=\"#FFFFFF\"><div align=\"center\" class=\"style11 style12 style23\">收文</div></td>"+"\r\n");	
sb.append("<td width=\"34%\" bgcolor=\"#FFFFFF\"><div align=\"center\" class=\"style11 style12 style23\">擬辦</div></td>"+"\r\n");	
sb.append("<td width=\"26%\" bgcolor=\"#FFFFFF\"><div align=\"center\" class=\"style13 style23\">複核</div></td>"+"\r\n");	
sb.append("<td width=\"26%\" bgcolor=\"#FFFFFF\"><div align=\"center\" class=\"style13 style23\">批示</div></td>"+"\r\n");	
sb.append("<td width=\"7%\" bgcolor=\"#FFFFFF\"><div align=\"center\" class=\"style13 style23\">複閱</div></td>"+"\r\n");	
sb.append("</tr>"+"\r\n");	
sb.append("<tr class=\"tablebody\">"+"\r\n");	
sb.append("<td width=\"7%\" height=\"150\" bgcolor=\"#FFFFFF\">&nbsp;</td>"+"\r\n");	
sb.append("<td width=\"34%\" height=\"150\" bgcolor=\"#FFFFFF\"><div align=\"left\" class=\"style25\">"+process_show+"</div></td>"+"\r\n");	
sb.append("<td width=\"26%\" height=\"150\" bgcolor=\"#FFFFFF\">&nbsp;</td>"+"\r\n");	
sb.append("<td width=\"26%\" height=\"150\" bgcolor=\"#FFFFFF\">&nbsp;</td>"+"\r\n");	
sb.append("<td width=\"7%\" height=\"150\" bgcolor=\"#FFFFFF\">&nbsp;</td>"+"\r\n");	
sb.append("</tr>"+"\r\n");	
sb.append("</table>"+"\r\n");	
}
%>
<!-- <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
	<td width="30%"><font face="標楷體">&nbsp;表單編號:F-EZ006</font></td>
	<td width="50%">&nbsp;</td>
 	<td width="20%" align="right"><font face="標楷體">&nbsp;版本:AA&nbsp;&nbsp;</font></td>
  </tr>
</table> -->
<%
/* sb.append("<table width=\"90%\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">"+"\r\n");	
sb.append("<tr>"+"\r\n");	
sb.append("<td width=\"30%\"><font face=\"標楷體\">&nbsp;表單編號:F-EZ006</font></td>"+"\r\n");	
sb.append("<td width=\"50%\">&nbsp;</td>"+"\r\n");	
sb.append("<td width=\"20%\" align=\"right\"><font face=\"標楷體\">&nbsp;版本:AA&nbsp;&nbsp;</font></td>"+"\r\n");	
sb.append("</tr>"+"\r\n");	
sb.append("</table>"+"\r\n");	 */

}
catch(Exception e){
	out.print(e.toString());
}
finally{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(rs2 != null) rs2.close();}catch(SQLException e){}
	try{if(rs3 != null) rs3.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(stmt2 != null) stmt2.close();}catch(SQLException e){}
	try{if(stmt3 != null) stmt3.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>

</body>
</html>
<%
sb.append("</body>"+"\r\n");	
sb.append("</html>"+"\r\n");	
session.setAttribute("sb",sb);
%>