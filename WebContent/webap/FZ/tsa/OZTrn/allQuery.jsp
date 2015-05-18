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
<script language="javascript" type="text/javascript">
function peak(){
	var d = new Date();
	var m = d.getMonth()+1;
	//預設尖峰月份為2.7.8.12
	if(m=="2" || m=="7" || m=="8" || m=="12"){
		document.form1.peak.value="on";
	}else{
		document.form1.peak.value="off";
	}
}
//控制action Page
function goAction(){
	var d = document.form1.checkType.value;
	if(  "PT" == d){
		document.form1.action = "all.jsp";
		document.form1.submit();
		return true;
	}else if("PC" == d){
		document.form1.action = "pc.jsp";
		document.form1.submit();
		return true;
	}else if("RC" == d){
		document.form1.action = "rc.jsp";
		document.form1.submit();
		return true;
	}else /*if("CRM" == d || "FM" == d || "SS" == d || "ES" == d )*/{
		document.form1.action = "CRMSSFM.jsp";
		document.form1.submit();
		return true;
	
	}
}
</script>
<title>query PT/PC</title>
</head>

<body onLoad="peak()">
<form name="form1"  method="post" target="mainFrame" onsubmit="return goAction()">

<select name="peak">
	<option value="on" class="txtred">旺季</option>
	<option value="off" >淡季</option>
</select>
<span class="txtblue">Fleet:</span>
<select name="fleet">
<%
for(int i=0;i<typeAL.size();i++){
	out.print("<option value=\""+(String)typeAL.get(i)+"\">"+(String)typeAL.get(i)+"</option>");
}
%>

</select>
<span class="txtblue">Rank:</span>
<select name="rank">
<option value="CA">CA</option>
<option value="FO">FO</option>
</select>
<span class="txtred">CheckType</span>
<select name="checkType">
	<option value="PC">PC</option>
	<option value="PT">PT</option>
	<option value="CRM">CRM</option>
	<option value="SS">SS</option>
	<option value="FM">FM</option>	
	<option value="ES">ES</option>				
	<option value="RC">RC</option>						
</select>
<input type="submit" class="button5" value="Query" >
</form>
</body>
</html>
