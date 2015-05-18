<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*,ci.db.*,java.util.*,fzac.*"%>
<%
// CrewSkjObj.class
// 2009/12/15 cs27 v002 mod add cop_duty_cdoe

String startDate  = request.getParameter("startDate");
String endDate = request.getParameter("endDate");
/*
String y1 = request.getParameter("y1");
String m1 = request.getParameter("m1");
String d1 = request.getParameter("d1");
String y2 = request.getParameter("y2");
String m2 = request.getParameter("m2");
String d2 = request.getParameter("d2");
*/


String userid = (String) session.getAttribute("cs55.usr") ; //get user id if already login

if(session.isNew() | userid == null ){
	 response.sendRedirect("../sendredirect.jsp");

}else{

String fullUCD = (String) session.getAttribute("fullUCD");

//檢查班表是否公布
swap3ac.PublishCheck pc = new swap3ac.PublishCheck(endDate.substring(0,4), endDate.substring(5,7));

if((!"190A".equals(fullUCD) && !"068D".equals(fullUCD) && !"640790".equals(userid))
	&& !pc.isPublished()){
//非航務、空服簽派者，才檢查班表是否公佈
%>
<div style="background-color:#99FFFF;text-align:center;color:#FF0000;font-family:Verdana;font-size:10pt; ">
		<%=endDate.substring(0,7)%>班表尚未正式公佈!!
</div>
<%

}else  if( !ci.tool.CheckDate.isValidateDate(startDate) 
	|| !ci.tool.CheckDate.isValidateDate(endDate) 
	){
%>
<div style="background-color:#99FFFF;text-align:center;color:#FF0000;font-family:Verdana;font-size:10pt;padding:2em;">
		日期選擇錯誤.請重新選擇.
</div>
<%

}else {


//寫入log
fz.writeLog wl = new fz.writeLog();
wl.updLog(userid, request.getRemoteAddr(),request.getRemoteHost(), "CII020");



String crewRank= "";

String emp = request.getParameter("emp");
AllCrewInfo c = new AllCrewInfo(emp);
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
String sql = null;
ConnDB cn = new ConnDB();
ArrayList dataAL = null;
Driver dbDriver = null;
CrewInfoObj crewObj = null;
int tempCount = 0;
//取得組員基本資料
if(c.isHasData()){
	 crewObj = c.getCrewInfo();
	crewRank = "";
	try{
	//User connection pool to  ORP3 AOCI
	cn.setAOCIPRODCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
	
//取得查詢區間內有效的rank_cd
	pstmt = conn.prepareStatement("SELECT * from crew_rank_v WHERE staff_num=? "
			+"AND (eff_dt<=To_Date(?,'yyyy/mm/dd') AND (exp_dt >= To_Date(?,'yyyy/mm/dd')  OR exp_dt IS NULL))");
			pstmt.setString(1,emp);
			pstmt.setString(2,startDate);
			pstmt.setString(3,endDate);
			rs = pstmt.executeQuery();
			if(rs.next()){
				crewRank = rs.getString("rank_cd");
			}
			
		rs.close();
		pstmt.close();
	
	
	
	/*
	sql = "select str_dt_tm_gmt s,r.staff_num,dps.port_a dpt,dps.port_b arv,"
		+"To_Char(str_dt_tm_loc,'yyyy/mm/dd') fdateLoc, To_Char(str_dt_tm_loc,'yyyy/mm/dd hh24:mi') fdateDptLoc,"
		+"To_Char(end_dt_tm_loc,'yyyy/mm/dd hh24:mi') fdateArvLoc,"		
		+"(CASE WHEN dps.flt_num='0' THEN dps.duty_cd ELSE dps.flt_num END ) duty_cd,"
		+" Nvl(r.special_indicator,' ') spCode,r.acting_rank "
		+"from duty_prd_seg_v dps, roster_v r "
		+"where dps.series_num=r.series_num  AND r.staff_num='"+crewObj.getEmpno()
		+"' AND r.delete_ind='N' AND str_dt_tm_loc BETWEEN To_Date('"+y1+m1+d1+" 0000','yyyymmdd hh24mi') "
		+"AND To_Date('"+y2+m2+d2+" 2359','yyyymmdd hh24mi') "
		+"UNION ALL SELECT str_dt s,r.staff_num,'' dpt,'' arv,"
		+"To_Char(str_dt,'yyyy/mm/dd') fdateLoc,"
		+"To_Char(str_dt,'yyyy/mm/dd hh24:mi') fdateDptLoc,"
		+"To_Char(end_dt,'yyyy/mm/dd hh24:mi') fdateArvLoc,duty_cd,' ' spcode,r.acting_rank "
		+"FROM roster_v r WHERE r.staff_num='"+crewObj.getEmpno()
		+"' AND r.series_num=0 AND r.delete_ind='N' "
		+"AND str_dt BETWEEN To_Date('"+y1+m1+d1+" 0000','yyyymmdd hh24mi') "
		+"AND To_Date('"+y2+m2+d2
		+" 2359','yyyymmdd hh24mi') ORDER BY s";//--ORDER BY str_dt_tm_gmt";
*/
sql = "select to_char(dps.act_str_dt_tm_gmt,'yyyy/mm/ddhh24mi') a,r.staff_num,To_Char(dps.str_dt_tm_loc,'yyyy/mm/dd') fdate, "
	+"To_Char(dps.str_dt_tm_loc,'yyyy/mm/dd hh24:mi') fdateDptLoc,"
	+"To_Char(dps.end_dt_tm_loc,'yyyy/mm/dd hh24:mi') fdateArvLoc ,"
    +"(CASE WHEN dps.flt_num='0' then dps.duty_cd ELSE dps.flt_num end ) duty_cd,dps.duty_cd duty_cd2,"
    +"dps.act_port_a dpt,dps.act_port_b arv,"
	+"dps.fleet_cd actp,  nvl(r.special_indicator,'&nbsp;') spCode,dps.SERIES_NUM, r.ROSTER_NUM "
	+" ,nvl(dps.cop_duty_cd,' ') cop_duty_cd "
   +"from duty_prd_seg_v dps, roster_v r "
	+"where dps.series_num=r.series_num "
   +"and dps.delete_ind = 'N' AND  r.delete_ind='N' "
	+"and r.staff_num =? "
	+" AND dps.act_str_dt_tm_gmt BETWEEN  to_date(?,'yyyy/mm/dd hh24mi') "
	+"AND To_Date(?,'yyyy/mm/dd hh24mi') "
	+"UNION ALL SELECT to_char(r.str_dt,'yyyy/mm/ddhh24mi') a,r.staff_num,To_Char(str_dt,'yyyy/mm/dd') fdate,"
	+"To_Char(str_dt,'yyyy/mm/dd hh24:mi') fdateDptLoc,"
	+"To_Char(end_dt,'yyyy/mm/dd hh24:mi') fdateArvLoc,duty_cd,duty_cd duty_cd2,"
    +"'&nbsp;' dpt,'&nbsp;' arv, '-' ACPT,'&nbsp;' spcode,r.series_num,r.roster_num "
	+" , ' ' cop_duty_cd "
	+"FROM roster_v r WHERE r.staff_num=? "
	+" AND r.series_num=0 AND r.delete_ind='N' "
	+"AND str_dt BETWEEN to_date(?,'yyyy/mm/dd hh24mi') "
	+"AND To_Date(?,'yyyy/mm/dd hh24mi')  order by a";
  		
		//System.out.print(sql);
		pstmt = conn.prepareStatement(sql);
		for(int i=1;i<7;i=i+3){
			pstmt.setString(i,crewObj.getEmpno());
			pstmt.setString(i+1,startDate+" 0000");
			pstmt.setString(i+2,endDate+" 2359");
		}

	rs = pstmt.executeQuery();
		while(rs.next()){
			if(dataAL == null){
				dataAL= new ArrayList();
			}
			CrewSkjObj obj = new CrewSkjObj();
			obj.setArv(rs.getString("arv"));
			obj.setAvLoc(rs.getString("fdateArvLoc"));
			obj.setDpt(rs.getString("dpt"));
			obj.setDtLoc(rs.getString("fdateDptLoc"));
			obj.setEmpno(rs.getString("staff_num"));
			obj.setFltno(rs.getString("duty_cd"));
			obj.setSpCode(rs.getString("spCode"));
			obj.setFdateLoc(rs.getString("fdate"));
			obj.setActp(rs.getString("actp"));
			obj.setRoster_num(rs.getString("roster_num"));
			obj.setSeries_num(rs.getString("series_num"));
			obj.setDuty_Cd(rs.getString("duty_cd2"));
			obj.setDptTPELoc(rs.getString("a"));
			obj.setCopDuty(rs.getString("cop_duty_cd")) ;	//v002

			dataAL.add(obj);
		}
		rs.close();
		pstmt.close();
		
	if(dataAL != null){
		for(int i=0;i<dataAL.size();i++){
			CrewSkjObj obj = (CrewSkjObj)dataAL.get(i);
			pstmt = conn.prepareStatement("select rostrg.TRG_CD,trgcd.TRG_CD_DESC,rostrg.TRAINING_FUNCTION "
			+"from ROSTER_SPECIAL_DUTIES_TRG_V rostrg, TRAINING_CODES_V trgcd "
			+"WHERE rostrg.TRG_CD=trgcd.TRG_CD AND ( rostrg.SERIES_NUM=? and  rostrg.ROSTER_NUM=? )");
			pstmt.setString(1,obj.getSeries_num());
			pstmt.setString(2,obj.getRoster_num());
			rs = pstmt.executeQuery();
			while(rs.next()){
				obj.setTrnCd(rs.getString("TRG_CD"));
				obj.setTrnDesc(rs.getString("TRG_CD_DESC"));
				obj.setTrnFunction(rs.getString("TRAINING_FUNCTION"));
			}
			rs.close();
			pstmt.close();

		}		
	
	}
		rs.close();
		pstmt.close();

	
	}catch (SQLException e){
		  out.print(e.toString());
		  
	}catch (Exception e){
		  out.print(e.toString());
	}finally{
	
		if (rs != null) try {rs.close();} catch (SQLException e) {}	
		if (pstmt != null) try {pstmt.close();} catch (SQLException e) {}
		if (conn != null) try { conn.close(); } catch (SQLException e) {}
	
	}

}


%>
<html>
<head>
<title>Show Schedule</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="menu.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="loadingStatus.css">

</head>


<script language="javascript" type="text/javascript" src="../../js/color.js"></script>
<style type="text/css">
	<!--

	/* style of selected cell */
	#t1 tbody tr.selected td {	
		background-color: #A7B5CE;
		color:#000000;
		font-weight: bold;
		font-family: Verdana; font-size: 9pt; font-weight: bold;
	}
	td{
	
	font-family:Verdana; font-size: 10pt;}

-->
</style>


<body onload="stripe('t1');">
<div align="center">
  <%
if(dataAL== null && c.isHasData()){
%>
      <div class="txtxred">Staff number/Sern:<%=crewObj.getEmpno()+"/"+crewObj.getSern()%> in <%=startDate+"~"+endDate%> has no Schedule!!</div>

<%
}else if(!c.isHasData()){
%>
 <div class="txtxred">Staff number/Sern:<%=emp%> is invalid.</div>
 <%
}else{ 
%>
 

 <table width="80%" border="1" cellpadding="0" cellspacing="0" id="t1">
 <caption class="txtblue">
  <%=crewObj.getEmpno() +"&nbsp;&nbsp;"+crewObj.getSern()+"&nbsp;&nbsp;"+crewObj.getCname()+"&nbsp;&nbsp;BASE:"+crewObj.getBase()
+"&nbsp;&nbsp;Rank:"+crewRank//crewObj.getOccu()
+"&nbsp;&nbsp;Groups:"+crewObj.getGrp()
+"&nbsp;&nbsp;<br>Date:"+startDate+"~"+endDate
%>
 <div align="right"><a href="javascript:print()"><img height="15" src="../../images/print.gif" width="17" border="0" ></a></div>
 </caption>
  <tr class="selected" >
    <td width="10%" height="20">
      <div align="center">Fdate<br>
        (Local)</div>
    </td>
    <td width="8%">
      <div align="center">Fltno</div>
    </td>
    <td width="6%">
      <div align="center">Dpt</div>
    </td>
    <td width="7%">
      <div align="center">Arv</div>
    </td>
    <td width="16%">
      <div align="center">Btime<br>
        (Local)</div>
    </td>
    <td width="17%">
      <div align="center">Etime<br>
        (Local)</div>
    </td>
    <td width="7%">
      <div align="center">Actp</div>
    </td>
    <td width="7%">
      <div align="center">SpCode</div>
    </td>
	<td width="10%">Trainning Code	</td>
	<td width="12%">Trainning Code Description</td>
    <td >Trainning Function</td> 
	<td  >COP Duty code</td>
  </tr>
  <%
  for(int i=0;i<dataAL.size();i++){
	CrewSkjObj obj = (CrewSkjObj)dataAL.get(i);  
  %>
  <tr >
    <td height="21" >
      <div align="center"><%=obj.getFdateLoc()%></div>
    </td>
    <td align="right" >
	<%
		if("FLY".equals(obj.getDuty_Cd()) | "TVL".equals(obj.getDuty_Cd())){  
		
	%>
	<a href="javascript:showCrewList('<%=obj.getDptTPELoc()%>','<%=obj.getFltno()%>','<%=obj.getDpt()+obj.getArv()%>','<%=obj.getActp()%>','<%=obj.getDtLoc()%>','<%=obj.getAvLoc()%>','<%=obj.getDuty_Cd()%>')"><%=obj.getFltno()%></a>
	
	<%				
		}else{
			out.print(obj.getFltno()+"<BR>");
		}
	%>
    </td>
    <td >
      <div align="center">&nbsp;<%=obj.getDpt()%></div>
    </td>
    <td >
      <div align="center">&nbsp;<%=obj.getArv()%></div>
    </td>
    <td >
      <div align="center"><%=obj.getDtLoc()%></div>
    </td>
    <td >
      <div align="center"><%=obj.getAvLoc()%></div>
    </td>
    <td >
      <div align="center"><%=obj.getActp()%></div>
    </td>
    <td >
      <div align="center"><%=obj.getSpCode()%></div>
    </td>
	<td>&nbsp;<% if(!"LO".equals(obj.getFltno()) && !"RST".equals(obj.getFltno())){out.print(obj.getTrnCd());}%></td>
	<td>&nbsp;<% if(!"LO".equals(obj.getFltno()) && !"RST".equals(obj.getFltno())){out.print(obj.getTrnDesc());}%></td>
	<td>&nbsp;<% if(!"LO".equals(obj.getFltno()) && !"RST".equals(obj.getFltno())){out.print(obj.getTrnFunction());}%></td>
	<td>&nbsp;<% if(!"LO".equals(obj.getFltno()) && !"RST".equals(obj.getFltno())){out.print(obj.getCopDuty());}%></td>
  </tr>
  <%
}
%>
</table>
<table width="80%" border="0" cellpadding="0" cellspacing="0">
  <tr >
    <td height="21" ><div align="left" class="txtblue">* Fltno為 RST 及 LO 時，不顯示 Trainning Code及Trainning Code Description.<br>
* 點選 Fltno 檢視 Crew List ( by Trip ).</div></td>
    </tr>
</table>
<script language="javascript" type="text/javascript">
	function showCrewList(str1,str2,str3,str4,str5,str6,str7){
		<%
		if("N".equals(crewObj.getFd_ind())){
		%>
		document.crewListForm.action="CrewListBySerisNum.jsp";		
		<%
		}else{
		%>
		document.crewListForm.action="CockpitCrewListBySerisNum.jsp";
		<%
		}
		%>	
	
		document.crewListForm.fltdate.value=str1;
		document.crewListForm.fltno.value=str2;
		document.crewListForm.showfltno.value=str2;		
		document.crewListForm.sector.value=str3;
		document.crewListForm.fleet.value=str4;
		document.crewListForm.str_dt_loc.value=str5;
		document.crewListForm.end_dt_loc.value=str6;							
		document.crewListForm.dutycd.value=str7;							
		document.crewListForm.submit();					
	}
</script>	
	<form name="crewListForm" method="post" action="CrewListBySerisNum.jsp" target="_blank">
	<input type="hidden" name="fltdate" value="">
	<input type="hidden" name="fltno" value="">
	<input type="hidden" name="sector" value="">		
	<input type="hidden" name="fleet" value="">		
	<input type="hidden" name="str_dt_loc" value="">		
	<input type="hidden" name="end_dt_loc" value="">		
	<input type="hidden" name="showfltno" value="">		
	<input type="hidden" name="dutycd" value="">		
	</form>

 <%
}//end of has data
 
%>
</div>
<script type="text/javascript" language="JavaScript">
if(parent.topFrame.document.getElementById("showLoading") != null){
	parent.topFrame.document.getElementById("showLoading").className="hiddenStatus";
}
if(parent.topFrame.document.getElementById("s1") != null){
	parent.topFrame.document.getElementById("s1").disabled=0;
}

if(parent.topFrame.document.getElementById("emp") != null){
	parent.topFrame.document.getElementById("emp").select();
	parent.topFrame.document.getElementById("emp").focus();
}
</script>
</body>
</html>
<%
}

}
%>