<%@page import="java.lang.reflect.Array"%>
<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.util.*,eg.prfe.*" %>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("../logout.jsp");
}
else
{

String empno	= (String)request.getParameter("empno");
String base		= (String)request.getParameter("base");
String sdate	= (String)request.getParameter("sdate");
String edate	= (String)request.getParameter("edate");
String flag		= (String)request.getParameter("flag");

StringBuffer sb = new StringBuffer();
//�Q�d�֤H
empno = eg.GetEmpno.getEmpno(empno);
eg.EGInfo egi = new eg.EGInfo(empno);
eg.EgInfoObj purobj = egi.getEGInfoObj(empno); 
if(purobj !=null)
{
	empno   = purobj.getEmpn();
}
%> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>�ȿ��g�z����²����{</title>
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
<script LANGUAGE="JavaScript">
function subwinXY(w,wname,wx,wy){	//�]�w�}�l���������e�A�}�Ҧ�m�b�ù������A�ۭq�}�Ҥj�p
//	wx = 750,wy=210;	
	x =(screen.width - wx) /2;
	y = (screen.height - wy) /2;
	window.open(w,wname,"left="+x+",top="+y+",width="+wx+",height="+wy+",resizable=yes,scrollbars=yes");
}
</script>
</head>

<%
sb.append("<html>"+"\r\n");	
sb.append("<head>"+"\r\n");	
sb.append("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=big5\">"+"\r\n");	
sb.append("<title>�ȿ��g�z����²����{</title>"+"\r\n");	
sb.append("<style type=\"text/css\">"+"\r\n");	
sb.append("<!--"+"\r\n");	
sb.append(".txtblue {"+"\r\n");	
sb.append("	font-size: 12px;"+"\r\n");	
sb.append("	line-height: 13.5pt;"+"\r\n");	
sb.append("	color: #464883;"+"\r\n");	
sb.append("	font-family:  \"Verdana\";"+"\r\n");	
sb.append("}"+"\r\n");	
sb.append(".fortable{"+"\r\n");	
sb.append("	border: 1pt solid;"+"\r\n");	
sb.append(" }"+"\r\n");	
sb.append(".tablehead3 {"+"\r\n");	
sb.append("	font-family: \"Arial\", \"Helvetica\", \"sans-serif\";"+"\r\n");	
sb.append("background-color: #006699;"+"\r\n");	
sb.append("font-size: 10pt;"+"\r\n");	
sb.append("text-align: center;"+"\r\n");	
sb.append("font-style: normal;"+"\r\n");	
sb.append("font-weight: normal;"+"\r\n");	
sb.append("color: #FFFFFF;	"+"\r\n");	
sb.append("}"+"\r\n");	
sb.append("-->"+"\r\n");	
sb.append("</style>"+"\r\n");	
sb.append("</head>"+"\r\n");	
%>

<body>
<table width="95%"  border="0" align="center" cellpadding="2" cellspacing="0">
  <tr>
    <td width="60%">
      <div align="right"><span class="txttitletop">�ȿ��g�z����²���A¾�ʵ��q </span></div>
    </td>
	<td><div align="right"><a href="javascript:window.print()"><img src="../images/print.gif" width="17" height="15" border="0" alt="�C�L"></a>&nbsp;&nbsp;<input type="button" name="rep" id="rep" value="Download File" onClick="downreport();"></div></td>
  </tr>
</table>
<table width="95%"  border="1" align="center" cellpadding="1" cellspacing="1" class="fortable"> 
	<tr class="txtblue">
	  	<td align="center" class="tablehead3"><strong>²�����</strong></div></td>
		<td align="center" class="tablehead3"><strong>²���ɶ�</strong></div></td>
    	<td align="center" class="tablehead3"><strong>�Z��</strong></div></td>
    	<td align="center" class="tablehead3"><strong>�ȿ��g�z</strong></div></td>
<%
Calendar gc = new GregorianCalendar();  
//2011/05/01�ϥηs�D�w
gc.set(2011,4,1);

Calendar gc2 = new GregorianCalendar();  
//2012/12/01�S��s�D�w
gc2.set(2012,11,01);
        
Calendar bfdt = new GregorianCalendar();//²�����
bfdt.set(Integer.parseInt(sdate.substring(0,4)),Integer.parseInt(sdate.substring(5,7))-1,Integer.parseInt(sdate.substring(8,10)));

if(gc.after(bfdt))
//2011/05/01 �ϥηs�D�w
{//���D�w
%>
	<td align="center" class="tablehead3"><strong>�{�����Ҵx����O(20%)</strong></div></td>
	<td align="center" class="tablehead3"><strong>�M�~���ѹB�ί�O(20%)</strong></div></td>
	<td align="center" class="tablehead3"><strong>�H�����Y�{����O(20%)</strong></div></td>
	<td align="center" class="tablehead3"><strong>�f�y��F���q��O(20%)</strong></div></td>
	<td align="center" class="tablehead3"><strong>����²���޲z��O(20%)</strong></div></td>
<%
}
//else if(gc.after(bfdt))
else if((gc.before(bfdt) | gc.equals(bfdt)) && gc2.after(bfdt))
{//2012/12/01 ����D�w
	flag ="A";
%>
	  	<td align="center" class="tablehead3"><strong>General-Check & Info(10%)</strong></div></td>
		<td align="center" class="tablehead3"><strong>A/C General(35%)</strong></div></td>
    	<td align="center" class="tablehead3"><strong>Safety & Security(35%)</strong></div></td>
    	<td align="center" class="tablehead3"><strong>�A�ȫŹF(10%)</strong></div></td>
    	<td align="center" class="tablehead3"><strong>�w���ĪG(10%)</strong></div></td>
<%
}	
else
{
		flag ="B";
%>
	  	<td align="center" class="tablehead3"><strong>General-Check & Info</strong></div></td><!--(0%)  -->
		<td align="center" class="tablehead3"><strong>A/C General</strong></div></td><!--(0%)  -->
    	<td align="center" class="tablehead3"><strong>Emergency Procedure</strong></div></td><!--(0%)  -->
    	<td align="center" class="tablehead3"><strong>Safety/Security</strong></div></td><!--(0%)  -->
    	<td align="center" class="tablehead3"><strong>Briefing Skill(100%)</strong></div></td>
<%
}
%>
		<td align="center" class="tablehead3"><strong>Total<br>Score</strong></div></td>
    	<td align="center" class="tablehead3"><strong>General Comment</strong></div></td>
    	<td align="center" class="tablehead3"><strong>�d�֤H</strong></div></td>
  	</tr> 

<%
sb.append("<body>"+"\r\n");	
sb.append("<table width=\"95%\"  border=\"0\" align=\"center\" cellpadding=\"2\" cellspacing=\"0\">"+"\r\n");	
sb.append("<tr>"+"\r\n");	
sb.append("<td>"+"\r\n");	
sb.append("<div align=\"center\"><span class=\"txttitletop\">�ȿ��g�z����²���A¾�ʵ��q </span></div>"+"\r\n");	
sb.append("</td>"+"\r\n");	
sb.append("</tr>"+"\r\n");	
sb.append("</table>"+"\r\n");	
sb.append("<table width=\"95%\"  border=\"1\" align=\"center\" cellpadding=\"1\" cellspacing=\"1\" class=\"fortable\"> "+"\r\n");	
sb.append("<tr class=\"txtblue\">"+"\r\n");	
sb.append("<td align=\"center\" class=\"tablehead3\"><strong>²�����</strong></div></td>"+"\r\n");	
sb.append("<td align=\"center\" class=\"tablehead3\"><strong>�ɶ�</strong></div></td>"+"\r\n");	
sb.append("<td align=\"center\" class=\"tablehead3\"><strong>�Z��</strong></div></td>"+"\r\n");	
sb.append("<td align=\"center\" class=\"tablehead3\"><strong>�ȿ��g�z</strong></div></td>"+"\r\n");	

if(gc.after(bfdt))
{//���D�w
sb.append("<td align=\"center\" class=\"tablehead3\"><strong>�{�����Ҵx����O(20%)</strong></div></td>"+"\r\n");	
sb.append("<td align=\"center\" class=\"tablehead3\"><strong>�M�~���ѹB�ί�O(20%)</strong></div></td>"+"\r\n");	
sb.append("<td align=\"center\" class=\"tablehead3\"><strong>�H�����Y�{����O(20%)</strong></div></td>"+"\r\n");	
sb.append("<td align=\"center\" class=\"tablehead3\"><strong>�f�y��F���q��O(20%)</strong></div></td>"+"\r\n");	
sb.append("<td align=\"center\" class=\"tablehead3\"><strong>����²���޲z��O(20%)</strong></div></td>"+"\r\n");	
}
else if((gc.before(bfdt) | gc.equals(bfdt)) && gc2.after(bfdt))
{
sb.append("<td align=\"center\" class=\"tablehead3\"><strong>General-Check & Info(10%)</strong></div></td>"+"\r\n");	
sb.append("<td align=\"center\" class=\"tablehead3\"><strong>A/C General(35%)</strong></div></td>"+"\r\n");	
sb.append("<td align=\"center\" class=\"tablehead3\"><strong>Safety & Security(35%)</strong></div></td>"+"\r\n");	
sb.append("<td align=\"center\" class=\"tablehead3\"><strong>�A�ȫŹF(10%)</strong></div></td>"+"\r\n");	
sb.append("<td align=\"center\" class=\"tablehead3\"><strong>�w���ĪG(10%)</strong></div></td>"+"\r\n");	
}
else //2012/12/01 ����D�w
{
sb.append("<td align=\"center\" class=\"tablehead3\"><strong>General-Check & Info</strong></div></td>"+"\r\n");	
sb.append("<td align=\"center\" class=\"tablehead3\"><strong>A/C General</strong></div></td>"+"\r\n");	
sb.append("<td align=\"center\" class=\"tablehead3\"><strong>Emergency Procedure</strong></div></td>"+"\r\n");	
sb.append("<td align=\"center\" class=\"tablehead3\"><strong>Safety/Security</strong></div></td>"+"\r\n");	
sb.append("<td align=\"center\" class=\"tablehead3\"><strong>Briefing Skill(100%)</strong></div></td>"+"\r\n");	
}

sb.append("<td align=\"center\" class=\"tablehead3\"><strong>Total<br>Score</strong></div></td>"+"\r\n");	
sb.append("<td align=\"center\" class=\"tablehead3\"><strong>General Comment</strong></div></td>"+"\r\n");	
sb.append("<td align=\"center\" class=\"tablehead3\"><strong>�d�֤H</strong></div></td>"+"\r\n");	
sb.append("</tr> "+"\r\n");	
%>
<%
PRBriefEval prbe = new PRBriefEval();
prbe.setFlag(flag);//2012/12/01 ����D�w
prbe.getPRBriefEval(sdate,edate,empno,base);
ArrayList objAL = new ArrayList();
objAL = prbe.getObjAL();

String [] showPass = new String[4];
if(objAL.size()>0)
{
	for(int i=0; i<objAL.size(); i++)
	{
		for(int m=0;m<showPass.length;m++){
			showPass[m] = "FAIL";//�w�]���q�L
		}
		PRBriefEvalObj obj = (PRBriefEvalObj) objAL.get(i);  
		
		//2013/01/15
		//if(flag.equals("B")){
			ArrayList scoreAL = new ArrayList();
			scoreAL = obj.getSubScoreObjAL();
			if(scoreAL.size()>0){
				for(int k=0;k<scoreAL.size();k++){
					PRBriefSubScoreObj objS = (PRBriefSubScoreObj) scoreAL.get(k) ;
					//out.println(objS.getItem_no());
					if(showPass[0].equals("FAIL") && objS.getItem_no().equals("F") && Integer.parseInt(objS.getScore()) > 0 ){
						showPass[0] = "PASS";
					}
					if(showPass[1].equals("FAIL") && objS.getItem_no().equals("G") && Integer.parseInt(objS.getScore()) > 0 ){
						showPass[1] = "PASS";
					}
					if(showPass[2].equals("FAIL") && objS.getItem_no().equals("H") && Integer.parseInt(objS.getScore()) > 0 ){
						showPass[2] = "PASS";
					}
					if(showPass[3].equals("FAIL") && objS.getItem_no().equals("I") && Integer.parseInt(objS.getScore()) > 0 ){
						showPass[3] = "PASS";
					}
				}
				
			}
		//}
		//2013/01/15 end		
%>
	<tr class="txtblue">
	  	<td  align="center"><%=obj.getBrief_dt()%></td>
	  	<td  align="center"><%=obj.getBrief_time()%></td>
	  	<td  align="center" ><%=obj.getFltno()%></td>
		<td  align="center" ><%=obj.getPurname()%></td>
		<% 
		/***********<!-- �C�X4������ 2013/01/15-->*************/
		if(flag.equals("A")){
		%>
		<td  align="center"><%=obj.getChk1_score()%></td>
		<td  align="center"><%=obj.getChk2_score()%></td>
	  	<td  align="center"><%=obj.getChk3_score()%></td>
		<td  align="center"><%=obj.getChk4_score()%></td>
	  
	  	<% 
	  	}else{//flag.equals("B")
		  	for(int m=0;m<showPass.length;m++){
		  	%>
		  	<td  align="center"><%=showPass[m]%></td>
			<%
			}
		}
		/************************/
		%>
		<td  align="center"><%=obj.getChk5_score()%></td>
		<%
if(obj.getComm()==null)
{
	obj.setComm(" ");
}

bfdt.set(Integer.parseInt(obj.getBrief_dt().substring(0,4)),Integer.parseInt(obj.getBrief_dt().substring(5,7))-1,Integer.parseInt(obj.getBrief_dt().substring(8,10)));

if(gc.after(bfdt))
{//���D�w
%>
		<td  align="center"><%=obj.getTtlscore()%></td>
<%
}
else if((gc.before(bfdt) | gc.equals(bfdt)) && gc2.after(bfdt)) //2012/12/01 ����D�w
{
%>
		<td  align="center"><a href="#" onClick="subwinXY('PRbrief_evalViewDetail.jsp?brief_dt=<%=obj.getBrief_dt()%>&purserEmpno=<%=obj.getPurempno()%>&flag=A','','700','350')"><u><%=obj.getTtlscore()%></u></a>
		</td>
<%
}
else //if(sdate<"2012/10/25") //2012/12/01 ����D�w
{
%>
		<td  align="center"><a href="#" onClick="subwinXY('PRbrief_evalViewDetail2.jsp?brief_dt=<%=obj.getBrief_dt()%>&purserEmpno=<%=obj.getPurempno()%>&flag=B','','700','350')"><u><%=obj.getTtlscore()%></u></a>
		</td>
<%
}
%>
		<td  align="left"><%=obj.getComm()%></td>
		<td  align="center"><%=obj.getNewname()%></td>
  	</tr> 
<%
sb.append("<tr class=\"txtblue\">"+"\r\n");	
sb.append("<td  align=\"center\">"+obj.getBrief_dt()+"</td>"+"\r\n");	
sb.append("<td  align=\"center\">"+obj.getBrief_time()+"</td>"+"\r\n");	
sb.append("<td  align=\"center\" >"+obj.getFltno()+"</td>"+"\r\n");	
sb.append("<td  align=\"center\" >"+obj.getPurname()+"</td>"+"\r\n");
/***************************/
if(flag.equals("A")){
	sb.append("<td  align=\"center\">"+obj.getChk1_score()+"</td>"+"\r\n");	
	sb.append("<td  align=\"center\">"+obj.getChk2_score()+"</td>"+"\r\n");	
	sb.append("<td  align=\"center\">"+obj.getChk3_score()+"</td>"+"\r\n");	
	sb.append("<td  align=\"center\">"+obj.getChk4_score()+"</td>"+"\r\n");
}else{ //if(flag.equals("B"))
	for(int m=0;m<showPass.length;m++){
		sb.append("<td  align=\"center\">"+showPass[m]+"</td>"+"\r\n");
	}
}
/***************************/
sb.append("<td  align=\"center\">"+obj.getChk5_score()+"</td>"+"\r\n");	
sb.append("<td  align=\"center\">"+obj.getTtlscore()+"</td>"+"\r\n");	
sb.append("<td  align=\"left\">"+obj.getComm()+"</td>"+"\r\n");	
sb.append("<td  align=\"center\">"+obj.getNewname()+"</td>"+"\r\n");	
sb.append("</tr> "+"\r\n");	
%>
<%
	}
}
else
{
%>
	<tr class="txtblue">
	  	<td  align="center" colspan="12">NO DATA FOUND!!</td>
	</tr>
<%
}
%>
</table>
</body>
</html>
<script language="javascript" type="text/javascript">
function downreport()
{
	location.replace("viewPRBE_download.jsp");
}
</script>
<%
sb.append("</table>"+"\r\n");
sb.append("</body>"+"\r\n");
sb.append("</html>"+"\r\n");
session.setAttribute("sb",sb);
}
%>

