<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="java.sql.*,java.sql.Date,fz.*"%>

<%
String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login
/*response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);*/

if (session.isNew() | sGetUsr == null) 
{		
  response.sendRedirect("sendredirect.jsp");
} 


String empno = request.getParameter("empno");



Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
String sql = null;
ci.db.ConnDB cn = new ci.db.ConnDB();

 Driver dbDriver = null;
ArrayList empnoAL = new ArrayList();
ArrayList cnameAL = new ArrayList();
ArrayList enameAL = new ArrayList();
ArrayList RECTYPEAL = new ArrayList();
ArrayList YYAL = new ArrayList();
ArrayList NAMEAL = new ArrayList();
ArrayList FLEET_CDAL = new ArrayList();
ArrayList CAAL = new ArrayList();
ArrayList FOAL = new ArrayList();
ArrayList FEAL = new ArrayList();
ArrayList INSTAL = new ArrayList();
ArrayList NIGHTAL = new ArrayList();
ArrayList DUTYIPAL = new ArrayList();
ArrayList DUTYSFAL = new ArrayList();
ArrayList DUTYCAAL = new ArrayList();
ArrayList DUTYFOAL = new ArrayList();
ArrayList DUTYIFEAL = new ArrayList();
ArrayList DUTYFEAL = new ArrayList();
ArrayList TODAYAL = new ArrayList();
ArrayList TONITAL = new ArrayList();
ArrayList LDDAYAL = new ArrayList();
ArrayList LDNITAL= new ArrayList(); 
ArrayList MMAL = new ArrayList(); 
ArrayList  PICAL = new ArrayList(); 

try {

cn.setDFUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);

pstmt = conn.prepareStatement("SELECT d.*,c.NAME cname,ename FROM dftcrec d,dftcrew c WHERE d.staff_num= c.empno "
			+"and d.staff_num=? AND d.FLEET_CD <> 'OPS' ORDER BY yy desc,mm");
		
