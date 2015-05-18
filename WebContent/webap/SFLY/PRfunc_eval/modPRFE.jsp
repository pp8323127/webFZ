<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*,java.util.*,ci.db.*,tool.ReplaceAll,java.util.ArrayList,java.net.URLEncoder,eg.prfe.*" %>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("../logout.jsp");
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
String saveDirectory = application.getRealPath("/")+"/SFLY/PRfunc_eval/FTP/file/";

int count = 0;
int countCi = 0;   
Connection conn   = null;

 PRFuncEval prfe = new PRFuncEval();
 prfe.getPRFuncEval(sernno);
 ArrayList objAL = prfe.getObjAL();	
 ArrayList memoAL = prfe.getObjAL();	
 if(objAL.size()>1)
 {
	 PRFuncEvalObj obj =(PRFuncEvalObj) objAL.get(1);  
	 score = obj.getKpi_score();
	 memoAL = obj.getMemoAL();
 }

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

	sql = "select To_Char(SYSDATE, 'mm/dd/yy') AS rundate, fltno, purname, instname, instempno, to_char(fltd,'yyyymmdd') as fltd, to_char(fltd,'yyyy') as fdate_y, to_char(fltd,'mm') as fdate_m, to_char(fltd,'dd') as fdate_d,acno, fleet  from egtstti where sernno = '"+ sernno+ "'";
	//out.println(sql);
	rs = stmt.executeQuery(sql); 
	while(rs.next())
	{
		sysdate = rs.getString("rundate");
		allFltno = rs.getString("fltno");
		fdate = rs.getString("fltd");
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
<title>�ȿ��g�z¾����q�s��</title>
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
		flag = confirm("�R���Ϥ�?");
		if (flag == true) 
		{
			document.getElementById("div"+divname+"B").style.display='none';
			document.getElementById("div"+divname+"A").style.display='';
			window.open("FTP/delFile.jsp?filename="+divname,'CaseClose','width=600,height=300,scrollbars=yes')
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
<form name="form1" action="updPRFE.jsp"  method ="post" Onsubmit = "return f_submit();">
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
      <div align="center"><span class="txttitletop">�ȿ��g�z¾����q�� </span></div>
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
   	   <td align="center" valign="middle"  rowspan= "2"><strong>��������</strong></td>
   	   <td align="center" valign="middle"  rowspan= "2"><strong>�l��</strong></td>
       <td align="center" valign="middle"  rowspan= "2"><strong>����KPI</strong></td>
   	   <td align="center" valign="middle"  colspan="3"><strong>����</strong></td>
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
		{//�������ؤ��P
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
		{//�l�Ф��P
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
	  	<td width="5%"><div align="center" class="style1">��<br>��<br>��<br>�z<br>�[<br>��</div>
		</td>
<%
	String tempmemo1 ="";
	String tempmemo2 ="";
	for(int k=0; k<memoAL.size(); k++)
	{
		PRFuncEvalObj2 memoobj =(PRFuncEvalObj2) memoAL.get(k);
		if("A".equals(memoobj.getMemo_type()))
		{
			tempmemo1 = memoobj.getMemo();
			if(tempmemo1 == null)
			{
				tempmemo1 = "";
			}
		}
		if("B".equals(memoobj.getMemo_type()))
		{
			tempmemo2 = memoobj.getMemo();
			if(tempmemo2 == null)
			{
				tempmemo2 = "";
			}
		}		
	}
%>
	  	<td width="95%"><span align="center" class="style1"><div align="left" class="style1">&nbsp;<textarea name="memo1" id="memo1" cols= "80" rows = "10"><%=tempmemo1%></textarea></div></td>
	</tr>
</table>
<table width="90%"  border="1" align="center" cellpadding="1" cellspacing="1" class="fortable"> 
	<tr height="80" align="center" valign="middle">
<%
File f1 = new File(saveDirectory,sernno+"_m1_1.jpg");
boolean b1 = false;
b1 = f1.exists();
String d1 ="";
String d2 ="";
String src1 ="";
if (b1==true)
{
	d1 = "none";
	d2 = "";
	src1 = "FTP/file/"+sernno+"_m1_1.jpg";
}
else
{
	d1 = "";
	d2 = "none";
	src1 = "../images/blank.jpg";
}
%>
			<td width="25%" class="txtblue">
			<div align="ceter" name="div<%=sernno%>_m1_1A" id="div<%=sernno%>_m1_1A" style="display:<%=d1%>"> 
			<a href="#" onClick="getFile('<%=sernno%>_m1_1');window.open('FTP/getFile.jsp?filename=<%=sernno%>_m1_1','CaseClose','left=200,top=200,width=600,height=300,scrollbars=yes');">���[�Ϥ�</a>
			</div>
			<div align="ceter" name="div<%=sernno%>_m1_1B" id="div<%=sernno%>_m1_1B" style="display:<%=d2%>"><a href="#" onClick="getFile('<%=sernno%>_m1_1');"><img id="img<%=sernno%>_m1_1B" src="<%=src1%>" width="130" height="80" border="0"></a>
			</div>
			</td>
<%
f1 = new File(saveDirectory,sernno+"_m1_2.jpg");
b1 = f1.exists();
d1 ="";
d2 ="";
src1 ="";
if (b1==true)
{
	d1 = "none";
	d2 = "";
	src1 = "FTP/file/"+sernno+"_m1_2.jpg";
}
else
{
	d1 = "";
	d2 = "none";
	src1 = "../images/blank.jpg";
}
%>
			<td width="25%" class="txtblue"><div align="ceter" name="div<%=sernno%>_m1_2A" id="div<%=sernno%>_m1_2A" style="display:<%=d1%>"> 
			<a href="#" onClick="getFile('<%=sernno%>_m1_2');window.open('FTP/getFile.jsp?filename=<%=sernno%>_m1_2','CaseClose','left=200,top=200,width=600,height=300,scrollbars=yes');">���[�Ϥ�</a>
			</div>
			<div align="ceter" name="div<%=sernno%>_m1_2B" id="div<%=sernno%>_m1_2B" style="display:<%=d2%>"><a href="#" onClick="getFile('<%=sernno%>_m1_2');"><img id="img<%=sernno%>_m1_2B" src="<%=src1%>" width="130" height="80" border="0"></a>
			</div>
			</td>
<%
f1 = new File(saveDirectory,sernno+"_m1_3.jpg");
b1 = f1.exists();
d1 ="";
d2 ="";
src1 ="";
if (b1==true)
{
	d1 = "none";
	d2 = "";
	src1 = "FTP/file/"+sernno+"_m1_3.jpg";
}
else
{
	d1 = "";
	d2 = "none";
	src1 = "../images/blank.jpg";
}
%>
			<td width="25%" class="txtblue"><div align="ceter" name="div<%=sernno%>_m1_3A" id="div<%=sernno%>_m1_3A" style="display:<%=d1%>"> 
			<a href="#" onClick="getFile('<%=sernno%>_m1_3');window.open('FTP/getFile.jsp?filename=<%=sernno%>_m1_3','CaseClose','left=200,top=200,width=600,height=300,scrollbars=yes');">���[�Ϥ�</a>
			</div>
			<div align="ceter" name="div<%=sernno%>_m1_3B" id="div<%=sernno%>_m1_3B" style="display:<%=d2%>"><a href="#" onClick="getFile('<%=sernno%>_m1_3');"><img id="img<%=sernno%>_m1_3B" src="<%=src1%>" width="130" height="80" border="0"></a>
			</div>
<%
f1 = new File(saveDirectory,sernno+"_m1_4.jpg");
b1 = f1.exists();
d1 ="";
d2 ="";
src1 ="";
if (b1==true)
{
	d1 = "none";
	d2 = "";
	src1 = "FTP/file/"+sernno+"_m1_4.jpg";
}
else
{
	d1 = "";
	d2 = "none";
	src1 = "../images/blank.jpg";
}
%>
			</td>
			<td width="25%" class="txtblue"><div align="ceter" name="div<%=sernno%>_m1_4A" id="div<%=sernno%>_m1_4A" style="display:<%=d1%>"> 
			<a href="#" onClick="getFile('<%=sernno%>_m1_4');window.open('FTP/getFile.jsp?filename=<%=sernno%>_m1_4','CaseClose','left=200,top=200,width=600,height=300,scrollbars=yes');">���[�Ϥ�</a>
			</div>
			<div align="ceter" name="div<%=sernno%>_m1_4B" id="div<%=sernno%>_m1_4B" style="display:<%=d2%>"><a href="#" onClick="getFile('<%=sernno%>_m1_4');"><img id="img<%=sernno%>_m1_4B" src="<%=src1%>" width="130" height="80" border="0"></a>
			</div>
		</td>
	</tr>
</table>
<table width="90%"  border="1" align="center" cellpadding="1" cellspacing="1" class="fortable"> 
	<tr class="txtblue">
	  	<td width="5%"><div align="center" class="style1">��<br>�Z<br>��<br>��<br>��<br>��<br>��<br>ĳ</div>
		</td>
	  	<td width="95%"><span align="center" class="style1"><div align="left" class="style1">&nbsp;<textarea name="memo2" id="memo2" cols= "80" rows = "10"><%=tempmemo2%></textarea></div></td>
</table>
<table width="90%"  border="1" align="center" cellpadding="1" cellspacing="1" class="fortable"> 
	<tr height="80" align="center" valign="middle">
<%
f1 = new File(saveDirectory,sernno+"_m2_1.jpg");
b1 = f1.exists();
d1 ="";
d2 ="";
src1 ="";
if (b1==true)
{
	d1 = "none";
	d2 = "";
	src1 = "FTP/file/"+sernno+"_m2_1.jpg";
}
else
{
	d1 = "";
	d2 = "none";
	src1 = "../images/blank.jpg";
}
%>
		<td width="25%" class="txtblue">
		<div align="ceter" name="div<%=sernno%>_m2_1A" id="div<%=sernno%>_m2_1A" style="display:<%=d1%>"> 
		<a href="#" onClick="getFile('<%=sernno%>_m2_1');window.open('FTP/getFile.jsp?filename=<%=sernno%>_m2_1','CaseClose','left=200,top=200,width=600,height=300,scrollbars=yes');">���[�Ϥ�</a>
		</div>
		<div align="ceter" name="div<%=sernno%>_m2_1B" id="div<%=sernno%>_m2_1B" style="display:<%=d2%>"><a href="#" onClick="getFile('<%=sernno%>_m2_1');"><img id="img<%=sernno%>_m2_1B" src="<%=src1%>" width="130" height="80" border="0"></a>
		</div>
		</td>
<%
f1 = new File(saveDirectory,sernno+"_m2_2.jpg");
b1 = f1.exists();
d1 ="";
d2 ="";
src1 ="";
if (b1==true)
{
	d1 = "none";
	d2 = "";
	src1 = "FTP/file/"+sernno+"_m2_2.jpg";
}
else
{
	d1 = "";
	d2 = "none";
	src1 = "../images/blank.jpg";
}
%>
		<td width="25%" class="txtblue"><div align="ceter" name="div<%=sernno%>_m2_2A" id="div<%=sernno%>_m2_2A" style="display:<%=d1%>"> 
		<a href="#" onClick="getFile('<%=sernno%>_m2_2');window.open('FTP/getFile.jsp?filename=<%=sernno%>_m2_2','CaseClose','left=200,top=200,width=600,height=300,scrollbars=yes');">���[�Ϥ�</a>
		</div>
		<div align="ceter" name="div<%=sernno%>_m2_2B" id="div<%=sernno%>_m2_2B" style="display:<%=d2%>"><a href="#" onClick="getFile('<%=sernno%>_m2_2');"><img id="img<%=sernno%>_m2_2B" src="<%=src1%>" width="130" height="80" border="0"></a>
		</div>
		</td>
<%
f1 = new File(saveDirectory,sernno+"_m2_3.jpg");
b1 = f1.exists();
d1 ="";
d2 ="";
src1 ="";
if (b1==true)
{
	d1 = "none";
	d2 = "";
	src1 = "FTP/file/"+sernno+"_m2_3.jpg";
}
else
{
	d1 = "";
	d2 = "none";
	src1 = "../images/blank.jpg";
}
%>
		<td width="25%" class="txtblue"><div align="ceter" name="div<%=sernno%>_m2_3A" id="div<%=sernno%>_m2_3A" style="display:<%=d1%>"> 
		<a href="#" onClick="getFile('<%=sernno%>_m2_3');window.open('FTP/getFile.jsp?filename=<%=sernno%>_m2_3','CaseClose','left=200,top=200,width=600,height=300,scrollbars=yes');">���[�Ϥ�</a>
		</div>
		<div align="ceter" name="div<%=sernno%>_m2_3B" id="div<%=sernno%>_m2_3B" style="display:<%=d2%>"><a href="#" onClick="getFile('<%=sernno%>_m2_3');"><img id="img<%=sernno%>_m2_3B" src="<%=src1%>" width="130" height="80" border="0"></a>
		</div>
		</td>
<%
f1 = new File(saveDirectory,sernno+"_m2_4.jpg");
b1 = f1.exists();
d1 ="";
d2 ="";
src1 ="";
if (b1==true)
{
	d1 = "none";
	d2 = "";
	src1 = "FTP/file/"+sernno+"_m2_4.jpg";
}
else
{
	d1 = "";
	d2 = "none";
	src1 = "../images/blank.jpg";
}
%>
		<td width="25%" class="txtblue"><div align="ceter" name="div<%=sernno%>_m2_4A" id="div<%=sernno%>_m2_4A" style="display:<%=d1%>"> 
		<a href="#" onClick="getFile('<%=sernno%>_m2_4');window.open('FTP/getFile.jsp?filename=<%=sernno%>_m2_4','CaseClose','left=200,top=200,width=600,height=300,scrollbars=yes');">���[�Ϥ�</a>
		</div>
		<div align="ceter" name="div<%=sernno%>_m2_4B" id="div<%=sernno%>_m2_4B" style="display:<%=d2%>"><a href="#" onClick="getFile('<%=sernno%>_m2_4');"><img id="img<%=sernno%>_m2_4B" src="<%=src1%>" width="130" height="80" border="0"></a>
		</div>
		</td>
  	</tr> 

	<tr height="80" align="center" valign="middle">
<%
f1 = new File(saveDirectory,sernno+"_m2_5.jpg");
b1 = f1.exists();
d1 ="";
d2 ="";
src1 ="";
if (b1==true)
{
	d1 = "none";
	d2 = "";
	src1 = "FTP/file/"+sernno+"_m2_5.jpg";
}
else
{
	d1 = "";
	d2 = "none";
	src1 = "../images/blank.jpg";
}
%>
		<td width="25%" class="txtblue">
		<div align="ceter" name="div<%=sernno%>_m2_5A" id="div<%=sernno%>_m2_5A" style="display:<%=d1%>"> 
		<a href="#" onClick="getFile('<%=sernno%>_m2_5');window.open('FTP/getFile.jsp?filename=<%=sernno%>_m2_5','CaseClose','left=200,top=200,width=600,height=300,scrollbars=yes');">���[�Ϥ�</a>
		</div>
		<div align="ceter" name="div<%=sernno%>_m2_5B" id="div<%=sernno%>_m2_5B" style="display:<%=d2%>"><a href="#" onClick="getFile('<%=sernno%>_m2_5');"><img id="img<%=sernno%>_m2_5B" src="<%=src1%>" width="130" height="80" border="0"></a>
		</div>
		</td>
<%
f1 = new File(saveDirectory,sernno+"_m2_6.jpg");
b1 = f1.exists();
d1 ="";
d2 ="";
src1 ="";
if (b1==true)
{
	d1 = "none";
	d2 = "";
	src1 = "FTP/file/"+sernno+"_m2_6.jpg";
}
else
{
	d1 = "";
	d2 = "none";
	src1 = "../images/blank.jpg";
}
%>
		<td width="25%" class="txtblue"><div align="ceter" name="div<%=sernno%>_m2_6A" id="div<%=sernno%>_m2_6A" style="display:<%=d1%>"> 
		<a href="#" onClick="getFile('<%=sernno%>_m2_6');window.open('FTP/getFile.jsp?filename=<%=sernno%>_m2_6','CaseClose','left=200,top=200,width=600,height=300,scrollbars=yes');">���[�Ϥ�</a>
		</div>
		<div align="ceter" name="div<%=sernno%>_m2_6B" id="div<%=sernno%>_m2_6B" style="display:<%=d2%>"><a href="#" onClick="getFile('<%=sernno%>_m2_6');"><img id="img<%=sernno%>_m2_6B" src="<%=src1%>" width="130" height="80" border="0"></a>
		</div>
		</td>
<%
f1 = new File(saveDirectory,sernno+"_m2_7.jpg");
b1 = f1.exists();
d1 ="";
d2 ="";
src1 ="";
if (b1==true)
{
	d1 = "none";
	d2 = "";
	src1 = "FTP/file/"+sernno+"_m2_7.jpg";
}
else
{
	d1 = "";
	d2 = "none";
	src1 = "../images/blank.jpg";
}
%>
		<td width="25%" class="txtblue"><div align="ceter" name="div<%=sernno%>_m2_7A" id="div<%=sernno%>_m2_7A" style="display:<%=d1%>"> 
		<a href="#" onClick="getFile('<%=sernno%>_m2_7');window.open('FTP/getFile.jsp?filename=<%=sernno%>_m2_7','CaseClose','left=200,top=200,width=600,height=300,scrollbars=yes');">���[�Ϥ�</a>
		</div>
		<div align="ceter" name="div<%=sernno%>_m2_7B" id="div<%=sernno%>_m2_7B" style="display:<%=d2%>"><a href="#" onClick="getFile('<%=sernno%>_m2_7');"><img id="img<%=sernno%>_m2_7B" src="<%=src1%>" width="130" height="80" border="0"></a>
		</div>
		</td>
<%
f1 = new File(saveDirectory,sernno+"_m2_8.jpg");
b1 = f1.exists();
d1 ="";
d2 ="";
src1 ="";
if (b1==true)
{
	d1 = "none";
	d2 = "";
	src1 = "FTP/file/"+sernno+"_m2_8.jpg";
}
else
{
	d1 = "";
	d2 = "none";
	src1 = "../images/blank.jpg";
}
%>
		<td width="25%" class="txtblue"><div align="ceter" name="div<%=sernno%>_m2_8A" id="div<%=sernno%>_m2_8A" style="display:<%=d1%>"> 
		<a href="#" onClick="getFile('<%=sernno%>_m2_8');window.open('FTP/getFile.jsp?filename=<%=sernno%>_m2_8','CaseClose','left=200,top=200,width=600,height=300,scrollbars=yes');">���[�Ϥ�</a>
		</div>
		<div align="ceter" name="div<%=sernno%>_m2_8B" id="div<%=sernno%>_m2_8B" style="display:<%=d2%>"><a href="#" onClick="getFile('<%=sernno%>_m2_8');"><img id="img<%=sernno%>_m2_8B" src="<%=src1%>" width="130" height="80" border="0"></a>
		</div>
		</td>
  	</tr> 

</table>
<table width="90%"  border="1" align="center" cellpadding="1" cellspacing="1" class="fortable"> 
	<tr class="txtblue">
	  	<td width="5%" rowspan = "11" align="center" >��<br>��<br>��<br>�M</div></td>
	  	<td align="center" >��q</td>
		<td align="center" >�y�츹�X</td>
		<td align="center" >�ȫȩm�W</td>
		<td align="center" >�ϬM�ƶ�</td>
		<td align="center" >�ƶ�����</td>
		</td>
  	</tr> 
	<%
	int csize = 1;
	for(int k=0; k<memoAL.size(); k++)
	{
		PRFuncEvalObj2 memoobj =(PRFuncEvalObj2) memoAL.get(k);
		if("C".equals(memoobj.getMemo_type()))
		{
		%>
		<tr class="txtblue" valign="top">
			<td align="center" >
			<input name="sect<%=csize%>" id="sect<%=csize%>" type="text" value="<%=memoobj.getSect()%>"  size="6" maxlength="6" onkeyup= "javascript:this.value=this.value.toUpperCase();">
			</td>
			<td align="left" ><input name="seatno<%=csize%>" id="seatno<%=csize%>" type="text" value="<%=memoobj.getSeatno()%>"  size="3" maxlength="3" onkeyup= "javascript:this.value=this.value.toUpperCase();"><br>
			<input name="seat_class<%=csize%>" id="seat_class<%=csize%>" type="radio" value="F" <%=(("F".equals(memoobj.getSeat_class()))?"CHECKED":"")%>>F<br>
			<input name="seat_class<%=csize%>" id="seat_class<%=csize%>" type="radio" value="C" <%=(("C".equals(memoobj.getSeat_class()))?"CHECKED":"")%>>C<br>
			<input name="seat_class<%=csize%>" id="seat_class<%=csize%>" type="radio" value="Y" <%=(("Y".equals(memoobj.getSeat_class()))?"CHECKED":"")%>>Y<br>
			<input name="seat_class<%=csize%>" id="seat_class<%=csize%>" type="radio" value="U/D" <%=(("U/D".equals(memoobj.getSeat_class()))?"CHECKED":"")%>>U/D
			</td>
			<td align="left" ><input name="cusname<%=csize%>" id="cusname<%=csize%>" type="text" value="<%=memoobj.getCust_name()%>"  size="10" maxlength="20">
			<br>
<%
			String ifcust_type1 ="";
			String ifcust_type2 ="";
			String ifcust_type3 ="";	
			String ifcust_type4 ="";
			String ifcust_type5 ="";
			if(!"".equals(memoobj.getCust_type()) && memoobj.getCust_type() != null )
			{
				if(memoobj.getCust_type().indexOf("EMER") >= 0 )
				{
					ifcust_type1 = "checked";
				}
				if(memoobj.getCust_type().indexOf("PARA") >= 0 )
				{
					ifcust_type2 = "checked";
				}
				if(memoobj.getCust_type().indexOf("GOLD") >= 0 )
				{
					ifcust_type3 = "checked";
				}
				if(memoobj.getCust_type().indexOf("DYNA") >= 0 )
				{
					ifcust_type4 = "checked";
				}
				if(memoobj.getCust_type().indexOf("MVC") >= 0 )
				{
					ifcust_type5 = "checked";
				}
			}
%>
			<input type="checkbox" name="cust_type<%=csize%>"  id="cust_type<%=csize%>" value="EMER" <%=ifcust_type1%>>EMER<br>
			<input type="checkbox" name="cust_type<%=csize%>"  id="cust_type<%=csize%>" value="PARA" <%=ifcust_type2%>>PARA<br>
			<input type="checkbox" name="cust_type<%=csize%>"  id="cust_type<%=csize%>" value="GOLD" <%=ifcust_type3%>>GOLD<br>
			<input type="checkbox" name="cust_type<%=csize%>"  id="cust_type<%=csize%>" value="DYNA" <%=ifcust_type4%>>DYNA<br>
			<input type="checkbox" name="cust_type<%=csize%>"  id="cust_type<%=csize%>" value="MVC" <%=ifcust_type5%>>MVC
			</td>
			<td align="center" ><textarea name="event<%=csize%>" id="event<%=csize%>" cols= "25" rows = "7"><%=memoobj.getEvent()%></textarea></td>

<%
			String ifcheck1 ="";
			String ifcheck2 ="";
			String ifcheck3 ="";	
			String ifcheck4 ="";
			String ifcheck5 ="";
			String ifcheck6 ="";	
			String ifcheck7 ="";
			String ifcheck8 ="";
			String ifcheck9 ="";	
			String ifcheck10 ="";
			String ifcheck11 ="";
			String ifcheck12="";	
			String ifcheck13="";

			if(!"".equals(memoobj.getEvent_type()) && memoobj.getEvent_type() != null )
			{
				if(memoobj.getEvent_type().indexOf("�q��") >= 0 )
				{
					ifcheck1 = "checked";
				}
				if(memoobj.getEvent_type().indexOf("����") >= 0 )
				{
					ifcheck2 = "checked";
				}
				if(memoobj.getEvent_type().indexOf("�|���Ʃy") >= 0 )
				{
					ifcheck3 = "checked";
				}
				if(memoobj.getEvent_type().indexOf("�Q����") >= 0 )
				{
					ifcheck4 = "checked";
				}
				if(memoobj.getEvent_type().indexOf("�y��") >= 0 )
				{
					ifcheck5 = "checked";
				}
				if(memoobj.getEvent_type().indexOf("�]��") >= 0 )
				{
					ifcheck6 = "checked";
				}
				if(memoobj.getEvent_type().indexOf("�����d�i") >= 0 )
				{
					ifcheck7 = "checked";
				}
				if(memoobj.getEvent_type().indexOf("�n���@�~") >= 0 )
				{
					ifcheck8 = "checked";
				}
				if(memoobj.getEvent_type().indexOf("�\��") >= 0 )
				{
					ifcheck9 = "checked";
				}
				if(memoobj.getEvent_type().indexOf("�ŪA") >= 0 )
				{
					ifcheck10 = "checked";
				}
				if(memoobj.getEvent_type().indexOf("���q�F��") >= 0 )
				{
					ifcheck11 = "checked";
				}
				if(memoobj.getEvent_type().indexOf("AVOD") >= 0 )
				{
					ifcheck12 = "checked";
				}
				if(memoobj.getEvent_type().indexOf("��L") >= 0 )
				{
					ifcheck13 = "checked";
				}
			}
%>
			<td align="left" valign="top">
			<input type="checkbox" name="event_type<%=csize%>"  id="event_type<%=csize%>" value="�q��" <%=ifcheck1%>>�q��&nbsp;
			<input type="checkbox" name="event_type<%=csize%>"  id="event_type<%=csize%>" value="����" <%=ifcheck2%>>����&nbsp;
			<input type="checkbox" name="event_type<%=csize%>"  id="event_type<%=csize%>" value="�|���Ʃy" <%=ifcheck3%>>�|���Ʃy<br>
			<input type="checkbox" name="event_type<%=csize%>"  id="event_type<%=csize%>" value="�y��" <%=ifcheck5%>>�y��&nbsp;
			<input type="checkbox" name="event_type<%=csize%>"  id="event_type<%=csize%>" value="�]��" <%=ifcheck6%>>�]��&nbsp;
			<input type="checkbox" name="event_type<%=csize%>"  id="event_type<%=csize%>" value="�Q����" <%=ifcheck4%>>�Q����<br>
			<input type="checkbox" name="event_type<%=csize%>"  id="event_type<%=csize%>" value="�\��" <%=ifcheck9%>>�\��&nbsp;
			<input type="checkbox" name="event_type<%=csize%>"  id="event_type<%=csize%>" value="�ŪA" <%=ifcheck10%>>�ŪA&nbsp;
			<input type="checkbox" name="event_type<%=csize%>"  id="event_type<%=csize%>" value="�n���@�~" <%=ifcheck8%>>�n���@�~<br>
			<input type="checkbox" name="event_type<%=csize%>"  id="event_type<%=csize%>" value="AVOD" <%=ifcheck12%>>AVOD
			<input type="checkbox" name="event_type<%=csize%>"  id="event_type<%=csize%>" value="�����d�i" <%=ifcheck7%>>�����d�i&nbsp;
			<input type="checkbox" name="event_type<%=csize%>"  id="event_type<%=csize%>" value="���q�F��" <%=ifcheck11%>>���q�F��<br>
			<input type="checkbox" name="event_type<%=csize%>"  id="event_type<%=csize%>" value="��L" <%=ifcheck13%>>��L
			</td>
		</tr> 
		<%			
			csize ++;
		}
	}

	for(int i=csize; i<11; i++)	
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
		<td align="left" ><input name="cusname<%=i%>" id="cusname<%=i%>" type="text" value=""  size="10" maxlength="20">
		<br>
		<input type="checkbox" name="cust_type<%=i%>"  id="cust_type<%=i%>" value="EMER">EMER<br>
		<input type="checkbox" name="cust_type<%=i%>"  id="cust_type<%=i%>" value="PARA">PARA<br>
		<input type="checkbox" name="cust_type<%=i%>"  id="cust_type<%=i%>" value="GOLD">GOLD<br>
		<input type="checkbox" name="cust_type<%=i%>"  id="cust_type<%=i%>" value="DYNA">DYNA<br>
		<input type="checkbox" name="cust_type<%=i%>"  id="cust_type<%=i%>" value="MVC">MVC
		</td>
		<td align="center" >
		<textarea name="event<%=i%>" id="event<%=i%>" cols= "25" rows = "7"></textarea></td>
		<td align="left">
			<input type="checkbox" name="event_type<%=i%>"  id="event_type<%=i%>" value="�q��">�q��&nbsp;
			<input type="checkbox" name="event_type<%=i%>"  id="event_type<%=i%>" value="����">����&nbsp;
			<input type="checkbox" name="event_type<%=i%>"  id="event_type<%=i%>" value="�|���Ʃy">�|���Ʃy<br>
			<input type="checkbox" name="event_type<%=i%>"  id="event_type<%=i%>" value="�y��">�y��&nbsp;
			<input type="checkbox" name="event_type<%=i%>"  id="event_type<%=i%>" value="�]��">�]��&nbsp;
			<input type="checkbox" name="event_type<%=i%>"  id="event_type<%=i%>" value="�Q����">�Q����<br>
			<input type="checkbox" name="event_type<%=i%>"  id="event_type<%=i%>" value="�\��">�\��&nbsp;
			<input type="checkbox" name="event_type<%=i%>"  id="event_type<%=i%>" value="�ŪA">�ŪA&nbsp;
			<input type="checkbox" name="event_type<%=i%>"  id="event_type<%=i%>" value="�n���@�~">�n���@�~<br>
			<input type="checkbox" name="event_type<%=i%>"  id="event_type<%=i%>" value="AVOD">AVOD
			<input type="checkbox" name="event_type<%=i%>"  id="event_type<%=i%>" value="�����d�i">�����d�i&nbsp;
			<input type="checkbox" name="event_type<%=i%>"  id="event_type<%=i%>" value="���q�F��">���q�F��<br>
			<input type="checkbox" name="event_type<%=i%>"  id="event_type<%=i%>" value="��L" >��L
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
session.setAttribute("objAL", objAL);
%>