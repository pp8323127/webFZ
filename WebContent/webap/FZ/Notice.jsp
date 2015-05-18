<%@page import="fz.*,java.sql.*,java.util.*,ftdp.*,ci.db.*,ci.tool.*"%>
<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*" errorPage="" %>
<%
String userid = "";
String password ="";
String eipid ="";
String dir_page = "preCheckACN.jsp";
eipid = (String) request.getParameter("eipid");

if(eipid != null && !"".equals(eipid))
{
	userid = eipid;
	dir_page = "http://tpeweb04.china-airlines.com/cia/";
}
else
{
userid=(String)session.getAttribute("userid");
password = (String)session.getAttribute("password");
session.invalidate();
}

Driver dbDriver = null;
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
String sql = null;
String FT = "";
String DP = "";
String st = "";
String et = "";
String adjust_dp ="";
String cname = "";
String empno= "";
String dhsb = "0";
String if_warning = "N";


try 
{
	ConnectionHelper ch = new ConnectionHelper();
	conn = ch.getConnection();
	stmt = conn.createStatement();

	sql = " select To_char(Trunc(sysdate-29,'dd'),'yyyy/mm/dd') st, To_Char(Trunc(SYSDATE,'dd'),'yyyy/mm/dd') et  from dual ";

	rs = stmt.executeQuery(sql);
	if (rs.next()) 
	{
		st = rs.getString("st");
		et = rs.getString("et");
	}

	CalcFtDp cdp = new CalcFtDp();
	cdp.getCrewFtDp(st,et,userid,"ALL","ALL");
	ArrayList objAL = new ArrayList();
	objAL = cdp.getObjAL();
	ftdpObj obj = null;
	for(int i=0; i<objAL.size(); i++)
	{
		obj = (ftdpObj) objAL.get(i);
		adjust_dp =Integer.toString(Integer.parseInt(obj.getDp())+Integer.parseInt(obj.getAdjust_mins()));
	
		dhsb = obj.getDhsb();
		FT = obj.getFt();
		cname = obj.getCname();
		empno = obj.getStaff_num();
		//DP = obj.getDp();
		

		int upper_hr = 13800;// 230hrs
		if(Integer.parseInt(dhsb)>0)
		{
			upper_hr = 15600; //260 hrs
		}
		
		if(Integer.parseInt(obj.getDp())>upper_hr || Integer.parseInt(FT)>7200)
		{
			if_warning = "Y";
		}
	}
} catch (Exception e) {
	//out.println("error : " + e.toString() + sql);
} finally {
	try {
		if (rs != null)
			rs.close();
	} catch (SQLException e) {
	}
	try {
		if (stmt != null)
			stmt.close();
	} catch (SQLException e) {
	}
	try {
		if (conn != null)
			conn.close();
	} catch (SQLException e) {
	}
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="../menu.css" rel="stylesheet" type="text/css">
<link href="menu.css" rel="stylesheet" type="text/css">
<script src="js/subWindow.js"></script>
<script language=javascript>
function show_alert(if_show)
{
	if("Y"==if_show)
	{
		alert("連續30日之個人飛時或執勤期間已達AOR上限,請即刻與派遣人員或組上連絡調班事宜!!");
	}
}

</script>

<title>Notice</title>
<style type="text/css">
body,input{
	font-family:Verdana, Arial, Helvetica, sans-serif;
	font-size:12pt;
	line-height:2;	
}
input{
	font-family:Verdana, Arial, Helvetica, sans-serif;
	font-size:10pt;
}
.red{
	color:#FF0000;	
	padding-left:1em;
	padding-right:1em;
}
.bold{
	font-weight:bold;
}
.blue{
	color:#0000FF;
		padding-left:1em;
	padding-right:1em;

}
.h{
	background-image:url(images/messagebox_info.png);
	padding-left:2em;
	background-attachment: fixed;
	background-repeat: no-repeat;
	background-position: left;
	font-size:18pt;
	font-weight:bold;
	letter-spacing:1em;
	
	
}
.area{
	background-color:#FFFFCC;
	padding:2em;
	width:80%;
	
	margin:3% ;
	border:2pt double red;

}
#ackButton{
	padding-left:10em;
	
	
}
.showStatus{
	display:inline;
	background-color:#BB0000;
	font-weight:bold;
	color:#FFFFFF;
	width:150pt;
	text-align:center;
	padding:2pt;
	padding-left:2em;
	padding-right:2em;
	margin-left:3em;
	font-size:10pt;
	line-height:normal;	
}
.hiddenStatus{
	display:none;
}

