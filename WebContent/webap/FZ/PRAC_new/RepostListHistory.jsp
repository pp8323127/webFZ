<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*,ci.db.ConnDB,java.net.URLEncoder,fz.*,java.util.*"%>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) {		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} 

String yy = request.getParameter("yy");
String mm = request.getParameter("mm");
String dd = request.getParameter("dd");
//String GdYear = request.getParameter("GdYear");
//取得考績年度
String GdYear = fz.pracP.GdYear.getGdYear(yy+"/"+mm);

/*
String oFltno = null;//傳入的fltno參數
if(request.getParameter("fltno").equals("")){
	 oFltno = "";
}else{
	 oFltno = request.getParameter("fltno").trim();
}
*/
String psrCName = null;
String psrEname = null;
String psrSern = null;
String bgColor = null;

ArrayList fdateAL 	= new ArrayList();
ArrayList fltnoAL 	= new ArrayList();
ArrayList sectAL 	= new ArrayList();
ArrayList updAL 	= new ArrayList();

Connection conn = null;
Driver dbDriver = null;
Statement stmt 	= null;
ResultSet rs 	= null;
String sql 		= null;

try{
//先抓座艙長的個人資料(orp3..fztcrew)
ConnDB cn = new ConnDB();
cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
		ResultSet.CONCUR_READ_ONLY);
sql = "select name cname,ename,box from fztcrew where empno='"+ sGetUsr+"'";
rs = stmt.executeQuery(sql);

if(rs.next()){
	psrCName = rs.getString("cname");
	psrEname = rs.getString("ename");
	psrSern = rs.getString("box");
}
rs.close();		
stmt.close();
conn.close();

//先抓cflt,塞入arrayList

cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
		ResultSet.CONCUR_READ_ONLY);
		
//TODO 更改sql
if(dd != null){	//測試用sql
	//if(oFltno.equals("")){
	sql = "SELECT To_Char(fltd,'yyyy/mm/dd') fdate,fltno,sect,psrempn,psrsern,psrname,nvl(upd,'-') upd "+
		"FROM egtcflt WHERE fltd=to_date('"+yy+mm+dd+"','yyyymmdd') "+
		"order by fltd,fltno";
/*	}
	else{
	sql =  "SELECT To_Char(fltd,'yyyy/mm/dd') fdate,fltno,sect,psrempn,psrsern,psrname,upd "+
			"FROM egtcflt WHERE fltd=to_date('"+yy+mm+"','yyyymm') AND fltno='"+oFltno+"'";
	}*/
}
else{	//以下的為正式的sql

	//if(oFltno.equals("")){
	sql = "SELECT To_Char(fltd,'yyyy/mm/dd') fdate,fltno,sect,psrempn,psrsern,psrname,nvl(upd,'-') upd "+
		"FROM egtcflt WHERE fltd BETWEEN To_Date('"+yy+mm+"01 00:00','yyyymmdd hh24:mi') and Last_Day(To_Date('"+yy+mm+"','yyyymm')) "
		+" AND psrempn='"+sGetUsr+"' order by fltd,fltno";
	/*}
	else{
	sql =  "SELECT To_Char(fltd,'yyyy/mm/dd')  fdate,fltno,sect,psrempn,psrsern,psrname,upd "+
			"FROM egtcflt WHERE fltd=to_date('"+yy+mm+"','yyyymm') AND fltno='"+oFltno+"' AND psrempn='"+sGetUsr+"'";
	}
	*/
}
//out.println(sql);
rs = stmt.executeQuery(sql);
if(rs!= null){
	while (rs.next()) {
		fdateAL.add(rs.getString("fdate"));
		fltnoAL.add(rs.getString("fltno"));
		sectAL.add(rs.getString("sect"));
		updAL.add(rs.getString("upd"));

	}
}
rs.close();
stmt.close();
conn.close();

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

if(fdateAL.size() !=0){ 
%>
<div align="center">
  <span class="txttitletop">Cabin' Report List --<%=mm+"/"+yy%> </span> </div>
  <table border="0" width="72%" align="center" cellpadding="2" cellspacing="0">
   <tr >
    <td width="16%" height="23" class="txtblue" >Empno:<%=sGetUsr%></td>
    <td width="24%" class="txtblue">Name:<%=psrCName%></td>
    <td width="29%"  class="txtblue">EName:<%=psrEname%></td>
    <td width="31%"  class="txtblue">Sern:<%=psrSern%></td>
  </tr>
 </table> 
<table width="72%"  border="0" align="center" cellpadding="2" cellspacing="0" class="fortable">
  <tr class="tablehead3">
    <td width="16%">Fdate</td>
    <td width="15%">Fltno</td>
    <td width="15%">Sect</td>
    <td width="24%">View/Edit</td>
  </tr>
  <%

	for(int i=0;i<fdateAL.size();i++){
		
	
		if( i%2 == 0){
			bgColor = "#CCCCCC";
		}else{
			bgColor = "#FFFFFF";
		}
	
  %>
  <tr class="tablebody" bgcolor="<%=bgColor%>">
    <td height="28" class="tablebody"><%=(String)fdateAL.get(i) %></td>
    <td class="tablebody"><%=(String)fltnoAL.get(i) %></td>
    <td class="tablebody"><%=(String)sectAL.get(i) %></td>
    <td class="tablebody">
	<%
		//upd = null or Y 時，允許座艙長編輯
		if("-".equals(updAL.get(i)) || "Y".equals(updAL.get(i)) ){
	%>
	<a href="FltIrrList2.jsp?fdate=<%=(String)fdateAL.get(i)%>&fltno=<%=(String)fltnoAL.get(i)%>&GdYear=<%=GdYear%>&purEmpno=<%=sGetUsr%>" target="_self">
	<font color="red"><u><strong>請補交報告</strong></u></font></a>
	<%
		}else{
	%>
	<a href="PURreport_print.jsp?fdate=<%=(String)fdateAL.get(i)%>&fltno=<%=(String)fltnoAL.get(i)%>&section=<%=(String)sectAL.get(i)%>" target="_blank">
	<font color="#FF33CC"><u>View</u></font></a>
	<%
	}
	%>
	</td>
  </tr>
<%
		
	}
%>  
</table>
<%

}else{
	%>
	<div class="errStyle1">No DATA!!</div>
	
	<%
}
%>

</body>
</html>
<%

%>
