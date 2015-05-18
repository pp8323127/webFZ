<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="fz.*,java.sql.*"%>
<%

response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);

String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login

} 

String userid =(String) session.getAttribute("userid") ; 
ArrayList setdatAL = null;

Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
ResultSet rs = null;
ci.db.ConnDB cn = new ci.db.ConnDB();
ArrayList commAL = null;

try{
cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement();

rs = stmt.executeQuery("select to_char(setdate,'YYYY/MM/DD') setdate from fztsetdf where station='KHH' order by setdate"); 
while(rs.next()){
	if(setdatAL == null){
		setdatAL = new ArrayList();
	}
	setdatAL.add(rs.getString("setdate"));
}

}catch (Exception e){
	  out.print(e.toString());
}finally{
	if (rs != null) try {rs.close();} catch (SQLException e) {}	
	if (stmt != null) try {stmt.close();} catch (SQLException e) {}
	if (conn != null) try { conn.close(); } catch (SQLException e) {}
}




%>

<html>
<head>
<title>自訂不收單日</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" type="text/css" href="../realSwap/realSwap.css" >
<link rel="stylesheet" type="text/css" href="../style/errStyle.css">
<link rel="stylesheet" type="text/css" href="../style/validator.css" >
<script language="javascript" type="text/javascript" src="calendar2.js"></script>
<script language="javascript" type="text/javascript" src="../js/validator.js"></script>
<script language="javascript" type="text/javascript" src="../js/checkDel.js"></script>


</head>

<body>
<%
if(setdatAL == null ){
%>
<div class="errStyle1">目前並未設定不收單日</div>
<%
}else{
%>
<form  method="post" name="form1" action="delappdate.jsp" onSubmit="return checkDel('form1')">
  <table width="45%"  border="0" align="center" cellpadding="0" cellspacing="1" class="tableBorder1">
    <tr class="tableInner3">
      <td colspan="3" ><div align="center">KHH不收單日</div></td>
    </tr>
 <tr class="tableh5">
      <td   >日期</td>
	   <td   >刪除</td>
    </tr>

        <div align="center">
<%
		for(int i=0;i<setdatAL.size();i++){
			String bgColor = "";
			if (i%2 == 0){
				bgColor = "#FFFFFF";
			}else{
				bgColor = "#DAE9F8";
			}
	%>
 <tr bgcolor="<%=bgColor%>">
   <td>
     <div align="left"><%=setdatAL.get(i)%>
         <input name="showdate" type="hidden" value="<%=setdatAL.get(i)%>">
         <br>
   </div></td>
   <td ><input name="checkdel" type="checkbox" id="checkdel"  value="<%=setdatAL.get(i)%>"></td>
      </tr>	  
          <%
		}
	
	
	%>  
        </div>
   
    <tr>
      <td colspan="3"  ><div align="center">&nbsp;&nbsp;
          <input name="Submit2" type="submit" class="btm" value="確認刪除">
</div></td>
    </tr>
  </table>
</form>
<%
}
%>
<hr  width="45%" align="center">

<form action="updappdate.jsp"  method="post" name="form2" id="form2" onSubmit="return v.exec()">
  <table width="45%"  border="0" align="center" cellpadding="0" cellspacing="1" class="tableBorder1">
    <tr>
      <td colspan="2"  align="center" class="tableInner3"><div  id="aText" style="display:inline; ">新增不收單日</div>（西洋年/月/日 ex:2007/12/31）</td>
    </tr>

        <div align="center">

 <tr>
   <td >     <div align="left">
         
         <div id="qdate" style="display:inline "></div>
         <div align="center">
           <input name="addate" id="addate" type="text" size="10" maxlength="10"  onClick="cal1.popup();">
           <img src="img/cal.gif" width="16" height="16" onClick="cal1.popup();"></div>
   </div></td>
   </tr>	  
        </div>
   
    <tr>
      <td colspan="2"  ><div align="center">        &nbsp;&nbsp;
        <input name="Submit" id="s1" type="submit" class="btm" value="確認新增">
      </div></td>
    </tr>
  </table>
</form>


</body>
</html>
<script  type="text/javascript" language="javascript">
	var cal1 = new calendar2(document.form2.elements['addate']);
	cal1.year_scroll = true;
	cal1.time_comp = false;


var a_fields = {
	'addate' : {
		'l': '不收單日',  // label
		'r': true,    // required
		
		't': 'aText'// id of the element to highlight if input not validated	
		
	}		
	
}
o_config = {
	'to_disable' : ['s1'],
	'alert' : 1
}
var v = new validator('form2', a_fields, o_config);
</script>
