<%@ page contentType="text/html; charset=big5" language="java"  errorPage="" %>
<%@ page import="java.sql.*,ci.db.*"%>
<%
//編輯已存在的GdType
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);

String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if ( sGetUsr == null) {		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
	
}


String cname	= request.getParameter("cname");
String ename = request.getParameter("ename");
if (ename == null) {ename = "&nbsp;";}
String fdate = request.getParameter("fdate");
String yearSern = request.getParameter("yearSern");

String sern  = null;
String fltno = null;
String sect  = null;
String GdYear= null;
String empno = null;
String comm = null;
String gdName = null;
String gdType = null;

ArrayList gdNameAL = new ArrayList();
ArrayList gdTypeAL = new ArrayList();
ArrayList gdComm	= new ArrayList();

//考評項目
fz.pracP.GdTypeName gn = new fz.pracP.GdTypeName();
try {
	gn.SelectData();
} catch (InstantiationException e) {
	out.print(e.toString());
} catch (IllegalAccessException e) {
	out.print(e.toString());
} catch (ClassNotFoundException e) {
	out.print(e.toString());
} catch (SQLException e) {
	out.print(e.toString());
}



Driver dbDriver = null;
Connection conn = null;
Statement stmt = null;
ResultSet myResultSet = null;
String sql = "";
ArrayList CommAL = gn.getCommAL();

try{
	ConnDB cn = new ConnDB();
	cn.setORP3EGUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
	stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
		ResultSet.CONCUR_READ_ONLY);
sql ="SELECT * FROM EGTGDDT WHERE yearsern='"+yearSern+"'";
myResultSet = stmt.executeQuery(sql);
	if(myResultSet.next()){
			sern  = myResultSet.getString("sern");
			fltno = myResultSet.getString("fltno");
			sect  = myResultSet.getString("sect");
			GdYear= myResultSet.getString("gdyear");
			empno = myResultSet.getString("empn");	
			comm = myResultSet.getString("comments");
			gdName= gn.ConverGdTypeToName(myResultSet.getString("gdtype"));//將gdType轉為gdName

			gdType = myResultSet.getString("gdtype");
	}
	
myResultSet.close();

}
catch (Exception e)
{
	  out.print(e.toString());
}
finally
{
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>編輯考核項目</title>
<link href="style2.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.y {
	background-color: #FFFFCC;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size:10pt;
	color: #000099;
	border: 1px solid;
}
-->
</style>
<script language="JavaScript" type="text/JavaScript">
function checkCharacter(){

	var message = document.form1.comm.value;
	var len = document.form1.comm.value.length;
		//alert(len);
	if(len >800){
		alert("Comments字元數限制為1000個字元，\n所輸入字數超過"+(len-800)+"個字元，請重新輸入");
		document.form1.comm.focus();
		return false;
	}
	else if(len == ""){
		if(confirm("尚未選擇Comments敘述，確定要送出？")){
			document.form1.Submit.disabled=1;
			document.form1.addToComm.disabled=1;
			return true;
		}
		else{
			document.form1.comm.focus();
			return false;
		}
	}
	else{
		document.form1.Submit.disabled=1;
		document.form1.addToComm.disabled=1;
	
		return true;
	}
}
/*
//選取的預設comments後，將值帶到輸入欄位，可重複附加
function addComments(){
    var addcomm = document.form1.gdComm.value;
	var originalComm = document.form1.comm.value;
	originalComm +=  ","+addcomm;	//用,隔開
	if(document.form1.comm.value == ""){	
		document.form1.comm.value = addcomm;	//輸入欄位無內容，直接加入選取的comments
	}
	else{
		document.form1.comm.value = originalComm;	//輸入欄位已有內容，附加選取的comments並用,隔開
	}
	
}
*/