</style>
<link rel="stylesheet" type="text/css" href="kbd.css">
</head>

<body onload="javascript:show_alert('<%=if_warning%>');">
<form method="post" action="<%=dir_page%>" onSubmit="loading()">
<div class="area" align="center">
<!--<div class="h">個人飛時(FT)及執勤時間(DP)查詢</div>-->
	<table width="500" border="0" align="center" cellpadding="3" cellspacing="2">
		<tr bgcolor="#EBF3FA">
			<td height="40" colspan="2">
				<div align="center" class="txttitletop"><%=cname%> (<%=empno%>) 個人飛時(FT),執勤期間(DP)查詢</div>
			</td>     
		</tr>
		<tr class="tablehead2">
			<td class="txttitletop" width=50%><div align="right" class="sect">
					<div align="center">資料期間:</div>
				</div></td>
			<td class="tablehead2"><%=st%> ~ <%=et%></td>
		</tr>
		<tr class="tablehead2">
			<td class="txttitletop" width=50%><div align="right" class="sect">
					<div align="center">個人飛時(FT):</div>
				</div></td>
			<td class="tablehead2"><%=TimeUtil.minToHHMMWithColon(FT)%></td>
		</tr>
		<tr class="tablehead2">
			<td class="txttitletop" width=50%><div align="right" class="sect">
					<div align="center">個人執勤期間(DP):</div>
				</div></td>
			<td class="tablehead2"><%=TimeUtil.minToHHMMWithColon(adjust_dp)%></td>
		</tr>
		<tr>
			<td class="txtxred" colspan="2" align="left">
				<table border="0" align="left">				
				<tr><td class="txtxred" class="font_hightlight" onClick="subwin('013_1.1.3. Schedual_Rev_10.pdf','ccom')" style="text-decoration:underline;cursor:hand ">客艙組員派遣相關規定請詳查 CCOM CH 1.1.3
				</td></tr>
				<tr><td class="txtxred">
				<strong>*</strong>個人飛時：連續30日內不超過120小時<br>
				<strong>*</strong>執勤期間：連續30日內不超過230小時;因執行待命或調派勤務最多得採計30 小時之延長時間至260小時
				</td></tr>
				<tr><td class="txtxred">
				*<strong>飛時限度異常處理</strong><br>
				1. 客艙組員自我管理，當察覺飛時限度與民航法規牴觸時，須及時回報客艙經理。<br>
				2. 遇飛時限度有違反法規之虞，客艙經理向機長反映，並向空服處辦公室回報，俾做適當安排。<br>
				</td></tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align="center" class="txtxred" colspan="2"><br>
				<span>*組員登錄日(含) 往前算29日,共30日</span> <br> <span>*組員僅能查詢自己紀錄</span>
			</td>
		</tr>
	</table>
	</div>
<div align="center" id="ackButton"><input type="submit" id="sb" class="kbd" value="Acknowledge">
<div id="showMessage" class="hiddenStatus">loading....</div>
</div>
</div>
<input type="hidden" name="userid" value="<%=userid%>">
<input type="hidden" name="password" value="<%=password%>">
</form>
<script language="javascript" type="text/javascript">
function loading(){
	document.getElementById("sb").disabled=true;
	document.getElementById("showMessage").className="showStatus";
}
</script>
</body>
</html>

