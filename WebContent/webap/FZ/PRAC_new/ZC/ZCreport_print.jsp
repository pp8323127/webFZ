<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="eg.zcrpt.*,java.sql.*,ci.db.*,java.util.ArrayList"%>
<%
//事務長<--助理座艙長報告--送出報告
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
ArrayList objAL = (ArrayList) session.getAttribute("zcreportobjAL"); 
String fdate = request.getParameter("fdate");
String fltno = request.getParameter("fltno");
String sect = request.getParameter("port");
String src = request.getParameter("src");
String purempn = request.getParameter("purempn");
String liveUrl="http://cabincrew.china-airlines.com/prpt/";
String testUrl="http://cabincrew.china-airlines.com/prptt/";

String url =testUrl; 
boolean flag = false ; 
//out.println("fdate"+fdate+",fltno"+fltno+",sect"+sect+","+src+",purempn"+purempn);
//fdate = "2014/09/05";
if(objAL != null && objAL.size()>0)
{
	out.println("2");
	flag = true;	
}else{
	ZCReport zcrt = new ZCReport();
    zcrt.getZCFltListForPR(fdate,fltno,sect,purempn);
	objAL = zcrt.getObjAL();
	if(objAL != null && objAL.size()>0)
	{
		out.println("1");
		flag = true;
	}else{
		out.println("No Data!");		
		
	}
}

if( ((flag && src != null && "APP".equals(src)) || ( flag && sGetUsr != null && !"".equals(sGetUsr)))) 
{
	String idx = request.getParameter("idx");
	/*if(idx == null || "".equals(idx)){
		idx = "0";
		//
	}*/
	out.println(idx);
	ZCReportObj obj = (ZCReportObj) objAL.get(Integer.parseInt(idx));	
	ArrayList crewListobjAL = new ArrayList();
	ArrayList fltIrrobjAL = new ArrayList();
	crewListobjAL = obj.getZccrewObjAL();
	fltIrrobjAL = obj.getZcfltirrObjAL();
	fdate = obj.getFdate();
	fltno = obj.getFlt_num();
	sect = obj.getPort();
	//out.println(fdate+","+fltno+","+sect);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title></title>
<link href="../style2.css" rel="stylesheet" type="text/css">
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
  <span class="style1">CABIN CREW DIVISION</span><p>
  <span class="style12">PURSER'S TRIP REPORT
  </span></div>
  <table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
	  <td colspan="3"><div align="right"><a href="javascript:window.print()"><img src="../../images/print.gif" width="17" height="15" border="0" alt="列印"></a></div></td>
    </tr>
	<tr>
      <td><strong>CM :</strong>&nbsp;&nbsp;<%=obj.getPsrempn()%>&nbsp;&nbsp; <%=obj.getPsrsern()%>&nbsp;&nbsp;<%=obj.getPsrname()%></td>
	  <td><strong>PR  :</strong>&nbsp;&nbsp; <%=obj.getZcempn()%>&nbsp;&nbsp;<%=obj.getZcsern()%>&nbsp;&nbsp;<%=obj.getZcname()%>&nbsp;&nbsp;Group : <%=obj.getZcgrps()%></td>
	  <td><strong>CA  :</strong>&nbsp;&nbsp;<%=obj.getCpname()%>&nbsp;&nbsp;A/C &nbsp;<%=obj.getAcno()%></td>
    </tr>
    <tr>
      <td><strong>Date : </strong><%=obj.getFdate()%></td>
	  <td><strong>Fltno : </strong><%=obj.getFlt_num()%></td>
	  <td><strong>Sect : </strong> <%=obj.getPort()%></td>
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
	if(i < crewListobjAL.size())
	{
		ZCReportCrewListObj zccrewobj = (ZCReportCrewListObj) crewListobjAL.get(i);
		if((i+1)%2==1)
		{
			out.println("<tr>");
		}
%>
      <td height="26" bgcolor="#CCCCCC"><div align="center" class="style4">&nbsp;<%=zccrewobj.getDuty()%></div></td>
      <td height="26"><div align="center" class="style4">&nbsp;<%=zccrewobj.getSern()%></div></td>
      <td height="26"><div align="center" class="style4">&nbsp;<%=zccrewobj.getCname()%></div></td>
      <td height="26"><div align="center" class="style4">&nbsp;<%=zccrewobj.getGrp()%></div></td>
	  <td height="26"><div align="center" class="style4">&nbsp;<%=zccrewobj.getScore()%></div></td>
      <td height="26"><div align="center" class="style4">&nbsp;
	  <%
		  if("Y".equals(zccrewobj.getBest_performance()))
			out.print("*"); 
		  else 
		    out.print("");
	  %>
	  </div></td>
	 <%
		if((i+1)%2==0)
		{
			out.println("</tr>");
		}
	}
	else
	{
		if((i+1)%2==1)
		{
			out.println("<tr>");
		}

%>
      <td height="26" bgcolor="#CCCCCC"><div align="center" class="style4">&nbsp;</div></td>
      <td height="26"><div align="center" class="style4">&nbsp;</div></td>
      <td height="26"><div align="center" class="style4">&nbsp;</div></td>
      <td height="26"><div align="center" class="style4">&nbsp;</div></td>
      <td height="26"><div align="center" class="style4">&nbsp;</div></td>
	  <td height="26"><div align="center" class="style4">&nbsp;</div></td>
<%
		if((i+1)%2==0)
		{
			out.println("</tr>");
		}

	}
}
%>
   </table>
  </td>
 </tr>
