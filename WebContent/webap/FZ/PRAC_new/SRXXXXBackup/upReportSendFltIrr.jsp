<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="java.sql.*,fz.pracP.*,	fz.pracP.dispatch.*,ci.db.ConnDB,java.net.URLEncoder,ci.db.*, fz.psfly.*,fz.projectinvestigate.*"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
//座艙長報告--送出報告
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (sGetUsr == null) {		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} 
String purserEmpno	= request.getParameter("purserEmpno");
String psrsern		= request.getParameter("psrsern");
String fdate = request.getParameter("fltd");
String fltno = request.getParameter("fltno").trim();
String sect = request.getParameter("dpt").trim()+request.getParameter("arv").trim();
String sql = "SELECT Count(*) count FROM egtcflt WHERE   fltd = To_Date('"+ fdate+"','yyyy/mm/dd') "+
			"and fltno='"+fltno+"' and sect='"+sect+"'" ;


Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
ResultSet rs = null;
boolean t = false;
int rowCount = 0;
String fltd = null;
String newdate = null;

String goPage= "";
String GdYear = "";


//2006/02/15 新增：檢查是否輸入登機準時資訊(TEST)
//登機準時資訊
fz.pracP.BordingOnTime borot = new fz.pracP.BordingOnTime(fdate,fltno,sect,purserEmpno);
try {
	borot.SelectData();
//	System.out.println("是否有flight資料：" + borot.isHasFlightInfo());
//	System.out.println("是否有登機資料：" + borot.isHasBdotInfo());

} catch (SQLException e) {
	System.out.print(e.toString());
} catch (Exception e) {
	System.out.print(e.toString());
}

//檢查：是否有組員名單
fz.pracP.CheckFltData cflt = new fz.pracP.CheckFltData(fdate, fltno, sect,purserEmpno);
try {
	cflt.RetrieveData();
//	System.out.println("是否有flight 資料：" + cflt.isHasFltData());
	if ( cflt.isHasFltData() ) {
//		System.out.println("是否有Crew資料：" + cflt.isHasFltCrewData());
//		System.out.println("是否有登機準時資料：" + cflt.isHasBdotData());
//		System.out.println("是否可更新報告:" + cflt.isUpd());
	}
} catch (SQLException e) {
	System.out.println(e.toString());
} catch (Exception e) {
	System.out.println(e.toString());
}

//******************************************************************
//Check if need to fill PSFLY and Done
boolean needfill = true;
boolean chk_sfly_have_data  = false;
PRSFlyIssue psf = new PRSFlyIssue();
psf.getPsflyTopic_no(fdate, fltno, sect.substring(0,3), sect.substring(3),purserEmpno,"","") ;
if(psf.getTopic_noAL().size()>0)
{
	needfill = true;
}
else
{
	needfill = false;
}
CheckPSFLYData chksfly = new CheckPSFLYData(fdate,fltno, sect, purserEmpno);
chk_sfly_have_data = chksfly.hasData();
//******************************************************************
//******************************************************************
//Check if need to fill Project and Done 專案管理
boolean pjneedfill = false;
boolean chk_proj_have_data  = false;
PRPJIssue pj = new PRPJIssue();
pj.getPRProj_no(fdate, fltno, sect.substring(0,3), sect.substring(3),sGetUsr,"","") ;
//out.println(fdate+"  "+fltno+"  "+sect.substring(0,3)+"  "+sect.substring(3)+"  "+sGetUsr);
if(pj.getProj_noAL().size()>0)
{
	pjneedfill = true;
}
CheckProjData chkproj = new CheckProjData(fdate,fltno, sect, purserEmpno);
chk_proj_have_data = chkproj.hasData();
//******************************************************************
//彈派處理
boolean iflessdisp_pass = false;
boolean iflessdisp = true;
String tempfltno = "";
String tempfleet = "";
String lessdispstr = "";
if(fltno.length()>= 4)
{
	tempfltno = fltno.substring(1,4);
}
else
{
	tempfltno = fltno;
}
FlexibleDispatch fd = new FlexibleDispatch();
iflessdisp = fd.ifFlexibleDispatch(fdate,fltno,sect,sGetUsr);
tempfleet = fd.getFleetCd();
if(iflessdisp == false)
{
	iflessdisp_pass = true;
}
else //if(iflessdisp == true)
{
	//get pax 人數
	int pax_count = fd.getPaxCount(fdate, fltno, sect); 
	//get 彈派人數
	int disp_count = fd.getFlexibleNum(fltno, tempfleet, sect, pax_count) ;
	//get ACM 人數
	int acm_count = fd.getACMCount(fdate, fltno, sect) ;
	if(disp_count <= acm_count | pax_count <=0 )
	{
		iflessdisp_pass = true;
	}
	else //if(disp_count != acm_count )
	{
		int i13_count  = fd.getI13Count(fdate, fltno, sect) ;
		if(i13_count>0)
		{
			iflessdisp_pass = true;
		}
	}
}
//******************************************************************

