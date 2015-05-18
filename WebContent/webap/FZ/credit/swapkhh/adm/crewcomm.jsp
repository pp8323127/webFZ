<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="java.sql.*"%>
<%
//�խ��ӽЪ���
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
 
} 


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

rs = stmt.executeQuery("select citem from fztccomf where station='KHH' order by citem"); 
while(rs.next()){
	if(commAL == null){
		commAL = new ArrayList();
	}
	commAL.add(rs.getString("citem"));
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
<title>�ۭq�խ��ӽЪ���</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" type="text/css" href="../realSwap/realSwap.css" >
<link rel="stylesheet" type="text/css" href="../style/errStyle.css">
<link rel="stylesheet" type="text/css" href="../style/validator.css" >
<script src="../js/validator.js"></script>
<script language="javascript" type="text/javascript" src="../js/checkDel.js"></script>



</head>

<body><%

if(commAL == null ){
out.print("<div class='errStyle1'>�ثe�õL�f�ַN��</div>");

}else{
%>

<form  method="post" name="form1" action="delcrewcomm.jsp" onSubmit="return checkDel('form1')">
  <table width="45%"  border="0" align="center" cellpadding="0" cellspacing="1" class="tableBorder1">
    <tr class="tableInner3">
      <td colspan="3" ><div align="center">KHH�խ��ӽЪ���</div></td>
    </tr>
 <tr class="tableh5">
      <td width="68%"   >�N��</td>
	   <td width="32%"   >�R��</td>
    </tr>
		<%
		for(int i=0;i<commAL.size();i++){
	String bgColor = "";
			if (i%2 == 0){
				bgColor = "#FFFFFF";
			}else{
				bgColor = "#DAE9F8";
			}
	%>
 <tr bgcolor="<%=bgColor%>">
	 <td>
     <div  align="left"><%=commAL.get(i)%>
         <input name="tcomm" type="hidden" value="<%=commAL.get(i)%>">
        </div>
   </td>
   <td ><input name="checkdel" type="checkbox" id="checkdel" value="<%=commAL.get(i)%>"></td>
    </tr>	  
     <%
		}
	%>   
    <tr>
      <td colspan="3"   align="center">
          <input name="Submit2" type="submit" class="btm" value="�T�{�R��">
</td>
    </tr>
  </table>
</form>
<%
}

%>
<hr  width="45%" align="center">
<form action="updcrewcomm.jsp"  method="post" name="form2" id="form2" onSubmit="return v.exec()">
  <table width="45%"  border="0" align="center" cellpadding="0" cellspacing="1" class="tableBorder1">
    <tr>
      <td colspan="2" class="tableInner3" id="aText" >�s�W�խ��ӽЪ���</td>
    </tr>

        <div align="center">

 <tr>
   <td >     <div align="left">
         <input name="addcomm" type="text" size="50" maxlength="50">
</div></td>
   </tr>	  
        </div>
   
    <tr>
      <td colspan="2"  ><div align="center">        &nbsp;&nbsp;
        <input name="Submit" type="submit" id="s1" class="btm" value="�T�{�s�W">
      </div></td>
    </tr>
  </table>
</form>


</body>
</html>
<script language="javascript" type="text/javascript">

var a_fields = {
	'addcomm' : {
		'l': '�խ��ӽЪ���',  // label
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