<%@page import="ws.prac.SFLY.MP.MemofbkObj"%>
<%@page import="ws.prac.SFLY.MP.SaveReportMpFileObj"%>
<%@page import="ws.prac.SFLY.MP.MPEvalObj2"%>
<%@page import="fz.psfly.PREval"%>
<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*,java.util.*,ci.db.*,tool.ReplaceAll,java.util.ArrayList,java.net.URLEncoder,eg.prfe.*" %>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) 
{		
	response.sendRedirect("../logout.jsp");
}

String sernno	= request.getParameter("sernno");
String sysdate    = null;
String allFltno   = null;
String fdate      = null;
String purserName = null;
String inspector  = null;
String fdate_y    = null;
String fdate_m    = null;
String fdate_d    = null;
String score	  = "0.00";
String fleet      = null;
String acno      = null;
String trip		=null;

String live = "http://cabincrew.china-airlines.com/prpt/";
//String test = "http://cabincrew.china-airlines.com/prptt/";
String url = live;
String saveDirectory = url + "/MP/"; 
//application.getRealPath("/")+"/SFLY/PRfunc_eval/FTP/file/";

StringBuffer sb = new StringBuffer();
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
ArrayList cusAL = prfe.getObjAL();

if(objAL.size()>1)
{
	PRFuncEvalObj obj =(PRFuncEvalObj) objAL.get(1);  
	score = obj.getKpi_score();
	memoAL = obj.getMemoAL();
	sugAL = obj.getSugAL();//建議事項
}

PREval prfe2 = new PREval();
prfe2.getPRFuncEvalCus(sernno, "");
cusAL = prfe2.getObjAL();//旅客反映

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

	sql = "select To_Char(SYSDATE, 'mm/dd/yy') AS rundate, fltno, purname, instname, to_char(fltd,'yyyymmdd') as fltd, to_char(fltd,'yyyy') as fdate_y, to_char(fltd,'mm') as fdate_m, to_char(fltd,'dd') as fdate_d,acno, fleet from egtstti where sernno = '"+ sernno+ "'";
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
<title>客艙經理職能評量編輯</title>
<style type="text/css">
<!--
.style3 {color: #000000}
.txtblue {
	font-size: 12px;
	line-height: 13.5pt;
	color: #464883;
	font-family:  "Verdana";
}
.txtred {
	font-size: 12px;
	line-height: 13.5pt;
	color: red;
	font-family:  "Verdana";
}
.fortable{
	border: 1pt solid;
 }
 .table_border2{	border: 1pt solid; border-collapse:collapse  }

.tablehead3 {
	font-family: "Arial", "Helvetica", "sans-serif";
	background-color: #006699;
	font-size: 10pt;
	text-align: center;
	font-style: normal;
	font-weight: normal;
	color: #FFFFFF;	
}
}
.style6 {font-size: 12px; font-weight: bold; }
-->
</style>
</head>
<%
sb.append("<html>"+"\r\n");	
sb.append("<head>"+"\r\n");	
sb.append("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=big5\">"+"\r\n");	
sb.append("<title>客艙經理職能評量編輯</title>"+"\r\n");	
sb.append("<style type=\"text/css\">"+"\r\n");	
sb.append("<!--"+"\r\n");	
sb.append(".style3 {color: #000000}"+"\r\n");	
sb.append(".style6 {"+"\r\n");	
sb.append("	font-size: 12px;"+"\r\n");	
sb.append("	font-weight: bold;"+"\r\n");	
sb.append(".txttitletop {"+"\r\n");	
sb.append("font-family:Verdana, Arial, Helvetica, sans-serif;"+"\r\n");	
sb.append("font-size: 16px;"+"\r\n");	
sb.append("	line-height: 22px;"+"\r\n");	
sb.append("	color: #464883;"+"\r\n");	
sb.append("	font-weight: bold;"+"\r\n");	
sb.append("}"+"\r\n");	
sb.append(".txtblue {"+"\r\n");	
sb.append("	font-size: 12px;"+"\r\n");	
sb.append("	line-height: 13.5pt;"+"\r\n");	
sb.append("	color: #464883;"+"\r\n");	
sb.append("	font-family:  \"Verdana\";"+"\r\n");	
sb.append("}"+"\r\n");	
sb.append(".txtred {"+"\r\n");	
sb.append("	font-size: 12px;"+"\r\n");	
sb.append("	line-height: 13.5pt;"+"\r\n");	
sb.append("	color: red;"+"\r\n");	
sb.append("	font-family:  \"Verdana\";"+"\r\n");	
sb.append("}"+"\r\n");	
sb.append(".fortable{"+"\r\n");	
sb.append("	border: 1pt solid;"+"\r\n");	
sb.append(" }"+"\r\n");	
sb.append(" .table_border2{	border: 1pt solid; border-collapse:collapse  }"+"\r\n");	
sb.append(".tablehead3 {"+"\r\n");	
sb.append("	font-family: \"Arial\", \"Helvetica\", \"sans-serif\";"+"\r\n");	
sb.append("	background-color: #006699;"+"\r\n");	
sb.append("	font-size: 10pt;"+"\r\n");	
sb.append("	text-align: center;"+"\r\n");	
sb.append("	font-style: normal;"+"\r\n");	
sb.append("	font-weight: normal;"+"\r\n");	
sb.append("	color: #FFFFFF;	"+"\r\n");	
sb.append("}"+"\r\n");	
sb.append("}"+"\r\n");	
sb.append("-->"+"\r\n");	
sb.append("</style>"+"\r\n");	
sb.append("</head>"+"\r\n");	
%>