</table>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
 <tr>
  <td height="37" colspan="4" valign="middle"><strong>II.Crew Performance : </strong>     
        <table width="100%"  border="1" cellpadding="0" cellspacing="0">
		<%
		int count_2=0;
		for(int i=0; i<crewListobjAL.size(); i++)
		{
			ZCReportCrewListObj zccrewobj = (ZCReportCrewListObj) crewListobjAL.get(i);
			ArrayList gradeAL = zccrewobj.getGradeobjAL();
			if(gradeAL.size()>0)
			{
				for( int j=0; j<gradeAL.size(); j++)
				{
					ZCGradeObj gradeobj = (ZCGradeObj) gradeAL.get(j);
					count_2++;
		%>
          <tr>
            <td width="12%"><span class="style21"><%=gradeobj.getCname()%></span></td>
            <td width="13%"><span class="style21"><%=gradeobj.getGddesc()%></span></td>
            <td width="75%"><span class="style21"><%=gradeobj.getComments()%></span></td>
          </tr>
		<%
				}
			}
		}
		if (count_2<=0)
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
  <table width="100%" border="1" align="center" cellpadding="0" cellspacing="0">
    <tr valign="top">
      <td height="150" colspan="4" valign="top"><strong>III.Flight Irregularity : </strong>
        <table width="100%"  border="1" cellpadding="0" cellspacing="0">
		<%
		int count_3=0;
		if(fltIrrobjAL.size()>0)
		{
			for(int i=0; i<fltIrrobjAL.size(); i++)
			{
				ZCFltIrrItemObj fltirrobj = (ZCFltIrrItemObj) fltIrrobjAL.get(i);
				if("1".equals(fltirrobj.getFlag()))
				{
					count_3++;
		%>
          <tr>
            <td width = "80"  valign="top"><span class="style21"> <%=fltirrobj.getItemdsc2()%></span></td>
            <td valign="top"><span class="style21">&nbsp;<%=fltirrobj.getItemdsc()%></span></td>
            <td width="375"  valign="top"><span class="style21">&nbsp;<%=fltirrobj.getComments()%></span></td>
		  </tr>
		  <tr>
		    <td width = "80" class="style10" bgcolor="#CCCCCC" align="center" valign="middle">擬辦</td>
			<td colspan = "3" class="style21"  valign="top">
		<%
				ArrayList zcrpthandleobjAL = new ArrayList();
				zcrpthandleobjAL = fltirrobj.getItemhandleobjAL();
				String handle_str = "";
				if(zcrpthandleobjAL.size()>0)
				{
					for(int k=0; k<zcrpthandleobjAL.size(); k++)
					{
						ZCReportCheckObj zcrptchkobj = (ZCReportCheckObj) zcrpthandleobjAL.get(k) ;
						if("Y".equals(zcrptchkobj.getItemclose()))
						{
							handle_str = handle_str + zcrptchkobj.getComments() +"  <"+zcrptchkobj.getHandle_username()+"  "+zcrptchkobj.getHandle_date()+"><br>";
						}//if("Y".equals(zcrptchkobj.getItemclose()))
					}
				}//if(zcrpthandleobjAL.size()>0)
%>
				  &nbsp;<%=handle_str%>
			</td>
		</tr>
<%
				}//if("1".equals(fltirrobj.getFlag()))
			}//for(int i=0; i<fltIrrobjAL.size(); i++)
		}
		//else
		if(count_3<=0)
		{
%>
		  <tr>
            <td colspan="4">本欄空白</td>
          </tr>
<%
		}
%>
    </table>
    
