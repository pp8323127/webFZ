<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="java.sql.*,ci.db.*,java.util.*" %>
<%
Connection conn = null;

Statement stmt = null;
ResultSet rs = null;
String sql = null;
ConnDB cn = new ConnDB();
ArrayList typeAL = new ArrayList();
try{

//直接連線 ORP3FZAP
cn.setORP3FZAP();
java.lang.Class.forName(cn.getDriver());
conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),
	cn.getConnPW());
stmt = conn.createStatement();

sql = "SELECT DISTINCT ac_type FROM fztckpl where ac_type NOT IN  ('Y','X') order by ac_type";
rs = stmt.executeQuery(sql);
while(rs.next()){
	typeAL.add(rs.getString("ac_type"));
}

}
catch (Exception e)
{
	  out.print(e.toString());
}
finally
{
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
<link href="style.css" rel="stylesheet" type="text/css">
<title>受訓記錄查詢</title>
<script language="javascript" src="../../js/showDate.js"></script>
</head>

<body onLoad="showYM('form1','year','month')">
<form name="form1" action="Record.jsp" method="post" target="mainFrame">
<select name="year">
	<jsp:include page="../../temple/year.htm" />
</select>
<select name="month">
	<jsp:include page="../../temple/month.htm" />
</select>
<span class="txtblue">機隊:</span>
<select name="fleet">
  <option value="ALL" selected="">ALL</option>
  <%
for(int i=0;i<typeAL.size();i++){
	out.print("<option value=\""+(String)typeAL.get(i)+"\">"+(String)typeAL.get(i)+"</option>");
}
%>
</select> 
<span class="txtblue">訓練種類</span>
<select name="clstype">
<option value="ALL" selected="">ALL</option>
<option value="PT">PT</option>
<option value="PC">PC</option>
<option value="CRM">CRM</option>
<option value="SS">SS</option>
<option value="FM">FM</option>
<option value="ES">ES</option>
<option value="RC">RC</option>
</select>
<input type="submit" class="button5" value="Query" >
<span class="txtblue">*查詢受訓紀錄者</span>
</form>
</body>
</html>
