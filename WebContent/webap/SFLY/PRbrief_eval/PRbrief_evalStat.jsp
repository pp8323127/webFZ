<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.util.*,eg.prfe.*" %>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) 
{		
	response.sendRedirect("../logout.jsp");
}

String empno	= request.getParameter("empno");
String base		= request.getParameter("base");
String sdate	= request.getParameter("sdate");
String edate	= request.getParameter("edate");
String f_score	= request.getParameter("f_score");
String t_score	= request.getParameter("t_score");
String inspector	= request.getParameter("inspector");
String flag		= (String)request.getParameter("flag");

empno = eg.GetEmpno.getEmpno(empno);
StringBuffer sb = new StringBuffer();
StringBuffer sb2 = new StringBuffer();
if(empno != null && !"".equals(empno))
{
	//�Q�d�֤H
	eg.EGInfo egi = new eg.EGInfo(empno);
	eg.EgInfoObj purobj = egi.getEGInfoObj(empno); 
	if(purobj !=null)
	{
		empno   = purobj.getEmpn();
	}
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
sb2.append("<html>\r\n");	
sb2.append("<head>\r\n");	
sb2.append("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=big5\">\r\n");	
sb2.append("<title>�ȿ��g�z����²����{</title>\r\n");	
sb2.append("<style type=\"text/css\">\r\n");	
sb2.append("<!--\r\n");	
sb2.append(".txtblue {\r\n");	
sb2.append("font-size: 12px;\r\n");	
sb2.append("line-height: 13.5pt;\r\n");	
sb2.append("color: #464883;\r\n");	
sb2.append("font-family:  \"Verdana\";\r\n");	
sb2.append("}\r\n");	
sb2.append(".fortable{\r\n");	
sb2.append("border: 1pt solid;\r\n");	
sb2.append("}\r\n");	
sb2.append(".tablehead3 {\r\n");	
sb2.append("font-family: \"Arial\", \"Helvetica\", \"sans-serif\";\r\n");	
sb2.append("background-color: #006699;\r\n");	
sb2.append("font-size: 10pt;\r\n");	
sb2.append("text-align: center;\r\n");	
sb2.append("font-style: normal;\r\n");	
sb2.append("font-weight: normal;\r\n");	
sb2.append("color: #FFFFFF;	\r\n");	
sb2.append("}\r\n");	
sb2.append("-->\r\n");	
sb2.append("</style>\r\n");	
sb2.append("</head>\r\n");		
%>


<body>
<table width="95%"  border="0" align="center" cellpadding="2" cellspacing="0">
  <tr>
    <td width="60%">
      <div align="right"><span class="txttitletop">�ȿ��g�z����²���A¾�ʵ��q </span></div>
    </td>
	<td><div align="right"><a href="javascript:window.print()"><img src="../images/print.gif" width="17" height="15" border="0" alt="�C�L"></a>&nbsp;&nbsp;<input type="button" name="rep" id="rep" value="CSV File" onClick="downreport();">&nbsp;&nbsp;<input type="button" name="rep" id="rep" value="HTM File" onClick="downreport2();"></div></td>
  </tr>
</table>
<table width="95%"  border="1" align="center" cellpadding="1" cellspacing="1" class="fortable"> 
	<tr class="txtblue">
	  	<td align="center" class="tablehead3"><strong>²�����</strong></div></td>
		<td align="center" class="tablehead3"><strong>����ɶ�</strong></div></td>
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
{//���D�w
%>
	<td align="center" class="tablehead3"><strong>�{�����Ҵx����O(20%)</strong></div></td>
	<td align="center" class="tablehead3"><strong>�M�~���ѹB�ί�O(20%)</strong></div></td>
	<td align="center" class="tablehead3"><strong>�H�����Y�{����O(20%)</strong></div></td>
	<td align="center" class="tablehead3"><strong>�f�y��F���q��O(20%)</strong></div></td>
	<td align="center" class="tablehead3"><strong>����²���޲z��O(20%)</strong></div></td>
<%
}
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
	  	<td align="center" class="tablehead3"><strong>General-Check & Info(0%)</strong></div></td>
		<td align="center" class="tablehead3"><strong>A/C General(0%)</strong></div></td>
    	<td align="center" class="tablehead3"><strong>Emergency Procedure(0%)</strong></div></td>
    	<td align="center" class="tablehead3"><strong>Safety/Security(0%)</strong></div></td>
    	<td align="center" class="tablehead3"><strong>Briefing Skill(100%)</strong></div></td>
<%
}
%>
		<td align="center" class="tablehead3"><strong>Total<br>Score</strong></div></td>
    	<td align="center" class="tablehead3"><strong>General Comment</strong></div></td>
    	<td align="center" class="tablehead3"><strong>�d�֤H</strong></div></td>
  	</tr> 
<%
sb2.append("<body>\r\n");	
sb2.append("<table width=\"95%\"  border=\"0\" align=\"center\" cellpadding=\"2\" cellspacing=\"0\">\r\n");	
sb2.append("<tr>\r\n");	
sb2.append("<td width=\"95%\">\r\n");	
sb2.append("<div align=\"center\"><span class=\"txttitletop\">�ȿ��g�z����²���A¾�ʵ��q </span></div>\r\n");	
sb2.append("</td>\r\n");	
sb2.append("</tr>\r\n");	
sb2.append("</table>\r\n");	
sb2.append("<table width=\"95%\"  border=\"1\" align=\"center\" cellpadding=\"1\" cellspacing=\"1\" class=\"fortable\"> \r\n");	
sb2.append("<tr class=\"txtblue\">\r\n");	
sb2.append("<td align=\"center\" class=\"tablehead3\"><strong>²�����</strong></div></td>\r\n");	
sb2.append("<td align=\"center\" class=\"tablehead3\"><strong>����ɶ�</strong></div></td>\r\n");	
sb2.append("<td align=\"center\" class=\"tablehead3\"><strong>�Z��</strong></div></td>\r\n");	
sb2.append("<td align=\"center\" class=\"tablehead3\"><strong>�ȿ��g�z</strong></div></td>\r\n");	
if(gc.after(bfdt))
{//���D�w
sb2.append("<td align=\"center\" class=\"tablehead3\"><strong>�{�����Ҵx����O(20%)</strong></div></td>"+"\r\n");	
sb2.append("<td align=\"center\" class=\"tablehead3\"><strong>�M�~���ѹB�ί�O(20%)</strong></div></td>"+"\r\n");	
sb2.append("<td align=\"center\" class=\"tablehead3\"><strong>�H�����Y�{����O(20%)</strong></div></td>"+"\r\n");	
sb2.append("<td align=\"center\" class=\"tablehead3\"><strong>�f�y��F���q��O(20%)</strong></div></td>"+"\r\n");	
sb2.append("<td align=\"center\" class=\"tablehead3\"><strong>����²���޲z��O(20%)</strong></div></td>"+"\r\n");	
}
else if((gc.before(bfdt) | gc.equals(bfdt)) && gc2.after(bfdt))
{
sb2.append("<td align=\"center\" class=\"tablehead3\"><strong>General-Check & Info(10%)</strong></div></td>"+"\r\n");	
sb2.append("<td align=\"center\" class=\"tablehead3\"><strong>A/C General(35%)</strong></div></td>"+"\r\n");	
sb2.append("<td align=\"center\" class=\"tablehead3\"><strong>Safety & Security(35%)</strong></div></td>"+"\r\n");	
sb2.append("<td align=\"center\" class=\"tablehead3\"><strong>�A�ȫŹF(10%)</strong></div></td>"+"\r\n");	
sb2.append("<td align=\"center\" class=\"tablehead3\"><strong>�w���ĪG(10%)</strong></div></td>"+"\r\n");	
}
else
{
sb2.append("<td align=\"center\" class=\"tablehead3\"><strong>General-Check & Info(0%)</strong></div></td>"+"\r\n");	
sb2.append("<td align=\"center\" class=\"tablehead3\"><strong>A/C General(0%)</strong></div></td>"+"\r\n");	
sb2.append("<td align=\"center\" class=\"tablehead3\"><strong>Emergency Procedure(0%)</strong></div></td>"+"\r\n");	
sb2.append("<td align=\"center\" class=\"tablehead3\"><strong>Safety/Security(0%)</strong></div></td>"+"\r\n");	
sb2.append("<td align=\"center\" class=\"tablehead3\"><strong>Briefing Skill(100%)</strong></div></td>"+"\r\n");	
}

sb2.append("<td align=\"center\" class=\"tablehead3\"><strong>Total<br>Score</strong></div></td>\r\n");	
sb2.append("<td align=\"center\" class=\"tablehead3\"><strong>General Comment</strong></div></td>\r\n");	
sb2.append("<td align=\"center\" class=\"tablehead3\"><strong>�d�֤H</strong></div></td>\r\n");	
sb2.append("</tr> \r\n");	

if(gc.after(bfdt))
{//���D�w
sb.append("²�����,����ɶ�,�Z��,�ȿ��g�z,�{�����Ҵx����O(20%),�M�~���ѹB�ί�O(20%),�H�����Y�{����O(20%),�f�y��F���q��O(20%),����²���޲z��O(20%),Total Score,General Comment,�d�֤H\r\n");	
}
else if((gc.before(bfdt) | gc.equals(bfdt)) && gc2.after(bfdt))
{
sb.append("²�����,����ɶ�,�Z��,�ȿ��g�z,General-Check & Info(10%),A/C General(35%),Safety & Security(35%),�A�ȫŹF(10%),�w���ĪG(10%),Total Score,General Comment,�d�֤H\r\n");	
}
else
{
sb.append("²�����,����ɶ�,�Z��,�ȿ��g�z,General-Check & Info(0%),A/C General(0%),Emergency Procedure(0%),Safety/Security(0%),Briefing Skill(100%),Total Score,General Comment,�d�֤H\r\n");	
}


PRBriefEval prbe = new PRBriefEval();
prbe.getPRBriefEvalStat(sdate,edate,base,empno,f_score,t_score,inspector);
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
		else if((gc.before(bfdt) | gc.equals(bfdt)) && gc2.after(bfdt))
		{
		%>
				<td  align="center"><a href="#" onClick="subwinXY('PRbrief_evalViewDetail.jsp?brief_dt= <%=obj.getBrief_dt()%>&purserEmpno=<%=obj.getPurempno()%>&flag=A','detail','700','350')"><u><%=obj.getTtlscore()%></u></a>
				</td>
		<%
		}
		else
		{
		%>
				<td  align="center"><a href="#" onClick="subwinXY('PRbrief_evalViewDetail2.jsp?brief_dt= <%=obj.getBrief_dt()%>&purserEmpno=<%=obj.getPurempno()%>&flag=B','detail','700','350')"><u><%=obj.getTtlscore()%></u></a>
				</td>
		<%
		}
		%>
		<td  align="left"><%=obj.getComm()%></td>
		<td  align="center"><%=obj.getNewname()%></td>
  	</tr> 
<%
sb2.append("<tr class=\"txtblue\">\r\n");	
sb2.append("<td  align=\"center\">"+obj.getBrief_dt()+"</td>\r\n");	
sb2.append("<td  align=\"center\">"+obj.getBrief_time()+"</td>\r\n");	
sb2.append("<td  align=\"center\" >"+obj.getFltno()+"</td>\r\n");	
sb2.append("<td  align=\"center\" >"+obj.getPurname()+"</td>\r\n");	
sb2.append("<td  align=\"center\">"+obj.getChk1_score()+"</td>\r\n");	
sb2.append("<td  align=\"center\">"+obj.getChk2_score()+"</td>\r\n");	
sb2.append("<td  align=\"center\">"+obj.getChk3_score()+"</td>\r\n");	
sb2.append("<td  align=\"center\">"+obj.getChk4_score()+"</td>\r\n");	
sb2.append("<td  align=\"center\">"+obj.getChk5_score()+"</td>\r\n");	
sb2.append("<td  align=\"center\">"+obj.getTtlscore()+"</td>\r\n");	
sb2.append("<td  align=\"left\">"+obj.getComm()+"</td>\r\n");	
sb2.append("<td  align=\"center\">"+obj.getNewname()+"</td>\r\n");	
sb2.append("</tr> \r\n");	

sb.append(obj.getBrief_dt()+","+obj.getBrief_time()+","+obj.getFltno()+","+obj.getPurname()+","+obj.getChk1_score()+","+obj.getChk2_score()+","+obj.getChk3_score()+","+obj.getChk4_score()+","+obj.getChk5_score()+","+obj.getTtlscore()+","+(obj.getComm().replaceAll(",","�A")).replaceAll("\r\n"," ")+","+obj.getNewname()+"\r\n");	

	}//for(int i=0; i<objAL.size(); i++)
}
else
{//if(objAL.size()>0)
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
<%
sb2.append("</table>\r\n");	
sb2.append("</body>\r\n");	
sb2.append("</html>\r\n");	
%>
<script language="javascript" type="text/javascript">
function downreport()
{
	location.replace("report_download.jsp");
}

function downreport2()
{
	location.replace("report_download2.jsp");
}

</script>

<%
session.setAttribute("sb",sb);	
session.setAttribute("sb2",sb2);	
%>
