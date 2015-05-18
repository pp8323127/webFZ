<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*,ci.db.*"%>
<%!
public class ReportObj {

	private String fdate;
	private String fltno;
	private String dpt;
	private String arv;

	public String getArv() {
		return arv;
	}

	public void setArv(String arv) {
		this.arv = arv;
	}

	public String getDpt() {
		return dpt;
	}

	public void setDpt(String dpt) {
		this.dpt = dpt;
	}

	public String getFdate() {
		return fdate;
	}

	public void setFdate(String fdate) {
		this.fdate = fdate;
	}

	public String getFltno() {
		return fltno;
	}

	public void setFltno(String fltno) {
		this.fltno = fltno;
	}

}
%>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || userid == null) {		//check user session start first or not login
	response.sendRedirect("/webfz/FZ/sendredirect.jsp");
} 

String year = request.getParameter("year");
String month = request.getParameter("month");
boolean status = false;
String errMsg = "";

Connection conn = null;
Driver dbDriver = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
ArrayList dataAL = null;
ConnDB cn = new ConnDB();
//檢查班表是否公布
swap3ac.PublishCheck pc = new swap3ac.PublishCheck(year, month);


if(!pc.isPublished()){
	errMsg = year+"/"+month+"班表尚未公佈.";
}else{



try{

cn.setAOCIPRODCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
	
		
	pstmt = conn.prepareStatement("select to_char(dps.str_dt_tm_loc,'yyyy/mm/dd') fdate,"
			+"dps.flt_num fltno,to_char(str_dt_tm_loc,'yyyy/mm/dd hh24:mi') stdDt,"
			+"dps.port_a dpt,dps.port_b arv,r.acting_rank qual "
		   +"from duty_prd_seg_v dps, roster_v r where dps.series_num=r.series_num "
		   +"and dps.delete_ind = 'N' AND  r.delete_ind='N' "
		   +"and r.staff_num =? AND dps.act_str_dt_tm_gmt BETWEEN  "
		   +"to_date(?,'yyyymmdd hh24mi') AND "
		   +"Last_Day( To_Date(?,'yyyymmdd hh24mi')) "
		   +"AND dps.duty_cd='FLY'  order by str_dt_tm_gmt");
	
	pstmt.setString(1,userid);
	pstmt.setString(2,year+month+"01 0000");
	pstmt.setString(3,year+month+"01 2359");
	
	rs = pstmt.executeQuery();
	while(rs.next()){
		if(dataAL == null)
			dataAL = new ArrayList();
		ReportObj obj = new ReportObj();
		obj.setFdate(rs.getString("fdate"));
		obj.setFltno(rs.getString("fltno"));
		obj.setDpt(rs.getString("dpt"));
		obj.setArv(rs.getString("arv"));
		dataAL.add(obj);
	}
	status = true;
	
}catch (Exception e) {
	errMsg += e.toString();
} finally {
	if ( rs != null ) try {
		rs.close();
	} catch (SQLException e) {}
	if ( pstmt != null ) try {
		pstmt.close();
	} catch (SQLException e) {}
	if ( conn != null ) try {
		conn.close();
	} catch (SQLException e) {}

}

}

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>助理座艙長 <%=year+month%>任務列表</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
if(!status){

%>
<div style="background-color:#99FFFF;
		color:#FF0000;
		font-family:Verdana;
		font-size:10pt;padding:5pt;
		text-align:center; ">
		ERROR:<%=errMsg%>
		</div>
<%
}else if(dataAL == null){
%>
<div style="background-color:#99FFFF;
		color:#FF0000;
		font-family:Verdana;
		font-size:10pt;padding:5pt;
		text-align:center; ">查無資料<br>No DATA!!</div>
<%
}else{
%>
<script language="javascript" type="text/javascript" src="../../js/subWindow.js"></script>
<script language="javascript" type="text/javascript">
function viewCrewList(year,month,day,fltno,sect){
	subwinXY('../../blank.htm','crewList','1000','800');
	document.form1.target="crewList";
	document.form1.action="../preCrewList.jsp";
	document.getElementById("yy").value = year;
	document.getElementById("mm").value = month;
	document.getElementById("dd").value = day;
	document.getElementById("fltno").value = fltno;
	document.getElementById("sect").value = sect;	

	document.form1.submit();
}
function viewRpt(fdate,fltno,dpt,arv){
	subwinXY('../../blank.htm','rpt','1000','800');
	document.form1.target="rpt";
	document.form1.action="printRpt.jsp";
	
	document.getElementById("fdate").value = fdate;
	document.getElementById("fltno").value = fltno;
	document.getElementById("dpt").value = dpt;
	document.getElementById("arv").value = arv;

	document.form1.submit();
}
</script>
<form method="post" name="form1" action="/webfz/FZAC/PRAC/preCrewList.jsp">
	<input type="hidden" name="fdate">
	<input type="hidden" name="yy">
	<input type="hidden" name="mm">
	<input type="hidden" name="dd">
	<input type="hidden" name="fltno">
	<input type="hidden" name="sect">
	<input type="hidden" name="dpt">
	<input type="hidden" name="arv">
</form>
<table width="72%"  border="0" align="center" cellpadding="2" cellspacing="2" class="tableBorder1">
<caption class="center r"><%=year+month%>任務列表</caption>
  <tr class="tableInner3">
    <td width="20%">Fdate</td>
    <td width="20%">Fltno</td>
    <td width="20%">Sect</td>
    <td width="20%">檢視任務名單</td>
    <td width="20%">列印 Crew List </td>
  </tr>
  <%
  	for(int i=0;i<dataAL.size();i++){

		ReportObj obj = (ReportObj)dataAL.get(i);
		String bgColor="";
		if(i%2 == 0){
			bgColor = "tableInner2";
		}else{
			bgColor = "";
		}
	
  %>
  <tr  class="<%=bgColor%>">
    <td height="28" ><%=obj.getFdate()%></td>
    <td ><%=obj.getFltno() %></td>
    <td ><%=obj.getDpt()+obj.getArv() %></td>
    <td ><a href="javascript:viewRpt('<%=obj.getFdate()%>','<%=obj.getFltno()%>','<%=obj.getDpt()%>','<%=obj.getArv()%>');"><img src="../../images/blue_view.gif" alt="Print Report" width="16" height="16"  border="0" title="Print Report"></a> </td>
    <td >
	<a href="javascript:viewCrewList('<%=obj.getFdate().substring(0,4)%>','<%=obj.getFdate().substring(5,7)%>','<%=obj.getFdate().substring(8)%>','<%=obj.getFltno()%>','<%=obj.getDpt()+obj.getArv()%>');"><img src="../../images/format-justify-fill.png" width="16" height="16" border="0" alt="Print Crew List" title="Print Crew List"></a>
	</td>
  </tr>
<%
		}
	
%>  
</table>

<%
}
%>
</body>
</html>
