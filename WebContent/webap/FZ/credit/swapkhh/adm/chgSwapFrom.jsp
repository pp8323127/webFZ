<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*" %>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login

String formno = request.getParameter("formno");
String aEmpno = request.getParameter("aEmpno");
String aCname = request.getParameter("aCname");
String rEmpno = request.getParameter("rEmpno");
String rCname = request.getParameter("rCname");
String ed_check = request.getParameter("ed_check");

Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
String sql = null;
ci.db.ConnDB cn = new ci.db.ConnDB();
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

sql = "SELECT trim(citem) citem FROM fztcommf where station='KHH' order by citem";
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
<title>更新申請單狀態確認</title>
<link href="../style/kbd.css" rel="stylesheet" type="text/css">
<link href="../realSwap/realSwap.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="../loadingStatus.css">

<script language="javascript" type="text/javascript" src="../js/showAndHiddenButton.js"></script>
<script language="javascript" type="text/javascript">
function chk(){
	if( confirm("確定要更新 "+"<%=formno%>"+" 號申請單？")){
		disabledButton("submit");
		document.getElementById("showStatus").className="showStatus";
		return true;
	}else{
		return false;
	}
}
</script>

</head>

<body>
<div id="showStatus" class="hiddenStatus">資料儲存中...請稍候</div>
<span class="r">Step 3.重新設定申請單</span>
<form name="form1" action="chgSwapFromUPD.jsp" method="post" onsubmit="return chk()" >
  <table width="100%" cellspacing="1" cellpadding="1" style="border-collapse:collapse;border:1pt double #00248F " >
      <tr class="tableh5" >
        <td width="126" >No</td>
        <td width="121" >Applicant</td>
        <td width="104" >Aname</td>
        <td width="114" >Replacer</td>
        <td width="143" >Rname</td>
        <td width="91" >ED_check</td>
        <td width="221" > ED <br>
        Comments </td>
    </tr>

      <tr style="background-color:#DAE9F8 ">
        <td ><%= formno%><input type="hidden" name="formno" value="<%=formno%>"></td>
        <td ><%= aEmpno%></td>
        <td ><%= aCname %></td>
        <td ><%=rEmpno%></td>
        <td ><%=rCname%></td>
        <td >
			<select name="ed_check">
			<option value="Y">Agree</option>
			<option value="N">Reject</option>
			</select>
		</td>
        <td >
		            <div align="left">
		              <input name="addcomm" type="text" size="10" maxlength="10">
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
  
		            </div></td>
  </tr>
      <tr >
        <td height="17" colspan="7" >          <input type="submit" id="submit" class="kbd" value="Update Form">		  <input type="hidden" name="aEmpno" value="<%=aEmpno%>">		  <input type="hidden" name="rEmpno" value="<%=rEmpno%>">			
        </td>
      </tr>

  </table>
</form>	
</body>
</html>
