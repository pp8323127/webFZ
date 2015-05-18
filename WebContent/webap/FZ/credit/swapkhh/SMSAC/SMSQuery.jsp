<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%

String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
/*response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);*/

if (session.isNew() || sGetUsr == null) 
{		//check user session start first
  %> <jsp:forward page="sendredirect.jsp" /> <%
} 

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>query SMS</title>
<script src="../js/showDate.js" language="javascript"></script>
<script src="../js/checkDate.js" language="javascript"></script>

<script language="javascript" type="text/javascript">
	function checkFlt(){
		var flt = document.form1.fltno.value;
		if(flt == ""){			
			document.form1.action="ShowFlt.jsp";
			document.form1.Submit.disabled=1;
			document.form2.Submit.disabled=1;
			document.form3.Submit.disabled=1;
			return true;
		}
		else{
			document.form1.showMakeFile.value="Y";
			document.form1.action="Show1Flt.jsp";						
			document.form1.Submit.disabled=1;
			document.form2.Submit.disabled=1;
			document.form3.Submit.disabled=1;
			
			return true;
		}
	}

function checkDuty(){
	var classType = document.form3.classType.value;
	if(classType == ""){		
		alert("�п�J�ҵ{�N�X!!");
		document.form3.classType.focus();
		return false;
	}
	else{
		document.form1.Submit.disabled=1;
		document.form2.Submit.disabled=1;
		document.form3.Submit.disabled=1;
	
		return true;
	}
}
</script>
<style type="text/css">
body,table,input{
	font-family: Verdana;
	font-size: 10pt;
	color:#333399;
}
select {
	font-family: Verdana;
	font-size: 10pt;
	color:#000000;
}



.b1 {
	background-color: #edf3fe;
	color: #000000;
	text-align: center;
}
</style>
</head>

<body onLoad="showYMD('form1','yy','mm','dd');showYMDHM('form2','yy','mm','dd','hh','mi');document.form1.fltno.focus();showYMD('form3','yy','mm','dd')"><br>


<TABLE width="834" BORDER="0" align="center" CELLPADDING="0" CELLSPACING="0">
<TR >
	<TD width="40" ><img src="img/1.gif"></TD>
	<TD width="754" BACKGROUND="img/2.gif">
	  <div align="center"><br>
        <span  style="color:#FF0000 "><span  style="color:#FF0000 ">KHH </span> Cabin eSMS ���²�T�q���t��</span></div>
	</TD>
	<TD width="40" ><img src="img/3.gif"></TD>
</TR>
<TR>
	<TD BACKGROUND="img/4.gif"></TD>
	<TD bgcolor="#edeff1" ><br>

	<form name="form1" method="post" action="ShowFlt.jsp" target="_self" onSubmit="return checkFlt()">
    <span >�E�o�S�w��Z�G</span>  
    <select name="yy">
<jsp:include page="../../../temple/year.htm" />
  </select>
    <span >�~</span>  
  <select name="mm" >
	<jsp:include page="../../../temple/month.htm" />
 </select>
  <span >��</span>&nbsp;&nbsp;
  <select name="dd" >
	<jsp:include page="../../../temple/day.htm" />
  </select>
  <span >��</span>  <span >
  <input type="hidden" name="showMakeFile">
  Fltno</span>
  <input name="fltno" type="text" id="fltno" size="4" maxlength="4">
  <input name="Submit" type="submit" value="Query" class="b1">
</form>
<form name="form2" method="post" action="ShowFlt.jsp" target="_self" onSubmit="return checkDate('form2','yy','mm','dd')">
  <span ><span >�E</span>�̮ɶ��o�e�G</span>
  <select name="yy">
    <jsp:include page="../../../temple/year.htm" />
  </select>
  <span >�~</span>
  <select name="mm" >
    <jsp:include page="../../../temple/month.htm" />
  </select>
  <span >��</span>&nbsp;&nbsp;
  <select name="dd" >
    <jsp:include page="../../../temple/day.htm" />
  </select>
  <span >��</span>
  <select name="hh">
    <%
  for(int i=0;i<24;i++){
  	if(i < 10){
		out.print("<option value=\"0"+i+"\">0"+i+"</option>");
	}else{
		out.print("<option value=\""+i+"\">"+i+"</option>");
	}
  }
  %>
  </select>
  <span >��</span>
  <select name="mi">
    <%
  for(int i=0;i<60;i++){
  	if(i < 10){
		out.print("<option value=\"0"+i+"\">0"+i+"</option>");
	}else{
		out.print("<option value=\""+i+"\">"+i+"</option>");
	}
  }
  %>
  </select>
  <span >���_&nbsp;&nbsp; �b</span>
  <select name="inHour">
    <option value="1">1</option>
    <option value="2">2</option>
    <option value="3">3</option>
    <option value="6">6</option>
    <option value="12">12</option>
    <option value="24">24</option>
    <option value="48">48</option>
  </select>
  <span >�X�p�ɤ��_��</span>
  <input name="Submit" type="submit" class="b1" value="Query">
</form>
<form name="form3" method="post" action="Show1Flt.jsp" target="_self" onSubmit="return checkDuty()">
  <span ><span >�E</span>�ݩR�ΤW�Ҳխ��G</span>
  <select name="yy">
    <jsp:include page="../../../temple/year.htm" />
  </select>
  <span >�~</span>
  <select name="mm" >
    <jsp:include page="../../../temple/month.htm" />
  </select>
  <span >��</span>&nbsp;&nbsp;
  <select name="dd" >
    <jsp:include page="../../../temple/day.htm" />
  </select>
  <span >��</span> <span > �ҵ{�N�X
  <input name="classType" type="text"  size="4" onkeyup="javascript:this.value=this.value.toUpperCase();">
  </span>
  <input name="Submit" type="submit" class="b1" value="Query" >
  <input type="hidden" name="showMakeFile" value="Y">
  <br>
	</form>

</TD>
	<TD BACKGROUND="img/5.gif"></TD>
</TR>
<TR>
  <TD BACKGROUND="img/4.gif"></TD>
  <TD bgcolor="#edeff1" >
    <ol>
      <li >�o�e²�T���Y�������Z���῵�խ��A�ϥΡu�o�S�w��Z�v�C</li>
      <li >�o�e²�T���S�w��Z�A�θӯ�Z���խ��W�榳�ܰʡA�ϥΡu�o�S�w��Z�v�ο�JFltno�C</li>
      <li >�o�e²�T���Y��X�p�ɤ��_������Z�A�ϥΡu�̮ɶ��o�e�v�C</li>
      <li >�o�e²�T�P�W�ҩΫݩR�խ��A�ШϥΡu�ݩR�ΤW�Ҳխ��v�C</li>
      <li >���ͤ�����X�ɫ�A�Ц�<a href="http://eip.china-airlines.com/" target="_blank"><font color="#FF0000" style="text-decoration:underline;font-size:10pt ">�د�²�T�A�Ⱥ�eSMS</font></a>�W�Ǹ��X�ɥH�o�e²�T�C</li>
    </ol>
  </TD>
  <TD BACKGROUND="img/5.gif"></TD>
</TR>
<TR>
	<TD ><img src="img/6.gif"></TD>
	<TD BACKGROUND="img/7.gif"></TD>
	<TD ><img src="img/8.gif"></TD>
</TR>
</TABLE>

</body>
</html>
