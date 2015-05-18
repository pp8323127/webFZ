<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="java.sql.*,ci.db.*,java.util.* "%>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("logout.jsp");
} 

Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
String sql = null;
String bgColor=null;
ConnDB cn = new ConnDB();

List itemNoAL   = new ArrayList();
List itemDscAL  = new ArrayList();
Driver dbDriver = null;

try{
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);


stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);

sql = "select itemno, itemdsc from egtstrm order by itemno";
rs = stmt.executeQuery(sql);

while(rs.next()){
	itemNoAL.add(rs.getString("itemno"));
	itemDscAL.add(rs.getString("itemdsc"));
}

}catch(Exception e){
	out.print(e.toString());
}finally{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}

}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Edit/Add Remark Attribute Value</title>
<link href = "style.css" rel="stylesheet" type="text/css">
<script src="js/subWindow.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript">
function checkAdd(){
	var v1 = document.form1.addItemNo.value;
	var v2 = document.form1.addItemDsc.value;
	if(v1 == ""){
		alert("請輸入項目編號(ItemNo)\nPLease insert the Item number");
		document.form1.addItemNo.focus();
		return false;
	}else if(v2 == ""){
		alert("請輸入備註欄屬性值內容(Remark Attribute Value Description)\nPLease Remark Attribute Value Description");
		document.form1.addItemDsc.focus();
		return false;
	
	}else{
		return true;
	}

}	

</script>

<style type="text/css">
<!--
.style3 {color: #0000FF}
.style7 {color: #993366}
.style8 {color: #9C3063}
.style9 {color: #000000}
-->
</style>
</head>

<body>
<p align="center" class="txttitletop style7" >Edit Remark Attribute</P>
<form name="form1" method="post" action="addRemark.jsp" onsubmit="return checkAdd()">
<table width="80%" border="1" align="center" cellpadding="1" cellspacing="1" class="tablebody">
  <tr class="tablehead3">
    <td width="11%" class="tablehead3"><strong>ItemNo</strong></td>
    <td width="89%" class="tablehead3"><div align="center"><strong>Remark Attribute Value </strong></div></td>
  </tr>
  <%
	if(itemNoAL.size() != 0)
	{	
		for(int i=0;i<itemNoAL.size();i++){
		
			if(i%2 ==0)
				bgColor="#CCCCCC";
			else
				bgColor="#FFFFFF";

		%>
  		<tr bgcolor="<%=bgColor%>">
    		<td><div align="center"><a href="#" class="txtblue style3" onClick="subwin('modRemark.jsp?itemNo=<%=itemNoAL.get(i)%>','Remark_itemDsc')"><%=itemNoAL.get(i)%></a></div></td>
    		<td><div align="left" class="txtblue style9">&nbsp;<%=itemDscAL.get(i)%></div></td>
  		</tr>
  		<%
		}

	}// if(itemNoAL.size() != 0) loop end 
	else
	{
	%>
	  	<tr bgcolor="#FFFF99">
   		  <td colspan="2"><div align="center" class="txttitletop style8">No Data!!</div></td>
	</tr>
	<%		
	}
	%>	
  </table>
	
<table width="80%" border="0" align="center" >
  <tr>
    <td class="txtred" ><div align="center">Click <strong>ItemNo</strong> to Edit the Remark Attribute Value description.</div></td>
  </tr>
</table>

<hr  width="80%" noshade>
<p align="center" class="txttitletop  style8">Add Remark Attribute </p>
<table width="80%" border="1" align="center" cellpadding="1" cellspacing="1" >
  <tr class="tablehead3">
     <td width="22%" >
       <div align="center" class="tablehead3"><strong>ItemNo</strong></div>
     </td>
     <td width="78%" ><div align="center" class="tablehead3"><strong>Remark Attribute Value Description
	   </strong></div>
	 </td>
  </tr>
  <tr class="txtblue">
    <td >
      <div align="center">
        <input name="addItemNo" type="text" id="addItemNo" size="3" maxlength="3" >
      </div>
    </td>
    <td >
      <input name="addItemDsc" type="text" id="addItemDsc" size="70" maxlength="50" >
    </td>
	</tr>
    <tr>
  	<td width="22%"><p class="txtblue">&nbsp;<span class="style9">Example</span>:<br>
&nbsp;&nbsp;<span class="style3">001、002、003...</span></p>
  	  </td>
  	<td width='78%'>&nbsp;<span class="txtblue"><span class="style9">Input Remark Attribute Value Description max length:</span><br>
  	  &nbsp;&nbsp;<span class="style3">50 English words /  25 Chinese words </span></span></td>
	</tr>
  <tr>
    <td colspan="3" class="txtblue" >
      <div align="center">
	      <input name="Submit" type="submit" class="button2" value=" Add ">　　
    		<input name="Submit" type="reset" class="button2" value=" Reset ">
        </div>
    </td>
    </tr>

</table>
</form>

</body>
</html>
