<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="java.io.File"%>
<%@ page import="java.sql.*,tool.ReplaceAll,java.net.URLEncoder,ci.db.ConnDB,eg.prfe.*,ws.prac.SFLY.MP.*" %>
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
String trip	    = request.getParameter("trip");
String syy = request.getParameter("syy");
String smm = request.getParameter("smm");
String sdd = request.getParameter("sdd");
String eyy = request.getParameter("eyy");
String emm = request.getParameter("emm");
String edd = request.getParameter("edd");


boolean hasRecord = false;
String sysdate    = null;
String allFltno   = request.getParameter("fltno");
String fdate      = request.getParameter("fltd");
String purserName = request.getParameter("purName");
String inspector  = request.getParameter("instEmpno");
String fdate_y    = fdate.substring(0,4);
String fdate_m    = fdate.substring(5,7);
String fdate_d    = fdate.substring(8,10);
String fleet      = request.getParameter("fleet");
String acno      = request.getParameter("acno");
String fileType = "";
int maxFileNum = 5;
int count = 0;
int countCi = 0;   

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
	if(document.getElementById("div"+divname+"Y").style.display == '')
	{
		document.getElementById("div"+divname+"Y").style.display='none';
		document.getElementById("div"+divname+"Z").style.display='';
		//document.getElementById("img"+divname+"B").src="FTP/file/"+divname+".jpg";
	}	
	else
	{
		document.getElementById("div"+divname+"Z").style.display='none';
		document.getElementById("div"+divname+"Y").style.display='';
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
<form name="form1" action="insPRFE_2.jsp"  method ="post" Onsubmit = "document.form1.Submit.disabled=1;">
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
     
     MPsflyRptFun detail = new MPsflyRptFun();
     detail.EvaluationItem("", "", "", "");
     MPsflySugObj[] sugArr = detail.sEvaItem.getSugItemArr();
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
		<td width="5%" rowspan = "2"><div align="center" class="style1">客<br>艙<br>管<br>理<br>觀<br>察</div></td>		
		
		<td align="center" >內容</td>	
		<td align="center" colspan="<%=maxFileNum%>">圖檔</td>	
	</tr>
	<tr class="txtblue">
	<td width="35%"><span align="center" class="style1"><div align="left" class="style1">&nbsp;<textarea name="memo1" id="memo1" cols= "40" rows = "10"></textarea></div></td>
	<%fileType = "A";

	prfe.getEvalFile(sernno,fileType,"");
	ArrayList fileObjAL = prfe.getObjAL();
	SaveReportMpFileObj fileObj = null;
	String fileUrl = "";
	String styleY = "";
	String styleZ = "";
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
				}
			}
		}
		%>
		<td width="10%" class="txtblue">		
		<div align="ceter" name="div<%=sernno%>_<%=fileType%>_<%=i%>Y" id="div<%=sernno%>_<%=fileType%>_<%=i%>Y" <%=styleY%>>
		<a href="#" onClick="getFile('<%=sernno%>_<%=fileType%>_<%=i%>');window.open('FTP/getFile_2.jsp?sernno=<%=sernno%>&type=<%=fileType%>&seq=<%=i%>&fdate=<%=fdate%>&fltno=<%=fltno%>&trip=<%=trip%>','CaseClose','left=200,top=200,width=600,height=300,scrollbars=yes');">附加圖片</a>
		</div>
		<div align="ceter" name="div<%=sernno%>_<%=fileType%>_<%=i%>Z" id="div<%=sernno%>_<%=fileType%>_<%=i%>Z" <%=styleZ%>>
			<a href="<%=fileUrl%>"  target="_blank"><img src=<%=fileUrl%> name="img<%=sernno%>_<%=fileType%>_<%=i%>Z" width="110" height="70" border="0" id="img<%=sernno%>_<%=fileType%>_<%=i%>Z"></a> </div>
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
	<%
	for(int i=0;i<sugArr.length;i++){ 		
	%>
	<tr class="txtblue" valign="top">
		<input type="hidden" name="sugArr" id="sugArr" value="<%=sugArr[i].getItemNo()%>" />
		<td width="5%"><span align="center" class="style1"><%=sugArr[i].getItemDsc()%></span></td>
		<td width="30%"><span align="center" class="style1">&nbsp;<textarea name="memo2" id="memo2" cols= "40" rows = "3"></textarea></span></td>
		<!-- 圖片 -->
		<%
		fileType = "B";
		prfe.getEvalFile(sernno,fileType,sugArr[i].getItemNo()); 
		fileObjAL = prfe.getObjAL();
		for(int j=0 ;j<maxFileNum ;j++) {
			fileUrl ="../images/blank.jpg";
			styleY = "";
			styleZ = "style='display:none'";
			if(fileObjAL.size()>0 && null != fileObjAL){
				if(j < fileObjAL.size()){
					fileObj =  (SaveReportMpFileObj) fileObjAL.get(j);
					if(fileType.equals(fileObj.getType()) && sugArr[i].getItemNo().equals(fileObj.getSubtype())){
						fileUrl = fileObj.getFileLink();
						styleY = "style='display:none'";
						styleZ = "";
					}
				}
			}
		%>
		<td width="10%" class="txtblue">
		<div align="ceter" name="div<%=sernno%>_<%=fileType%>_<%=j%>Y" id="div<%=sernno%>_<%=fileType%>_<%=j%>Y" <%=styleY%>>
		<a href="#" onClick="getFile('<%=sernno%>_<%=fileType%>_<%=j%>');window.open('FTP/getFile_2.jsp?sernno=<%=sernno%>&type=<%=fileType%>&seq=<%=j%>&fdate=<%=fdate%>&fltno=<%=fltno%>&trip=<%=trip%>&itemno=<%=sugArr[i].getItemNo()%>','CaseClose','left=200,top=200,width=600,height=300,scrollbars=yes');">附加圖片</a>
		</div>
		<div align="ceter" name="div<%=sernno%>_<%=fileType%>_<%=j%>Z" id="div<%=sernno%>_<%=fileType%>_<%=j%>Z" <%=styleZ%>>
		  <a href="<%=fileUrl%>" target="_blank"><img src="<%=fileUrl%>" name="img<%=sernno%>_<%=fileType%>_<%=j%>Z" width="110" height="70" border="0" id="img<%=sernno%>_<%=fileType%>_<%=j%>Z"></a> </div>
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
	for(int i=1; i<11; i++)	
	{
	%>
	<tr class="txtblue" valign="top">
	  	<td align="center" >
		<input name="sect" id="sect<%=i%>" type="text" value=""  size="6" maxlength="6" onkeyup= "javascript:this.value=this.value.toUpperCase();">

		</td>
		<td align="left" ><input name="seatno" id="seatno<%=i%>" type="text" value=""  size="3" maxlength="3" onkeyup= "javascript:this.value=this.value.toUpperCase();">
		/<select name="seat_class" id="seat_class<%=i%>" >
			<option value="F">F</option>
			<option value="C">C</option>
			<option value="W">W</option>
			<option value="Y">Y</option>
			<option value="U/D">U/D</option>
		</select>
			<!-- 
			<input name="seat_class" id="seat_class<%=i%>" type="radio" value="F" checked>F<br>
			<input name="seat_class" id="seat_class<%=i%>" type="radio" value="C">C<br>
			<input name="seat_class" id="seat_class<%=i%>" type="radio" value="Y">Y<br>
			<input name="seat_class" id="seat_class<%=i%>" type="radio" value="W">W<br>
			<input name="seat_class" id="seat_class<%=i%>" type="radio" value="U/D">U/D
			 -->
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
		<a href="#" onClick="subwinXY('mdCusReply.jsp?sernno=<%=sernno%>&seqno=<%=i%>','edit','600','600');"><img src="../images/list.gif" width="22" height="22" border="0" alt="Detail"></a>
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
