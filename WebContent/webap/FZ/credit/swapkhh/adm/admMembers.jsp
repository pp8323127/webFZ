<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="java.sql.*"%>
<%!
public class memberObj{
	private String empno;
	private String cname;
	
	public String getCname() {
		return cname;
	}
	
	public void setCname(String cname) {
		this.cname = cname;
	}
	
	public String getEmpno() {
		return empno;
	}
	
	public void setEmpno(String empno) {
		this.empno = empno;
	}
	
}
%>
<%
//設定高雄換班管理人員
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
ArrayList dataAL = null;
String errMsg = "";
boolean status = false;
try{
	cn.setORP3FZUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
	stmt = conn.createStatement();
	
	rs = stmt.executeQuery("SELECT * FROM fztuidg WHERE gid='KHHEFFZ' ORDER BY userid"); 
	while(rs.next()){
		if(dataAL == null){
			dataAL = new ArrayList();
		}
		memberObj o = new memberObj();
		o.setCname(rs.getString("username"));
		o.setEmpno(rs.getString("userid"));
		dataAL.add(o);
	}
	status = true;

}catch (Exception e){
	 errMsg += e.toString();
}finally{

	if (rs != null) try {rs.close();} catch (SQLException e) {}	
	if (stmt != null) try {stmt.close();} catch (SQLException e) {}
	if (conn != null) try { conn.close(); } catch (SQLException e) {}
}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>申請單管理人員設定</title>
<link rel="stylesheet" type="text/css" href="../style/errStyle.css">
<link rel="stylesheet" type="text/css" href="../realSwap/realSwap.css">
<link rel="stylesheet" type="text/css" href="../style/validator.css" >
<script language="javascript" type="text/javascript" src="../js/validator.js"></script>
<script language="javascript" type="text/javascript" src="../js/checkDel.js"></script>

</head>

<body onLoad="document.getElementById('empno').focus();">
<%

if(dataAL == null){
	out.print("<div class='errStyle1'>尚未設定管理人員名單</div>");
}else{
%>
<form  method="post" name="form1" action="delAdmMembers.jsp" onSubmit="return checkDel('form1')">
  <table width="45%"  border="0" align="center" cellpadding="0" cellspacing="1" class="tableBorder1">
    <tr>
      <td colspan="4" >設定高雄換班管理人員</td>
    </tr>
 <tr class="tableh5">
      <td width="31%">員工號</td>
	   <td width="31%">姓名</td>
	   <td width="38%">刪除</td>
    </tr>
<%
		for(int i=0;i<dataAL.size();i++){
			memberObj obj = (memberObj)dataAL.get(i);
			String bgColor = "";
			if (i%2 == 0){
				bgColor = "#FFFFFF";
			}else{
				bgColor = "#DAE9F8";
			}
	%>
<tr bgcolor="<%=bgColor%>">
   <td>
     <%=obj.getEmpno()%>         <br>
	</td>
   <td><%=obj.getCname()%></td>
   <td ><input name="checkdel" type="checkbox" id="checkdel" value="<%=obj.getEmpno()%>"></td>
</tr>	  
     <%
		}
	%>     
    <tr>
      <td colspan="4"  ><input name="Submit2" id="s2" type="submit"  value="確認刪除">      </td>
    </tr>
  </table>
</form>
<%
}
%>
<hr width="45%">
<form action="updAdmMembers.jsp"  method="post" name="form2" id="form2" onSubmit="return v.exec()">
  <table width="45%"  border="0" align="center" cellpadding="0" cellspacing="1" class="tableBorder1" >
    <tr>
      <td colspan="2" class="tableh5" ><div id="aText" style="display:inline ">新增人員</div></td>
    </tr>
	 <tr>
   <td ><input name="empno" id="empno" type="text" size="10" maxlength="6"></td>
   </tr>	  
      
    <tr bgcolor="#DAE9F8">
      <td colspan="2"  >&nbsp;&nbsp;        <input name="Submit" type="submit" id="s1" value="確認新增">
      </td>
    </tr>
    <tr>
      <td colspan="2"  style="text-align:left; " class="r">*請輸入高雄站換班申請之管理人員員工號.<br>
        *TPEED人員均有權限使用，不需再輸入.</td>
    </tr>
  </table>
 
</form>

</body>
</html>
<script  type="text/javascript" language="javascript">
var a_fields = {
	'empno' : {
		'l': '管理人員',  // label
		'r': true,    // required
		'f': 'integer',  
		't': 'aText'// id of the element to highlight if input not validated	
		
	}		
	
}

o_config = {
	'to_disable' : ['s1'],
	'alert' : 1
}
var v = new validator('form2', a_fields, o_config);

</script>
