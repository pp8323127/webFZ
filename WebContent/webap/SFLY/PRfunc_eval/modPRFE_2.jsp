<%@page import="ws.prac.SFLY.MP.MemofbkObj"%>
<%@page import="ws.prac.SFLY.MP.MPEvalObj"%>
<%@page import="ws.prac.SFLY.MP.MPEvalObj2"%>
<%@page import="ws.prac.SFLY.MP.MPsflyEvaItemObj"%>
<%@page import="ws.prac.SFLY.MP.MPsflySugObj"%>
<%@page import="ws.prac.SFLY.MP.MPsflyCatObj"%>
<%@page import="ws.prac.SFLY.MP.MPsflyRptFun"%>
<%@page import="ws.prac.SFLY.MP.SaveReportMpFileObj"%>
<%@page import="java.io.File"%>
<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*,java.util.*,ci.db.*,java.util.ArrayList,java.net.URLEncoder,eg.prfe.*" %>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("../logout.jsp");
}
if("643937".equals(userid)){
	userid = "631451";
}
String sernno	= request.getParameter("sernno");
String syy = request.getParameter("syy");
String smm = request.getParameter("smm");
String sdd = request.getParameter("sdd");
String eyy = request.getParameter("eyy");
String emm = request.getParameter("emm");
String edd = request.getParameter("edd");

String sdate = request.getParameter("sdate");
String edate = request.getParameter("edate");


String sysdate    = null;
String allFltno   = null;
String fdate      = null;
String purserName = null;
String inspector  = null;
String inspectorid  = null;
String fdate_y    = null;
String fdate_m    = null;
String fdate_d    = null;
String score	  = "0.00";
String fleet      = null;
String acno      = null;
String trip		=null;

String fileType = "";
int maxFileNum = 5;
int count = 0;
int countCi = 0;   
Connection conn   = null;

 PRFuncEval prfe = new PRFuncEval();
 prfe.getPRFuncEval_2(sernno);
 ArrayList objAL = prfe.getObjAL();	
 ArrayList memoAL = prfe.getObjAL();
 ArrayList sugAL = prfe.getObjAL();
//out.println(prfe.getReturnStr()); 
 if(objAL.size()>1)
 {
	 PRFuncEvalObj obj =(PRFuncEvalObj) objAL.get(1);  
	 score = obj.getKpi_score();
	 memoAL = obj.getMemoAL();
	 sugAL = obj.getSugAL();//建議事項
	 
 }
/*----*/

