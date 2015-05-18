<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*"  %>
<%@ page import="java.sql.*,ci.db.*,java.util.*" %>
<%
Connection conn = null;

Statement stmt = null;
ResultSet rs = null;
String sql = null;
ConnDB cn = new ConnDB();
Driver dbDriver = null;
ArrayList typeAL = new ArrayList();
try{

	cn.setORP3FZUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			conn = dbDriver.connect(cn.getConnURL(), null);
	stmt = conn.createStatement();

	rs = stmt.executeQuery("SELECT DISTINCT ac_type FROM fztckpl where ac_type NOT IN  ('Y','X') order by ac_type");
	while(rs.next()){
		typeAL.add(rs.getString("ac_type"));
	}
	rs.close();
	stmt.close();

}catch (Exception e){
	  out.print(e.toString());
}finally{
	if (rs != null)
		rs.close();
	if (stmt != null)
		stmt.close();
	if (conn != null)
		conn.close();
}


%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>年度複訓訓練記錄查詢</title>
<link rel="stylesheet" type="text/css" href="../../../style/style1.css">
<link rel="stylesheet" type="text/css" href="../../../style/kbd.css">
</head>

<body>
<form name="form1"  method="post" target="mainFrame" action="RecurrentRecord.jsp" >
  <p>Fleet
      <select name="fleet">
    <%
for(int i=0;i<typeAL.size();i++){
	out.print("<option value=\""+(String)typeAL.get(i)+"\">"+(String)typeAL.get(i)+"</option>");
}
%>
    
  </select>
    Rank
      <select name="rank">
        <option value="CA">CA</option>
        <option value="FO">FO/RP</option>
      </select>
    CheckType
      <select name="checkType">
	    <option value="PC">PC</option>
	    <option value="PT">PT</option>
<!-- 	    <option value="CRM">CRM</option>
	    <option value="SS">SS</option>
	    <option value="FM">FM</option>	
	    <option value="ES">ES</option> -->				
	    <option value="RC">RC</option>						
      </select>
    <input type="submit" class="kbd"  value="Query" > 
      <span class="red">*受訓記錄查詢
      </span>
  </p>
</form>
</body>
</html>
