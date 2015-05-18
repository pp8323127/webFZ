<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*,ci.db.ConnDB,java.net.URLEncoder,fz.*,java.util.*"%>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (sGetUsr == null) {		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} 

String yy = request.getParameter("yy");
String mm = request.getParameter("mm");
/*
String oFltno = null;//傳入的fltno參數
if(request.getParameter("fltno").equals("")){
	 oFltno = "";
}else{
	 oFltno = request.getParameter("fltno").trim();
}
*/
String fdate 	= null;
String fltno 	= null;//資料庫中抓出來的fltno
String sect 	= null;
String flag = null;	//Y: 有報告 N:無報告
String dd = null;
String GdYear = null;
String bgColor = null;
String psrSern = null;
String psrName = null;


Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
ResultSet rs = null;
String sql = null;
String scheSql = null;
int rowCount = 0;

try{
ConnDB cn = new ConnDB();
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
		ResultSet.CONCUR_READ_ONLY);

	sql = "SELECT To_Char(fltd,'yyyy/mm/dd') fdate,fltno,sect,cpname,cpno,psrempn,psrsern,psrname,upd "+
		"FROM egtcflt WHERE fltd BETWEEN To_Date('"+yy+mm+"01 00:00','yyyymmdd hh24:mi') "
		+"and Last_Day(To_Date('"+yy+mm+"','yyyymm'))  and upd='N' order by fdate, fltno";

rs = stmt.executeQuery(sql);
if(rs.next()){//抓出資料筆數
	rs.last();
	rowCount = rs.getRow();
	rs.beforeFirst();
}

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>客艙報告 --歷史資料</title>
<link href="style2.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="../errStyle.css">

</head>
<body>
<%
if(rowCount ==0){
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
%>
<div class="errStyle1">查無資料!!No DATA!!</div>
<%

}
else{
%>
<div align="center">
  <span class="txttitletop">Cabin' Report List --<%=mm+"/"+yy%> </span> 
  <table width="72%"  border="0" align="center" cellpadding="2" cellspacing="0" class="fortable">
  <tr class="tablehead3">
    <td width="20%">Fdate</td>
    <td width="14%">Fltno</td>
    <td width="12%">Sect</td>
    <td width="13%">CM_Sern</td>
    <td width="18%">CM_Name</td>
    <td width="23%">View</td>
  </tr>
  <%
	if(rs != null){
		while(rs.next()){

		fdate 	= rs.getString("fdate");
		fltno 	= rs.getString("fltno").trim();
		sect 	= rs.getString("sect").trim();
		psrSern = rs.getString("psrsern");
		psrName = rs.getString("psrname");


  	if((rs.getRow())%2 == 0){
		bgColor = "#CCCCCC";
	}else{
		bgColor = "#FFFFFF";
	}
	
  %>
  <tr class="tablebody" bgcolor="<%=bgColor%>">
    <td height="28" class="tablebody"><%=fdate %></td>
    <td class="tablebody"><%=fltno %></td>
    <td class="tablebody"><%=sect %></td>
    <td class="tablebody"><%=psrSern%></td>
    <td class="tablebody"><%=psrName%></td>
    <td class="tablebody"><a href="PURreport_print.jsp?fdate=<%=fdate%>&fltno=<%=fltno%>&section=<%=sect%>" target="_self"><font color="#FF33CC"><u>View</u></font></a>

	</td>
  </tr>
<%
		}
	}
%>  
</table>

</div>
</body>
</html>
<%
}//end of else(有無資料）
}
catch (Exception e)
{
	
	  out.print(e.toString());
		//  response.sendRedirect("../showMessage.jsp?messagestring="+URLEncoder.encode("系統忙碌中，請稍後再試"));
}
finally
{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>
