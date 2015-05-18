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
		response.sendRedirect("../showmessage.jsp?messagestring="+URLEncoder.encode("非本班機客艙經理，不得使用此功能") );		
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

		if( !borot.isHasBdotInfo())
		{
	%>
			alert("Crew Boarding on Time 資訊必須輸入,方能送出報告!!\n"
			+"請點選 Save 按鈕.");
			return false;
	<%
		}
		else
		{
			String submitPage = "upReportSave.jsp";
			if(isZ)
			{
				submitPage= "upReportSaveZ.jsp";
			}
	%>
		document.form2.Submit.disabled=1;
		document.form2.SendReport.disabled=1;
		document.form2.action="<%=submitPage%>";
		document.form2.submit();
	<%
		}
	%>
	//return true;
}

function showBt(flag)
{
	if("1" == flag)
	{	//選擇準時為Y
		document.getElementById("botN").style.display="none";
		document.getElementById("bdtm").focus();
	}
	else
	{	//選擇準時為N
		document.getElementById("botN").style.display="";
		document.getElementById("bdtm").focus();
		document.getElementById("bdreason").style.background="#FFFFCC";
		
	}
}

function compose_note(colname)//20130418新增
{
	var c_value = "";
	for (var i=0; i < eval("document.bdForm."+colname+".length"); i++)
	{
		if (eval("document.bdForm."+colname+"[i].checked"))
		{
			c_value = c_value+" "+ eval("document.bdForm."+colname+"[i].value") ;
		}
	}
	//alert(c_value);
	document.getElementById("bdreason").value = c_value ;
}

function showspan(key,status)
{
	if(status==1)
	{
		for (var i=0; i < eval("document.form2."+key+"_yn_box.length"); i++)
		{
			eval("document.form2."+key+"_yn_box[i].checked=false");
		}
		document.getElementById(key+"_note").value="";
		document.getElementById(key+"_span").style.display="none";
	}
	else //status==2
	{
		document.getElementById(key+"_yn").checked=false;
		document.getElementById(key+"_span").style.display="";
	}
}

function initBt()
{//初始化登機準時資訊
	<%
	if ( !borot.isHasFlightInfo()	| (borot.isHasFlightInfo() && !borot.isHasBdotInfo() ) ) 
	{ //預設值為準時
	%>
		document.getElementById("bdotY").checked=true;
		document.getElementById("bdotN").checked=false;
		showBt(1);
	<%
	}
	else
	{
		if("Y".equals(borot.getBdot()))
		{
%>
		document.getElementById("bdotY").checked=true;
		document.getElementById("bdotN").checked=false;
		showBt(1);
<%		
		}
		else
		{
%>
		document.getElementById("bdotY").checked=false;
		document.getElementById("bdotN").checked=true;
		<%
		String str = "";
		if(borot.getBdReason() != null)
		{
			str = ci.tool.ReplaceAllFor1_3.replace(borot.getBdReason(),"\"","\\\"");
		}
		%>
		document.getElementById("bdreason").value="<%=str%>";	
		showBt(2);
<%		
		}
	}
%>
}

function chkBdot()
{
	//選擇不準時，需輸入時間及理由
	var bdr = document.getElementById("bdreason").value;
	if(document.getElementById("bdotN").checked )
	{
		if("" == bdr)
		{
			alert("請輸入不準時原因!!");
			document.getElementById("bdreason").focus();
			return false;
		}
	}
}

</script>
</head>
<body onLoad="initBt()">
<!--***************************************************************************-->
<form name="bdForm" method="post" action="updBdot.jsp" onsubmit="return chkBdot()">
<div align="center">
<table width="90%"  border="0" align="center" cellpadding="2" cellspacing="0" bgcolor="#CCFFFF" >
<tr>
  <td width="27%" class="txtblue">FltDate:<span class="txtxred"><%=fdate%></span></td>
  <td width="23%" class="txtblue">Fltno:<span class="txtxred"><%=fltno%></span></td>
  <td width="25%" class="txtblue">Sector:<span class="txtxred"><%=dpt%><%=arv%></span></td>
  <td width="25%" class="txtblue">ACNO:<span class="txtxred"><%=acno%></span></td>
