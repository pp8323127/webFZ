<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="fz.*,ci.db.*,java.sql.*"%>
<%
//ED�s��̷s����
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
 %>
 <jsp:forward page="sendredirect.jsp" /> 
<%
} 

String userid =(String) session.getAttribute("userid") ; 
String occu = (String) session.getAttribute("occu");
if(occu == null) occu = "N";
String flag = "";
Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
ResultSet myResultSet = null;
boolean t = false;
String ms =null;
try{
//dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
//conn = dbDriver.connect("jdbc:weblogic:pool:CAL.FZCP02", null);
ConnDB cn = new ConnDB();
cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement();
String comm = null;
String sql = "";

if(occu.equals("ED") | "626914".equals(sGetUsr) | "640790".equals(sGetUsr)){ //�ŪAñ��,�����
	sql = "select replace(ms,'<BR>','\r\n') ms from fzthotn where flag='2' and station='TPE'";
	flag = "2";
}
else{ //���ñ��
	sql = "select replace(ms,'<BR>','\r\n') ms from fzthotn where flag='1'";
	flag = "1";
}
myResultSet = stmt.executeQuery(sql); 
	if(myResultSet != null){
		while(myResultSet.next()){
			ms= myResultSet.getString("ms");
		}
	}
%>

<html>
<head>
<title>�ۭq�̷s����</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="menu.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
function replaceChar()
{
	var message = document.form1.ms.value;
	var len = document.form1.ms.value.length;
	document.form1.flag.value = "<%=flag%>";
				
	if(len >1800)
	{
		alert("�r�ƶW�L"+(len-1800)+"�Ӧr���A�Э��s��J");
		document.form1.ms.focus();
		return false;
	}
	else
	{
		return true;
	}
}

function del()
{	//�T�{�O�_�R������ܵ���
	if(	confirm("Do you really want to Delete??\n�T�w�n�R��������ơH?")){
			//document.form1.action = "delfri.jsp";
			//document.form1.submit();
			location.href="updHotNews.jsp?ms=\r\n";
			return true;
		}
	else{
			//location.reload();
			//document.form1.reset();
			return false;
		}

}
</script>

</head>

<body>
<br>
<form name="form1"  method="post" action="updHotNews.jsp"  onSubmit="return replaceChar();" >
  <table width="42%"  border="1" align="center" cellpadding="0" cellspacing="1" class="fortable">
    <tr>
      <td colspan="2" class="tablehead3">
        <div align="center">�s��HotNews!!</div>
      </td>
    </tr>

        <div align="center">

 <tr>
   <td class="tablebody">     <div align="left">
         <textarea name="ms" cols="50" rows="16" ><%=ms%></textarea>
</div></td>
   </tr>	  
        </div>
   
    <tr>
      <td colspan="2"  class="tablebody"><div align="center">        &nbsp;&nbsp;
        <input name="Submit" type="submit"  value="���" > &nbsp;&nbsp; &nbsp;&nbsp;
		<input name="reset" type="reset"  value="Reset" > &nbsp;&nbsp; &nbsp;&nbsp;
        <input name="delms" type="button" value="�R��" onClick="return del()"> 
        <input name="flag" type="hidden" id="flag" value="2">
      </div></td>
    </tr>
  </table>
  <table width="42%"  border="0" align="center" cellpadding="0" cellspacing="1" >
    <tr>
      <td width="7%" align="left" class="txtxred">
        <div align="center"></div>
      </td>
      <td width="93%" align="left" class="txtxred">*�r�ƭ���G2000�ӭ^��r��1000�Ӥ���r.<br>
*�Y�n����Шϥ�Enter��.<br>
*�t�η|�۰���̫ܳ��s�ɶ�
.      </td>
    </tr>
  </table>
  <p>&nbsp;</p>
</form>


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
      <jsp:forward page="err.jsp" /> 
<%
}
%>
