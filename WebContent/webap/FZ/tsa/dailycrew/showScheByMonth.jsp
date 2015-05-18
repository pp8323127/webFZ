<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*,ci.db.*,java.util.*,fzac.*"%>
<%
String sGetUsr = request.getParameter("userid");

if (sGetUsr == null){
	sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login

	if (session.isNew() || sGetUsr == null) 
	{		//check user session start first
	 response.sendRedirect("../sendredirect.jsp");
	} 
}

String y1 = request.getParameter("y1");
String m1 = request.getParameter("m1");
//String d1 = request.getParameter("d1");
//String y2 = request.getParameter("y2");
//String m2 = request.getParameter("m2");
//String d2 = request.getParameter("d2");
String emp = request.getParameter("emp");
CrewInfo c = new CrewInfo(emp);
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
String sql = null;
ConnDB cn = new ConnDB();
ArrayList dataAL = new ArrayList();
Driver dbDriver = null;
CrewInfoObj crewObj = null;
//取得組員基本資料
if(c.isHasData()){
	 crewObj = c.getCrewInfo();
	
	try{
	//User connection pool to  ORP3 AOCI
	cn.setAOCIPRODCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
	stmt = conn.createStatement();
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
	+"dps.fleet_cd actp,  nvl(r.special_indicator,'&nbsp;') spCode "
   +"from duty_prd_seg_v dps, roster_v r "
	+"where dps.series_num=r.series_num "
   +"and dps.delete_ind = 'N' AND  r.delete_ind='N' "
	+"and r.staff_num ='"+crewObj.getEmpno()
	+"' AND dps.act_str_dt_tm_gmt BETWEEN  to_date('"+y1+m1+"01 00:00','yyyymmdd hh24:mi') "
	+"AND last_day(To_Date('"+y1+m1+"01 23:59','yyyymmdd hh24:mi')) "
	+"UNION ALL SELECT to_char(r.str_dt,'yyyy/mm/ddhh24mi') a,r.staff_num,To_Char(str_dt,'yyyy/mm/dd') fdate,"
	+"To_Char(str_dt,'yyyy/mm/dd hh24:mi') fdateDptLoc,"
	+"To_Char(end_dt,'yyyy/mm/dd hh24:mi') fdateArvLoc,duty_cd,duty_cd duty_cd2,"
    +"'&nbsp;' dpt,'&nbsp;' arv, '-' ACPT,'&nbsp;' spcode "
	+"FROM roster_v r WHERE r.staff_num='"+crewObj.getEmpno()
	+"' AND r.series_num=0 AND r.delete_ind='N' "
	+"AND str_dt BETWEEN To_Date('"+y1+m1+"01 0000','yyyymmdd hh24mi') "
	+"AND last_day(To_Date('"+y1+m1+"01 2359','yyyymmdd hh24mi'))  order by a";
  		
		//System.out.print(sql);
		
	rs = stmt.executeQuery(sql);
		while(rs.next()){
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
			obj.setDuty_Cd(rs.getString("duty_cd2"));
			obj.setDptTPELoc(rs.getString("a"));
			
			dataAL.add(obj);
		}
	
	}catch (SQLException e){
		  out.print(e.toString());
		  
	}catch (Exception e){
		  out.print(e.toString());
	}finally{
	
		if (rs != null) try {rs.close();} catch (SQLException e) {}	
		if (stmt != null) try {stmt.close();} catch (SQLException e) {}
		if (conn != null) try { conn.close(); } catch (SQLException e) {}
	
	}

}


%>
<html>
<head>
<title>Monthly Schedule</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="menu.css" rel="stylesheet" type="text/css">
<link href="../../kbd.css" rel="stylesheet" type="text/css">

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
if(dataAL.size() == 0 && c.isHasData()){
%>
      <div class="txtxred">Staff number/Sern:<%=crewObj.getEmpno()+"/"+crewObj.getSern()%> in <%=y1+"/"+m1%> has no Schedule!!</div>

<%
}else if(!c.isHasData()){
%>
 <div class="txtxred">Staff number/Sern:<%=emp%> is invalid.</div>
 <%
}else{ 
%>

  <table width="80%" border="0" cellpadding="0" cellspacing="0" >
  	<tr><td width="95%">
	  <div align="center"><span class="txtblue">
  
 <%=crewObj.getEmpno() +"&nbsp;&nbsp;"+crewObj.getSern()+"&nbsp;&nbsp;"+crewObj.getCname()+"&nbsp;&nbsp;BASE:"+crewObj.getBase()
+"&nbsp;&nbsp;Rank:"+crewObj.getOccu()
+"&nbsp;&nbsp;Groups:"+crewObj.getGrp()
+"&nbsp;&nbsp;<br>Date:"+y1+"/"+m1
%>
        </span>
	    </div>
  	</td>
  	  <td width="5%">
  	    <div align="right"><a href="javascript:print()"><img height="15" src="../../images/print.gif" width="17" border="0" ></a></div>
  	  </td>
  	</tr>
  </table>

 <table width="80%" border="1" cellpadding="0" cellspacing="0" id="t1">
  <tr class="selected" >
    <td width="16%" height="20">
      <div align="center">Fdate<br>
        (Local)</div>
    </td>
    <td width="12%">
      <div align="center">Fltno</div>
    </td>
    <td width="10%">
      <div align="center">Dpt</div>
    </td>
    <td width="10%">
      <div align="center">Arv</div>
    </td>
    <td width="19%">
      <div align="center">Btime<br>
        (Local)</div>
    </td>
    <td width="18%">
      <div align="center">Etime<br>
        (Local)</div>
    </td>
    <td width="8%">
      <div align="center">Actp</div>
    </td>
    <td width="7%">
      <div align="center">SpCode</div>
    </td>
    <!--   <td class="tablehead">Crew</td> -->
  </tr>
  <%
  for(int i=0;i<dataAL.size();i++){
	CrewSkjObj obj = (CrewSkjObj)dataAL.get(i);  
  %>
  <tr >
    <td height="21" >
      <div align="center"><%=obj.getFdateLoc()%></div>
    </td>
    <td >
	
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
  </tr>
  <%
}
%>
</table><br>
<table width="80%" border="0" cellpadding="0" cellspacing="0">
<tr><td><div align="left" class="txtxred">* Click Fltno to view Crew List by Trip.</div></td></tr>
</table>
<br>
<input type="button" class="kbd" onClick="javascript:self.close();" value="CLOSE">
<script language="javascript" type="text/javascript">
	function showCrewList(str1,str2,str3,str4,str5,str6,str7){
		document.crewListForm.fltdate.value=str1;
		document.crewListForm.fltno.value=str2;
		document.crewListForm.showfltno.value=str2;		
		document.crewListForm.sector.value=str3;
		document.crewListForm.fleet.value=str4;
		document.crewListForm.str_dt_loc.value=str5;
		document.crewListForm.end_dt_loc.value=str6;							
		document.crewListForm.dutycd.value=str7;							
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
</body>
</html>