<body>
<table width="95%"  border="0" align="center" cellpadding="2" cellspacing="0">
  <tr>
    <td width="60%">
      <div align="right"><span class="txttitletop">客艙經理職能評量表 </span></div>
    </td>
	<td><div align="right"><a href="javascript:window.print()"><img src="../images/print.gif" width="17" height="15" border="0" alt="列印"></a>&nbsp;&nbsp;<input type="button" name="rep" id="rep" value="Download File" onClick="downreport();"></div></td>
  </tr>
</table>
<%

sb.append("<body>"+"\r\n");	
sb.append("<table width=\"95%\"  border=\"0\" align=\"center\" cellpadding=\"2\" cellspacing=\"0\">"+"\r\n");	
sb.append("<tr>"+"\r\n");	
sb.append("<td width=\"60%\">"+"\r\n");	
sb.append("<div align=\"center\"><span class=\"txttitletop\">客艙經理職能評量表 </span></div>"+"\r\n");	
sb.append("</td>"+"\r\n");	
sb.append("</tr>"+"\r\n");	
sb.append("</table>"+"\r\n");	
%>
<table width="95%"  border="1" align="center" cellpadding="1" cellspacing="1" class="fortable"> 
	<tr class="txtblue">
	  	<td width="25%"><div align="left" class="style1">&nbsp;<span class="style3"><strong>Date</strong>:</span><span class="txtred"><%=fdate_y%>&nbsp;</span><span class="style3"><strong>Y</strong></span><span class="txtred">&nbsp;<%=fdate_m%>&nbsp;</span><span class="style3"><strong>M</strong></span><span class="txtred">&nbsp;<%=fdate_d%>&nbsp;</span><span class="style3"><strong>D</strong></span></div>
		</td>
	  	<td width="25%"><span align="left" class="style1">&nbsp;&nbsp;&nbsp;<span class="style3"><strong>Flt</strong>:</span><span class="txtred"><%=allFltno%>&nbsp;&nbsp; <%=fleet%>&nbsp;&nbsp;<%=acno%></span>
		</td>
    	<td width="16%"><div align="left" class="style1">&nbsp;<span class="style3"><strong>CMr</strong>:</span><span class="txtred"><%=purserName%></span></div></td>
    	<td width="17%"><div align="left" class="style1">&nbsp;<span class="style3"><strong>Inspector</strong>:</span><span class="txtred"><%=inspector%></span></div></td>
    	<td width="17%"><div align="left" class="style1">&nbsp;<span class="style3"><strong>Score : </strong></span><span class="txtred"><%=score%></span></div></td>
  	</tr> 