</tr>
</table>
<fieldset style="width:90%; ">
<legend class="txttitletop">Crew Boarding On Time</legend>
<P>
<table align="center"  width="95%">
<tr>  
  <td align="left"><span class="txtblue">組員登機準時：
      <label>
      <input type="radio" name="bdot" value="Y"  onClick="showBt(1)" id="bdotY">
      <span class="txtxred">Yes</span></label>
      <label>
      <input type="radio" name="bdot" value="N" onClick="showBt(2)" id="bdotN">
      </label>
	  </span>
      <label><span class="txtblue">No</span></label>
		<span style="display:none " id="botN" class="txtblue">不準時原因：
		<input type="text" name="bdreason" maxlength="2000" size="50" id="bdreason">
		<input type="checkbox" name="bd" value="高速公路塞車" onclick="compose_note('bd');">高速公路塞車
		<input type="checkbox" name="bd" value="飛機晚到" onclick="compose_note('bd');">飛機晚到
		</span>
  </td>
</tr>
<tr>
  <td align="left">
    <input type="submit" name="Submit" value="Save" style="background-color:#3366CC;color:#FFFFFF;font-family:Verdana " id="bdsb">
	<!--<input type="reset" value="Reset">-->
		<input type="hidden" name="fdate" value="<%=fdate%>">
		<input type="hidden" name="fltno" value="<%=fltno%>">	
		<input type="hidden" name="acno" value="<%=acno%>">	
		<input type="hidden" name="sect" value="<%=dpt+arv%>">		
		<input type="hidden" name="purserEmpno" value="<%=purserEmpno%>">	
		<input type="hidden" name="psrname" value="<%=psrname%>">	
		<input type="hidden" name="psrsern" value="<%=psrsern%>">
		<input type="hidden" name="pgroups" value="<%=pgroups%>">
		<input type="hidden" name="GdYear" value="<%=GdYear%>">
		<input type="hidden" name="isZ" value="<%=request.getParameter("isZ")%>">
		<input type="hidden" name="bdtmyyyy" value="<%=fdate.substring(0,4)%>" id="bdtmyyyy">
		<input type="hidden" name="bdtmmm" value="<%=fdate.substring(5,7)%>" id="bdtmmm">
		<input type="hidden" name="bdtmdd" value="<%=fdate.substring(8)%>" id="bdtmdd">
		<input type="hidden" name="bdtm" value="0001" id="bdtm">
  </td>
  </tr>
