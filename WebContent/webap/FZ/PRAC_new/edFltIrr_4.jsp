<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="ci.db.*,fz.*,java.sql.*,java.net.URLEncoder,fz.pracP.*,java.util.*" %>
<%
//新增、刪除Flt Irregularity
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if ( sGetUsr == null) 
{		//check user session start first or not login
	//response.sendRedirect("../sendredirect.jsp");
}

boolean hasRecord = false;
boolean isZ = false;

if(!"".equals(request.getParameter("isZ")) && null != request.getParameter("isZ"))
{
	isZ = true;
}


//String GdYear = "2005";//request.getParameter("GdYear");
String fdate = request.getParameter("fdate"); //2005/07/07
//取得考績年度
String GdYear = fz.pracP.GdYear.getGdYear(fdate);

String fltno = request.getParameter("fltno"); //003
String dpt = request.getParameter("dpt"); //SFO
String arv = request.getParameter("arv"); //TPE
String acno = request.getParameter("acno"); //18201
session.setAttribute("fz.acno",acno);
//out.print("acno="+acno);
//String GdYear = request.getParameter("GdYear");

//String itemNo = null;
String itemNoDsc = null;//大項的敘述
String itemDsc = null;//細項的敘述
String comm	= null;
String yearsern = null;//流水號
String clb  = "";
String mcr="";
String rca  = "";
String emg="";

int count = 0;  
Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
ResultSet myResultSet = null;

//modify by cs66 2005/2/23，因前頁FltIrrList已驗證，此處不再驗證是否為座艙長，
String purserEmpno  = request.getParameter("pur");
/*
chkUser ck = new chkUser();
ck.findCrew(sGetUsr);
//登入者的empno,sern,name,group
String psrsern	= ck.getSern();
String psrname	= ck.getName();
String pgroups = ck.getGroup();
*/

//取得座艙長資料
String psrsern	 = null;
String psrname	 = null;
String pgroups = null;
fzac.CrewInfo cInfo = new fzac.CrewInfo(purserEmpno);
aircrew.CrewCName cc = new aircrew.CrewCName();
if( cInfo.isHasData())
{
	fzac.CrewInfoObj cObj= cInfo.getCrewInfo();
	psrsern =cObj.getSern();
//	psrname =cObj.getCname();
	psrname = cc.getCname(purserEmpno);
	pgroups =cObj.getGrp();
}

String sql = null;
String upd = null;
try
{
String pbuser = (String)session.getAttribute("pbuser");

//驗證是否為Purser
//可使用者:cs55,cs66,cs27,cs40,cs71,cs73
//新增630166 ->吉鎮麗，.....EF人員

if(!sGetUsr.equals("638716") && !sGetUsr.equals("640073") && !sGetUsr.equals("633007") && !sGetUsr.equals("634319") && !sGetUsr.equals("640790") && !sGetUsr.equals("627018") && !sGetUsr.equals("627536") && !sGetUsr.equals("630208") && !sGetUsr.equals("629019") && !sGetUsr.equals("625384") && !sGetUsr.equals("630166") && !sGetUsr.equals("628997") && !"Y".equals(pbuser))
{
	//modify by cs66 at 2005/2/21 
	/*
	purserEmpno  為 sql select出來的第一個非S及非I 的purser empno
	pur 為上一頁傳來的purser empno
	特殊狀況會出現，該班purser，並非select出來的員工號，
	因上一頁會顯示兩個座艙長，所以若傳入的員工號為登入者，則可編輯此份報告
	
	*/
	//if(  !sGetUsr.equals(purserEmpno) &&!sGetUsr.equals(pur) ){	
	if(!sGetUsr.equals(purserEmpno))
	{
		response.sendRedirect("../showmessage.jsp?messagestring="+URLEncoder.encode("非本班機座艙長，不得使用此功能") );		
	}
}		

ConnDB cn = new ConnDB();
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);

//驗證報告是否已經送出
sql = "select nvl(upd,'Y') upd from egtcflt where fltd = to_date('"+fdate+"','yyyy/mm/dd') "+
 "and fltno = '"+fltno+"' and sect = '"+dpt+arv+"' ";
 
myResultSet = stmt.executeQuery(sql); 

if(myResultSet.next())
{
	upd = myResultSet.getString("upd");
	if (upd.equals("N"))
	{ //報告已送出不可修改
					
		try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
		try{if(stmt != null) stmt.close();}catch(SQLException e){}
		try{if(conn != null) conn.close();}catch(SQLException e){}
		response.sendRedirect("../showmessage.jsp?messagestring="+URLEncoder.encode("報告已送出，不得修改"));
	}
}

sql = "select dt.* ,pi.itemdsc dsc from egtcmdt dt, egtcmpi pi where dt.itemno = pi.itemno and  fltno='"+fltno+"' and fltd=to_date('"+fdate+"','yyyy/mm/dd') and sect='"+dpt+arv+"'";