</table>

<%
sb.append("<table width=\"95%\"  border=\"1\" align=\"center\" cellpadding=\"1\" cellspacing=\"1\" class=\"fortable\"> "+"\r\n");	
sb.append("	<tr class=\"txtblue\">"+"\r\n");	
sb.append("<td width=\"25%\"><div align=\"left\" class=\"style1\">&nbsp;<span class=\"style3\"><strong>Date</strong>:</span><span class=\"txtred\">"+fdate_y+"&nbsp;</span><span class=\"style3\"><strong>Y</strong></span><span class=\"txtred\">&nbsp;"+fdate_m+"&nbsp;</span><span class=\"style3\"><strong>M</strong></span><span class=\"txtred\">&nbsp;"+fdate_d+"&nbsp;</span><span class=\"style3\"><strong>D</strong></span></div>"+"\r\n");	
sb.append("		</td>"+"\r\n");	
sb.append("	  	<td width=\"25%\"><span align=\"left\" class=\"style1\">&nbsp;&nbsp;&nbsp;<span class=\"style3\"><strong>Flt</strong>:</span><span class=\"txtred\">"+allFltno+"&nbsp;&nbsp; "+fleet+"&nbsp;&nbsp;"+acno+" </span>"+"\r\n");	
sb.append("		</td>"+"\r\n");	
sb.append("    	<td width=\"16%\"><div align=\"left\" class=\"style1\">&nbsp;<span class=\"style3\"><strong>CM</strong>:</span><span class=\"txtred\">"+purserName+"</span></div></td>"+"\r\n");	
sb.append("    	<td width=\"17%\"><div align=\"left\" class=\"style1\">&nbsp;<span class=\"style3\"><strong>Inspector</strong>:</span><span class=\"txtred\">"+inspector+"</span></div></td>"+"\r\n");	
sb.append("    	<td width=\"17%\"><div align=\"left\" class=\"style1\">&nbsp;<span class=\"style3\"><strong>Score : </strong></span><span class=\"txtred\">"+score+"</span></div></td>"+"\r\n");	
sb.append("  	</tr> "+"\r\n");	
sb.append("</table>"+"\r\n");	
%>

