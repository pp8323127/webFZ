<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="fz.*,java.sql.*,java.util.Date,java.text.DateFormat,java.net.URLEncoder,ci.db.*"%>
<%
//�d�ߨ�L�խ����
/*
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
 %>
 <jsp:forward page="sendredirect.jsp" /> 
<%
} 
*/
String empno	= request.getParameter("tf_empno");	//���u��
String sess1	= request.getParameter("tf_sess1");	//�_�l���O
String sess2	= request.getParameter("tf_sess2");	//�������O
String tf_ename 	= request.getParameter("tf_ename");	//�m�W

String cname	= 	null;
String occu		= 	null;
String base		=	null;
String box		=   null;
String sess		=	null;
String ename	=	null;
String fleet	=	null;
String mphone	=	null;
String hphone	=	null;
//String address	=	null;
String icq		=	null;
String email	=	null;
String rs_emp	= 	null;

int count = 0;
String bcolor	=null;

//get schedule locked status
chkUser chk = new chkUser();
String chkemp = chk.checkLock(empno);

	if("Y".equals(chkemp) ){	//��w���A��Y
	%>
		<jsp:forward page="../showmessage.jsp">
		<jsp:param name="messagestring" value="The Crew didn't open his schedule<BR>�Ӳխ����}��Z��ѥL�H�d�� " />
		</jsp:forward>

	<%
	}


//get Date
java.util.Date nowDate = new Date();
int syear	=	nowDate.getYear() + 1900;
int smonth	= 	nowDate.getMonth() + 1;
int sdate	= nowDate.getDate();
if (sdate >=25){	//�W�L25���A��U�Ӥ몺�Z��
	
	if (smonth == 12){	//�W�L12��25���A����~1�몺�Z��
		smonth = 1;
		syear = syear+1;
	}
	else{
		smonth = smonth+1;
	}
}



String sql = "SELECT EMPNO,BOX,SESS,NAME,ENAME,CABIN,OCCU,NVL(FLEET,'&nbsp;') FLEET,BASE,EMAIL,NVL(MPHONE,'&nbsp;') MPHONE,NVL(HPHONE,'&nbsp;') HPHONE,NVL(ICQ,'&nbsp;') ICQ FROM FZTCREW ";

//out.print(tf_ename);
if(!"".equals(tf_ename)){//�Ωm�W�d��
	sql = sql + " WHERE NAME LIKE '%" + tf_ename + "%'  AND LOCKED='N'";
}
else{
	if ( "".equals(empno)){	//�H���O�d��
	
		if(sess2.equals("")){	//�H��@���O�d��
			sql = sql + " WHERE SESS = '" + sess1 + "'  AND LOCKED='N'";
			//out.println(sql);	
		}
		else
		{	//�H�����Ӵ��O���d��
			sql = sql + " WHERE to_number(SESS) >= " + sess1 + " AND to_number(SESS) <= " + sess2 +"  AND LOCKED='N'";
			//out.println(sql);
		}
	
	}
	else{	//�H���u���d��
		if(empno.length()<6){
			sql = sql +" WHERE TRIM(BOX) = '"+ empno + "'  AND LOCKED='N'";
		}
		else{
		sql = sql + " WHERE EMPNO = '" + empno + "' AND LOCKED='N' ";
		//out.println(sql);
		}
	}
}
sql = sql + " order by empno";

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

//dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
//conn = dbDriver.connect("jdbc:weblogic:pool:CAL.FZCP02", null);
stmt = conn.createStatement();

myResultSet = stmt.executeQuery(sql); 

%>

<html>
<head>
<title>CrewQuery</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="../menu.css" rel="stylesheet" type="text/css">

<style type=text/css>
<!--
BODY{margin:0px;/*���e�K��������*/}
-->
</style>


</head>

<body>
<div align="center" class="txttitletop">Crew Query</div>
<table width="90%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr> 
      <td width="5%">&nbsp;</td>
      <td width="90%"> 
       
      </td>
      <td width="5%">
        <div align="right"><a href="javascript:window.print()"> <img src="../images/print.gif" width="17" height="15" border="0" alt="�C�L"></a> 
        </div>
      </td>
    </tr>
</table>
    <table align="center" cellpadding="1"  cellspacing="1" border="1"  width="92%">
      <tr >
	    <td width="54" class="tablehead3">EmpNO</td>
        <td width="58" class="tablehead3">Name</td>
        <td width="72" class="tablehead3">EName</td>
        <td width="27" class="tablehead3">Sern</td>
        <td width="35" class="tablehead3">Sess</td>
        <td width="46" class="tablehead3">Occu</td>
        <td width="35" class="tablehead3">Fleet</td>
        <td width="47" class="tablehead3">Base</td>
        <td width="39" class="tablehead3">EMAIL</td>
        <td width="51" class="tablehead3">Mobile</td>
        <td width="52" class="tablehead3">Home</td>
        <td width="42" class="tablehead3">ICQ</td>
      </tr>
      <%
  int xCount=0;
  if(myResultSet != null){

	while (myResultSet.next()){
		xCount++;
		rs_emp	= 	myResultSet	.getString("EMPNO");
		box		=	myResultSet	.getString("BOX");
		sess	=	myResultSet	.getString("SESS");
		ename	=	myResultSet	.getString("ENAME");
		fleet	=	myResultSet	.getString("FLEET");
		mphone	=	myResultSet	.getString("MPHONE");
		hphone	=	myResultSet	.getString("HPHONE");
		//address	=	myResultSet	.getString("ADDRESS");
		icq		=	myResultSet	.getString("ICQ");	
		cname	= 	myResultSet.getString("NAME");
		occu	=	myResultSet.getString("OCCU");	
		base	=	myResultSet.getString("BASE");
		email	= 	myResultSet.getString("EMAIL");


		count++;
			if (xCount%2 == 0)
			{
				bcolor = "#C9C9C9";
			}
			else
			{
				bcolor = "#FFFFFF";
			}
		
%>
      <tr bgcolor="<%= bcolor%>">
	    <td height="26" class="tablebody"><%=rs_emp %></td>
        <td class="tablebody"><p style="white-space:nowrap "><%= cname%></p></td>
        <td class="tablebody"><p align="left" style="white-space:nowrap ">&nbsp;<%= ename%></p></td>
        <td class="tablebody"><%=box %></td>
        <td class="tablebody"><%=sess %></td>
        <td class="tablebody"><%=occu%></td>
        <td class="tablebody"><%=fleet %></td>
        <td class="tablebody"><%=base %></td>
        <td class="tablebody"><a href="../mail.jsp?to=<%=email%>&cname=<%=URLEncoder.encode(cname)%> <%=ename%>" target="_blank"><img alt="mail to <%=cname%>" border="0" height="15" src="../images/mail.gif" width="15"></a></td>
        <td class="tablebody"><%=mphone %></td>
        <td class="tablebody"><%=hphone %></td>
        <td class="tablebody"><%=icq %></td>
      </tr>
      <%		
	
	}
}

%>
    </table>
    <br>
    <div align="center">
</div>
  <%
	if (xCount==0)
	{
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
%>
	<jsp:forward page="../showmessage.jsp">
	<jsp:param name="messagestring" value="No record found !<BR>�L��ơA�i��]��<P>1.�̱���d�L���<BR>2.�L�H�}��A�ɵL������" />
	</jsp:forward>
<%
} 
  
%>
  

</body>
</html>
<%
}
catch (Exception e)
{
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