<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*,ci.db.*,java.net.URLEncoder,fz.*,java.util.*, fz.psfly.*,fz.projectinvestigate.*, eg.zcrpt.*"%>

<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) {		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} 
//201306
String occu = (String)session.getAttribute("occu");
String uidg = "PR";
if(occu.equals("ZC")){
	uidg = "MC";//掛ZC crew_rank_v , 'MC' 才要寫報告
}
String yy = request.getParameter("yy");
String mm = request.getParameter("mm");

//檢查班表是否公布
swap3ac.PublishCheck pc = new swap3ac.PublishCheck(yy, mm);

if(!pc.isPublished()){
%>
<div style="background-color:#99FFFF;text-align:center;color:#FF0000;font-family:Verdana;font-size:10pt; ">
		<%=yy+"/"+mm%>班表尚未正式公佈!!
</div>
<%
}
else
{
String psrCName = null; 
String psrEname = null;
String psrSern = null;

String fdate 	= null;
String fltno 	= null;//資料庫中抓出來的fltno
String sect 	= null;
String flag = null;	//Y: 有報告 N:無報告
String upd = null;	//Y:報告可再編輯 N:報告不可再編輯
String updStr = null;
String dd = null;
String GdYear = null;
String bgColor = null;
String matchStr = "";
String ftime = "";
String rj = null;
String arln_cd ="CI";
boolean check_pre_mm_done = true;
boolean noticeQA = false;
ArrayList scheAL = new ArrayList();	//儲存報告 in egtcflt
ArrayList updAL = new ArrayList();//儲存報告的狀態(Y: 可編輯，N: 不可編輯)
ArrayList reject = new ArrayList(); //報告是否被退回

Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
ResultSet rs = null;
String sql = null;
String scheSql = null;
int rowCount = 0;
ArrayList fdateAL = new ArrayList();
ArrayList fltnoAL = new ArrayList();
ArrayList sectAL = new ArrayList();
ArrayList acnoAL = new ArrayList();
//*************************************************
ArrayList unhandleZCrptAL = new ArrayList();
ZCReportCheck zcrct = new ZCReportCheck();
unhandleZCrptAL=zcrct.getMonthlyUnHandleZCReportForCM(sGetUsr,yy,mm);
//*************************************************
ConnDB cn = new ConnDB();
ConnAOCI cna = new ConnAOCI();
try
{
	//先抓座艙長的個人資料(orp3..fztcrew)
	cn.setORP3FZUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
	
	stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
		//sql = "select name cname,ename,box from fztcrew where empno='"+ sGetUsr+"'";
	sql = "select cname,ename,sern from egtcbas where empn='"+ sGetUsr+"'";
	rs = stmt.executeQuery(sql);
	
	if(rs.next()){
		psrCName = rs.getString("cname");
		psrEname = rs.getString("ename");
		psrSern = rs.getString("sern");
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


//1.先抓cflt,塞入arrayList
try
{
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
		
//TODO 更改sql
if(sGetUsr.equals("640073") || sGetUsr.equals("638716"))
{	//測試用sql
	sql = "SELECT To_Char(fltd,'yyyy/mm/dd') fdate,fltno,sect,psrempn,psrsern,psrname,nvl(upd,'Y') upd,nvl(reject,'&nbsp;') reject "+
		"FROM egtcflt WHERE fltd BETWEEN To_Date('"+yy+mm+"01 00:00','yyyymmdd hh24:mi') "
		+"AND      Last_Day(To_Date('"+yy+mm+"','yyyymm'))";
}
else
{	//以下的為正式的sql
	sql = "SELECT To_Char(fltd,'yyyy/mm/dd') fdate,fltno,sect,psrempn,acno,psrsern,psrname,nvl(upd,'Y') upd,nvl(reject,'&nbsp;') reject "+
		"FROM egtcflt WHERE fltd BETWEEN To_Date('"+yy+mm+"01 00:00','yyyymmdd hh24:mi') "
		+"AND      Last_Day(To_Date('"+yy+mm+"01 2359','yyyymmdd hh24mi'))+1/3  AND psrempn='"+sGetUsr+"'";
}

rs = stmt.executeQuery(sql);
if(rs!= null)
{
	while (rs.next()) 
	{
		scheAL.add(rs.getString("fdate").trim() + "," + rs.getString("fltno").trim()+ "," + rs.getString("sect").trim());
		updAL.add(rs.getString("upd"));
		reject.add(rs.getString("reject"));
		fdateAL.add(rs.getString("fdate").trim());
		fltnoAL.add(rs.getString("fltno"));
		sectAL.add(rs.getString("sect"));
		acnoAL.add(rs.getString("acno"));
		rowCount ++;
	}
}

//************************************************************************************
rs.close();
//check 前一個月是否完成
sql = " SELECT Count(*) c FROM egtcrpt WHERE empno = '"+sGetUsr+"' AND fltd BETWEEN trunc(To_Date('"+yy+"/"+mm+"/01','yyyy/mm/dd')-32,'mm') AND To_Date('"+yy+"/"+mm+"/01','yyyy/mm/dd')-1 AND flag <> 'Y' ";
rs = stmt.executeQuery(sql);
if (rs.next()) 
{
	if(rs.getInt("c")>0)
	{
		check_pre_mm_done = false;
	}
}

//************************************************************************************
rs.close();
//notice QA
sql = "SELECT Count(*) c FROM dual WHERE SYSDATE BETWEEN To_Date('20130801','yyyymmdd') AND To_Date('20130831 2359','yyyymmdd hh24mi')";
// OR SYSDATE BETWEEN To_Date('20121214','yyyymmdd') AND To_Date('20121221 2359','yyyymmdd hh24mi') 
rs = stmt.executeQuery(sql);
if (rs.next()) 
{
	if(rs.getInt("c")>0)
	{
		noticeQA = true;
	}
}
//************************************************************************************


}
catch (Exception e)
{
	
	  out.print("error 1 : "+e.toString());
}
finally
{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}


try
{
//LIVE 抓AOCIPROD  該月duty為Pusrser的班表
cn.setAOCIPRODCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);

/*
cna.setAOCIFZUser();
java.lang.Class.forName(cna.getDriver());
conn = DriverManager.getConnection(cna.getConnURL(), cna.getConnID(),cna.getConnPW());
stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
*/

//TEST
/*cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);	
stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
*/
if("640790".equals(sGetUsr) || "638716".equals(sGetUsr) )
{	//測試用，設定員工號為627536

	sql = "select to_char(dps.str_dt_tm_loc,'yyyy/mm/dd') fdate,dps.flt_num fltno,to_char(str_dt_tm_loc,'yyyy/mm/dd hh24:mi') stdDt, to_char(str_dt_tm_loc,'hh24mi') ftime, "
		+"dps.duty_cd dutycd, dps.act_port_a dpt,dps.act_port_b arv,r.acting_rank qual, r.special_indicator, dps.arln_cd "
	   +"from duty_prd_seg_v dps, roster_v r where dps.series_num=r.series_num "
	   +"and dps.delete_ind = 'N' AND  r.delete_ind='N' "
	   +"and r.staff_num ='627536' AND dps.act_str_dt_tm_gmt BETWEEN  "
	   +"to_date('"+yy+mm+"01 00:00','yyyymmdd hh24:mi') AND "
	   +"Last_Day( To_Date('"+yy+mm+"01 23:59','yyyymmdd hh24:mi')) "
	   +" AND dps.duty_cd='FLY'" 
	   //+" AND  r.acting_rank='PR'" 
	   +" AND ( r.acting_rank='"+uidg+"' OR Nvl(r.special_indicator,' ') = 'J')"//201306
	   + "order by str_dt_tm_gmt";

}
else
{
/*
	sql = "SELECT fdate,dutycode fltno,dpt,arv FROM "+ct.getTable()+
	" WHERE empno='"+sGetUsr+"' AND substr(fdate,1,7) = '"+yy+"/"+mm+"' "+
	"AND SubStr(Trim(qual),1,1) ='P' and spcode not in ('I','S') and dh <> 'Y' AND dpt <> ' '";
	*/
	sql = "select dps.duty_cd,to_char(dps.str_dt_tm_loc,'yyyy/mm/dd') fdate,dps.flt_num fltno,to_char(str_dt_tm_loc,'yyyy/mm/dd hh24:mi') stdDt, to_char(str_dt_tm_loc,'hh24mi') ftime, "
	+"dps.act_port_a dpt,dps.act_port_b arv,r.acting_rank qual, r.special_indicator, dps.arln_cd arln_cd "
	   +"from duty_prd_seg_v dps, roster_v r where dps.series_num=r.series_num "
	   +"and dps.delete_ind = 'N' AND  r.delete_ind='N' "
	   +"and r.staff_num ='"+sGetUsr+"' AND dps.act_str_dt_tm_gmt BETWEEN  "
	   +"to_date('"+yy+mm+"01 00:00','yyyymmdd hh24:mi') AND "
	   +"Last_Day( To_Date('"+yy+mm+"01 23:59','yyyymmdd hh24:mi')) "
	   +" AND r.duty_cd='FLY' AND dps.duty_cd IN ('FLY','TVL')" 
	   //+ "AND  r.acting_rank='PR'" 
	   //+ "AND ( r.acting_rank='"+uidg+"'  OR Nvl(r.special_indicator,' ') = 'J') "//201306
	   +" AND ( (r.acting_rank in ('PR','MC')  "
	   +" 		OR (r.ACTING_RANK = 'FC' and Nvl(r.special_indicator,' ') = 'J' )"//201306
	   +" 		OR (r.ACTING_RANK = 'FC' and fleet_cd = '738') "//201412
	   +"	 )) "
	   + "order by str_dt_tm_gmt";
}

//out.println(sql);
rs = stmt.executeQuery(sql);
rowCount = 0;
if(rs.next())
{//抓出資料筆數
	rs.last();
	rowCount = rs.getRow();
	rs.beforeFirst();
}



if(rowCount ==0 )
{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
	out.print("查無資料<br>No DATA!!");
	
}
else
{

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>客艙報告 --歷史資料</title>
<link href="style2.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="../js/subWindow.js"></script>
<script language="javascript" type="text/javascript">
function viewCrewList(year,month,day,fltno,sect)
{
	document.getElementById("yy").value = year;
	document.getElementById("mm").value = month;
	document.getElementById("dd").value = day;
	document.getElementById("fltno").value = fltno;
	document.getElementById("sect").value = sect;
	subwinXY('../blank.htm','crewList','1000','800');
	document.form1.target="crewList";
	document.form1.submit();
}

function viewCrewList2(year,month,day,fltno,sect,ftime)
{
window.open ("CrewListForPur.jsp?yy="+year+"&mm="+month+"&dd="+day+"&fltno="+fltno+"&ftime="+ftime+"&port="+sect, 'crewList','height=1000, width=800, toolbar=no, menubar=no, scrollbars=yes, resizable=yes');
}


function viewZCReport(fdate,fltno,sect,purempn)
{
window.open ("ZC/ZCreport_print.jsp?idx=0&fdate="+fdate+"&fltno="+fltno+"&port="+sect+"&purempn="+purempn, 'zcreport','height=600, width=800, toolbar=no, menubar=no, scrollbars=yes, resizable=yes');
}

function handleZCReport(fdate,fltno,sect,purempn,yy,mm)
{
window.open ("handleZCreport.jsp?yy="+yy+"&mm="+mm+"&fdate="+fdate+"&fltno="+fltno+"&port="+sect+"&purempn="+purempn, 'handlezcreport','height=600, width=800, toolbar=no, menubar=no, scrollbars=yes, resizable=yes');
}


function viewMVCList(fdate,fltno,sect)
{
window.open ("mvc/viewMVCList.jsp?fdate="+fdate+"&fltno="+fltno+"&port="+sect,'mvcList','height=600, width=800, toolbar=no, menubar=no, scrollbars=yes, resizable=yes');
}

function notice_undone()
{
	if(<%=check_pre_mm_done%> == false)
	{
		alert("您前二個月份尚有未完成的報告!!");
	}
}

function notice_QA()
{
	if(<%=noticeQA%> == true)
	{
		alert("【提醒您：8/1~8/31日需檢查CCOM，\r\n並將結果誌於CABIN REPORT】");
	}
}


</script>

</head>
<body onload="notice_undone();notice_QA();"> 
<form method="post" name="form1" action="preCrewList.jsp">
	<input type="hidden" name="yy" id="yy" >
	<input type="hidden" name="mm" id="mm">
	<input type="hidden" name="dd" id="dd">
	<input type="hidden" name="fltno" id="fltno">
	<input type="hidden" name="sect" id="sect">
	<input type="hidden" name="arln_cd" id="arln_cd">
</form>
<div align="center">
  <span class="txttitletop">Cabin  Report List --<%=yy+"/"+mm%> </span> 
  <table border="0" width="80%" align="center" cellpadding="2" cellspacing="0">
   <tr >
    <td width="16%" height="23" class="txtblue" >Empno:<%=sGetUsr%></td>
    <td width="24%" class="txtblue">Name:<%=psrCName%></td>
    <td width="29%"  class="txtblue">EName:<%=psrEname%></td>
    <td width="31%"  class="txtblue">Sern:<%=psrSern%></td>
  </tr>
 </table> 
<table width="80%"  border="0" align="center" cellpadding="2" cellspacing="0" class="fortable">
  <tr class="tablehead3">
    <td width="10%">Fdate</td>
    <td width="7%">Fltno</td>
    <td width="8%">Sect</td>
    <td width="12%">Status</td>
    <td width="10%">CM Rpt</td>
    <td width="10%">PR Rpt</td>
	<td width="10%">CrewList</td>
	<td width="6%">MVC</td>
	<td width="10%">PSfly</td>
	<td width="7%">Proj</td>
	<td width="10%">ChkItem</td>
  </tr>
  <%
	if(rs != null)
	{
		while(rs.next())
		{
		boolean isZ = false;
		fdate 	= rs.getString("fdate");
		ftime   = rs.getString("ftime");
		arln_cd = rs.getString("arln_cd");
		dd	= fdate.substring(8);
		
	//取得delay班次號碼 GetFltnoWithSuffix(String flightDate, String fltno, String sector,String actualDepatureDateTime)
	
	fz.pracP.GetFltnoWithSuffix gf = new fz.pracP.GetFltnoWithSuffix(fdate.substring(0,4)+fdate.substring(5,7)+fdate.substring(8),		 rs.getString("fltno"), rs.getString("dpt")+rs.getString("arv"),rs.getString("stdDt"));

	if(rs.getString("fltno").substring(rs.getString("fltno").length()-1).equals("Z"))
	{
	//最後一碼為Z時，不檢查delay班次號碼
		isZ = true;
	}	

	//fltno 	= rs.getString("fltno").trim();
	fltno = gf.getFltnoWithSuffix();
	sect = rs.getString("dpt").trim()+rs.getString("arv").trim();
	matchStr = fdate+","+fltno+","+sect;

	if(!scheAL.isEmpty())
	{
		for (int i = 0; i < scheAL.size(); i++) 
		{
			if(((String)scheAL.get(i)).equals(matchStr)  )
			{
				flag="Y";//已編輯過報告
				upd = (String)updAL.get(i);					
				rj = (String)reject.get(i);
				//match的話。把從EG抓出來的資料set null
				updAL.set(i,null);
				reject.set(i,null);
				fdateAL.set(i,null);
				fltnoAL.set(i,null);
				sectAL.set(i,null);
				acnoAL.set(i,null);
				
				if("Y".equals(rj)) rj = "Reject";
				break;
			}
			else
			{
				flag = "N";
				upd  = "N";
				rj = "&nbsp;";
			}
		}
	}
	else
	{
		flag="N";//還未編輯
	}

	if("Y".equals(flag))
	{	//已編輯過報告
		if("Y".equals(upd) )
		{	//報告仍可修改
			updStr="<font color=blue>可修改"+rj+"</font>";
		}
		else
		{	//報告已送出，不可修改
			updStr="不可修改";
		}
	}
	else
	{	//尚未編輯過報告
		updStr = "<font color=red>尚未編輯</font>";
	}
	

  	if((rs.getRow())%2 == 0)
	{
		bgColor = "#CCCCCC";
	}
	else
	{
		bgColor = "#FFFFFF";
	}


	//判斷報告是否過期未繳	
	GregorianCalendar cal4 = new GregorianCalendar();//today
	cal4.set(Calendar.HOUR_OF_DAY,00);
	cal4.set(Calendar.MINUTE,01);	

	//Fltd+1天
	GregorianCalendar cal5 = new GregorianCalendar();
	cal5.set(Calendar.YEAR,Integer.parseInt(fdate.substring(0,4)));
	cal5.set(Calendar.MONTH,(Integer.parseInt(fdate.substring(5,7)))-1);
	cal5.set(Calendar.DATE,Integer.parseInt(fdate.substring(8))); 
	cal5.add(Calendar.DATE,1);  

	
	if(cal4.after(cal5) && (!"N".equals(upd) | "N".equals(flag)) && (yy+"/"+mm).equals(fdate.substring(0,7)) && !"TVL".equals(rs.getString("duty_cd")) && !"I".equals(rs.getString("special_indicator")))	
	{//非TVL Flt && 非Inspector Flt, 早於今天的fltd又未繳交則底色改為紅色
		bgColor = "#FF8C8C";
	}
	
  %>
  <tr class="tablebody" bgcolor="<%=bgColor%>">
    <td height="28" class="tablebody"><%=fdate%></td>
    <td class="tablebody">
	<%
	if(isZ)
	 {
	//連去新頁
		out.print(rs.getString("fltno")	);
	}
	else
	{
		out.print(fltno);
	}

	if("TVL".equals(rs.getString("duty_cd")))
	{
		out.print("&nbsp;<span style=\"color:#FF0000;\">TVL</span>");
	}
	
	%>	</td>
    <td class="tablebody"><%=sect%></td>
    <td class="tablebody">
	<%
	if("630845".equals(sGetUsr))	
	{
	//out.print(upd+" "+flag);
	//out.print(fltno+" "+sect+" "+matchStr);
	}
	%>
	
	<%=updStr%></td>
    <td class="tablebody">
	<%
	
 //1.已編輯過報告，但尚未送出，或2.尚未編輯過報告-->連結至編輯的畫面
	if(("Y".equals(flag) && "Y".equals(upd))|| "N".equals(flag) )
	{	
		//11~12月，考績算下一年度的
		if(fdate.substring(5,7).equals("11") ||fdate.substring(5,7).equals("12"))
		{	
			GdYear =(Integer.toString((Integer.parseInt(fdate.substring(0,4))+1) ));
		}
		else
		{
			GdYear = fdate.substring(0,4);
		}
		String tempAlertOfTVL = "";
		/*if("TVL".equals(rs.getString("duty_cd")))
		{
			tempAlertOfTVL=" onClick='javascript:alert(\"非本班次Duty客艙,請勿進入編輯報告!!\");' ";
		}*/

		if(isZ)
		{
	%>
		<a href="FltIrrListZ.jsp?fyy=<%=fdate.substring(0,4)%>&fmm=<%=fdate.substring(5,7)%>&fdd=<%=dd%>&fltno=<%=rs.getString("fltno")%>&GdYear=<%=GdYear%>" <%=tempAlertOfTVL%> target="_self">
	<%		
		}
		else
		{
	%>
		<a href="FltIrrList.jsp?fyy=<%=fdate.substring(0,4)%>&fmm=<%=fdate.substring(5,7)%>&fdd=<%=dd%>&fltno=<%=fltno%>&GdYear=<%=GdYear%>" target="_self" <%=tempAlertOfTVL%>>
		<%
		}//end of fltno is not Z 
	%>
		<img src="../images/pencil.gif" width="16" height="16" style="margin-right:1em;border:0pt; " title="Edit Report" alt="Edit Report"></a>
	<%
	}//if(( "Y".equals(flag) && "Y".equals(upd))|| "N".equals(flag) )
	//已編輯過報告且已送出，不可再編輯-->連至report畫面
	else if( ("Y".equals(flag) && "N".equals(upd)) )
	{
	%>
	<a href="PURreport_print.jsp?fdate=<%=fdate%>&fltno=<%=fltno%>&section=<%=sect%>" target="_blank">
	<img src="../images/blue_view.gif" width="16" height="16" style="margin-right:1em;border:0pt; " title="View Report" alt="View Report"></a><br>	
	<%
	}
	%>	</td>
	<%
	//ZC Report
	eg.zcrpt.ZCReport zcrt = new eg.zcrpt.ZCReport();
    zcrt.getZCFltListForPR(fdate,fltno,sect,sGetUsr);
	ArrayList zcAL = new ArrayList();
	zcAL = zcrt.getObjAL();
	if(zcAL.size()>0)
	{
		eg.zcrpt.ZCReportObj zcobj = (eg.zcrpt.ZCReportObj) zcAL.get(0);
		if("Y".equals(zcobj.getIfsent()))
		{//已送出
		    boolean hasunhandlezcrpt = false;
			if(unhandleZCrptAL.size()>0)
			{
				for(int u=0; u<unhandleZCrptAL.size(); u++)
				{
					ZCReportObj unhandleobj = (ZCReportObj) unhandleZCrptAL.get(u);
					if(unhandleobj.getFltd().equals(fdate) && (unhandleobj.getFltno().equals(fltno) | unhandleobj.getFltno().equals(fltno.replaceAll("Z", ""))) && unhandleobj.getSect().equals(sect))
					{
						hasunhandlezcrpt=true;
					}
				}
			}
%>
			<td class="tablebody"><a href="javascript:viewZCReport('<%=fdate%>','<%=fltno%>','<%=sect%>','<%=sGetUsr%>');"><img src="../images/viewmag.png" width="16" height="16" border="0" alt="ZC Report" title="ZC Report"></a>	
<%
			if(hasunhandlezcrpt==true)
			{
%>
				<a href="javascript:handleZCReport('<%=fdate%>','<%=fltno%>','<%=sect%>','<%=sGetUsr%>','<%=yy%>','<%=mm%>');"><img src="../img2/Write.gif" width="16" height="16" border="0" alt="Handle PR Report" title="Handle PR Report">
<%				
			}			
%>
			</td>
<%		
		}
		else
		{//編輯中
%>
			<td><font color="red">編輯中</font></td>
<%		
		}
	}
	else
	{
%>
	<td class="tablebody">&nbsp;</td>
<%	
	}
	%>
	<td class="tablebody">
<%
if("XXXX".equals(sGetUsr))	
{
%>
	<a href="javascript:viewCrewList('<%=fdate.substring(0,4)%>','<%=fdate.substring(5,7)%>','<%=fdate.substring(8)%>','<%=fltno%>','<%=sect%>');"><img src="../images/format-justify-fill.png" width="16" height="16" border="0" alt="Print Crew List" title="Print Crew List"></a>
<%
}
else
{
%>
	<a href="javascript:viewCrewList2('<%=fdate.substring(0,4)%>','<%=fdate.substring(5,7)%>','<%=fdate.substring(8)%>','<%=fltno%>','<%=sect%>','<%=ftime%>');"><img src="../images/format-justify-fill.png" width="16" height="16" border="0" alt="Print Crew List" title="Print Crew List"></a>
<%
}
%>	</td>
	<!--MVC-->
	<td class="tablebody">
	<%
	GregorianCalendar cal1 = new GregorianCalendar();//today
	cal1.set(Calendar.HOUR_OF_DAY,00);
	cal1.set(Calendar.MINUTE,01);	
	
	//三天後
	GregorianCalendar cal2 = new GregorianCalendar();
	cal2.add(Calendar.DATE,4);   	

	//Fltd
	GregorianCalendar cal3 = new GregorianCalendar();
	cal3.set(Calendar.YEAR,Integer.parseInt(fdate.substring(0,4)));
	cal3.set(Calendar.MONTH,(Integer.parseInt(fdate.substring(5,7)))-1);
	cal3.set(Calendar.DATE,Integer.parseInt(fdate.substring(8)));    	
	
	if(cal1.before(cal3) && cal2.after(cal3))	
	//if(cal1.before(cal3) && cal2.after(cal3) && ("632934".equals(sGetUsr) | "630304".equals(sGetUsr) | "628812".equals(sGetUsr) | "626929".equals(sGetUsr) | "630752".equals(sGetUsr) | "630557".equals(sGetUsr) | "631023".equals(sGetUsr) | "630937".equals(sGetUsr) | "630473".equals(sGetUsr) | "631748".equals(sGetUsr) ))	
	//if(cal1.before(cal3) && cal2.after(cal3) && "630368".equals(sGetUsr) )	
	//if(1==2)
	//if("632934".equals(sGetUsr) | "630304".equals(sGetUsr) )
	{//三天內的航班才可查詢MVC
	%>
		<a href="javascript:viewMVCList('<%=fdate%>','<%=arln_cd%><%=fltno%>','<%=sect%>');"><img src="../images/userlist.gif" width="16" height="16" border="0" alt="View MVC List" title="View MVC List"></a>
	<%
	}
	else
	{
		out.print("&nbsp;");
	}
	%>	</td>
	<!--MVC-->
	<!--自我督察-->
	<td class="tablebody">
<%
	//是否需填自我督察
	boolean needfill = false;
	PRSFlyIssue psf = new PRSFlyIssue();
    psf.getPsflyTopic_no(fdate, fltno, sect.substring(0,3), sect.substring(3),sGetUsr,"","") ;
	//out.println(fdate+"  "+fltno+"  "+sect.substring(0,3)+"  "+sect.substring(3)+"  "+sGetUsr);
	if(psf.getTopic_noAL().size()>0)
	{
		needfill = true;
	}


	//已編輯過報告且已送出，不可再編輯  flag 代表有無報告
	if("Y".equals(flag) && "N".equals(upd)) 	
	{
		if(needfill==true)
		{
%>
		 <a href="PSFLY/viewPSFLY.jsp?sect=<%=sect%>&fltdt=<%=fdate%>&fltno=<%=fltno%>" target="_blank">
		 <img src="../images/blue_view.gif" width="16" height="16" style="margin-right:1em;border:0pt; " alt="View PSFLY">		 </a>
<%
		}
		else
		{
%>
		 &nbsp;
<%
		}
	}	
	else if("Y".equals(flag) && "Y".equals(upd))
	{
		if(needfill==true)
		{
			/*
			String topic_no = "";
			for(int k =0; k<psf.getTopic_noAL().size(); k++)
			{
				topic_no = topic_no+","+psf.getTopic_noAL().get(k);
			}
			*/
%>		 
		 <!--<a href="PSFLY/edPSFLY.jsp?sect=&fltdt=&fltno=&topic_no=&fleet=&acno=" target="_blank">-->	 
		 <img src="../images/pencil.gif" width="16" height="16" style="margin-right:1em;border:0pt; " alt="Edit PSFLY">
		 <!--</a>-->
<%
		}
		else
		{
%>
		 &nbsp;
<%
		}
	}
	else if("N".equals(flag))
	{
		if(needfill==true)
		{
			String topic_no = "";
			for(int k =0; k<psf.getTopic_noAL().size(); k++)
			{
				topic_no = topic_no+","+psf.getTopic_noAL().get(k);
			}
%>
		 <a href="PSFLY/prePSFLY.jsp?sect=<%=sect%>&fltdt=<%=fdate%>&fltno=<%=fltno%>&topic_no=<%=topic_no.substring(1)%>&fleet=<%=psf.getFleet()%>&acno=<%=psf.getAcno()%>" target="_blank">
		 <img src="../images/ed1.gif" width="16" height="16" style="margin-right:1em;border:0pt; " alt="PSFLY Request">		 </a>
<%
		}
		else
		{
%>
		 &nbsp;
<%
		}
	}
%>	</td>
	<!--專案調查-->
	<td class="tablebody"><%
	//是否需填專案調查
	boolean pjneedfill = false;
	PRPJIssue pj = new PRPJIssue();
    pj.getPRProj_no(fdate, fltno, sect.substring(0,3), sect.substring(3),sGetUsr,"","") ;
	//out.println(fdate+"  "+fltno+"  "+sect.substring(0,3)+"  "+sect.substring(3)+"  "+sGetUsr);
	if(pj.getProj_noAL().size()>0)
	{
		pjneedfill = true;
	}


	//已編輯過報告且已送出，不可再編輯  flag 代表有無報告
	if("Y".equals(flag) && "N".equals(upd)) 	
	{
		if(pjneedfill==true)
		{
%>
	  <a href="ProjInvestigation/viewProj.jsp?sect=<%=sect%>&fltdt=<%=fdate%>&fltno=<%=fltno%>" target="_blank">
	    <img src="../images/blue_view.gif" width="16" height="16" style="margin-right:1em;border:0pt; " alt="View ProjInvestigation">	    </a>
<%
		}
		else
		{
%>
		 &nbsp;
<%
		}
	}	
	else if("Y".equals(flag) && "Y".equals(upd))
	{
		if(pjneedfill==true)
		{
			/*
			String proj_no = "";
			for(int k =0; k<pj.getProj_noAL().size(); k++)
			{
				proj_no = proj_no+","+pj.getProj_noAL().get(k);
			}
			*/
%>
		<!-- 
		 <a href="ProjInvestigation/edProj.jsp?sect=&fltdt=&fltno=proj_no=&fleet=&acno=" target="_blank">
		 -->
		 <img src="../images/pencil.gif" width="16" height="16" style="margin-right:1em;border:0pt; " alt="Edit ProjInvestigation">
		 <!--</a>-->
<%
		}
		else
		{
%>
		 &nbsp;
<%
		}
	}
	else if("N".equals(flag))
	{
		if(pjneedfill==true)
		{
			String proj_no = "";
			for(int k =0; k<pj.getProj_noAL().size(); k++)
			{
				proj_no = proj_no+","+pj.getProj_noAL().get(k);
			}
%>
		 <a href="ProjInvestigation/preProj.jsp?sect=<%=sect%>&fltdt=<%=fdate%>&fltno=<%=fltno%>&proj_no=<%=proj_no.substring(1)%>&fleet=<%=pj.getFleet()%>&acno=<%=pj.getAcno()%>" target="_blank">
		 <img src="../images/ed1.gif" width="16" height="16" style="margin-right:1em;border:0pt; " alt="ProjInvestigation Request">		 </a>
<%
		}
		else
		{
%>
		 &nbsp;
<%
		}
	}
%>	</td>
	<!--查核項目-->
	<td class="tablebody">
	<%
		//是否需填查核項目
		eg.flightcheckitem.CheckItemKeyValue ckKey = new eg.flightcheckitem.CheckItemKeyValue();
		ckKey.setFltd(fdate);
		ckKey.setFltno(fltno);
		ckKey.setSector(sect);
		ckKey.setPsrEmpn(sGetUsr);
		eg.flightcheckitem.CheckItemWithFlight ckhItemFlt = null;
		ArrayList al = null;
	try
	{
		ckhItemFlt = new eg.flightcheckitem.CheckItemWithFlight(ckKey);	
		al = ckhItemFlt.getChkItemAL();
	}
	catch(Exception e){}

//********************************************************************************************
	if(al != null)
	{
		//已編輯過報告且已送出，不可再編輯  flag 代表有無報告
		if("Y".equals(flag) && "N".equals(upd)) 	
		{
			for(int q=0;q<al.size();q++)
			{
				eg.flightcheckitem.CheckMainItemObj obj = (eg.flightcheckitem.CheckMainItemObj)al.get(q);
				if(obj.isHasCheckData())
				{
		%>
			<a href="chkItem/ViewChkItem.jsp?seqno=<%=obj.getSeqno()%>&checkRdSeq=<%=obj.getCheckRdSeq()%>&sector=<%=sect%>&fltd=<%=fdate%>&fltno=<%=fltno%>&psrEmpn=<%=sGetUsr%>" target="_blank">
			<img src="../images/blue_view.gif" width="16" height="16" style="margin-right:1em;border:0pt; " alt="View Check Item"></a>
		<%
				}
			}
		}	
		else if("Y".equals(flag) && "Y".equals(upd))
		{
		%>
			<img src="../images/pencil.gif" width="16" height="16" style="margin-right:1em;border:0pt; " alt="Check Item Request">
		<%
		}
		else if("N".equals(flag))
		{
		%>
			<img src="../images/ed1.gif" width="16" height="16" style="margin-right:1em;border:0pt; " alt="Check Item Request">
		<%
		}
		else
		{//if(al != null)
		%>
				&nbsp;
		<%
		}
	}
	else
	{//if(al != null)
	%>
			&nbsp;
	<%
	}
	%>	</td>
	<!--Add-->
  </tr>
<%
		}
	}
	//**************************************************************************
	for(int i=0;i<fdateAL.size();i++)
	{
		updStr = "";
		GdYear="";
		if(fdateAL.get(i) != null)
		{		
			if("Y".equals(updAL.get(i)) )
			{	//報告仍可修改
				updStr="<font color=blue>可修改"+rj+"</font>";
			}
			else
			{	//報告已送出，不可修改
				updStr="不可修改";
			}
		
		//11~12月，考績算下一年度的
		if(((String)fdateAL.get(i)  ).substring(5,7).equals("11") ||((String)fdateAL.get(i)  ).substring(5,7).equals("12"))
		{	
			GdYear =(Integer.toString((Integer.parseInt(((String)fdateAL.get(i)  ).substring(0,4))+1) ));
		}
		else
		{
			GdYear = ((String)fdateAL.get(i)  ).substring(0,4);
		}

		//判斷報告是否過期未繳	
		GregorianCalendar cal4 = new GregorianCalendar();//today
		cal4.set(Calendar.HOUR_OF_DAY,00);
		cal4.set(Calendar.MINUTE,01);	

		//cal4.set(Calendar.YEAR,2012);
		//cal4.set(Calendar.MONTH,4);
		//cal4.set(Calendar.DATE,20); 

		
		//Fltd+1天
		GregorianCalendar cal5 = new GregorianCalendar();
		cal5.set(Calendar.YEAR,Integer.parseInt(((String)fdateAL.get(i)).substring(0,4)));
		cal5.set(Calendar.MONTH,(Integer.parseInt(((String)fdateAL.get(i)).substring(5,7)))-1);
		cal5.set(Calendar.DATE,Integer.parseInt(((String)fdateAL.get(i)).substring(8))); 
		cal5.add(Calendar.DATE,1);  

		bgColor="#FFFFCC";
		if(cal4.after(cal5) && !"N".equals(updAL.get(i)))	
		{//早於今天的fltd又未繳交則底色改為紅色
			bgColor = "#FF8C8C";
		}
%>
  <tr class="tablebody" bgcolor="<%=bgColor%>" >
    <td height="28" class="tablebody"><%=fdateAL.get(i)%></td>
    <td class="tablebody"><%=fltnoAL.get(i) %></td>
    <td class="tablebody"><%=sectAL.get(i)  %></td>
    <td class="tablebody"><%=updStr%></td>
    <td class="tablebody">
	
	<%
	if("Y".equals(updAL.get(i)) )
	{//報告仍可修改
	%>
	<a href="edFltIrr.jsp?fdate=<%=fdateAL.get(i)%>&fltno=<%=fltnoAL.get(i)%>&dpt=<%=((String)sectAL.get(i)).substring(0,3)%>&arv=<%=((String)sectAL.get(i)).substring(3)%>&GdYear=<%=GdYear%>&acno=<%=acnoAL.get(i)%>&pur=<%=sGetUsr%>" target="_self">
	<img src="../images/pencil.gif" width="16" height="16" style="margin-right:1em;border:0pt; " title="Edit Report" alt="Edit Report"></a>
	<%	
	}
	else
	{//view
%>
	<a href="PURreport_print.jsp?fdate=<%=fdateAL.get(i)%>&fltno=<%=fltnoAL.get(i)%>&section=<%=sectAL.get(i)%>" target="_blank">
	<img src="../images/blue_view.gif" width="16" height="16" style="margin-right:1em;border:0pt; " title="View Report" alt="View Report"></a><br>
<%	
	}
%></td>

<%
	//ZC Report
	eg.zcrpt.ZCReport zcrt2 = new eg.zcrpt.ZCReport();
    zcrt2.getZCFltListForPR(fdate,fltno,sect,sGetUsr);
	ArrayList zcAL2 = new ArrayList();
	zcAL2 = zcrt2.getObjAL();
	if(zcAL2.size()>0)
	{
		//if("630326".equals(sGetUsr))
		//{
		//	out.println(zcrt2.getSql());
		//}
		eg.zcrpt.ZCReportObj zcobj = (eg.zcrpt.ZCReportObj) zcAL2.get(0);
		if("Y".equals(zcobj.getIfsent()))
		{//已送出
%>
			<td class="tablebody"><a href="javascript:viewZCReport('<%=((String)fdateAL.get(i)).substring(0,4)%>/<%=((String)fdateAL.get(i)).substring(5,7)%>/<%=((String)fdateAL.get(i)).substring(8)%>','<%=fltnoAL.get(i)%>','<%=sectAL.get(i)%>','<%=sGetUsr%>');"><img src="../images/viewmag.png" width="16" height="16" border="0" alt="ZC Report" title="ZC Report"></a>			</td>
<%		
		}
		else
		{//編輯中
%>
			<td><font color="red">編輯中</font></td>
<%		
		}
	}
	else
	{
%>
	<td class="tablebody">&nbsp;</td>
<%	
	}
%>

<td class="tablebody"><a href="javascript:viewCrewList('<%=((String)fdateAL.get(i)).substring(0,4)%>','<%=((String)fdateAL.get(i)).substring(5,7)%>','<%=((String)fdateAL.get(i)).substring(8)%>','<%=fltnoAL.get(i)%>','<%=sectAL.get(i)%>');"><img src="../images/format-justify-fill.png" width="16" height="16" border="0" alt="Print Crew List" title="Print Crew List"></a></td>
<!--Add-->

	<!--MVC-->
	<td class="tablebody">
	<%
	GregorianCalendar cal1 = new GregorianCalendar();//today
	cal1.set(Calendar.HOUR_OF_DAY,00);
	cal1.set(Calendar.MINUTE,01);	
	
	//三天後
	GregorianCalendar cal2 = new GregorianCalendar();
	cal2.add(Calendar.DATE,4);   	

	//Fltd
	GregorianCalendar cal3 = new GregorianCalendar();
	cal3.set(Calendar.YEAR,Integer.parseInt(fdate.substring(0,4)));
	cal3.set(Calendar.MONTH,(Integer.parseInt(fdate.substring(5,7)))-1);
	cal3.set(Calendar.DATE,Integer.parseInt(fdate.substring(8)));    	
	
	if(cal1.before(cal3) && cal2.after(cal3))	
	//if(1==2)
	{//三天內的航班才可查詢MVC
	%>
		<a href="javascript:viewMVCList('<%=fdate%>','<%=fltno%>','<%=sect%>');"><img src="../images/userlist.gif" width="16" height="16" border="0" alt="View MVC List" title="View MVC List"></a>
	<%
	}
	else
	{
		out.print("&nbsp;");
	}
	%>	</td>
	<!--MVC-->

	<!--自我督察-->
	<td>
<%
	//是否需填自我督察
	boolean needfill = false;
	PRSFlyIssue psf = new PRSFlyIssue();
	if (fdateAL.size()>0)
	{				
		psf.getPsflyTopic_no((String)fdateAL.get(i), (String)fltnoAL.get(i), ((String)sectAL.get(i)).substring(0,3), ((String)sectAL.get(i)).substring(3),sGetUsr,"","") ;
		//psf.getPsflyTopic_no("2008/11/25", "0006", "TPE", "TPE",sGetUsr,"","") ;
		//out.println((String)fdateAL.get(i)+"  "+fltnoAL.get(i)+"  "+((String)sectAL.get(i)).substring(0,3)+"  "+((String)sectAL.get(i)).substring(3)+"  "+sGetUsr);
		if(psf.getTopic_noAL().size()>0)
		{
			needfill = true;
		}
    }
	//已編輯過報告且已送出，不可再編輯  flag 代表有無報告
	if("Y".equals(flag) && "N".equals(updAL.get(i))) 	
	{
		if(needfill==true)
		{
%>
		 <a href="PSFLY/viewPSFLY.jsp?sect=<%=sectAL.get(i)%>&fltdt=<%=(String)fdateAL.get(i)%>&fltno=<%=fltnoAL.get(i)%>" target="_blank">
		 <img src="../images/blue_view.gif" width="16" height="16" style="margin-right:1em;border:0pt; " alt="View PSFLY">		 </a>
<%
		}
		else
		{
%>
		 &nbsp;
<%
		}
	}	
	else if("Y".equals(flag) && "Y".equals(updAL.get(i))) 
	{
		if(needfill==true)
		{
			/*
			String topic_no = "";
			for(int k =0; k<psf.getTopic_noAL().size(); k++)
			{
				topic_no = topic_no+","+psf.getTopic_noAL().get(k);
			}
			*/
%>

		 <!--<a href="PSFLY/edPSFLY.jsp?sect=&fltdt= &fltno=&topic_no=&fleet=&acno=" target="_blank">-->
		 
		 <img src="../images/pencil.gif" width="16" height="16" style="margin-right:1em;border:0pt; " alt="Edit PSFLY">
		 <!--</a>-->
<%
		}
		else
		{
%>
		 &nbsp;
<%
		}
	}
	else
	{
		if(needfill==true)
		{
			String topic_no = "";
			for(int k =0; k<psf.getTopic_noAL().size(); k++)
			{
				topic_no = topic_no+","+psf.getTopic_noAL().get(k);
			}
%>
		 <a href="PSFLY/prePSFLY.jsp?sect=<%=sectAL.get(i)%>&fltdt=<%=(String)fdateAL.get(i)%>&fltno=<%=fltnoAL.get(i)%>&topic_no=<%=topic_no.substring(1)%>&fleet=<%=psf.getFleet()%>&acno=<%=psf.getAcno()%>" target="_blank">
		 <img src="../images/ed1.gif" width="16" height="16" style="margin-right:1em;border:0pt; " alt="PSFLY Request">		 </a>
<%
		}
		else
		{
%>
		 &nbsp;
<%
		}
	}
%>	</td>
<!--Add-->
<!--Add-->
	<!--專案調查-->
	<td class="tablebody">
<%
	//是否需填專案調查
	boolean pjneedfill = false;
	PRPJIssue pj = new PRPJIssue();
	if (fdateAL.size()>0)
	{				
		pj.getPRProj_no((String)fdateAL.get(i), (String)fltnoAL.get(i), ((String)sectAL.get(i)).substring(0,3), ((String)sectAL.get(i)).substring(3),sGetUsr,"","") ;
		//pj.getPRProj_no("2008/11/25", "0006", "TPE", "TPE",sGetUsr,"","") ;
		//out.println((String)fdateAL.get(i)+"  "+fltnoAL.get(i)+"  "+((String)sectAL.get(i)).substring(0,3)+"  "+((String)sectAL.get(i)).substring(3)+"  "+sGetUsr);
		if(pj.getProj_noAL().size()>0)
		{
			pjneedfill = true;
		}
    }
	//已編輯過報告且已送出，不可再編輯  flag 代表有無報告
	if("Y".equals(flag) && "N".equals(updAL.get(i))) 	
	{
		if(pjneedfill==true)
		{
%>
		 <a href="ProjInvestigation/viewProj.jsp?sect=<%=sectAL.get(i)%>&fltdt=<%=(String)fdateAL.get(i)%>&fltno=<%=fltnoAL.get(i)%>" target="_blank">
		 <img src="../images/blue_view.gif" width="16" height="16" style="margin-right:1em;border:0pt; " alt="View ProjInvestigation">		 </a>
<%
		}
		else
		{
%>
		 &nbsp;
<%
		}
	}	
	else if("Y".equals(flag) && "Y".equals(updAL.get(i))) 
	{
		if(pjneedfill==true)
		{
			/*
			String proj_no = "";
			for(int k =0; k<pj.getProj_noAL().size(); k++)
			{
				proj_no = proj_no+","+pj.getProj_noAL().get(k);
			}
			*/
%>
		<!--
		 <a href="ProjInvestigation/edProj.jsp?sect=&fltdt=&fltno=&proj_no=&fleet=&acno=" target="_blank">-->
		 <img src="../images/pencil.gif" width="16" height="16" style="margin-right:1em;border:0pt; " alt="Edit ProjInvestigation">
		 <!--</a>-->
<%
		}
		else
		{
%>
		 &nbsp;
<%
		}
	}
	else
	{
		if(pjneedfill==true)
		{
			String proj_no = "";
			for(int k =0; k<pj.getProj_noAL().size(); k++)
			{
				proj_no = proj_no+","+pj.getProj_noAL().get(k);
			}
%>
		 <a href="ProjInvestigation/preProj.jsp?prj = <%=proj_no%>&sect=<%=sectAL.get(i)%>&fltdt=<%=(String)fdateAL.get(i)%>&fltno=<%=fltnoAL.get(i)%>&proj_no=<%=proj_no.substring(1)%>&fleet=<%=pj.getFleet()%>&acno=<%=pj.getAcno()%>" target="_blank">
		 <img src="../images/ed1.gif" width="16" height="16" style="margin-right:1em;border:0pt; " alt="ProjInvestigation Request">		 </a>
<%
		}
		else
		{
%>
		 &nbsp;
<%
		}
	}
%>	</td>
	<!--Add-->
<td class="tablebody">
	<!--查核項目-->
<%
	//是否需填查核項目
	eg.flightcheckitem.CheckItemKeyValue ckKey = new eg.flightcheckitem.CheckItemKeyValue();
	ckKey.setFltd(fdate);
	ckKey.setFltno(fltno);
	ckKey.setSector(sect);
	ckKey.setPsrEmpn(sGetUsr);
	eg.flightcheckitem.CheckItemWithFlight ckhItemFlt = null;
	ArrayList al = null;
try
{
	ckhItemFlt = new eg.flightcheckitem.CheckItemWithFlight(ckKey);	
	al = ckhItemFlt.getChkItemAL();
}
catch(Exception e){}
finally{}

if(al != null)
{
	//已編輯過報告且已送出，不可再編輯  flag 代表有無報告
	if("Y".equals(flag) && "N".equals(updAL.get(i))) 	
	{
		for(int q=0;q<al.size();q++)
		{
			eg.flightcheckitem.CheckMainItemObj obj = (eg.flightcheckitem.CheckMainItemObj)al.get(q);
			if(obj.isHasCheckData())
			{
	%>
		<a href="chkItem/ViewChkItem.jsp?seqno=<%=obj.getSeqno()%>&checkRdSeq=<%=obj.getCheckRdSeq()%>&sector=<%=sectAL.get(i)%>&fltd=<%=(String)fdateAL.get(i)%>&fltno=<%=fltnoAL.get(i)%>&psrEmpn=<%=sGetUsr%>" target="_blank">
		<img src="../images/blue_view.gif" width="16" height="16" style="margin-right:1em;border:0pt; " alt="View Check Item "></a>
	<%
			}
		}
	}	
	else if("Y".equals(flag) && "Y".equals(updAL.get(i))) 
	{
	%>
		<img src="../images/pencil.gif" width="16" height="16" style="margin-right:1em;border:0pt; " alt="Check Item Request">
	<%
	}
	else
	{
	%>
		<img src="../images/ed1.gif" width="16" height="16" style="margin-right:1em;border:0pt; " alt="Check Item Request">
	<%
	}
}
else
{//if(al != null)
%>
		&nbsp;
<%
}
%></td>
<!--Add-->
</tr>
<%		
		}
	}
%>  
</table>

</div>
</body>
</html>
<%
}//end of else(有無資料）
}
catch (Exception e)
{	
	  out.print("error 2 : "+ e.toString());
}
finally
{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}

}
%>
