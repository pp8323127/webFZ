<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*,fz.pracP.*, fz.pracP.dispatch.*" %>
<%!
public class CrewListObj {
	private String startDate;
	private String endDate;
	private String fltno;
	private String sector;
	private String fleet;
	private String empno;
	private String cname;
	private String ename;
	private String serno="";
	private String qual;
	private String spcode;
	private String grp;
	private String acm;
	private String meal;
	private String series_num;
	private String act_str_dt_tm_gmt;//format: yyyymmdd hh24mi
	private String lastFlight;
	private String rptLoc= "";
	private String isCheckIn = "";
	private String cr = "";
	private String priority = "";
	
	public String getIsCheckIn() {
		return isCheckIn;
	}
	public void setIsCheckIn(String isCheckIn) {
		this.isCheckIn = isCheckIn;
	}
	public String getRptLoc() {
		return rptLoc;
	}
	public void setRptLoc(String rptLoc) {
		this.rptLoc = rptLoc;
	}
	public String getLastFlight() {
		return lastFlight;
	}
	public void setLastFlight(String lastFlight) {
		this.lastFlight = lastFlight;
	}
	
	public String getAct_str_dt_tm_gmt() {
		return act_str_dt_tm_gmt;
	}
	public void setAct_str_dt_tm_gmt(String act_str_dt_tm_gmt) {
		this.act_str_dt_tm_gmt = act_str_dt_tm_gmt;
	}
	public String getSeries_num() {
		return series_num;
	}
	public void setSeries_num(String series_num) {
		this.series_num = series_num;
	}
	
