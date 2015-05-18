<%@ page contentType="text/html; charset=big5" language="java" import="crewhr.HrCheck,java.math.BigDecimal" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
//response.setHeader("Cache-Control","no-cache");
//response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first
	response.sendRedirect("../sendredirect.jsp");
}
%>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>1000hr Save List</title>
<link href="../menu.css" rel="stylesheet" type="text/css">
</head>
<body>
<div align="center">
<p>
<%
String yy = request.getParameter("yy");
String mm = request.getParameter("mm");

HrCheck hc = new HrCheck();
String[][] rs = null;
String bcolor = "";
int ck = 0;
try{
	//檢查當月是否已做過存檔動作
	ck = hc.checkRec(yy, mm);
	//out.println("row : " + String.valueOf(ck));
	//未執行過存檔作業
	if(ck == 0){
		rs = hc.getHrCheck(yy+mm);
		if(rs != null && rs.length > 500){
	%>
		<br>
		<span class="txttitletop"><%=yy%> / <%=mm%> Flight Crew Log BLKhr -- TPE Time / FZTCREW</span>
	<br><span class="txttitle">Crew : <%=rs.length%></span>
	<form name="form1" method="post" action="upd1000hr.jsp">
		<table width="70%"  border="1" cellspacing="0" cellpadding="0">
		  <tr class="tablehead2">
			<td>Fleet</td>
			<td>Occu</td>
			<td>EmpNo</td>
			<td>Name</td>
			<td>上月hr</td>
			<td>BLKhr</td>
			<td>跨月hr</td>
		  </tr>
	<%
			for(int i = 0; i < rs.length; i++){
				//上月hr + BLKhr > 95hr
				if((Double.parseDouble(rs[i][4]) + Double.parseDouble(rs[i][6])) > 5700.0){ 
					bcolor = "#FF00FF";
				}
				else{
					bcolor = "";
				}
	%>
		  <tr class="tablebody" bgcolor="<%=bcolor%>">
			<td><%=rs[i][3]%></td>
			<td><%=rs[i][2]%></td>
			<td><%=rs[i][0]%><input name="empno" type="hidden" value="<%=rs[i][0]%>"></td>
			<td><%=rs[i][1]%></td>
			<td><input name="lmmhr" type="text" value="<%=new BigDecimal(Double.parseDouble(rs[i][6]) / 60).setScale(3,BigDecimal.ROUND_HALF_UP)%>" size="10" maxlength="10" readonly></td>
			<td><input name="blkhr" type="text" value="<%=new BigDecimal(Double.parseDouble(rs[i][4]) / 60).setScale(3,BigDecimal.ROUND_HALF_UP)%>" size="10" maxlength="10"></td>
			<td><input name="nmmhr" type="text" value="<%=new BigDecimal(Double.parseDouble(rs[i][5]) / 60).setScale(3,BigDecimal.ROUND_HALF_UP)%>" size="10" maxlength="10"></td>
		  </tr>
	<%
				//out.println("<br>");
			}
	%>	  
		</table>
		<input type="submit" name="Submit" value="Save">&nbsp;&nbsp;
		<input type="reset" name="Submit" value="Rest">
        <input name="yy" type="hidden" value="<%=yy%>">
		<input name="mm" type="hidden" value="<%=mm%>">
    </form>
<%
		}
		else{
			out.println("<p class='txttitletop'>Log檔未轉入 !!</p>");
		}
	}
	else{
		out.println("<p class='txttitletop'>資料已存在，請查看1000hr Check !!</p>");
	}
%>
	</div>
	</body>
	</html>
<%
}
catch(Exception e){
	out.println("<p class='txttitletop'>存取失敗 : "+e.toString()+"</p>");
}
%>
