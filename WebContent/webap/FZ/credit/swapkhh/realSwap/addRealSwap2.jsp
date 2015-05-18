<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*" %>
<%
String year = request.getParameter("year");
String month = request.getParameter("month");
String aEmpno = request.getParameter("aempno");
String rEmpno = request.getParameter("rempno");

//���o���Z����
swap3ackhh.ApplyCheck ac = new swap3ackhh.ApplyCheck(aEmpno,rEmpno,year,month);


Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
ResultSet rs = null;
boolean status = false;
String errMSg = "";
ArrayList citemAL = new ArrayList();

ci.db.ConnDB cn = new ci.db.ConnDB();
try{
	cn.setORP3FZUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
	
	stmt = conn.createStatement();

	rs = stmt.executeQuery("SELECT citem FROM fztrcomf where station='KHH' ORDER BY citem"); 

	while(rs.next()){
			citemAL.add(rs.getString("citem"));		
	}
rs.close();
status = true;

}catch (SQLException e){	 
	 errMSg = e.toString();
}finally{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
//���o�m�W
aircrew.CrewCName cc = new aircrew.CrewCName();


%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>�s�W���鴫�Z�O��</title>
<link rel="stylesheet" type="text/css" href="realSwap.css" >
<link rel="stylesheet" type="text/css" href="../kbd.css" >
<link rel="stylesheet" type="text/css" href="../loadingStatus.css">

<script language="javascript" type="text/javascript" src="../js/showAndHiddenButton.js"></script>

<script language="javascript" type="text/javascript" src="../js/showDate.js"></script>
<script language="javascript" type="text/javascript" >
function checkForm(){
	var a = document.form1.aempno.value;
	var r = document.form1.rempno.value;
	
	if(a == ""){
		alert("�п�J���Z�̭��u��!!");
		document.form1.aempno.focus();
		return false;
	}else if(r == ""){
		alert("�п�J�Q���̭��u��!!");
		document.form1.rempno.focus();
		return false;
	
	}else{
		if(confirm("�T�{�s�W?!")){
			disabledButton("b1");
			disabledButton("s1");
			
			document.getElementById("showStatus").className="showStatus";
			return true;
		}else{
			return false;
		}
		
	}
}

</script>

</head>

<body >
<div id="showStatus" class="hiddenStatus">��Ƹ��J��...�еy��</div>

<div align="center">
<form name="form1" action="insRealSwap.jsp" method="post" onsubmit="return checkForm()">
<p>&nbsp;</p>
<table width="61%"  border="0" cellpadding="0" cellspacing="1" class="tableBorder1">
<tr><td>
<table width="100%"  border="0" cellpadding="1" cellspacing="1">
  <tr class="tableInner2">
    <td height="25" colspan="2">�s�WKHH���鴫�Z�O�� <span style="color:#0000FF">[Step2.��J���Z���ƭp��βz��.]</span></td>
  </tr>
  <tr >
    <td width="16%" height="33" class="tableh5">���Z�~/��</td>
    <td width="84%"  >
      <div align="left">
	  <input type="text" value="<%=year%>" name="year" size="4" readonly>
  /	  <input type="text" value="<%=month%>" name="month" size="2" readonly>
      </div>
    </td>
    </tr>
</table>
<table width="100%"  border="0" cellspacing="1" cellpadding="0" >

  <tr class="tableInner2">
    <td width="16%" rowspan="2">�ӽЪ�      </td>
    <td width="19%" height="25">���u��/�m�W</td>
    <td width="14%">�w������</td>
    <td width="22%">���Z���ƭp��</td>
    <td width="29%">���Z�z��</td>
  </tr>
  <tr>
    <td height="29">
      <input type="text" size="6" maxlength="6" name="aempno" value="<%=aEmpno%>" readonly style="border:0pt; ">
	  <%=cc.getCname(aEmpno)%>
    </td>
    <td><span class="r"><%=ac.getAApplyTimes()%></span>	</td>
    <td>
      <select name="aCount">
        <option value="Y" selected="Y">YES</option>
        <option value="N">NO</option>
      </select>
</td>
    <td>
      <select name="aComm">
        <option value="�L">�L</option>
        <%	for(int i=0;i<citemAL.size();i++){
			out.print("<option value=\""+citemAL.get(i)+"\">"+citemAL.get(i)+"</option>");		}		
		%>
      </select>
    </td>
  </tr>
</table>
<table width="100%"  border="0" cellpadding="0" cellspacing="1" >
  <tr class="tableInner3">
    <td width="16%" rowspan="2">�Q����    </td>
    <td width="19%" height="27">���u��/�m�W</td>
    <td width="14%">�w������</td>
    <td width="22%">���Z���ƭp��</td>
    <td width="29%">���Z�z��</td>
  </tr>
  <tr>
    <td height="29">
      <input type="text" size="6" maxlength="6" name="rempno" value="<%=rEmpno%>"  readonly style="border:0pt; ">
	   <%=cc.getCname(rEmpno)%>
    </td>
    <td><span class="r"><%=ac.getRApplyTimes()%></span>   </td>
    <td>
      <select name="rCount">
        <option value="Y" selected="Y">YES</option>
        <option value="N">NO</option>
      </select>
	</td>
    <td>
      <select name="rComm">
        <option value="�L">�L</option>
        <%	for(int i=0;i<citemAL.size();i++){
			out.print("<option value=\""+citemAL.get(i)+"\">"+citemAL.get(i)+"</option>");		}		
		%>
      </select>
    </td>
  </tr>
  <tr>
    <td colspan="5">
      <input  type="button" id="b1" class="kbd" value="BACK" onClick="javascipt:history.back(-1);">&nbsp;&nbsp;
      <input name="Submit" id="s1" type="submit" class="kbd" value="Update">
    </td>
    </tr>
  <tr>
    <td colspan="5">
      <div  class="r">*�w�����ƭp��,�]�t�q�l���Z��w�֭�A�ι��鴫�Z�ݭp�⦸�Ƥ��`�M�C</div>
    </td>
  </tr>
</table>

</td></tr>
</table>
</form>
</div>
</body>
</html>
