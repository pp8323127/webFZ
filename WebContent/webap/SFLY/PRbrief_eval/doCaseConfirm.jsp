<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*,java.util.*,ci.db.*,tool.ReplaceAll, eg.prfe.*" %>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (sGetUsr == null) 
{		
	response.sendRedirect("../../FZ/sendredirect.jsp");
}

			
String yyyymm	   = request.getParameter("yyyymm");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>�y��������²����{</title>
<link href="../../style.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style1 {color: #000000}
.style2 {line-height: 13.5pt; font-family: "Verdana"; font-size: 12px;}
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
.style6 {font-size: 12px; font-weight: bold; }
.style23 {color: #FF0000}
.style24 {color: #000000}
.style25 {color: #000000; font-size: 12px; }
-->
</style>
<script language=javascript>
function s_form()
{
	//alert("�˵�������h�L�k�A�d�ߦ����d�ֳ��i,���O�d�йw���C�L");
	flag = confirm("�˵������T�{?");
	if (flag == true) 
	{
		return true;
	}
	else
	{
		return false;
	}
}

function subwinXY(w,wname,wx,wy){	//�]�w�}�l���������e�A�}�Ҧ�m�b�ù������A�ۭq�}�Ҥj�p
//	wx = 750,wy=210;	
	x =(screen.width - wx) /2;
	y = (screen.height - wy) /2;
	window.open(w,wname,"left="+x+",top="+y+",width="+wx+",height="+wy+",resizable=yes,scrollbars=yes");
}
</script>

</head>
<body>
<table width="95%"  border="0" align="center" cellpadding="2" cellspacing="0">
  <tr>
    <td width="60%">
      <div align="center"><span class="txttitletop">�y��������²����{���q </span></div>
    </td>	
  </tr>
</table>
<table width="95%"  border="1" align="center" cellpadding="1" cellspacing="1" class="fortable"> 
	<tr class="txtblue">
	  	<td align="center" class="tablehead3"><strong>²�����</strong></div></td>
		<td align="center" class="tablehead3"><strong>����ɶ�</strong></div></td>
    	<td align="center" class="tablehead3"><strong>�Z��</strong></div></td>
    	<td align="center" class="tablehead3"><strong>�y����</strong></div></td>
<%
Calendar gc = new GregorianCalendar();  
//2011/05/01�ϥηs�D�w
gc.set(2011,4,1);
        
Calendar bfdt = new GregorianCalendar();//²�����
bfdt.set(Integer.parseInt(yyyymm.substring(0,4)),Integer.parseInt(yyyymm.substring(5,7))-1,1);

if(gc.after(bfdt))
{//���D�w
%>
	<td align="center" class="tablehead3"><strong>�{�����Ҵx����O(20%)</strong></div></td>
	<td align="center" class="tablehead3"><strong>�M�~���ѹB�ί�O(20%)</strong></div></td>
	<td align="center" class="tablehead3"><strong>�H�����Y�{����O(20%)</strong></div></td>
	<td align="center" class="tablehead3"><strong>�f�y��F���q��O(20%)</strong></div></td>
	<td align="center" class="tablehead3"><strong>����²���޲z��O(20%)</strong></div></td>
<%
}
else
{//�s�D�w
%>
	  	<td align="center" class="tablehead3"><strong>General-Check & Info(10%)</strong></div></td>
		<td align="center" class="tablehead3"><strong>A/C General(35%)</strong></div></td>
    	<td align="center" class="tablehead3"><strong>Safety & Security(35%)</strong></div></td>
    	<td align="center" class="tablehead3"><strong>�A�ȫŹF(10%)</strong></div></td>
    	<td align="center" class="tablehead3"><strong>�w���ĪG(10%)</strong></div></td>
<%
}	
%>
		<td align="center" class="tablehead3"><strong>Total<br>Score</strong></div></td>
    	<td align="center" class="tablehead3"><strong>General Comment</strong></div></td>
    	<td align="center" class="tablehead3"><strong>�d�֤H</strong></div></td>
  	</tr> 
<%
PRBriefEval prbe = new PRBriefEval();
prbe.getPRChkCase(yyyymm, yyyymm, sGetUsr);
ArrayList objAL = new ArrayList();
objAL = prbe.getObjAL();
if(objAL.size()>0)
{
	for(int i=0; i<objAL.size(); i++)
	{
		PRBriefEvalObj obj = (PRBriefEvalObj) objAL.get(i);  
%>
	<tr class="txtblue">
	  	<td  align="center"><%=obj.getBrief_dt()%></td>
	  	<td  align="center"><%=obj.getBrief_time()%></td>
	  	<td  align="center" ><%=obj.getFltno()%></td>
		<td  align="center" ><%=obj.getPurname()%></td>
		<td  align="center"><%=obj.getChk1_score()%></td>
		<td  align="center"><%=obj.getChk2_score()%></td>
	  	<td  align="center"><%=obj.getChk3_score()%></td>
		<td  align="center"><%=obj.getChk4_score()%></td>
	  	<td  align="center"><%=obj.getChk5_score()%></td>
<%
bfdt.set(Integer.parseInt(obj.getBrief_dt().substring(0,4)),Integer.parseInt(obj.getBrief_dt().substring(5,7))-1,Integer.parseInt(obj.getBrief_dt().substring(8,10)));
if(gc.after(bfdt))
{//���D�w
%>
		<td  align="center"><%=obj.getTtlscore()%></td>
<%
}
else
{
%>
		<td  align="center"><a href="#" onClick="subwinXY('PRbrief_evalViewDetail.jsp?brief_dt=<%=obj.getBrief_dt()%>&purserEmpno=<%=obj.getPurempno()%>','','700','350')"><u><%=obj.getTtlscore()%></u></a>
		</td>
<%
}
%>
		<td  align="left"><%=obj.getComm()%></td>
		<td  align="center"><%=obj.getNewname()%></td>
  	</tr> 
<%
	}	
%>
</table>
<table width="90%"   align="center"> 
<tr><td align="center">
<form name="form1" method="post" target="mainFrame" action="doCaseConfirm2.jsp" onsubmit="return s_form();">
  <input type="hidden" name="yyyymm" id="yyyymm" value="<%=yyyymm%>">
  <input type="submit" name="Submit" value="�˵�����">
</form>
</td></tr>
</table>
<%
}
else
{
%>
<table width="90%"   align="center"> 
	<tr class="txtblue">
	  	<td  align="center" colspan="12">NO DATA FOUND!!</td>
	</tr>
</table>
<%
}
%>
</body>
</html>
