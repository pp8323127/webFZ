<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*" %>
<%!
public class FltObj {
	private String fdate;
	private String fltno;
	private String dpt;
	private String arv;
	private String tripno;
	
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
	public String getTripno() {
		return tripno;
	}
	public void setTripno(String tripno) {
		this.tripno = tripno;
	}
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" type="text/css" href="../errStyle.css">
<link rel="stylesheet" type="text/css" href="../style2.css">
<script type="text/javascript" language="javascript" src="../js/color.js"></script>
<script language="javascript" src="../js/subWindow.js" type="text/javascript"></script>

<title>顯示航班</title>
</head>
<%
String fdate = request.getParameter("fdate"); // yyyy/mm/dd
String fltno = "";
String fltnoCondition = "";
if("".equals(request.getParameter("fltno") ) | 
	null == request.getParameter("fltno") ){
	
	fltnoCondition	="";	
	fltno = "";
}else{
	fltno = 	request.getParameter("fltno") ;
	fltnoCondition= " and dps.flt_num = lpad('"+fltno+"',4,'0') ";
}

if(fdate != null && !"".equals(fdate)){
 //檢查班表是否公布
swap3ac.PublishCheck pc = new swap3ac.PublishCheck(fdate.substring(0,4), fdate.substring(5,7));





String sql = "SELECT To_Char(str_dt_tm_loc,'yyyy/mm/dd hh24:mi') fdateDptLoc,dps.* "
		+"from duty_prd_seg_v dps where dps.act_str_dt_tm_gmt BETWEEN To_Date('"+fdate+" 0000','yyyy/mm/dd hh24mi')-2 "
		+"AND To_Date('"+fdate+" 2359','yyyy/mm/dd hh24mi')+2 "
		+"AND dps.str_dt_tm_loc BETWEEN To_Date('"+fdate+" 0000','yyyy/mm/dd hh24mi') "
		+"AND To_Date('"+fdate+" 2359','yyyy/mm/dd hh24mi') "
		+fltnoCondition
		+"AND dps.duty_cd='FLY' AND dps.delete_ind='N' AND dps.fd_ind='N' ORDER BY  str_dt_tm_loc,flt_num";

ArrayList dataAL = new ArrayList();


Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
ci.db.ConnDB cn = new ci.db.ConnDB();
Driver dbDriver = null;
//班表公布才去查詢資料
if(pc.isPublished()){
try {

	cn.setAOCIPRODCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);

	
	pstmt = conn.prepareStatement(sql);

	rs = pstmt.executeQuery();
	while (rs.next()) {
		FltObj obj = new FltObj();
		obj.setFdate(rs.getString("fdateDptLoc"));
		obj.setDpt(rs.getString("port_a"));
		obj.setArv(rs.getString("port_b"));
		obj.setFltno(rs.getString("flt_num"));
		obj.setTripno(rs.getString("trip_num"));
		dataAL.add(obj);
	}

} catch (SQLException e) {
	System.out.print("showFlt exception :"+e.toString());
} catch (Exception e) {
	System.out.print("showFlt exception :"+e.toString());
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


<body onLoad="stripe('t1')">
<div align="center">
  <%
  //班表是否公布
if(!pc.isPublished()){
%>
<p  class="errStyle1"><%=fdate.substring(0,4)+"/"+fdate.substring(5,7)%> 班表尚未正式公布，不得查詢.</p>
<%
}  else 
if(!ci.tool.CheckDate.isValidateDate(fdate)){	//不正確的日期
%>
<div class="errStyle1">Flight Date : <%=fdate%> 非有效日期!!<br>
請重新選擇Flight Date查詢條件!!</div>
<%
}else if(dataAL.size() == 0){
out.print("<div class=\"errStyle1\">NO DATA!!查無資料!!</div>");
}else{
%>
  <br>
  <span style="color:#FF0000;font-family:Verdana;font-size:10pt">Flight Query<br></span>

<table width="60%" border="1" align="center" cellpadding="1" cellspacing="1" id="t1">
  <tr class="sel2">
    <td width="23%" height="21">Start Fdate(Local)</td>
    <td width="14%">Fltno</td>
    <td width="12%">Dpt</td>
    <td width="16%">Arv</td>
    <td width="17%">Trip Detail</td>
    <td width="18%">Crew</td>
  </tr>
  <%
  for(int i=0;i<dataAL.size();i++){
  	FltObj obj = (FltObj)dataAL.get(i);
  %>
  <tr>
    <td><%=obj.getFdate()%></td>
    <td><%=obj.getFltno()%></td>
    <td><%=obj.getDpt()%></td>
    <td><%=obj.getArv()%></td>
    <td><a href="#" onClick="subwinXY('../swap3ac/tripInfo.jsp?tripno=<%=obj.getTripno()%>','t','600','250')" ><%=obj.getTripno()%></a></td>
    <td><a href="showFltCrew.jsp?tripno=<%=obj.getTripno()%>&fdate=<%=obj.getFdate()%>&fltno=<%=obj.getFltno()%>&dpt=<%=obj.getDpt()%>&arv=<%=obj.getArv()%>" target="_self"> <img height="16" src="../img2/user2.gif" width="16" border="0"></a></td>
  </tr>
  <%
  }
  %>
</table>
</div>
<%
}

}else{
%>
<body>
<p  class="errStyle1">請選擇查詢日期</p>


<%
}
%>
</body>
</html>