//若無輸入登機資料，不得送出報告!!
if( !borot.isHasBdotInfo()){//無登機資料
%>
<script language="javascript" type="text/javascript">
alert("尚未輸入Crew Boarding On time資訊,不得送出報告!!\n請於Flt Irregularity輸入!!");
self.location = "PRSel.jsp";
</script>
<%
}
else if(!cflt.isHasFltCrewData())
{
String goToPage= "flightcrew.jsp?fyy="+fdate.substring(0,4)+"&fmm="+fdate.substring(5,7)+"&fdd="+
			fdate.substring(8)+"&fltno="+fltno+"&GdYear="+GdYear+"&acno=null";
%>
<script language="javascript" type="text/javascript">
alert("尚未編輯組員考評,不得送出報告!!\n");
self.location = "<%=goToPage%>";
</script>
<%
}
else if(needfill == true && chk_sfly_have_data == false) 
{
String goToPage= "RepostList.jsp?yy="+fdate.substring(0,4)+"&mm="+fdate.substring(5,7);
%>
<script language="javascript" type="text/javascript">
alert("尚未填寫座艙長自我督察報告,不得送出!!\n");
self.location = "<%=goToPage%>";
</script>
<%
}
else if(pjneedfill == true && chk_proj_have_data == false) 
{//專案調查
String goToPage= "RepostList.jsp?yy="+fdate.substring(0,4)+"&mm="+fdate.substring(5,7);
%>
<script language="javascript" type="text/javascript">
alert("尚未填寫座艙長專案調查報告,不得送出!!\n");
self.location = "<%=goToPage%>";
</script>
<%
}
else if (iflessdisp_pass == false)
{
String goToPage= "RepostList.jsp?yy="+fdate.substring(0,4)+"&mm="+fdate.substring(5,7);
%>
<script language="javascript" type="text/javascript">
alert("彈派人數不正確,請確認,或於<Flt Irregularity>中註明原因!!\n");
self.location = "<%=goToPage%>";
</script>
<%
}
else
{
try
{
ConnDB cn = new ConnDB();
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);

stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
		ResultSet.CONCUR_READ_ONLY); 
rs = stmt.executeQuery(sql);//查詢是否已經有資料，若有，則送出報告...若無，則回到 flightcrew.jsp
while(rs.next())
{
	rowCount = rs.getInt("count");
}
rs.close();