MPsflyRptFun detail = new MPsflyRptFun();
detail.EvaluationItem("", "", "", "");
MPsflyCatObj[] cateArr = detail.sEvaItem.getCateItemAr();//旅客反映選項
MPsflySugObj[] sugArr = detail.sEvaItem.getSugItemArr();//建議事項選項

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

	sql = "select To_Char(SYSDATE, 'mm/dd/yy') AS rundate, fltno,trip, purname, instname, instempno, to_char(fltd,'yyyymmdd') as fltd, to_char(fltd,'yyyy') as fdate_y, to_char(fltd,'mm') as fdate_m, to_char(fltd,'dd') as fdate_d,acno, fleet  from egtstti where sernno = '"+ sernno+ "'";
	//out.println(sql);
	rs = stmt.executeQuery(sql); 
	while(rs.next())
	{
		sysdate = rs.getString("rundate");
		allFltno = rs.getString("fltno");
		fdate = rs.getString("fltd");
		trip = rs.getString("trip");
		purserName = rs.getString("purname");
		inspector = rs.getString("instname");
		inspectorid = rs.getString("instempno");
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
<title>客艙經理職能評量編輯</title>
<link href="../style.css" rel="stylesheet" type="text/css">
<script src="../js/checkDel.js" type="text/javascript"></script>
<script src="../js/CheckAll.js" language="javascript" type="text/javascript"></script>
<script src="../js/subWindow.js" language="javascript" type="text/javascript"></script>
<style type="text/css">
<!--
.style3 {color: #000000}
.style4 {
	font-size: 12px;
	font-weight: bold;
}
-->
</style>
<script language="JavaScript" type="text/JavaScript">
function f_submit()
{	
	document.form1.Submit.disabled=1;
	return true;
}

function getFile(divname,fileName,sernno,type,seq,fdate,fltno,trip,itemno)
{	
	if('' == fileName)
	{
		document.getElementById("div"+divname+"Z").style.display='none';
		document.getElementById("div"+divname+"Y").style.display='';
		//document.getElementById("img"+divname+"B").src="FTP/file/"+divname+".jpg";
		
		if('' == itemno){
			window.open("FTP/getFile_2.jsp?sernno="+sernno+"&type="+type+"&seq="+seq+"&fdate="+fdate+"&fltno="+fltno+"&trip="+trip ,'CaseClose','left=200,top=200,width=600,height=300,scrollbars=yes');	
		}else{
			window.open("FTP/getFile_2.jsp?sernno="+sernno+"&type="+type+"&seq="+seq+"&fdate="+fdate+"&fltno="+fltno+"&trip="+trip+"&itemno="+itemno ,'CaseClose','left=200,top=200,width=600,height=300,scrollbars=yes');
		}
	
		
	}
	else
	{
		flag = confirm("刪除圖片?");
		if (flag == true) 
		{
			document.getElementById("div"+divname+"Y").style.display='none';
			document.getElementById("div"+divname+"Z").style.display='';
			//alert("FTP/delFile_2.jsp?filename="+fileName+"&sernno"+sernno+"&type="+type+"&seq="+seq+"&fdate="+fdate+"&fltno="+fltno+"&trip="+trip );
			if('' == itemno){
				window.open("FTP/delFile_2.jsp?filename="+fileName+"&sernno="+sernno+"&type="+type+"&seq="+seq+"&fdate="+fdate+"&fltno="+fltno+"&trip="+trip ,'CaseClose','left=200,top=200,width=600,height=300,scrollbars=yes');	
			}else{
				window.open("FTP/delFile_2.jsp?filename="+fileName+"&sernno="+sernno+"&type="+type+"&seq="+seq+"&fdate="+fdate+"&fltno="+fltno+"&trip="+trip+"&itemno="+itemno ,'CaseClose','left=200,top=200,width=600,height=300,scrollbars=yes');
			}
			
		}
		else
		{
			return;
		}
	}
	return;
}	
</script>
</head>

<body>
<form name="form1" action="updPRFE_2.jsp"  method ="post" Onsubmit = "return f_submit();">
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
      <div align="center"><span class="txttitletop">客艙經理職能評量表 </span></div>
    </td>
  </tr>
</table>
<table width="90%"  border="1" align="center" cellpadding="1" cellspacing="1" class="fortable"> 
	<tr class="txtblue">
	  	<td width="25%"><div align="left" class="style1">&nbsp;<span class="style3"><strong>Date</strong>:</span><span class="txtred"><%=fdate_y%>&nbsp;</span><span class="style3"><strong>Y</strong></span><span class="txtred">&nbsp;<%=fdate_m%>&nbsp;</span><span class="style3"><strong>M</strong></span><span class="txtred">&nbsp;<%=fdate_d%>&nbsp;</span><span class="style3"><strong>D</strong></span></div>
		</td>
	  	<td width="25%"><span align="left" class="style1">&nbsp;&nbsp;&nbsp;<span class="style3"><strong>Flt</strong>:</span><span class="txtred"><%=allFltno%>&nbsp;&nbsp; <%=fleet%>&nbsp;&nbsp;<%=acno%></span>
		</td>
    	<td width="16%"><div align="left" class="style1">&nbsp;<span class="style3"><strong>Purser</strong>:</span><span class="txtred"><%=purserName%></span></div></td>
    	<td width="17%"><div align="left" class="style1">&nbsp;<span class="style3"><strong>Inspector</strong>:</span><span class="txtred"><%=inspector%></span></div></td>
    	<td width="17%"><div align="left" class="style1">&nbsp;<span class="style3"><strong>Score : </strong></span><span class="txtred"><%=score%></span></div></td>
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
		String eval50str = "";
		String eval75str = "";
		String eval100str = "";
		if("50".equals(obj.getKpi_eval())){eval50str="checked";}
		if("75".equals(obj.getKpi_eval())){eval75str="checked";}
		if("100".equals(obj.getKpi_eval())){eval100str="checked";}
%>
		<td align="left" ><%=obj.getKpidesc()%></td>
		<td align="center" ><input name="<%=obj.getKpino()%>" type="radio" value="50" <%=eval50str%>></td>
		<td align="center" ><input name="<%=obj.getKpino()%>" type="radio" value="75" <%=eval75str%>></td>
		<td align="center" ><input name="<%=obj.getKpino()%>" type="radio" value="100" <%=eval100str%>></td>
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
		<td width="5%" rowspan = "2"><div align="center" class="style1">客<br>艙<br>管<br>理<br>觀<br>察</div></td>		
		
		<td align="center" >內容</td>	
		<td align="center" colspan="<%=maxFileNum%>">圖檔</td>	
	</tr>
	<%
	fileType = "A";
	String tempmemo1 ="";
	for(int k=0; k<memoAL.size(); k++)
	{
		MPEvalObj2 memoobj =(MPEvalObj2) memoAL.get(k);
		if(fileType.equals(memoobj.getMemo_type()))
		{
			tempmemo1 = memoobj.getMemo();
			if(tempmemo1 == null)
			{
				tempmemo1 = "";
			}
		}
			
	}
	 %>
	<tr class="txtblue">
	<td width="35%"><span align="center" class="style1"><div align="left" class="style1">&nbsp;<textarea name="memo1" id="memo1" cols= "40" rows = "10"><%=tempmemo1%></textarea></div></td>
	<%
	PRFuncEval eval = new PRFuncEval();
	eval.getEvalFile(sernno,fileType,"");
	ArrayList fileObjAL = eval.getObjAL();
	SaveReportMpFileObj fileObj = null;
	String fileUrl = "";
	String styleY = "";
	String styleZ = "";
	String fileName= "";
	for(int i=0 ;i<maxFileNum ;i++) {
		fileUrl ="../images/blank.jpg";
		styleY = "";
		styleZ = "style='display:none'";
		if(fileObjAL.size() > 0 && null != fileObjAL){
			if(i<fileObjAL.size()){
				fileObj =  (SaveReportMpFileObj) fileObjAL.get(i);
				if(fileType.equals(fileObj.getType())){
					fileUrl = fileObj.getFileLink();					
					styleY= "style='display:none'";
					styleZ = "";
					fileName = fileObj.getFilename();
				}
			}
		}
		%>
		<td width="10%" class="txtblue">		
		<div align="ceter" name="div<%=sernno%>_<%=fileType%>_<%=i%>Y" id="div<%=sernno%>_<%=fileType%>_<%=i%>Y" <%=styleY%>>
		<a href="#" onClick="getFile('<%=sernno%>_<%=fileType%>_<%=i%>','','<%=sernno%>','<%=fileType%>','<%=i%>','<%=fdate%>','<%=allFltno%>','<%=trip%>','')">附加圖片</a>
		<!-- ;window.open('FTP/getFile_2.jsp?sernno=<%=sernno%>&type=<%=fileType%>&seq=<%=i%>&fdate=<%=fdate%>&fltno=<%=fdate%>&trip=<%=trip%>','CaseClose','left=200,top=200,width=600,height=300,scrollbars=yes'); -->
		</div>
		<div align="ceter" name="div<%=sernno%>_<%=fileType%>_<%=i%>Z" id="div<%=sernno%>_<%=fileType%>_<%=i%>Z" <%=styleZ%>>
			<a href="#" onClick="getFile('<%=sernno%>_<%=fileType%>_<%=i%>','<%=fileName%>','<%=sernno%>','<%=fileType%>','<%=i%>','<%=fdate%>','<%=allFltno%>','<%=trip%>','')">刪除圖片</a>		
			<a href="<%=fileUrl%>"  target="_blank"><img src=<%=fileUrl%> name="img<%=sernno%>_<%=fileType%>_<%=i%>Z" width="100" height="65" border="0" id="img<%=sernno%>_<%=fileType%>_<%=i%>Z"></a>
		</div>
		</td>
	<%	
	}
	%>
	</tr> 
</table>

<table width="90%"  border="1" align="center" cellpadding="1" cellspacing="1" class="fortable"> 
	<tr class="txtblue">
	  	<td width="5%" rowspan = "11" align="center"><div align="center" class="style1">航<br>班<br>事<br>務<br>改<br>善<br>建<br>議</div></td>
		<td align="center" >項目</td>
		<td align="center" >內容</td>	
		<td align="center" colspan="<%=maxFileNum%>">圖檔</td>	
	</tr>
	<%
	for(int i=0;i<sugAL.size();i++){
		MemofbkObj objm = (MemofbkObj) sugAL.get(i);		
	%>
	<tr class="txtblue" valign="top">
		<input type="hidden" name="sugArr" id="sugArr" value="<%=objm.getQuesNo()%>" />
		<td width="5%"><span align="center" class="style1"><%=objm.getQuesDsc()%></span></td>
		<td width="30%"><span align="center" class="style1">&nbsp;<textarea name="memo2" id="memo2" cols= "40" rows = "3"><%=objm.getFeedback()%></textarea></span></td>
		<!-- 圖片 -->
		<%
		fileType = "B";
		eval.getEvalFile(sernno,fileType,objm.getQuesNo()); 
		fileObjAL = eval.getObjAL();
		for(int j=0 ;j<maxFileNum ;j++) {
			fileUrl ="../images/blank.jpg";
			styleY = "";
			styleZ = "style='display:none'";
			
			if(fileObjAL.size()>0 && null != fileObjAL){
				if(j < fileObjAL.size()){
					fileObj =  (SaveReportMpFileObj) fileObjAL.get(j);
					if(fileType.equals(fileObj.getType()) && objm.getQuesNo().equals(fileObj.getSubtype())){
						fileUrl = fileObj.getFileLink();						
						styleY = "style='display:none'";
						styleZ = "";
						fileName = fileObj.getFilename();
					}
				}
			}
		%>
		<td width="10%" class="txtblue">
		<div align="ceter" name="div<%=sernno%>_<%=fileType%>_<%=j%>Y" id="div<%=sernno%>_<%=fileType%>_<%=j%>Y" <%=styleY%>>
	
		<a href="#" onClick="getFile('<%=sernno%>_<%=fileType%>_<%=j%>','','<%=sernno%>','<%=fileType%>','<%=j%>','<%=fdate%>','<%=allFltno%>','<%=trip%>','<%=objm.getQuesNo()%>')">附加圖片</a>
		<!--<a href="#" onClick="getFile('<%=sernno%>_<%=fileType%>_<%=j%>');
		  window.open('FTP/getFile_2.jsp?sernno=<%=sernno%>&type=<%=fileType%>&seq=<%=j%>&fdate=<%=fdate%>&fltno=<%=allFltno%>&trip=<%=trip%>&itemno=<%=objm.getQuesNo()%>','CaseClose','left=200,top=200,width=600,height=300,scrollbars=yes');">附加圖片</a>-->
		</div>
		<div align="ceter" name="div<%=sernno%>_<%=fileType%>_<%=j%>Z" id="div<%=sernno%>_<%=fileType%>_<%=j%>Z" <%=styleZ%>>
		  <a href="#" onClick="getFile('<%=sernno%>_<%=fileType%>_<%=j%>','<%=fileName%>','<%=sernno%>','<%=fileType%>','<%=j%>','<%=fdate%>','<%=allFltno%>','<%=trip%>','<%=objm.getQuesNo()%>')">刪除圖片</a>		
		  <a href="<%=fileUrl%>" target="_blank"><img src="<%=fileUrl%>" name="img<%=sernno%>_<%=fileType%>_<%=j%>Z" width="100" height="65" border="0" id="img<%=sernno%>_<%=fileType%>_<%=j%>Z"></a> </div>
		</td>
	<%
		}
	%>
  	</tr>
	<%
	} 
	%> 	
</table>

<table width="90%"  border="1" align="center" cellpadding="1" cellspacing="1" class="fortable"> 
	<tr class="txtblue">
	  	<td width="5%" rowspan = "11" align="center" >旅<br>客<br>反<br>映</div></td>
	  	<td align="center" >航段</td>
		<td align="center" >座位號碼/艙等</td>
		<td align="center" >旅客姓名</td>	
		<td align="center">卡號</td>
		<td align="center" >事項分類/反映事項</td>
  	</tr> 
	<%
	fileType = "C";
	int countC = 1;
	for(int i=0; i<memoAL.size(); i++)	
	{
		MPEvalObj2 obj2 = (MPEvalObj2) memoAL.get(i); 
		if(fileType.equals(obj2.getMemo_type())){
			String ifcust_type0 ="checked";
			String ifcust_type1 ="";
			String ifcust_type2 ="";
			String ifcust_type3 ="";	
			String ifcust_type4 ="";
			String ifcust_type5 ="";
			if(!"".equals(obj2.getCust_type()) && obj2.getCust_type() != null )
			{
				if(obj2.getCust_type().indexOf("EMER") >= 0 )
				{
					ifcust_type1 = "checked";
					ifcust_type0 = "";
				}
				if(obj2.getCust_type().indexOf("PARA") >= 0 )
				{
					ifcust_type2 = "checked";
					ifcust_type0 = "";
				}
				if(obj2.getCust_type().indexOf("GOLD") >= 0 )
				{
					ifcust_type3 = "checked";
					ifcust_type0 = "";
				}
				if(obj2.getCust_type().indexOf("DYNA") >= 0 )
				{
					ifcust_type4 = "checked";
					ifcust_type0 = "";
				}
				if(obj2.getCust_type().indexOf("MVC") >= 0 )
				{
					ifcust_type5 = "checked";
					ifcust_type0 = "";
				}
			}
	%>
	<tr class="txtblue" valign="top">
	  	<td align="center" >
		<input name="sect" id="sect<%=countC%>" type="text" size="6" maxlength="6" onkeyup= "javascript:this.value=this.value.toUpperCase();" value="<%=obj2.getSect()%>">
		</td>
		<td align="left" ><input name="seatno" id="seatno<%=countC%>" type="text" size="3" maxlength="3" onkeyup= "javascript:this.value=this.value.toUpperCase();"  value="<%=obj2.getSeatno()%>">
		/<select name="seat_class" id="seat_class<%=countC%>" >
			<option value="F" <%=(("F".equals(obj2.getSeat_class()))?"selected='selected'":"")%> >F</option>
			<option value="C" <%=(("C".equals(obj2.getSeat_class()))?"selected='selected'":"")%>>C</option>
			<option value="W" <%=(("W".equals(obj2.getSeat_class()))?"selected='selected'":"")%>>W</option>
			<option value="Y" <%=(("Y".equals(obj2.getSeat_class()))?"selected='selected'":"")%>>Y</option>
			<option value="U/D" <%=(("U/D".equals(obj2.getSeat_class()))?"selected='selected'":"")%>>U/D</option>
		</select>
		</td>
		<td align="left" ><input name="cusname" id="cusname<%=countC%>" type="text" size="10" maxlength="20"  value="<%=obj2.getCust_name()%>"></td>		
		<td align="left"><input name="cardno" id="cardno<%=countC%>" type="text" size="10" maxlength="10"  value="<%=obj2.getCardNo()%>"><br>
		<input type="checkbox" name="cust_type"  id="cust_type<%=countC%>" value=""  <%=ifcust_type0%>>None<br>
		<input type="checkbox" name="cust_type"  id="cust_type<%=countC%>" value="EMER" <%=ifcust_type1%>>EMER<br>
		<input type="checkbox" name="cust_type"  id="cust_type<%=countC%>" value="PARA" <%=ifcust_type2%>>PARA<br>
		<input type="checkbox" name="cust_type"  id="cust_type<%=countC%>" value="GOLD" <%=ifcust_type3%>>GOLD<br>
		<input type="checkbox" name="cust_type"  id="cust_type<%=countC%>" value="DYNA" <%=ifcust_type4%>>DYNA<br>
		<input type="checkbox" name="cust_type"  id="cust_type<%=countC%>" value="MVC" <%=ifcust_type5%>>MVC
		</td>
		<td align="left">
		<input type="hidden" name="seqno" id="seqno" value=<%=obj2.getSeqno()%>>
		<a href="#" onClick="subwinXY('mdCusReply.jsp?sernno=<%=sernno%>&seqno=<%=obj2.getSeqno()%>','edit','600','600');"><img src="../images/list.gif" width="22" height="22" border="0" alt="Detail"></a>
		</td>
  	</tr> 
<%
		countC++;
		}//if("C".equals(obj2.getMemo_type()))
	}		
	int endCount = 0;
	for(int i=countC; i<11; i++){
		endCount++;
	%>
	<tr class="txtblue" valign="top">
	  	<td align="center" >
		<input name="sect" id="sect<%=i%>" type="text" value=""  size="6" maxlength="6" onkeyup= "javascript:this.value=this.value.toUpperCase();">
		</td>
		<td align="left" ><input name="seatno" id="seatno<%=i%>" type="text" value=""  size="3" maxlength="3" onkeyup= "javascript:this.value=this.value.toUpperCase();">
		<select name="seat_class" id="seat_class<%=i%>" >
			<option value="F">F</option>
			<option value="C">C</option>
			<option value="W">W</option>
			<option value="Y">Y</option>
			<option value="U/D">U/D</option>
		</select>
		</td>
		<td align="left" ><input name="cusname" id="cusname<%=i%>" type="text" value=""  size="10" maxlength="20"></td>		
		<td align="left"><input name="cardno" id="cardno<%=i%>" type="text" value=""  size="10" maxlength="10"><br>
		<input type="checkbox" name="cust_type"  id="cust_type<%=i%>" value="" checked="checked">None<br>
		<input type="checkbox" name="cust_type"  id="cust_type<%=i%>" value="EMER">EMER<br>
		<input type="checkbox" name="cust_type"  id="cust_type<%=i%>" value="PARA">PARA<br>
		<input type="checkbox" name="cust_type"  id="cust_type<%=i%>" value="GOLD">GOLD<br>
		<input type="checkbox" name="cust_type"  id="cust_type<%=i%>" value="DYNA">DYNA<br>
		<input type="checkbox" name="cust_type"  id="cust_type<%=i%>" value="MVC">MVC
		</td>
		<td align="left">
		
		<input type="hidden" name="seqno" id="seqno" value=<%=memoAL.size()+endCount%>>
		<a href="#" onClick="subwinXY('mdCusReply.jsp?sernno=<%=sernno%>&seqno=<%=memoAL.size()+endCount%>','edit','600','600');"><img src="../images/list.gif" width="22" height="22" border="0" alt="Detail"></a>
		</td>
  	</tr> 
<%
	}//for(int i=1; i<11; i++)			
%>
</table>
<%
String ifallowupdate = "disabled";
if(userid.equals(inspectorid))
{
	ifallowupdate = "";
}
%>
<table width="90%"  border="0" align="center"> 
	<tr><td align= "center"><br><input name="Submit" type="Submit" value=" SUBMIT " <%=ifallowupdate%>></td></tr>
</table>
</form>
</body>
</html>

<%

session.setAttribute("cateArr", cateArr);
session.setAttribute("objAL", objAL);
%>