myResultSet = stmt.executeQuery(sql);
if(myResultSet.next())
{
	myResultSet.last();
	count = myResultSet.getRow();//取得筆數
	myResultSet.beforeFirst();
}

if(count >0)
{
	hasRecord = true;	
}
%> 

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>檢視及新增其他事項View &amp; Add Flt Irregularity</title>
<link href="style2.css" rel="stylesheet" type="text/css">
<script src="checkDel.js" type="text/javascript"></script>
<script src="../../js/CheckAll.js" language="javascript" type="text/javascript"></script>
<script src="../../MT/js/subWindow.js" language="javascript" type="text/javascript"></script>

<script language="JavaScript" type="text/JavaScript">

//TODO在此處限制登機準時資訊必須輸入
function sendReport()
{	
	<%
	if(hasRecord)
	{
	
		out.print("document.form1.Submit.disabled=1;");
	}

	String submitPage = "upReportSave.jsp?src=4";
	if(isZ)
	{
		submitPage= "upReportSaveZ.jsp?src=4";
	}
	%>
	document.form2.Submit.disabled=1;
	document.form2.SendReport.disabled=1;
	document.form2.action="<%=submitPage%>";
	document.form2.submit();
	//return true;
}

function showspan(key,status)
{
	if(status==1)
	{
		document.getElementById(key+"_span").style.display="none";
	}
	else
	{
		document.getElementById(key+"_span").style.display="";
	}
}

function compose_note(colname)
{
	var c_value = "";
	for (var i=0; i < eval("document.form2."+colname+"_str.length"); i++)
	{
		if (eval("document.form2."+colname+"_str[i].checked"))
		{
			c_value = c_value+" "+ eval("document.form2."+colname+"_str[i].value") ;
		}
	}

	//alert(c_value);
	document.getElementById(colname+"_note").value = c_value ;
}

function chkMostWirte(){
	var b04_value = null;
	var b03_value = null;
	b04_value = document.getElementById("B04_yn").checked;
	b03_value = document.getElementById("B03_yn").checked;
	alert(b04_value + b03_value);
	
	if(b04_value && b04_value ){
		
	}
}

</script>
</head>
<body onLoad="initBt()">
<!--***************************************************************************-->
<div align="center">
<table width="90%"  border="0" align="center" cellpadding="2" cellspacing="0" bgcolor="#CCFFFF" >
<tr>
  <td width="27%" class="txtblue">FltDate:<span class="txtxred"><%=fdate%></span></td>
  <td width="23%" class="txtblue">Fltno:<span class="txtxred"><%=fltno%></span></td>
  <td width="25%" class="txtblue">Sector:<span class="txtxred"><%=dpt%><%=arv%></span></td>
  <td width="25%" class="txtblue">ACNO:<span class="txtxred"><%=acno%></span></td>
</tr>
</table>
<p>
<!--****************************************************************************-->
<form name="form1" onSubmit="return del('form1');" action="delFltIrr.jsp">
	<input name="src" id="src" type="hidden" value="4" >
