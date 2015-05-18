<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,java.util.*,java.text.*,ci.db.*" %>
<jsp:useBean id="SB" class="fz.countSBcrew" />
<jsp:useBean id="acci" class="fz.countACshow" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
/*
String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first
	response.sendRedirect("../sendredirect.jsp");
} 
*/
%>
<%
String currDt, strDt, endDt;
int pastHr, futureHr;

SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HHmm");
Calendar cal = new GregorianCalendar();
cal.setTime(new java.util.Date()); 

// now=10:43 ==> 09:43~00:43 
if (request.getParameter("pastHr") == null) pastHr = 1; 
else pastHr = Integer.parseInt(request.getParameter("pastHr"));

if (request.getParameter("futureHr") == null) {
   futureHr = 24 - (int) cal.get(Calendar.HOUR_OF_DAY); 
   if (futureHr == 1)  futureHr = 3; //for midnight arrival crew
   //if (futureHr < 6)  futureHr = 12; //for ext.4000 check tomorrow car
}else{
   futureHr = Integer.parseInt(request.getParameter("futureHr"));
}

cal.add(Calendar.HOUR, -1 * pastHr); 
strDt = sdf.format(cal.getTime());
cal.add(Calendar.HOUR, futureHr+1);
endDt = sdf.format(cal.getTime());

//request.getParameter("fltdate");
String fltdate 	="2010/01/13";
String showDate = "";
String sect_in = "";
String fltno_in	= "";
String status = "dt"; //TPE departure
//String fullUCD = "cabinCrew";

//檢查班表是否公布
//swap3ac.PublishCheck pc = new swap3ac.PublishCheck(request.getParameter("yy"), request.getParameter("mm"));
//swap3ac.PublishCheck pc = new swap3ac.PublishCheck(fltdate.substring(0,4), fltdate.substring(5,7));

