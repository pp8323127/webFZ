<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*,java.util.*,java.io.*,fz.*" errorPage="" %>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);

String occu = (String)session.getValue("occu");
String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login

/*
if (sGetUsr == null){
	sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader ("Expires", 0);
	
	if (session.isNew() || sGetUsr == null) 
	{		//check user session start first
		response.sendRedirect("../sendredirect.jsp");
	} 
}
*/
/*
String sql = null;
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
ConnDB cn = new ConnDB();
Driver dbDriver = null;


ArrayList dutycdAL = new ArrayList();

try
{
cn.setAOCIPRODCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement();
sql = "SELECT DISTINCT(duty_cd) as duty_cd FROM duty_prd_seg_v order by duty_cd";

rs=stmt.executeQuery(sql);

while (rs.next()) 
{
	dutycdAL.add(rs.getString("duty_cd"));
}

}catch(SQLException e){
	out.print(e.toString());
}
catch(Exception e)
{
	out.print(e.toString());
}
finally
{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
*/
%>
<html>
<head>
<title>Off Crew Query</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" href="menu.css" type="text/css">
<script language="JavaScript" type="text/javascript" src="../../js/showDate.js"></script>

<script language="JavaScript" type="text/JavaScript">

 
function checkdate(){		//檢查超過設定的時間，則不予查詢
	 /* nowdate = new Date();	//抓現在時間
	 var y,m,d
		m = nowdate.getMonth()+1;*/
		dt = new Date(40*86400000+(new Date()).getTime() );  //今天之後40天的日期
		//一天86400000豪秒= 1000*60*60*24

	var sely,selm,seld;
	seldate = new Date();	
	sely = form1.fyy.value;
	selm = parseInt(document.form1.fmm.value)-1;
	seld = parseInt(document.form1.fdd.value);
	
		seldate.setFullYear(sely);
		seldate.setMonth(selm);
		seldate.setDate(seld);		//設定選擇的日期
		
/*
	if (seldate > dt){
		alert("Please reselect date to query!!\n\n日期超出資料範圍，請重新選擇！！");
		location.reload();
		return false;
		
	}
*/
	var sdate = document.form1.fyy.value + form1.fmm.value + form1.fdd.value;
	var edate = document.form1.eyy.value + form1.emm.value + form1.edd.value;

	if (parseInt(sdate) > parseInt(edate))
	{
		alert("Please select correct period!!\n\n日期區間輸入有誤，請重新選擇！！");
		location.reload();
		return false;
	}

	/*
	if (document.form1.duty_cd.value=="FLY")
	{
		if (document.form1.fltno.value=="")
		{
			alert("Please input FltNo!!\n\n請輸入查詢班機號碼！！");
			document.form1.fltno.focus();
			return false;
		}
	}
    */

	return true;
}

</script>

</head>

<body  onLoad="showYMD('form1','fyy','fmm','fdd');showYMD('form1','eyy','emm','edd');document.form1.duty_cd.value='FLY'" >
<form name="form1" method="post" action="showCl.jsp" target="mainFrame" onSubmit="return checkdate()">
  <span class="txtblue">
  <select name="fyy" >
	  <jsp:include page="../../temple/year.htm" />
  </select>
    
  <select name="fmm" >
	  <jsp:include page="../../temple/month.htm" />
  </select>
  <select name="fdd" >
	  <jsp:include page="../../temple/day.htm" />
  </select>To
  <select name="eyy" >
	  <jsp:include page="../../temple/year.htm" />
  </select>
    
  <select name="emm" >
	  <jsp:include page="../../temple/month.htm" />
  </select>
  <select name="edd" >
	  <jsp:include page="../../temple/day.htm" />
  </select>
  
  Duty Code
  <SELECT name=duty_cd id=duty_cd>	
  <%
  // include 檔案名稱：不分艙等 dutycd.htm,	前艙： dutycdY.htm, 後艙：dutycdN.htm
  String cabin = (String)session.getAttribute("cabin");
  if("Y".equals(cabin)){
  %>
		  <jsp:include page="../../temple/dutycdY.htm" />
		  <option value="R2">R2</option>
		  <option value="R3">R3</option>
		  <option value="R4">R4</option>		
		  <option value="RT">RT</option>		  		  
		    		  
<%
  }else  if("N".equals(cabin)){
  %>
		  <jsp:include page="../../temple/dutycdN.htm" />
<%
}else{
  %>
		  <jsp:include page="../../temple/dutycd.htm" />
<%


}
%>		  
  </SELECT>
  FltNo
  <input type="text" name="fltno" size="4" maxlength="4" >
  Sector
  <input type="text" name="sector" size="6" maxlength="6" onkeyup="javascript:this.value=this.value.toUpperCase();">
	Rank
  <select name="occu" >
  <%
  
  	out.print("<option value=\"Y\" style=\"color:red\">Cockpit</option>\r\n");
  	out.print("<option value=\"N\" style=\"color:red\">Cabin</option>\r\n");
  
  %>
    <option value="all" selected>ALL</option>
		<jsp:include page="../../temple/occu.htm" />
  </select>
  </span>
  <%
  if("Y".equals(cabin)){
  %>
  <span class="txtblue">Fleet</span>  
  <select name="fleet_cd">
	<option value="">ALL</option>
	<option value="333">333</option>
	<option value="343">343</option>
	<option value="34B">34B</option>
	<option value="738">738</option>
	<option value="73A">73A</option>
	<option value="744">744</option>
	<option value="74F">74F</option>
	<option value="AB6">AB6</option>
	<option value="APQ">APQ</option>
  </select>
  <%
  }
  
  
 
  %>
   
<span class="txtblue">BASE:</span>
  <select name="B">
  	<option value="ALL" selected>ALL</option>
	<option value="TPE" >TPE</option>	
	<option value="KHH">KHH</option>
	<option value="NRT">NRT</option>
	<option value="KIX">KIX</option>
	<option value="SIN">SIN</option>
	<option value="SGN">SGN</option>
	<option value="BKK">BKK</option>  
	<option value="DEL">DEL</option>  


  </select>
  <input type="submit" name="Submit" value="Query" class="btm"> 
</form>
</body>
</html>
