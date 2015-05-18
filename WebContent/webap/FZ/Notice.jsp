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
		alert("�s��30�餧�ӤH���ɩΰ��Դ����w�FAOR�W��,�ЧY��P�����H���βդW�s���կZ�Ʃy!!");
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
<!--<div class="h">�ӤH����(FT)�ΰ��Ԯɶ�(DP)�d��</div>-->
	<table width="500" border="0" align="center" cellpadding="3" cellspacing="2">
		<tr bgcolor="#EBF3FA">
			<td height="40" colspan="2">
				<div align="center" class="txttitletop"><%=cname%> (<%=empno%>) �ӤH����(FT),���Դ���(DP)�d��</div>
			</td>     
		</tr>
		<tr class="tablehead2">
			<td class="txttitletop" width=50%><div align="right" class="sect">
					<div align="center">��ƴ���:</div>
				</div></td>
			<td class="tablehead2"><%=st%> ~ <%=et%></td>
		</tr>
		<tr class="tablehead2">
			<td class="txttitletop" width=50%><div align="right" class="sect">
					<div align="center">�ӤH����(FT):</div>
				</div></td>
			<td class="tablehead2"><%=TimeUtil.minToHHMMWithColon(FT)%></td>
		</tr>
		<tr class="tablehead2">
			<td class="txttitletop" width=50%><div align="right" class="sect">
					<div align="center">�ӤH���Դ���(DP):</div>
				</div></td>
			<td class="tablehead2"><%=TimeUtil.minToHHMMWithColon(adjust_dp)%></td>
		</tr>
		<tr>
			<td class="txtxred" colspan="2" align="left">
				<table border="0" align="left">				
				<tr><td class="txtxred" class="font_hightlight" onClick="subwin('013_1.1.3. Schedual_Rev_10.pdf','ccom')" style="text-decoration:underline;cursor:hand ">�ȿ��խ����������W�w�иԬd CCOM CH 1.1.3
				</td></tr>
				<tr><td class="txtxred">
				<strong>*</strong>�ӤH���ɡG�s��30�餺���W�L120�p��<br>
				<strong>*</strong>���Դ����G�s��30�餺���W�L230�p��;�]����ݩR�νլ��԰ȳ̦h�o�ĭp30 �p�ɤ������ɶ���260�p��
				</td></tr>
				<tr><td class="txtxred">
				*<strong>���ɭ��ײ��`�B�z</strong><br>
				1. �ȿ��խ��ۧں޲z�A���ı���ɭ��׻P����k�W��Ĳ�ɡA���ήɦ^���ȿ��g�z�C<br>
				2. �J���ɭ��צ��H�Ϫk�W�����A�ȿ��g�z�V�����ϬM�A�æV�ŪA�B�줽�Ǧ^���A�ڰ��A��w�ơC<br>
				</td></tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align="center" class="txtxred" colspan="2"><br>
				<span>*�խ��n����(�t) ���e��29��,�@30��</span> <br> <span>*�խ��ȯ�d�ߦۤv����</span>
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

