<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="java.io.File"%>
<%@ page import="java.sql.*,tool.ReplaceAll,java.net.URLEncoder,ci.db.ConnDB,eg.prfe.*" %>
<%@ page import="java.io.*,java.util.*" %>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("../logout.jsp");
}

if("640790".equals(userid) | "643937".equals(userid) )
{
	//userid = "628933";
	userid = "625384";
}


String sernno	= request.getParameter("sernno");
String fltno	= request.getParameter("fltno");
String fltd	    = request.getParameter("fltd");
String syy = request.getParameter("syy");
String smm = request.getParameter("smm");
String sdd = request.getParameter("sdd");
String eyy = request.getParameter("eyy");
String emm = request.getParameter("emm");
String edd = request.getParameter("edd");


boolean hasRecord = false;
String sysdate    = null;
String allFltno   = null;
String fdate      = null;
String purserName = null;
String inspector  = null;
String fdate_y    = null;
String fdate_m    = null;
String fdate_d    = null;
String fleet      = null;
String acno      = null;


int count = 0;
int countCi = 0;   
Connection conn   = null;

String sql = null;
ResultSet rs = null;
Statement stmt = null;
ConnDB cn = new ConnDB();
Driver dbDriver = null;

try
{
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
	stmt   = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);

	sql = "select To_Char(SYSDATE, 'mm/dd/yy') AS rundate, fltno, purname, instname, to_char(fltd,'yyyymmdd') as fltd, to_char(fltd,'yyyy') as fdate_y, to_char(fltd,'mm') as fdate_m, to_char(fltd,'dd') as fdate_d, acno, fleet from egtstti where sernno = '"+ sernno+ "'";
	rs = stmt.executeQuery(sql); 
	while(rs.next())
	{
		sysdate = rs.getString("rundate");
		allFltno = rs.getString("fltno");
		fdate = rs.getString("fltd");
		purserName = rs.getString("purname");
		inspector = rs.getString("instname");
		fdate_y = rs.getString("fdate_y");
		fdate_m = rs.getString("fdate_m");
		fdate_d = rs.getString("fdate_d");
		acno = rs.getString("acno");
		fleet = rs.getString("fleet");
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
<title>客艙經理/事務長職能評量編輯</title>
<link href="../style.css" rel="stylesheet" type="text/css">
<script src="../js/checkDel.js" type="text/javascript"></script>
<script src="../js/CheckAll.js" language="javascript" type="text/javascript"></script>
<script src="../js/subWindow.js" language="javascript" type="text/javascript"></script>
<script language="JavaScript" type="text/JavaScript">

function checkAdd(){	
	count = 0;
	for (i=0; i<eval(document.form2.length); i++) {
		if (eval(document.form2.elements[i].checked)) count++;
	}
	if(count ==0 ) {
		alert("Please select the issue you need! \n尚未勾選要需要的項目!!");
		return false;
	}
	else{
				return true;
	}
}

function getFile(divname)
{	
	if(document.getElementById("div"+divname+"A").style.display == '')
	{
		document.getElementById("div"+divname+"A").style.display='none';
		document.getElementById("div"+divname+"B").style.display='';
		//document.getElementById("img"+divname+"B").src="FTP/file/"+divname+".jpg";
	}	
	else
	{
		document.getElementById("div"+divname+"B").style.display='none';
		document.getElementById("div"+divname+"A").style.display='';
	}
	
	return;
}	

</script>
<style type="text/css">
<!--
.style3 {color: #000000}
.style4 {
	font-size: 12px;
	font-weight: bold;
}
-->
</style>
</head>

<body>
<form name="form1" action="insPRFE.jsp"  method ="post" Onsubmit = "document.form1.Submit.disabled=1;">
<input name="sernno" type="hidden" value="<%=sernno%>">
<input name="syy" type="hidden" value="<%=syy%>">
<input name="smm" type="hidden" value="<%=smm%>">
<input name="sdd" type="hidden" value="<%=sdd%>">
<input name="eyy" type="hidden" value="<%=eyy%>">
<input name="emm" type="hidden" value="<%=emm%>">
<input name="edd" type="hidden" value="<%=edd%>">

<table width="90%"  border="0" align="center" cellpadding="2" cellspacing="0">
  <tr>
    <td>
      <div align="center"><span class="txttitletop">客艙經理/事務長職能評量表 </span></div>
    </td>
  </tr>
</table>
<table width="90%"  border="1" align="center" cellpadding="1" cellspacing="1" class="fortable"> 
	<tr class="txtblue">
	  	<td width="25%"><div align="left" class="style1">&nbsp;<span class="style3"><strong>Date</strong>:</span><span class="txtred"><%=fdate_y%>&nbsp;</span><span class="style3"><strong>Y</strong></span><span class="txtred">&nbsp;<%=fdate_m%>&nbsp;</span><span class="style3"><strong>M</strong></span><span class="txtred">&nbsp;<%=fdate_d%>&nbsp;</span><span class="style3"><strong>D</strong></span></div>
		</td>
	  	<td width="25%"><span align="left" class="style1">&nbsp;&nbsp;&nbsp;<span class="style3"><strong>Flt</strong>:</span><span class="txtred"><%=allFltno%>&nbsp;&nbsp; <%=fleet%>&nbsp;&nbsp;<%=acno%></span>
		</td>
    	<td width="18%"><div align="left" class="style1">&nbsp;<span class="style3"><strong>CM/PR</strong>:</span><span class="txtred"><%=purserName%></span></div></td>
    	<td width="18%"><div align="left" class="style1">&nbsp;<span class="style3"><strong>Inspector</strong>:</span><span class="txtred"><%=inspector%></span></div></td>
    	<td width="14%"><div align="left" class="style1">&nbsp;<span class="style3"><strong>Score : </strong></span><span class="txtred">&nbsp;</span></div></td>
  	</tr> 
</table>
<table width="90%" border="1" align="center" cellpadding="1" cellspacing="1" class="fortable">
  	<tr class="tablehead3">
   	   <td align="center" valign="middle"  rowspan= "2">&nbsp;</td>
   	   <td align="center" valign="middle"  rowspan= "2"><strong>評估項目</strong></td>
   	   <td align="center" valign="middle"  rowspan= "2"><strong>子標</strong></td>
       <td align="center" valign="middle"  rowspan= "2"><strong>指標KPI</strong></td>
   	   <td align="center" valign="middle"  colspan="3"><strong>評分</strong></td>
    </tr>
	 <tr class="tablehead3">
       <td align="center" valign="middle"><strong>NDIP</strong></td>
       <td align="center" valign="middle"><strong>AVRG</strong></td>
       <td align="center" valign="middle"><strong>GOOD</strong></td>		  
  	</tr>
  	<%
	 PRFuncEval prfe = new PRFuncEval();
     prfe.getPRFuncEvalEmpty();
     ArrayList objAL = prfe.getObjAL();	
	 int mi_seq = 1;
	for(int j=1;j<objAL.size();j++)
	{		
		PRFuncEvalObj objp =(PRFuncEvalObj) objAL.get(j-1);        
		PRFuncEvalObj obj =(PRFuncEvalObj) objAL.get(j);  
    %>
  	<tr class="txtblue">
<%
		if(!objp.getMitemno().equals(obj.getMitemno()))
		{//評估項目不同
%>
			<td align="left" ><span class="style4"><%=mi_seq%>.</span></td>
			<td align="center" ><span class="style4"><%=obj.getMitemdesc()%></span></td>
<%
			mi_seq++;
	    }
		else
		{
%>
			<td align="center" >&nbsp;</td>
			<td align="center" >&nbsp;</td>
<%
		}
%>

<%
		//********************************************************
		if(!objp.getSitemno().equals(obj.getSitemno()))
		{//子標不同
%>
			<td align="left" ><%=obj.getSitemdesc()%>(<%=obj.getGrade_percentage()%>%)</td>
<%
	    }
		else
		{
%>
			<td align="center" >&nbsp;</td>
<%
		}
%>

<%
		//********************************************************
%>
		<td align="left" ><%=obj.getKpidesc()%></td>
		<td align="center" ><input name="<%=obj.getKpino()%>" type="radio" value="50"></td>
		<td align="center" ><input name="<%=obj.getKpino()%>" type="radio" value="75" checked></td>
		<td align="center" ><input name="<%=obj.getKpino()%>" type="radio" value="100"></td>
<%
		//********************************************************
%>
   	</tr>
    <%
	}
	%>  
</table>
<table width="90%"  border="1" align="center" cellpadding="1" cellspacing="1" class="fortable"> 
	<tr class="txtblue">
	  	<td width="5%"><div align="center" class="style1">客<br>艙<br>管<br>理<br>觀<br>察</div>
		</td>
	  	<td width="95%"><span align="center" class="style1"><div align="left" class="style1">&nbsp;<textarea name="memo1" id="memo1" cols= "80" rows = "10"></textarea></div></td>
    </tr>
</table>
<table width="90%"  border="1" align="center" cellpadding="1" cellspacing="1" class="fortable"> 
	<tr height="80" align="center" valign="middle">
		<td width="25%" class="txtblue">
		<div align="ceter" name="div<%=sernno%>_m1_1A" id="div<%=sernno%>_m1_1A" style="display:">
		<a href="#" onClick="getFile('<%=sernno%>_m1_1');window.open('FTP/getFile.jsp?filename=<%=sernno%>_m1_1','CaseClose','left=200,top=200,width=600,height=300,scrollbars=yes');">附加圖片</a>
		</div>
		<div align="ceter" name="div<%=sernno%>_m1_1B" id="div<%=sernno%>_m1_1B" style="display:none"><img id="img<%=sernno%>_m1_1B" src="../images/blank.jpg" width="130" height="80" border="0">
		</div>
		</td>
		<td width="25%" class="txtblue"><div align="ceter" name="div<%=sernno%>_m1_2A" id="div<%=sernno%>_m1_2A" style="display:"> 
		<a href="#" onClick="getFile('<%=sernno%>_m1_2');window.open('FTP/getFile.jsp?filename=<%=sernno%>_m1_2','CaseClose','left=200,top=200,width=600,height=300,scrollbars=yes');">附加圖片</a>
		</div>
		<div align="ceter" name="div<%=sernno%>_m1_2B" id="div<%=sernno%>_m1_2B" style="display:none"><img id="img<%=sernno%>_m1_2B" src="../images/blank.jpg" width="130" height="80" border="0">
		</div>
		</td>
		<td width="25%" class="txtblue"><div align="ceter" name="div<%=sernno%>_m1_3A" id="div<%=sernno%>_m1_3A" style="display:"> 
		<a href="#" onClick="getFile('<%=sernno%>_m1_3');window.open('FTP/getFile.jsp?filename=<%=sernno%>_m1_3','CaseClose','left=200,top=200,width=600,height=300,scrollbars=yes');">附加圖片</a>
		</div>
		<div align="ceter" name="div<%=sernno%>_m1_3B" id="div<%=sernno%>_m1_3B" style="display:none"><img id="img<%=sernno%>_m1_3B" src="../images/blank.jpg" width="130" height="80" border="0">
		</div>
		</td>
		<td width="25%" class="txtblue"><div align="ceter" name="div<%=sernno%>_m1_4A" id="div<%=sernno%>_m1_4A" style="display:"> 
		<a href="#" onClick="getFile('<%=sernno%>_m1_4');window.open('FTP/getFile.jsp?filename=<%=sernno%>_m1_4','CaseClose','left=200,top=200,width=600,height=300,scrollbars=yes');">附加圖片</a>
		</div>
		<div align="ceter" name="div<%=sernno%>_m1_4B" id="div<%=sernno%>_m1_4B" style="display:none"><img id="img<%=sernno%>_m1_4B" src="../images/blank.jpg" width="130" height="80" border="0">
		</div>
		</td>
  	</tr> 
</table>
<table width="90%"  border="1" align="center" cellpadding="1" cellspacing="1" class="fortable"> 
	<tr class="txtblue">
	  	<td width="5%"><div align="center" class="style1">航<br>班<br>事<br>務<br>改<br>善<br>建<br>議</div>
		</td>
	  	<td width="95%"><span align="center" class="style1"><div align="left" class="style1">&nbsp;<textarea name="memo2" id="memo2" cols= "80" rows = "10"></textarea></div></td>
	</tr>
</table>
<table width="90%"  border="1" align="center" cellpadding="1" cellspacing="1" class="fortable"> 
	<tr height="80" align="center" valign="middle">
		<td width="25%" class="txtblue">
		<div align="ceter" name="div<%=sernno%>_m2_1A" id="div<%=sernno%>_m2_1A" style="display:"> 
		<a href="#" onClick="getFile('<%=sernno%>_m2_1');window.open('FTP/getFile.jsp?filename=<%=sernno%>_m2_1','CaseClose','left=200,top=200,width=600,height=300,scrollbars=yes');">附加圖片</a>
		</div>
		<div align="ceter" name="div<%=sernno%>_m2_1B" id="div<%=sernno%>_m2_1B" style="display:none"><img id="img<%=sernno%>_m2_1B" src="../images/blank.jpg" width="130" height="80" border="0">
		</div>
		</td>
		<td width="25%" class="txtblue"><div align="ceter" name="div<%=sernno%>_m2_2A" id="div<%=sernno%>_m2_2A" style="display:"> 
		<a href="#" onClick="getFile('<%=sernno%>_m2_2');window.open('FTP/getFile.jsp?filename=<%=sernno%>_m2_2','CaseClose','left=200,top=200,width=600,height=300,scrollbars=yes');">附加圖片</a>
		</div>
		<div align="ceter" name="div<%=sernno%>_m2_2B" id="div<%=sernno%>_m2_2B" style="display:none"><img id="img<%=sernno%>_m2_2B" src="../images/blank.jpg" width="130" height="80" border="0">
		</div>
		</td>
		<td width="25%" class="txtblue"><div align="ceter" name="div<%=sernno%>_m2_3A" id="div<%=sernno%>_m2_3A" style="display:"> 
		<a href="#" onClick="getFile('<%=sernno%>_m2_3');window.open('FTP/getFile.jsp?filename=<%=sernno%>_m2_3','CaseClose','left=200,top=200,width=600,height=300,scrollbars=yes');">附加圖片</a>
		</div>
		<div align="ceter" name="div<%=sernno%>_m2_3B" id="div<%=sernno%>_m2_3B" style="display:none"><img id="img<%=sernno%>_m2_3B" src="../images/blank.jpg" width="130" height="80" border="0">
		</div>
		</td>
		<td width="25%" class="txtblue"><div align="ceter" name="div<%=sernno%>_m2_4A" id="div<%=sernno%>_m2_4A" style="display:"> 
		<a href="#" onClick="getFile('<%=sernno%>_m2_4');window.open('FTP/getFile.jsp?filename=<%=sernno%>_m2_4','CaseClose','left=200,top=200,width=600,height=300,scrollbars=yes');">附加圖片</a>
		</div>
		<div align="ceter" name="div<%=sernno%>_m2_4B" id="div<%=sernno%>_m2_4B" style="display:none"><img id="img<%=sernno%>_m2_4B" src="../images/blank.jpg" width="130" height="80" border="0">
		</div>
		</td>
  	</tr> 

	<tr height="80" align="center" valign="middle">
		<td width="25%" class="txtblue">
		<div align="ceter" name="div<%=sernno%>_m2_5A" id="div<%=sernno%>_m2_5A" style="display:"> 
		<a href="#" onClick="getFile('<%=sernno%>_m2_5');window.open('FTP/getFile.jsp?filename=<%=sernno%>_m2_5','CaseClose','left=200,top=200,width=600,height=300,scrollbars=yes');">附加圖片</a>
		</div>
		<div align="ceter" name="div<%=sernno%>_m2_5B" id="div<%=sernno%>_m2_5B" style="display:none"><img id="img<%=sernno%>_m2_5B" src="../images/blank.jpg" width="130" height="80" border="0">
		</div>
		</td>
		<td width="25%" class="txtblue"><div align="ceter" name="div<%=sernno%>_m2_6A" id="div<%=sernno%>_m2_6A" style="display:"> 
		<a href="#" onClick="getFile('<%=sernno%>_m2_6');window.open('FTP/getFile.jsp?filename=<%=sernno%>_m2_6','CaseClose','left=200,top=200,width=600,height=300,scrollbars=yes');">附加圖片</a>
		</div>
		<div align="ceter" name="div<%=sernno%>_m2_6B" id="div<%=sernno%>_m2_6B" style="display:none"><img id="img<%=sernno%>_m2_6B" src="../images/blank.jpg" width="130" height="80" border="0">
		</div>
		</td>
		<td width="25%" class="txtblue"><div align="ceter" name="div<%=sernno%>_m2_7A" id="div<%=sernno%>_m2_7A" style="display:"> 
		<a href="#" onClick="getFile('<%=sernno%>_m2_7');window.open('FTP/getFile.jsp?filename=<%=sernno%>_m2_7','CaseClose','left=200,top=200,width=600,height=300,scrollbars=yes');">附加圖片</a>
		</div>
		<div align="ceter" name="div<%=sernno%>_m2_7B" id="div<%=sernno%>_m2_7B" style="display:none"><img id="img<%=sernno%>_m2_7B" src="../images/blank.jpg" width="130" height="80" border="0">
		</div>
		</td>
		<td width="25%" class="txtblue"><div align="ceter" name="div<%=sernno%>_m2_8A" id="div<%=sernno%>_m2_8A" style="display:"> 
		<a href="#" onClick="getFile('<%=sernno%>_m2_8');window.open('FTP/getFile.jsp?filename=<%=sernno%>_m2_8','CaseClose','left=200,top=200,width=600,height=300,scrollbars=yes');">附加圖片</a>
		</div>
		<div align="ceter" name="div<%=sernno%>_m2_8B" id="div<%=sernno%>_m2_8B" style="display:none"><img id="img<%=sernno%>_m2_8B" src="../images/blank.jpg" width="130" height="80" border="0">
		</div>
		</td>
  	</tr> 
</table>
<table width="90%"  border="1" align="center" cellpadding="1" cellspacing="1" class="fortable"> 
	<tr class="txtblue">
	  	<td width="5%" rowspan = "11" align="center" >旅<br>客<br>反<br>映</div></td>
	  	<td align="center" >航段</td>
		<td align="center" >座位號碼</td>
		<td align="center" >旅客姓名</td>
		<td align="center" >反映事項</td>
		<td align="center" >事項分類</td>
		</td>
  	</tr> 
	<%
	for(int i=1; i<11; i++)	
	{
	%>
	<tr class="txtblue" valign="top">
	  	<td align="center" >
		<input name="sect<%=i%>" id="sect<%=i%>" type="text" value=""  size="6" maxlength="6" onkeyup= "javascript:this.value=this.value.toUpperCase();">
		</td>
		<td align="left" ><input name="seatno<%=i%>" id="seatno<%=i%>" type="text" value=""  size="3" maxlength="3" onkeyup= "javascript:this.value=this.value.toUpperCase();"><br>
		<input name="seat_class<%=i%>" id="seat_class<%=i%>" type="radio" value="F" checked>F<br>
		<input name="seat_class<%=i%>" id="seat_class<%=i%>" type="radio" value="C">C<br>
		<input name="seat_class<%=i%>" id="seat_class<%=i%>" type="radio" value="Y">Y<br>
		<input name="seat_class<%=i%>" id="seat_class<%=i%>" type="radio" value="U/D">U/D
		</td>
		<td align="left" ><input name="cusname<%=i%>" id="cusname<%=i%>" type="text" value=""  size="10" maxlength="20"><br>
		<input type="checkbox" name="cust_type<%=i%>"  id="cust_type<%=i%>" value="EMER">EMER<br>
		<input type="checkbox" name="cust_type<%=i%>"  id="cust_type<%=i%>" value="PARA">PARA<br>
		<input type="checkbox" name="cust_type<%=i%>"  id="cust_type<%=i%>" value="GOLD">GOLD<br>
		<input type="checkbox" name="cust_type<%=i%>"  id="cust_type<%=i%>" value="DYNA">DYNA<br>
		<input type="checkbox" name="cust_type<%=i%>"  id="cust_type<%=i%>" value="MVC">MVC
		</td>
		<td align="center" >
		<textarea name="event<%=i%>" id="event<%=i%>" cols= "25" rows = "7"></textarea></td>
		<td align="left">
			<input type="checkbox" name="event_type<%=i%>"  id="event_type<%=i%>" value="訂位">訂位&nbsp;
			<input type="checkbox" name="event_type<%=i%>"  id="event_type<%=i%>" value="票務">票務&nbsp;
			<input type="checkbox" name="event_type<%=i%>"  id="event_type<%=i%>" value="會員事宜">會員事宜<br>
			<input type="checkbox" name="event_type<%=i%>"  id="event_type<%=i%>" value="座椅">座椅&nbsp;
			<input type="checkbox" name="event_type<%=i%>"  id="event_type<%=i%>" value="設備">設備&nbsp;
			<input type="checkbox" name="event_type<%=i%>"  id="event_type<%=i%>" value="貴賓室">貴賓室<br>
			<input type="checkbox" name="event_type<%=i%>"  id="event_type<%=i%>" value="餐飲">餐飲&nbsp;
			<input type="checkbox" name="event_type<%=i%>"  id="event_type<%=i%>" value="空服">空服&nbsp;
			<input type="checkbox" name="event_type<%=i%>"  id="event_type<%=i%>" value="登機作業">登機作業<br>
			<input type="checkbox" name="event_type<%=i%>"  id="event_type<%=i%>" value="AVOD">AVOD
			<input type="checkbox" name="event_type<%=i%>"  id="event_type<%=i%>" value="劃位櫃檯">劃位櫃檯&nbsp;
			<input type="checkbox" name="event_type<%=i%>"  id="event_type<%=i%>" value="公司政策">公司政策<br>
			<input type="checkbox" name="event_type<%=i%>"  id="event_type<%=i%>" value="其他" >其他
		</td>
  	</tr> 
<%
	}		
%>
</table>
<table width="90%"  border="0" align="center"> 
	<tr><td align= "center"><br><input name="Submit" type="Submit" value=" SUBMIT " ></td></tr>
</table>
</form>
</body>
</html>

<%
session.setAttribute("emptyobjAL", objAL);
%>