pstmt.setString(1,empno);
	
	rs = pstmt.executeQuery();
	while (rs.next()) {
		empnoAL.add(rs.getString("staff_num"));
		cnameAL.add(rs.getString("cname"));
		enameAL.add(rs.getString("ename"));	
		RECTYPEAL.add(rs.getString("RECTYPE"));
		YYAL.add(rs.getString("YY"));		
		FLEET_CDAL.add(rs.getString("fleet_cd"));
		CAAL.add(rs.getString("ca"));
		FOAL.add(rs.getString("fo"));
		FEAL.add(rs.getString("fe"));
		INSTAL.add(rs.getString("inst"));
		NIGHTAL.add(rs.getString("night"));
		DUTYIPAL.add(rs.getString("DUTYIP"));
		DUTYSFAL.add(rs.getString("DUTYSF"));
		DUTYCAAL.add(rs.getString("DUTYCA"));
		DUTYFOAL.add(rs.getString("DUTYFO"));
		DUTYIFEAL.add(rs.getString("DUTYIFE"));
		DUTYFEAL.add(rs.getString("DUTYFE"));
		TODAYAL.add(rs.getString("TODAY"));
		TONITAL.add(rs.getString("TONIT"));
		LDDAYAL.add(rs.getString("LDDAY"));
		LDNITAL.add(rs.getString("LDNIT"));
		MMAL.add(rs.getString("mm"));
		PICAL.add(rs.getString("pic"));
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
<html>
<head>
<title>Crew Record List</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<meta http-equiv="pragma" content="no-cache">
<link href="../menu.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="#FFFFFF" text="#000000" >
<%  if (empnoAL.size()==0) { %>
<div align="center"><br>
  <span class="txtblue">查無資料<br>
  No Record<br>
  </span>
  <br>
</div>
<% } else{  %>
  <table width="87%" border="0">
    <tr>
      <td width="39%" height="57"><p align="left" class="txtblue">Empno : <%= request.getParameter("empno")%> <br>
        Name :
            <%=cnameAL.get(0)%><br>
        </p>
      </td>
      <td width="61%" valign="middle" class="txtblue">Click Month to Edit Crew Record<br>
      點選月份以編輯 Crew Record </td>
    </tr>
  </table>

<div align="center">
    <table width="99%" class="fortable">
      <tr>
        <td width="6%" class="tablehead3">
        <div align="center">RecType</div></td>
        <td width="3%" class="tablehead3">
        <div align="center">Year</div></td>
        <td width="4%" class="tablehead3">
        <div align="center">Month</div></td>
        <td width="7%" class="tablehead3">
        <div align="center">Fleet_cd</div></td>
        <td width="8%" class="tablehead3">
        <div align="center">CA</div></td>
        <td width="0%" class="tablehead3">
        <div align="center">FO</div></td>
        <td width="2%" class="tablehead3">
        <div align="center">FE</div></td>
        <td width="1%" class="tablehead3">
        <div align="center">Inst</div></td>
        <td width="2%" class="tablehead3">
        <div align="center">Night</div></td>
        <td width="3%" class="tablehead3">
        <div align="center">DutyIP</div></td>
        <td width="4%" class="tablehead3">
        <div align="center">DutySF</div></td>
        <td width="5%" class="tablehead3">
        <div align="center">DutyCA</div></td>
        <td width="5%" class="tablehead3">
        <div align="center">DutyFO</div></td>
        <td width="5%" class="tablehead3">
        <div align="center">DutyIFE</div></td>
        <td width="5%" class="tablehead3">
        <div align="center">DutyFE</div></td>
        <td width="5%" class="tablehead3">
        <div align="center">ToDay</div></td>
        <td width="4%" class="tablehead3">
        <div align="center">ToNit</div></td>
        <td width="4%" class="tablehead3">
        <div align="center">LdDay</div></td>
        <td width="4%" class="tablehead3">
        <div align="center">LdNit</div></td>
        <td width="23%">
        <div align="center" class="tablehead3">PIC</div></td>
      </tr>
      <% for(int i = 0;i<empnoAL.size();i++){ %>
      <tr>
        <td width="5%" class="tablebody"><%=RECTYPEAL.get(i)%> </td>
        <td width="5%" class="tablebody"><%=YYAL.get(i)%> </td>
        <td width="5%" class="tablebody"><a href='crewrecdetail.jsp?empname=<%=cnameAL.get(i)%>&empno=<%=request.getParameter("empno")%>&fleet=<%=FLEET_CDAL.get(i)%>&rectype=<%=RECTYPEAL.get(i)%>&yy=<%=YYAL.get(i)%>&mm=<%=MMAL.get(i)%>'><%=MMAL.get(i)%></a> </td>
        <td class="tablebody"><%=FLEET_CDAL.get(i)%></td>
        <td width="5%" class="tablebody"><%=CAAL.get(i)%> </td>
        <td width="5%" class="tablebody"><%=FOAL.get(i)%> </td>
        <td width="5%" class="tablebody"><%=FEAL.get(i)%> </td>
        <td width="5%" class="tablebody"><%=INSTAL.get(i)%> </td>
        <td width="5%" class="tablebody"><%=NIGHTAL.get(i)%> </td>
        <td width="5%" class="tablebody"><%=DUTYIPAL.get(i)%> </td>
        <td width="5%" class="tablebody"><%=DUTYSFAL.get(i)%> </td>
        <td width="5%" class="tablebody"><%=DUTYCAAL.get(i)%> </td>
        <td width="5%" class="tablebody"><%=DUTYFOAL.get(i)%> </td>
        <td width="5%" class="tablebody"><%=DUTYIFEAL.get(i)%> </td>
        <td width="5%" class="tablebody"><%=DUTYFEAL.get(i)%> </td>
        <td width="5%" class="tablebody"><%=TODAYAL.get(i)%> </td>
        <td width="5%" class="tablebody"><%=TONITAL.get(i)%> </td>
        <td width="5%" class="tablebody"><%=LDDAYAL.get(i)%> </td>
        <td width="5%" class="tablebody"><%=LDNITAL.get(i)%> </td>
        <td width="5%" class="tablebody"><%=PICAL.get(i)%> </td>
      </tr>
      <%
	}
%>
    </table>
</div>
<% } /* end !Recordset1_isEmpty */ %>
</div>
<p>&nbsp; </p>
</body>
</html>