<%
//有資料才show
if(hasRecord)
{
%>
<table width="90%"  border="0" align="center" cellpadding="2" cellspacing="0" class="fortable">
<tr class="tablehead2">
      <td width="5%">&nbsp;</td>
      <td colspan="2">Item</td>
      <td width="45%">Comments</td>
      <td width="5%">CLB</td>
 	  <td width="5%">Meal<br>Check</td>
      <td width="5%">回報<br>飛航<br>組員</td>
      <td width="5%">使用<br>緊急<br>設備</td>
  </tr>
	<%
	while(myResultSet.next())
	{
		clb="";
		mcr="";
		rca="";
		emg="";
		
		itemNoDsc 	= myResultSet.getString("dsc");
		itemDsc 	= myResultSet.getString("itemdsc");
		comm		= myResultSet.getString("comments");
		yearsern 	= myResultSet.getString("yearsern");
		if("Y".equals(myResultSet.getString("clb"))){	clb="YES";}else if("N".equals(myResultSet.getString("clb"))){clb="NO";}
		if("Y".equals(myResultSet.getString("mcr"))){	mcr="YES";}else if("N".equals(myResultSet.getString("mcr"))){mcr="NO";}

		if("Y".equals(myResultSet.getString("rca"))){	rca="YES";}else if("N".equals(myResultSet.getString("rca"))){rca="NO";}
		if("Y".equals(myResultSet.getString("emg"))){	emg="YES";}else if("N".equals(myResultSet.getString("emg"))){emg="NO";}


	%>
    <tr class="fortable">
      <td align="center" class="fortable"><input type="checkbox" value="<%=yearsern%>" name="delItem"></td>
      <td width="10%" class="fortable txtblue" align="left" >
	  <img src="../images/pencil.gif" width="15" height="15">
	  <a href="#" onClick="subwinXY('edFltIrr2.jsp?isZ=<%=request.getParameter("isZ")%>&yearsern=<%=yearsern%>&purserEmpno=<%=purserEmpno%>&pur=<%=purserEmpno%>&src=4','','700','350')"><u><%=itemNoDsc%></u></a></td>
      <td width="16%" class="fortable txtblue" ><%=itemDsc%></td>
      <td class="fortable txtblue"><%=comm%></td>
      <td class="fortable txtblue">&nbsp;<%=clb%> </td>
      <td class="fortable txtblue">&nbsp;<%=mcr%> </td>
      <td class="fortable txtblue">&nbsp;<%=rca%> </td>
      <td class="fortable txtblue">&nbsp;<%=emg%> </td>
    </tr>
	<%
	}
	%>
</table>
  <div align="center">
    <input name="Submit" type="submit" class="delButon" value="Delete Selected" >
  <br> <span class="purple_txt"><strong>*Click Item to Edit(點選Item即可進入編輯comments)<br>
  </strong></span>
  </div>
  <%
  }	  //End of if have record
  %>
	      <input type="hidden" name="fdate" value="<%=fdate%>">
          <input type="hidden" name="fltno" value="<%=fltno%>">	
		  <input type="hidden" name="acno" value="<%=acno%>">	
          <input type="hidden" name="dpt" value="<%=dpt%>">		
		  <input type="hidden" name="arv" value="<%=arv%>">	
		  <input type="hidden" name="GdYear" value="<%=GdYear%>">
 		  <input type="hidden" name="purserEmpno" value="<%=purserEmpno%>">	
		  <input type="hidden" name="psrname" value="<%=psrname%>">	
 		  <input type="hidden" name="psrsern" value="<%=psrsern%>">
		  <input type="hidden" name="pur" value="<%=purserEmpno%>">
		  <input type="hidden" name="isZ" value="<%=request.getParameter("isZ")%>">

</form>
<%
ArrayList filename = new ArrayList();
ArrayList filedsc = new ArrayList();
count = 0;

myResultSet = stmt.executeQuery("select filename, filedsc from egtfile where fltd=to_date('"+fdate+"','yyyy/mm/dd') and fltno='"+fltno+"' and sect='"+dpt+arv+"'");
while(myResultSet.next()){
	filename.add(myResultSet.getString("filename"));
	filedsc.add(myResultSet.getString("filedsc"));
	count++;
}

if(count > 0)
{
%>
<table width="90%"  border="0" align="center" cellpadding="2" cellspacing="0" class="fortable">
  <tr class="tablehead3">
    <td width="13%">&nbsp;</td>
    <td width="51%">FileName</td>
    <td width="36%">Description</td>
  </tr>
  <%
  for(int i=0; i < filename.size(); i++){
  %>
  <tr>
    <td class="fortable txtblue">
      <div align="center">
        <input type="button" value="DELETE" onClick="if(confirm('確定要刪除檔案：<%=filename.get(i)%> ?')){self.location='FTP/delFile.jsp?isZ=<%=request.getParameter("isZ")%>&fdate=<%=fdate%>&fltno=<%=fltno%>&dpt=<%=dpt%>&arv=<%=arv%>&uploadFileName=<%=filename.get(i)%>&purserEmpno=<%=purserEmpno%>&acno=<%=acno%>&src=4';this.disabled=1;}else{return false;}" style="background-color:#BFE4FF;color:#00487D;font-family:Verdana ">
      </div>
    </td>
    <td class="fortable txtblue"><a href="http://cabincrew.china-airlines.com/prpt/<%=filename.get(i)%>" target="_blank"><%=filename.get(i)%></a></td>
    <td class="fortable txtblue"><%=filedsc.get(i)%></td>
  </tr>
  <%
  }
  %>
</table>
<%
}
%>
<div align="center">
  <input name="upload" type="button" class="addButton" value="Upload(上傳檔案)" onClick="subwinXY('FTP/uploadfile.jsp?isZ=<%=request.getParameter("isZ")%>&fdate=<%=fdate%>&fltno=<%=fltno%>&dpt=<%=dpt%>&arv=<%=arv%>&purserEmpno=<%=purserEmpno%>&acno=<%=acno%>&src=4','delUpload','700','350')">
  <br>
</div>
<!--****************************************************************************-->
<form name="form2" method="post" action="upFltIrr.jsp" onSubmit="return checkCharacter()">
<input type="hidden" name="src" value="4">
<div align="center">
<fieldset style="width:90%; ">
<legend class="txttitletop">設備\系統</legend>
<P>
  <table width="95%" cellpadding="2" cellspacing="2" border="0">
  <tr bgcolor="#DFDFDF" class="txtblue">
    <td width="15%" align="center" valign="middle">客艙溫度</td>
