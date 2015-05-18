<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="ci.db.*,fz.*,java.sql.*,java.net.URLEncoder,fz.pracP.*,java.util.ArrayList" %>
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

//登機準時資訊
fz.pracP.BordingOnTime borot = new fz.pracP.BordingOnTime(fdate,fltno,dpt+arv,purserEmpno);
try 
{
	borot.SelectData();
//	System.out.println("是否有flight資料：" + borot.isHasFlightInfo());
//	System.out.println("是否有登機資料：" + borot.isHasBdotInfo());

} 
catch (SQLException e) 
{
	System.out.print(e.toString());
	//out.print(e.toString());
} 
catch (Exception e) 
{
	System.out.print(e.toString());
	//out.print(e.toString());
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
//TODO在此處限制登機準時資訊必須輸入
function sendReport()
{	
	<%
	if(hasRecord)
	{
	
		out.print("document.form1.Submit.disabled=1;");
	}

	String submitPage = "upReportSave.jsp?src=6";
	if(isZ)
	{
		submitPage= "upReportSaveZ.jsp?src=6";
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
		document.getElementById("C03_span2").style.display="none";
		document.getElementById("C03_span3").style.display="none";

		for (var i=0; i < eval("document.form2.C03_str.length"); i++)
		{
			document.form2.C03_str[i].checked=false;
		}
		document.getElementById(key+"_note").value = "";
	}
	else
	{
		var span2_show = false;
		var span3_show = false;

		document.getElementById(key+"_span").style.display="";

		for (var i=0; i < eval("document.form2.C03_yn.length"); i++)
		{
			if (eval("document.form2.C03_yn[i].checked"))
			{				
				if(eval("document.form2.C03_yn[i].value") == "C03/OBT故障" )
				{
					span2_show = true;
				}

				if(eval("document.form2.C03_yn[i].value") == "C03/E-SHOPPING異常" )
				{
					span3_show = true;
				}
			}
		}

		if(span2_show == true)
		{
			document.getElementById("C03_span2").style.display="";
			document.getElementById("C03_span3").style.display="none";
		}
		else if(span3_show == true)
		{
			document.getElementById("C03_span2").style.display="none";
			document.getElementById("C03_span3").style.display="";
		}
		else
		{
			document.getElementById("C03_span2").style.display="none";
			document.getElementById("C03_span3").style.display="none";
			document.getElementById("C03_note").value="";

			for (var i=0; i < eval("document.form2.C03_str.length"); i++)
			{
				document.form2.C03_str[i].checked=false;
			}
		}
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
	document.getElementById(colname+"_note").value = c_value;
}
</script>
</head>
<body>
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
	<input name="src" id="src" type="hidden" value="5" >
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
	  <a href="#" onClick="subwinXY('edFltIrr2.jsp?isZ=<%=request.getParameter("isZ")%>&yearsern=<%=yearsern%>&purserEmpno=<%=purserEmpno%>&pur=<%=purserEmpno%>&src=5','','700','350')"><u><%=itemNoDsc%></u></a></td>
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
if(count > 0){
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
        <input type="button" value="DELETE" onClick="if(confirm('確定要刪除檔案：<%=filename.get(i)%> ?')){self.location='FTP/delFile.jsp?isZ=<%=request.getParameter("isZ")%>&fdate=<%=fdate%>&fltno=<%=fltno%>&dpt=<%=dpt%>&arv=<%=arv%>&uploadFileName=<%=filename.get(i)%>&purserEmpno=<%=purserEmpno%>&acno=<%=acno%>&src=5';this.disabled=1;}else{return false;}" style="background-color:#BFE4FF;color:#00487D;font-family:Verdana ">
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
  <input name="upload" type="button" class="addButton" value="Upload(上傳檔案)" onClick="subwinXY('FTP/uploadfile.jsp?isZ=<%=request.getParameter("isZ")%>&fdate=<%=fdate%>&fltno=<%=fltno%>&dpt=<%=dpt%>&arv=<%=arv%>&purserEmpno=<%=purserEmpno%>&acno=<%=acno%>&src=5','delUpload','700','350')">
  <br>
</div>
<!--****************************************************************************-->
<form name="form2" method="post" action="upFltIrr.jsp" onSubmit="return checkCharacter()">
<input type="hidden" name="src" value="5">
<div align="center">
<fieldset style="width:90%; ">
<legend class="txttitletop">客艙服務</legend>
<P>
  <table width="95%" cellpadding="2" cellspacing="2" border="0">
  <tr bgcolor="#DFDFDF" class="txtblue">
    <td width="15%" align="center" valign="middle">免稅品</td>
<%
	PRreportTool prt1 = new PRreportTool();
	prt1.getCMPDItemdsc("C03") ;
	ArrayList prt1AL = prt1.getObjAL();
	int split_idx = 1;
%>
	<td width="85%" align="left">
	    <table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr>
		<td width="25%"><input name="C03_yn" type="radio" value="Yes" onClick="showspan('C03','1')" checked><span class="txtxred">正常</span></td>
<%
	for(int i=0; i<prt1AL.size(); i++)
	{
		++split_idx;
%>
		<td width="25%"><input name="C03_yn" type="radio" value="C03/<%=prt1AL.get(i)%>" onClick="showspan('C03','2')"><%=prt1AL.get(i)%></td>
<%
	    if(split_idx%4==0)
		{
			out.println("</tr><tr>");
		}
	}	
%>
		</tr>
		</table>
		<span style="display:none " id="C03_span" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td colspan="4">
		Note : <input type="text" size="50" maxlength="2000" name="C03_note" id="C03_note">
		</td></tr>
		</table>
		</span>
		<span style="display:none " id="C03_span2" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td colspan="4">
		      <input type="checkbox" name="C03_str" value="2R" onclick="compose_note('C03')">2R
			  <input type="checkbox" name="C03_str" value="3L" onclick="compose_note('C03')">3L
		      <input type="checkbox" name="C03_str" value="3R" onclick="compose_note('C03')">3R
		      <input type="checkbox" name="C03_str" value="4R" onclick="compose_note('C03')">4R 
		      <input type="checkbox" name="C03_str" value="5L" onclick="compose_note('C03')">5L
			  <input type="checkbox" name="C03_str" value="DFA" onclick="compose_note('C03')">DFA
		</td></tr>
		</table>
		</span>
		<span style="display:none " id="C03_span3" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td colspan="4">
		      <input type="checkbox" name="C03_str" value="PIL未顯示PONO" onclick="compose_note('C03')">PIL未顯示PONO
			  <input type="checkbox" name="C03_str" value="未裝載" onclick="compose_note('C03')">未裝載
		      <input type="checkbox" name="C03_str" value="裝載不符" onclick="compose_note('C03')">裝載不符
		</td></tr>
		</table>
		</span>
	</td>
  </tr>
  <tr class="txtblue">
    <td width="15%" align="center" valign="middle">各式影片</td>
<%
	PRreportTool prt2 = new PRreportTool();
	prt2.getCMPDItemdsc("C01") ;
	ArrayList prt2AL = prt2.getObjAL();
	split_idx = 1;
%>
	<td width="85%" align="left">
	    <table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr>
		<td width="25%"><input name="C01_yn" type="radio" value="Yes" onClick="showspan('C01','1')" checked><span class="txtxred">正常</span></td>
<%
	for(int i=0; i<prt2AL.size(); i++)
	{
		++split_idx;
%>
		<td width="25%"><input name="C01_yn" type="radio" value="C01/<%=prt2AL.get(i)%>" onClick="showspan('C01','2')"><%=prt2AL.get(i)%></td>
<%
	    if(split_idx%4==0)
		{
			out.println("</tr><tr>");
		}
	}	
%>
		</tr>
		</table>
		<span style="display:none " id="C01_span" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td colspan="4">
		Note : <input type="text" size="50" maxlength="2000" name="C01_note" id="C01_note">
		</td></tr>
		</table>
		</span>
	</td>
  </tr>
  <tr bgcolor="#DFDFDF" class="txtblue">
    <td width="15%" align="center" valign="middle">閱讀刊物</td>
<%
	PRreportTool prt3 = new PRreportTool();
	prt3.getCMPDItemdsc("C05") ;
	ArrayList prt3AL = prt3.getObjAL();
	split_idx = 1;
%>
	<td width="85%" align="left">
	    <table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr>
		<td width="25%"><input name="C05_yn" type="radio" value="Yes" onClick="showspan('C05','1')" checked><span class="txtxred">正常</span></td>
<%
	for(int i=0; i<prt3AL.size(); i++)
	{
		++split_idx;
%>
		<td width="25%"><input name="C05_yn" type="radio" value="C05/<%=prt3AL.get(i)%>" onClick="showspan('C05','2')"><%=prt3AL.get(i)%></td>
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
		<span style="display:none " id="C05_span" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td colspan="4">
		Note : <input type="text" size="50" maxlength="2000" name="C05_note" id="C05_note">
		</td></tr>
		</table>
		</span>
	</td>
  </tr>
  <tr class="txtblue">
    <td width="15%" align="center" valign="middle">枕頭毛毯</td>
<%
	PRreportTool prt4 = new PRreportTool();
	prt4.getCMPDItemdsc("C10") ;
	ArrayList prt4AL = prt4.getObjAL();
	split_idx = 1;
%>
	<td width="85%" align="left">
	    <table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr>
		<td width="25%"><input name="C10_yn" type="radio" value="Yes" onClick="showspan('C10','1')" checked><span class="txtxred">正常</span></td>
<%
	for(int i=0; i<prt4AL.size(); i++)
	{
		++split_idx;
%>
		<td width="25%"><input name="C10_yn" type="radio" value="C10/<%=prt4AL.get(i)%>" onClick="showspan('C10','2')"><%=prt4AL.get(i)%></td>
<%
	    if(split_idx%4==0)
		{
			out.println("</tr><tr>");
		}
	}	
%>
		</tr>
		</table>
		<span style="display:none " id="C10_span" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td colspan="4">
		Note : <input type="text" size="50" maxlength="2000" name="C10_note" id="C10_note">
		</td></tr>
		</table>
		</span>
	</td>
  </tr>
  <tr bgcolor="#DFDFDF" class="txtblue">
    <td width="15%" align="center" valign="middle">毛巾/布類</td>
<%
	PRreportTool prt5 = new PRreportTool();
	prt5.getCMPDItemdsc("D09") ;
	ArrayList prt5AL = prt5.getObjAL();
	split_idx = 1;
%>
	<td width="85%" align="left">
	    <table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr>
		<td width="25%"><input name="D09_yn" type="radio" value="Yes" onClick="showspan('D09','1')" checked><span class="txtxred">正常</span></td>
<%
	for(int i=0; i<prt5AL.size(); i++)
	{
		++split_idx;
%>
		<td width="25%"><input name="D09_yn" type="radio" value="D09/<%=prt5AL.get(i)%>" onClick="showspan('D09','2')"><%=prt5AL.get(i)%></td>
<%
	    if(split_idx%4==0)
		{
			out.println("</tr><tr>");
		}
	}	
%>
		</tr>
		</table>
		<span style="display:none " id="D09_span" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td colspan="4">
		Note : <input type="text" size="50" maxlength="2000" name="D09_note" id="D09_note">
		</td></tr>
		</table>
		</span>
	</td>
  </tr>
  <tr class="txtblue">
    <td width="15%" align="center" valign="middle">拖鞋</td>
<%
	PRreportTool prt6 = new PRreportTool();
	prt6.getCMPDItemdsc("C11") ;
	ArrayList prt6AL = prt6.getObjAL();
	split_idx = 1;
%>
	<td width="85%" align="left">
	    <table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr>
		<td width="25%"><input name="C11_yn" type="radio" value="Yes" onClick="showspan('C11','1')" checked><span class="txtxred">正常</span></td>
<%
	for(int i=0; i<prt6AL.size(); i++)
	{
		++split_idx;
%>
		<td width="25%"><input name="C11_yn" type="radio" value="C11/<%=prt6AL.get(i)%>" onClick="showspan('C11','2')"><%=prt6AL.get(i)%></td>
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
		<span style="display:none " id="C11_span" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td colspan="4">
		Note : <input type="text" size="50" maxlength="2000" name="C11_note" id="C11_note">
		</td></tr>
		</table>
		</span>
	</td>
  </tr>
  <tr bgcolor="#DFDFDF" class="txtblue">
    <td width="15%" align="center" valign="middle">盥洗包</td>
<%
	PRreportTool prt7 = new PRreportTool();
	prt7.getCMPDItemdsc("C02") ;
	ArrayList prt7AL = prt7.getObjAL();
	split_idx = 1;
%>
	<td width="85%" align="left">
	    <table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr>
		<td width="25%"><input name="C02_yn" type="radio" value="Yes" onClick="showspan('C02','1')" checked><span class="txtxred">正常</span></td>
<%
	for(int i=0; i<prt7AL.size(); i++)
	{
		++split_idx;
%>
		<td width="25%"><input name="C02_yn" type="radio" value="C02/<%=prt7AL.get(i)%>" onClick="showspan('C02','2')"><%=prt7AL.get(i)%></td>
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
		<span style="display:none " id="C02_span" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td colspan="4">
		Note : <input type="text" size="50" maxlength="2000" name="C02_note" id="C02_note">
		</td></tr>
		</table>
		</span>
	</td>
  </tr>
  <tr class="txtblue">
    <td width="15%" align="center" valign="middle">耳機</td>
<%
	PRreportTool prt8 = new PRreportTool();
	prt8.getCMPDItemdsc("C15") ;
	ArrayList prt8AL = prt8.getObjAL();
	split_idx = 1;
%>
	<td width="85%" align="left">
	    <table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr>
		<td width="25%"><input name="C15_yn" type="radio" value="Yes" onClick="showspan('C15','1')" checked><span class="txtxred">正常</span></td>
<%
	for(int i=0; i<prt8AL.size(); i++)
	{
		++split_idx;
%>
		<td width="25%"><input name="C15_yn" type="radio" value="C15/<%=prt8AL.get(i)%>" onClick="showspan('C15','2')"><%=prt8AL.get(i)%></td>
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
		<span style="display:none " id="C15_span" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td colspan="4">
		Note : <input type="text" size="50" maxlength="2000" name="C15_note" id="C15_note">
		</td></tr>
		</table>
		</span>
	</td>
  </tr>
  <tr bgcolor="#DFDFDF" class="txtblue">
    <td width="15%" align="center" valign="middle">雜貨箱\車廚具箱 P.S.K</td>
<%
	PRreportTool prt9 = new PRreportTool();
	prt9.getCMPDItemdsc("C07") ;
	ArrayList prt9AL = prt9.getObjAL();
	split_idx = 1;
%>
	<td width="85%" align="left">
	    <table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr>
		<td width="25%"><input name="C07_yn" type="radio" value="Yes" onClick="showspan('C07','1')" checked><span class="txtxred">正常</span></td>
<%
	for(int i=0; i<prt9AL.size(); i++)
	{
		++split_idx;
%>
		<td width="25%"><input name="C07_yn" type="radio" value="C07/<%=prt9AL.get(i)%>" onClick="showspan('C07','2')"><%=prt9AL.get(i)%></td>
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
		<span style="display:none " id="C07_span" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td colspan="4">
		Note : <input type="text" size="50" maxlength="2000" name="C07_note" id="C07_note">
		</td></tr>
		</table>
		</span>
	</td>
  </tr>
  <tr class="txtblue">
    <td width="15%" align="center" valign="middle">其他空服用品</td>
<%
	PRreportTool prt10 = new PRreportTool();
	prt10.getCMPDItemdsc("C09") ;
	ArrayList prt10AL = prt10.getObjAL();
	split_idx = 1;
%>
	<td width="85%" align="left">
	    <table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr>
		<td width="25%"><input name="C09_yn" type="radio" value="Yes" onClick="showspan('C09','1')" checked><span class="txtxred">正常</span></td>
<%
	for(int i=0; i<prt10AL.size(); i++)
	{
		++split_idx;
%>
		<td width="25%"><input name="C09_yn" type="radio" value="C09/<%=prt10AL.get(i)%>" onClick="showspan('C09','2')"><%=prt10AL.get(i)%></td>
<%
	    if(split_idx%4==0)
		{
			out.println("</tr><tr>");
		}
	}
%>
		<td width="25%"><input name="C09_yn" type="radio" value="C13/空服用品遺失" onClick="showspan('C09','2')">空服用品遺失</td>
<%	
		++split_idx;

	if(split_idx<4)
	{
		out.println("<td width=\"25%\">&nbsp;</td>");
	}
%>
		</tr>
		</table>
		<span style="display:none " id="C09_span" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td colspan="4">
		Note : <input type="text" size="50" maxlength="2000" name="C09_note" id="C09_note">
		</td></tr>
		</table>
		</span>
	</td>
  </tr>
  <tr bgcolor="#DFDFDF" class="txtblue">
    <td width="15%" align="center" valign="middle">飲料</td>
<%
	PRreportTool prt11 = new PRreportTool();
	prt11.getCMPDItemdsc("C12") ;
	ArrayList prt11AL = prt11.getObjAL();
	split_idx = 1;
%>
	<td width="85%" align="left">
	    <table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr>
		<td width="25%"><input name="C12_yn" type="radio" value="Yes" onClick="showspan('C12','1')" checked><span class="txtxred">正常</span></td>
<%
	for(int i=0; i<prt11AL.size(); i++)
	{
		++split_idx;
%>
		<td width="25%"><input name="C12_yn" type="radio" value="C12/<%=prt11AL.get(i)%>" onClick="showspan('C12','2')"><%=prt11AL.get(i)%></td>
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
		<span style="display:none " id="C12_span" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td colspan="4">
		Note : <input type="text" size="50" maxlength="2000" name="C12_note" id="C12_note">
		</td></tr>
		</table>
		</span>
	</td>
  </tr>

  <tr class="txtblue">
    <td width="15%" align="center" valign="middle">特別餐</td>
<%
	PRreportTool prt12 = new PRreportTool();
	prt12.getCMPDItemdsc("D01") ;
	ArrayList prt12AL = prt12.getObjAL();
	split_idx = 1;
%>
	<td width="85%" align="left">
	    <table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr>
		<td width="25%"><input name="D01_yn" type="radio" value="Yes" onClick="showspan('D01','1')" checked><span class="txtxred">正常</span></td>
<%
	for(int i=0; i<prt12AL.size(); i++)
	{
		if(((String)prt12AL.get(i)).indexOf("PIL") < 0 && ((String)prt12AL.get(i)).indexOf("取消") < 0)
		{
			++split_idx;
%>
			<td width="25%"><input name="D01_yn" type="radio" value="D01/<%=prt12AL.get(i)%>" onClick="showspan('D01','2')"><%=prt12AL.get(i)%></td>
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
		<tr>
		<td width="25%"><span class="txtxred">訂餐異常 : </span></td>
<%
	for(int i=0; i<prt12AL.size(); i++)
	{
		if(((String)prt12AL.get(i)).indexOf("PIL") >= 0 | ((String)prt12AL.get(i)).indexOf("取消") >= 0)
		{
			++split_idx;
%>
			<td width="25%"><input name="D01_yn" type="radio" value="D01/<%=prt12AL.get(i)%>" onClick="showspan('D01','2')"><%=prt12AL.get(i)%></td>
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
		<span style="display:none " id="D01_span" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td colspan="4">
		Note : <input type="text" size="50" maxlength="2000" name="D01_note" id="D01_note">
		</td></tr>
		<tr><td colspan="4">
		 已誌In Flight Meal Check Report : <input name="D01_mcr" type="radio" value="N">No&nbsp;&nbsp;
		<input name="D01_mcr" type="radio" value="Y">Yes
		</td></tr>
		</table>
		</span>
	</td>
  </tr>

  <tr bgcolor="#DFDFDF" class="txtblue">
    <td width="15%" align="center" valign="middle">FCL餐點</td>
<%
	PRreportTool prt13 = new PRreportTool();
	prt13.getCMPDItemdsc("D10") ;
	ArrayList prt13AL = prt13.getObjAL();
	split_idx = 1;
%>
	<td width="85%" align="left">
	    <table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr>
		<td width="25%"><input name="D10_yn" type="radio" value="Yes" onClick="showspan('D10','1')" checked><span class="txtxred">正常</span></td>
<%
	for(int i=0; i<prt13AL.size(); i++)
	{
		++split_idx;
%>
		<td width="25%"><input name="D10_yn" type="radio" value="D10/<%=prt13AL.get(i)%>" onClick="showspan('D10','2')"><%=prt13AL.get(i)%></td>
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
		<span style="display:none " id="D10_span" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td colspan="4">
		Note : <input type="text" size="50" maxlength="2000" name="D10_note" id="D10_note">
		</td></tr>
		<tr><td colspan="4">
		 已誌In Flight Meal Check Report : <input name="D10_mcr" type="radio" value="N">No&nbsp;&nbsp;
		<input name="D10_mcr" type="radio" value="Y">Yes
		</td></tr>
		</table>
		</span>
	</td>
  </tr>

  <tr class="txtblue">
    <td width="15%" align="center" valign="middle">CCL餐點</td>
<%
	PRreportTool prt14 = new PRreportTool();
	prt14.getCMPDItemdsc("D11") ;
	ArrayList prt14AL = prt14.getObjAL();
	split_idx = 1;
%>
	<td width="85%" align="left">
	    <table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr>
		<td width="25%"><input name="D11_yn" type="radio" value="Yes" onClick="showspan('D11','1')" checked><span class="txtxred">正常</span></td>
<%
	for(int i=0; i<prt14AL.size(); i++)
	{
		++split_idx;
%>
		<td width="25%"><input name="D11_yn" type="radio" value="D11/<%=prt14AL.get(i)%>" onClick="showspan('D11','2')"><%=prt14AL.get(i)%></td>
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
		<span style="display:none " id="D11_span" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td colspan="4">
		Note : <input type="text" size="50" maxlength="2000" name="D11_note" id="D11_note">
		</td></tr>
		<tr><td colspan="4">
		 已誌In Flight Meal Check Report : <input name="D11_mcr" type="radio" value="N">No&nbsp;&nbsp;
		<input name="D11_mcr" type="radio" value="Y">Yes
		</td></tr>
		</table>
		</span>
	</td>
  </tr>

  <tr bgcolor="#DFDFDF" class="txtblue">
    <td width="15%" align="center" valign="middle">YCL餐點</td>
<%
	PRreportTool prt15 = new PRreportTool();
	prt15.getCMPDItemdsc("D12") ;
	ArrayList prt15AL = prt15.getObjAL();
	split_idx = 1;
%>
	<td width="85%" align="left">
	    <table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr>
		<td width="25%"><input name="D12_yn" type="radio" value="Yes" onClick="showspan('D12','1')" checked><span class="txtxred">正常</span></td>
<%
	for(int i=0; i<prt15AL.size(); i++)
	{
		++split_idx;
%>
		<td width="25%"><input name="D12_yn" type="radio" value="D12/<%=prt15AL.get(i)%>" onClick="showspan('D12','2')"><%=prt15AL.get(i)%></td>
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
		<span style="display:none " id="D12_span" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td colspan="4">
		Note : <input type="text" size="50" maxlength="2000" name="D12_note" id="D12_note">
		</td></tr>
		<tr><td colspan="4">
		 已誌In Flight Meal Check Report : <input name="D12_mcr" type="radio" value="N">No&nbsp;&nbsp;
		<input name="D12_mcr" type="radio" value="Y">Yes
		</td></tr>
		</table>
		</span>
	</td>
  </tr>
  <tr bgcolor="#DFDFDF" class="txtblue">
    <td width="15%" align="center" valign="middle">組員餐</td>
<%
	PRreportTool prt16 = new PRreportTool();
	prt16.getCMPDItemdsc("D13") ;
	ArrayList prt16AL = prt16.getObjAL();
	split_idx = 1;
%>
	<td width="85%" align="left">
	    <table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr>
		<td width="25%"><input name="D13_yn" type="radio" value="Yes" onClick="showspan('D13','1')" checked><span class="txtxred">正常</span></td>
<%
	for(int i=0; i<prt16AL.size(); i++)
	{
		++split_idx;
%>
		<td width="25%"><input name="D13_yn" type="radio" value="D13/<%=prt16AL.get(i)%>" onClick="showspan('D13','2')"><%=prt16AL.get(i)%></td>
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
		<span style="display:none " id="D13_span" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td colspan="4">
		Note : <input type="text" size="50" maxlength="2000" name="D13_note" id="D13_note">
		</td></tr>
		<tr><td colspan="4">
		 已誌In Flight Meal Check Report : <input name="D13_mcr" type="radio" value="N">No&nbsp;&nbsp;
		<input name="D13_mcr" type="radio" value="Y">Yes
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