if(rowCount != 0)
{//egtcflt 中已有報告紀錄，則送出
//out.print("有報告紀錄");

	sql = "update egtcflt set upd='N', reject=null, reject_dt=null where fltd=to_date('"+ fdate +
		  "','yyyy/mm/dd') and fltno='"+ fltno +"' and sect ='"+ sect +"'" ;
				
	stmt.executeUpdate(sql);//將upd設為N

//Modified by cs66 at 2005/01/03: gdYear不加1000
	
/*				
	//∵報告尚未正式送出前，gdyear in egtgddt 為原本的的gdyear+1000		，所以此處要減回去	
	sql ="UPDATE egtgddt SET gdyear=to_char(to_number(gdyear)-1000) "+
					"WHERE fltd=to_date('"+ fdate+"','yyyy/mm/dd') "+
					"AND fltno='"+fltno.trim() +"' AND sect='"+sect.trim()+"' ";
					
			
	stmt.executeQuery(sql);//設定gdyear
*/	
	//判斷egtcrpt是否有記錄, 有-->update, 無-->insert
rs = stmt.executeQuery("select fltd, newdate from egtcrpt where fltd=to_date('"+ fdate +"','yyyy/mm/dd') and fltno='"+fltno+"' and sect='"+ sect +"' ");
while(rs.next())
{
	fltd = rs.getString("fltd");
	newdate = rs.getString("newdate");
}

rs.close();
//取得trip_num
String trip_num = "null";
rs = stmt.executeQuery("select dps.trip_num "
	   +"from egdb.duty_prd_seg_v dps, egdb.roster_v r where dps.series_num=r.series_num  "
	   +"  and dps.delete_ind = 'N' AND  r.delete_ind='N' "
	   +" and r.staff_num ='"+purserEmpno+"' AND dps.act_str_dt_tm_gmt BETWEEN  "
	   +" to_date('"+fdate.substring(0,7)+"01 00:00','yyyy/mmdd hh24:mi') AND "
	   +" Last_Day( To_Date('"+fdate.substring(0,7)+"01 23:59','yyyy/mmdd hh24:mi'))  "
	   +" AND r.duty_cd='FLY' AND dps.duty_cd IN ('FLY','TVL') AND  r.acting_rank='PR'  "
	   +" AND dps.flt_num='"+fltno+"' AND dps.port_a||dps.port_b='"+sect+"' "
	   +" AND   dps.str_dt_tm_loc    BETWEEN  "
	   +" to_date('"+fdate+" 0000','yyyy/mm/dd hh24mi')  "
	   +" AND To_Date('"+fdate+" 2359','yyyy/mm/dd hh24mi')");

while(rs.next())
{
	trip_num = "'"+rs.getString("trip_num")+"'";
}

rs.close();




//out.println(ct);
if(fltd == null)
{
	sql = "insert into egtcrpt(fltd,fltno,sect,empno,chguser,chgdate,flag,caseclose,newdate,trip_num) "
		+"values(to_date('"+ fdate +"','yyyy/mm/dd'),'"+fltno+"','"+sect+"','"+sGetUsr+"','"+sGetUsr+
		"',sysdate,'Y',null,sysdate,"+trip_num+")";
}
else
{
	if(newdate == null)
	{
		sql = "update egtcrpt set flag='Y',empno='"+sGetUsr+"',chguser='"+sGetUsr+"' ,chgdate=sysdate,newdate=sysdate,caseclose='N' "+
		   	  "where fltd=to_date('"+ fdate + "','yyyy/mm/dd') and fltno='"+fltno+"' and sect='"+ sect +"' ";
	}
	else
	{
		sql = "update egtcrpt set flag='Y',empno='"+sGetUsr+"',chguser='"+sGetUsr+"' ,chgdate=sysdate,caseclose='N' "+
		   	  "where fltd=to_date('"+ fdate + "','yyyy/mm/dd') and fltno='"+fltno+"' and sect='"+ sect +"' ";
	}
}
//out.println(sql);
/*	sql = "update egtcrpt set flag='Y',empno='"+sGetUsr+"',chguser='"+sGetUsr+"' ,chgdate=sysdate "+
		   "where fltd=to_date('"+ fdate +"','yyyy/mm/dd') "+
		  " and fltno='"+fltno.trim()+"' and sect='"+ sect.trim() +"' ";*/
	
	stmt.executeUpdate(sql);	  

}else{	//無報告紀錄，到flightcrew，傳遞參數：fyy,fnn,fdd,fltno,GdYear,acno
//out.print("No");


	//11~12月的航班，考績年度為下一個年度
   if(fdate.substring(5,7).equals("11") ||fdate.substring(5,7).equals("12")){	
		GdYear =(Integer.toString((Integer.parseInt(fdate.substring(0,4))+1) ));
	}
	else{
		GdYear = fdate.substring(0,4);
	}
	goPage = "flightcrew.jsp?fyy="+fdate.substring(0,4)+"&fmm="+fdate.substring(5,7)+"&fdd="+
			fdate.substring(8)+"&fltno="+fltno+"&GdYear="+GdYear+"&acno=null";

}

}
catch (Exception e)
{
	  t = true;
 System.out.print("ReportSend ERROR:"+e.toString()+"<BR>"+sql);
//		  response.sendRedirect("../showmessage.jsp?messagestring="+URLEncoder.encode("系統忙碌中，請稍後再試"));
}
finally
{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Send Report(送出報告)</title>
<link href="style2.css" rel="stylesheet" type="text/css">

</head>
<body>

<%
if(t){
	  response.sendRedirect("../showmessage.jsp?messagestring="+URLEncoder.encode("系統忙碌中，請稍後再試"));	
}else{
%>
<div align="center">

  <span class="purple_txt"><strong>報告已成功送出!!!<br>
  <br>
Send Report Success!!
<br>
<br>
</strong></span><span class="red12"><strong>報告一經送出，即不得更改。
</strong></span></div>
<script>
<%
if(!goPage.equals("")){//egtcflt中尚未有紀錄....轉頁至flightcrew，輸入PartI  Report
	out.print("alert('報告尚未填寫完畢，不得送出!!\\n\\n請按「確定」輸入PartI Report');"+
			"self.location='"+ goPage+"';");
}
else{//egtcflt中已經有紀錄....
%>
alert("報告已經送出!!");
<%
}
%>
</script>
<%
}
%>
</body>
</html>
<%
}//end of check 是否有登機準時資料
%>