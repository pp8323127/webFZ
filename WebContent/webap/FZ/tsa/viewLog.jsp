<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="java.sql.*,ci.db.*" %>
<%
String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);

if (sGetUsr == null) 
{		//check if not login
  %> <jsp:forward page="sendredirect.jsp" /> <%
} 
String yyyy		= request.getParameter("year");
String mm		= request.getParameter("month");
String dd		= request.getParameter("day");
String selSysname	= request.getParameter("sysname");
String selEmpno	 = null;
if(  null !=request.getParameter("empno"))
	selEmpno = request.getParameter("empno");

ConnDB cn = new ConnDB();

Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
String sql = null;
int  sqlCase = 0;


ArrayList loginTimeAL 	= new ArrayList();
ArrayList useridAL 		= new ArrayList();
ArrayList sysnameAL 	= new ArrayList();
dz.CrewName crewName = new dz.CrewName();
String bgColor= null;
 Driver dbDriver = null;
//顯示OP人員名字
tsa.CIIViewLogUserList vUser = new 	tsa.CIIViewLogUserList();
try{
cn.setDFUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);

stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
//一.選年月
if("N".equals(dd)){					
	//1.有員工號
	if(!"".equals(selEmpno)){
		if(!"N".equals(selSysname))	//有特定的function
			sqlCase=1;
		else
			sqlCase =2;
	}else{//2.無員工號
		if(!"N".equals(selSysname))	//有特定的function
			sqlCase=3;
		else
			sqlCase =4;
	}
	
}else{	//二.選年月日
	//1.有員工號
	if(!"".equals(selEmpno)){
		if(!"N".equals(selSysname))	//有特定的function
			sqlCase =5;
		else
			sqlCase =6;
	}else{//2.無員工號
		if(!"N".equals(selSysname))	//有特定的function
			sqlCase=7;
		else
			sqlCase =8;
	}
}

switch (sqlCase) {
	case 1 :
		sql = "select to_char(login_time,'yyyy/mm/dd HH24:MI') login_time,userid,sysname "+
			"from dftclog where to_char(login_time,'yyyymm')='"+
			yyyy+mm+"' and userid='"+ selEmpno+"' and sysname='"+selSysname+"' order by login_time";	
		break;
	case 2 :
		sql = "select to_char(login_time,'yyyy/mm/dd HH24:MI') login_time,userid,sysname "+
			"from dftclog where to_char(login_time,'yyyymm')='"+
			yyyy+mm+"' and userid='"+ selEmpno+"' order by login_time";	
		break;
	case 3 :
		sql = "select to_char(login_time,'yyyy/mm/dd HH24:MI') login_time,userid,sysname "+
			"from dftclog where to_char(login_time,'yyyymm')='"+
			yyyy+mm+"' and sysname='"+selSysname+"' order by login_time";	
		break;
	case 4 :
		sql = "select to_char(login_time,'yyyy/mm/dd HH24:MI') login_time,userid,sysname "+
			"from dftclog where to_char(login_time,'yyyymm')='"+
			yyyy+mm+"'  order by login_time";	
		break;
	case 5 :
		sql = "select to_char(login_time,'yyyy/mm/dd HH24:MI') login_time,userid,sysname "+
			"from dftclog where to_char(login_time,'yyyymmdd')='"+
			yyyy+mm+dd+"' and userid='"+ selEmpno+"' and sysname='"+selSysname+"' order by login_time";	
		break;
	case 6 :
		sql = "select to_char(login_time,'yyyy/mm/dd HH24:MI') login_time,userid,sysname "+
			"from dftclog where to_char(login_time,'yyyymmdd')='"+
			yyyy+mm+dd+"' and userid='"+ selEmpno+"' order by login_time";	
		break;
	case 7 :
		sql = "select to_char(login_time,'yyyy/mm/dd HH24:MI') login_time,userid,sysname "+
			"from dftclog where to_char(login_time,'yyyymmdd')='"+
			yyyy+mm+dd+"' and sysname='"+selSysname+"' order by login_time";	
		break;
	case 8 :
		sql = "select to_char(login_time,'yyyy/mm/dd HH24:MI') login_time,userid,sysname "+
			"from dftclog where to_char(login_time,'yyyymmdd')='"+
			yyyy+mm+dd+"' order by login_time";	
		break;
	default :
		break;
}

rs = stmt.executeQuery(sql);
while(rs.next()){
	loginTimeAL.add(rs.getString("login_time"));
	useridAL.add(rs.getString("userid"));
	sysnameAL.add(rs.getString("sysname"));
}

	
}catch(Exception e){
	out.print(e.toString());
}finally{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}

}


%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>View Log</title>
<link href="../menu.css" rel="stylesheet" type="text/css">
</head>

<body>
<div align="center">
  <%
if(loginTimeAL.size() >0){
%>
  <span class="txttitle">Log of Login</span></div>
<table width="80%"  border="0" align="center" cellpadding="0" cellspacing="1" class="fortable">
  <tr class="tablehead3">
    <td width="25%">Login_Time</td>
    <td width="16%">UserID</td>
    <td width="27%">Name</td>
    <td width="11%">Fleet</td>
    <td width="21%">Login_Function</td>
  </tr>
  <%
	for(int i=0;i<loginTimeAL.size();i++)  {
		if(i%2 ==0)
			bgColor = "#FFFFFF";
		else
			bgColor="#CCCCCC";
			
  %>
  <tr bgcolor="<%=bgColor%>">
    <td>
      <div align="center" class="txtblue"><%=(String)loginTimeAL.get(i)%></div>
    </td>
    <td>
      <div align="center" class="txtblue"><%=(String)useridAL.get(i)%></div>
    </td>
    <td>
      <div align="left" class="txtblue">&nbsp;<%
	  if(!"".equals(crewName.getCname((String)useridAL.get(i)))){
	  	out.print(crewName.getCname((String)useridAL.get(i))+" "+crewName.getEname((String)useridAL.get(i)));
	  }else{
		out.print(vUser.getCname((String)useridAL.get(i)));
	  } 	  
	  
	  %></div>
    </td>
    <td>
      <div align="center"><span class="txtblue"><%
  	  if(!"".equals(crewName.getFleet((String)useridAL.get(i)))){
	  	out.print(crewName.getFleet((String)useridAL.get(i)));
	  }else{
		out.print(vUser.getFleet((String)useridAL.get(i)));
	  } 
	  	
		
	%></span></div>
    </td>
    <td>
      <div align="left">&nbsp;<span class="txtblue"><%=(String)sysnameAL.get(i)%></span></div>
    </td>
  </tr>
  <%
  }
  %>
  
</table>
<div align="center">
  <%
}
else{
out.print("<div align=\"center\"><span class=\"txttitletop\">NO DATA</span></div>");
}
%>

</body>
</html>
