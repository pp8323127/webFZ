<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.*,java.sql.*"%>

<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
	out.print("Session timeout, please re-login!!");
} 
String year = request.getParameter("year");
String month = request.getParameter("month");
String day = request.getParameter("day");
String sformno = request.getParameter("sformno");
String eformno = request.getParameter("eformno");
String empno = request.getParameter("empno");
String sql = "select formno,aempno,acname,rempno,rcname,to_char(newdate,'yyyy/mm/dd hh24:mi') newDate  from fztformf where station='KHH'   ";

if (day.equals("N")){

sql +="AND newdate BETWEEN To_Date('"+year+month+"01 0000','yyyymmdd hh24mi')  "
	+"AND last_day(To_Date('"+year+month+"01 2359','yyyymmdd hh24mi')) ";

}else{
	sql +="AND newdate BETWEEN To_Date('"+year+month+day+" 0000','yyyymmdd hh24mi')  "
	+"AND To_Date('"+year+month+day+" 2359','yyyymmdd hh24mi') ";
	
}


if (!"".equals(empno)){
	sql += " and (aempno = '"+empno+"' or rempno = '"+empno+"') ";
}
else{
	if (!"".equals(sformno))
	{
		if (!"".equals(eformno))
		{
			sql += " and to_number(substr(to_char(formno),7)) >= "+sformno+" and to_number(substr(to_char(formno),7)) <= "+eformno;
		}
		else
		{
			sql += " and to_number(substr(to_char(formno),7)) = "+sformno;
		}
	}
}
sql += " and ed_check is null order by formno";

ArrayList dataAL = null;

Connection conn = null;
Driver dbDriver = null;
ci.db.ConnDB cn = new ci.db.ConnDB();
PreparedStatement pstmt = null;
ResultSet rs = null;
boolean status = false;
String errMsg ="";
String bcolor  = "";
ArrayList commAL = new ArrayList();;
try
{
cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);

pstmt = conn.prepareStatement("SELECT citem FROM fztcommf WHERE station='KHH' order by citem");
rs = pstmt.executeQuery();
while(rs.next())
{
	commAL.add(rs.getString("citem"));
}
rs.close();
pstmt.close();

pstmt = conn.prepareStatement(sql);
rs = pstmt.executeQuery();
while(rs.next()){
	if(dataAL == null){
		dataAL = new ArrayList();
	}
	swap3ackhh.SwapFormObj obj = new swap3ackhh.SwapFormObj();
	obj.setFormno(rs.getString("formno"));
	obj.setAEmpno(rs.getString("aempno"));
	obj.setACname(rs.getString("acname"));
	obj.setREmpno(rs.getString("rempno"));
	obj.setRCname(rs.getString("rcname"));	
	obj.setNewdate(rs.getString("newDate"));

	dataAL.add(obj);
}
rs.close();
pstmt.close();
status = true;
}
catch (SQLException e) 	
{//getMessage(), getSQLState(), and getErrorCode 
	errMsg = e.toString()+"  ***  getMessage = "+ e.getMessage()+"  ***  getSQLState = "+ e.getSQLState()+"  ***  getErrorCode = "+ e.getErrorCode() ;
}
catch (Exception e) 	
{
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
%>
<html>
<head>
<title>任務互換申請單處理</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">

<link rel="stylesheet" type="text/css" href ="../realSwap/realSwap.css">
<link rel="stylesheet" href="../style/errStyle.css" type="text/css">

</head>

<body >
<%
if(!status){
	out.print("<div class=\"errStyle1\">ERROR:"+errMsg+"</div>");
}else{
	if(dataAL == null){
		out.print("<div class=\"errStyle1\">符合查詢條件之所有申請單均已處理完畢.</div>");
	}else{
%>
<div align="center">
  <p class="r" >任務互換申請單處理</p>
  <form name="form1" method="post" action="upd_handleform.jsp" ONSUBMIT="return f_submit()">
    <table width="100%" border="0"  cellspacing="1" cellpadding="1"  class="tableBorder1">

	  <tr class="tableh5"> 
        <td width="12%" >No</td>
        <td width="15%" >Applicant</td>
        <td width="15%" >Substitute</td>
        <td width="12%" >Confirm</td>
        <td width="26%" >Comments</td>
        <td width="15%" >Newdate</td>
		<td width="5%" >View</td>
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
        <td ><%=obj.getFormno()%>          <input type="hidden" name="formno" value="<%=obj.getFormno()%>">        </td>
        <td ><%=obj.getAEmpno()%>            <input type="hidden" name="aempno" value="<%=obj.getAEmpno()%>">        </td>
        <td ><%=obj.getREmpno()%>            <input type="hidden" name="rempno" value="<%=obj.getREmpno()%>">        </td>
        <td >          <select name="cf">
            <option value="Y">Agree</option>
            <option value="N">Reject</option>
          </select>        </td>
        <td >
          <div align="left">
            <input name="addcomm" type="text" size="10" maxlength="10">
            <br>
            <select name="comm">
              <%
			  for(int idx=0;idx<commAL.size();idx++){
			  
			  %>
              <option value="<%=commAL.get(idx)%>"><%=commAL.get(idx)%></option>
              <%
			  	 }
			  %>
            </select>
          </div></td>
        <td ><%=obj.getNewdate()%></td>
		<td ><a href="../showForm.jsp?formno=<%=obj.getFormno()%>" target="_blank"><img src="img/view.gif" border="0"></a></td>
      </tr>

      <%
		}

%>
    </table>
    <br>

    <div class="r">Total Record Count : <%=dataAL.size()%><br>
    </div>
    <br>
      <input type="submit" name="Submit" value="確定處理">
  </form>
  <p>&nbsp; </p>
</div>


<%	
	
	
	}

}
%>

</body>
</html>
<%
	
	

%>
<script language=javascript>
function f_submit()
{  
	 return confirm("確定更新所有申請單,並發送mail至組員全員信箱 ?")
		//form1.submit();
}
</script>