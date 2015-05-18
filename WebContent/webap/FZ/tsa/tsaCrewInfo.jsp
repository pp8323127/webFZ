<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*" errorPage="" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%

String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login

response.setHeader("Cache-Control","no-cache");

response.setDateHeader ("Expires", 0);



if (session.isNew() ||sGetUsr == null) 

{		//check user session start first

	response.sendRedirect("sendredirect.jsp");

} 

%>

<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=big5">

<title>TSA Crew Info</title>

<link href="../menu.css" rel="stylesheet" type="text/css">

<script language="JavaScript" type="text/JavaScript">

function checkField(){

	if(document.form1.birthY.value ==""){

		alert("Please insert BirthDate.");

		document.form1.birthY.focus();

		return false;

	}

	else{

		return true;

	}

}

</script>



</head>

<body>



<div align="center">

  <%

String empno 		= request.getParameter("empno");





Connection conn = null;

Statement stmt = null;

ResultSet myResultSet = null;

String sql = "SELECT NAME cname,lastname,firstname,passno,passcontry,mname,gender,pilotctry,pilotno,remark,doctype,tvlstatus,"+

			"To_Char(birthdate,'yyyy/mm/dd') birthdate  FROM dfttsa "+

			"where empno ='"+empno+"'";

int count = 0;



String cname		= null;

String lastname		= null;

String firstname	= null;

String passno		= null;

String passcountry	= null;

String birthdate 	= null;
String mname 	= null;
String gender 	= null;
String pilotctry 	= null;
String pilotno 	= null;
String remark 	= null;
String doctype 	= null;
String tvlstatus 	= null;

 Driver dbDriver = null;
ConnDB cn = new ConnDB();
try{

cn.setDFUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);

stmt = conn.createStatement();

myResultSet = stmt.executeQuery(sql);

	if(myResultSet.next()){

		 cname			= myResultSet.getString("cname");

		 lastname		= myResultSet.getString("lastname");

		 firstname		= myResultSet.getString("firstname");

		 passno			= myResultSet.getString("passno");

		 passcountry	= myResultSet.getString("passcontry");

		 birthdate 		= myResultSet.getString("birthdate");
		 mname	= myResultSet.getString("mname");
		gender	= myResultSet.getString("gender");
		pilotctry	= myResultSet.getString("pilotctry");
		pilotno	= myResultSet.getString("pilotno");
		remark	= myResultSet.getString("remark");
		doctype	= myResultSet.getString("doctype");
		tvlstatus	= myResultSet.getString("tvlstatus");				
		 count ++;

	}



if(count ==0){

	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}

	try{if(stmt != null) stmt.close();}catch(SQLException e){}

	try{if(conn != null) conn.close();}catch(SQLException e){}

	

	response.sendRedirect("showmessage.jsp?messagestring=No Crew Info,Please insert empno again");



}	

%>

<form name="form1" action="UpdateTsaCrewInfo.jsp" method="post" onSubmit="return checkField()">

  <span class="txttitletop">TSA Crew Info </span>  
    <table width="79%"  border="0" cellpadding="2" cellspacing="0" class="fortable">
      <tr class="tablebody"> 
        <td width="16%" class="tablehead3" >Empno</td>
        <td width="34%" class="txtblue"><%=empno%></td>
        <td width="16%" class="tablehead3" >Name</td>
        <td width="34%"  class="txtblue"><%=cname%></td>
      </tr>
      <tr class="tablebody"> 
        <td class="tablehead3" >LastName</td>
        <td  class="tablebody"> <input name="lastname" type="text" id="textfield" size="30" maxlength="35" value="<%=lastname%>"> 
        </td>
        <td class="tablehead3" >FirstName</td>
        <td  class="tablebody"> <input name="firstname" type="text" id="textfield2" size="30" maxlength="35" value="<%=firstname%>"> 
        </td>
      </tr>
      <tr class="tablebody"> 
        <td class="tablehead3" >MiddleName</td>
        <td  class="tablebody"> <input name="mname" type="text" id="textfield" size="30" maxlength="35" value="<%=mname%>"> 
        </td>
        <td class="tablehead3" >Gender</td>
        <td  class="tablebody"> <input name="gender" type="text" id="textfield2" size="30" maxlength="35" value="<%=gender%>"> 
        </td>
      </tr>
      <tr class="tablebody"> 
        <td class="tablehead3" >PassNo</td>
        <td  class="tablebody"> <input name="passno" type="text" id="textfield3" size="30" maxlength="20" value="<%=passno%>"> 
        </td>
        <td class="tablehead3" >PassCountry</td>
        <td  class="tablebody"> <input name="passcountry" type="text" id="textfield22" size="30" maxlength="50" value="<%=passcountry%>"> 
        </td>
      </tr>
      <tr class="tablebody"> 
        <td class="tablehead3" >Pilot issue country</td>
        <td  class="tablebody"> <input name="pilotctry" type="text" id="textfield3" size="30" maxlength="20" value="<%=pilotctry%>"> 
        </td>
        <td class="tablehead3" >Pilot number</td>
        <td  class="tablebody"> <input name="pilotno" type="text" id="textfield22" size="30" maxlength="50" value="<%=pilotno%>"> 
        </td>
      </tr>
      <tr class="tablebody"> 
        <td class="tablehead3" >BirthDate</td>
        <td colspan="3"  class="tablebody"> <label for="birthY" class="txtred">Year</label> 
          <input name="birthY" type="text"  size="4" maxlength="4" value="<%=birthdate.substring(0,4)%>"> 
          <label for="birthM" class="txtred">Month</label> <select name="birthM">
            <option value="<%=birthdate.substring(5,7)%>"><%=birthdate.substring(5,7)%></option>
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
          </select> <label for="birthD" class="txtred">Day</label> <select name="birthD">
            <option value="<%=birthdate.substring(8)%>"><%=birthdate.substring(8)%></option>
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
          </select> </td>
      </tr >
      <tr class="tablebody"> 
        <td class="tablehead3" >Document type</td>
        <td  class="tablebody"> <input name="doctype" type="text" id="textfield3" size="30" maxlength="20" value="<%=doctype%>"> 
        </td>
        <td class="tablehead3" >Travel status</td>
        <td  class="tablebody"> <input name="tvlstatus" type="text" id="textfield22" size="30" maxlength="50" value="<%=tvlstatus%>"> 
        </td>
      </tr>
      <tr class="tablebody"> 
        <td class="tablehead3" >Remark</td>
        <td  class="tablebody"> <input name="remark" type="text" id="textfield3" size="30" maxlength="20" value="<%=remark%>"> 
        </td>
        <td class="tablehead3" >&nbsp;</td>
        <td  class="tablebody">&nbsp; </td>
      </tr>
      <tr > 
        <td colspan="4" > <label for="Submit"></label> <div align="center"> 
            <input type="submit" name="Submit" value="Modify" id="Submit">
            &nbsp;&nbsp;&nbsp; 
            <input name="reset" type="reset" value="Reset">
            <input type="hidden" name="empno" value="<%=empno%>">
            <input type="hidden" name="cname" value="<%=cname%>">
            <br>
            <span class="txtxred">*Enter 4 digital numbers to represent the year 
            of BirthDate. </span><br>
          </div></td>
      </tr>
    </table>

</form>

</div>

</body>

</html>



<%

}

catch (Exception e)

{

	  out.print(e.toString());

}

finally

{

	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}

	try{if(stmt != null) stmt.close();}catch(SQLException e){}

	try{if(conn != null) conn.close();}catch(SQLException e){}

}

%>