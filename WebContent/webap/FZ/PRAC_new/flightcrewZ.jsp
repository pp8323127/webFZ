<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="java.sql.*,
				java.net.URLEncoder,
				java.util.*,
				ci.db.*,
				ci.tool.*,
				fz.pracP.*,
				fz.prObj.*"
%>
<html>
<head>
<title>Flight Query</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="style2.css" rel="stylesheet" type="text/css">
<link href="errStyle.css"  rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript">

</script>
</head>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) {		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} else{

//檢查是否為Power user(開發人員.groupId=CSOZEZ)
String  isPowerUser = (String)session.getAttribute("powerUser"); 
String bgColor = "#FFFFFF";


String fyy = request.getParameter("fyy");
String fmm = request.getParameter("fmm");
String fdd = request.getParameter("fdd");
//String mydate = fyy+"/"+fmm + "/" + fdd;
//取得考績年度
String GdYear = fz.pracP.GdYear.getGdYear(fyy+"/"+fmm + "/" + fdd);
boolean futureFlt = false;

String fltno = request.getParameter("fltno");//.replace('Z', ' ').trim();
String sect = request.getParameter("sect");
//判斷選擇的航班是否為未來fly , 是-->只可Print , 不是-->可Edit & Print
//cs66 2006/2/20
GregorianCalendar curDate = new GregorianCalendar();
GregorianCalendar skjDate = new GregorianCalendar();
skjDate.set(Integer.parseInt(fyy) ,Integer.parseInt(fmm)-1,Integer.parseInt(fdd));

if(skjDate.after(curDate))
{ // 在目前日期之後,不得編輯
	futureFlt = true;
}

//out.println("fltno "+fltno);
//取得資料
fz.pracP.GetFltInfo ft = new fz.pracP.GetFltInfo(fyy+"/"+fmm + "/" + fdd, fltno, true);
ArrayList dataAL = null;
try {
	ft.RetrieveData();
	dataAL = ft.getDataAL();

} catch (SQLException e) {
	System.out.println(e.toString());
} catch (Exception e) {
	System.out.println(e.toString());
}

//out.println(dataAL.size());
%>


<body >
<%
if(!ft.isHasData())
{
%>
<div class="errStyle1" >NO DATA!!</div>
<%
}
//else //if(dataAL.size() ==1 )
else if(dataAL.size() ==1 )
{//僅有一班時，check是否為本班次座艙長
	fz.prObj.FltObj obj = null;
	int idx =0;
	//out.println(sect);
	//out.println(dataAL.size());
	//out.println(dpt);
	//out.println(arv);
//out.print(dataAL.size());
	for(int o=0; o<dataAL.size(); o++)
	{
		obj = (fz.prObj.FltObj)dataAL.get(o);
/*
		if(sGetUsr.equals(obj.getPurEmpno()))
		{
			idx = o;
		}
*/
		if(sGetUsr.equals(obj.getPurEmpno()) && sect.equals(obj.getDpt()+obj.getArv()))
		{
			idx = o;
		}
	}

	obj = (fz.prObj.FltObj)dataAL.get(idx);

//out.print(fyy+"/"+fmm+"/"+fdd+"*"+obj.getFltno()+"*"+obj.getDpt()+obj.getArv()+"*"+obj.getPurEmpno());

	 fz.pracP.CheckFltData cflt = new fz.pracP.CheckFltData(fyy+"/"+fmm+"/"+fdd, obj.getFltno(),obj.getDpt()+obj.getArv(),obj.getPurEmpno());	 
		try 
		{
			cflt.RetrieveData();
		} catch (SQLException e) {} catch (Exception e) {   }
		

		

	if(!sGetUsr.equals(obj.getPurEmpno()) &&!"Y".equals(isPowerUser))
	{//非本班機座艙長,亦非poweruser		
	%>
	<div class="errStyle1" >非本班機座艙長,不得撰寫報告!!<%=obj.getPurEmpno()%></div>
	<%
	}
	else if(cflt.isHasFltData() && !cflt.isUpd())
	{
	%>
		<div class="errStyle1" >報告已送出，不得再修改!!</div>
	<%
														
    }
	else
	{
%>
<div align="center" class="txttitletop">
<table width="60%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td width="90%"> 
        <div align="center" class="txttitletop"> <%=fyy+fmm+fdd%>&nbsp; Fltno: <%=fltno%></div>
      </td>
    </tr>
    <tr>
      <td class="txtxred">
        <div align="right">班表時間為起迄站之當地時間 </div>
      </td>
    </tr>
  </table>
<table width="81%" border="0" cellpadding="0" cellspacing="0">
  <tr class="tablehead3">
    <td width="10%" height="15">FDate      <br>
      </td>
    <td width="9%">Fltno</td>
    <td width="7%">Dpt</td>
    <td width="8%">Arv</td>
    <td width="16%">Start Time<br> 
      </td>
    <td width="16%">End Time </td>
    <td width="11%">Acno</td>
	<td width="9%">PurName</td>
    <td width="9%">Flt<br>      Irregularity</td>
	<td width="5%" >Print</td>
	</tr>


<%
//只有一筆資料時
	fz.prObj.FltObj obj1 = (fz.prObj.FltObj)dataAL.get(idx);
	fzac.CrewInfoObj purCrewObj =obj.getPurCrewObj();

//取得座艙長中文姓名
aircrew.CrewCName cc = new aircrew.CrewCName();
purCrewObj.setCname(cc.getCname(obj.getPurEmpno()));		


%>
  <tr bgcolor="#FFFFFF">
    <td class="tablebody"><%=obj1.getStdD()%></td>
    <td class="tablebody"><%=obj1.getFltno()%></td>
    <td class="tablebody"><%=obj1.getDpt()%></td>
    <td class="tablebody"><%=obj1.getArv()%></td>
    <td class="tablebody"><%=obj1.getStdDt()%></td>
    <td class="tablebody"><%=obj1.getEndDt()%></td>
    <td class="tablebody"><%=obj1.getAcno()%></td>
	<td class="tablebody"><%=purCrewObj.getCname()%></td>
	 <td align="center" valign="middle" class="tablebody"><div align="center">
	<%
	if(!futureFlt)
	{
	%>
   <a href="checkfltZ.jsp?fdate=<%=obj1.getStdD()%>&fltno=<%=obj1.getFltno()%>&dpt=<%=obj1.getDpt()%>&arv=<%=obj1.getArv()%>&pxac=<%=obj1.getPxac()%>&book_total=<%=obj1.getBook_total()%>&acno=<%=obj1.getAcno()%>&f=<%=obj1.getActualF()%>&c=<%=obj1.getActualC()%>&y=<%=obj1.getActualY()%>&GdYear=<%=GdYear%>&purserEmpno=<%=obj1.getPurEmpno()%>&purname=<%=URLEncoder.encode(purCrewObj.getCname())%>&pursern=<%=purCrewObj.getSern()%>&pgroups=<%=purCrewObj.getGrp()%>" target="_self"><img src="../images/ed3.gif" width="22" height="22" border="0" alt="Edit Report"></a>
	<%
	}
	else
	{
		out.print("X");
	}
	%>
	</div></td>
<td align="center" valign="middle" class="tablebody"><div align="center">
<a href="printrpt.jsp?fdate=<%=obj1.getStdD()%>&fltno=<%=obj1.getFltno()%>&dpt=<%=obj1.getDpt()%>&arv=<%=obj1.getArv()%>&pxac=<%=obj1.getPxac()%>&book_total=<%=obj1.getBook_total()%>&acno=<%=obj1.getAcno()%>&f=<%=obj1.getActualF()%>&c=<%=obj1.getActualC()%>&y=<%=obj1.getActualY()%>&GdYear=<%=GdYear%>" target="_self"><img src="../images/print.gif"  border="0" alt="Print Report"></a></div></td>	
	</tr>
</table>

<table width="72%" border="0" cellpadding="0" cellspacing="0" align="center">
  <tr>
    <td class="txtblue"><br>
      Click <img src="../images/ed3.gif" width="22" height="22" border="0" alt="Edit Report">to Edit Report<br> 
      Click <img src="../images/print.gif"  border="0" alt="Print Report"> to print blank report with crew list. </td>
  </tr>
</table>
</div>
<%

	}
}
else
{//有兩筆以上資料
	fz.prObj.FltObj obj = null;
	int idx =0;
	for(int o=0; o<dataAL.size(); o++)
	{
		obj = (fz.prObj.FltObj)dataAL.get(o);
		if(sGetUsr.equals(obj.getPurEmpno()) && sect.equals(obj.getDpt()+obj.getArv()))
		{
			idx = o;
		}
	}

	obj = (fz.prObj.FltObj)dataAL.get(idx);

//out.print(fyy+"/"+fmm+"/"+fdd+"*"+obj.getFltno()+"*"+obj.getDpt()+obj.getArv()+"*"+obj.getPurEmpno());

	 fz.pracP.CheckFltData cflt = new fz.pracP.CheckFltData(fyy+"/"+fmm+"/"+fdd, obj.getFltno(),obj.getDpt()+obj.getArv(),obj.getPurEmpno());	 
	try 
	{
		cflt.RetrieveData();
	} 
	catch (SQLException e) 
	{
	} 
	catch (Exception e) 
	{   
	}

	if(!sGetUsr.equals(obj.getPurEmpno()) &&!"Y".equals(isPowerUser))
	{//非本班機座艙長,亦非poweruser		
	%>
	<div class="errStyle1" >非本班機座艙長,不得撰寫報告!!<%=obj.getPurEmpno()%></div>
	<%
	}
	else if(cflt.isHasFltData() && !cflt.isUpd())
	{
	%>
		<div class="errStyle1" >報告已送出，不得再修改!!</div>
	<%
														
	}
	else
	{
%>
<div align="center" class="txttitletop">
<table width="60%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td width="90%"> 
        <div align="center" class="txttitletop"> <%=fyy+fmm+fdd%>&nbsp; Fltno: <%=fltno%></div>
      </td>
    </tr>
    <tr>
      <td class="txtxred">
        <div align="right">班表時間為起迄站之當地時間 </div>
      </td>
    </tr>
  </table>
<table width="81%" border="0" cellpadding="0" cellspacing="0">
  <tr class="tablehead3">
    <td width="10%" height="15">FDate      <br>
      </td>
    <td width="9%">Fltno</td>
    <td width="7%">Dpt</td>
    <td width="8%">Arv</td>
    <td width="16%">Start Time<br> 
      </td>
    <td width="16%">End Time </td>
    <td width="11%">Acno</td>
	<td width="9%">PurName</td>
    <td width="9%">Flt<br>      Irregularity</td>
	<td width="5%" >Print</td>
	</tr>


<%
//只有一筆資料時
	fz.prObj.FltObj obj1 = (fz.prObj.FltObj)dataAL.get(idx);
	fzac.CrewInfoObj purCrewObj =obj.getPurCrewObj();

//取得座艙長中文姓名
aircrew.CrewCName cc = new aircrew.CrewCName();
purCrewObj.setCname(cc.getCname(obj.getPurEmpno()));		


%>
  <tr bgcolor="#FFFFFF">
    <td class="tablebody"><%=obj1.getStdD()%></td>
    <td class="tablebody"><%=obj1.getFltno()%></td>
    <td class="tablebody"><%=obj1.getDpt()%></td>
    <td class="tablebody"><%=obj1.getArv()%></td>
    <td class="tablebody"><%=obj1.getStdDt()%></td>
    <td class="tablebody"><%=obj1.getEndDt()%></td>
    <td class="tablebody"><%=obj1.getAcno()%></td>
	<td class="tablebody"><%=purCrewObj.getCname()%></td>
	 <td align="center" valign="middle" class="tablebody"><div align="center">
	<%
	if(!futureFlt)
	{
	%>
   <a href="checkfltZ.jsp?fdate=<%=obj1.getStdD()%>&fltno=<%=obj1.getFltno()%>&dpt=<%=obj1.getDpt()%>&arv=<%=obj1.getArv()%>&pxac=<%=obj1.getPxac()%>&book_total=<%=obj1.getBook_total()%>&acno=<%=obj1.getAcno()%>&f=<%=obj1.getActualF()%>&c=<%=obj1.getActualC()%>&y=<%=obj1.getActualY()%>&GdYear=<%=GdYear%>&purserEmpno=<%=obj1.getPurEmpno()%>&purname=<%=URLEncoder.encode(purCrewObj.getCname())%>&pursern=<%=purCrewObj.getSern()%>&pgroups=<%=purCrewObj.getGrp()%>&stdDt=<%=obj.getStdDt()%>"  target="_self"><img src="../images/ed3.gif" width="22" height="22" border="0" alt="Edit Report"></a>
	<%
	}
	else
	{
		out.print("X");
	}
	%>
	</div></td>
<td align="center" valign="middle" class="tablebody"><div align="center">
<a href="printrpt.jsp?fdate=<%=obj1.getStdD()%>&fltno=<%=obj1.getFltno()%>&dpt=<%=obj1.getDpt()%>&arv=<%=obj1.getArv()%>&pxac=<%=obj1.getPxac()%>&book_total=<%=obj1.getBook_total()%>&acno=<%=obj1.getAcno()%>&f=<%=obj1.getActualF()%>&c=<%=obj1.getActualC()%>&y=<%=obj1.getActualY()%>&GdYear=<%=GdYear%>" target="_self"><img src="../images/print.gif"  border="0" alt="Print Report"></a></div></td>	
	</tr>
</table>

<table width="72%" border="0" cellpadding="0" cellspacing="0" align="center">
  <tr>
    <td class="txtblue"><br>
      Click <img src="../images/ed3.gif" width="22" height="22" border="0" alt="Edit Report">to Edit Report<br> 
      Click <img src="../images/print.gif"  border="0" alt="Print Report"> to print blank report with crew list. </td>
  </tr>
</table>
</div>
<%

	}

}
%>
</body>
</html>
<%
}//end of has session value
%>