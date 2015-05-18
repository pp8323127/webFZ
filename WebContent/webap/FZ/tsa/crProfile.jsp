<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page  import="java.sql.*,ci.db.ConnDB"%>

<%

String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login
String empID = request.getParameter("empID");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);

if ( sGetUsr == null ) {		
	response.sendRedirect("sendredirect.jsp");
} else if(null == request.getParameter("empID") | "".equals(request.getParameter("empID"))){
%>
Please input ID to Query.
<%	
}else{
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
Driver dbDriver = null;

ConnDB cn = new ConnDB();

String AllName = "";
String sex = "";
String birthPlace = "";
String bidthDay = "";
String mStatus = "";
String bloodType = "";
String nation= "";
String inDate = "";
String unit = "";
String position = "";
String errMsg = "";
boolean status = false;

//¨ú±oCountry column

String nationStr = "";

try {
	
	cn.setORP3FZUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);

	pstmt = conn.prepareStatement("SELECT a.employid as empno, a.cname as cname, a.lname as lname, a.fname as fname, a.sex as sex, b.bloddesc as bloddesc,upper(a.nationcd) as nationcd, b.areadesc as areadesc, b.marriage as marriage, b.unitcd as unitcd, b.postcd as postcd, b.varycd as varycd,e.cdesc as varydesc, c.cdesc as postdesc, d.cdesc as unitdesc, to_char(a.indt,'yyyy/mm/dd') as indt, to_char(b.birthdt,'yyyy/mm/dd') as birthdt,b.fjobgrp as fjobgrp, to_char(a.postdt,'yyyy/mm/dd') as postdt, to_char(a.graddt,'yyyy/mm/dd') as graddt, a.fpstlvl as fpstlvl, a.fpstgrd as fpstgrd FROM hrdb.hrvegemploy a, hrdb.hrvppemp050 b, hrdb.hrvpbpostcd c, hrdb.hrvpbunitcd d, hrdb.hrvpdvarycd e where a.employid = b.employid and a.employid = ? and a.varycd = e.varycd(+) and a.postcd = c.postcd and a.unitcd = d.unitcd");
	pstmt.setString(1,empID);
	
	rs = pstmt.executeQuery();
	while (rs.next()) {
		AllName = rs.getString("cname")+"("+ rs.getString("lname") + rs.getString("fname")+")";
		sex = rs.getString("sex");
		birthPlace = rs.getString("areadesc");
		bidthDay = rs.getString("birthdt");
		mStatus = rs.getString("marriage");
		bloodType = rs.getString("bloddesc");
		nation= rs.getString("nationcd");
		inDate = rs.getString("indt");
		unit = rs.getString("unitdesc");
		position = rs.getString("postdesc");		
	}
	
	
	


rs.close();
pstmt.close();

pstmt = conn.prepareStatement("select  Upper(ctrycd2) ctrycd2,Upper(ctrycd3) ctrycd3,Upper(country) cdesc "
					+"from dztctry WHERE  Upper(ehrcd) =?");
	pstmt.setString(1,	nation);				
	rs = pstmt.executeQuery();
	while(rs.next()){
		nationStr = rs.getString("ctrycd2")+"/"+ rs.getString("ctrycd3")+"<BR>"+rs.getString("cdesc");
	}					
rs.close();
pstmt.close();
status = true;
	
} catch (SQLException e) {
	errMsg = e.getMessage();
} catch (Exception e) {
	errMsg = e.getMessage();
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
<title>Crew Profile</title>
<style type="text/css">
body{
font-family:Verdana;
font-size:12pt;
color:#000000;
}
.colth{
	background-color:#3399CC;
	color:#FFFFFF;
}
.lf{
text-align:left;
padding-left:1em;

}
</style>
</head>

<body>
<%
if(!status){
%>
Error <%=errMsg%>
<%
}else{


%>
<br><table width="90%"  border="0" align="center" cellpadding="1" cellspacing="1" class="fortable">
  <tr  height="37.5" >
    <td colspan="6" ><div align="center" >Crew Profile </div>      </td>
  </tr>
  <%  

%>
</table>
<table width="90%"  border="1" align="center" cellpadding="1" cellspacing="1" class="fortable">
  <%  

%>
  <tr class="txtblue" height="37.5" >
    <td width="16%" class="colth" ><div align="center" >ID</div></td>
    <td width="19%" class="lf" ><%=empID%></td>
    <td width="13%" class="colth" ><div align="center" >Name</div></td>
    <td colspan=3 ><div align="center"><%=AllName%> </div></td>
  </tr>
  <tr class="txtblue" height="37.5" >
    <td width="16%" class="colth" ><div align="center" >Sex</div></td>
    <td width="19%" class="lf" ><%=sex%></td>
    <td width="13%" class="colth" ><div align="center" >Birth Place</div></td>
    <td width="17%" class="lf" ><%=birthPlace%>&nbsp;</td>
    <td width="12%" class="colth" ><div align="center" >Birthday</div></td>
    <td width="23%" class="lf" ><%=bidthDay%>&nbsp;</td>
  </tr>
  <tr class="txtblue" height="37.5" >
    <td width="16%" class="colth" ><div align="center" >Marital Status</div></td>
    <td width="19%" class="lf" ><%=mStatus%></td>
    <td width="13%" class="colth" ><div align="center" >Blood Type</div></td>
    <td width="17%" class="lf" ><%=bloodType%>&nbsp;</td>
    <td width="12%" class="colth" ><div align="center" >Nationality</div></td>
    <td width="23%" class="lf" ><%=nationStr%></td>
  </tr>
  <tr class="txtblue" height="37.5" >
    <td width="16%" class="colth" ><div align="center" >In-Date</div></td>
    <td width="19%" class="lf" ><%=inDate%></td>
    <td class="colth" ><div align="center" >Unit</div></td>
    <td class="lf" >
            
          <%=unit%></td>
    <td width="12%" class="colth" ><div align="center" >Position</div></td>
    <td width="23%" class="lf" >
            
          <%=position%></td>
  </tr>
</table>
<%
}
%>
</body>
</html>
<%
}//end of has session And request Parameter
%>