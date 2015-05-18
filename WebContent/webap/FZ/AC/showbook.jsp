<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="fz.*,ci.db.*,java.sql.*"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
 response.sendRedirect("../sendredirect.jsp");
} 
String bcolor = null;


Connection conn = null;
ConnDB cn = new ConnDB();
Driver dbDriver = null;
Statement stmt = null;
ResultSet rs = null;

ArrayList dataAL = new ArrayList();
String year = request.getParameter("year");
String month = request.getParameter("month");
ArrayList commAL = new ArrayList();

try{
cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement();

String sql = "select fdate,fltno,tripno,put_date putdate,comments from fztsput where empno = '"+ sGetUsr
		+ "' ";
		
if( request.getParameter("year") != null && !"".equals(request.getParameter("year"))){
sql +="and fdate like '"+year+"/"+month+"/%'" ;
}
		

rs = stmt.executeQuery(sql); 

while(rs.next()){
	swap3ac.CrewSkjObj obj = new swap3ac.CrewSkjObj();
	obj.setFdate(rs.getString("fdate"));
	obj.setDutycode(rs.getString("fltno"));
	obj.setTripno(rs.getString("tripno"));
	commAL.add(rs.getString("comments"));
	dataAL.add(obj);
}

}catch (Exception e){
	out.print(e.toString());
}finally{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}

%>


<html>
<head>
<title>交換班表記錄</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="../menu.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="../errStyle.css">
</head>

<body>
<%
if(dataAL.size() == 0){
%>
<div class="errStyle1">No Put Schedule Record Found !!<br>您沒有任何丟出班的紀錄</div>
<%

}else{
%>
<table width="70%" border="0" align="center">
  <tr>
	<td width="8%" height="40"></td>
	<td width="87%">
	  <div align="center" class="txttitletop">我的丟班資訊 Put Schedule
	    record </div>
	  </td>
	<td width="5%"><div align="right"><a href="javascript:window.print()"><img src="../images/print.gif" border="0"></a></div></td>
</tr>
</table>
<form name="form1" method="post" action="upddelete.jsp">
  <table width="70%" border="1" align="center" cellpadding="0" cellspacing="0">
    <tr class="tablehead3"> 
      <td width="22%">FltDate</td>
      <td width="14%">FltNo</td>
      <td width="12%">TripNo</td>
      <td width="8%">Detail</td>
      <td width="33%">Comments</td>
      <td width="11%">cancel</td>
    </tr>
    <%
  for(int i=0;i<dataAL.size();i++){
	swap3ac.CrewSkjObj obj = (swap3ac.CrewSkjObj)dataAL.get(i);

			if (i%2 == 0){
				bcolor = "#C9C9C9";
			}else{
				bcolor = "#FFFFFF";
			}
%>
    <tr   bgcolor="<%=bcolor %>"> 
      <td class="tablebody"><%=obj.getFdate() %></td>
      <td class="tablebody"><a href="../favorfltquery.jsp?fltno=<%=obj.getDutycode() %>" target="_blank"><%=obj.getDutycode() %></a></td>
      <td class="tablebody"><%=obj.getTripno() %></td>
      <td class="tablebody"> 
        <div align="center"><a href="../swap3ac/tripInfo.jsp?tripno=<%=obj.getTripno()%>" target="_blank"> <img src="../img2/doc2.gif" border="0" alt="show Schedule Detail"></a></div>
      </td>
      <td class="tablebody"> 
    <%=commAL.get(i)%>
      </td>
      <td>    <div align="center"> 
          <input type="checkbox" name="checkdelete" value="<%=obj.getTripno()%>">
        </div></td>
    </tr>
    <%

}
  %>
  </table>
  <p align="center" class="txtblue">
    <input type="submit" name="Submit" value="Cancel" class="btm">
    <input type="hidden" name="year"  value="<%=year%>">
    <input type="hidden" name="month"  value="<%=month%>">
<br>
  </p>
</form>
<%
}
%>
</body>
</html>
