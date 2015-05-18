<%@page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*,java.util.*"%>
<%

String userid = (String) session.getAttribute("cs55.usr") ; //get user id if already login

if (session.isNew() | userid == null ) 
{		//check user session start first
  %> <jsp:forward page="sendredirect.jsp" /> <%
} 

String empno = request.getParameter("empno");
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
String sql = null;
Driver dbDriver = null;
ArrayList fleetAL = new ArrayList();
String fleet_cd = null;
String cname = null;
String ename = null;
int rowCount =0;

ConnDB cn = new ConnDB() ;

try{
//取得crew之fleet_cd,用orp3
//dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
//conn = dbDriver.connect("jdbc:weblogic:pool:CAL.DFCP01", null);
//DataSource
cn.setDZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn  = dbDriver.connect(cn.getConnURL(), null);

stmt = conn.createStatement();
sql = "SELECT DISTINCT fleet FROM dfdb.dftcrew "
	+"where fleet IS NOT NULL and fleet NOT IN ('---',' ') "
	+"ORDER BY fleet";

rs = stmt.executeQuery(sql);
while(rs.next()){
	fleetAL.add(rs.getString("fleet"));
}	

sql = "select  * from dftcrew where empno='"+empno+"' and flag='Y'";

rs = stmt.executeQuery(sql);
	while(rs.next()){
		fleet_cd = rs.getString("fleet");
		cname = rs.getString("name");
		ename = rs.getString("ename");
		rowCount++;
	}

}catch (SQLException e){
	  out.print(e.toString());
}catch (Exception e){
	  out.print(e.toString());
}finally{
	if (rs != null)
		try {rs.close();} catch (SQLException e) {}
	if (stmt != null)
		try {stmt.close();} catch (SQLException e) {}
	if (conn != null)
		try {conn.close();}catch (SQLException e) {}
}

%>
<html>
<head>
<title>Crew Record Insert</title>
<link href="../menu.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<script language="JavaScript" type="text/JavaScript">
function setZero(){

	for(var i=0;i<document.form1.length-2;i++){
		if(i>3){
			if(document.form1.elements[i].value == ""){
				document.form1.elements[i].value="0";
				alert(i);
			}
		}else if(document.form1.elements[i].value == ""){
			if(i == 0){
				alert("請輸入RecType!!");
			}else if(i == 1){
				alert("請輸入Year!!");
			}
			document.form1.elements[i].focus();
			return false;
		}
			
		
	}
	
	return true;

}
</script>


