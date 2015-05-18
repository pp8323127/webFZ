<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*,java.util.*,java.text.*" %>
<%
/*
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
*/
String userid = (String) session.getAttribute("cs55.usr") ; //get user id if already login

String fdate = request.getParameter("fdate");
String empno   = request.getParameter("empno");
String fltno   = request.getParameter("fltno");
String sec   = request.getParameter("sec");
String adjmins   = request.getParameter("adjmins");
String adjmins2   = request.getParameter("adjmins2");
String fym = request.getParameter("fym");

if (userid == null) 
{		
	response.sendRedirect("../logout.jsp");
} 

if("".equals(fym) || fym == null)
{
	java.util.Date curDate = Calendar.getInstance().getTime();
	String yyyy = new SimpleDateFormat("yyyy",Locale.UK).format(curDate);
	String mm = new SimpleDateFormat("MM",Locale.UK).format(curDate);
	fym = yyyy+"/"+mm;
}

if("".equals(fdate) || fdate == null)
{
	java.util.Date curDate = Calendar.getInstance().getTime();
	String yyyy = new SimpleDateFormat("yyyy",Locale.UK).format(curDate);
	String mm = new SimpleDateFormat("MM",Locale.UK).format(curDate);
	fdate = yyyy+"/"+mm+"/";
}


ArrayList typeAL = new ArrayList();
ArrayList fdateAL = new ArrayList();
ArrayList empnoAL = new ArrayList();
ArrayList sbtimeAL = new ArrayList();
ArrayList fltnoAL = new ArrayList();
ArrayList rpttimeAL = new ArrayList();
ArrayList adjminsAL = new ArrayList();
ArrayList adjmins2AL = new ArrayList();
ArrayList secAL = new ArrayList();

String bgColor=null;
int count = 0;
String sql = null;
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
Driver dbDriver = null;
ConnDB cn = new ConnDB();

