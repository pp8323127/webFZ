<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="fz.*,java.sql.*,java.util.Date,java.text.DateFormat,ci.db.*"%>
<%
//自訂好友名單
/*
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
*/
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
 %>
 <jsp:forward page="../sendredirect.jsp" /> 
<%
} 

String userid =(String) session.getAttribute("userid") ;

Connection conn = null;
Driver dbDriver = null;

Statement stmt = null;
ResultSet myResultSet = null;
boolean t = false;
try
{
ConnDB cn = new ConnDB();
cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);

stmt = conn.createStatement();

String bf_empno = null;


//String sql = "select bf_empno from fztfrid where empno='"+sGetUsr +"' order by bf_empno";
String sql = "select empno,name,ename,nvl(box,'&nbsp;') box,sess,cabin,occu,base,email from fztcrew "
			+"where empno in (select bf_empno from fztfrid where empno='"+sGetUsr +"') order by empno";
//out.print(sql);
myResultSet = stmt.executeQuery(sql); 

String cname = null;
String ename = null;
String box = null;
String sess = null;
String cabin = null;
String occu = null;
String base = null;
String email = null;

//get Date
java.util.Date nowDate = new Date();
int syear	=	nowDate.getYear() + 1900;
int smonth	= 	nowDate.getMonth() + 1;
int sdate	= nowDate.getDate();
if (sdate >=25){	//超過25號，抓下個月的班表
	
	if (smonth == 12){	//超過12月25號，抓明年1月的班表
		smonth = 1;
		syear = syear+1;
	}
	else{
		smonth = smonth+1;
	}
}

%>

<html>
<head>
<title>自訂我的好友</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="../menu.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style1 {color: #FFFFFF}
.dele {
	font-family: "細明體";
	font-size: 10pt;
	color: #FFFF00;
	background-color: #FF0000;
	border: #006666;
}
.dele2 {
	font-family: "細明體";
	font-size: 10pt;
	color: #FFFF00;
	border: 2px solid #FF0000;
}

.e2 {
	background-color: #ccffff;
	border-right: 1pt solid #666666;
	border-bottom: 1pt solid #666666;
	border-left: 1pt solid #cccccc;
	border-top: 1pt solid #cccccc;
}

-->
</style>
</head>
<!--    action="delfri.jsp" -->
<script language="JavaScript" type="text/JavaScript">

function del(){
	count = 0;
	for (i=0; i<document.form1.length; i++) {
		if (document.form1.elements[i].checked) count++;
	}
	if(count ==0 ) {
		alert("Please select delete item\n尚未勾選要刪除的項目!!");
		return false;
	}
	
	else{
	
		if(	confirm("Do you really want to Delete??\n確定要刪除此筆資料？?")){
				document.form1.action = "delfri.jsp";
				document.form1.submit();
				return true;
			}
		else{
				//location.reload();
				document.form1.reset();
				return false;
			}
	}
	

}
function sendmail(){
	document.form1.action = "../mail_cs66.jsp";
	document.form1.submit();

}

function chk(){	//驗證不可將自己設為好友
	if(document.form2.addfrid.value =="<%=sGetUsr%>"){
		alert("Error!!You can't add yourself to friend list\n請勿將自己加入好友!!");
		//location.reload()
		document.form2.addfrid.value="";
		document.form2.addfrid.focus();
		return false;
	}
	else{
		var colValue = document.form2.addfrid.value;
   	 if(colValue ==""){
			alert("Please insert your good friend!!\n請輸入好友!!");
			document.form2.addfrid.focus();
			return false;
	 }else{
			return true;
	 }
		
	}


}
function viewCrewInfo(empno){

		document.formC.tf_empno.value = empno;	
		document.formC.submit();
	}
</script>

<body onload="document.form2.addfrid.focus();">
<form name="formC" method="post" action="crewInfo.jsp">
<input type="hidden" name="tf_empno" id="tf_empno" >
<input type="hidden" name="tf_sess1"  >
<input type="hidden" name="tf_sess2"  >
<input type="hidden" name="tf_ename"  >
</form>
<div align="center"><span class="txttitletop">Friend List(好友名單列表)</span>&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" value="看哪些人設我為好友" onClick="javascript:window.open('goodfriend2.jsp')" class="e2">
</div>
<div align="center"><br>
    <span class="style1"><span class="txtblue">You can query the crew by click Name column (點選姓名可查詢該組員資料)</span></span></div>
