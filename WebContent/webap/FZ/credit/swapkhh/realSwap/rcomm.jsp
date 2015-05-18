<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="fz.*,java.sql.*,ci.db.*"%>
<%
//實體換班審核意見
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login

if (sGetUsr == null) 
{		
	response.sendRedirect("/webfz/FZ/sendredirect.jsp");
}

String userid =(String) session.getAttribute("userid") ; 


Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
ResultSet rs = null;
ci.db.ConnDB cn = new ci.db.ConnDB();
ArrayList citemAL = null;
try{
cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement();

rs = stmt.executeQuery("select citem from fztrcomf where station='KHH' order by citem"); 
while(rs.next()){
	if(citemAL == null){
		citemAL = new ArrayList();
	}
	citemAL.add(rs.getString("citem"));
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
<link href="realSwap.css" rel="stylesheet" type="text/css">
<link href="../kbd.css" rel="stylesheet" type="text/css">
<script src="../js/checkBlank.js"></script>
<script src="../js/checkDel.js"></script>
</head>


<body onload="document.form2.addcomm.focus();">
<%
if(citemAL != null && citemAL.size()  > 0){
%>
<form  method="post" name="form1" action="delRComm.jsp" onSubmit="return checkDel('form1')">
  <table width="45%"  border="1" align="center" cellpadding="0" cellspacing="0" class="tableBorder1" >
    <tr class="tableInner3">
      <td colspan="3"><div align="center">KHH手工換班理由</div>
      </td>
    </tr>
 <tr class="tableh5">
      <td width="62%"  >意見</td>
	   <td width="38%"   >刪除</td>
    </tr>

          <%
		for(int i=0;i< citemAL.size();i++){
			String bgColor = "";
			if (i%2 == 0){
				bgColor = "#FFFFFF";
			}else{
				bgColor = "#DAE9F8";
			}
	%>
 <tr bgcolor="<%=bgColor%>">
   <td >
     <div align="left"><%=(String)citemAL.get(i)%>
         <input name="tcomm" type="hidden" value="<%=(String)citemAL.get(i)%>">
         <br>
   </div></td>
   <td ><input name="checkdel" type="checkbox" id="checkdel" value="<%=(String)citemAL.get(i)%>"></td>
    </tr>	  
        <%
		}
	%>  
       
    <tr>
      <td colspan="3"  ><div align="center">&nbsp;&nbsp;
          <input name="Submit2" type="submit" class="kbd" value="確認刪除">
</td>
    </tr>
  </table>
</form>

<%
}else
{
	out.print("<p  align=\"center\">目前尚無新增手工換班理由!!</p><hr width=\"45%\" align=\"center\">");
}
%>
<br>


<form action="updRComm.jsp"  method="post" name="form2" id="form2" onSubmit="return checkBlank('form2','addcomm','Comment is required!!\n請輸入新增手工換班理由!!')">
  <table width="45%"  border="1" align="center" cellpadding="0" cellspacing="0" >
    <tr>
      <td colspan="2" class="tableInner3">
      <div align="center">新增手工換班理由</div></td>
    </tr>

       

 <tr>
   <td >     <div align="left">
         <input name="addcomm" type="text" size="50" maxlength="40">
</div></td>
   </tr>	  
       
   
    <tr>
      <td colspan="2"  ><div align="center">        &nbsp;&nbsp;
        <input name="Submit" type="submit" class="kbd"  value="確認新增">
      </div></td>
    </tr>
  </table>
</form>


</body>
</html>
<%


%>
