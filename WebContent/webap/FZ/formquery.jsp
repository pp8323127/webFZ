<%@page contentType="text/html; charset=big5" language="java" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
String username = (String) session.getAttribute("cname") ; 
//20130326�W�[**
String occu = (String) session.getAttribute("occu");
String powerUser =(String)session.getAttribute("powerUser");
//**************
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
  %> <jsp:forward page="sendredirect.jsp" /> <%
} 
else if(!("ED".equals(occu) | "Y".equals(powerUser)))
{//���դ�ñ���i�ݦ���20130326�W�[
%>
	<p  class="errStyle1">1.�z�L�v�ϥΦ��\��I<br> 2.���m�L�[�Э��s�n�J�I</p>
<%
}
else
{
%>
<html>
<head>
<title>�ӽг�B�z�d��</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" type="text/css" href="../style/errStyle.css">
<link rel="stylesheet" type="text/css" href="../style/style1.css">
<link rel="stylesheet" type="text/css" href="../style/lightColor.css">
<link rel="stylesheet" type="text/css" href="../style/kbd.css">
<script language="JavaScript" type="text/JavaScript" src="js/showDate.js"></script>
</head>

<body  onLoad="showYMD('form1','fyy','fmm','fdd')"> 
<form name="form1" method="post" action="handleform.jsp" target="mainFrame">
<span class="blue" style="margin-left:0.5em; ">[���Z��B�z]</span>
  <select name="fyy" >
<script language="javascript" type="text/javascript" src="/webfz/FZ/js/date.js"></script>
	<script language="javascript" type="text/javascript">
		var nowYear=new Date().getFullYear();
		
		for(var i=nowYear;i<=nowYear+1;i++){
			var defaultSelect = "";
			if(i==nowYear){
				defaultSelect=" selected";
			}
			document.write("<option value='"+i+"'"+defaultSelect+">"+i+"</option>");
		}
	</script>
  </select>
    
  <select name="fmm" >
    <option value="01">01</option>
    <option value="02">02</option>
    <option value="03">03</option>
    <option value="04">04</option>
    <option value="05">05</option>
    <option value="06">06</option>
    <option value="07">07</option>
    <option value="08">08</option>
    <option value="09">09</option>
    <option value="10">10</option>
    <option value="11">11</option>
    <option value="12">12</option>
  </select>
  <select name="fdd" >
    <option value="N" class="blue">����</option>
    <option value="01">01</option>
    <option value="02">02</option>
    <option value="03">03</option>
    <option value="04">04</option>
    <option value="05">05</option>
    <option value="06">06</option>
    <option value="07">07</option>
    <option value="08">08</option>
    <option value="09">09</option>
    <option value="10">10</option>
    <option value="11">11</option>
    <option value="12">12</option>
    <option value="13">13</option>
    <option value="14">14</option>
    <option value="15">15</option>
    <option value="16">16</option>
    <option value="17">17</option>
    <option value="18">18</option>
    <option value="19">19</option>
    <option value="20">20</option>
    <option value="21">21</option>
    <option value="22">22</option>
    <option value="23">23</option>
    <option value="24">24</option>
    <option value="25">25</option>
    <option value="26">26</option>
    <option value="27">27</option>
    <option value="28">28</option>
    <option value="29">29</option>
    <option value="30">30</option>
    <option value="31">31</option>
  </select>
 <label for="sno" style="margin-left:0.5em; ">���Z�渹</label>
    <input type="text" name="sno" maxlength="4" size="5">
  ~<input type="text" name="eno" size="5" maxlength="4">
  <label for="empno" style="margin-left:0.5em; ">���u��</label>
  <input type="text" name="empno" maxlength="6" size="6">
  
  <input type="submit" name="Submit" value="�d��" class="kbd" style="margin-left:0.5em; ">
   �H�ӽФ��/�渹(<span class="red">��|�X</span>)/�խ����u���d��
</form>
</body>
</html>
<%
}	  
%>