<%
	PRreportTool prt1 = new PRreportTool();
	prt1.getCMPDItemdsc("B04") ;
	ArrayList prt1AL = prt1.getObjAL();
	int split_idx = 1;
%>
	<td width="85%" align="left">
	    <table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr>
		<td width="25%"><input name="B04_yn" type="radio" value="Yes" onClick="showspan('B04','1')" ><span class="txtxred">正常</span></td>
<%
	for(int i=0; i<prt1AL.size(); i++)
	{
		++split_idx;
%>
		<td width="25%"><input name="B04_yn" type="radio" value="B04/<%=prt1AL.get(i)%>" onClick="showspan('B04','2')"><%=prt1AL.get(i)%></td>
<%
	    if(split_idx%4==0)
		{
			out.println("</tr><tr>");
		}
	}	
%>
		</tr>
		</table>
		<span style="display:none " id="B04_span" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td colspan="4">
		Note : <input type="text" size="50" maxlength="2000" name="B04_note" id="B04_note">
		</td></tr>
		<tr><td colspan="4">
		      <input type="checkbox" name="B04_str" value="旅客登機時悶熱" onclick="compose_note('B04')">旅客登機時悶熱 
		      <input type="checkbox" name="B04_str" value="關門後滑行時悶熱" onclick="compose_note('B04')">關門後滑行時悶熱
		      <input type="checkbox" name="B04_str" value="航程中悶熱" onclick="compose_note('B04')">航程中悶熱<br>
		      <input type="checkbox" name="B04_str" value="全機" onclick="compose_note('B04')">全機
		      <input type="checkbox" name="B04_str" value="Zone A" onclick="compose_note('B04')">Zone A
		      <input type="checkbox" name="B04_str" value="Zone B" onclick="compose_note('B04')">Zone B
		      <input type="checkbox" name="B04_str" value="Zone C" onclick="compose_note('B04')">Zone C
		      <input type="checkbox" name="B04_str" value="Zone D" onclick="compose_note('B04')">Zone D
		      <input type="checkbox" name="B04_str" value="Zone E" onclick="compose_note('B04')">Zone E
		      <input type="checkbox" name="B04_str" value="Zone U/D" onclick="compose_note('B04')">Zone U/D
		</td></tr>
		<tr><td colspan="4">
		已誌CLB : <input name="B04_clb" type="radio" value="N">No&nbsp;&nbsp;
		<input name="B04_clb" type="radio" value="Y">Yes
		</td></tr>
		</table>
		</span>
	</td>
  </tr>
  <tr class="txtblue">
    <td width="15%" align="center" valign="middle">水量表</td>
<%
	PRreportTool prt2 = new PRreportTool();
	prt2.getCMPDItemdsc("B09") ;
	ArrayList prt2AL = prt2.getObjAL();
	split_idx = 1;
%>
	<td width="85%" align="left">
	    <table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr>
		<td width="25%"><input name="B09_yn" type="radio" value="Yes" onClick="showspan('B09','1')" checked><span class="txtxred">正常</span></td>
<%
	for(int i=0; i<prt2AL.size(); i++)
	{
		++split_idx;
%>
		<td width="25%"><input name="B09_yn" type="radio" value="B09/<%=prt2AL.get(i)%>" onClick="showspan('B09','2')"><%=prt2AL.get(i)%></td>
<%
	    if(split_idx%4==0)
		{
			out.println("</tr><tr>");
		}
	}	
%>
		</tr>
		</table>
		<span style="display:none " id="B09_span" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td colspan="4">
		Note : <input type="text" size="50" maxlength="2000" name="B09_note" id="B09_note">
		</td></tr>
		<tr><td colspan="4">
		已誌CLB : <input name="B09_clb" type="radio" value="N">No&nbsp;&nbsp;
		<input name="B09_clb" type="radio" value="Y">Yes
		</td></tr>
		</table>
		</span>
	</td>
  </tr>
  <tr bgcolor="#DFDFDF" class="txtblue">
    <td width="15%" align="center" valign="middle">緊急裝備</td>
<%
	PRreportTool prt3 = new PRreportTool();
	prt3.getCMPDItemdsc("H01") ;
	ArrayList prt3AL = prt3.getObjAL();
	split_idx = 1;
%>
	<td width="85%" align="left">
	    <table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr>
		<td width="25%"><input name="H01_yn" type="radio" value="Yes" onClick="showspan('H01','1')" checked><span class="txtxred">正常</span></td>
