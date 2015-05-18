<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,java.util.*,java.text.*,df.overTime.ac.*,df.getCrewInfo" %>
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
String bgColor="#CCCCCC";
boolean issave = false;

//out.println(yyyy+"/"+mm+"/"+dd+"/"+fltno+"/"+empno+"/"+adjmins+"/"+adjmins2+"<br>");
RetrieveSBIRData_AC rot = new RetrieveSBIRData_AC(yyyy,mm,dd,fltno,empno);        
rot.retrieveSBIRData();
ArrayList objAL = new ArrayList();
objAL = rot.getObjAL();
getCrewInfo info = new getCrewInfo();

//out.println(rot.getSQLStr()+"<br>");
//out.println(rot.getErrorStr()+"<br>");
//out.println("str "+str+"<br>");
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Edit SB or Irregular case</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script src="../../js/CheckAll.js" language="javascript"></script>
<script language="Javascript" type="text/javascript" src="../../FZ/js/subWindow.js"></script>
<script language="Javascript" type="text/javascript" src="../../FZ/js/checkBlank.js"></script>
<script language="javascript" type="text/javascript">
function chk()
{
	var count = 0;
	for (i=0; i<eval(document.form1.length); i++) 
	{
		if (eval(document.form1.elements[i].checked)) count++;
	}

	if(count ==0 ) 
	{
		alert("請勾選新增項目!!");
		return false;
	}
	else
	{
		if(	confirm("確認新增待命及特殊情形工時調整？"))
		{
			document.form1.Submit.disabled=1;
			return true;

		}
		else
		{
			return false;
		}

	}
}	
</script>
</head>

<body onload= "on_load()">
<form name="form1" method="post" action="insAdjt_ac.jsp" onsubmit="return chk();">
<input type="hidden" name="adjmins" value="<%=adjmins%>">
<input type="hidden" name="adjmins2" value="<%=adjmins2%>">
<div>
  <table width="95%" border="0" align="center">
    <tr>
      <td class="txttitletop">待命及特殊情形工時調整 </td>
      <td>
          <div align="right">
		    <input type="button" name="close" value="Close window" class="button2" onclick="window.close()">
          </div>
      </td>
    </tr>
  </table>
