<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="java.sql.*,ci.db.*,ci.tool.*"%>
<%
// 2011-02-11 mod INSERT into 
String userid = (String) session.getAttribute("cs55.usr") ; //get user id if already login


if (userid == null | session.isNew()) {		//check user session start first
	response.sendRedirect("sendredirect.jsp");
} 

	String staff_num = request.getParameter("staff_num");
	String rectype = 	request.getParameter("rectype");
	String yyyy = request.getParameter("yyyy");
	String mm = request.getParameter("mm");
	String fleet_cd = request.getParameter("fleet_cd");	
	String ca 		= request.getParameter("ca");
	String fo 		= request.getParameter("fo");
	String fe 		= request.getParameter("fe");
	String inst	 	= request.getParameter("inst");
	String night		= request.getParameter("night");
	String dutyip		= request.getParameter("dutyip");
	String dutysf		= request.getParameter("dutysf");
	String dutyca		= request.getParameter("dutyca");
	String dutyfo		= request.getParameter("dutyfo");
	String dutyife		= request.getParameter("dutyife");
	String dutyfe		= request.getParameter("dutyfe");
	String today		= request.getParameter("today");
	String tonit		= request.getParameter("tonit");
	String ldday		= request.getParameter("ldday");
	String ldnit		= request.getParameter("ldnit");
	String pic 		= request.getParameter("pic");
/*	
	String ca 		= TimeUtil.hhmmToMin(request.getParameter("ca"));
	String fo 		= TimeUtil.hhmmToMin(request.getParameter("fo"));
	String fe 		= TimeUtil.hhmmToMin(request.getParameter("fe"));
	String inst	 	= TimeUtil.hhmmToMin(request.getParameter("inst"));
	String night 	= TimeUtil.hhmmToMin(request.getParameter("night"));
	String dutyip 	= TimeUtil.hhmmToMin(request.getParameter("dutyip"));
	String dutysf 	= TimeUtil.hhmmToMin(request.getParameter("dutysf"));
	String dutyca 	= TimeUtil.hhmmToMin(request.getParameter("dutyca"));
	String dutyfo 	= TimeUtil.hhmmToMin(request.getParameter("dutyfo"));
	String dutyife 	= TimeUtil.hhmmToMin(request.getParameter("dutyife"));
	String dutyfe 	= TimeUtil.hhmmToMin(request.getParameter("dutyfe"));
	String today 	= TimeUtil.hhmmToMin(request.getParameter("today"));
	String tonit 	= TimeUtil.hhmmToMin(request.getParameter("tonit"));
	String ldday 	= TimeUtil.hhmmToMin(request.getParameter("ldday"));
	String ldnit 	= TimeUtil.hhmmToMin(request.getParameter("ldnit"));
	String pic 		= TimeUtil.hhmmToMin(request.getParameter("pic"));
*/
//檢查unique 條件：    rectype, yy, mm,staff_num,fleet_cd
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
Driver dbDriver = null;
int rowCount = 0;		
int resultCount = 0;
ConnDB cn = new ConnDB();
String sql = null;
try{
	cn.setDFUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
	

	stmt = conn.createStatement();
	
	rs = stmt.executeQuery("select count(*) count from dfdb.dftcrec "
			+"where staff_num="+staff_num+" and yy="+yyyy
			+" and mm="+mm+" and fleet_cd='"+fleet_cd+"' and rectype='"+rectype+"'");
		
	while(rs.next()){
		rowCount = rs.getInt("count");
	}			
	sql = "INSERT INTO dfdb.dftcrec "
			+" (rectype,yy,mm,staff_num ,fleet_cd ,ca,fo,fe,inst, night,dutyip, dutysf,dutyca,dutyfo,dutyife,dutyfe"
			+" ,today,tonit,ldday,ldnit,pic,ops,pic2) "
			+" VALUES('"+rectype+"','"+yyyy
			+"','"+mm+"','"+staff_num+"','"+fleet_cd+"','"+ca+"','"+fo+"','"+fe+"','"+inst
			+"','"+night+"','"+dutyip+"','"+dutysf+"','"+dutyca+"','"+dutyfo+"','"+dutyife+"','"
			+dutyfe+"','"+today+"','"+tonit+"','"+ldday+"','"+ldnit+"','"+pic+"',NULL,0)"; //2011/02/11
	
	if(rowCount == 0){	//尚未有資料，繼續insert
		resultCount = stmt.executeUpdate(sql);		
	}
	
}catch(SQLException e){
	out.print("SQL = "+sql+"<BR>錯誤訊息："+e.toString()+"<BR>");
}catch(Exception e){
	out.print("錯誤訊息："+e.toString()+"<BR>");
}finally{
	if (rs != null)
		try {rs.close();} catch (SQLException e) {}
	if (stmt != null)
		try {stmt.close();} catch (SQLException e) {}
	if (conn != null)
		try {conn.close();}catch (SQLException e) {}
}
	
%>


<html>
<head>
<title>
Insert Crew Record
</title>
<link href="../menu.css" rel="stylesheet" type="text/css">
</head>

<body >
<%
if(rowCount > 0){
%>
		<div class="txtblue" style="text-align:center ">year/month:<span class="txtxred"><%=yyyy+"/"+mm%></span><span class="txtred"><br>
		</span>Staff_num: <span class="txtxred"><%=staff_num%></span><br>
		Fleet_cd:<span class="txtxred"><%=fleet_cd%></span><br>
		RecType:<span class="txtxred"><%=rectype%><br>
	    已有資料存在!!無法新增!!</span></div>

        <%
}else if(resultCount >0){
%>
<div class="txtxred" style="text-align:center ">Crew Record Insert Success!!
  <a href="CrewRdInsMenu.jsp" target="_self"><br>
<u>Click here to add another.</u></a></div>
<%
}else{
%>
	<div class="txtxred" style="text-align:center ">新增資料失敗.請重新輸入.
  <a href="javascript:history.back(-1)" target="_self"><br>
<u>Click here to reinsert crew record.</u></a></div>
    <%	
}
%>

</body>
</html>