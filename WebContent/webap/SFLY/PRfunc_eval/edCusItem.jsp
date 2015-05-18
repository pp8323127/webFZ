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
List selectitemAL     = new ArrayList();
Driver dbDriver = null;

try{
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);

stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);

sql = "select itemno,itemdsc,flag,selectitem from egtprcus t ";
rs = stmt.executeQuery(sql);

while(rs.next()){
	itemNoAL.add(rs.getString("itemno"));
	itemDscAL.add(rs.getString("itemdsc"));
	flagAL.add(rs.getString("flag"));
	selectitemAL.add(rs.getString("selectitem"));

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
<link href="../style.css" rel="stylesheet" type="text/css">
<script src="../js/subWindow.js" type="text/javascript"></script>
<script src="../js/CheckAll.js" type="text/javascript"></script>
<script src="../js/changeAction.js" type="text/javascript"></script>
<script src="../js/checkBlank.js" type="text/javascript"></script>
<script src="../js/checkFItemDel.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript">
function checkAdd(){
	var v2 = document.form1.addItemDsc.value;
	if(v2 == ""){
		alert("請輸入項目內容(Item Description)\nPLease insert Item Description");
		document.form1.addItemDsc.focus();
		return false;
	}else{
		newAction('form1','insCusItem.jsp');
		return true;
	}

}	
</script>

<style type="text/css">
</style>
</head>

<body>
<div align="center">
  <%
	if(itemNoAL.size() != 0){

%> 
  <span class="txttitletop style1">Edit Item </span></div>
<form name="form1" method="post" action="insCusItem.jsp" onsubmit="return checkAdd()">
<table width="70%" border="0" align="center" class="tablebody">
<tr class="txtblue">
 <!-- <td width="15%" class="table_head"><div align="center"><input type="checkbox" name="all" onClick="CheckAll('form1','all')">Select</div></td>  -->
  <td width="15%" class="table_head"><span class="style6">ItemNo</span></td>
  <td width="60%" class="table_head"><span class="style6">Item</span></td>
  <td width="10%" class="table_head"><span class="style6">ShowItem </span></td>
  <td width="15%" class="table_head"><span class="style6">Template Item</td>
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
  <td class="txtblue"><div align="center"><%=itemNoAL.get(i)%></div></td>
  <td>
    <div align="left" class="txtblue style3">&nbsp;&nbsp;<a href="#" onClick="subwinXY('modCusItem.jsp?itemno=<%=itemNoAL.get(i)%>','sItem','600','500')"><%=itemDscAL.get(i)%></a></div>
  </td> 
  <td><div align="center" class="txtblue"><%=showFlag%></div></td>
  <td  Align="left">
	      <div align="left" class="style8">
	      <%
	      if(null!=selectitemAL && null!=selectitemAL.get(i)){ 
	      %>
	      <a href="#" onclick="subwinXY('edCusTemp.jsp?itemno=<%=itemNoAL.get(i)%>','edCusItem','600','300')"><%=selectitemAL.get(i).toString().replace("/", "<br>")%></a>
	      <%
	      }else{
		  %>
	      <a href="#" onclick="subwinXY('edCusTemp.jsp?itemno=<%=itemNoAL.get(i)%>','edCusItem','600','300')">Insert Template</a>
	      <%
		  } 
		  %>
	      </div>
      </td>
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
	
	<td width="65%" class="table_head"><div align="center"><span class="style6">&nbsp;Item Description</span></div></td>
	<td width="15%" class="table_head"><span class="style6">ShowItem</span></td>
  </tr>
  <tr>
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
  	<td colspan="2" class="txtblue">&nbsp;&nbsp;<span class="style7">Description max length:</span><span class="style5"> 100 English words</span></td>
	</tr>
  <tr>
    <td colspan="3" >
      <div align="center">
      <input name="Submit" type="submit" class="button1" value="Add">
        <!-- <input name="addItem" type="button" class="button1" id="addItem" value="Add" onClick="return checkAdd()"> -->
&nbsp;&nbsp;&nbsp;
<input name="Reset" type="reset" class="button1" value="Reset">
</div>
    </td>
    </tr>

</table>
</form>

</body>
</html>