	public String getMeal() {
		return meal;
	}
	public void setMeal(String meal) {
		this.meal = meal;
	}
	public String getAcm() {
		return acm;
	}
	public void setAcm(String acm) {
		this.acm = acm;
	}
	public String getCname() {
		return cname;
	}
	public void setCname(String cname) {
		this.cname = cname;
	}
	public String getEmpno() {
		return empno;
	}
	public void setEmpno(String empno) {
		this.empno = empno;
	}
	public String getEname() {
		return ename;
	}
	public void setEname(String ename) {
		this.ename = ename;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getFleet() {
		return fleet;
	}
	public void setFleet(String fleet) {
		this.fleet = fleet;
	}
	public String getFltno() {
		return fltno;
	}
	public void setFltno(String fltno) {
		this.fltno = fltno;
	}
	public String getGrp() {
		return grp;
	}
	public void setGrp(String grp) {
		this.grp = grp;
	}
	public String getQual() {
		return qual;
	}
	public void setQual(String qual) {
		this.qual = qual;
	}
	public String getSector() {
		return sector;
	}
	public void setSector(String sector) {
		this.sector = sector;
	}
	public String getSerno() {
		return serno;
	}
	public void setSerno(String serno) {
		this.serno = serno;
	}
	public String getSpcode() {
		return spcode;
	}
	public void setSpcode(String spcode) {
		this.spcode = spcode;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getCr() {
		return cr;
	}
	public void setCr(String cr) {
		this.cr = cr;
	}
	public String getPriority() {
		return priority;
	}
	public void setPriority(String priority) {
		this.priority = priority;
	}
}
%>
<%
response.setContentType("text/html; charset=big5");

String sGetUsr = (String)session.getAttribute("userid");

if (sGetUsr == null){
	response.sendRedirect("../sendredirect.jsp");
	
}
String fltdate= request.getParameter("yy") +request.getParameter("mm")+request.getParameter("dd"); //yyyymmdd
String fltno = request.getParameter("fltno");  //0681
String ftime = request.getParameter("ftime");  //5821
String port = request.getParameter("port");  //5821
String inner_sect = request.getParameter("sect");  //5821
if((inner_sect == null | "".equals(inner_sect)) && port != null && !"".equals(port))
{
	inner_sect = port;
}


//檢查班表是否公布
swap3ac.PublishCheck pc = new swap3ac.PublishCheck(request.getParameter("yy"), request.getParameter("mm"));

if( !pc.isPublished()){
//非航務、空服簽派者，才檢查班表是否公佈
%>
<div style="background-color:#99FFFF;text-align:center;color:#FF0000;font-family:Verdana;font-size:10pt; ">
		<%=request.getParameter("yy")+"/"+request.getParameter("mm")%>班表尚未正式公佈!!
</div>
<%

}
else
{
aircrew.CrewInfo cc = new aircrew.CrewInfo();
StringBuffer sb = new StringBuffer();
sb.append("SELECT d.series_num,to_char(act_str_dt_tm_gmt,'yyyymmdd hh24mi') actStrDt,");
sb.append("To_Char(d.str_dt_tm_loc,'mm/dd hh24mi') str_dt_loc,To_Char(d.end_dt_tm_loc,'mm/dd hh24mi') end_dt_loc,");
sb.append("d.flt_num,d.act_port_a||d.act_port_b sector, d.fleet_cd,d.flt_num ,rr.staff_num,rr.special_indicator,");
sb.append("(CASE WHEN d.duty_cd='TVL' THEN 'TVL' ELSE '' END )   ACM ,cc.Rank_cd,cc.ename,cc.grp,cc.sern ,cc.cname ");
sb.append(" FROM duty_prd_seg_v d ,");
  /* 取得該班組員 */
sb.append(" ( select r.series_num,r.staff_num,r.special_indicator  FROM roster_v r  WHERE r.delete_ind='N'   ) rr ,");
  /* 取得組員資料 */
sb.append("  (SELECT c.staff_num,cv.rank_cd Rank_cd, c.other_surname||' '||c.other_first_name ename,");
sb.append("    c.preferred_name  cname, c.section_number grp, LTrim(LPad(Nvl(Trim(c.seniority_code),'0'),12,'0'),'0') sern ");
//sb.append("    c.preferred_name  cname, c.section_number grp, ltrim(c.seniority_code,'0') sern ");

sb.append("  FROM crew_v c,crew_rank_v cv ");
sb.append("  WHERE c.staff_num = cv.staff_num  AND cv.eff_dt<= To_Date(?,'yyyymmdd') ");
sb.append("AND (cv.exp_dt IS null  OR cv.exp_dt >= To_Date(?,'yyyymmdd') ) ) cc ");
sb.append("WHERE d.series_num = rr.series_num  AND rr.staff_num = cc.staff_num ");
sb.append(" AND d.act_str_dt_tm_gmt BETWEEN (To_Date(?,'yyyymmdd hh24mi') - 2) and (To_Date(?,'yyyymmdd hh24mi') + 2) " );
sb.append(" AND d.str_dt_tm_loc BETWEEN  To_Date(?,'yyyymmdd hh24mi') AND To_Date(?,'yyyymmdd hh24mi') ");

sb.append(" AND d.delete_ind='N' AND d.duty_cd in ('FLY','TVL')"); 

//2013/10/29 delay班--air crews no data問題
if(fltno.indexOf("Z") > -1){
//	fltno = fltno.substring(0,4);
	sb.append("AND d.flt_num in ('"+fltno+"','"+fltno.substring(0,4)+"') ");
}else{
	sb.append("AND d.flt_num='"+fltno+"' ");
}
	 /* 雙航段時，需輸入Sector*/
if(null != inner_sect && !"".equals(inner_sect)){

sb.append("and d.act_port_a||d.act_port_b=upper('"+inner_sect+"') ");
}
	/* 排序時，前艙排前面，後艙PR排前面，其餘照序號排 */
sb.append("  ORDER BY d.fd_ind DESC,  ");
//sb.append("decode(cc.rank_cd,'PR','1','FC','2',rr.staff_num) ");
//sb.append("decode(cc.rank_cd,'PR',1,'FC',2,To_Number(cc.sern,0)) ");
sb.append("decode(cc.rank_cd,'PR','00001','FC','00002',lpad(cc.sern,5,'0')) ");



/*if("632934".equals(sGetUsr))
{
out.print(sb.toString());
}*/

Driver dbDriver = null;
Connection conn 	= null;
PreparedStatement pstmt 		= null;
ResultSet rs = null;

String bgColor = null;
ConnDB cn = new ConnDB();
ArrayList dataAL = null;
boolean status = false;
String errMsg  = "";
String sect = null;
String dpt = null;
try
{
	cn.setAOCIPRODCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);

    pstmt = conn.prepareStatement(sb.toString()); 
	pstmt.setString(1,fltdate);
	pstmt.setString(2,fltdate);
	
	//pstmt.setString(3,fltdate+" 0000");
	//pstmt.setString(4,fltdate+" 2359");
	pstmt.setString(5,fltdate+" "+ftime);
	pstmt.setString(6,fltdate+" "+ftime);
	pstmt.setString(3,fltdate+" 0000");
	pstmt.setString(4,fltdate+" 2359");
	//pstmt.setString(7,fltno);
	
 rs = pstmt.executeQuery();
 while(rs.next()){

	 if(dataAL == null){
		dataAL =new ArrayList();
	 }
	CrewListObj obj = new CrewListObj();
	obj.setAcm(rs.getString("acm"));
	obj.setCname(cc.getCname(rs.getString("staff_num")));
	obj.setEmpno(rs.getString("staff_num"));
	obj.setEname(rs.getString("ename"));
	obj.setEndDate(rs.getString("end_dt_loc"));
	obj.setFleet(rs.getString("fleet_cd"));
	obj.setFltno(rs.getString("flt_num"));
	obj.setGrp(rs.getString("grp"));
	obj.setQual(rs.getString("Rank_cd"));
	obj.setSector(rs.getString("sector"));
	sect = rs.getString("sector");
	dpt = sect.substring(0,3);
	//排除退後再聘序號欄位內容為 [null]者
	if(!"null".equals(rs.getString("sern")))
	{
	obj.setSerno(rs.getString("sern"));
	}

	obj.setSpcode(rs.getString("special_indicator"));
	obj.setStartDate(rs.getString("str_dt_loc"));	
	obj.setSeries_num(rs.getString("series_num"));
	obj.setAct_str_dt_tm_gmt(rs.getString("actStrDt"));
	dataAL.add(obj);
 }
	rs.close();
	pstmt.close();

if(dataAL != null)
{
	for(int i=0;i<dataAL.size();i++)
	{	
		CrewListObj obj = (CrewListObj)dataAL.get(i);
        //***********************************************************
		//Set Credit Hour		
		fzac.CreditHrsForDispatch crh = new fzac.CreditHrsForDispatch(obj.getEmpno(), request.getParameter("yy") +request.getParameter("mm"));
		crh.SelectSingleCrew();
		//obj.setCr(crh.getCrewCrinMin());   
		obj.setCr(ci.tool.TimeUtil.minToHHMM(crh.getCrewCrinMin()));		

		if(!"6".equals(obj.getEmpno().substring(0,1)) | "K".equals(obj.getSpcode()) | "J".equals(obj.getSpcode()) | "I".equals(obj.getSpcode()) | "PR".equals(obj.getQual()) | "CA".equals(obj.getQual()) | "FO".equals(obj.getQual()) | "FE".equals(obj.getQual()) |"RP".equals(obj.getQual()))
		{
			obj.setPriority("0");   
		}
		else
		{
			obj.setPriority(crh.getCrewCrinMin()); 			
		}
		//***********************************************************

	    //取得組員餐	
		pstmt = conn.prepareStatement("SELECT staff_num, meal_type "
			+"FROM acdba.crew_special_meals_t "
			+"WHERE eff_fm_dt <= to_date(?,'yyyymmdd') "
			+"AND (eff_to_dt >= to_date(?,'yyyymmdd') OR eff_to_dt IS NULL ) "
			+"AND staff_num =?");
		pstmt.setString(1,fltdate);
		pstmt.setString(2,fltdate);	
		pstmt.setString(3,obj.getEmpno());
		rs =pstmt.executeQuery();
		if(rs.next()){
			obj.setMeal(rs.getString("meal_type"));
		}
		rs.close();
		pstmt.close();

		
		pstmt = conn.prepareStatement("select to_char(arvtm,'HH24:MI')||'/'||fltno lastfly "
		+"from (select dps.act_end_dt_tm_gmt arvtm, dps.flt_num fltno "
		+"from duty_prd_seg_v dps, roster_v r "
		+"where dps.series_num=r.series_num "
		+"and dps.act_str_dt_tm_gmt between to_date(?,'yyyymmdd')  "
		+"and (to_date(?,'yyyymmddHH24MI') - (1/1440))  "
		+"and dps.delete_ind='N' and r.delete_ind='N' "
		+"and dps.series_num=? "
		+"and dps.duty_cd in ('TVL','FLY') "
		+"order by dps.act_end_dt_tm_gmt desc) where rownum=1");
		pstmt.setString(1,	obj.getAct_str_dt_tm_gmt().substring(0,8));
		pstmt.setString(2,	obj.getAct_str_dt_tm_gmt());
		pstmt.setString(3,obj.getSeries_num());
		rs =pstmt.executeQuery();
		if(rs.next()){
			obj.setLastFlight(rs.getString("lastfly"));
		} 
		rs.close();
		pstmt.close();
		
	pstmt = conn.prepareStatement("select staff_num,nvl(no_show,'Y') no_show,"
		+"(CASE WHEN dp.no_show='N' THEN 'Y' ELSE 'N' END ) chkin from crew_dops_v dp "
		+"where flt_dt_tm between to_date(?,'yyyy/mm/dd HH24MI') "
		+"and to_date(?,'yyyy/mm/ddHH24MI') "
		+"and flt_num=lpad(?,4,'0') and dep_arp_cd=? and staff_num=?");
		pstmt.setString(1,obj.getAct_str_dt_tm_gmt().substring(0,8)+" 0000");
		pstmt.setString(2,obj.getAct_str_dt_tm_gmt().substring(0,8)+" 2359");
		pstmt.setString(3,obj.getFltno());
		pstmt.setString(4,obj.getSector().substring(0,3));
		pstmt.setString(5,obj.getEmpno());
		
		rs =pstmt.executeQuery();
		if(rs.next()){
			obj.setIsCheckIn(rs.getString("chkin"));
		} 
		rs.close();
		pstmt.close();
	
	}
	
	conn.close();

	//取得 組員報到地點 TODO
	//cn.setORP3EGUserCP();
	cn.setORP3FZUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
	
	for(int i=0;i<dataAL.size();i++)
	{	
		CrewListObj obj = (CrewListObj)dataAL.get(i);

		//pstmt = conn.prepareStatement("select rptloc from egdb.egtchkin "
		//				+ "where empno=? "
		//				+ "AND sdate <= to_date(?,'yyyymmdd') "
		//				+ "and edate >= to_date(?,'yyyymmdd')");


		pstmt = conn.prepareStatement(" select rptloc from egdb.egtchkin where empno=? AND sdate <= to_date(?,'yyyymmdd') and edate >= to_date(?,'yyyymmdd') UNION select decode(rptloc,'0','TSA','1','CAL PARK','2','T1/T2',rptloc) rptloc from (select rptloc from dfdb.dftcrew_rptloc where empno= ? order by chgdt desc) where rownum=1");

		pstmt.setString(1, obj.getEmpno());
		pstmt.setString(2, obj.getAct_str_dt_tm_gmt().substring(0,8));
		pstmt.setString(3, obj.getAct_str_dt_tm_gmt().substring(0,8));
		pstmt.setString(4, obj.getEmpno());
		rs = pstmt.executeQuery();
		if (rs.next()) 
		{
			if (!"TSA".equals(rs.getString("rptloc"))) 
			{
				obj.setRptLoc(rs.getString("rptloc"));
			}
		}
		rs.close();
		pstmt.close();
		
	}
	
}	
	conn.close();
	status = true;
}catch(SQLException e){
	errMsg = e.toString();
}finally{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Crew List</title>
<link href="../menu.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="../kbd.css">
<link rel="stylesheet" type="text/css" href="../errStyle.css">


<style type="text/css">
<!--
body{font-size:10pt;font-family:Arial, Helvetica, sans-serif;}
.bodFont{color: #464883;}
.red {color: #FF0000;font-weight: bold;}
-->
</style>
</head>

<body>
<div align="center">
  <%
  
if(!status){
%>
<div class="errStyle1">ERROR:<%=errMsg%></div>

  <%


}
else
{  
if(dataAL==null)
{
%>
  <div class="errStyle1">NO DATA!!  </div>
  <%
}
else
{
//先抓第一筆，顯示航班資料
CrewListObj objX = (CrewListObj)dataAL.get(0);

//Get booking data
//*****************************************************************************
//GetFltInfo ft = new GetFltInfo(request.getParameter("yy")+"/" +request.getParameter("mm")+"/"+request.getParameter("dd"), fltno);

GetFltInfo ft = new GetFltInfo(request.getParameter("yy")+"/" +request.getParameter("mm")+"/"+request.getParameter("dd"), fltno,inner_sect);
String book_f = "NA" ;
String book_c = "NA" ;
String book_y = "NA" ;
String book_ttl = "NA";
String fleet_conf = objX.getFleet();
String sect_conf = objX.getSector();
String fltno_conf = objX.getFltno();
ArrayList bookAL = new ArrayList();

try 
{
	 ft.RetrieveData();
	 bookAL = ft.getDataAL();		            
 	 if(bookAL.size()>0)
 	 {
 	    for(int i =0; i < bookAL.size(); i++)
 	    {
 	        fz.prObj.FltObj fltobj = (fz.prObj.FltObj) bookAL.get(i);
			book_f = fltobj.getActualF();
			book_c = fltobj.getActualC();
			book_y = fltobj.getActualY();
			book_ttl = fltobj.getBook_total();
 	    }             
	 }
	
 } 
 catch (SQLException e) 
 {
 System.out.println(e.toString());
 e.printStackTrace();
 } 
 catch (Exception e) 
{
 System.out.println(e.toString());
 }

//if FlexibleDispatch
FlexibleDispatch fd = new FlexibleDispatch();

 //Set ACM priority
for(int m = 1; m<=3; m++)
{
	int maxidx = 0;
	for(int i=1;i<dataAL.size();i++)
	{
		CrewListObj obj1 = (CrewListObj)dataAL.get(i);
		CrewListObj obj2 = (CrewListObj)dataAL.get(maxidx);

		if(Integer.parseInt(obj1.getPriority()) > Integer.parseInt(obj2.getPriority()))
		{
			maxidx = i;
		}	
	}
	CrewListObj objcr = (CrewListObj)dataAL.get(maxidx);
	objcr.setPriority("0");
	objcr.setCr(objcr.getCr()+"("+m+")");
}
//*****************************************************************************
%>

</div>
<table width="80%"  border="1" align="center" cellpadding="1" cellspacing="1" style="empty-cells:show;border-collapse:collapse; " >
<caption  align="center" class="txttitletop">
Flight Crew List <br>
<span style="color:#0000FF; ">( Reference Only )</span>
<table width="100%"  border="0" align="center" cellpadding="0" cellspacing="0" style="empty-cells:show;border-collapse:collapse; " >
<tr>
<td align="left" class="red" >F/C/Y:<%=book_f%>/<%=book_c%>/<%=book_y%>(<%=book_ttl%>/<%=fd.getConfig(objX.getFleet())%>)</td>
<td align="right"><a href="javascript:window.print()"><img src="../images/print.gif" width="17" height="15" border="0" alt="列印"></a>
<td align="right"><a href="/mail/mail.jsp?fdate=<%=fltdate%>&ftime=<%=ftime%>&fltno=<%=fltno%>&sect=<%=port%>&user=<%=sGetUsr%>&rid=X">
<img src="../images/mail.gif" width="17" height="15" border="0" alt="mail"></a>
</td>
</tr>
</table>

</caption>

  <tr style="background-color:#6983AF;color:#FFFFFF;text-align:center;font-weight:bold; ">
    <td>Start LOC</td>
    <td>Fltno</td>
	<td>Fleet</td>
    <td>Sector</td>
    <td>End LOC</td>
  </tr>
<tr class="txtred" align="center">
    <td><%=objX.getStartDate()%></td>
    <td><%=objX.getFltno()%></td>
    <td><%=objX.getFleet()%></td>
    <td><%=objX.getSector()%></td>
    <td><%=objX.getEndDate()%></td>
</tr>
</table>

  <%  
objX = null;
%>

<br>
<table width="80%"  border="1" align="center" cellpadding="1" cellspacing="1" style="empty-cells:show;border-collapse:collapse; " >
  <tr style="background-color:#6983AF;color:#FFFFFF;text-align:center;font-weight:bold; ">
	<td width="4%" height="22" align="center">#</td>
    <td width="5%" align="center">Rmk</td>
	<%
	//add by cs55 2006/10/31
  	if("TPE".equals(dpt)){
	%>
	<td width='5%'>ChkIN</td><%	}	%>
    <td width="8%">EmpNo</td>
    <td width="15%">Name</td>
    <td width="15%">EName</td>
	<td width="5%">Meal</td>
    <td width="5%">Sern</td>
	<td width="5%">Qual</td>
    <td width="5%">SpCode</td>
	<td width="5%">Rpt</td>
	<td width="5%">Grp</td>
    <td width="10%">LastFlt</td>
	<td width="10%">CR.</td>
  </tr>

<%	
	for(int i=0;i<dataAL.size();i++){
		CrewListObj obj = (CrewListObj)dataAL.get(i);
			
		if (i%2 == 0){
			bgColor = "";
		}else{
			//bgColor = " bgcolor='rgb(231,243,255)' ";
			bgColor = "bgcolor='#CCFFFF'";
		}
  %>
  <tr <%=bgColor%> align="center" >
  	<td height="26" style="text-align:right;padding-right:0.25em; " ><%=i+1%></td>
    <td  ><%=obj.getAcm()%></td>
<%
  	if("TPE".equals(dpt)){
%>
	<td  class='red'>
	<%
		if("N".equals(obj.getIsCheckIn())&&( "1".equals(obj.getGrp()) || "2".equals(obj.getGrp()) || "3".equals(obj.getGrp()) || "4".equals(obj.getGrp()) || "98".equals(obj.getGrp()) || "96".equals(obj.getGrp()))){
			
	%><%=obj.getIsCheckIn()%>
	<%	}	%>
	</td>	<%}%>
    <td ><%=obj.getEmpno()%></td>
    <td style="text-align:left;padding-left:0.25em; "><%=obj.getCname()%></td>
    <td style="text-align:left;padding-left:0.25em; "><%=obj.getEname()%></td>
    <td ><%=obj.getMeal()%></td>
    <td  style="text-align:right;padding-right:0.25em; ">
      <%=obj.getSerno()%>
    </td>
    <td ><%=obj.getQual()%></td>
    <td><%=obj.getSpcode()%></td>
	<td  style="font-weight:bold; "><%=obj.getRptLoc()%></td>
	
	<td><%=obj.getGrp()%></td>
	<td><%=obj.getLastFlight()%></td>
<%
if("0".equals(obj.getCr()) | "0000".equals(obj.getCr()))	
{
	obj.setCr("");
}
%>
	<td><%=obj.getCr()%></td>
  </tr>
  <%
  		}
	
  %>
</table>
<div align="center">
<table width="80%"  border="0" align="center" cellpadding="0" cellspacing="0">
<tr>
<td width="51%" align="right" valign="top">
<!--********-->
  <input type="button" class="kbd" onClick="javascript:self.close();" value="CLOSE" style="margin-top:1em;font-family:Verdana, Arial, Helvetica, sans-serif; ">
<!--********-->
</td>
<%
//******************************************************************
//if FlexibleDispatch
boolean ifFlexibleDispatch = false;
ifFlexibleDispatch = fd.ifFlexibleDispatch2(request.getParameter("yy")+"/" +request.getParameter("mm")+"/"+request.getParameter("dd"),fltno_conf,sect_conf,sGetUsr);	

if(ifFlexibleDispatch == true)
{
%>
<td width="49%">
<!--********-->
<%
boolean show = false;

//香港線不包含Transfer Flt and Fleet in 74*/34*
if (("744".equals(fleet_conf) | "74A".equals(fleet_conf) | "74B".equals(fleet_conf) | "34A".equals(fleet_conf) | "343".equals(fleet_conf) | "34B".equals(fleet_conf)) &&  sect_conf.indexOf("HKG") >= 0 && (!"641".equals(fltno.substring(1,4)) && !"642".equals(fltno.substring(1,4)) && !"643".equals(fltno.substring(1,4)) && !"644".equals(fltno.substring(1,4)) &&  !"679".equals(fltno.substring(1,4)) && !"680".equals(fltno.substring(1,4))) ) 
{
	show = true;//80%開始彈
}

//大陸線and Fleet in 74*/34*
if (("744".equals(fleet_conf) | "74A".equals(fleet_conf) | "74B".equals(fleet_conf) | "34A".equals(fleet_conf) | "343".equals(fleet_conf) | "34B".equals(fleet_conf)) && (sect_conf.indexOf("MNL") >= 0 | sect_conf.indexOf("PVG") >= 0 | sect_conf.indexOf("PEK") >= 0 | sect_conf.indexOf("CAN") >= 0 | sect_conf.indexOf("CTU") >= 0 | sect_conf.indexOf("KMG") >= 0 | sect_conf.indexOf("CKG") >= 0 | sect_conf.indexOf("NKG") >= 0 | sect_conf.indexOf("XMN") >= 0 | sect_conf.indexOf("SHE") >= 0 | sect_conf.indexOf("CSX") >= 0 | sect_conf.indexOf("SZX") >= 0 | sect_conf.indexOf("NGB") >= 0 | sect_conf.indexOf("HGH") >= 0 | sect_conf.indexOf("CGO") >= 0 | sect_conf.indexOf("XIY") >= 0 | sect_conf.indexOf("SHA") >= 0 | sect_conf.indexOf("DLC") >= 0 | sect_conf.indexOf("TAO") >= 0 | sect_conf.indexOf("FOC") >= 0 | sect_conf.indexOf("WNZ") >= 0 | sect_conf.indexOf("YNZ") >= 0 | sect_conf.indexOf("KHN") >= 0 | sect_conf.indexOf("SYX") >= 0 | sect_conf.indexOf("HAK") >= 0 | sect_conf.indexOf("WUH") >= 0 | sect_conf.indexOf("WUX") >= 0 |
sect_conf.indexOf("HIJ") >= 0))
{
	show = true;//80%開始彈
}	

if (!"738".equals(fleet_conf) && !"73A".equals(fleet_conf) && sect_conf.indexOf("OKA") >= 0 )
//if (!"738".equals(fleet_conf) && sect_conf.indexOf("OKA") >= 0 )
{
	show = true;
}

//全部航班皆從80%顯示
show = true;

%>
<table width="40%"  border="1" align="right" cellpadding="1" cellspacing="1" style="empty-cells:show;border-collapse:collapse; " >
  <tr style="background-color:#6983AF;color:#FFFFFF;text-align:center;font-weight:bold; ">
	<td align="center">FLEET</td>
    <td align="center">CFG</td>
<%
if (show == true)
{
%>
	<td align="center">CFG*80%</td>
<%
}	
%>	
	<td align="center">CFG*60%</td>
	<td align="center">CFG*40%</td>
  </tr>
  <!--<tr>
	<td align="center">744</td>
    <td align="center">397</td>
<%
if (show == true)
{
%>
	<td align="center">317</td>
<%
}	
%>	
	<td align="center">238</td>
	<td align="center">158</td>
  </tr>-->
  <tr>
	<td align="center">74C</td>
    <td align="center">375</td>
<%
if (show == true)
{
%>
	<td align="center">300</td>
<%
}	
%>	
	<td align="center">225</td>
	<td align="center">150</td>
  </tr>
    <tr>
	<td align="center">74C*</td>
    <td align="center">380</td>
<%
if (show == true)
{
%>
	<td align="center">304</td>
<%
}	
%>	
	<td align="center">228</td>
	<td align="center">152</td>
  </tr>

  <tr>
	<td align="center">74B</td>
    <td align="center">389</td>
<%
if (show == true)
{
%>
	<td align="center">311</td>
<%
}	
%>	
	<td align="center">233</td>
	<td align="center">156</td>
  </tr>

  <tr>
	<td align="center">738</td>
    <td align="center">158</td>
<%
if (show == true)
{
%>
	<td align="center">--</td>
<%
}	
%>	
	<td align="center">94</td>
	<td align="center">--</td>
  </tr>

  <tr>
	<td align="center">73A</td>
    <td align="center">168</td>
<%
if (show == true)
{
%>
	<td align="center">--</td>
<%
}	
%>	
	<td align="center">100</td>
	<td align="center">--</td>
  </tr>

  <tr>
	<td align="center">343</td>
    <td align="center">276</td>
<%
if (show == true)
{
%>
	<td align="center">220</td>
<%
}	
%>	
	<td align="center">165</td>
	<td align="center">110</td>
  </tr>
  <tr>
	<td align="center">333</td>
    <td align="center">313</td>
<%
if (show == true)
{
%>
	<td align="center">250</td>
<%
}	
%>	
	<td align="center">187</td>
	<td align="center">125</td>
  </tr>
  <tr>
	<td align="center">33A</td>
    <td align="center">307</td>
<%
if (show == true)
{
%>
	<td align="center">245</td>
<%
}	
%>	
	<td align="center">184</td>
	<td align="center">122</td>
  </tr>
  <!--<tr>
	<td align="center">33B</td>
    <td align="center">313</td>
<%
if (show == true)
{
%>
	<td align="center">250</td>
<%
}	
%>	
	<td align="center">187</td>
	<td align="center">125</td>
  </tr>  -->
</table>
<!--********-->
</td>
<%
}//
else//if(ifFlexibleDispatch == false)
{
%>
<td>&nbsp;</td>
<%
}
%>
</tr>
</table>
  <%
}//end of has crew data
}//end of success

}
%>

</body>
</html>