<table width="95%" border="1" align="center" cellpadding="1" cellspacing="1" class="fortable">
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
sb.append("<table width=\"95%\" border=\"1\" align=\"center\" cellpadding=\"1\" cellspacing=\"1\" class=\"fortable\">"+"\r\n");	
sb.append("<tr class=\"tablehead3\">"+"\r\n");	
sb.append("   	   <td align=\"center\" valign=\"middle\"  rowspan= \"2\">&nbsp;</td>"+"\r\n");	
sb.append("   	   <td align=\"center\" valign=\"middle\"  rowspan= \"2\"><strong>評估項目</strong></td>"+"\r\n");	
sb.append("<td align=\"center\" valign=\"middle\"  rowspan= \"2\"><strong>子標</strong></td>"+"\r\n");	
sb.append("       <td align=\"center\" valign=\"middle\"  rowspan= \"2\"><strong>指標KPI</strong></td>"+"\r\n");	
sb.append("   	   <td align=\"center\" valign=\"middle\"  colspan=\"3\"><strong>評分</strong></td>"+"\r\n");	
sb.append("    </tr>"+"\r\n");	
sb.append("	 <tr class=\"tablehead3\">"+"\r\n");	
sb.append("       <td align=\"center\" valign=\"middle\"><strong>NDIP</strong></td>"+"\r\n");	
sb.append("       <td align=\"center\" valign=\"middle\"><strong>AVRG</strong></td>"+"\r\n");	
sb.append("       <td align=\"center\" valign=\"middle\"><strong>GOOD</strong></td>"+"\r\n");	
sb.append("  	</tr>"+"\r\n");	
%>
  	<%
	int mi_seq = 1;
	for(int j=1;j<objAL.size();j++)
	{		
		PRFuncEvalObj objp =(PRFuncEvalObj) objAL.get(j-1);        
		PRFuncEvalObj obj =(PRFuncEvalObj) objAL.get(j);  
    %>
  	<tr class="txtblue">
<%
sb.append("<tr class=\"txtblue\">"+"\r\n");	

		if(!objp.getMitemno().equals(obj.getMitemno()))
		{//評估項目不同
%>
			<td align="left" ><span class="style6"><%=mi_seq%>.</span></td>
			<td align="center" ><span class="style6"><%=obj.getMitemdesc()%></span></td>
<%
sb.append("<td align=\"left\" ><span class=\"style6\">"+mi_seq+".</span></td>"+"\r\n");	
sb.append("<td align=\"center\" ><span class=\"style6\">"+obj.getMitemdesc()+"</span></td>"+"\r\n");

			mi_seq++;
	    }
		else
		{
%>
			<td align="center" >&nbsp;</td>
			<td align="center" >&nbsp;</td>
<%
sb.append("<td align=\"center\" >&nbsp;</td>"+"\r\n");	
sb.append("<td align=\"center\" >&nbsp;</td>"+"\r\n");		
%>
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
sb.append("<td align=\"left\" >"+obj.getSitemdesc()+"("+obj.getGrade_percentage()+"%)</td>"+"\r\n");	
%>
<%
	    }
		else
		{
%>
			<td align="center" >&nbsp;</td>
<%
sb.append("<td align=\"center\" >&nbsp;</td>"+"\r\n");		
%>
<%
		}
%>

<%
		//********************************************************
		String eval50str = "";
		String eval75str = "";
		String eval100str = "";
		if("50".equals(obj.getKpi_eval())){eval50str="<img src='../images/check.gif' width='17' height='15' border='0' >";}
		if("75".equals(obj.getKpi_eval())){eval75str="<img src='../images/check.gif' width='17' height='15' border='0' >";}
		if("100".equals(obj.getKpi_eval())){eval100str="<img src='../images/check.gif' width='17' height='15' border='0' >";}

		String eval50str2 = "";
		String eval75str2 = "";
		String eval100str2 = "";
		if("50".equals(obj.getKpi_eval())){eval50str2="<span>V</span>";}
		if("75".equals(obj.getKpi_eval())){eval75str2="<span>V</span>";}
		if("100".equals(obj.getKpi_eval())){eval100str2="<span>V</span>";}

%>
		<td align="left" ><%=obj.getKpidesc()%></td>
		<td align="center" >&nbsp;<%=eval50str%></td>
		<td align="center" >&nbsp;<%=eval75str%></td>
		<td align="center" >&nbsp;<%=eval100str%></td>
<%
sb.append("<td align=\"left\">"+obj.getKpidesc()+"</td>"+"\r\n");	
sb.append("<td align=\"center\" class=\"txtred\">&nbsp;"+eval50str2+"</td>"+"\r\n");	
sb.append("<td align=\"center\" class=\"txtred\">&nbsp;"+eval75str2+"</td>"+"\r\n");	
sb.append("<td align=\"center\" class=\"txtred\">&nbsp;"+eval100str2+"</td>"+"\r\n");	
		//********************************************************
%>
   	</tr>
<%
sb.append("</tr>"+"\r\n");		
%>
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
sb.append("</table>"+"\r\n");	
sb.append("<table width=\"95%\"  border=\"1\" align=\"center\" cellpadding=\"1\" cellspacing=\"1\" class=\"fortable\">"+"\r\n");	
sb.append("	<tr class=\"txtblue\">"+"\r\n");	
sb.append("	  	<td width=\"5%\" rowspan = \"2\"><div align=\"center\" class=\"style1\">客<br>艙<br>管<br>理<br>觀<br>察</div></td>"+"\r\n");	
sb.append("		<td align=\"center\" >內容</td>"+"\r\n");	
sb.append("		<td align=\"center\" colspan=\"maxFileNum\">圖檔</td>"+"\r\n");	
%>
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
sb.append("<tr class=\"txtblue\">");
sb.append("	  	<td width=\"95%\" align=\"left\" valign=\"top\" class=\"style1\">&nbsp;"+tempmemo1.replaceAll("\r\n","<br>")+"</td>"+"\r\n");	

	prfe2.getEvalFile(sernno,fileType,"");
	ArrayList fileObjAL = prfe2.getObjAL();
	SaveReportMpFileObj fileObj = null;
	String fileUrl = "";

	for(int i=0 ;i<maxFileNum ;i++) {
		fileUrl ="../images/blank.jpg";
		if(fileObjAL.size() > 0 && null != fileObjAL){
			if(i<fileObjAL.size()){
				fileObj =  (SaveReportMpFileObj) fileObjAL.get(i);
				if(fileType.equals(fileObj.getType())){
					fileUrl = fileObj.getFileLink();
				}
			}
		}
		%>
		<td width="10%" class="txtblue">		
		<div align="ceter" name="div<%=sernno%>_<%=fileType%>_<%=i%>Z" id="div<%=sernno%>_<%=fileType%>_<%=i%>Z">
			<a href="<%=fileUrl%>"  target="_blank"><img src=<%=fileUrl%> name="img<%=sernno%>_<%=fileType%>_<%=i%>Z" width="100" height="65" border="0" id="img<%=sernno%>_<%=fileType%>_<%=i%>Z"></a> </div>
		</td>
	<%	

sb.append("<td width=\"10%\" align=\"ceter\">"+"\r\n");	
sb.append("<img src=\""+fileUrl+"\" width=\"100\" height=\"65\" border=\"0\">"+"\r\n");	
sb.append("</td>"+"\r\n");	

	}
	%>
	</tr> 
</table>
<%
sb.append("</tr>"+"\r\n");	
sb.append("</table>"+"\r\n");	
%>

<table width="90%"  border="1" align="center" cellpadding="1" cellspacing="1" class="fortable"> 
	<tr class="txtblue">
	  	<td width="5%" rowspan = "11" align="center"><div align="center" class="style1">航<br>班<br>事<br>務<br>改<br>善<br>建<br>議</div></td>
		<td align="center" >項目</td>
		<td align="center" >內容</td>	
		<td align="center" colspan="<%=maxFileNum%>">圖檔</td>	
	</tr>
	<%
sb.append("<table width=\"95%\"  border=\"1\" align=\"center\" cellpadding=\"1\" cellspacing=\"1\" class=\"fortable\"> "+"\r\n");	
sb.append("	<tr class=\"txtblue\">"+"\r\n");	
sb.append("	  	<td width=\"5%\" rowspan = \"11\" align=\"center\"><div align=\"center\" class=\"style1\">航<br>班<br>事<br>務<br>改<br>善<br>建<br>議</div></td>"+"\r\n");	
sb.append("		<td align=\"center\" >項目</td>"+"\r\n");
sb.append("		<td align=\"center\" >內容</td>"+"\r\n");
sb.append("		<td align=\"center\" colspan=\""+maxFileNum+"\">圖檔</td>	"+"\r\n");	
sb.append("</tr>"+"\r\n");	
	for(int i=0;i<sugAL.size();i++){
		MemofbkObj objm = (MemofbkObj) sugAL.get(i);		
	%>
	<tr class="txtblue" valign="top">
		<input type="hidden" name="sugArr" id="sugArr" value="<%=objm.getQuesNo()%>" />
		<td width="5%"><span align="center" class="style1"><%=objm.getQuesDsc()%></span></td>
		<td width="30%"><span align="center" class="style1">&nbsp;<textarea name="memo2" id="memo2" cols= "40" rows = "3"><%=objm.getFeedback()%></textarea></span></td>
		<!-- 圖片 -->
		<%
sb.append("<tr class=\"txtblue\" valign=\"top\">"+"\r\n");	
sb.append("	<td width=\"5%\"><span align=\"center\" class=\"style1\">"+objm.getQuesDsc()+"</span></td>"+"\r\n");	
sb.append("	  	<td width=\"30%\"><span align=\"center\" class=\"style1\">&nbsp;<textarea name=\"memo2\" id=\"memo2\" cols= \"40\" rows = \"3\">"+objm.getFeedback()+"</textarea></span></td>"+"\r\n");	
			
		fileType = "B";
		prfe2.getEvalFile(sernno,fileType,objm.getQuesNo()); 
		fileObjAL = prfe2.getObjAL();
		for(int j=0 ;j<maxFileNum ;j++) {
			fileUrl ="../images/blank.jpg";
			if(fileObjAL.size()>0 && null != fileObjAL){
				if(j < fileObjAL.size()){
					fileObj =  (SaveReportMpFileObj) fileObjAL.get(j);
					if(fileType.equals(fileObj.getType()) && objm.getQuesNo().equals(fileObj.getSubtype())){
						fileUrl = fileObj.getFileLink();
					}
				}
			}
		%>
		<td width="10%" class="txtblue">
		<div align="ceter" name="div<%=sernno%>_<%=fileType%>_<%=j%>Z" id="div<%=sernno%>_<%=fileType%>_<%=j%>Z">
		  <a href="<%=fileUrl%>" target="_blank"><img src="<%=fileUrl%>" name="img<%=sernno%>_<%=fileType%>_<%=j%>Z" width="100" height="65" border="0" id="img<%=sernno%>_<%=fileType%>_<%=j%>Z"></a> </div>
		</td>
	<%
sb.append("<td width=\"10%\" class=\"txtblue\">"+"\r\n");	
sb.append("	<img src=\""+fileUrl+"\" width=\"100\" height=\"65\" border=\"0\">"+"\r\n");	
sb.append("</td>"+"\r\n");	
			
		}
	%>
  	</tr>
	<%
	} 	
	%> 	
</table>
<%
sb.append("</td>"+"\r\n");	
sb.append("</table>"+"\r\n");	
%>


<table width="95%"  border="1" align="center" cellpadding="1" cellspacing="1" class="fortable"> 
	<tr class="txtblue">
	  	<td width="5%" rowspan = "11" align="center" >旅<br>客<br>反<br>映</div></td>
	  	<td align="center" >航段</td>
		<td align="center" >座位號碼</td>
		<td align="center" >艙等</td>
		<td align="center" >旅客姓名</td>
		<td align="center" >卡別</td>
		<td align="center" >反映事項</td>
		<td align="center" >事項分類</td>
		</td>
  	</tr> 
<%
sb.append("<table width=\"95%\"  border=\"1\" align=\"center\" cellpadding=\"1\" cellspacing=\"1\" class=\"fortable\"> "+"\r\n");	
sb.append("	<tr class=\"txtblue\">"+"\r\n");	
sb.append("	  	<td width=\"5%\" rowspan = \"11\" align=\"center\" >旅<br>客<br>反<br>映</div></td>"+"\r\n");	
sb.append("	  	<td align=\"center\" >航段</td>"+"\r\n");	
sb.append("		<td align=\"center\" >座位號碼</td>"+"\r\n");	
sb.append("		<td align=\"center\" >艙等</td>"+"\r\n");	
sb.append("		<td align=\"center\" >旅客姓名</td>"+"\r\n");	
sb.append("		<td align=\"center\" >卡別</td>"+"\r\n");	
sb.append("		<td align=\"center\" >反映事項</td>"+"\r\n");	
sb.append("		<td align=\"center\" >事項分類</td>"+"\r\n");	
sb.append("		</td>"+"\r\n");	
sb.append("  	</tr>"+"\r\n");	
%>
	<%
	int csize = 1;
	for(int k=0; k<memoAL.size(); k++)
	{
		PRFuncEvalObj2 memoobj =(PRFuncEvalObj2) memoAL.get(k);
		if("C".equals(memoobj.getMemo_type()))
		{
		%>
		<tr class="txtblue">
			<td align="center">&nbsp;<%=memoobj.getSect()%></td>
			<td align="center" >&nbsp;<%=memoobj.getSeatno()%></td>
			<td align="center" >&nbsp;<%=memoobj.getSeat_class()%></td>
			<td align="center" >&nbsp;<%=memoobj.getCust_name()%></td>
			<td align="center" >&nbsp;<%=memoobj.getCust_type()%></td>
			<td align="left" >&nbsp;<%=memoobj.getEvent().replaceAll("\r\n","<br>")%></td>
			<td align="center" >&nbsp;<%=memoobj.getEvent_type()%></td>
		</tr> 
		<%
sb.append("		<tr class=\"txtblue\">"+"\r\n");	
sb.append("			<td align=\"center\">"+memoobj.getSect()+"</td>"+"\r\n");	
sb.append("			<td align=\"center\" >"+memoobj.getSeatno()+"</td>"+"\r\n");	
sb.append("			<td align=\"center\" >"+memoobj.getSeat_class()+"</td>"+"\r\n");	
sb.append("			<td align=\"center\" >"+memoobj.getCust_name()+"</td>"+"\r\n");	
sb.append("			<td align=\"center\" >"+memoobj.getCust_type()+"</td>"+"\r\n");	
sb.append("			<td align=\"left\" >"+memoobj.getEvent().replaceAll("\r\n","<br>")+"</td>"+"\r\n");	
sb.append("			<td align=\"center\" >"+memoobj.getEvent_type()+"</td>"+"\r\n");	
sb.append("		</tr> "+"\r\n");	
		%>
		<%			
			csize ++;
		}
	}

	for(int i=csize; i<11; i++)	
	{		
	%>
	<tr class="txtblue">
	  	<td align="center" >&nbsp;</td>
	  	<td align="center" >&nbsp;</td>
	  	<td align="center" >&nbsp;</td>
	  	<td align="center" >&nbsp;</td>
	  	<td align="center" >&nbsp;</td>
	  	<td align="center" >&nbsp;</td>
	  	<td align="center" >&nbsp;</td>
  	</tr> 
<%
sb.append("	<tr class=\"txtblue\">"+"\r\n");
sb.append("	  	<td align=\"center\" >&nbsp;</td>"+"\r\n");
sb.append("	  	<td align=\"center\" >&nbsp;</td>"+"\r\n");
sb.append("	  	<td align=\"center\" >&nbsp;</td>"+"\r\n");
sb.append("	  	<td align=\"center\" >&nbsp;</td>"+"\r\n");
sb.append("	  	<td align=\"center\" >&nbsp;</td>"+"\r\n");
sb.append("	  	<td align=\"center\" >&nbsp;</td>"+"\r\n");
sb.append("	  	<td align=\"center\" >&nbsp;</td>"+"\r\n");
sb.append("  	</tr> "+"\r\n");
%>
<%
	}//for(int i=1; i<6; i++)			
%>
</table>
</form>
</body>
</html>
<script language="javascript" type="text/javascript">
function downreport()
{
	location.replace("viewPRFE_download.jsp");
}
</script>
<%
sb.append("</table>"+"\r\n");
sb.append("</form>"+"\r\n");
sb.append("</body>"+"\r\n");
sb.append("</html>"+"\r\n");
session.setAttribute("sb",sb);
%>