<%
	for(int i=0; i<prt3AL.size(); i++)
	{
		++split_idx;
%>
		<td width="25%"><input name="H01_yn" type="radio" value="H01/<%=prt3AL.get(i)%>" onClick="showspan('H01','2')"><%=prt3AL.get(i)%></td>
<%
	    if(split_idx%4==0)
		{
			out.println("</tr><tr>");
		}
	}	

	if(split_idx<4)
	{
		out.println("<td width=\"25%\">&nbsp;</td>");
	}

%>
		</tr>
		</table>
		<span style="display:none " id="H01_span" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td colspan="4">
		Note : <input type="text" size="50" maxlength="2000" name="H01_note" id="H01_note">
		</td></tr>
		<tr><td colspan="4">
		已誌CLB : <input name="H01_clb" type="radio" value="N">No&nbsp;&nbsp;
		<input name="H01_clb" type="radio" value="Y">Yes
		</td></tr>
		<tr><td colspan="4">
		是否回報飛航組員 : <input name="H01_rca" type="radio" value="N">No&nbsp;&nbsp;
		<input name="H01_rca" type="radio" value="Y">Yes
		</td></tr>
		</table>
		</span>
	</td>
  </tr>
  <tr class="txtblue">
    <td width="15%" align="center" valign="middle">座椅缺失</td>
<%
	PRreportTool prt4 = new PRreportTool();
	prt4.getCMPDItemdsc("B01") ;
	ArrayList prt4AL = prt4.getObjAL();
	split_idx = 1;
%>
	<td width="85%" align="left">
	    <table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr>
		<td width="25%"><input name="B01_yn" type="radio" value="Yes" onClick="showspan('B01','1')" checked><span class="txtxred">正常</span></td>
<%
	for(int i=0; i<prt4AL.size(); i++)
	{
		++split_idx;
%>
		<td width="25%"><input name="B01_yn" type="radio" value="B01/<%=prt4AL.get(i)%>" onClick="showspan('B01','2')"><%=prt4AL.get(i)%></td>
<%
	    if(split_idx%4==0)
		{
			out.println("</tr><tr>");
		}
	}	
%>
		</tr>
		</table>
		<span style="display:none " id="B01_span" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td colspan="4">
		Note : <input type="text" size="50" maxlength="2000" name="B01_note" id="B01_note">
		</td></tr>
		<tr><td colspan="4">
		已誌CLB : <input name="B01_clb" type="radio" value="N">No&nbsp;&nbsp;
		<input name="B01_clb" type="radio" value="Y">Yes
		</td></tr>
		</table>
		</span>
	</td>
  </tr>
  <tr bgcolor="#DFDFDF" class="txtblue">
    <td width="15%" align="center" valign="middle">影視系統缺失</td>
<%
	PRreportTool prt5 = new PRreportTool();
	prt5.getCMPDItemdsc("B03") ;
	ArrayList prt5AL = prt5.getObjAL();
	split_idx = 1;
%>
	<td width="85%" align="left">
	    <table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr>
		<td width="25%"><input name="B03_yn" type="radio" value="Yes" onClick="showspan('B03','1')" ><span class="txtxred">正常</span></td>
<%
	for(int i=0; i<prt5AL.size(); i++)
	{
		if(!"PTV".equals(((String)prt5AL.get(i)).substring(0,3)) && !"區域性".equals(((String)prt5AL.get(i)).substring(0,3)))
		{
			++split_idx;
%>
			<td width="25%"><input name="B03_yn" type="radio" value="B03/<%=prt5AL.get(i)%>" onClick="showspan('B03','2')"><%=prt5AL.get(i)%></td>
<%
			if(split_idx%4==0)
			{
				out.println("</tr><tr>");
			}
		}
	}	
%>
		</tr>
		</table>
		<span style="display:none " id="B03_span" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td colspan="4">
		Note : <input type="text" size="50" maxlength="2000" name="B03_note" id="B03_note">
		</td></tr>
		<tr><td colspan="4">
		已誌CLB : <input name="B03_clb" type="radio" value="N">No&nbsp;&nbsp;
		<input name="B03_clb" type="radio" value="Y">Yes
		</td></tr>
		</table>
		</span>
	</td>
  </tr>
  <tr class="txtblue">
    <td width="15%" align="center" valign="middle">PTV故障</td>
<%
	split_idx = 1;