try
{
	cn.setDFUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
	stmt = conn.createStatement();
/*	
	if("".equals(fym) || fym == null)
	{
		sql = "select type, fdate, empno, nvl(sbtime,'') sbtime, fltno, nvl(rpttime,'') rpttime, nvl(adjmins,'0') adjmins, nvl(adjmins2,'0') adjmins2, to_char(sysdate,'yyyy/mm') fym, sect  from dftadjt where SubStr(fdate,1,7) = to_char(sysdate,'yyyy/mm') and type = 'MU' order by fdate desc, fltno, sect";
	}
	else
	{
*/
		sql = "select type, fdate, empno, nvl(sbtime,'') sbtime, fltno, nvl(rpttime,'') rpttime, nvl(adjmins,'') adjmins, nvl(adjmins2,'0') adjmins2, SubStr(fdate,1,7) fym, sect from dftadjt where SubStr(fdate,1,7) = '"+fym+"' and type = 'MU' order by fdate desc, fltno, sect";
//	}
	//out.print(sql+"<br>");
	rs = stmt.executeQuery(sql);

	while(rs.next())
	{
		fym = rs.getString("fym");
		typeAL.add(rs.getString("type"));
		fdateAL.add(rs.getString("fdate"));
		empnoAL.add(rs.getString("empno"));
		sbtimeAL.add(rs.getString("sbtime"));
		fltnoAL.add(rs.getString("fltno"));
		rpttimeAL.add(rs.getString("rpttime"));
		adjminsAL.add(rs.getString("adjmins"));
		adjmins2AL.add(rs.getString("adjmins2"));
		secAL.add(rs.getString("sect"));

	}
}catch(Exception e){
	out.print(e.toString());
}finally{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Edit SB or Irregular case</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript">
function chkInpt()
{
	var v1 = document.form1.fdate.value;
	var v2 = document.form1.empno.value;
	var v3 = document.form1.fltno.value;
	var v4 = document.form1.sec.value;
	var v6 = document.form1.adjmins.value;
	var v7 = document.form1.adjmins2.value;
	if(v1 == "" || v1 == null)
	{
		alert("請輸入日期\nPlease enter flt-date !");
		document.form1.fdate.focus();
		return false;
	}
	else if(v1.length <10 )
	{
		alert("日期格式不正確\nDate format is incorrect! ");
		document.form1.fdate.focus();
		return false;
	
	}
	else if(v2 == "")
	{
		alert("請輸入員工號\nPlease enter empno");
		document.form1.empno.focus();
		return false;	
	}
	else if(v3 == "")
	{
		alert("請輸入航班號碼\nPlease enter Fltno");
		document.form1.fltno.focus();
		return false;	
	}
	else
	{
		return true;
	}
}	

function re_load()
{
	self.location = "editAdjt.jsp?fym="+document.form1.fym.value+"&fdate="+document.form1.fym.value.substring(0,8);
}

function on_load()
{
	document.form1.fdate.value = "<%=fdate%>";
	document.form1.fltno.value = "<%=fltno%>";
	document.form1.empno.value = "<%=empno%>";
	document.form1.sec.value = "<%=sec%>";
	document.form1.fym.value = "<%=fym%>";
	document.form1.adjmins.value = "<%=adjmins%>";	
	document.form1.adjmins2.value = "<%=adjmins2%>";	
	document.form1.fym.value = "<%=fym%>";	
	document.form1.fdate.focus();

}

</script>
</head>

<body onload= "on_load()">
<form name="form1" method="post" action="insAdjt.jsp" onsubmit="return chkInpt()">
<div align="center"><span class="txttitletop style1">Add/Modify Item </span></div>
<table width="90%" border="1" align="center" cellpadding="1" cellspacing="1" >
  <tr bgcolor="#9CCFFF" class="txtblue">
	  <!--<td colspan="2"><div align="center"><span class="txtblue">類別</span></td>-->
	  <td><div align="center"><span class="txtblue">日期</span></td>
	  <td><div align="center"><span class="txtblue">員工號</span></td>
	  <td><div align="center"><span class="txtblue">航班號碼</span></td>
	  <td><div align="center"><span class="txtblue">航段</span></td>
	  <!--<td><div align="center"><span class="txtblue">待命報到時間</span></td>
	  <td><div align="center"><span class="txtblue">原班組員報到時間 </span></td>-->
	  <td><div align="center"><span class="txtblue">延長工時(分鐘)<br>14小時以上</span></td>
	  <td><div align="center"><span class="txtblue">延長工時(分鐘)<br>16小時以上</span></td>
  </tr>
  <tr>
    <!--<td colspan="2">
      <div align="center">
	  	<SELECT name="type" id="type">	
          <OPTION value="MU">MU</OPTION>
          <OPTION value="SB">SB</OPTION>
          <OPTION value="IR">IR</OPTION>
        </SELECT>
      </div>
    </td>-->
    <td >
      <input name="fdate" type="text" id="fdate" size="10" maxlength="10" value="<%=fdate%>" >
    </td>
    <td >
      <input name="empno" type="text" id="empno" size="6" maxlength="6" value="" >
    </td>
    <td >
      <input name="fltno" type="text" id="fltno" size="10" maxlength="10" value="" >
    </td>
    <td>
      <input name="sec" type="text" id="sec" size="10" maxlength="10" value="" onkeyup="javascript:this.value=this.value.toUpperCase();" >
    </td>
    <!--<td>
      <input name="sbtime" type="text" id="sbtime" size="4" maxlength="4" value="" >
    </td>
	<td>
      <input name="rpttime" type="text" id="rpttime" size="4" maxlength="4" value="" >
    </td>
	-->
    <td>
      <input name="adjmins" type="text" id="adjmins" size="6" maxlength="6" value="0" >
    </td>
    <td>
      <input name="adjmins2" type="text" id="adjmins2" size="6" maxlength="6" value="0" >
    </td>
  </tr>
  <tr>
  	<!--<td rowspan="2 " class="txtblue2">EX:</td>
  	<td class="txtblue2">SB</td>-->
  	<td height="23" class="txtblue">2006/03/01</td>
  	<td class="txtblue">641123</td>
  	<td class="txtblue">101</td>
  	<td class="txtblue">NRT/TPE</td>
  	<!--<td class="txtblue2">0630</td>
  	<td class="txtblue2">0705</td>-->
  	<td class="txtblue">120</td>
  	<td class="txtblue">50</td>
  </tr>
<!--
  <tr>
  	<td class="txtblue2">IR</td>
  	<td class="txtblue2">2006/03/01</td>
  	<td class="txtblue2">641123</td>
  	<td class="txtblue2">100/101</td>
  	<td class="txtblue2">&nbsp;</td>
  	<td class="txtblue2">&nbsp;</td>
  	<td class="txtblue2">-50</td>
  </tr>
 -->
 <tr align= "center">
  	<td class="txtblue"  colspan="6">當天來回航班,請擇最後段航段輸入</td>
 </tr>
  <tr>
    <td colspan="8" >
      <div align="center">
        <input name="aa" type="submit" class="button1" id="submit" value="Add/Modify">
		&nbsp;&nbsp;&nbsp;
		<input name="reset" type="reset" class="button1" value="Reset">
	  </div>
    </td>
    </tr>
</table>
<p>
<hr width="90%" noshade>
<div align="center" class="txtblue">
  Year/Month&nbsp;&nbsp;
  <select name="fym" id="fym" onChange="re_load()">
  <%
	java.util.Date now = new java.util.Date();
	int syear	=	now.getYear() + 1900;
	for (int i=syear+1; i>=2006; i--) 
	{    
		for (int j=1; j<13; j++) 
		{
			if (j<10 )
			{
  %>
				<option value="<%=i%>/0<%=j%>"><%=i%>/0<%=j%></option>
  <%
			}
			else
			{
  %>
				<option value="<%=i%>/<%=j%>"><%=i%>/<%=j%></option>
  <%
			}
		}
	}
  %>
  </select>
</div>
<hr  width="90%" noshade>
<p>
<div align="center"><span class="txttitletop">待命及特殊情形工時調整 </span></div>
<table width="90%" border="0" align="center" class="tablebody2">	
	<tr bgcolor="#9CCFFF" class="table_head">
	  <!--<td><span class="txtblue">類別</span></td>-->
	  <td><span class="txtblue">日期</span></td>
	  <td><span class="txtblue">員工號</span></td>
	  <td><span class="txtblue">航班號碼</span></td>
	  <td><span class="txtblue">航段</span></td>
	  <!--<td><span class="txtblue">待命報到時間</span></td>
	  <td><span class="txtblue">原班組員報到時間</span></td>-->
	  <td><span class="txtblue">延長工時(分鐘)<br>14小時以上</span></td>
	  <td><span class="txtblue">延長工時(分鐘)<br>16小時以上</span></td>
	  <td><span class="txtblue">&nbsp;</span></td>
	  <td><span class="txtblue">&nbsp;</span></td>
    </tr>
<%
if(typeAL.size() > 0)
{
	for(int i=0;i<typeAL.size();i++)
	{
		if(i%2 ==0)
			bgColor="#CCCCCC";
		else
			bgColor="#FFFFFF";

%>
		<tr bgcolor="<%=bgColor%>">
		  <!--<td class="txtblue">
			<div align="center">&nbsp;<%=typeAL.get(i)%></div>
		  </td>-->
		  <td>
			<div align="center" class="txtblue style3">&nbsp;<%=fdateAL.get(i)%></div>
		  </td> 
		  <td>
			<div align="center" class="txtblue"><%=empnoAL.get(i)%></div>
		  </td>
		  <td align="center" class="txtblue">
			<div align="center">&nbsp;<%=fltnoAL.get(i)%></div>
		  </td>
		  <td align="center" class="txtblue">
			<div align="center">&nbsp;<%=secAL.get(i)%></div>
		  </td>
		  <!--<td>
			<div align="center" class="txtblue style3">&nbsp;<%=sbtimeAL.get(i)%></div>
		  </td> 
		  <td>
			<div align="center" class="txtblue"><%=rpttimeAL.get(i)%></div>
		  </td>
		  -->
		  <td>
			<div align="center" class="txtblue"><%=adjminsAL.get(i)%></div>
		  </td>
		  <td>
			<div align="center" class="txtblue"><%=adjmins2AL.get(i)%></div>
		  </td>
		  <td>
			<div align="center" class="txtblue"><input name="modify" type="button" value="Modify"  onClick="self.location='editAdjt.jsp?fdate=<%=fdateAL.get(i)%>&empno=<%=empnoAL.get(i)%>&fltno=<%=fltnoAL.get(i)%>&sec=<%=secAL.get(i)%>&adjmins=<%=adjminsAL.get(i)%>&adjmins2=<%=adjmins2AL.get(i)%>&fym=<%=fym%>'"></div>
		  </td>
		  <td>
			<div align="center" class="txtblue"><input name="delete" type="button" value="Delete" onClick="self.location='delAdjt.jsp?type_del=MU&fdate_del=<%=fdateAL.get(i)%>&empno_del=<%=empnoAL.get(i)%>&fltno_del=<%=fltnoAL.get(i)%>&sec_del=<%=secAL.get(i)%>&fym=<%=fym%>'">
		    </div>
		  </td>
		</tr>
<%
	}//for(int i=0;i<typeAL.size();i++)
}//if(typeAL.size() > 0)
else 
{
%>
	<tr bgcolor="<%=bgColor%>">
		<td colspan="8"><div align="center" class="txtblue">No Data</div></td>
	</tr>
<%		
}
%>
</table>
</form>
</body>
</html>

