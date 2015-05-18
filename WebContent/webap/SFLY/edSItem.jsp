<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*,java.util.*" %>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("logout.jsp");
} 

Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
ConnDB cn = new ConnDB();

String sql = null;
String bgColor=null;
String kin = null;
String itemno;
String itemdesc;
String itemname = null;
ArrayList itemNoAL = new ArrayList();
ArrayList itemDscAL = new ArrayList();
ArrayList sflagAL = new ArrayList();
ArrayList selectitemAL = new ArrayList();
//List kinAL = new ArrayList();

kin = request.getParameter("kin");
Driver dbDriver = null;

try{
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);

stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);

sql = "select itemno||'. '||itemdsc as itemdsc from egtstfi where itemno = '" + kin + "'";
rs = stmt.executeQuery(sql);
while(rs.next())
{
	itemname = rs.getString("itemdsc");
}
rs.close();

sql = "";
sql = "select * from egtstsi where kin = '" + kin + "' order by itemno ";
rs = stmt.executeQuery(sql);
while(rs.next()){
	itemNoAL.add(rs.getString("itemno"));
	itemDscAL.add(rs.getString("itemdsc"));
	sflagAL.add(rs.getString("sflag"));
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
<link href="style.css" rel="stylesheet" type="text/css">
<script src="js/subWindow.js" type="text/javascript"></script>
<script src="js/CheckAll.js" type="text/javascript"></script>
<script src="js/checkDel.js" type="text/javascript"></script>
<style type="text/css">
<!--
.style2 {
	font-family: "Courier New", Courier, mono;
	font-size: 12pt;
}
.style8 {color: #000000}
.style10 {font-size: 14px; color: #000000; font-weight: bold; }
-->
</style>
</head>

<body>

<form name="form1" method="post" action="updSItem.jsp?status=del&kin=<%=kin%>" onsubmit="return checkDel('form1')">
<div align="center">
  <table width="80%" border="0" align="center">
    <tr>
      <td class="txtblue">Item :&nbsp;<%=itemname%></td>
      <td>
          <div align="right">
            <input name="add" type="button" class="button2" id="add" value="Insert SubItem" onclick="subwinXY('insSItem.jsp?kin=<%=kin%>','insSItem','600','300')" > 
		  <!--  <input name="Submit" type="submit" class="button2" value="Delete">-->&nbsp; 
		    <input type="button" name="close" value="Close window" class="button2" onclick="window.close()">
          </div>
        </td>
    </tr>
  </table>
</div>
<p align="center"></p>
<div align="center">
  <table width="80%" border="0" align="center" class="tablebody">
    <tr bgcolor="#9CCFFFF" class="txtblue">
      <!--<td width="20%" class="table_head">
    <div align="center">
      <input type="checkbox" name="all" onClick="CheckAll('form1','all')">
        Select</div>
  </td>-->
      <td width="15%" class="table_head">
        <div align="center" class="style10">SubItem No</div>
      </td>
      <td width="45%" class="table_head style10 style8">SubItem Description</td>
      <td width="10%" class="table_head style10 style8">Show Item</td>
      <td width="30%" class="table_head style10 style8">Template Item</td>
    </tr>
    <%
	if(itemNoAL.size() != 0)
	{
		for(int i=0;i<itemNoAL.size();i++)
		{
		if(i%2 ==0)
			bgColor="#CCCCCC";
		else
			bgColor="#FFFFFF";
	
%>
    <tr bgcolor="<%=bgColor%>" class="txtblue">
    <!--  <td><input type="checkbox" name="itemno" value="<%=itemNoAL.get(i)%>"></td>-->
      <td  Align="Center"><span class="style8"><%=itemNoAL.get(i)%></span></td>
      <td  Align="left">
	      <div align="left" class="style8">&nbsp;&nbsp;<a href="#" onclick="subwinXY('modSItem.jsp?itemno=<%=itemNoAL.get(i)%>&kin=<%=kin%>','updSItem','600','300')"><%=itemDscAL.get(i)%></a></div>
      </td>
      <td  Align="Center"><span class="style8"><%=sflagAL.get(i)%></span></td>
      <td  Align="left">
	      <div align="left" class="style8">
	      <%
	      if(null!=selectitemAL && null!=selectitemAL.get(i)){ 
	      %>
	      <a href="#" onclick="subwinXY('edTItem.jsp?itemno=<%=itemNoAL.get(i)%>&kin=<%=kin%>','edTItem','600','300')"><%=selectitemAL.get(i).toString().replace("*", "<br>")%></a>
	      <%
	      }else{
		  %>
	      <a href="#" onclick="subwinXY('edTItem.jsp?itemno=<%=itemNoAL.get(i)%>&kin=<%=kin%>','edTItem','600','300')">Insert Template</a>
	      <%
		  } 
		  %>
	      </div>
      </td>
    </tr>
    <%}
}else{
	out.print("<tr><td colspan=3 class='table_head'><div align='center'>NO DATA !!</div></td>");
}
%>
  </table>
</div>
</form>
<div align="center">
  <%
if(itemNoAL.size() != 0)
{
%>
</div>
<div align=center class="style2">
  <div align="center"><font color=red>Click subitem for editing.</font></div>
</div>
<div align="center">
  <%
}
%>
</div>
</body>
</html>