function addComm2(){//將第一個comments的選項值帶到輸入欄位，可重複附加
    var addcomm = document.form1.gdComm.value;
	var originalComm = document.form1.comm.value;
	originalComm +=  ","+addcomm;	//用,隔開
	if(document.form1.comm.value == ""){	
		document.form1.comm.value = addcomm;	//輸入欄位無內容，直接加入選取的comments
	}
	else{
		document.form1.comm.value = originalComm;	//輸入欄位已有內容，附加選取的comments並用,隔開
	}
}
function clearcomm(){

	var comm = document.form1.gdname.value;
	if(comm == "GD17"){
		document.form1.gdComm.length=<%=CommAL.size()%>+1;
		document.form1.gdComm.options[0] = new Option("","");
		document.form1.gdComm.options[0].selected;
		<%
		for(int i=0;i<CommAL.size();i++){
		out.print("document.form1.gdComm.options["+(i+1)+"] = new Option(\""+CommAL.get(i)+"\",\""+CommAL.get(i)+"\");\r\n");
		}		
		%>		
		
	}else if(comm == "GD20"){
		document.form1.gdComm.length=2;
		document.form1.gdComm.options[0] = new Option("YES","YES");
		document.form1.gdComm.options[1] = new Option("NO","NO");
	}else if(comm == "GD25"){
		document.form1.gdComm.length=2;
		document.form1.gdComm.options[0] = new Option("YES","YES");
		document.form1.gdComm.options[1] = new Option("NEED TO IMPROVE","NEED TO IMPROVE");
	}else if(comm == "GD28"){
		document.form2.gdComm.length=2;
		document.form2.gdComm.options[0] = new Option("YES","YES");
		document.form2.gdComm.options[1] = new Option("NO","NO");
	}else{
		document.form1.gdComm.length=<%=CommAL.size()%>;
		<%
		for(int i=0;i<CommAL.size();i++){
		out.print("document.form1.gdComm.options["+i+"] = new Option(\""+CommAL.get(i)+"\",\""+CommAL.get(i)+"\");\r\n");
		}		
		%>		
		//document.form1.gdComm.value = "工作敬業、認真";
	}
}


</script>
</head>

<body onLoad="javascript:document.form1.comm.focus()">
<div align="center">

    <span class="txttitletop">Edit In-Flight Service Grade</span>
</div>
<form name="form1" method="post" action="upGdType2.jsp" onSubmit="return checkCharacter()">
  <table width="78%"  border="0" align="center" cellpadding="2" cellspacing="0" >
    <tr>
      <td class="txtblue">Date:<span class="txtred"><%=fdate%></span></td>
      <td class="txtblue">Fltno:<span class="txtred"><%=fltno%></span></td>
      <td class="txtblue">Sern:<span class="txtred"><%=sern%></span></td>
      <td class="txtblue">&nbsp;</td>
    </tr>
    <tr>
      <td colspan="4" class="txtblue">Name:<span class="txtred"><%=cname%>&nbsp;<%=ename%></span></td>
    </tr>
  </table>
  <table width="78%"  border="0" align="center" cellpadding="2" cellspacing="0" class="fortable">
    <tr >
      <td width="13%" class="y">
        <div align="center">Item</div>
      </td>
      <td width="87%" class="txtblue"><%=gdName%>
	  	<input name="gdname" id="gdname" type="hidden" value="<%=gdType%>"></td>
		<input name="gddesc" id="gddesc" type="hidden" value="<%=gdName%>">
	  </td>
    </tr>
    <tr>
      <td height="59"class="y">
        <div align="center">Comments</div>
      </td>
	  <td class="fortable">
<%
if(gdType.equals("GD20") | gdType.equals("GD25") | gdType.equals("GD28"))
{
%>
        <select name="gdComm" >
		<%
		if(gdType.equals("GD20"))
		{
		out.print("<option value=\"YES\">YES</option>");
		out.print("<option value=\"NO\">NO</option>");		
		} 
		else if(gdType.equals("GD25"))
		{
		out.print("<option value=\"YES\">YES</option>");
		out.print("<option value=\"NEED TO IMPROVE\">NEED TO IMPROVE</option>");		
		}
		else if(gdType.equals("GD28"))
		{
		out.print("<option value=\"YES\">YES</option>");
		out.print("<option value=\"NO\">NO</option>");		
		}
		%>			
       </select>	
		<input type="button" onclick="addComm2()"  name="addToComm"  value="Add to comments" >
<%
}			
%>
          <textarea name="comm" cols="50" rows="4"><%=comm%></textarea>
        </p>
      </td>
    </tr>
  </table>
  <div align="center">
      <input type="submit" name="Submit" value="Save (儲存)" class="addButton">
      &nbsp;&nbsp;&nbsp;
		  <input name="reset" type="reset" value="Reset (清除重寫)">
		&nbsp;&nbsp;&nbsp;
          <input name="button" type="button"  onClick="javascript:self.close()" value="Exit (離開)">
&nbsp;&nbsp;&nbsp;
 		    <input type="hidden" name="fltno" value="<%=fltno%>">
		    <input type="hidden" name="fdate" value="<%=fdate%>">
		    <input type="hidden" name="sern" value="<%=sern%>">
		    <input type="hidden" name="cname" value="<%=cname%>">
		    <input type="hidden" name="ename" value="<%=ename%>">
		    <input type="hidden" name="sect" value="<%=sect%>">
		    <input type="hidden" name="GdYear" value="<%=GdYear%>">
		    <input type="hidden" name="empno" value="<%=empno%>">
			<input type="hidden" name="yearSern" value="<%=yearSern%>">
    </div>
</form>

</body>
</html>


