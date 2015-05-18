<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*,java.util.*" %>
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

String showFlag = null;
String flag     = null;
List itemNoAL   = new ArrayList();
List itemDscAL  = new ArrayList();
List flagAL     = new ArrayList();
Driver dbDriver = null;

try{
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);

stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);

sql = "select * from egtstfi order by itemno";
rs = stmt.executeQuery(sql);

while(rs.next()){
	itemNoAL.add(rs.getString("itemno"));
	itemDscAL.add(rs.getString("itemdsc"));
	flagAL.add(rs.getString("flag"));

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
<title>Edit Check Item </title>
<link href="style.css" rel="stylesheet" type="text/css">
<script src="js/subWindow.js" type="text/javascript"></script>
<script src="js/CheckAll.js" type="text/javascript"></script>
<script src="js/changeAction.js" type="text/javascript"></script>
<script src="js/checkBlank.js" type="text/javascript"></script>
<script src="js/checkFItemDel.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript">
function checkAdd(){
	var v1 = document.form1.addItemNo.value;
	var v2 = document.form1.addItemDsc.value;
	if(v1 == ""){
		alert("請輸入項目編號(ItemNo)\nPLease insert Item number");
		document.form1.addItemNo.focus();
		return false;
	}else if(v2 == ""){
		alert("請輸入項目內容(Item Description)\nPLease insert Item Description");
		document.form1.addItemDsc.focus();
		return false;
	
	}else{
		newAction('form1','insFItem.jsp');
		return true;
	}

}	
</script>

<style type="text/css">
<!--
.style1 {font-family: "Courier New", Courier, mono}
.style3 {color: #0000FF}
.style5 {color: #FF0000}
.style6 {
	color: #000000;
	font-weight: bold;
}
.style7 {color: #000000}
-->
</style>
</head>

<body>
<div align="center">
  <%
	if(itemNoAL.size() != 0){

%> 
  <span class="txttitletop style1">Edit Item </span></div>
<form name="form1" method="post" action="delFItem.jsp" onsubmit="return checkFItemDel('form1')">
<table width="70%" border="0" align="center" class="tablebody">
<tr class="txtblue">
 <!-- <td width="15%" class="table_head"><div align="center"><input type="checkbox" name="all" onClick="CheckAll('form1','all')">Select</div></td>  -->
  <td width="15%" class="table_head"><span class="style6">ItemNo</span></td>
  <td width="70%" class="table_head"><span class="style6">Item</span></td>
  <td width="15%" class="table_head"><span class="style6">ShowItem </span></td>
</tr>
<%
		
		for(int i=0;i<itemNoAL.size();i++){
		
		flag = (String)flagAL.get(i);
		if("Y".equals(flag) ){	//show Item
			showFlag="YES";
		}else{	// don't show Item
			showFlag="NO";
		}
		
		if(i%2 ==0)
			bgColor="#CCCCCC";
		else
			bgColor="#FFFFFF";

%>
<tr bgcolor="<%=bgColor%>">
 <!-- <td><div align="center">
   <input type="checkbox" name="itemno" value="<%//=itemNoAL.get(i)%>"></div></td> -->
  <td class="txtblue"><div align="center"><a href="#" onClick="subwinXY('modFItem.jsp?itemno=<%=itemNoAL.get(i)%>','fItem','600','300')"><%=itemNoAL.get(i)%></a></div></td>
  <td>
    <div align="left" class="txtblue style3">&nbsp;&nbsp;<a href="#" onClick="subwinXY('edSItem.jsp?kin=<%=itemNoAL.get(i)%>','sItem','600','500')"><%=itemDscAL.get(i)%></a></div>
  </td> 
  <td><div align="center" class="txtblue"><%=showFlag%></div></td>
</tr>
<%}

%>
</table>
<%
}else{
	out.print("NO DATA!!");
}
%>
<table width="70%" border="0" align="center" >
  <!--<tr>
    <td >
      <div align="center">
        <input name="Submit" type="submit" class="table_body2" value="Delete">
      </div>
    </td>
    </tr> -->
  <tr>
    <td class="txtred" ><div align="center">Click <strong>ItemNo</strong> to Edit.&nbsp; &nbsp;&nbsp;Click <strong>Item</strong> to view/edit subitem.</div></td>
  </tr>

</table>
<hr  width="70%" noshade>
<div align="center"><span class="txttitletop style1">Add Item </span></div>
<table width="70%" border="1" align="center" cellpadding="1" cellspacing="1" >
  <tr bgcolor="#9CCFFF" class="txtblue">
	<td width="25%" class="table_head"><div align="center"><span class="style6">Itemno</span></div></td>
	<td width="62%" class="table_head"><div align="center"><span class="style6">&nbsp;Item Description</span></div></td>
	<td width="13%" class="table_head"><span class="style6">ShowItem</span></td>
  </tr>
  <tr>
    <td >
      <div align="center">
        <input name="addItemNo" type="text" id="addItemNo" size="2" maxlength="2" onkeyup="javascript:this.value=this.value.toUpperCase();" >
      </div>
    </td>
    <td >
      <input name="addItemDsc" type="text" id="addItemDsc" size="47" maxlength="100" >
    </td>
	<td><div align="center">
	  <select name="addFlag" id="addFlag">
	      <option value="Y">Yes</option>
	      <option value="N">No</option>
	      </select>
	  </div></td>
  </tr>
    <tr>
  	<td width="25%" class="txtblue">&nbsp;<span class="style7">Example:</span><span class="style3"> A、B、C...</span></td>
  	<td colspan="2" class="txtblue">&nbsp;&nbsp;<span class="style7">Description max length:</span><span class="style5"> 100 English words</span></td>
	</tr>
  <tr>
    <td colspan="3" >
      <div align="center">
        <input name="addItem" type="button" class="button1" id="addItem" value="Add" onClick="return checkAdd()">
&nbsp;&nbsp;&nbsp;
<input name="Submit" type="reset" class="button1" value="Reset">
</div>
    </td>
    </tr>

</table>
</form>

</body>
</html>
