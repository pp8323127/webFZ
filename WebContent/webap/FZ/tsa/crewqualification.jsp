<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*, java.util.*, java.text.*, javax.naming.*, ci.db.*" %>

<%
//Check user already login or not

String s_USER_ID = (String)session.getAttribute("s_USER_ID");

//if(s_USER_ID == null)
//	response.sendRedirect("dz_relogin.html");

//String sGetUsr = (String) session.getAttribute("cs55.usr") ; 
//get user id if already login
String	sGetUsr = request.getParameter("sGetUsr");
session.setAttribute("sGetUsr",sGetUsr);

Connection conn = null;
Driver dbDriver = null;
Statement stmt  = null;
ResultSet myResultSet = null;
String rptloc  	= "TSA";
String sdate 	= null;
String theday  	= null;

try{	 
	ConnDB cn = new ConnDB();

	cn.setORP3FZUserCP();

	//cn.setDFUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
	stmt = conn.createStatement();		
	myResultSet = stmt.executeQuery("select to_char(sysdate, 'yyyy-mm-dd') from dual");
	if (myResultSet.next()) theday = myResultSet.getString(1);
   }catch (Exception e){
			out.println("Error : " + e.toString());
		       }
    finally{	try{
			if(myResultSet != null) myResultSet.close();
		   }catch(SQLException e){}
   		try{
			if(stmt != null) stmt.close();
		   }catch(SQLException e){}
   		try{
			if(conn != null) conn.close();
		   }catch(SQLException e){}
	   }
	session.setAttribute("sSYSDATE",theday);
%>

<html>
<head>
<link rel="stylesheet" href="format.css" type="text/css">
<title></title>
<script language="Javascript" src="../temple/FieldTools.js"></script>
<script language=javascript>  
	
</script>
<script language = javascript>
	function getCalendar(obj) { eval("wincal=window.open('../Calendar.htm','" + obj +"','width=350,height=200')");}
	function f_Back(){ history.go(-1);}
	function f_onLoad()
	{
		document.form1.slt_FLEET.focus();	 
	}
</script>

</head>
<body onLoad="f_onLoad()">

<%
//String bcolor1 	= "#99CCCC";			//Light Blue
//String bcolor1 	= "#FFCCCC";			//Light Pink
String bcolor1 		= "#CCCC99";			//Light Weak Yellow
//String bcolor2 	= "LightGoldenrodYellow";	//Light Yellow
String bcolor2	 	= "#FFFFFF";			//White
//String bcolor3 	= "#C0C0C0";			//Medium Gray
String bcolor3 		= "#CCCCFF";			//Light Blue
String bcolor4 		= "#DDDDDD";			//Light Gray
String bcolor5 		= "#666666";			//Dark Gray
String bcolor_col 	= "#FFFFFF";			//White

//java.util.Date	d_SYSDATE	= new java.util.Date();
//java.util.Date	d_SYSDATE_M6	= new java.util.Date(d_SYSDATE.getTime() - (long)6 * 24 * 60 * 60 * 1000); // -6 days

//SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy/MM/dd");
//SimpleDateFormat sdf2 = new SimpleDateFormat("HH:mm");
//SimpleDateFormat sdf3 = new SimpleDateFormat("yyyy/MM/dd HH:mm");

try
{
	
%>


<form action="crewqualification_list.jsp" method= "post" name= "form1" target="mainFrame">
 
  <table width="700" align="center">
    <tr class="detail">
	<td class="title">Fleet :</td>
	<td class="change">
		<select name="slt_FLEET" id="slt_FLEET" >
			<option value="%"    selected>ALL</option>
			<option value="744" 	     >744</option>
			<option value="340"          >340</option>
			<option value="330"          >330</option>
			<option value="738"          >738</option>
		</select>
	</td>
	<td class="title">Rank :</td>
        <td class="change">
		<select name="slt_RANK" id="slt_RANK">
			<option value="%"   selected>ALL</option>
			<option value="CA"          >CA</option>
			<option value="RP"          >RP</option>
			<option value="FO"          >FO</option>
		</select>
	</td>
   	
   	<td class="title">ID :</td>
	<td class="change"><input name="slt_EMPNO" id="slt_EMPNO" type="text" maxlength="6" size=6></td>
			
        <td class="title">Check_Date :</td>
	<td><span onclick="getCalendar('checkdate')" style="cursor:pointer">
			<input name="checkdate" type="text" class="text" style="cursor:pointer" onFocus="this.blur()"
			value="<%=theday%>" size="15" maxlength="10"><img src="../images/p2.gif" width="22" height="22">
		    </span>
        </td>
  
	<td class="title">Qualifications :</td>
        <td class="change">
		<select name="slt_QUALIFICATION" id="slt_QUALIFICATION">
			<option value="%"     selected  >ALL</option>
			<option value="A001"		>檢定證 (RAT)</option>
			<option value="A002"          	>英檢加簽 (ENG)</option>
			<option value="A003"          	>體檢證 (MED)</option>
			<option value="A004"          	>護照 (PPT)</option>
			<option value="A005"            >台胞證 (CHN)</option>
			<option value="A006"            >台胞證加簽 (CN)</option>
			<option value="A007"          	>US VISA (USD)</option>
			<option value="A008"          	>SPPA (FAA)</option>
			<option value="A009"            >China VISA (for EXP) (CN)</option>
			<option value="A010"            >LUX VISA (for EXP) (LU)</option>
			<option value="A011"          	>外籍居留證 (ARC)</option>
			<option value="A012"          	>空勤組員證 (CMC)</option>
			<option value="A013-1"          >Recency (45/FLT)</option>
			<option value="A013-2"          >Recency (90/TO&LD)</option>
			<option value="A014"          	>CRM</option>
			<option value="A015"            >Security Training (SS)</option>
			<option value="A016"            >Emergency Training (ET)</option>
			<option value="A017"            >Dangerous Goods (DG)</option>
			<option value="A018"            >Airport & Route competence (APT&RT)</option>
			<option value="A019"       	>Right Seat qualification (RHS)</option>
			<option value="A020"           	>IP/CP qualification (IPCP)</option>
			<option value="A021"          	>PT</option>
			<option value="A022"          	>PC</option>
			<option value="A023"            >RC</option>
			<option value="A024"            >Initial TRN & CHK (Initial)</option>
			<option value="A025"            >Specific qualification-LVO(CAT II,IIIa/IIIb)</option>
			<option value="A026"            >Specific qualification-RVSM</option>
			<option value="A027"            >Specific qualification-ETOPS</option>
			<option value="A028"            >Equipment qualification-TCAS/ACAS</option>
			<option value="A029"            >Equipment qualification-GPWS/EGPWS</option>
		</select>
	</td>
	<td class="title">Effective :</td>
	<td  class="change">
		<select name="slt_EFFECTIVE" id="slt_EFFECTIVE">
			<option value="%"   selected	>ALL</option>
			<option value="Yes"           	>Yes</option>
			<option value="No"           	>No</option>
		</select>	
	</td>

   	<td>	<input name="Submit" type="submit"	value="Inquery"	></td>		
   </tr>			
 </table>	

		
</form>
	
<%
}
catch(Exception ex)
{
	out.println(ex.toString());
}
finally
{
}
%>

</body>
</html>
