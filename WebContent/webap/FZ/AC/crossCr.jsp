<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.*,java.sql.*,java.util.*,swap3ac.*"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);

//String ourTeam = (String)session.getAttribute("Unitcd");
String sGetUsr =  (String) session.getAttribute("userid") ;
String goPage  = "";
String aEmpno = (String) session.getAttribute("userid");//request.getParameter("aEmpno");request.getParameter("aEmpno");
if(session.isNew() | null == session.getAttribute("userid"))
{
	response.sendRedirect("../sendredirect.jsp");
}
else
{

//String cname = (String) session.getAttribute("cname") ;
//String empno = request.getParameter("empno");
String empno = request.getParameter("rEmpno");//request.getParameter("rEmpno");(String)session.getAttribute("rEmpno");
String rEmpno = (String)session.getAttribute("rEmpno");

String year = request.getParameter("year");
String month = request.getParameter("month");

if(aEmpno.equals(rEmpno))
{//�Q���̱b���P�ӽЪ̬ۦP
%>
<p style="background-color:#99FFFF;color:#FF0000;font-family:Verdana;font-size:10pt;padding:5pt;text-align:center;">�Q����(<%=empno%>)���u���L��!!</p>
<%
}
else
{

CrewCrossCr csk = new CrewCrossCr(aEmpno, rEmpno, year, month);

CrewInfoObj aCrewInfoObj = null; //�ӽЪ̪��խ��ӤH���
CrewInfoObj rCrewInfoObj = null;//�Q���̪��խ��ӤH���
ArrayList aCrewSkjAL = null;//�ӽЪ̪��Z��
ArrayList rCrewSkjAL = null; //�Q���̪��Z��

String aCname = null;
String rCname = null;
try 
{
	csk.SelectData();
	aCrewInfoObj =csk.getACrewInfoObj();
	rCrewInfoObj =csk.getRCrewInfoObj();		
	aCrewSkjAL	= csk.getACrewSkjAL();
	rCrewSkjAL = csk.getRCrewSkjAL();

	if(aCrewInfoObj != null)
	{ 
	/*	aCname = new String(ci.tool.UnicodeStringParser.removeExtraEscape(
				aCrewInfoObj.getCname()).getBytes(), "Big5");
	*/
		aCname			 = aCrewInfoObj.getCname();
	}

	if(rCrewInfoObj != null)
	{ 
	/*	rCname =new String(ci.tool.UnicodeStringParser.removeExtraEscape(
				rCrewInfoObj.getCname()).getBytes(), "Big5");
	*/
		rCname	 = rCrewInfoObj.getCname();
	}
} 
catch (SQLException e) 
{
	System.out.println("crossCr Exception :"+e.toString());	
}
catch(Exception e)
{
	System.out.println("crossCr Exception :"+e.toString());
	//out.println(e.toString());
}

//���o�Q�d�ߪ̤w������
swap3ac.ApplyCheck ac = new swap3ac.ApplyCheck(aEmpno,rEmpno,year,month);

String bcolor=null;

%>
<html>
<head>
<title>���ɸպ�d��</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" href="../menu.css" type="text/css">
<link rel="stylesheet" type="text/css" href="../errStyle.css">
<link rel="stylesheet" type="text/css" href="../../style/lightColor.css">
<style type="text/css">
<!--
.bt{background-color:#99CCFF;color:#000000;font-family:Verdana;border:1pt solid #000000; }
.bt2{background-color:#CCCCCC;color:#000000;font-family:Verdana;border:1pt solid #000000; }
tr,td{font-family:Verdana, Arial, Helvetica, sans-serif;font-size:10pt;}
.center{text-align:center;}
.tablebody{font-family:Verdana, Arial, Helvetica, sans-serif;font-size:10pt;}
#aSwapSkj, #rSwapSkj{border:1pt solid gray ;}
-->
</style>


<script language="javascript" src="../js/subWindow.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript">

function chek()
{
//var len = <%=aCrewSkjAL.size()+rCrewSkjAL.size()%>;
var c = 0;
	for(var i=0;i<document.form1.elements.length;i++){
		if(document.form1.elements[i].checked){
			c++;
		}
	}

	if(c == 0){
		alert("�ФĿ�󴫯Z��!!");
		return false;
	}else{
		document.form1.Submit.disabled=1;
		return true;
	}
}
</script>

</head>


<body>
<%
//�ӽЪ̻P�Q�����������Ĳխ���i�ϥδ��Z�\��,
if(null == rCrewInfoObj   | null ==aCrewInfoObj)
{
%>
<div class="errStyle1" >
<br>
�Q���̡G <%=rEmpno%> �D���Ī����u��,��<a href="crossCrQueryStep1.jsp" target="_self" style="text-decoration:underline ">���s��J</a>!!
<br>
</div>
<%
}
else if(null == aCrewSkjAL)
{
%>
<div class="errStyle1">
<br>
<%=aEmpno%> �� <%=year+"/"+month %>  �L�Z��,��<a href="crossCrQueryStep1.jsp" target="_self" style="text-decoration:underline ">���s��J</a>!!
<br>
</div>
<%
}
else if(  null == rCrewSkjAL)
{
%>
<div  class="errStyle1">
<br>
�Q�d�ߪ̡G <%=rEmpno%> �� <%=year+"/"+month %>  �L�Z��,��<a href="crossCrQueryStep1.jsp" target="_self" style="text-decoration:underline ">���s��J</a>!!
<br>
</div>
<%
}
else
{
//�g�Jlog
fz.writeLog wl = new fz.writeLog();
wl.updLog(sGetUsr, request.getRemoteAddr(),request.getRemoteHost(), "FZ400");
%>
<form name="form1" method="post"  action="crossCrCalc.jsp" onSubmit="return chek()" >
<div align="center"> 
	<span class="txtxred">���Z���ɸպ�</span><a href="javascript:window.print();"><img src="../images/print.gif" border="0"></a><br>
<!--modify on 2011/12/27-->
<!--���o��몺�C�@��-->
<%
ArrayList dayofmonthAL = new ArrayList();
dayofmonthAL=csk.getEachDayOfMonth(year,month);
%>
<table border="1" cellspacing="1" cellpadding="1" ><!--style="border-collapse:collapse; "-->
	<tr class=" center">
	  <td valign ="middle" rowspan="2" class="bgPurple">FltDate<br><%=year%>/<%=month%></td>
	  <td colspan="6">
		   <span class="txtblue"><%=aCname%> 
				 <%=aCrewInfoObj.getEmpno()%> 
				 <%=aCrewInfoObj.getSern()%> 
				 <%=aCrewInfoObj.getOccu()%> 
				 <%=aCrewInfoObj.getBase()%> 
				 CR:<%=aCrewInfoObj.getPrjcr()%></span><br>
			<span class="txtblue"><span class="txtxred">����w���Z����:<%=ac.getAApplyTimes()%></span></span>
	  </td>
	  <td colspan="6">
		   <span class="txtblue"><%=rCname%> 
				<%=rCrewInfoObj.getEmpno()%> 
				<%=rCrewInfoObj.getSern()%> 
				<%=rCrewInfoObj.getOccu()%> <%=rCrewInfoObj.getBase()%> 
				CR:<%=rCrewInfoObj.getPrjcr()%></span><br>
			<span class="txtblue"><span class="txtxred">����w���Z����:<%=ac.getRApplyTimes()%></span></span>
	  </td>
	</tr>
	<tr class="center">
	  <td class="bgPurple">Fltno</td>
	  <td class="bgPurple">CR</td>
	  <td class="bgPurple">RestHr</td>
	  <td class="bgPurple">SpCode</td>
	  <td class="bgPurple">Detail</td>
	  <td class="bgPurple">Select </td>
	  <td class="bgPurple">Fltno</td>
	  <td class="bgPurple">CR</td>
	  <td class="bgPurple">RestHr</td>
	  <td class="bgPurple">SpCode</td>
	  <td class="bgPurple">Detail</td>
	  <td class="bgPurple">Select </td>
	</tr>
<%
for(int o=0; o<dayofmonthAL.size(); o++)
{
if (o%2 == 0)
{
	bcolor = "bgLBlue";
}
else
{
	bcolor = "";
}

if(((String)dayofmonthAL.get(o)).indexOf("SAT")>=0 | ((String)dayofmonthAL.get(o)).indexOf("SUN")>=0)
{
	//�g��
	bcolor="bgLPink";
}
%>
<tr class="<%=bcolor%>">
	<td class="tablebody"><div align="left"><%=((String)dayofmonthAL.get(o)).substring(8)%></div></td>
<%
int acnt = 0;
for(int i=0;i<aCrewSkjAL.size();i++)
{
	CrewSkjObj obj =(CrewSkjObj) aCrewSkjAL.get(i);		

	if(((String)dayofmonthAL.get(o)).equals(obj.getFdate()+" ("+obj.getDayOfWeek()+")"))
	{
		acnt++;
%>
	  <!--<td class="tablebody"><%=obj.getFdate()+" ("+obj.getDayOfWeek()+")"%></td>-->
	  <td class="tablebody"><%=obj.getDutycode()%>
			<%if("TVL".equals(obj.getCd())){out.print("&nbsp;TVL");}%>
	  </td>
	  <td class="tablebody">&nbsp;<span style="color:#FF0000"> 
	  <%
		  if("BL".equals(obj.getCd()))
		  {
			out.print("0200");
		  }
		  else
		  {
			out.print(obj.getCr());
		  }
	  %> 
	  </span> 
	  </td>
<%
ApplyCheck ack = new ApplyCheck();
ArrayList resthrAL = ack.getRestHour(year,month,"TPE");
String resthr ="";
resthr = obj.getResthr();
 
for(int h=0; h<resthrAL.size(); h++)
{
	RestHourObj resthrobj = (RestHourObj) resthrAL.get(h);
	if(resthrobj.getCondi_val().equals(obj.getDutycode()))
	{
		resthr = resthrobj.getResthr();
	}
	else if(resthrobj.getCondi_val().equals(obj.getArv()))
	{
		resthr = resthrobj.getResthr();
	}
}
/*
String resthr ="";
resthr = obj.getResthr();

if("SB".equals(obj.getDutycode()))
{
resthr = "24";			
}
else if("HS1".equals(obj.getDutycode()) | "HS2".equals(obj.getDutycode()) | "R".equals(obj.getDutycode().substring(0,1)))
{
resthr = "8";			
}
else if ("0833".equals(obj.getDutycode()) | "0835".equals(obj.getDutycode()))
{
resthr = "24";			
}
else if ("GUM".equals(obj.getArv()) | "CNX".equals(obj.getArv()) | "HKT".equals(obj.getArv()))
{
resthr = "36";			
}
else if ("CTS".equals(obj.getArv()))
{
resthr = "�@���";			
}
*/
%>
	  <td class="tablebody">&nbsp;<%=resthr%></td>
	  <td class="tablebody">&nbsp;<%=obj.getSpCode()%></td>
	  <td class="tablebody">
<%
	  if(!"0".equals(obj.getTripno()))
	  {
%>
		<a href="#" onClick="subwinXY('../swap3ac/tripInfo.jsp?tripno=<%=obj.getTripno()%>','t','600','250')" > <img height="16" src="../images/blue_view.gif" width="16" border="0"></a>
<% 
	  }
	  else
	  {
		  out.print("&nbsp;");
	  } 
%> 
	  </td>
	  <td class="tablebody" align="center">&nbsp;
	  <%
	  if(!"B1".equals(obj.getDutycode()) && !"EE".equals(obj.getDutycode()) 
		&& !"MT".equals(obj.getDutycode()) && !"CT".equals(obj.getDutycode()) &&
		!"FT".equals(obj.getDutycode()) && !"B2".equals(obj.getDutycode()) &&
		!"GS".equals(obj.getDutycode()) && !"BL".equals(obj.getDutycode()) 
		&& ((!"0".equals(obj.getTripno()) && !"AL".equals(obj.getDutycode()) && !"XL".equals(obj.getDutycode()) && !"LVE".equals(obj.getDutycode())) || ("0".equals(obj.getTripno()) && ("AL".equals(obj.getDutycode()) | "XL".equals(obj.getDutycode()) | "LVE".equals(obj.getDutycode()))) ) )
	  {
	  %>
		  <input type="checkbox" name="aSwapSkj" id="aSwapSkj" value="<%=i%>">
	  <%
	   }
	   else
	   {
		   out.print("&nbsp;");
	   }
%>
	  </td>
<%
	}//if(dayoffmonthAL.get(o).equals(obj.getFdate()+" ("+obj.getDayOfWeek()+")"))
}//	for(int i=0;i<aCrewSkjAL.size();i++)

if(acnt<=0)
{
%>
	<td colspan="6" class="tablebody">&nbsp;</td>
<%
}

//�Q���̸�T	
int rcnt = 0;
for(int i=0;i<rCrewSkjAL.size();i++)
{
	CrewSkjObj obj = (CrewSkjObj)rCrewSkjAL.get(i);	
	
	if(((String)dayofmonthAL.get(o)).equals(obj.getFdate()+" ("+obj.getDayOfWeek()+")"))
	{
		rcnt++;
%>
	  <td class="tablebody"><%=obj.getDutycode()%> <%if("TVL".equals(obj.getCd())){out.print("&nbsp;TVL");}%></td>
	  <td class="tablebody">&nbsp;<span style="color:#FF0000"> 
<%
		if("BL".equals(obj.getCd()))
		{
			out.print("0200");
		}
		else
		{
			out.print(obj.getCr());
		}			
%> 
		</span> 
		</td>
<%

ApplyCheck ack = new ApplyCheck();
ArrayList resthrAL = ack.getRestHour(year,month,"TPE");
String resthr ="";
resthr = obj.getResthr();

for(int h=0; h<resthrAL.size(); h++)
{
	RestHourObj resthrobj = (RestHourObj) resthrAL.get(h);
	if(resthrobj.getCondi_val().equals(obj.getDutycode()))
	{
		resthr = resthrobj.getResthr();
	}
	else if(resthrobj.getCondi_val().equals(obj.getArv()))
	{
		resthr = resthrobj.getResthr();
	}
}

/*
String resthr ="";
resthr = obj.getResthr();
if("SB".equals(obj.getDutycode()))
{
resthr = "24";			
}
else if("HS1".equals(obj.getDutycode()) | "HS2".equals(obj.getDutycode()) | "R".equals(obj.getDutycode().substring(0,1)))
{
resthr = "8";			
}
else if ("0833".equals(obj.getDutycode()) | "0835".equals(obj.getDutycode()))
{
resthr = "24";			
}
else if ("GUM".equals(obj.getArv()) | "CNX".equals(obj.getArv()) | "HKT".equals(obj.getArv()))
{
resthr = "36";			
}
else if ("CTS".equals(obj.getArv()))
{
resthr = "�@���";			
}
*/
%>
  <td class="tablebody">&nbsp;<%=resthr%></td>
  <td class="tablebody">&nbsp;<%=obj.getSpCode()%></td>
  <td class="tablebody">
<%			
   if(!"0".equals(obj.getTripno()))
   {
%>
	<a href="#" onClick="subwinXY('../swap3ac/tripInfo.jsp?tripno=<%=obj.getTripno()%>','t','600','250')" > <img height="16" src="../images/blue_view.gif" width="16" border="0"></a>
<% 
	}
	else
	{
		out.print("&nbsp;");
	} 
%>    </td>           
  <td class="tablebody" align="center">&nbsp;
<%
	 if(!"B1".equals(obj.getDutycode()) && !"EE".equals(obj.getDutycode())
		&& !"MT".equals(obj.getDutycode()) && !"CT".equals(obj.getDutycode()) &&
		!"FT".equals(obj.getDutycode()) && !"B2".equals(obj.getDutycode()) &&
		!"GS".equals(obj.getDutycode()) && !"BL".equals(obj.getDutycode()) 
		&& ((!"0".equals(obj.getTripno()) && !"AL".equals(obj.getDutycode()) && !"XL".equals(obj.getDutycode()) && !"LVE".equals(obj.getDutycode())) || ("0".equals(obj.getTripno()) && ("AL".equals(obj.getDutycode()) | "XL".equals(obj.getDutycode()) | "LVE".equals(obj.getDutycode()))) ) )
	{
%>
		<input type="checkbox" name="rSwapSkj" id="rSwapSkj" value="<%=i%>">
<%
	}
	else
	{
		out.print("&nbsp;");
	}
%>
	  </td>
<%
	}//if(dayoffmonthAL.get(o).equals(obj.getFdate()+" ("+obj.getDayOfWeek()+")"))
}//	for(int i=0;i<aCrewSkjAL.size();i++)

if(rcnt<=0)
{
%>
	<td colspan="6" class="tablebody">&nbsp;</td>
<%
}
%>
</tr>
<%
}//for(int o=0; o<dayofmonthAL.size(); o++)	
%>
</table>

<br> 
<div align="center">
	  <input type="Submit" name="Submit" value="���Z���ɸպ�" class="buttonLBlue">
	  <input type="hidden" name="year"  value="<%=year%>">
	  <input type="hidden" name="month" value="<%=month%>">
 	  <input type="hidden" name="aEmpno" value="<%=sGetUsr%>">
	  <input type="hidden" name="rEmpno" value="<%=empno%>">
      <br>  
</div>
</form>
<div style="text-align:justify;font-family:Verdana;font-size:10pt;padding-left:150pt;color:#FF0000;padding-bottom:2pt;padding-top:2pt;margin-left:50pt;line-height:1.3" align="center">
**���G<br>
1.B1,CT,FT,B2,GS ���o�ӽд��Z<br>
2.EE,BL�ݥ��g�դW�P�N��A��񴫯Z��ӽ�.<br>
3.AL �i����CR 2�p�ɡA�����v�T�`����.<br>
4.���\��ȴ��Ѵ��Z�e���ɸպ�A<br>
���ˬd���Z����O�_���ӽг�|���gED�B�z�A<br>
�θӤ봫�Z���ƶW�L3�����o���Z�����p.<br>
5.�d�ߥ��ȩ��ӡA���I��Detail <img height="16" src="../images/blue_view.gif" width="16" border="0">�ϥ�.<br>
6.<strong>��ܤ���ɶȨѰѦҡA���T��ɽХH�������^�Ь��ǡC</strong>
</div>
<%
		}//if(null == rCrewInfoObj   | null ==aCrewInfoObj)
%>  
</body>
</html>
<%
	}//if(aEmpno.equals(rEmpno))
}//if(session.isNew() | null == session.getAttribute("userid"))
%>