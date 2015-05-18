<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="java.sql.*"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
//String username = (String) session.getAttribute("cname") ; 

if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
	//response.sendRedirect("/webfz/FZAC/sendredirect.jsp");
} 

String conf = request.getParameter("conf");//Y : agress, N : reject
String cdate = request.getParameter("cdate");//A : apply date, C : check date
String sDate = request.getParameter("sdate");
String eDate = request.getParameter("edate");
String empno = request.getParameter("empno").trim();
StringBuffer sql = new StringBuffer();
StringBuffer reportTitle  = new StringBuffer();

sql.append("SELECT f.*,To_char(f.checkDate,'yyyy/mm/dd hh24:mi') cdate,");
sql.append("To_char(f.newDate,'yyyy/mm/dd hh24:mi') ndate ");
sql.append("FROM fztformf f WHERE station='KHH' ");



if ("A".equals(conf)) {
	sql.append(" AND ed_check is not null ");
	reportTitle.append(" �֭�/�h�^ ");
} else {
	sql.append(" AND ed_check ='" + conf + "' ");

	if ("Y".equals(conf)) {
		reportTitle.append(" �֭� ");
	} else {
		reportTitle.append(" �h�^ ");
	}
}
reportTitle.append("�ӽг�O��");

if ("A".equals(cdate)) {
	sql.append("AND newdate BETWEEN To_Date('" + sDate
			+ " 0000','yyyy/mm/dd hh24mi') ");
	sql
			.append("AND To_Date('" + eDate
					+ " 2359','yyyy/mm/dd hh24mi') ");
	reportTitle.insert(0, " �ӽФ���G " + sDate + "~" + eDate + " ");

} else if ("C".equals(cdate)) {
	sql.append("AND checkdate BETWEEN To_Date('" + sDate
			+ " 0000','yyyy/mm/dd hh24mi') ");
	sql
			.append("AND To_Date('" + eDate
					+ " 2359','yyyy/mm/dd hh24mi') ");
	reportTitle.insert(0, " �B�z����G " + sDate + "~" + eDate + " ");

}

if (!"".equals(empno) && null != empno) {
	sql.append(" AND (aempno='" + empno + "' or rempno='" + empno
			+ "') ");
}

sql.append(" ORDER by FORMNO");

Connection conn = null;
Driver dbDriver = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
ci.db.ConnDB cn = new ci.db.ConnDB();

String errMsg = "";
boolean status = false;
ArrayList dataAL = null;

try {

	cn.setORP3FZUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);

	pstmt = conn.prepareStatement(sql.toString());

	rs = pstmt.executeQuery();
	while (rs.next()) {
		if (dataAL == null) {
			dataAL = new ArrayList();
		}
		swap3ackhh.SwapFormObj obj = new swap3ackhh.SwapFormObj();
		obj.setFormno(rs.getString("formno"));
		obj.setAEmpno(rs.getString("aempno"));
		obj.setACname(rs.getString("acname"));
		obj.setAGrps(rs.getString("agroups"));
		obj.setREmpno(rs.getString("rempno"));
		obj.setRCname(rs.getString("rcname"));
		obj.setRGrps(rs.getString("rgroups"));
		obj.setNewdate(rs.getString("ndate"));
		obj.setCheckdate(rs.getString("cdate"));
		obj.setEd_check(rs.getString("ed_check"));
		obj.setCheckuser(rs.getString("checkuser"));
		obj.setComments(rs.getString("comments"));
		dataAL.add(obj);

	}

	rs.close();
	pstmt.close();
	conn.close();
	status = true;
} catch (Exception e) {
	errMsg = e.toString();
} finally {
	if (rs != null)
		try {
			rs.close();
		} catch (SQLException e) {}
	if (pstmt != null)
		try {
			pstmt.close();
		} catch (SQLException e) {}
	if (conn != null)
		try {
			conn.close();
		} catch (SQLException e) {}
}







String bcolor="";

%>
<html>
<head>
<title>Apply Query</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" type="text/css" href="../realSwap/realSwap.css">
<link rel="stylesheet" href="../style/errStyle.css" type="text/css">

<script language="javascript" src="subWindow.js"></script>

</head>

<body >
<%
if(!status){
out.print("ERROR:"+errMsg);
}else{
	if(dataAL == null){
%>
<div class="errStyle1">�d�߱���L�w�B�z�ӽг�.<br>
�|���B�z���ӽг�A�Цܡu�ӽг�B�z�v�d��.
</div>
<%
	}else{
	

%>
<div align="center">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td width="93%" align="center" class="r" ><%=reportTitle.toString()%></td>
      <td width="7%"> 
        <div align="right"><a href="javascript:window.print()"> <img src="../print.gif" width="17" height="15" border="0" alt="�C�L"></a> 
        </div>
      </td>
    </tr>
  </table>
  <table width="100%" cellspacing="1" cellpadding="1" style="border-collapse:collapse;border:1pt double #00248F " >
    <tr class="tableh5">
	  <td >No</td>
	  <td >Empno</td>
	  <td >Applicant</td>
	  <td >Group</td>
	  <td >Empno</td> 
      <td >Substitute</td>
	  <td >Group</td>
      <td >ED</td>
	  <td >CheckDate</td>
	  <td >CheckUser</td>
      <td >ApplyDate </td>
      <td >EDComments </td>
	  <td >View</td>
    </tr>
    <%
		for(int i=0;i<dataAL.size();i++){
			swap3ackhh.SwapFormObj obj = (swap3ackhh.SwapFormObj)dataAL.get(i);		
			if (i%2 == 0){
				bcolor = "#FFFFFF";
			}else{
				bcolor = "#DAE9F8";
			}
%>
    <tr bgcolor="<%=bcolor%>"> 
      <td ><%=obj.getFormno()%></td>
	  <td ><%=obj.getAEmpno()%></td>
	  <td ><%=obj.getACname()%></td>
	  <td ><%=obj.getAGrps()%></td>
      <td ><%=obj.getREmpno()%></td>
	  <td ><%=obj.getRCname()%></td>
	  <td ><%=obj.getRGrps()%></td>
      <td ><%=obj.getEd_check()%></td>
      <td ><%=obj.getCheckdate()%></td>
	  <td ><%=obj.getCheckuser()%></td>
      <td ><%=obj.getNewdate()%></td>
      <td ><div align="left"><%=obj.getComments()%></div></td>
	  <td>
        <div align="center"><a href="#" onClick="subwin('../showForm.jsp?formno=<%=obj.getFormno()%>','showform')"> <img src="img/view.gif" border="0" alt="Detail"></a></div>
	  </td>
    </tr>
    <%
	}

	%>

  </table>
<span class="r">Total Records : <%=dataAL.size()%></span>


</div>
<%
	
	
	}
}

%>

</body>
</html>
