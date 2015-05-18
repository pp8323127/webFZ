<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.pracP.*,java.sql.*,ci.db.ConnDB"%>
<%

String uid = request.getParameter("uid");
if(uid == null)
{
	String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
	if (session.isNew() || sGetUsr == null) 
	{		//check user session start first or not login
		response.sendRedirect("../sendredirect.jsp");
	} 
}

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title></title>
<link href="style2.css" rel="stylesheet" type="text/css">

<style type="text/css">
<!--
.style1 {
	font-size: x-large;
	font-weight: bold;
}
.style4 {font-size: medium}
.style5 {
	font-size: x-small;
	font-weight: bold;
}
.style6 {font-size: small}
.style8 {color: #000000}
.style10 {font-size: small; font-weight: bold; color: #000000; }
.style12 {font-size: medium; font-weight: bold; }
.style13 {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 10px;
	font-weight: bold;
}
.style15 {font-size: 12px; font-weight: bold; }
.style16 {font-size: 12px}
.style21 {font-family: Arial, Helvetica, sans-serif; font-size: 14px; }
-->
</style>
</head>
<body>
  <div align="center">
<%
String fltd = request.getParameter("fdate");//yyyy/mm/dd
String fltno = request.getParameter("fltno");//006
String sect = request.getParameter("section");//TPELAX
String cpname = null;
String acno = null;
String psrsern	= null;
String psrname	= null;
String pgroups = null;
String f = null;
String c = null;
String y = null;
String inf = null;
String pxac = null;
String pscore = null;
String reply = null;
String realduty = null;

ArrayList duty	 = new ArrayList();
ArrayList sern	 = new ArrayList();
ArrayList crew	 = new ArrayList();
ArrayList groups = new ArrayList();
ArrayList score = new ArrayList();
ArrayList bp = new ArrayList();

String shift = null;
String shift_mark = null;
String[] sh_time = new String[8];

Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
Statement stmt2 = null;
ResultSet rs = null;
ResultSet rs2 = null;

String theday = null;
int rCount = 0;
String sql = null;
String sql2 = "";

try{
PurReport pr = new PurReport();
ConnDB cn = new ConnDB();
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
		ResultSet.CONCUR_READ_ONLY);
stmt2 = conn.createStatement();


//抓取該班組員名單
sql = "select * from egtcflt where fltd=to_date('"+fltd+"','yyyy/mm/dd') and fltno='"+fltno+"' and sect=upper('"+sect+"')";
//out.println(sql);
rs	= stmt.executeQuery(sql);
if(rs != null)
{
	fz.pracP.pa.GetPADuty_cd gpc = new fz.pracP.pa.GetPADuty_cd();
	while(rs.next())
	{		
		if(null == rs.getString("cpname"))
		{
			cpname = "";
		}
		else
		{
			cpname = rs.getString("cpname");
		}
	
		acno = rs.getString("acno");
		psrsern	= rs.getString("psrsern");
		psrname = rs.getString("psrname");
		pgroups = rs.getString("pgroups");
		//psrEmpno = rs.getString("psrempn");		
		f = rs.getString("book_f");
		c = rs.getString("book_c");
		y = rs.getString("book_y");
		inf = rs.getString("inf");
		pxac = rs.getString("pxac");
		reply = rs.getString("reply");		
		shift = rs.getString("SHIFT");
		shift_mark = rs.getString("SH_REMARK");
		sh_time[0] = rs.getString("SH_ST1");
		sh_time[1] = rs.getString("SH_ET1");
		sh_time[2] = rs.getString("SH_ST2");
		sh_time[3] = rs.getString("SH_ET2");
		if(shift_mark == null) shift_mark= "&nbsp;";
		if(reply == null) reply = "&nbsp;";
		for(int i=0; i<20; i++)
		{
			//if(!rs.getString("sern"+String.valueOf(i+1)).equals("0"))
			if(!rs.getString("sern"+String.valueOf(i+1)).equals("0") && null !=rs.getString("sern"+String.valueOf(i+1)) )
			{
				if("PA".equals(rs.getString("duty"+String.valueOf(i+1))))
				{
					realduty = gpc.getDuty_cd(rs.getString("empn"+String.valueOf(i+1)), fltd, fltno, sect) ;

					duty.add(rs.getString("duty"+String.valueOf(i+1))+"("+realduty+")");
				}
				else
				{
					duty.add(rs.getString("duty"+String.valueOf(i+1)));
				}

				sern.add(rs.getString("sern"+String.valueOf(i+1)));
				crew.add(rs.getString("crew"+String.valueOf(i+1)));
				score.add(rs.getString("score"+String.valueOf(i+1)));
				groups.add(pr.getGroups((String)sern.get(i)));
				bp.add(pr.getBP(fltd, fltno, sect, (String)sern.get(i)));
				//crewEmpnAL.add(rs.getString("empn"+String.valueOf(i+1)));
				/*
				duty.add(rs.getString("duty"+String.valueOf(i+1)));
				sern.add(rs.getString("sern"+String.valueOf(i+1)));
				crew.add(rs.getString("crew"+String.valueOf(i+1)));
				score.add(rs.getString("score"+String.valueOf(i+1)));
				groups.add(pr.getGroups((String)sern.get(i)));
				bp.add(pr.getBP(fltd, fltno, sect, (String)sern.get(i)));
				*/
			}
			else
			{
				i = 20;
			}
		}
	}
}
rs	= stmt.executeQuery("select to_char(sysdate, 'yyyy/mm/dd HH24:MI') theday from dual");
if(rs.next())
{
	theday = rs.getString("theday");
}


%> 
  </div>
<div align="center">
  <span class="style1">CABIN CREW DIVISION</span><p>
  <span class="style12">CM'S TRIP REPORT(PART I)
  </span></div>
  <table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
	  <td colspan="3"><div align="right"><a href="javascript:window.print()"><img src="../images/print.gif" width="17" height="15" border="0" alt="列印"></a></div></td>
    </tr>
    <tr>
      <td>CM : <%=psrname%></td>
	  <td><div align="center">Group : <%=pgroups%></div></td>
	  <td><div align="right">Serial No. : <%=psrsern%></div></td>
    </tr>
    <tr>
      <td>Date : <%=fltd%></td>
	  <td>CI<%=fltno%>&nbsp;&nbsp;<%=sect%></td>
	  <td><div align="right">Capt.&nbsp;&nbsp;<%=cpname%>&nbsp;&nbsp;A/C&nbsp;<%=acno%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Pax.F : <%=f%> &nbsp;C : <%=c%> &nbsp;Y : <%=y%> &nbsp;INF. : <%=inf%></div></td>
    </tr>
</table>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="37" colspan="4" valign="middle"><strong>I.Crew Duty & Grade : </strong>     
     <table width="100%"  border="1" align="center" cellpadding="0" cellspacing="0" >
     <tr bgcolor="#CCCCCC">
      <td><div align="center" class="style5 style6 style8">Duty</div></td>
      <td><div align="center" class="style10">S.No.</div></td>
      <td><div align="center" class="style10">Name</div></td>
      <td><div align="center" class="style10">GRP</div></td>
	  <td><div align="center" class="style10">GRD</div></td>
      <td><div align="center" class="style10">B/P</div></td>
	  <td><div align="center" class="style10">Duty</div></td>
      <td><div align="center" class="style10">S.No.</div></td>
      <td><div align="center" class="style10">Name</div></td>
      <td><div align="center" class="style10">GRP</div></td>
	  <td><div align="center" class="style10">GRD</div></td>
      <td><div align="center" class="style10">B/P</div></td>
    </tr>
<%
for(int i=0; i<20; i++)
{
	rCount++;
	if(rCount > 2 )
	{
		rCount = 1;
	}
	if(rCount == 1)
	{
%>
		<tr>
<%
	}
	if(i<sern.size())
	{
		pscore = (String)score.get(i);
		if(pscore.equals("0")) pscore = "X";
%>
      <td height="26" bgcolor="#CCCCCC"><div align="center" class="style4"><%=duty.get(i)%>&nbsp;</div></td>
      <td height="26"><div align="center" class="style4"><%=sern.get(i)%></div></td>
      <td height="26"><div align="center" class="style4"><%=crew.get(i)%></div></td>
      <td height="26"><div align="center" class="style4"><%=groups.get(i)%></div></td>
	  <td height="26"><div align="center" class="style4"><%=pscore%></div></td>
      <td height="26"><div align="center" class="style4"><%=bp.get(i)%></div></td>
<%
	}
	else{
%>
      <td height="26" bgcolor="#CCCCCC"><div align="center" class="style4">&nbsp;</div></td>
      <td height="26"><div align="center" class="style4">&nbsp;</div></td>
      <td height="26"><div align="center" class="style4">&nbsp;</div></td>
      <td height="26"><div align="center" class="style4">&nbsp;</div></td>
      <td height="26"><div align="center" class="style4">&nbsp;</div></td>
	  <td height="26"><div align="center" class="style4">&nbsp;</div></td>
<%
	}
	if(rCount == 3){
		
%>
		</tr>
<%
	}
}
%>
<!--
    <tr>
	  <td height="50" colspan="1" valign="middle" align="center"><strong>Reply</strong>
      <td height="50" colspan="11" valign="top" class="style21"><%=reply%> </td>
	</tr>
-->
	<tr>
            <td colspan="12" class="style4">Shift Record : <%=shift %> &nbsp; <%=shift_mark %> <br>
			<%
			for(int i=0 ;i<sh_time.length ;i=i+2){
				if(sh_time[i] == null){
					%>
					&nbsp; 
					<%
				}else{
			%>
			第<%=i%>段輪休:<%=sh_time[i]%>~<%=sh_time[i+1]%>
			<%
				}
			}
			%>
			
			</td>
    </tr>
   </table>
  </td>
 </tr>
</table>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
 <tr>
  <td height="37" colspan="4" valign="middle"><strong>II.Crew Performance : </strong>     
    <table width="100%"  border="1" cellpadding="0" cellspacing="0">
		<%
		rCount = 0;
		sql = "select b.yearsern yearsern, a.cname gname, c.gdname gitem, nvl(b.comments,'&nbsp;') gcomm " +
		"from egtcbas a, egtgddt b, egtgdtp c " +
		"where a.empn=b.empn and b.gdtype=c.gdtype and b.fltd=to_date('"+fltd+"','yyyy/mm/dd') and b.fltno='"+fltno+"' and b.sect='"+sect+"' and b.gdtype <> 'GD1' " +
		"order by b.gdtype";
		rs	= stmt.executeQuery(sql);
		if(rs != null)
		{
			while(rs.next())
			{
		%>
          <tr>
            <td width="12%"><span class="style21"><%=rs.getString("gname")%></span></td>
            <td width="13%"><span class="style21"><%=rs.getString("gitem")%></span></td>
            <td width="75%"><span class="style21"><%=rs.getString("gcomm")%></span></td>
          </tr>
		<%
			StringBuffer sb2 = new StringBuffer();
		    sb2.append("");
			sql2 = " select chk.comments comments, hr.cname cname, To_Char(handle_date,'yyyy/mm/dd hh24:mi') handle_date from egtpfchk chk, hrvegemploy hr where yearsern = '"+rs.getString("yearsern")+"' AND chk.handle_userid = hr.employid (+) AND chk.itemclose_date IS NOT null order by handle_unit";
			rs2	= stmt2.executeQuery(sql2);
			while(rs2.next())
			{
				sb2.append(rs2.getString("comments")+" <"+rs2.getString("cname")+" "+rs2.getString("handle_date")+">"+"<br>");
			}

			if(sb2.length()>0)
			{
		%>
		  <tr>
		  	<td><div align="center"><span class="style15">REPLY</span></div></td>
			<td colspan="2"><span class="style21"><%=sb2.toString()%></span></td>
		  </tr>
		<%
			}//if(sb2 != null)
				rCount++;
			}
		}


		if(rCount == 0)
		{
			%>
		  <tr>
            <td colspan="3">本欄空白</td>
		  </tr>
			<%
		}
		%>
        </table>
	  </td>
    </tr>
  </table>
  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td height="151" colspan="4" valign="top"><strong>III.Flight Irregularity : </strong>
        <table width="100%"  border="1" cellpadding="0" cellspacing="0">
		<%
		rCount = 0;
		sql = "select a.itemdsc desc1, b.itemdsc desc2, nvl(b.comments,'&nbsp;') comm, nvl(b.reply,'&nbsp;') reply, b.clb,b.mcr,b.rca,b.emg,b.yearsern yearsern "+
		"from egtcmpi a, egtcmdt b " +
		"where a.itemno=b.itemno and b.fltd=to_date('"+fltd+"','yyyy/mm/dd') and b.fltno='"+fltno+
		"' and b.sect='"+sect+"' and b.flag='1' order by b.newdate";
		rs	= stmt.executeQuery(sql);

		if(rs != null)
		{
			while(rs.next())
			{
		%>
          <tr>
            <td width="15%"><div align="center"><span class="style21"><%=rs.getString("desc1")%></span></div></td>
            <td width="20%"><div align="center"><span class="style21"><%=rs.getString("desc2")%></span></div></td>
            <td width="49%"><span class="style21"><%=rs.getString("comm")%></span></td>
            <td width="4%">
			<%
			if(null != rs.getString("clb"))
			{
				out.print("CLB:"+rs.getString("clb"));
			}
			%>
			</td>
            <td width="4%">
			<%
			if(null != rs.getString("mcr"))
			{
				out.print("MCR:"+rs.getString("mcr"));
			}
			%>
			</td>	
			
			<td width="4%">
			<%
			if(null != rs.getString("rca"))
			{
				out.print("RCA:"+rs.getString("rca"));
			}
			%>
			</td>			

            <td width="4%">
			<%
			if(null != rs.getString("emg"))
			{
				out.print("EMG:"+rs.getString("emg"));
			}
			%>
			</td>
          </tr>
<%
StringBuffer sb = new StringBuffer();
if(rs.getString("reply") !=null && !"".equals(rs.getString("reply")))
{
sb.append(rs.getString("reply")+"<br>");
}
//sql2 = " select * from egtprchk where yearsern = '"+rs.getString("yearsern")+"' order by handle_unit";
sql2 = " select chk.comments comments, hr.cname cname, To_Char(handle_date,'yyyy/mm/dd hh24:mi') handle_date from egtprchk chk, hrvegemploy hr where yearsern = '"+rs.getString("yearsern")+"' AND chk.handle_userid = hr.employid (+) AND chk.itemclose_date IS NOT null order by handle_unit";
rs2	= stmt2.executeQuery(sql2);
while(rs2.next())
{
	//sb.append("<"+rs2.getString("handle_unit")+">"+rs2.getString("comments")+"<br>");
	sb.append(rs2.getString("comments")+" <"+rs2.getString("cname")+" "+rs2.getString("handle_date")+">"+"<br>");
}
%>
		  <tr>
		  	<td><div align="center"><span class="style15">REPLY</span></div></td>
			<td colspan="6"><span class="style21"><%=sb.toString()%></span></td>
		  </tr>
		<%
				rCount++;
			}
		}
		if(rCount == 0)
		{
			%>
		  <tr>
            <td colspan="7">本欄空白</td>
          </tr>
			<%
		}
		%>
        </table>
		<%
       //****************Show upload file************************		
		ArrayList filename = new ArrayList();
		ArrayList filedsc = new ArrayList();
		
		rs = stmt.executeQuery("select filename, filedsc from egtfile where fltd=to_date('"+fltd+"','yyyy/mm/dd') and fltno='"+fltno+"' and sect='"+sect+"'");
		while(rs.next())
		{
			filename.add(rs.getString("filename"));
			filedsc.add(rs.getString("filedsc"));
		}
		%>
		<table width="100%"  border="0" align="center" cellpadding="2" cellspacing="0" class="fortable">
		<tr>
			<td width="21%">Attach File :</td>
		</tr>
		  <%

		  for(int i=0; i < filename.size(); i++)
		  {
		  %>
		  <tr>
			<td class="fortable txtblue"><a href="http://cabincrew.china-airlines.com/prpt/<%=filename.get(i)%>" target="_blank"><%=filename.get(i)%></a></td>
			<td width="79%" class="fortable txtblue"><%=filedsc.get(i)%></td>
		  </tr>
		  <%
		  }
		  %>
		</table>
		<%
		//********************Show upload file end******************
		%>
	</td>
    </tr>
 </table>
 <table width="100%" border="1" align="center" cellpadding="0" cellspacing="0">
    <!--<tr valign="middle">
      <td width="36%"  height="39"><div align="center" class="style15">APPROVAL</div></td>
      <td width="38%"><div align="center" class="style15">CONCLUSION</div></td>
      <td width="23%"><div align="center" class="style15">REMARK</div></td>
    </tr>
    <tr>
      <td height="170" valign="top"><span class="style21">&nbsp;</span></td>
      <td height="170" valign="top">&nbsp;</td>
      <td height="170" valign="top">&nbsp;</td>
    </tr>-->

  <TR vAlign=center>
    <TD height=39 width="36%">
      <DIV class=style15 align=center>RECOMENDATION</DIV></TD>
    <TD width="27%">
      <DIV class=style15 align=center>REPLY</DIV></TD>
    <TD width="26%">
      <DIV class=style15 align=center>CONCLUSION</DIV></TD>
    <TD width="11%">
      <DIV class=style15 align=center>REMARK</DIV></TD></TR>
  <TR>
    <TD height=184 vAlign=top><SPAN class=style21>&nbsp;<%=reply%></SPAN></TD>
    <TD height=184 vAlign=top>&nbsp;</TD>
    <TD height=184 vAlign=top>&nbsp;</TD>
    <TD height=184 vAlign=top>&nbsp;</TD>
  </TR>
</table>
<br><!--表單編號 : F-EF002E-->
 <table width="100%"  border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td align="left"><span class="style16">表單編號 : F-EZ001</span></td>
      <td><div align="left" class="style16">PrintDate : <%=theday%> </div></td>
	  <td align="right" class="style16">版本：AA</td>
    </tr>
  </table>
</body>
</html>
<%
}
catch (Exception e)
{
	  out.print(e.toString());
}
finally
{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(rs2 != null) rs2.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(stmt2 != null) stmt2.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>