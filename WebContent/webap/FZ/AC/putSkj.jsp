<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.*,java.sql.*,ci.db.*"%>
<%


response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{	
	//response.sendRedirect("../sendredirect.jsp");
} 
//write log
/*
String userip = request.getRemoteAddr();
String userhost = request.getRemoteHost();

writeLog wl = new writeLog();
String wlog = wl.updLog(sGetUsr, userip,userhost, "FZ0511");
*/
//String cname = (String) session.getAttribute("cname") ;
session.setAttribute("putSkjObj",null);

String year = request.getParameter("year");
String month = request.getParameter("month");
String errMsg = "";
//檢查班表是否公布
swap3ac.PublishCheck pc =null;
if(request.getParameter("year") != null && request.getParameter("month") != null
	&& !"".equals(request.getParameter("year"))  && !"".equals(request.getParameter("month"))){
		 pc = new swap3ac.PublishCheck(year, month);
 
}

 if(request.getParameter("year") == null | request.getParameter("month") == null
 	| "".equals(request.getParameter("year")) |"".equals(request.getParameter("month"))){
%>
<p  style="background-color:#99FFFF;color:#FF0000;font-family:Verdana;font-size:10pt;padding:5pt;text-align:center;">請選擇年/月</p>
<%
}else if(!pc.isPublished()){
%>
<p  style="background-color:#99FFFF;color:#FF0000;font-family:Verdana;font-size:10pt;padding:5pt;text-align:center;"><%=year+"/"+month%> 班表尚未正式公布</p>
<%
}else{

swap3ac.CrewSwapSkj csk = new swap3ac.CrewSwapSkj(sGetUsr, "null", year, month);

swap3ac.CrewInfoObj obj = null;
ArrayList dataAL = null;
try {
	csk.SelectData();
	obj = csk.getACrewInfoObj();
	 dataAL = csk.getACrewSkjAL();

	
} catch (SQLException e) {
	//System.out.print(e.toString());
} catch (Exception e) {
//	System.out.print(e.toString());

}
//儲存丟班資訊
fzac.CrewPutSkjObj cpObj2 = new fzac.CrewPutSkjObj();
if(obj != null){
	cpObj2.setCrewInfo(obj);
	cpObj2.setSkjObj(dataAL);
}
//移除已丟出之班表
fzac.RemoveDuplicatePutSkj rp = new fzac.RemoveDuplicatePutSkj(cpObj2);

try {
	rp.job();
	
} catch (SQLException e) {
	//System.out.print(e.toString());
} catch (Exception e) {
	//System.out.print(e.toString());

}
fzac.CrewPutSkjObj cpObj = rp.getCrewSkjObj();

session.setAttribute("putSkjObj",cpObj);


//取得已丟出之班表
fzac.CrewPutSkj crPurSkj = new fzac.CrewPutSkj(sGetUsr,year,month);
ArrayList oDataAL = null;

try{
	crPurSkj.SelectData();
	oDataAL = crPurSkj.getPutSkjAL();
}catch(Exception e){

}
/*
Connection conn = null;
ConnDB cn = new ConnDB();
Driver dbDriver = null;
PreparedStatement pstmt = null;
ResultSet rs = null;



try{
cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);

pstmt = conn.prepareStatement("select fdate,fltno,tripno,put_date putdate from fztsput where empno =? and   fdate like ?"); 
pstmt.setString(1,sGetUsr);
pstmt.setString(2,year+"/"+month+"/%");
rs  = pstmt.executeQuery();

while(rs.next()){
	if(oDataAL == null){
		oDataAL = new ArrayList();
	}
	swap3ac.CrewSkjObj objx = new swap3ac.CrewSkjObj();
	objx.setFdate(rs.getString("fdate"));
	objx.setDutycode(rs.getString("fltno"));
	objx.setTripno(rs.getString("tripno"));
	oDataAL.add(objx);
}

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
*/
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Schedule Put</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" href="swapArea.css" type="text/css">
<link rel="stylesheet" type="text/css" href="swapArea.css">
<link rel="stylesheet" type="text/css" href="../errStyle.css">
<script language="javascript" type="text/javascript" >

function checkPut(){
		count = 0;
		for (i=0; i<document.form1.length; i++) {
			if (document.form1.elements[i].checked){
				 count++;
			}
		}
		if(count ==0 ) {
			alert("尚未勾選要丟出的班次!!\nPlease select Schedule!!");
			return false;
		}else{
			document.getElementById("showStatus").className="showStatus";
			document.getElementById("putSubmit").disabled=1;
			document.getElementById("cancelSubmit").disabled=1;
			
			return true;
			
		}		

}

function checkCancel(){
	countx=0;
		for (i=0; i<document.form2.length; i++) {
			if (document.form2.elements[i].checked){
				 countx++;
			}
		}


		if(countx ==0 ) {
			alert("尚未選擇取消項目!!\nPlease select item to cancel");
			return false;
		}else{
			document.getElementById("showStatus").className="showStatus";
			document.getElementById("putSubmit").disabled=1;
			document.getElementById("cancelSubmit").disabled=1;		
			return true;
			
		}		

}


</script>
<script language="JavaScript" src="hints.js"></script>
<script language="JavaScript" src="hints_cfg.js"></script>
</head>

<body >
<div id="showStatus" class="hiddenStatus">loading...</div>

<%
if(obj != null && dataAL.size() > 0){


%>
<form name="form1" method="post" action="putSkjUpdate.jsp" onsubmit="return checkPut()">
<table width="80%" border="0" cellpadding="0" cellspacing="0" align="center">
<tr class="left red"><td height="62" valign="top">
The following shedule is for reference only. For official up-to-date schedule information, please contact Scheduling Department. <br>
下列班表僅供參考，請向組員派遣部門確認個人正式班表任務。
</td></tr>
<tr class="center" >
  <td class="blue"><%=year+"/"+month%> Schedule by Trip<br>
  <%=obj.getCname()%> <%=sGetUsr%> <%=obj.getSern()%> <%=obj.getQual()%> <%=obj.getBase()%></td>
</tr>
</table>
<table width="80%"  border="0" align="center" cellpadding="0" cellspacing="1" style="border:1pt solid black;border-collapse:collapse; " >
      <tr> 
	  	<th width="15%" >FltDate</th>
		<th width="8%" >FltNo</th>
        <th width="10%" >TripNo</th>
        <th width="5%" >Put</th>
		<th width="62%" >Commets</th>
      </tr>
<%
	  for(int i=0;i<dataAL.size();i++){
	  
		swap3ac.CrewSkjObj objX = (swap3ac.CrewSkjObj) dataAL.get(i);
		String cssStyle = "";
			if (i%2 == 1)	{
				cssStyle = "gridRowEven";
			}	else{
				cssStyle = "gridRowOdd";
			}
%>
      <tr height="24" class="<%=cssStyle %>"> 
	  	<td class="center" ><%=objX.getFdate()%></td>
		<td class="right"><%=objX.getDutycode()%></td>
        <td class="right"><a name="<%=i%>" href="#<%=i%>" onMouseOver="myHint.show('vList')" onMouseOut="myHint.hide()" onClick="javascript:viewFlightCrew('<%=objX.getTripno()%>');"><%=objX.getTripno()%></a></td>
		<td class="center"> 
          <input type="checkbox" name="checkput"  value="<%=i%>" >
        </td>
		<td class="left"><input name="comm" type="text" id="comm<%=i%>" value="no comments" size="60" maxlength="100" onfocus="if(this.value==this.defaultValue)this.value='';document.form1.checkput[<%=i%>].checked=true;" onBlur="if(this.value==''){this.value=this.defaultValue;document.form1.checkput[<%=i%>].checked=false;}"></td>
      </tr>
      <%
	}
%>
<tr><td colspan="6" class="center">  <input type="submit" id="putSubmit" value="Put the Schedule">
  <br>
  <br>
  <span class="red">*Comments 字數限制：100英文字或50中文字.</span>    <input type="hidden" name="year"  value="<%=year%>">
    <input type="hidden" name="month"  value="<%=month%>">
</td>
</tr>
</table>
</form>
<hr noshade width="80%">
<%
}else{
%>
<div   style="width:80%;text-align:center;margin-left:10%;color:#FF0000;line-height:1.3;display:block;">所有班表均已丟出/查無資料.</div>
<hr noshade width="80%">

<%

}
if(oDataAL == null){
%>
<div   style="width:80%;text-align:center;margin-left:10%;color:#FF0000;line-height:1.3;display:block;">目前並無已丟出班表.</div>
<%
}else{
%>
<form name="form2" method="post" action="putSkjDel.jsp" onSubmit="return checkCancel()">
<table width="80%" border="0" cellpadding="0" cellspacing="0" align="center">
<tr class="center blue"><td  valign="top">我的丟班資訊 Put Schedule Record
</td></tr>
</table>

<table width="80%" border="0" align="center" cellpadding="0" cellspacing="1" style="border:1pt solid black;border-collapse:collapse; " >
    <tr > 
      <th width="15%" class="darkPurpleBG">FltDate</th>
      <th width="8%" class="darkPurpleBG">FltNo</th>
      <th width="10%" class="darkPurpleBG">TripNo</th>
      <th class="darkPurpleBG">Comments</th>
      <th width="5%" class="darkPurpleBG">Cancel</th>

    </tr>
	<%
	for(int i=0;i<oDataAL.size();i++){
		swap3ac.CrewSkjObj objx = (swap3ac.CrewSkjObj)oDataAL.get(i);
		String cssStyle = "";
			if (i%2 == 1)	{
				cssStyle = "lightPurpleBG";
			}	else{
				cssStyle = "gridRowOdd";
			}
%>
      <tr class="<%=cssStyle %>"> 
      <td class="center"><%=objx.getFdate()%></td>
      <td class="right"><%=objx.getDutycode() %></td>
      <td class="right"><a name="a<%=i%>" href="#a<%=i%>" onMouseOver="myHint.show('vList')" onMouseOut="myHint.hide()" onClick="javascript:viewFlightCrew('<%=objx.getTripno()%>');"><%=objx.getTripno()%></a> </td>
      <td class="left"><%=objx.getCd()%></td>
      <td class="center"><input type="checkbox" name="checkdelete" value="<%=objx.getTripno()%>"></td>
	</tr>
<%
}
%>	
<tr><td colspan="5" class="center">
  <input type="submit" name="Submit" id="cancelSubmit" value="Cancel" >
</td></tr>
</table>
  
    <input type="hidden" name="year"  value="<%=year%>">
    <input type="hidden" name="month"  value="<%=month%>">
</form>	

<%
}
%>

<form name="form3" method="post" id="form3" target="_blank">
	<input type="hidden" name="tripno" id="tripno">	
</form>
<script language="javascript" type="text/javascript">
	function viewFlightCrew(tripno){
		document.getElementById("tripno").value = tripno;
		document.form3.action="viewFlightCrew.jsp";
		document.form3.submit();	
	}	
</script>

</body>
</html>
<%
}
%>