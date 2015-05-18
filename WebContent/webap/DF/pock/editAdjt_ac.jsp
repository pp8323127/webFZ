<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.ConnectionHelper,java.util.*,java.text.*,df.overTime.ac.*" %>
<%
/*
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
*/
String userid = (String) session.getAttribute("cs55.usr") ; //get user id if already login
if (userid == null) 
{		
	response.sendRedirect("../logout.jsp");
} 

String yyyy = request.getParameter("yyyy");
String mm   = request.getParameter("mm");
String dd   = request.getParameter("dd");
String fltno   = request.getParameter("fltno");
String empno   = request.getParameter("empno");
String adjmins   = request.getParameter("adjmins");
String adjmins2   = request.getParameter("adjmins2");
String type   = request.getParameter("type");
String bgColor="#CCCCCC";


java.util.Date curDate = Calendar.getInstance().getTime();
String dyyyy = new SimpleDateFormat("yyyy",Locale.UK).format(curDate);
String dmm = new SimpleDateFormat("MM",Locale.UK).format(curDate);
if(type == null || "".equals(type))
{
	yyyy=dyyyy;
	mm=dmm;
}
RetrieveSBIRData_AC rot = new RetrieveSBIRData_AC(yyyy,mm,dd,fltno,empno);        
rot.getSBIRData();
ArrayList objAL = rot.getObjAL();
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Edit SB or Irregular case</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script language="Javascript" type="text/javascript" src="../../FZ/js/subWindow.js"></script>
<script language="javascript" type="text/javascript">
function goQuery()
{
	var y = document.form1.yyyy.value ;
	var m = document.form1.mm.value;
	if(y.length==0)
	{
		alert("Please input 年");
		document.form1.yyyy.focus();
		return;
	}

	if(m.length==0)
	{
		alert("Please input 月");
		document.form1.mm.focus();
		return;
	}
	document.form1.type.value="Q" ;
	document.form1.target = "_self";
	document.form1.b1.disabled=1;
	document.form1.action = "editAdjt_ac.jsp";
	document.form1.submit();
}

function goNew()
{
	var y = document.form1.yyyy.value ;
	var m = document.form1.mm.value;
	var d = document.form1.dd.value;
	var fltno = document.form1.fltno.value;
	var adj = document.form1.adjmins.value;
	var adj2 = document.form1.adjmins2.value;
	
	if(y.length==0)
	{
		alert("Please input 年");
		document.form1.yyyy.focus();
		return;
	}

	if(m.length==0)
	{
		alert("Please input 月");
		document.form1.mm.focus();
		return;
	}

	if(d.length==0)
	{
		alert("Please input 日");
		document.form1.dd.focus();
		return;
	}
		
	if(fltno.length==0)
	{
		alert("Please input 航班號碼");
		document.form1.fltno.focus();
		return;
	}

	if(adj.length==0)
	{
		alert("Please input 延長工時(分鐘)");
		document.form1.adjmins.focus();
		return;
	}

	if(adj2.length==0)
	{
		alert("Please input 延長工時(分鐘)");
		document.form1.adjmins2.focus();
		return;
	}

	//document.form1.target = "mywindow";
	document.form1.target = "_blank";
	document.form1.action="newAdjt_ac.jsp";
	//window.open('','mywindow','toolbar=no,scroll=yes,resizable=yes');
	document.form1.b2.disabled=1;
	document.form1.submit();
}
function on_load()
{
	document.form1.yyyy.value = "<%=yyyy%>";
	document.form1.mm.value = "<%=mm%>";
	document.form1.dd.focus();
}

</script>
</head>