<form  method="post" name="form1" >
  <table width="92%"  border="1" align="center" cellpadding="0" cellspacing="1" class="fortable">
    <tr>
      <td height="23" colspan="12" class="tablehead3"><div align="center">我的好友（My Friend ） </div></td>
    </tr>
    <tr>
      <td width="12%" bgcolor="#999999"  class="tablebody style1">Empno</td>
      <td width="13%" bgcolor="#999999"  class="tablebody style1">Sern</td>
      <td width="15%" bgcolor="#999999"  class="tablebody style1">Name</td>
      <td width="30%" bgcolor="#999999"  class="tablebody style1">EName</td>
      <td width="9%" bgcolor="#999999"  class="tablebody style1">Email</td>
      <td width="10%" bgcolor="#999999"  class="tablebody style1">Send Mail </td>
    </tr>
    <div align="center">
      <%
	if(myResultSet != null){
	while (myResultSet.next()){
		bf_empno 	= 	myResultSet.getString("empno");
		cname 		= 	myResultSet.getString("name");
		ename		=	myResultSet.getString("ename");
		box 		= 	myResultSet.getString("box");
		sess 		= 	myResultSet.getString("sess");
		cabin 		= 	myResultSet.getString("cabin");
		occu 		=	myResultSet.getString("occu");
		base 		= 	myResultSet.getString("base");
		email		= 	myResultSet.getString("email");
	%>
      <tr>
        <td class="tablebody">
          <div align="center"><acronym title="show information of <%=cname%> ( <%=ename%> ) "><a href="javascript:viewCrewInfo('<%=bf_empno%>')" ><%=bf_empno%></a></acronym>
              <input name="friend" type="hidden" value="<%=bf_empno%>">
              <br>
          </div></td>
        <td class="tablebody"><div align="center"><%=box%></div></td>
        <td class="tablebody"><div align="center"><%=cname%></div></td>
        <td class="tablebody"><div align="left">&nbsp;<%=ename%></div></td>
        <td class="tablebody"><div align="center"><a href="../mail.jsp?to=<%=email%>&cname=<%=ename%>" target="_blank"><img src="../images/mail.gif" alt="mail to <%=cname%>" border="0"></a></div></td>
        <td class="tablebody"><div align="center">
          <input type="checkbox" name="to" value="<%=bf_empno%>">
        </div></td>
      </tr>
      <%
		}
	}
	
	%>
    </div>
    <tr>
      <td colspan="12"  class="tablebody"><div align="center">&nbsp;&nbsp;
              <input name="SubmitDel" type="button" class="dele" value="Delete"  onClick="del()">
&nbsp;&nbsp;
<input name="SubmitMail" type="button"  value="SendMail" onClick="sendmail()">
      </div></td>
    </tr>
  </table>
</form>
<form action="updfri.jsp"  method="post" name="form2" id="form2" onSubmit="return chk()">
  <table width="38%"  border="1" align="center" cellpadding="0" cellspacing="1" class="fortable">
    <tr>
      <td colspan="2" class="tablehead3"><div align="center">新增好友名單(Add to list)</div></td>
    </tr>
        <div align="center">
 <tr>
   <td class="tablebody">     
         <div align="left">
         <span class="txtblue">&nbsp;</span><span class="txtxred">EmpNo</span>
         <input name="addfrid" type="text" size="29" maxlength="40">
		 </div>
   </td>
  </tr>	  
        </div>
   
    <tr>
      <td height="25" colspan="2"  class="tablebody"><div align="center">        &nbsp;&nbsp;
        <input name="Submit" type="submit" class="btm" value=" Add " >
      </div></td>
    </tr>
  </table>

	

</form>
</body>
</html>
<%
}
catch (Exception e)
{
	out.println(e.toString());
	t = true;
}
finally
{
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
if(t)
{
%>
      <jsp:forward page="../err.jsp" /> 
<%
}
%>