</div>
<%
if(objAL.size()>0)
{
%>
<table width="95%" border="0" align="center" cellpadding="1" cellspacing="1" >
<tr>
	<td>
	<table width="100%" border="1" align="center" cellpadding="1" cellspacing="1" >
	<tr align="center" valign="middle" bgcolor="#0000FF" class="table_body" >
	  <td colspan="8"><span class="txtblue">&nbsp;系統計算資料</span></td>
	  <td colspan="7"><span class="txtblue">&nbsp;人工調整資料</span></td>
	</tr>
	<tr align="center" valign="middle" bgcolor="#9CCFFF" class="table_head">
	  <td width="2%"><span class="txtblue">&nbsp;</span></td>
	  <td width="10%"><span class="txtblue">UTC實際<br>起飛時間</span></td>
	  <td width="10%"><span class="txtblue">TPE<br>報到時間</span></td>
	  <td width="10%"><span class="txtblue">TPE<br>報離時間</span></td>
	  <td width="5%"><span class="txtblue">航班<br>號碼</span></td>
	  <td width="5%"><span class="txtblue">航段</span></td>
	  <td width="5%"><span class="txtblue">延長<br>工時<br>(分鐘)<br>
      越洋線<br>14~16小時<br>區域線<br>12~16小時</span></td>
	  <td width="5%"><span class="txtblue">延長<br>工時<br>(分鐘)<br>
      16小時以上</span></td>
	  <td width="10%"><span class="txtblue">組員<br>姓名</span></td>
	  <td width="10%"><span class="txtblue">組員<br>員工號</span></td>
	  <td width="5%"><span class="txtblue">延長<br>工時<br>(分鐘)<br>
      越洋線<br>14~16小時<br>區域線<br>12~16小時</span></td>
	  <td width="5%"><span class="txtblue">延長<br>工時<br>(分鐘)<br>
      16小時以上</span></td>
	  <td width="5%"><span class="txtblue">航段</span></td>
	  <td width="2%"><span class="txtblue">全選<input name="allchkbox" type="checkbox" onClick="CheckAll('form1','allchkbox')" ></span></td>
	  <td width="10%"><span class="txtblue">維護人員</span></td>
    </tr>
<%
	for(int i=0;i<objAL.size();i++)
	{
		boolean ifshow = true;
		if(i%2 ==0)
		{
			bgColor="#CCCCCC";
		}
		else
		{
			bgColor="#FFFFFF";
		}

		OverTimeObj obj = (OverTimeObj)objAL.get(i);
		info.setCrewInfo(obj.getEmpno());	
		if(!"".equals(empno) && empno != null)
		{
			if(!empno.equals(obj.getEmpno()))
			{
				ifshow=false;
			}
		}

		if(ifshow == true)
		{
%>
		<tr bgcolor="<%=bgColor%>">
		  <td>
			<div align="center" class="txtblue">&nbsp;<%=i+1%></div>
		  </td> 
		  <!--********************************************-->
		  <td>
			<div align="center" class="txtblue">&nbsp;<%=obj.getAct_takeoff_utc()%></div>
		  </td> 
		  <td>
			<div align="center" class="txtblue">&nbsp;<%=obj.getSkj_report_gmt()%></div>
		  </td> 
		  <td>
			<div align="center" class="txtblue">&nbsp;<%=obj.getAct_release_gmt()%></div>
		  </td> 
		  <td align="center" class="txtblue">
			<div align="center">&nbsp;<%=obj.getFltno()%></div>
		  </td>
		  <td>
			<div align="center" class="txtblue">&nbsp;<%=obj.getPort_a()%><%=obj.getPort_b()%></div>
		  </td> 
		  <td>
			<div align="center" class="txtblue">&nbsp;<%=obj.getOvermins()%></div>
		  </td>
		  <td>
			<div align="center" class="txtblue">&nbsp;<%=obj.getOvermins2()%></div>
		  </td>
		  <!--********************************************-->
<%
if("N".equals(obj.getSbirflag()))	
{//SBIR no data     
	obj.setOvermins_sbir(adjmins);
	obj.setOvermins2_sbir(adjmins2);
	obj.setChguser(userid);
	issave=true;
%>	
		  <td>
			<div align="center" class="txtblue">&nbsp;<%=info.getCname()%></div>
		  </td>
		  <td>
			<div align="center" class="txtblue">&nbsp;<%=obj.getEmpno()%></div>
		  </td>
		  <td>
			<div align="center" class="txtblue">&nbsp;<%=obj.getOvermins_sbir()%></div>
		  </td>
		  <td>
			<div align="center" class="txtblue">&nbsp;<%=obj.getOvermins2_sbir()%></div>
		  </td>
		  <td>
			<div align="center" class="txtblue">&nbsp;<%=obj.getPort_a()%><%=obj.getPort_b()%></div>
		  </td>
		  <td>
			<div align="center" class="txtblue">
			<input name="chkItem" type="checkbox" id="chkItem" value="<%=i%>"></div>
		  </td>
		  <td>
			<div align="center" class="txtblue">&nbsp;<%=obj.getChguser()%></div>
		  </td>
<%
}
else
{//SBIR has data 
%>			
		  <td>
			<div align="center" class="txtblue">&nbsp;<%=info.getCname()%></div>
		  </td>
		  <td>
			<div align="center" class="txtblue">
			<a href="#" onClick="subwinXY('updAdjt_ac.jsp?idx=<%=i%>&adjmins=<%=adjmins%>&adjmins2=<%=adjmins2%>','sItem','600','500')">&nbsp;<%=obj.getEmpno()%></a>
			</div>
		  </td>
		  <td>
			<div align="center" class="txtblue">&nbsp;<%=obj.getOvermins_sbir()%></div>
		  </td>
		  <td>
			<div align="center" class="txtblue">&nbsp;<%=obj.getOvermins2_sbir()%></div>
		  </td>
		  <td>
			<div align="center" class="txtblue">&nbsp;<%=obj.getPort_a()%><%=obj.getPort_b()%></div>
		  </td>
		  <td>
			<div align="center" class="txtblue">&nbsp;</div>
		  </td>
		  <td>
			<div align="center" class="txtblue">&nbsp;<%=obj.getSbirflag()%></div>
		  </td>
<%
}
%>
		</tr>
<%
		}//if(ifshow==true)
	}//for(int i=0;i<objAL.size();i++)

	if(issave==true)
	{
%>
  <tr>
    <td colspan="15" >
      <div align="center">
		<input name="Submit" type="submit" class="button1" id="Submit" value="Save">
	  </div>
    </td>
    </tr>
<%
	}//if(issave==true)
%>
	</table>
	</td>
</tr>
</table>
<%
}
else
{
%>
<table width="95%" border="1" align="center" cellpadding="1" cellspacing="1" >
	<tr bgcolor="<%=bgColor%>">
		<td><div align="center" class="txtblue">No data found!!</div></td>
	</tr>
</table>
<%
}
%>
</form>
</body>
</html>
<%
session.setAttribute("objAL",objAL);
%>