<body onload= "on_load()">
<form name="form1" method="post">
<input name="type" type="hidden" id="type">
<div align="center">
<span class="txttitletop style1">SB & IR</span></div>
<table width="90%" border="1" align="center" cellpadding="1" cellspacing="1" >
  <tr bgcolor="#9CCFFF" class="txtblue">
	  <td><div align="center"><span class="txtblue">UTC實際起飛日期</span><span class="txtred">*</span></td>
	  <td><div align="center"><span class="txtblue">航班號碼</span><span class="txtred">*</span></td>
	  <td><div align="center"><span class="txtblue">員工號</span></td>
	  <td><div align="center"><span class="txtblue">延長工時(分鐘)</span><span class="txtred">*</span><span class="txtblue"><br>
      越洋線14~16小時<br>區域線12~16小時</span></td>
	  <td><div align="center"><span class="txtblue">延長工時(分鐘)</span><span class="txtred">*</span><span class="txtblue"><br>
      16小時以上</span></td>
  </tr>
  <tr align="center" valign="middle">
    <td>	  <table border="0" align="center" cellpadding="1" cellspacing="1" >
      <tr class="errStyle1">
        <td>年*</td>
        <td>月*</td>
        <td>日*</td>
      </tr>
      <tr align="center" valign="middle">
        <td><input name="yyyy" type="text" id="yyyy" size="4" maxlength="4" value="">
        </td>
        <td><input name="mm" type="text" id="mm" size="4" maxlength="2" value="" >
        </td>
        <td><input name="dd" type="text" id="dd" size="4" maxlength="2" value="" ></td>
      </tr>
      <tr class="errStyle1">
        <td colspan="3">ex:2007 01 01</td>
      </tr>
    </table></td>
    <td >
      <input name="fltno" type="text" id="fltno" size="10" maxlength="10" value="" >
    </td>
    <td >
      <input name="empno" type="text" id="empno" size="6" maxlength="6" value="" >
    </td>
    <td>
      <input name="adjmins" type="text" id="adjmins" size="6" maxlength="6" value="0" >
    </td>
    <td>
      <input name="adjmins2" type="text" id="adjmins2" size="6" maxlength="6" value="0" >
    </td>
  </tr>
 <tr align= "center">
  	<td class="txtblue"  colspan="6">(<span class="txtred">*</span>)為新增必要條件</td>
 </tr>
  <tr>
    <td colspan="8" >
      <div align="center">
		<input name="b1" type="button" class="button1" id="b1" value="查詢" onclick="goQuery();">
		&nbsp;&nbsp;&nbsp;
		<input name="b2" type="button" class="button1" id="b2" value="新增" onclick="goNew();">
		&nbsp;&nbsp;&nbsp;
		<input name="reset" type="button" class="button1" value="Reset" onclick="document.form1.b2.disabled=0;document.form1.b1.disabled=0">
	  </div>
    </td>
    </tr>
</table>
<p>
<hr  width="90%" noshade>
<div align="center"><span class="txttitletop">待命及特殊情形工時調整 </span></div>
<table width="90%" border="0" align="center" cellpadding="1" cellspacing="1" >
	<tr align="center" valign="middle" bgcolor="#9CCFFF" class="table_head">
	  <td><span class="txtblue">SEQ</span></td>
	  <td><span class="txtblue">UTC實際起飛時間</span></td>
	  <td><span class="txtblue">航班號碼</span></td>
	  <td><span class="txtblue">航段</span></td>
	  <td><span class="txtblue">員工號</span></td>
	  <td><span class="txtblue">延長工時(分鐘)<br>
      越洋線14~16小時<br>區域線12~16小時</span></td>
	  <td><span class="txtblue">延長工時(分鐘)<br>
      16小時以上</span></td>
	  <td><span class="txtblue">新增人員</span></td>
    </tr>
<%
if(objAL.size()>0)
{
	for(int i=0;i<objAL.size();i++)
	{
		if(i%2 ==0)
			bgColor="#CCCCCC";
		else
			bgColor="#FFFFFF";
		OverTimeObj obj = (OverTimeObj)objAL.get(i);

%>
		<tr bgcolor="<%=bgColor%>">
		  <td>
			<div align="center" class="txtblue">&nbsp;<%=i+1%></div>
		  </td> 
		  <td>
			<div align="center" class="txtblue">&nbsp;<%=obj.getAct_takeoff_utc()%></div>
		  </td> 
		  <td align="center" class="txtblue">
			<div align="center">&nbsp;<%=obj.getFltno()%></div>
		  </td>
		  <td>
			<div align="center" class="txtblue">&nbsp;<%=obj.getPort_a()%><%=obj.getPort_b()%></div>
		  </td> 
		  <td>
			<div align="center" class="txtblue">&nbsp;<%=obj.getEmpno()%></div>
		  </td>
		  <td>
			<div align="center" class="txtblue">&nbsp;<%=obj.getOvermins()%></div>
		  </td>
		  <td>
			<div align="center" class="txtblue">&nbsp;<%=obj.getOvermins2()%></div>
		  </td>
		  <td>
			<div align="center" class="txtblue">&nbsp;<%=obj.getChguser()%></div>
		  </td>
		</tr>
<%
	}//for(int i=0;i<objAL.size();i++)
}
else
{
%>
	<tr bgcolor="<%=bgColor%>">
		<td colspan="8"><div align="center" class="txtblue">No data found!!</div></td>
	</tr>
<%
}
%>
</table>
</form>
</body>
</html>