</head>
<%
if(rowCount == 0){
%>

<body onLoad="document.form1.rectype.focus();document.form1.fleet_cd.value='<%=fleet_cd%>'">
<div class="txtxred" style="text-align:center ">此員工號無效，請重新輸入正確的員工號.<br>

<a href="CrewRdInsMenu.jsp" target="_self"><u>Back</u></a></div>
<%
}else{
%>

<center>
  <span class="txttitletop">Y8 Crew Record </span><br>

<form method="post" name="form1" action="updCrewRdIns.jsp" onsubmit="return setZero()"> 
  <table width="567" border="1" class="fortable">
    <tr>
      <td width="66" class="tablehead3">
        <div align="left"><b>Staff_num</b></div>
      </td>
      <td width="71" class="tablebody">
        <div align="center"> <%=empno%> </div>
      </td>

      <td width="65" class="tablehead3">
        <div align="left"><b>Name</b></div>
      </td>
      <td width="83" class="tablebody">
        <div align="center"> <%=cname%> </div>
      </td>
    
      <td width="71" class="tablehead3">
        <div align="left"><b>EName</b></div>
      </td>
      <td colspan="3" class="tablebody">
        <div align="center"> <%=ename%> </div>
      </td>
      </tr>
    <tr>
      <td width="66" class="tablehead3">
        <div align="left"><b>RecType</b></div>
      </td>
      <td width="71" class="tablebody">
        <div align="center">
          <input type="text" size="10" maxlength="1" name="rectype" onkeyup="javascript:this.value=this.value.toUpperCase();"> 
        </div>
      </td>

      <td width="65" class="tablehead3">
        <div align="left"><b>Year(yyyy)</b></div>
      </td>
      <td width="83" class="tablebody">
        <div align="center">
          <input type="text" size="4" maxlength="4" name="yyyy">
        </div>
      </td>

      <td width="71" class="tablehead3">
        <div align="left"><b>Month(mm)</b></div>
      </td>
      <td width="42" class="tablebody">
        <div align="center">
          <select name="mm">
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
          <!-- <input type="text" size="10" maxlength="2" name="mm"> -->
        </div>
      </td>

      <td width="54" class="tablehead3">
        <div align="left"><b>Fleet_cd</b></div>
      </td>
      <td width="63" class="tablebody">
        <div align="center">
          <!--   <input type="text" size="10" maxlength="3" name="fleet_cd"> -->
          <select name="fleet_cd">
            <option value="BEF">BEF</option>
            <% 	for(int i=0;i<fleetAL.size();i++){	  %>
            <option value="<%=(String)fleetAL.get(i)%>"><%=(String)fleetAL.get(i)%></option>
            <% 		}	  %>
          </select>
        </div>
      </td>
    </tr>
  </table>
  <span class="txtxred"><br>
  以下欄位，請輸入[分鐘數]</span>
  <table width="567" border="1" class="fortable">
    <tr>
      <td width="84" class="tablehead3">
        <div align="left"><b>CA</b></div>
      </td>
      <td class="tablebody">
        <div align="center">
          <input name="ca" type="text" size="10" maxlength="10"  value="0" onFocus="this.select()">
        </div>
      </td>
      <td width="76" class="tablehead3">
        <div align="left"><b>FO</b></div>
      </td>
      <td class="tablebody">
        <div align="center">
          <input name="fo" type="text" size="10" maxlength="10"  value="0" onFocus="this.select()">
        </div>
      </td>
    </tr>
    <tr>
      <td class="tablehead3">
        <div align="left"><b>FE</b></div>
      </td>
      <td class="tablebody">
        <div align="center">
          <input name="fe" type="text" size="10" maxlength="10" value="0" onFocus="this.select()">
        </div>
      </td>
      <td class="tablehead3">
        <div align="left"><b>Inst</b></div>
      </td>
      <td class="tablebody">
        <div align="center">
          <input name="inst" type="text" size="10"maxlength="10" value="0" onFocus="this.select()">
        </div>
      </td>
    </tr>
    <tr>
      <td class="tablehead3">
        <div align="left"><b>Night</b></div>
      </td>
      <td class="tablebody">
        <div align="center">
          <input name="night" type="text" size="10" maxlength="10" value="0" onFocus="this.select()">
        </div>
      </td>
      <td class="tablehead3">
        <div align="left"><b>DutyIP</b></div>
      </td>
      <td class="tablebody">
        <div align="center">
          <input name="dutyip" type="text" size="10" maxlength="10" value="0" onFocus="this.select()">
        </div>
      </td>
    </tr>
    <tr>
      <td class="tablehead3">
        <div align="left"><b>DutySF</b></div>
      </td>
      <td class="tablebody">
        <div align="center">
          <input name="dutysf" type="text" size="10" maxlength="10" value="0" onFocus="this.select()">
        </div>
      </td>
      <td class="tablehead3">
        <div align="left"><b>DutyCA</b></div>
      </td>
      <td class="tablebody">
        <div align="center">
          <input name="dutyca" type="text" size="10" maxlength="10" value="0" onFocus="this.select()">
        </div>
      </td>
    </tr>
    <tr>
      <td class="tablehead3">
        <div align="left"><b>DutyFO</b></div>
      </td>
      <td class="tablebody">
        <div align="center">
          <input name="dutyfo" type="text" size="10" maxlength="10" value="0" onFocus="this.select()">
        </div>
      </td>
      <td class="tablehead3">
        <div align="left"><b>DutyIFE</b></div>
      </td>
      <td class="tablebody">
        <div align="center">
          <input name="dutyife" type="text" size="10" maxlength="10" value="0" onFocus="this.select()">
        </div>
      </td>
    </tr>
    <tr>
      <td class="tablehead3">
        <div align="left"><b>DutyFE</b></div>
      </td>
      <td class="tablebody">
        <div align="center">
          <input name="dutyfe" type="text" size="10" maxlength="10" value="0" onFocus="this.select()">
        </div>
      </td>
      <td class="tablehead3">
        <div align="left"><b>ToDay</b></div>
      </td>
      <td class="tablebody">
        <div align="center">
          <input name="today" type="text"  size="10" maxlength="5" value="0" onFocus="this.select()">
        </div>
      </td>
    </tr>
    <tr>
      <td class="tablehead3">
        <div align="left"><b>ToNit</b></div>
      </td>
      <td class="tablebody">
        <div align="center">
          <input name="tonit" type="text" size="10" maxlength="5" value="0" onFocus="this.select()">
        </div>
      </td>
 
      <td class="tablehead3">
        <div align="left"><b>LdDay</b></div>
      </td>
      <td class="tablebody">
        <div align="center">
          <input name="ldday" type="text" size="10" maxlength="5" value="0" onFocus="this.select()">
        </div>
      </td>
    </tr>
    <tr>
      <td class="tablehead3">
        <div align="left"><b>LdNit</b></div>
      </td>
      <td class="tablebody">
        <div align="center">
          <input name="ldnit" type="text" size="10" maxlength="5" value="0" onFocus="this.select()">
        </div>
      </td>
      <td class="tablehead3">
        <div align="left"><b>PIC</b></div>
      </td>
      <td class="tablebody">
        <div align="center">
          <input name="pic" type="text" size="10"  maxlength="10"  value="0" onFocus="this.select()">
        </div>
      </td>
    </tr>
  </table>
  <p>
    <input type="submit" value="Insert Record" >
    <input type="hidden" name="staff_num" value="<%=empno%>">
</p>
  <div align="left"></div>
</form>
</center>
<%
}//end of has that empno
%>
</body>
</html>