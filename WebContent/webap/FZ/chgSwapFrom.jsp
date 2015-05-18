<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*" %>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login

String formno = request.getParameter("formno");
String aEmpno = request.getParameter("aEmpno");
String aCname = request.getParameter("aCname");
String rEmpno = request.getParameter("rEmpno");
String rCname = request.getParameter("rCname");
String ed_check = request.getParameter("ed_check");
String formtype = request.getParameter("formtype");

Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
String sql = null;
ConnDB cn = new ConnDB();
Driver dbDriver = null;
ArrayList citemAL = new ArrayList();
try{
//User connection pool 

cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);


//直接連線 ORP3FZ
/*
cn.setORT1FZ();
java.lang.Class.forName(cn.getDriver());
conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),
	cn.getConnPW());
*/

stmt = conn.createStatement();

sql = "SELECT trim(citem) citem FROM fztcomm ORDER BY Decode(citem,'Agree',' ',citem)";
rs = stmt.executeQuery(sql);
	while(rs.next()){
		citemAL.add(rs.getString("citem"));
	}

}catch (SQLException e){
	  out.print(e.toString());
}catch (Exception e){
	  out.print(e.toString());
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
<title>無標題文件</title>
<link href="kbd.css" rel="stylesheet" type="text/css">
<link href="menu.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript">
function chk(){
	if( confirm("確定要更新 "+"<%=formno%>"+" 號申請單？")){
		return true;
	}else{
		return false;
	}
}
</script>

</head>

<body>
<form name="form1" action="chgSwapFromUPD.jsp" method="post" onsubmit="return chk()" >
<table width="700" border="1" cellpadding="0" cellspacing="0">
      <tr class="tablehead3">
        <td width="76" >No</td>
        <td width="57" >Applicant</td>
        <td width="53" >Aname</td>
        <td width="55" >Replacer</td>
        <td width="52" >Rname</td>
        <td width="69" >ED_check</td>
        <td width="129" > ED Comments </td>
    </tr>

      <tr >
        <td class="txtblue"><%= formtype%><%= formno%><input type="hidden" name="formno" value="<%=formno%>"></td>
        <td class="txtblue"><%= aEmpno%></td>
        <td class="txtblue"><%= aCname %></td>
        <td class="txtblue"><%=rEmpno%></td>
        <td class="txtblue"><%=rCname%></td>
        <td class="tablebody">
			<select name="ed_check">
			<option value="Y">Agree</option>
			<option value="N">Reject</option>
			</select>
		</td>
        <td class="tablebody">
		            <input name="addcomm" type="text" size="30" maxlength="30">
		            <br>
            <select name="comm">
			<%
			for(int i=0;i<citemAL.size();i++){
			%>
			<option value="<%=citemAL.get(i)%>"><%=citemAL.get(i)%></option>
			<%
			}
			%>
			</select>

		</td>
  </tr>
      <tr >
        <td height="17" colspan="7" class="tablebody">
          <div align="center">
            <input type="submit" class="kbd" value="Update Form">
			<input type="hidden" name="aEmpno" value="<%=aEmpno%>">
			<input type="hidden" name="rEmpno" value="<%=rEmpno%>">		
			<input type="hidden" name="formtype" value="<%=formtype%>">	          
		  </div>
        </td>
      </tr>

  </table>
</form>	
</body>
</html>