</table>
</fieldset>
</form>
<p>
<!--****************************************************************************-->
<form name="form1" onSubmit="return del('form1');" action="delFltIrr.jsp">
<%
//有資料才show
if(hasRecord)
{
%>
<table width="90%"  border="0" align="center" cellpadding="2" cellspacing="0" class="fortable">
<tr class="tablehead2">
      <td width="4%">&nbsp;</td>
      <td colspan="2">Item<br>(點下列選項-編輯更多文字)</td>
      <td width="47%">Comments</td>
      <td width="5%">CLB</td>
 	  <td width="7%">Meal<br>Check</td>
      <td width="7%">回報<br>飛航<br>組員</td>
      <td width="7%">使用<br>緊急<br>設備</td>
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
      <td width="11%" class="fortable txtblue" align="left" > 
	  <img src="../images/pencil.gif" width="15" height="15">
	  <a href="#" onClick="subwinXY('edFltIrr2.jsp?isZ=<%=request.getParameter("isZ")%>&yearsern=<%=yearsern%>&purserEmpno=<%=purserEmpno%>&pur=<%=purserEmpno%>','','700','350')"><u><%=itemNoDsc%></u></a></td>
      <td width="12%" class="fortable txtblue" ><%=itemDsc%></td>
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
  <br>
  <span class="purple_txt"><strong>*Click Item to Edit(點選Item即可進入編輯comments)<br>
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
        <input type="button" value="DELETE" onClick="if(confirm('確定要刪除檔案：<%=filename.get(i)%> ?')){self.location='FTP/delFile.jsp?isZ=<%=request.getParameter("isZ")%>&fdate=<%=fdate%>&fltno=<%=fltno%>&dpt=<%=dpt%>&arv=<%=arv%>&uploadFileName=<%=filename.get(i)%>&purserEmpno=<%=purserEmpno%>&acno=<%=acno%>';this.disabled=1;}else{return false;}" style="background-color:#BFE4FF;color:#00487D;font-family:Verdana ">
      </div>
    </td>
    <td class="fortable txtblue"><a href="http://cabincrew.china-airlines.com/prptt/<%=filename.get(i)%>" target="_blank"><%=filename.get(i)%></a></td>
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
  <input name="upload" type="button" class="addButton" value="Upload(上傳檔案)" onClick="subwinXY('FTP/uploadfile.jsp?isZ=<%=request.getParameter("isZ")%>&fdate=<%=fdate%>&fltno=<%=fltno%>&dpt=<%=dpt%>&arv=<%=arv%>&purserEmpno=<%=purserEmpno%>&acno=<%=acno%>','delUpload','700','350')">
  <br>
</div>

<div align="center">
  <input name="addPR" type="button" class="addButton" value="選擇內容:PR REPORT" onClick="subwinXY('addZcFileAndFltIrr.jsp?sect=<%=dpt%><%=arv%>&fltd=<%=fdate%>&fltno=<%=fltno%>&GdYear=<%=GdYear%>&psrname=<%=psrname%>&psrsern=<%=psrsern%>','addPR','700','350')"/>
  <br/>
</div>
<!--****************************************************************************-->
<form name="form2" method="post" action="upFltIrr.jsp" onSubmit="return checkCharacter()">
<div align="center">
<fieldset style="width:90%; ">
<legend class="txttitletop">班機經常事務</legend>
<!--<span class="txtxred"><strong>若需輸入超過1000中文字或2000英文字,請新增後,再到上方item編輯</strong></span>-->
<table width="95%" cellpadding="2" cellspacing="2" border="0">
  <tr class="txtblue">
    <td width="20%" align="left">低於服務派遣派遣</td>
	<td width="85%" align="left">
		<input name="I01_yn" type="radio" value="no" onClick="showspan('I01','1')" checked>
		<span class="txtxred">No</span>&nbsp;&nbsp;
		<input name="I01_yn" type="radio" value="Yes" onClick="showspan('I01','2')">Yes &nbsp;&nbsp;
		<span style="display:none" id="I01_span">
		<select name="I01">
			<option value="低於服務派遣一人" selected>低於服務派遣一人</option>
			<option value="低於服務派遣二人">低於服務派遣二人</option>
			<option value="低於服務派遣三人">低於服務派遣三人</option>
			<option value="低於服務派遣四人">低於服務派遣四人</option>
			<option value="低於服務派遣五人">低於服務派遣五人</option>
			<option value="低於服務派遣六人">低於服務派遣六人</option>
		</select>
		&nbsp;&nbsp;Note : <input type="text" size="30" maxlength="2000" name="I01_note" id="I01_note">
		</span>
	</td>
  </tr>
  <tr class="txtblue">
    <td align="left">臨時彈派</td>
	<td align="left">
		<input name="I13_yn" type="radio" value="no" onClick="showspan('I13','1')" checked>
		<span class="txtxred">No</span>&nbsp;&nbsp;
		<input name="I13_yn" type="radio" value="Yes" onClick="showspan('I13','2')">Yes &nbsp;&nbsp;
		<span style="display:none" id="I13_span">
		<select name="I13">
			<option value="DFA">DFA</option>
		</select>
		&nbsp;&nbsp;Note : <input type="text" size="30" maxlength="2000" name="I13_note" id="I13_note">
		</span>
	</td>
  </tr>
  <tr class="txtblue">
    <td align="left">休時不足及工作超時</td>
	<td align="left">
		<input name="I08_yn" type="radio" value="no" onClick="showspan('I08','1')" checked>
		<span class="txtxred">No</span>&nbsp;&nbsp;
		<input name="I08_yn" type="radio" value="Yes" onClick="showspan('I08','2')">Yes&nbsp;&nbsp;
		<span style="display:none" id="I08_span">
		Note : <input type="text" size="43" maxlength="2000" name="I08_note" id="I08_note">
		</span>
	</td>
  </tr>
</table>
 <hr>
  <table width="95%" cellpadding="2" cellspacing="2" border="0">
  <tr bgcolor="#DFDFDF" class="txtblue">
    <td width="15%" align="center" valign="middle">班機準時</td>
<%
	PRreportTool prt1 = new PRreportTool();
	prt1.getCMPDItemdsc2("J") ;
	ArrayList prt1AL = prt1.getObjAL();
	int split_idx = 1;
%>
	<td width="90%" align="left">
	    <table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr>		
		<td width="25%"><input name="J_yn" id="J_yn" type="radio" value="Yes" onClick="showspan('J','1')" checked><span class="txtxred">正常</span></td>
<%
	for(int i=0; i<prt1AL.size(); i++)
	{
		PRreportToolObj obj = (PRreportToolObj) prt1AL.get(i); 
		++split_idx;
%>
		<td width="25%"><input name="J_yn_box" id="J_yn_box" type="checkbox"  value="<%=obj.getPi_itemno()%>/<%=obj.getPi_itemdsc()%>-<%=obj.getLevel()%>" onClick="showspan('J','2')"><%=obj.getPi_itemdsc()%></td>
<%
	    if(split_idx%4==0)
		{
			out.println("</tr><tr>");
		}
	}	
%>
		</tr>
		</table>
		<span style="display:none " id="J_span" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td colspan="4">
		Note : <input type="text" size="50" maxlength="2000" name="J_note" id="J_note">
		</td></tr>
		</table>
		</span>		
	</td>
  </tr>
  <tr class="txtblue">
    <td width="15%" align="center" valign="middle">客艙清潔</td>
<%
	PRreportTool prt2 = new PRreportTool();
	prt2.getCMPDItemdsc2("F") ;
	ArrayList prt2AL = prt2.getObjAL();
	split_idx = 1;
%>
	<td width="90%" align="left">
	    <table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr>
		<td width="25%"><input name="F_yn" id="F_yn" type="radio" value="Yes" onClick="showspan('F','1')" checked><span class="txtxred">正常</span></td>
<%
	for(int i=0; i<prt2AL.size(); i++)
	{
		PRreportToolObj obj = (PRreportToolObj) prt2AL.get(i); 
		++split_idx;
%>
		<td width="25%"><input name="F_yn_box" id="F_yn_box" type="checkbox" value="<%=obj.getPi_itemno()%>/<%=obj.getPi_itemdsc()%>-<%=obj.getLevel()%>" onClick="showspan('F','2')"><%=obj.getPi_itemdsc()%>未落實</td>
<%
	    if(split_idx%4==0)
		{
			out.println("</tr><tr>");
		}
	}	
%>
		</tr>
		</table>
		<span style="display:none " id="F_span" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td colspan="4">
		Note : <input type="text" size="50" maxlength="2000" name="F_note" id="F_note">
		</td></tr>		
		</table>
		</span>
	</td>
  </tr>
  <tr bgcolor="#DFDFDF"  class="txtblue">
    <td width="15%" align="center" valign="middle">劃位</td>
<%
	PRreportTool prt3 = new PRreportTool();
	prt3.getCMPDItemdsc("E02") ;
	ArrayList prt3AL = prt3.getObjAL();
	split_idx = 1;
%>
	<td width="90%" align="left">
	    <table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr>
		<td width="25%"><input name="E02_yn" id="E02_yn" type="radio" value="Yes" onClick="showspan('E02','1')" checked><span class="txtxred">正常</span></td>
<%
	for(int i=0; i<prt3AL.size(); i++)
	{
		++split_idx;
%>
		<td width="25%"><input name="E02_yn_box" id="E02_yn_box" type="checkbox" value="E02/<%=prt3AL.get(i)%>" onClick="showspan('E02','2')"><%=prt3AL.get(i)%></td>
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
		<span style="display:none " id="E02_span" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td colspan="4">
		Note : <input type="text" size="50" maxlength="2000" name="E02_note" id="E02_note">
		</td></tr>		
		</table>
		</span>
	</td>
  </tr>
  <tr class="txtblue">
    <td width="15%" align="center" valign="middle">客艙行李</td>
<%
	PRreportTool prt4 = new PRreportTool();
	prt4.getCMPDItemdsc("E01") ;
	ArrayList prt4AL = prt4.getObjAL();
	split_idx = 1;
%>
	<td width="90%" align="left">
	    <table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr>
		<td width="25%"><input name="E01_yn" id="E01_yn" type="radio" value="Yes" onClick="showspan('E01','1')" checked><span class="txtxred">正常</span></td>
<%
	for(int i=0; i<prt4AL.size(); i++)
	{
		++split_idx;
%>
		<td width="25%"><input name="E01_yn_box" id="E01_yn_box" type="checkbox" value="E01/<%=prt4AL.get(i)%>" onClick="showspan('E01','2')"><%=prt4AL.get(i)%></td>
<%
	    if(split_idx%4==0)
		{
			out.println("</tr><tr>");
		}
	}	
%>
		</tr>
		</table>
		<span style="display:none " id="E01_span" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td colspan="4">
		Note : <input type="text" size="50" maxlength="2000" name="E01_note" id="E01_note">
		</td></tr>		
		</table>
		</span>
	</td>
  </tr>
  <tr bgcolor="#DFDFDF"  class="txtblue">
    <td width="15%" align="center" valign="middle">表格</td>
<%
	PRreportTool prt5 = new PRreportTool();
	prt5.getCMPDItemdsc("E03") ;
	ArrayList prt5AL = prt5.getObjAL();
	split_idx = 1;
%>
	<td width="90%" align="left">
	    <table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr>
		<td width="25%"><input name="E03_yn" id="E03_yn" type="radio" value="Yes" onClick="showspan('E03','1')" checked><span class="txtxred">正常</span></td>
<%
	for(int i=0; i<prt5AL.size(); i++)
	{
		++split_idx;
%>
		<td width="25%"><input name="E03_yn_box" id="E03_yn_box" type="checkbox" value="E03/<%=prt5AL.get(i)%>" onClick="showspan('E03','2')"><%=prt5AL.get(i)%></td>
<%
	    if(split_idx%4==0)
		{
			out.println("</tr><tr>");
		}
	}	
%>
		</tr>
		</table>
		<span style="display:none " id="E03_span" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td colspan="4">
		Note : <input type="text" size="50" maxlength="2000" name="E03_note" id="E03_note">
		</td></tr>
		</table>
		</span>
	</td>
  </tr>
  <tr class="txtblue">
    <td width="15%" align="center" valign="middle">場站資訊</td>
<%
	PRreportTool prt6 = new PRreportTool();
	prt6.getCMPDItemdsc("H04") ;
	ArrayList prt6AL = prt6.getObjAL();
	split_idx = 1;
%>
	<td width="90%" align="left">
	    <table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr>
		<td width="25%"><input name="H04_yn" id="H04_yn" type="radio" value="Yes" onClick="showspan('H04','1')" checked><span class="txtxred">正常</span></td>
<%
	for(int i=0; i<prt6AL.size(); i++)
	{
		++split_idx;
%>
		<td width="25%"><input name="H04_yn_box" id="H04_yn_box" type="checkbox" value="H04/<%=prt6AL.get(i)%>" onClick="showspan('H04','2')"><%=prt6AL.get(i)%></td>
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
		<span style="display:none " id="H04_span" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td colspan="4">
		Note : <input type="text" size="50" maxlength="2000" name="H04_note" id="H04_note">
		</td></tr>
		</table>
		</span>
	</td>
  </tr>
  <tr bgcolor="#DFDFDF"  class="txtblue">
    <td width="15%" align="center" valign="middle">服務流程</td>
<%
	PRreportTool prt7 = new PRreportTool();
	prt7.getCMPDItemdsc("H03") ;
	ArrayList prt7AL = prt7.getObjAL();
	split_idx = 1;
%>
	<td width="90%" align="left">
	    <table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr>
		<td width="25%"><input name="H03_yn" id="H03_yn" type="radio" value="Yes" onClick="showspan('H03','1')" checked><span class="txtxred">正常</span></td>
<%
	for(int i=0; i<prt7AL.size(); i++)
	{
		++split_idx;
%>
		<td width="25%"><input name="H03_yn_box" id="H03_yn_box" type="checkbox" value="H03/<%=prt7AL.get(i)%>" onClick="showspan('H03','2')"><%=prt7AL.get(i)%></td>
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
		<span style="display:none " id="H03_span" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td colspan="4">
		Note : <input type="text" size="50" maxlength="2000" name="H03_note" id="H03_note">
		</td></tr>		
		</table>
		</span>
	</td>
  </tr>
 </table>
</fieldset>
<br>
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