%>
	<td width="85%" align="left">
	    <table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr>
		<td width="25%"><input name="B03_2_yn" type="radio" value="Yes" onClick="showspan('B03_2','1')" checked><span class="txtxred">正常</span></td>
		<td width="25%"><input name="B03_2_yn" type="radio" value="B03/PTV故障-頭等艙" onClick="showspan('B03_2','2')">PTV故障-頭等艙</td>
		<td width="25%"><input name="B03_2_yn" type="radio" value="B03/PTV故障-商務艙" onClick="showspan('B03_2','2')">PTV故障-商務艙</td>
		<td width="25%"><input name="B03_2_yn" type="radio" value="B03/PTV故障-經濟艙" onClick="showspan('B03_2','2')">PTV故障-經濟艙</td>
		</tr>
		<tr>
		<td width="25%"><input name="B03_2_yn" type="radio" value="B03/區域性影視故障" onClick="showspan('B03_2','2')">區域性影視故障</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		</tr>
		</table>
		<span style="display:none " id="B03_2_span" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td colspan="4">
		Note : <input type="text" size="50" maxlength="2000" name="B03_2_note" id="B03_2_note">
		</td></tr>
		<tr><td colspan="4">
		已誌CLB : <input name="B03_2_clb" type="radio" value="N">No&nbsp;&nbsp;
		<input name="B03_2_clb" type="radio" value="Y">Yes
		</td></tr>
		</table>
		</span>
	</td>
  </tr>

  <tr bgcolor="#DFDFDF" class="txtblue">
    <td width="15%" align="center" valign="middle">客艙缺失</td>
<%
	PRreportTool prt6 = new PRreportTool();
	prt6.getCMPDItemdsc("B05") ;
	ArrayList prt6AL = prt6.getObjAL();
	split_idx = 1;
%>
	<td width="85%" align="left">
	    <table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr>
		<td width="25%"><input name="B05_yn" type="radio" value="Yes" onClick="showspan('B05','1')" checked><span class="txtxred">正常</span></td>
<%
	for(int i=0; i<prt6AL.size(); i++)
	{
		if(!"艙門".equals(((String)prt6AL.get(i)).substring(0,2)))
		{
			++split_idx;
%>
			<td width="25%"><input name="B05_yn" type="radio" value="B05/<%=prt6AL.get(i)%>" onClick="showspan('B05','2')"><%=prt6AL.get(i)%></td>
<%
			if(split_idx%4==0)
			{
				out.println("</tr><tr>");
			}
		}
	}	
%>
		<td width="25%"><input name="B05_yn" type="radio" value="B02/Cabin滴/漏水" onClick="showspan('B05','2')">Cabin滴/漏水</td>
<%	
		++split_idx;

	if(split_idx<4)
	{
		out.println("<td width=\"25%\">&nbsp;</td>");
	}
%>
		</tr>
		</table>
		<span style="display:none " id="B05_span" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td colspan="4">
		Note : <input type="text" size="50" maxlength="2000" name="B05_note" id="B05_note">
		</td></tr>
		<tr><td colspan="4">
		已誌CLB : <input name="B05_clb" type="radio" value="N">No&nbsp;&nbsp;
		<input name="B05_clb" type="radio" value="Y">Yes
		</td></tr>
		</table>
		</span>
	</td>
  </tr>

  <tr class="txtblue">
    <td width="15%" align="center" valign="middle">艙門缺失</td>
	<td width="85%" align="left">
	    <table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr>
		<td width="25%"><input name="B05_2_yn" type="radio" value="Yes" onClick="showspan('B05_2','1')" checked><span class="txtxred">正常</span></td>
		<td width="25%"><input name="B05_2_yn" type="radio" value="B05/艙門缺失" onClick="showspan('B05_2','2')">艙門缺失</td>
		<td width="25%">&nbsp;</td>
		<td width="25%">&nbsp;</td>
		</tr>
		</table>
		<span style="display:none " id="B05_2_span" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td colspan="4">
		Note : <input type="text" size="50" maxlength="2000" name="B05_2_note" id="B05_2_note">
		</td></tr>
		<tr><td colspan="4">
		      <input type="checkbox" name="B05_2_str" value="門把異常" onclick="compose_note('B05_2')">門把異常 
		      <input type="checkbox" name="B05_2_str" value="疑似艙門漏氣" onclick="compose_note('B05_2')">疑似艙門漏氣
		      <input type="checkbox" name="B05_2_str" value="艙門故障" onclick="compose_note('B05_2')">艙門故障
		      <input type="checkbox" name="B05_2_str" value="艙門異常" onclick="compose_note('B05_2')">艙門異常
		      <input type="checkbox" name="B05_2_str" value="艙門噪音" onclick="compose_note('B05_2')">艙門噪音<br>
		</td></tr>
		<tr><td colspan="4">
		已誌CLB : <input name="B05_2_clb" type="radio" value="N">No&nbsp;&nbsp;
		<input name="B05_2_clb" type="radio" value="Y">Yes
		</td></tr>
		<tr><td colspan="4">
		是否回報飛航組員 : <input name="B05_2_rca" type="radio" value="N">No&nbsp;&nbsp;
		<input name="B05_2_rca" type="radio" value="Y">Yes&nbsp;&nbsp;
		</td></tr>
		</table>
		</span>
	</td>
  </tr>
  <tr bgcolor="#DFDFDF" class="txtblue">
    <td width="15%" align="center" valign="middle">廚房缺失</td>
