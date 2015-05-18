<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*,java.util.*" %>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("../logout.jsp");
} 

String sort = request.getParameter("sort");
if("".equals(sort) | sort == null)
{
	sort = "itemno";
}

Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
String sql = null;
String bgColor=null;
ConnDB cn = new ConnDB();

//String showFlag = null;
//String flag     = null;

List issueNoAL   = new ArrayList();
List issueDscAL  = new ArrayList();
List flagAL     = new ArrayList();
Driver dbDriver = null;

try{
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);

stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);

sql = "select itemno, subject, flag from egtstci order by "+sort+"";
rs = stmt.executeQuery(sql);

while(rs.next()){
	issueNoAL.add(rs.getString("itemno"));
	issueDscAL.add(rs.getString("subject"));
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
<title>Edit Self Inspection Issue </title>
<link href ="../style.css" rel="stylesheet" type="text/css">
<script src="../js/subWindow.js" type="text/javascript"></script>
<!--<script src="..js/CheckAll.js" type="text/javascript"></script>
<script src="..js/changeAction.js" type="text/javascript"></script>
<script src="..js/checkBlank.js" type="text/javascript"></script>
<script src="..js/checkFItemDel.js" type="text/javascript"></script>-->
<script language="javascript" type="text/javascript">
function checkAdd(){
	var v1 = document.form1.addIssueNo.value;
	var v2 = document.form1.addIssueDsc.value;
	if(v1 == ""){
		alert("請輸入項目編號(IssueNo)\nPLease insert the Issue number");
		document.form1.addIssueNo.focus();
		return false;
	}else if(v2 == ""){
		alert("請輸入項目內容(Issue Description)\nPLease insert the Issue Description");
		document.form1.addIssueDsc.focus();
		return false;
	
	}else{
		//newAction('form1','insIssue.jsp');
		return true;
	}

}	

</script>

<style type="text/css">
<!--
.style3 {color: #0000FF}
.style5 {color: #FF0000}
.style7 {
	font-size: 14;
	color: #000000;
}
.style8 {color: #000000}
.style9 {color: #000000; font-size: 12px; }
.style14 {font-size: 12}
.style15 {font-family: Verdana}
.style17 {font-size: 12; font-weight: bold; font-family: Verdana; }
-->
</style>
</head>

<body>

<p align="center" class="txttitletop" >Edit Self Inspection List Issue </P>
<form name="form1" method="post" action="addIssue.jsp" onsubmit="return checkAdd()">
<table width="80%" border="1" align="center" cellpadding="1" cellspacing="1" class="table_border2">
  <tr class="table_head">
    <td width="10%"><span class="style17"><a href="edIssue.jsp?sort=itemno" >IssueNo</a></span></td>
    <td width="85%"><div align="center" class="table_head style14 style15"><strong>Issue</strong></div></td>
    <td width="5%"><div align="center" class="style17"><a href="edIssue.jsp?sort=flag">Flag</a></div></td>
  </tr>
  <%
	if(issueNoAL.size() != 0)
	{		
	
		for(int i=0;i<issueNoAL.size();i++){
		
		if(i%2 ==0)
			bgColor="#CCCCCC";
		else
			bgColor="#FFFFFF";

	%>
  	<tr bgcolor="<%=bgColor%>" class="txtblue">
    	<td><div align="center" class="style8"><a href="#" class="style9" onClick="subwin('modIssue.jsp?issueNo=<%=issueNoAL.get(i)%>','SIL_issue')"><%=issueNoAL.get(i)%></a></div></td>
   	  <td class="txtblue"><div align="left" class="style7">&nbsp;<%=issueDscAL.get(i)%></div></td>
   	  <td class="txtblue"><div align="center" class="style7">&nbsp;<%=flagAL.get(i)%></div></td>
  	</tr>
  	<%
  		}
	}// end of  if(issueNoAL.size() != 0) loop
	else
	{
	%>
	  	<tr bgcolor="#FFFF99">
   		  <td colspan="3"><div align="center" class="txttitletop">No Data!!</div></td>
		</tr>
	<%		
	}
	%>	
</table>
<table width="80%" border="0" align="center" >
  <tr>
    <td class="txtred" ><div align="center">Click <strong>IssueNo</strong> to Edit the issue description.</div></td>
  </tr>
</table>

<hr  width="80%" noshade>
<p align="center" class="txttitletop ">Add Self Inspection List Issue</p>
<table width="80%" border="1" align="center" cellpadding="1" cellspacing="1" class="table_border2" >
  <tr class="tablehead3">
     <td width="22%" >
       <div align="center" class="tablehead3"><strong>IssueNo</strong></div>
     </td>
     <td width="78%" ><div align="center" class="tablehead3"><strong>Issue Description
	   </strong></div>
	 </td>
  </tr>
  <tr>
    <td >
      <div align="center">
        <input name="addIssueNo" type="text" id="addIssueNo" size="3" maxlength="3" >
      </div>
    </td>
    <td >
      <input name="addIssueDsc" type="text" id="addIssueDsc" size="70" maxlength="150" >
    </td>
	</tr>
    <tr class="txtblue">
  	<td width="22%"><p>&nbsp;Example:<span class="style3"><br>&nbsp;&nbsp;001、002、003...</span></p>
  	  </td>
  	<td width='78%'>&nbsp;<span class="txtxred">Input Issue Description max length</span>:<span class="style5"><br>
  	&nbsp;&nbsp;</span><span class="style3">150 English words /  75 Chinese words</span> </td>
	</tr>
  <tr>
    <td colspan="3" >
      <div align="center">
	      <input name="Submit" type="submit" value="Add">　　
    		<input type="reset" name="Submit" value="Reset">
        </div>
    </td>
    </tr>

</table>
</form>

</body>
</html>
