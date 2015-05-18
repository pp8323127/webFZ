<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.util.*,eg.prfe.*" %>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("../logout.jsp");
}

String syy	= request.getParameter("syy");
String smm	= request.getParameter("smm");
String eyy	= request.getParameter("eyy");
String emm	= request.getParameter("emm");
%> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>座艙長任務簡報表現</title>
<style type="text/css">
<!--
.txtblue {
	font-size: 12px;
	line-height: 13.5pt;
	color: #464883;
	font-family:  "Verdana";
}
.fortable{
	border: 1pt solid;
 }
.tablehead3 {
	font-family: "Arial", "Helvetica", "sans-serif";
	background-color: #006699;
	font-size: 10pt;
	text-align: center;
	font-style: normal;
	font-weight: normal;
	color: #FFFFFF;	
}
-->
</style>
<script language=javascript>
function subwinXY(w,wname,wx,wy){	//設定開始視窗的長寬，開啟位置在螢幕中央，自訂開啟大小
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
      <div align="right"><span class="txttitletop">客艙經理任務簡報表現評量 </span></div>
    </td>
	<td><div align="right"><a href="javascript:window.print()"><img src="../images/print.gif" width="17" height="15" border="0" alt="列印"></a></div></td>
  </tr>
</table>
<table width="95%"  border="1" align="center" cellpadding="1" cellspacing="1" class="fortable"> 
	<tr class="txtblue">
	  	<td align="center" class="tablehead3"><strong>#</strong></div></td>
	  	<td align="center" class="tablehead3"><strong>簡報日期</strong></div></td>
		<td align="center" class="tablehead3"><strong>報到時間</strong></div></td>
    	<td align="center" class="tablehead3"><strong>班次</strong></div></td>
<%
Calendar gc = new GregorianCalendar();  
//2011/04/01使用新題庫
gc.set(2011,3,1);
        
Calendar bfdt = new GregorianCalendar();//簡報日期
bfdt.set(Integer.parseInt(syy),Integer.parseInt(smm)-1,1);

if(gc.after(bfdt))
{//舊題庫
%>
	<td align="center" class="tablehead3"><strong>現場環境掌控能力(20%)</strong></div></td>
	<td align="center" class="tablehead3"><strong>專業知識運用能力(20%)</strong></div></td>
	<td align="center" class="tablehead3"><strong>人際關係認知能力(20%)</strong></div></td>
	<td align="center" class="tablehead3"><strong>口語表達溝通能力(20%)</strong></div></td>
	<td align="center" class="tablehead3"><strong>任務簡報管理能力(20%)</strong></div></td>
<%
}
else
{//新題庫
%>
	  	<td align="center" class="tablehead3"><strong>General-Check & Info(10%)</strong></div></td>
		<td align="center" class="tablehead3"><strong>A/C General(35%)</strong></div></td>
    	<td align="center" class="tablehead3"><strong>Safety & Security(35%)</strong></div></td>
    	<td align="center" class="tablehead3"><strong>服務宣達(10%)</strong></div></td>
    	<td align="center" class="tablehead3"><strong>預期效果(10%)</strong></div></td>
<%
}	
%>
		<td align="center" class="tablehead3"><strong>Total<br>Score</strong></div></td>
    	<td align="center" class="tablehead3"><strong>General Comment</strong></div></td>
    	<td align="center" class="tablehead3"><strong>查核人</strong></div></td>
    	<td align="center" class="tablehead3"><strong>回覆時間</strong></div></td>
  	</tr> 

<%
PRBriefEval prbe = new PRBriefEval();
prbe.getPRChkCase(syy+"/"+smm, eyy+"/"+emm, userid);
ArrayList objAL = new ArrayList();
objAL = prbe.getObjAL();
int count =0;
if(objAL.size()>0)
{
	for(int i=0; i<objAL.size(); i++)
	{
		PRBriefEvalObj obj = (PRBriefEvalObj) objAL.get(i);  
		if(!"".equals(obj.getConfirm_tmst()) && obj.getConfirm_tmst() != null)
		{
			count++;
%>
	<tr class="txtblue">
		<td  align="center"><%=count%></td>
	  	<td  align="center"><%=obj.getBrief_dt()%></td>
	  	<td  align="center"><%=obj.getBrief_time()%></td>
	  	<td  align="center" ><%=obj.getFltno()%></td>
		<td  align="center"><%=obj.getChk1_score()%></td>
		<td  align="center"><%=obj.getChk2_score()%></td>
	  	<td  align="center"><%=obj.getChk3_score()%></td>
		<td  align="center"><%=obj.getChk4_score()%></td>
	  	<td  align="center"><%=obj.getChk5_score()%></td>
<%
bfdt.set(Integer.parseInt(obj.getBrief_dt().substring(0,4)),Integer.parseInt(obj.getBrief_dt().substring(5,7))-1,Integer.parseInt(obj.getBrief_dt().substring(8,10)));
if(gc.after(bfdt))
{//舊題庫
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
		<td  align="center"><%=obj.getConfirm_tmst()%></td>
  	</tr> 
<%
		}
	}
}

if(count<=0)
{
%>
	<tr class="txtblue">
	  	<td  align="center" colspan="13">NO DATA FOUND!!</td>
	</tr>
<%
}
%>
</table>
</body>
</html>
