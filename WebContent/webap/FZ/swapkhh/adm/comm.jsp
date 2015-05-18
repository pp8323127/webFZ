<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="java.sql.*"%>
<%
//ED審核意見
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
	response.sendRedirect("/webfz/FZ/sendredirect.jsp");
} 

String userid =(String) session.getAttribute("userid") ; 

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

rs = stmt.executeQuery("select citem from fztcommf where station='KHH' order by citem"); 
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
<title>自訂審核Comment</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="../realSwap/realSwap.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="../style/errStyle.css">
<script language="javascript" type="text/javascript" src="../js/checkDel.js"></script>
</head>

<body>
<%

if(commAL == null){
out.print("<div class='errStyle1'>尚未設定無審核意見</div>");
}else{
%>
<form  method="post" name="form1" action="delcomm.jsp" onSubmit="return checkDel('form1')">
  <table width="45%"  border="0" align="center" cellpadding="0" cellspacing="1" class="tableBorder1">
    <tr class="tableInner3">
      <td colspan="3" ><div align="center">KHH審核意見</div></td>
    </tr>
 <tr class="tableh5">
      <td width="62%"   >意見</td>
	   <td width="38%"   >刪除</td>
    </tr>

        <div align="center">
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
   <td >
     <div align="left"><%=commAL.get(i)%>
         <input name="tcomm" type="hidden" value="<%=commAL.get(i)%>">
         <br>
   </div></td>
   <td ><input name="checkdel" type="checkbox" id="checkdel" value="<%=commAL.get(i)%>"></td>
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
<form action="updcomm.jsp"  method="post" name="form2" id="form2">
  <table width="45%"  border="0" align="center" cellpadding="0" cellspacing="1" class="tableBorder1">
    <tr>
      <td colspan="2" class="tableInner3"><div align="center">新增審核意見</div></td>
    </tr>

        <div align="center">

 <tr>
   <td >     <div align="left">
         <input name="addcomm" type="text" size="50" maxlength="40">
</div></td>
   </tr>	  
        </div>
   
    <tr>
      <td colspan="2"  ><div align="center">        &nbsp;&nbsp;
        <input name="Submit" type="submit" value="確認新增">
      </div></td>
    </tr>
  </table>
</form>


</body>
</html>