<%
	PRreportTool prt7 = new PRreportTool();
	prt7.getCMPDItemdsc("B07") ;
	ArrayList prt7AL = prt7.getObjAL();
	split_idx = 1;
%>
	<td width="85%" align="left">
	    <table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr>
		<td width="25%"><input name="B07_yn" type="radio" value="Yes" onClick="showspan('B07','1')" checked><span class="txtxred">正常</span></td>
<%
	for(int i=0; i<prt7AL.size(); i++)
	{
		++split_idx;
%>
		<td width="25%"><input name="B07_yn" type="radio" value="B07/<%=prt7AL.get(i)%>" onClick="showspan('B07','2')"><%=prt7AL.get(i)%></td>
<%
	    if(split_idx%4==0)
		{
			out.println("</tr><tr>");
		}
	}	
%>
		<td width="25%"><input name="B07_yn" type="radio" value="B02/Galley漏水" onClick="showspan('B07','2')">Galley漏水</td>
<%	
		++split_idx;

	if(split_idx<4)
	{
		out.println("<td width=\"25%\">&nbsp;</td>");
	}
%>
		</tr>
		</table>
		<span style="display:none " id="B07_span" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td colspan="4">
		Note : <input type="text" size="50" maxlength="2000" name="B07_note" id="B07_note">
		</td></tr>
		<tr><td colspan="4">
		已誌CLB : <input name="B07_clb" type="radio" value="N">No&nbsp;&nbsp;
		<input name="B07_clb" type="radio" value="Y">Yes
		</td></tr>
		</table>
		</span>
	</td>
  </tr>
  <tr class="txtblue">
    <td width="15%" align="center" valign="middle">洗手間缺失</td>
<%
	PRreportTool prt8 = new PRreportTool();
	prt8.getCMPDItemdsc("B06") ;
	ArrayList prt8AL = prt8.getObjAL();
	split_idx = 1;
%>
	<td width="85%" align="left">
	    <table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr>
		<td width="25%"><input name="B06_yn" type="radio" value="Yes" onClick="showspan('B06','1')" checked><span class="txtxred">正常</span></td>
<%
	for(int i=0; i<prt8AL.size(); i++)
	{
		if(((String)prt8AL.get(i)).indexOf("異味") < 0)
		{
			++split_idx;
	%>
			<td width="25%"><input name="B06_yn" type="radio" value="B06/<%=prt8AL.get(i)%>" onClick="showspan('B06','2')"><%=prt8AL.get(i)%></td>
	<%
			if(split_idx%4==0)
			{
				out.println("</tr><tr>");
			}
		}
	}	
%>
		<td width="25%"><input name="B06_yn" type="radio" value="B02/LAV漏水" onClick="showspan('B06','2')">LAV漏水</td>
<%	
		++split_idx;

	if(split_idx<4)
	{
		out.println("<td width=\"25%\">&nbsp;</td>");
	}
%>
		</tr>
		</table>
		<span style="display:none " id="B06_span" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td colspan="4">
		Note : <input type="text" size="50" maxlength="2000" name="B06_note" id="B06_note">
		</td></tr>
		<tr><td colspan="4">
		已誌CLB : <input name="B06_clb" type="radio" value="N">No&nbsp;&nbsp;
		<input name="B06_clb" type="radio" value="Y">Yes
		</td></tr>
		<tr><td colspan="4">
		是否回報飛航組員 : <input name="B06_rca" type="radio" value="N">No&nbsp;&nbsp;
		<input name="B06_rca" type="radio" value="Y">Yes&nbsp;&nbsp;
		</td></tr>
		</table>
		</span>
	</td>
  </tr>
  <tr bgcolor="#DFDFDF"  class="txtblue">
    <td width="15%" align="center" valign="middle">洗手間異味</td>
<%
	split_idx = 1;
%>
	<td width="85%" align="left">
	    <table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr>
		<td width="25%"><input name="B06_2_yn" type="radio" value="Yes" onClick="showspan('B06_2','1')" checked><span class="txtxred">正常</span></td>
<%
	for(int i=0; i<prt8AL.size(); i++)
	{
		if(((String)prt8AL.get(i)).indexOf("異味") >= 0)
		{
			++split_idx;
	%>
			<td width="25%"><input name="B06_2_yn" type="radio" value="B06/<%=prt8AL.get(i)%>" onClick="showspan('B06_2','2')"><%=prt8AL.get(i)%></td>
	<%
			if(split_idx%4==0)
			{
				out.println("</tr><tr>");
			}
		}
	}	

	if(split_idx<4)
	{
		out.println("<td width=\"25%\">&nbsp;</td>");
	}