//if((!"190A".equals(fullUCD) && !"068D".equals(fullUCD))	&& !pc.isPublished()){
//非航務、空服簽派者，才檢查班表是否公佈
if (false){
   %><!-- <div style="background-color:#99FFFF;text-align:center;color:#FF0000;font-family:Verdana;font-size:10pt; "><%//=showDate%>班表尚未正式公佈!! </div> --> <%
}else{
boolean statusDB = false;
String errMsg = "";
String fltnoCondition = "";
String fltnoCondition2 = "";
String sectCondition = "";
String sectCondition2 = "";
String acchk = null; //add by cs55 2006/10/31

if(!fltno_in.equals("")){
	if(fltno_in.length() <= 4){
		fltnoCondition = " and flt_num =lpad('"+ fltno_in +"',4,'0') ";
		fltnoCondition2 = " and d.flt_num =lpad('"+ fltno_in +"',4,'0') ";
	}
	else{
		fltnoCondition = " and flt_num ='"+ fltno_in +"' ";
		fltnoCondition2 = " and d.flt_num ='"+ fltno_in +"' ";
	}
}

 if(!sect_in.equals("")){
	sectCondition = " and port_a||port_b ='"+sect_in+"' ";
	sectCondition2 = " and d.port_a||d.port_b ='"+sect_in+"' ";
}
 if(status.equals("dt")){
	sectCondition += " and port_a ='TPE' ";
	sectCondition2 += " and d.port_a ='TPE' ";
	sect_in = "TPE Departure";
}
else if(status.equals("at")){
	sectCondition += " and port_b ='TPE' ";
	sectCondition2 += " and d.port_b ='TPE' ";	
	sect_in = "TPE Arrival";
	
}else if(status.equals("dk")){
	sectCondition += " and port_a ='KHH' ";
	sectCondition2 += " and d.port_a ='KHH' ";	
	sect_in = "KHH Departure";
	
}else if(status.equals("ak")){
	sectCondition += " and port_b ='KHH' ";
	sectCondition2 += " and d.port_b ='KHH' ";
	sect_in = "KHH Arrival";
}

else if(status.equals("db")){
	sectCondition += " and port_a ='BKK' ";
	sectCondition2 += " and d.port_a ='BKK' ";
	sect_in = "BKK Departure";
	
}else if(status.equals("ab")){
	sectCondition = " and port_b ='BKK' ";
	sectCondition2 = " and d.port_b ='BKK' ";
	sect_in = "BKK Arrival";
}

else if(status.equals("ds")){
	sectCondition += " and port_a ='SGN' ";
	sectCondition2 += " and d.port_a ='SGN' ";
	sect_in = "SGN Departure";
}else if(status.equals("as")){
	sectCondition += " and port_b ='SGN' ";
	sectCondition2 += " and d.port_b ='SGN' ";
	sect_in = "SGN Arrival";
}

else if(status.equals("dj")){
	sectCondition += " and port_a ='NRT' ";
	sectCondition2 += " and d.port_a ='NRT' ";
	sect_in = "NRT Departure";
}else if(status.equals("aj")){
	sectCondition += " and port_b ='NRT' ";
	sectCondition2 += " and d.port_b ='NRT' ";
	sect_in = "NRT Arrival";
}

else if(status.equals("di")){
	sectCondition += " and port_a ='SIN' ";
	sectCondition2 += " and d.port_a ='SIN' ";
	sect_in = "SIN Departure";
}else if(status.equals("ai")){
	sectCondition += " and port_b ='SIN' ";
	sectCondition2 += " and d.port_b ='SIN' ";
	sect_in = "SIN Arrival";
}

Driver dbDriver = null;
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
boolean t = false;
String  sql = null;
int Count = 0;
String bgColor = null;
String rpt_time = null;
String dpt_port = null;
//add by cs55 2006/11/28
int cnt_flt = 0;
int cnt_checkin = 0;
int cnt_open = 0;
//end add 2006/11/28

ConnDB cn = new ConnDB();
ArrayList al = new ArrayList();
boolean hasOpen = false;//任何一班有Open
StringBuffer sqlSB  = new StringBuffer();
try{
	cn.setAOCIPRODCP();
	//cn.setORP3FZUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
	
//*****************************************************
sqlSB.append("select (case when d2.tod_start_loc_ds is not null then to_Char(d2.tod_start_loc_ds,'yyyy/mm/dd HH24MI') else '' end) erpt,");
sqlSB.append("To_Char(d.str_dt_tm_gmt,'yyyy/mm/dd HH24MI') str_dt_tm_gmt,");
sqlSB.append("To_Char(d.act_str_dt_tm_gmt,'mm/dd HH24MI') str_dt_tpe,");
sqlSB.append("To_Char(d.end_dt_tm_gmt,'mm/dd HH24MI') end_dt_tpe, d.flt_num, d.fleet_cd,");
sqlSB.append("d.port_a||d.port_b sect, to_char(d.str_dt_tm_loc,'mm/dd HH24MI') str_dt_loc,");
sqlSB.append("To_Char(d.end_dt_tm_loc,'mm/dd HH24MI') end_dt_loc, d.duty_cd   , d.arln_cd ");
sqlSB.append("FROM duty_prd_seg_v d  ,");
sqlSB.append(" ( SELECT tod_start_loc_ds,str_dt_tm_gmt, act_str_dt_tm_gmt,end_dt_tm_gmt,flt_num,fleet_cd,");
sqlSB.append("   str_dt_tm_loc,end_dt_tm_loc,duty_cd,port_a,port_b,rescheduled_flt_dt_tm, arln_cd ");
sqlSB.append("   FROM  duty_prd_seg_v  ");
sqlSB.append("   WHERE duty_seq_num=1  AND item_seq_num=1 ");
sqlSB.append("   AND delete_ind='N' AND  fd_ind='N' AND duty_cd in ( 'FLY','TVL') ");
sqlSB.append("   AND duty_cd in ( 'FLY','TVL') ");
sqlSB.append("   AND END_dt_tm_loc ");
sqlSB.append("   BETWEEN To_Date(?,'yyyy/mm/dd hh24mi') ");
sqlSB.append("   AND    (To_Date(?,'yyyy/mm/dd hh24mi') + 1) ");
sqlSB.append("   AND act_str_dt_tm_gmt ");
sqlSB.append("   BETWEEN To_Date(?,'yyyy/mm/dd hh24mi') ");
sqlSB.append("   AND     To_Date(?,'yyyy/mm/dd hh24mi') ");
sqlSB.append("   AND delete_ind='N' ");
sqlSB.append("  AND fd_ind='N' ");
sqlSB.append( fltnoCondition + sectCondition );
sqlSB.append("GROUP  BY str_dt_tm_gmt, act_str_dt_tm_gmt,end_dt_tm_gmt,flt_num,fleet_cd, ");
sqlSB.append("str_dt_tm_loc,end_dt_tm_loc,duty_cd,port_a,port_b,rescheduled_flt_dt_tm, ");
sqlSB.append("arln_cd ,tod_start_loc_ds ");
sqlSB.append("  ) d2 ");
sqlSB.append("WHERE d.str_dt_tm_gmt = d2.str_dt_tm_gmt(+) ");
sqlSB.append("  AND d.act_str_dt_tm_gmt =d2.act_str_dt_tm_gmt(+) ");
sqlSB.append("  AND d.flt_num = d2.flt_num(+) ");
sqlSB.append("  AND d.duty_cd = d2.duty_cd(+) ");
sqlSB.append("  AND d.port_a = d2.port_a(+) ");
sqlSB.append("  AND d.port_b = d2.port_b(+) ");
sqlSB.append("  AND d.arln_cd = d2.arln_cd(+) ");
sqlSB.append("  AND  d.duty_cd in ( 'FLY','TVL') ");
sqlSB.append("  AND  d.END_dt_tm_loc ");
sqlSB.append("  BETWEEN To_Date(?,'yyyy/mm/dd hh24mi') ");
sqlSB.append("  AND    (To_Date(?,'yyyy/mm/dd hh24mi') + 1) ");
sqlSB.append("  AND d.act_str_dt_tm_gmt ");
sqlSB.append("  BETWEEN To_Date(?,'yyyy/mm/dd hh24mi') ");
sqlSB.append("  AND     To_Date(?,'yyyy/mm/dd hh24mi') ");
sqlSB.append("  AND d.delete_ind='N' ");
sqlSB.append("  AND d.fd_ind='N' ");
sqlSB.append("  AND d.duty_cd='FLY' "); //avoid dupe flt
sqlSB.append( fltnoCondition2 + sectCondition2 );
sqlSB.append("GROUP  BY d.str_dt_tm_gmt, d.act_str_dt_tm_gmt,d.end_dt_tm_gmt,d.flt_num,d.fleet_cd,");
sqlSB.append(" d.str_dt_tm_loc,d.end_dt_tm_loc,d.duty_cd,d.port_a,d.port_b,");
sqlSB.append("d.rescheduled_flt_dt_tm, d.arln_cd ,d2.tod_start_loc_ds ");
sqlSB.append("ORDER BY erpt, d.duty_cd"); 

//***********	 
//out.println(sql);
pstmt = conn.prepareStatement(sqlSB.toString());
for(int i=1;i<9;i=i+2){
	//pstmt.setString(i,fltdate+" 0000");
	//pstmt.setString(i+1,fltdate+" 2359");	
	pstmt.setString(i, strDt); 
	pstmt.setString(i+1, endDt); 
}
//out.print(strDt+" "+endDt);
rs = pstmt.executeQuery();
while(rs.next()){
	fzac.DailyCheckObj obj = new fzac.DailyCheckObj();
	obj.setSch(rs.getString("str_dt_tm_gmt"));
	obj.setStLoc(rs.getString("str_dt_loc"));
	obj.setStTPE(rs.getString("str_dt_tpe"));
	obj.setEdLoc(rs.getString("end_dt_loc"));
	obj.setEdTPE(rs.getString("end_dt_tpe"));
	obj.setERpt(rs.getString("erpt"));
	obj.setFleet(rs.getString("fleet_cd"));		
	obj.setFleet_cd(rs.getString("fleet_cd"));
	obj.setDuty_cd(rs.getString("duty_cd"));
	obj.setArln_cd(rs.getString("arln_cd"));
	//if("0605".equals(rs.getString("flt_num"))) out.print("*");
	if("0".equals(rs.getString("flt_num"))){
		obj.setFltno(rs.getString("duty_cd"));
	}else{
		obj.setFltno(rs.getString("flt_num"));
	}	
	
	if("TVL".equals(rs.getString("duty_cd"))){
		obj.setRmk("TVL");
	}else{
		obj.setRmk("&nbsp;");
	}	
	
	obj.setSect(rs.getString("sect"));
	al.add(obj);
}
rs.close();
pstmt.close();

/*
//add by cs55 2006/11/28
sqlSB = new StringBuffer();
sqlSB.append("select count(*) from (select distinct act_str_dt_tm_gmt, flt_num, port_a||port_b sect ");
sqlSB.append("from duty_prd_seg_v " );
sqlSB.append("where duty_cd in ( 'FLY','TVL') and ");
sqlSB.append("str_dt_tm_loc BETWEEN To_Date(?,'yyyy/mm/dd hh24mi') " );
sqlSB.append("and  To_Date(?,'yyyy/mm/dd hh24mi') ");
sqlSB.append(fltnoCondition + sectCondition );
sqlSB.append(" and act_str_dt_tm_gmt BETWEEN (To_Date(?,'yyyy/mm/dd hh24mi') - 2) and (To_Date(?,'yyyy/mm/dd hh24mi') + 2) ");
sqlSB.append(" and delete_ind='N' and fd_ind='N' and port_a <> port_b) ");
//out.println(sql);
pstmt = conn.prepareStatement(sqlSB.toString());
for(int i=1;i<5;i=i+2){
	//pstmt.setString(i,fltdate+" 0000");
	//pstmt.setString(i+1,fltdate+" 2359");
	pstmt.setString(i, strDt);
	pstmt.setString(i+1, endDt);
}

rs = pstmt.executeQuery();
if(rs.next()) cnt_flt = rs.getInt(1);
rs.close();
pstmt.close();
conn.close();
//end add 2006/11/28
*/

//建明接車時間
cn.setORP3FZUserCP();	
conn = dbDriver.connect(cn.getConnURL(), null);
ArrayList alTmp = new ArrayList();

pstmt = conn.prepareStatement("SELECT fltno,sect,To_Char(tsa_dt,'mm/dd hh24mi') rptR "
+"FROM fztflin WHERE fltd BETWEEN To_Date(?,'yyyy/mm/dd hh24mi') "
+"AND to_Date(?,'yyyy/mm/dd hh24mi')");

//pstmt.setString(1,fltdate+" 0000");
//pstmt.setString(2,fltdate+" 2359");
pstmt.setString(1, strDt.substring(0,10)+" 0000"); 
pstmt.setString(2, strDt.substring(0,10)+" 2359"); //cs40 2010-11-04, endDt-->strDt

rs = pstmt.executeQuery();
while(rs.next()){
	fzac.DailyCheckObj obj = new fzac.DailyCheckObj();
	obj.setFltno(rs.getString("fltno"));
	obj.setSect(rs.getString("sect"));
	obj.setRRpt(rs.getString("rptR"));
	//if (rs.getString("fltno").equals("0160")) out.print("~~~~"+rs.getString("rptR"));
	alTmp.add(obj);
}
pstmt.close();
rs.close();
conn.close();

//match 班表與 建明接車時間
for(int i=0;i<al.size();i++){
	fzac.DailyCheckObj obj = (fzac.DailyCheckObj)al.get(i);
	
	for(int idx=0;idx<alTmp.size();idx++){
		fzac.DailyCheckObj obj2 = ( fzac.DailyCheckObj)alTmp.get(idx);
		//if(obj.getFltno().equals("0065")) out.print("-");
		//if(obj2.getFltno().equals("0065")) out.print("=");
		if(obj.getFltno().equals(obj2.getFltno()) 
			&& obj.getSect().equals(obj2.getSect())  ){
			obj.setRRpt(obj2.getRRpt());
		}
	}	
}
/*
//取得OPEN 組員
cn.setAOCIPRODCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
sqlSB = new StringBuffer();
sqlSB.append("SELECT  flt_num,act_port_a,act_port_b , to_char(act_str_dt_tm_gmt,'mm/dd HH24MI') str_dt_tpe, ");
sqlSB.append("sum(cc1_num_pln-cc1_num_fil) cc1,sum(cc2_num_pln-cc2_num_fil) cc2, ");
sqlSB.append("sum(cc3_num_pln-cc3_num_fil) cc3,sum(cc4_num_pln-cc4_num_fil) cc4, ");
sqlSB.append("sum(cc5_num_pln-cc5_num_fil) cc5,sum(cc6_num_pln-cc6_num_fil) cc6, ");
sqlSB.append("sum(cc7_num_pln-cc7_num_fil) cc7, ");
sqlSB.append("sum(cc1_num_pln+cc2_num_pln+cc3_num_pln+cc4_num_pln+cc5_num_pln+cc6_num_pln+cc7_num_pln) total_pln, ");
sqlSB.append("sum(cc1_num_fil+cc2_num_fil+cc3_num_fil+cc4_num_fil+cc5_num_fil+cc6_num_fil+cc7_num_fil) total_fil, ");
sqlSB.append("( sum(cc1_num_pln+cc2_num_pln+cc3_num_pln+cc4_num_pln+cc5_num_pln+cc6_num_pln+cc7_num_pln) ");
sqlSB.append("-sum(cc1_num_fil+cc2_num_fil+cc3_num_fil+cc4_num_fil+cc5_num_fil+cc6_num_fil+cc7_num_fil)) total_Open ");
sqlSB.append("FROM duty_prd_seg_v ");
sqlSB.append("WHERE delete_ind='N' ");
sqlSB.append("AND duty_cd IN ('FLY','TVL') ");
sqlSB.append("AND str_dt_tm_loc BETWEEN To_Date(?,'yyyy/mm/dd hh24mi') ");
sqlSB.append(" AND To_Date(?,'yyyy/mm/dd hh24mi') ");
sqlSB.append(" AND act_str_dt_tm_gmt BETWEEN (To_Date(?,'yyyy/mm/dd hh24mi') - 2) and (To_Date(?,'yyyy/mm/dd hh24mi') + 2) " );
sqlSB.append("GROUP BY flt_num,act_port_a,act_port_b ,act_str_dt_tm_gmt");	

pstmt = conn.prepareStatement(sqlSB.toString());

//pstmt.setString(1,fltdate+" 0000");
//pstmt.setString(2,fltdate+" 2359");
//pstmt.setString(3,fltdate+" 0000");
//pstmt.setString(4,fltdate+" 2359");
pstmt.setString(1, strDt);
pstmt.setString(2, endDt);
pstmt.setString(3, strDt);
pstmt.setString(4, endDt);

rs = pstmt.executeQuery();

alTmp = new ArrayList();
while(rs.next()){
	fzac.DailyCheckObj obj = new fzac.DailyCheckObj();
	obj.setFltno(rs.getString("FLT_NUM"));
	obj.setStTPE(rs.getString("str_dt_tpe"));
	obj.setSect(rs.getString("act_port_a")+rs.getString("act_port_b"));
	obj.setOpenCC1(rs.getInt("cc1"));
	obj.setOpenCC2(rs.getInt("cc2"));
	obj.setOpenCC3(rs.getInt("cc3"));
	obj.setOpenCC4(rs.getInt("cc4"));
	obj.setOpenCC5(rs.getInt("cc5"));
	obj.setOpenCC6(rs.getInt("cc6"));
	obj.setOpenCC7(rs.getInt("cc7"));
	obj.setTotalFil(rs.getInt("total_fil"));
	obj.setTotalOpen(rs.getInt("total_Open"));
	obj.setTotalPln(rs.getInt("total_pln"));

	alTmp.add(obj);
}

pstmt.close();
rs.close();
conn.close();

//將open value 存入物件

for(int i=0;i<al.size();i++){
	fzac.DailyCheckObj obj = (fzac.DailyCheckObj)al.get(i);
	
	for(int idx=0;idx<alTmp.size();idx++){
		fzac.DailyCheckObj obj2 = ( fzac.DailyCheckObj)alTmp.get(idx);
		
		if(obj.getFltno().equals(obj2.getFltno()) 
			&& obj.getStTPE().equals(obj2.getStTPE()) 
			&& obj.getSect().equals(obj2.getSect())){
			obj.setOpenCC1(obj2.getOpenCC1());
			obj.setOpenCC2(obj2.getOpenCC2());
			obj.setOpenCC3(obj2.getOpenCC3());
			obj.setOpenCC4(obj2.getOpenCC4());
			obj.setOpenCC5(obj2.getOpenCC5());
			obj.setOpenCC6(obj2.getOpenCC6());
			obj.setOpenCC7(obj2.getOpenCC7());
			obj.setTotalFil(obj2.getTotalFil());
			obj.setTotalOpen(obj2.getTotalOpen());
			obj.setTotalPln(obj2.getTotalPln());
			if(obj2.getTotalOpen() > 0){
				hasOpen= true;
			}
		}
	}	
}
*/
statusDB = true;
}catch (SQLException e){
	errMsg = e.toString();
}catch (Exception e){
	errMsg = e.toString();
}finally{
	try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}

%>
<html>
<head>
<meta http-equiv="refresh" content="120;url=showDailyRPT.jsp">
<title>TPE Departure Flights List</title>
<link href="../../menu.css" rel="stylesheet" type="text/css">
<link href="../../menu.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="../../errStyle.css">
<script src="../../js/subWindow.js"></script>
<script language="javascript">
var currentMenu = 0;						//宣告目前展開的目錄變數

function ShowSubMenu(id) {					//啟動函式時,會取得目前的目錄編號
  if (document.getElementById("SubMenu" + id).style.display == "") 	//判別動作目錄的子目錄是否已顯示
  {
     document.getElementById("SubMenu" + id).style.display = "none";	//若已動作則隱藏該子目錄
	document.getElementById("pic" + id).innerHTML="<img height=\"15\" src=\"../../images/plus.gif\" width=\"15\" border=\"0\">";
     currentMenu = 0; 						//設定已展開的目錄為無
  }
  else 								//如果目前的目錄並未展開則判斷是否有展開的目錄
  {
     //如果已有展開的目錄的話,則隱藏該展開的目錄
     //if (currentMenu != 0) {document.all["SubMenu" + currentMenu].style.display = "none";}  
     document.getElementById("SubMenu" + id).style.display = "";		//展開目前要動作的目錄
	document.getElementById("pic" + id).innerHTML="<img src=\"../../images/minus.gif\"  height=\"15\"  width=\"15\" border=\"0\">";	 
     currentMenu = id;						//設定己展開的目錄為目前動作的目錄編號
  }
}

<% 
if(hasOpen){//至少有一筆Open > 0,才有此function

 %>
function expA(a){
<%
	for(int i=0;i<al.size();i++){
		fzac.DailyCheckObj obj = ( fzac.DailyCheckObj)al.get(i);
		if(obj.getTotalOpen() > 0){
		%>
		if(a == "1"){//展開全部
			document.getElementById("SubMenu<%=i%>").style.display = "";
			document.getElementById("pic<%=i%>").innerHTML="<img src=\"../../images/minus.gif\"  height=\"15\"  width=\"15\" border=\"0\">";	 
		}else{//收起全部
			document.getElementById("SubMenu<%=i%>").style.display = "none";
			document.getElementById("pic<%=i%>").innerHTML="<img height=\"15\" src=\"../../images/plus.gif\" width=\"15\" border=\"0\">";
		}
		<%
		}
	}
%>	
if(a == "1"){ //原本是展開,頁面顯示Collapse all,執行expA(2)
	document.getElementById("e").innerHTML = "<a href=\"javascript:expA(2)\">Collapse all "
				+"<img  src=\"../../images/minus.gif\"  border=\"0\"></a>";

}else{	//原本是關閉,頁面顯示Expand all,執行expA(1)
	document.getElementById("e").innerHTML = "<a href=\"javascript:expA(1)\">Expand all "
				+"<img height=\"16\" src=\"../../images/plus.gif\" width=\"19\" border=\"0\"></a>";
}


}
<%}%>
</script>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<style type="text/css">
<!--
.style1 {
	font-family: Verdana;
	font-size: small;
	color: #FF0000;
}
-->
</style>
</head>

<body>
<p>
<%
if(!statusDB){
	out.print("<div class=\"errStyle1\">"+errMsg+"</div>");
}else{


if(al.size() > 0){
%>
<div align="right">
  <table width="95%"  border="0" align="center" cellpadding="2" cellspacing="0" >
    <tr>
      <td width="95%">
       <p align="center">
<span class="txttitletop"><%=sect_in%>&nbsp; <%//=fltdate%>
          Flights List</span><br><span class="style1">Updated time:  <%=new java.text.SimpleDateFormat("yyyy/MM/dd hh:mm:ss a").format(new java.util.Date())%></span></p>

      </td>
      <td width="11%">
	  <% 
	  if(hasOpen){//至少有一筆Open > 0,才顯示Expand/Collapse
	  
	   %>


	  <%
	  }	//end of has open
	  
	  %>
	  </td>
      <td width="4%"></td>
    </tr>
  </table>
  
</div>
<table width="40%"  border="0" align="center" cellpadding="0" cellspacing="0" class="fortable">
  <tr class="tablehead3"> 
    <td>Flight no.</td>
    <td >Sector</td>
	<td>Actual Report(e-go)</td>
  </tr>
  <%
	for(int i=0;i<al.size();i++){
		fzac.DailyCheckObj obj = ( fzac.DailyCheckObj)al.get(i);
		rpt_time = obj.getERpt();
		dpt_port = obj.getSect().substring(0, 3);
			if (i%2 == 0){
				bgColor = "#99CCFF"; // "#C9C9C9";
			}else{
				bgColor = "#FFFFFF";
			}

%>
  <tr bgcolor="<%=bgColor%>" class="txtred"> 
    <td> <%
 if(obj.getTotalOpen() == 0){
 //無open ,totalOpen=N
	%> <div align="center">
	<%=obj.getFltno()%>
	</div>
      <%
	  }else{	//將open人數傳到下一頁,totalOpen=Y
	  %> <div align="center">
	  <%=obj.getFltno()%>
	  </div>
      <%	  
	  }	  
	  %> </td>
    <td> <div align="center"><%=obj.getSect().substring(0,3) + "-"+obj.getSect().substring(3,6)%></div></td>
	<% // rpt_time may be null while obj.getERpt()
	//if (rpt_time != null) {
	//   rpt_time = rpt_time.substring(5,10)+ " " +rpt_time.substring(11,13)+ ":"+rpt_time.substring(13,15); 
	//}//if	
	%>
	<td> <div align="center"><%=obj.getRRpt()%></div></td>
  </tr>
  <%
		  if(obj.getTotalOpen() > 0){
	%>
  <%
  		}//end of has open
	}
  
  %>
</table>
<br>


 
</p>

<%
}else{
	out.print("<div class=\"errStyle1\">NO DATA!!!</div>");
}

}//end of statusDB is true
}
%>
</body>
</html>