<%  
//****************Show ZC upload file************************
	ArrayList fileZCname = new ArrayList();
	ArrayList fileZCdsc = new ArrayList();
	
	Connection conn = null;
	Driver dbDriver = null;
	Statement stmt = null;
	ResultSet rs = null;
	try
	{

	ConnDB cn = new ConnDB();
	cn.setORP3EGUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
	stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
	
	rs = stmt.executeQuery("select filename, filedsc from egtzcfile where fltd=to_date('"+fdate+"','yyyy/mm/dd') and fltno='"+fltno+"' and sect='"+sect+"'");
	while(rs.next())
	{
		fileZCname.add(rs.getString("filename"));
		fileZCdsc.add(rs.getString("filedsc"));
	}
	
	if(fileZCname.size()>0)
	{
	%>
		<table width="100%"  border="0" align="center" cellpadding="2" cellspacing="0" class="fortable">
		<tr>
			<td width="21%">PR Attach File :</td>
		</tr>
		  <%
		  for(int i=0; i < fileZCname.size(); i++){
		  %>
		  <tr>
			<td class="fortable txtblue"><a href="<%=url%>PR/<%=fileZCname.get(i)%>" target="_blank"><%=fileZCname.get(i)%></a></td>
			<td width="79%" class="fortable txtblue"><%=fileZCdsc.get(i)%></td>
		  </tr>
		  <%
		  }
		  %>
		</table>
		<%
	}
//********************Show upload file end******************
%>
    
<%//**************************************************************************%>
    <br>
	<table width="100%" border="1" align="center" cellpadding="0" cellspacing="0">
    <tr valign="top">
      <td height="150" colspan="4" valign="top"><strong>IV.CM Report Flight Irregularity : </strong>
        <table width="100%"  border="1" cellpadding="0" cellspacing="0">
<%

if(rs!=null){rs.close();}

int rCount = 0;
String sql = null;

	rCount = 0;
	sql = "select a.itemdsc desc1, b.itemdsc desc2, nvl(b.comments,'&nbsp;') comm, nvl(b.reply,'&nbsp;') reply, b.clb,b.mcr, b.rca,b.emg from egtcmpi a, egtcmdt b where a.itemno=b.itemno and b.fltd=to_date('"+fdate+"','yyyy/mm/dd') and b.fltno='"+fltno+"' and b.sect='"+sect+"' order by b.newdate";

	//out.println(sql);
	rs	= stmt.executeQuery(sql);
	if(rs.next())
	{//抓出資料筆數
		rs.last();
		rCount = rs.getRow();
		rs.beforeFirst();
	}

	while(rs.next())
	{
		%>
		   <tr>
			<td width="15%"><div align="center"><span class="style21"><%=rs.getString("desc1")%></span></div></td>
			<td width="20%"><div align="center"><span class="style21"><%=rs.getString("desc2")%></span></div></td>
			<td width="63%"><span class="style21"><%=rs.getString("comm")%></span></td>
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
		  <tr>
			<td><div align="center"><span class="style15">REPLY</span></div></td>
			<td colspan="6" width="85%"><span class="style21"><%=rs.getString("reply")%></span></td>
		  </tr>
		<%
	}

	if(rCount <= 0)
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

rs = stmt.executeQuery("select filename, filedsc from egtfile where fltd=to_date('"+fdate+"','yyyy/mm/dd') and fltno='"+fltno+"' and sect='"+sect+"'");
while(rs.next())
{
	filename.add(rs.getString("filename"));
	filedsc.add(rs.getString("filedsc"));
}

if(filename.size()>0)
{
%>
	<table width="100%"  border="0" align="center" cellpadding="2" cellspacing="0" class="fortable">
	<tr>
		<td width="21%">CM Attach File :</td>
	</tr>
	  <%
	  for(int i=0; i < filename.size(); i++){
	  %>
	  <tr>
		<td class="fortable txtblue"><a href="<%=url%><%=filename.get(i)%>" target="_blank"><%=filename.get(i)%></a></td>
		<td width="79%" class="fortable txtblue"><%=filedsc.get(i)%></td>
	  </tr>
	  <%
	  }
	  %>
	</table>
	<%
}
	//********************Show upload file end******************
	%>
		</td>
	   </tr>

    <tr valign="top">
      <td height="150" colspan="4" valign="top"><strong>V.CM Report RECOMENDATION : </strong>
        <table width="100%"  border="1" cellpadding="0" cellspacing="0">
<%
	rs.close();
	sql = "select reply from egtcflt where fltd=to_date('"+fdate+"','yyyy/mm/dd') and fltno='"+fltno+"' and sect=upper('"+sect+"')";
	rs	= stmt.executeQuery(sql);
	if(rs.next())
	{//抓出資料筆數
		rs.last();
		rCount = rs.getRow();
		rs.beforeFirst();
	}

	while(rs.next())
	{
		%>
		  <tr>
			<td align="center"><span class="style15">REPLY</span></td>
			<td colspan="6" width="85%"><span class="style21"><%=rs.getString("reply")%></span></td>
		  </tr>
		<%
	}

	if(rCount <= 0)
	{
	%>
	  <tr>
		<td colspan="7">本欄空白</td>
	  </tr>
	<%
	}
%>
	</table>
   </td>
   </tr>
	</table>
<%
} 
catch (SQLException e) 
{
	out.print(e.toString());
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
</body>
</html>
<%
}else{		//check user session start first or not login
	response.sendRedirect("/webfz/FZ/sendredirect.jsp");
}	

%>