%>
		</tr>
		</table>
		<span style="display:none " id="B06_2_span" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td colspan="4">
		Note : <input type="text" size="50" maxlength="2000" name="B06_2_note" id="B06_2_note">
		</td></tr>
		<tr><td colspan="4">
		已誌CLB : <input name="B06_2_clb" type="radio" value="N">No&nbsp;&nbsp;
		<input name="B06_2_clb" type="radio" value="Y">Yes
		</td></tr>
		</table>
		</span>
	</td>
  </tr>

  <tr class="txtblue">
    <td width="15%" align="center" valign="middle">Crew Bunk</td>
<%
	PRreportTool prt9 = new PRreportTool();
	prt9.getCMPDItemdsc("B11") ;
	ArrayList prt9AL = prt9.getObjAL();
	split_idx = 1;
%>
	<td width="85%" align="left">
	    <table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr>
		<td width="25%"><input name="B11_yn" type="radio" value="Yes" onClick="showspan('B11','1')" checked><span class="txtxred">正常</span></td>
<%
	for(int i=0; i<prt9AL.size(); i++)
	{
		++split_idx;
%>
		<td width="25%"><input name="B11_yn" type="radio" value="B11/<%=prt9AL.get(i)%>" onClick="showspan('B11','2')"><%=prt9AL.get(i)%></td>
<%
	    if(split_idx%4==0)
		{
			out.println("</tr><tr>");
		}
	}	

	if(split_idx<4)
	{
		out.println("<td width=\"25%\">&nbsp;</td>");
	}
%>
		</tr>
		</table>
		<span style="display:none " id="B11_span" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td colspan="4">
		Note : <input type="text" size="50" maxlength="2000" name="B11_note" id="B11_note">
		</td></tr>
		<tr><td colspan="4">
		已誌CLB : <input name="B11_clb" type="radio" value="N">No&nbsp;&nbsp;
		<input name="B11_clb" type="radio" value="Y">Yes
		</td></tr>
		</table>
		</span>
	</td>
  </tr>
 </table>
</fieldset>
<!--*****************************************************************************-->
  <div align="center">
    <input type="submit" name="Submit" value="Save (新增)" class="addButton" >&nbsp;&nbsp;&nbsp;
	<input name="SendReport" type="button" class="addButton" value="Next(下一步)" onClick="sendReport()">&nbsp;&nbsp;&nbsp;
	<input name="reset" type="reset" value="Reset (清除重寫)">
	<!--ZC-->
<%
	eg.zcrpt.ZCReport zcrt = new eg.zcrpt.ZCReport();
    zcrt.getZCFltListForPR(fdate,fltno,dpt+arv,purserEmpno);
	ArrayList zcAL = zcrt.getObjAL();
	if(zcAL.size()>0)
	{
		eg.zcrpt.ZCReportObj zcobj = (eg.zcrpt.ZCReportObj) zcAL.get(0);
		if("Y".equals(zcobj.getIfsent()))
		{//已送出	  
%>
		&nbsp;&nbsp;&nbsp;
		<input type="button" name="viewzc" value="PR Report" class="bu" Onclick="javascript:window.open ('ZC/ZCreport_print.jsp?idx=0&fdate=<%=fdate%>&fltno=<%=fltno%>&port=<%=dpt%><%=arv%>&purempn=<%=purserEmpno%>','zcreport','height=600, width=800, toolbar=no, menubar=no, scrollbars=yes, resizable=yes');" >
<%
		}//已送出if("Y".equals(zcobj.getIfsent()))
	}//if(zcAL.size()>0)			
%>
	<!--ZC-->
        <input type="hidden" name="fltd" value="<%=fdate%>">
        <input type="hidden" name="fltno" value="<%=fltno%>">		
        <input type="hidden" name="dpt" value="<%=dpt%>">		
		<input type="hidden" name="arv" value="<%=arv%>">	
 		<input type="hidden" name="purserEmpno" value="<%=purserEmpno%>">	
		<input type="hidden" name="psrname" value="<%=psrname%>">	
 		<input type="hidden" name="psrsern" value="<%=psrsern%>">	
		
		<input type="hidden" name="fdate" value="<%=fdate%>">
		<input type="hidden" name="acno" value="<%=acno%>">	
		<input type="hidden" name="GdYear" value="<%=GdYear%>">
		<input type="hidden" name="ispart2" value="Y">	
		<input type="hidden" name="pur" value="<%=purserEmpno%>">
		<input type="hidden" name="isZ" value="<%=request.getParameter("isZ")%>">
		<br>
  <span class="txtxred">Input Note max length English 4000 words、Chinese 2000 words</span> </div>
</form>
<p align="center">&nbsp;</p>
</body>
</html>
<%

}
catch (Exception e)
{
	 out.print(e.toString());
	 //  response.sendRedirect("../showMessage.jsp?messagestring="+URLEncoder.encode("系統忙碌中，請稍後再試"));
}
finally
{
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>