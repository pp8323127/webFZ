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
{//被換者帳號與申請者相同
%>
<p style="background-color:#99FFFF;color:#FF0000;font-family:Verdana;font-size:10pt;padding:5pt;text-align:center;">被換者(<%=empno%>)員工號無效!!</p>
<%
}
else
{

CrewCrossCr csk = new CrewCrossCr(aEmpno, rEmpno, year, month);

CrewInfoObj aCrewInfoObj = null; //申請者的組員個人資料
CrewInfoObj rCrewInfoObj = null;//被換者的組員個人資料
ArrayList aCrewSkjAL = null;//申請者的班表
ArrayList rCrewSkjAL = null; //被換者的班表

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

//取得被查詢者已換次數
swap3ac.ApplyCheck ac = new swap3ac.ApplyCheck(aEmpno,rEmpno,year,month);

String bcolor=null;

%>
<html>
<head>
<title>飛時試算查詢</title>
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
		alert("請勾選更換班次!!");
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
//申請者與被換者應為有效組員方可使用換班功能,
if(null == rCrewInfoObj   | null ==aCrewInfoObj)
{
%>
<div class="errStyle1" >
<br>
被換者： <%=rEmpno%> 非有效的員工號,請<a href="crossCrQueryStep1.jsp" target="_self" style="text-decoration:underline ">重新輸入</a>!!
<br>
</div>
<%
}
else if(null == aCrewSkjAL)
{
%>
<div class="errStyle1">
<br>
<%=aEmpno%> 於 <%=year+"/"+month %>  無班表,請<a href="crossCrQueryStep1.jsp" target="_self" style="text-decoration:underline ">重新輸入</a>!!
<br>
</div>
<%
}
else if(  null == rCrewSkjAL)
{
%>
<div  class="errStyle1">
<br>
被查詢者： <%=rEmpno%> 於 <%=year+"/"+month %>  無班表,請<a href="crossCrQueryStep1.jsp" target="_self" style="text-decoration:underline ">重新輸入</a>!!
<br>
</div>
<%
}
else
{
//寫入log
fz.writeLog wl = new fz.writeLog();
wl.updLog(sGetUsr, request.getRemoteAddr(),request.getRemoteHost(), "FZ400");
%>
<form name="form1" method="post"  action="crossCrCalc.jsp" onSubmit="return chek()" >
<div align="center"> 
	<span class="txtxred">換班飛時試算</span><a href="javascript:window.print();"><img src="../images/print.gif" border="0"></a><br>
<!--modify on 2011/12/27-->
<!--取得當月的每一天-->
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
			<span class="txtblue"><span class="txtxred">本月已換班次數:<%=ac.getAApplyTimes()%></span></span>
	  </td>
	  <td colspan="6">
		   <span class="txtblue"><%=rCname%> 
				<%=rCrewInfoObj.getEmpno()%> 
				<%=rCrewInfoObj.getSern()%> 
				<%=rCrewInfoObj.getOccu()%> <%=rCrewInfoObj.getBase()%> 
				CR:<%=rCrewInfoObj.getPrjcr()%></span><br>
			<span class="txtblue"><span class="txtxred">本月已換班次數:<%=ac.getRApplyTimes()%></span></span>
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
	//週末
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
resthr = "一曆日";			
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

//被換者資訊	
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
resthr = "一曆日";			
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
	  <input type="Submit" name="Submit" value="換班飛時試算" class="buttonLBlue">
	  <input type="hidden" name="year"  value="<%=year%>">
	  <input type="hidden" name="month" value="<%=month%>">
 	  <input type="hidden" name="aEmpno" value="<%=sGetUsr%>">
	  <input type="hidden" name="rEmpno" value="<%=empno%>">
      <br>  
</div>
</form>
<div style="text-align:justify;font-family:Verdana;font-size:10pt;padding-left:150pt;color:#FF0000;padding-bottom:2pt;padding-top:2pt;margin-left:50pt;line-height:1.3" align="center">
**註：<br>
1.B1,CT,FT,B2,GS 不得申請換班<br>
2.EE,BL需先經組上同意後，手填換班單申請.<br>
3.AL 可扣除CR 2小時，但不影響總飛時.<br>
4.本功能僅提供換班前飛時試算，<br>
不檢查換班雙方是否有申請單尚未經ED處理，<br>
或該月換班次數超過3次不得換班之情況.<br>
5.查詢任務明細，請點選Detail <img height="16" src="../images/blue_view.gif" width="16" border="0">圖示.<br>
6.<strong>顯示之休時僅供參考，正確休時請以派遣部回覆為準。</strong>
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