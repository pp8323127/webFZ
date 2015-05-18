<%@page contentType="text/html; charset=big5" language="java"%>
<%@ page import="fz.*,java.util.*" %>
<%!
	// 由於使用者名單是共享物件且設定為單一instance
	// 故宣告方式不能用<jsp:useBean>的tag

	UserList userlist = UserList.getInstance(); 
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<% //設定每60秒鐘頁面自動refresh	%>
<meta http-equiv="refresh" content=60>
<title>線上使用者名單</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" type="text/css" href="../../style/style1.css">
<link rel="stylesheet" type="text/css" href="../../style/lightColor.css">
</head>

<body>
<center>
 
  <table width="50%" border="0" cellspacing="0" cellpadding="0" class="tableStyle1" style="border-collapse:collapse;empty-cells:show; ">
  <caption class="txttitletop">Online User List（線上使用者名單）</caption>
    <tr class="center bgBlue2"> 
      <td >Empno</td>
      <td >Name</td>
      <td >Sern</td>
      <td >Occu</td>
      <td >Base</td>
    </tr>
<%
chkUser cu = new chkUser(); 
int pCount=0;
try{
  // 將線上使用者名單印出
  String empno = null;
  String rs = null;
  Enumeration elements = userlist.getList();
  int totalUser = 0;
  totalUser = userlist.getUserNum();
  int xCount=0;
  
  String bcolor = null;
  String occu = null;
  String sern = null;
  String name = null;
  String base = null;

  
  while(elements.hasMoreElements())
  {
     empno = (String)elements.nextElement();
	 rs = cu.findCrew(empno);
	 
	 pCount++;
	 if ("1".equals(rs))	
	 {
	 	occu = cu.getOccu();
		sern = cu.getSern();
		name = cu.getName();
		base = cu.getBase();
	 }
	 else 
	 {
	 //若為辦公室人員，則不顯示其在線上
	 continue;
	 /*	occu = "U";
		sern = "";
		name = "OfficeUser";
		base = "TSA";
	 */		
	 }
	 xCount++;
	
	if (xCount%2 == 0)
		{
			bcolor = "bgLBlue";
		}
		else
		{
			bcolor = "";
		}

%>
    <tr class="<%=bcolor%>"> 
	<td height="23" >
	
<%
/*if ("U".equals(occu)){
	name="";
	sern="";
	occu = "";
	base="";
*/
%>
	
<%
//}else{
%>
      <img src="../images/friend.gif" width="22" height="22" align="middle"><a href="javascript:viewCrew('<%=empno%>');" ><%=empno%></a>
<%
//}
%>
	</td>
      <td ><%=name%></td>
      <td ><%=sern%></td>
      <td ><%=occu%></td>
      <td ><%=base%></td>
    </tr>
<%
}
%>
  </table>
    <span class="txtblue">On Line User : <%=totalUser%><br>By click column of empno, you can view user's information <br>
（點選員工號，可查詢該使用者之個人資料)</span> 
</center>

<form name="form1" action="crewInfo.jsp" method="post" target="_self">
	<input type="hidden" name="tf_ename">
	<input type="hidden" name="tf_sess1">
	<input type="hidden" name="tf_sess2">
	<input type="hidden" name="tf_empno">
</form>
<script type="text/javascript" language="javascript">
	function viewCrew(empno){
		document.form1.tf_empno.value = empno;
		document.form1.submit();
	}
</script>
<%
}catch (Exception e)
{
	out.println(e.toString());
}
%>
</body>

</html>
