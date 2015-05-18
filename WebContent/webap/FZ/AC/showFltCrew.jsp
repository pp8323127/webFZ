<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*" errorPage="" %>
<%!
public class CrewObj {
	private String empno;
	private String sern;
	private String cname;
	private String ename;
	private String grp;
	private String acting_rank;
	private String spCode;
	public String getActing_rank() {
		return acting_rank;
	}
	public void setActing_rank(String acting_rank) {
		this.acting_rank = acting_rank;
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
	public String getGrp() {
		return grp;
	}
	public void setGrp(String grp) {
		this.grp = grp;
	}
	public String getSern() {
		return sern;
	}
	public void setSern(String sern) {
		this.sern = sern;
	}
	public String getSpCode() {
		return spCode;
	}
	public void setSpCode(String spCode) {
		this.spCode = spCode;
	}

}
%>
<%
String tripno = "";
if("".equals(request.getParameter("tripno") ) | 
	null == request.getParameter("tripno") ){

%>
No DATA!!
<%
}else{

tripno =request.getParameter("tripno");


ArrayList dataAL = new ArrayList();
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
ci.db.ConnDB cn = new ci.db.ConnDB();
Driver dbDriver = null;
//		取得中文姓名
aircrew.CrewCName cc = new aircrew.CrewCName();
try {
	cn.setAOCIPRODCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);

	
	pstmt = conn.prepareStatement("SELECT r.staff_num,r.special_indicator spCode,r.acting_rank,"
			+"To_Number(nvl(c.seniority_code,'0')) sern,c.section_number,c.other_surname||' '||c.other_first_name ename "
			+"FROM roster_v r ,crew_v c WHERE r.staff_num = c.staff_num  "
			+"AND r.series_num=? AND r.delete_ind='N' "
			+"ORDER BY r.staff_num,r.acting_rank ");
	pstmt.setString(1,tripno);
	rs = pstmt.executeQuery();
	while (rs.next()) {
		CrewObj obj = new CrewObj();
		obj.setActing_rank(rs.getString("acting_rank"));
		obj.setCname(cc.getCname(rs.getString("staff_num")));
		obj.setEname(rs.getString("ename"));
		obj.setEmpno(rs.getString("staff_num"));
		obj.setGrp(rs.getString("section_number"));
		obj.setSern(rs.getString("sern"));
		obj.setSpCode(rs.getString("spCode"));
		dataAL.add(obj);
	}

} catch (SQLException e) {
	System.out.print(e.toString());
} catch (Exception e) {
	System.out.print(e.toString());
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
	

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" type="text/css" href="../errStyle.css">
<link rel="stylesheet" type="text/css" href="../style2.css">
<script type="text/javascript" language="javascript" src="../js/color.js"></script>
<script language="javascript" src="../js/subWindow.js" type="text/javascript"></script>

<title>航班組員查詢</title>
</head>

<body onLoad="stripe('t1')">
<div align="center">
  <%
if(dataAL.size() == 0){
	out.print("<div class=\"errStyle1\">NO DATA!!查無資料!!</div>");

}else{
%>
  <span  style="color:#FF0000;font-family:Verdana ;font-size:10pt">Flight Crew <br>
<%=request.getParameter("fdate")+"&nbsp;"+request.getParameter("fltno")+"&nbsp;"+request.getParameter("dpt")+request.getParameter("arv")%>&nbsp;Tripno:<a href="#" onClick="subwinXY('../swap3ac/tripInfo.jsp?tripno=<%=tripno%>','t','600','250')" ><%=tripno%></a></span>
  

  <%
}
%>
  <table width="60%" border="1" align="center" cellpadding="1" cellspacing="1" id="t1">
    <tr class="sel3">
      <td width="15%">Empno</td>
      <td width="11%">Sern</td>
      <td width="15%">Cname</td>
      <td width="27%">Ename</td>
      <td width="11%">SpCode</td>
      <td width="8%">Group</td>
      <td width="8%">Acting_rank</td>
      <td width="13%">Skj</td>
    </tr>
    <%
	for(int i=0;i<dataAL.size();i++){
		CrewObj obj =(CrewObj)dataAL.get(i);
	%>
    <tr>
      <td><a href="#" onClick="subwinXY('SingleCrew.jsp?empno=<%=obj.getEmpno()%>','t','800','250')" ><%=obj.getEmpno()%></a></td>
      <td><%=obj.getSern()%></td>
      <td><%=obj.getCname()%></td>
      <td>
        <div align="left">&nbsp;<%=obj.getEname()%></div>
      </td>
      <td><%=obj.getSpCode()%></td>
      <td><%=obj.getGrp()%></td>
      <td><%=obj.getActing_rank()%></td>
      <td><a href="crewSkj.jsp?empno=<%=obj.getEmpno()%>&year=<%=request.getParameter("fdate").substring(0,4)%>&month=<%=request.getParameter("fdate").substring(5,7)%>" target="_self"><img src="../img2/doc5.gif" border="0"></a></td>
    </tr>
    <%
	}
	%>
  </table>
  <br>
</div>
</body>
</html>
<%
}//end of has requestParameter
%>