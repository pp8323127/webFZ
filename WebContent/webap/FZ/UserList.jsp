<%@page contentType="text/html; charset=big5" language="java"%>
<%@ page import="fz.*,java.util.*" %>
<%!
	// �ѩ�ϥΪ̦W��O�@�ɪ���B�]�w����@instance
	// �G�ŧi�覡�����<jsp:useBean>��tag

	UserList userlist = UserList.getInstance();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<% //�]�w�C60���������۰�refresh	%>
<meta http-equiv="refresh" content=60>
<title>�u�W�ϥΪ̦W��</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" type="text/css" href="../style/style1.css">
<link rel="stylesheet" type="text/css" href="../style/lightColor.css">
</head>

<body>
<center>
 
  <table width="50%" border="0" cellspacing="0" cellpadding="0" class="tableStyle1" style="border-collapse:collapse;empty-cells:show; ">
  <caption class="txttitletop">Online User List�]�u�W�ϥΪ̦W��^</caption>
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
  // �N�u�W�ϥΪ̦W��L�X
  String empno = null;
  String rs = null;
  Enumeration elements = userlist.getList();
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
	 else //�Y���줽�ǤH���A�h��ܥH�U��T
	 {
	 	occu = "U";
		sern = "";
		name = "OfficeUser";
		base = "TSA";
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
if ("U".equals(occu))
{
%>
	  <%=empno%>
<%
}
else
{
%>
      <a href="crewquery.jsp?tf_ename=&tf_sess1=&tf_sess2=&tf_empno=<%=empno%>" target="_self"><%=empno%></a>
<%
}
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
    <span class="txtblue">On Line User : <%=pCount%><br>By click column of empno, you can view user's information <br>
�]�I����u���A�i�d�߸ӨϥΪ̤��ӤH���)</span> 
</center>
</body>

</html>
<%
}catch (Exception e)
{
	out.println(e.toString());
}
%>