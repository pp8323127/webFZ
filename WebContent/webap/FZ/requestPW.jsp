<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>忘記密碼</title>
<link href="menu.css" rel="stylesheet" type="text/css">
<script language="javascript">
function chk(){
	var empno = document.form1.empno.value;
	
	if("" == empno  ){
		alt();
		return false;
	}else if(isNaN(empno)){
		//不是數字
		alt();
		return false;		
	}else if(empno.length < 6){
		//不滿6位
		alt();
		return false;
	}else{ 		
		return true;
	}
	

}

function alt(){
	alert("Employee number is required!!\n請輸入員工號");
	document.form1.empno.focus();
}

/*

function checkEmpno(){
	if(document.form1.empno.value ==""){
		alert("Employee number is required!!\n請輸入員工號");
		document.form1.empno.focus();		
		return false;
	}else{
		return true;
	}
}
*/
</script>
<style type="text/css">
.table1{background-color:#EBF3FA;color:black;font-size:9pt;line-height:170%;text-decoration:none;text-transform:none;padding-left:2px;padding-right:2px;padding-top:2px;padding-bottom:2px;} 
.table2{background-color:#FFFFFF;color:black;font-size:9pt;line-height:170%;text-decoration:none;text-transform:none;padding-left:2px;padding-right:2px;padding-top:2px;padding-bottom:2px;} 
.table3{		border: 1px solid #996431;}

</style>
</head>

<body onLoad="document.form1.empno.focus()">
<form action="sendPW.jsp" method="post" name="form1" onsubmit="return chk()">
  <TABLE width=362 border=0 cellPadding=7 cellSpacing=0 bordercolor="#000066" class="table3">
    <TBODY>
      <TR>
        <TD width="344" class="table1">
          <DIV align=center><span class="txtblue">忘記密碼(Forget Password) </span></DIV>
        </TD>
      </TR>
      <TR>
        <TD class="table2" height=90>
          <DIV align=center><span class="txtblue">員工號(Employee Number)：</span>
              <input type="text" name="empno"  id="empno" size="6" maxlength="6">
          </DIV>
        </TD>
      </TR>
      <TR>
        <TD class="table1" height=35>
          <div align="center">
            <input type="submit" name="Submit" value="Send" >
          </div>
        </TD>
      </TR>
    </TBODY>
  </TABLE>
  <p><span class="txtgray2">密碼將寄至</span><a href="http://mail.cal.aero" target="_blank">全員信箱</a>。</p>
  <p class="txttitle">The password will send to your webmail(<a href="http://mail.cal.aero" target="_blank">http://mail.cal.aero</a>).</p>
</form>
<p>&nbsp;</p>
</body>
</html>
