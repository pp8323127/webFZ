<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="fz.*,java.sql.*"%>
<%
//KHH �s��̷s����
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{

} 

String userid =(String) session.getAttribute("userid") ; 




String flag = "";
Connection conn = null;
Driver dbDriver = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
ci.db.ConnDB cn = new ci.db.ConnDB();
boolean status = false;
String errMsg = "";

String comm = "";


try{
cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);

pstmt = conn.prepareStatement("SELECT * FROM fzthotn WHERE flag=2 AND station='KHH'");

rs = pstmt.executeQuery(); 
	
while(rs.next()){
	comm= rs.getString("ms");
}
comm = comm.replaceAll("<BR>", "\r\n");
	status = true;
	
}catch (Exception e){
	errMsg = e.toString();
}finally{

	if (rs != null) try {rs.close();} catch (SQLException e) {}	
	if (pstmt != null) try {pstmt.close();} catch (SQLException e) {}
	if (conn != null) try { conn.close(); } catch (SQLException e) {}
}	

%>

<html>
<head>
<title>�ۭq�̷s����</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" type="text/css" href="../realSwap/realSwap.css">
<script language="JavaScript" type="text/JavaScript">
function replaceChar(){

	var message = document.form1.ms.value;
	var len = message.length;
	
		//alert(len);
	if(len >800){
		alert("�r�ƶW�L"+(len-800)+"�Ӧr���A�Э��s��J");
		document.form1.ms.focus();
		return false;
	}
	else{
		document.form1.Submit.disabled=1;
		document.form1.reset.disabled=1;
		document.form1.delms.disabled=1;
		
		return true;
	}
}

function del(){	//�T�{�O�_�R������ܵ���
	if(	confirm("Do you really want to Delete??\n�T�w�n�R��������ơH?")){
			document.form1.ms.value='�L';
			document.form1.submit();			
			document.form1.Submit.disabled=1;
			document.form1.reset.disabled=1;
			document.form1.delms.disabled=1;
			return true;
		}
	else{
			
			return false;
		}

}
</script>

</head>

<body>
<br>
<form action="updHotNews.jsp"  method="post" name="form1" onSubmit="return replaceChar()" >
  <table width="40%"  border="0" align="center" cellpadding="0" cellspacing="1" class="tableBorder1" >
    <tr>
      <td colspan="2" class="tableInner3" >
        <div align="center">�s��KHH�̷s����</div>
      </td>
    </tr>

        <div align="center">

 <tr>
   <td >     <div align="left">
         <textarea name="ms" cols="50" rows="8" ><%=comm%></textarea>
</div></td>
   </tr>	  
        </div>
   
    <tr>
      <td colspan="2"  ><div align="center">       
          <p>
  <input name="Submit" type="submit"  value="���" >
&nbsp;&nbsp; &nbsp;&nbsp;
		  <input name="reset" type="reset"  value="Reset" >
&nbsp;&nbsp; &nbsp;&nbsp;
          <input name="delms" type="button" value="�R��" onClick="return del()"> 
        </p>
          <p align="left" class="r">*�r�ƭ���G1000�ӭ^��r��500�Ӥ���r.<br>
    *�Y�n����Шϥ�Enter��.<br>
    *�t�η|�۰���̫ܳ��s�ɶ� . </p>
      </div></td>
    </tr>
  </table>
 
  <p>&nbsp;</p>
</form>


</body>
</html>
