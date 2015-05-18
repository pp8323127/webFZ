<%@page contentType="text/html; charset=big5" language="java" import="java.sql.*"%>
<%@ include file="../../Connections/cnORP3DF.jsp" %>
<%
String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login
/*
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);

if (session.isNew()) 
{		//check user session start first
  %> <jsp:forward page="sendredirect.jsp" /> <%
} 
if (sGetUsr == null) 
{		//check if not login
  %> <jsp:forward page="sendredirect.jsp" /> <%
} 
*/
	String empno = request.getParameter("empno");
	
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	ArrayList occuAL = new ArrayList();  
	int count =0;
String name	="";
String ename	="";
String sex	="";
String flag	="";
String cabin	="";
String box	="";
String nflrk	="";
String oflrk	="";
String ovrk	="";
String indt	="";
String poid	="";
String podt	="";
String pout	="";
String post	="";
String occu	="";
String fleet	="";
String base	="";
String sect	="";
String paycode	="";
String brk	="";
String brkrate	="";
String banknont ="";
String banknous ="";
String taxfmin	="";
String ipcp	="";
String traf	="";
String birthdate	="";
String birthplace	="";
String passno		="";
String passcontry	="";
String passcon		="";
String nation		="";
String passvalid	="";
String lastname		="";
String firstname	="";
String middlename	="";

  
 try{
   Class.forName(MM_cnORP3DF_DRIVER);
   conn = DriverManager.getConnection(MM_cnORP3DF_STRING,MM_cnORP3DF_USERNAME,MM_cnORP3DF_PASSWORD);
   stmt = conn.createStatement();	 
	  
	rs = stmt.executeQuery("SELECT DISTINCT occu FROM dftcrew "+
							"where occu IS NOT NULL anD occu NOT IN ('--',' ','FA','FS','PR') "+
							"ORDER BY occu");
	while(rs.next()){
		occuAL.add(rs.getString("occu"));
	}							
	
	rs = stmt.executeQuery("select  empno, name, ename, sex, flag, chgid, chgtime, cabin , box, nflrk, oflrk , ovrk  , indt , poid ,"
   			  +" podt , pout , post , occu , fleet , base , sect , paycode , brk   , brkrate , banknont , banknous , "
			  +"taxfmin , ipcp, traf , sess, to_char(birthdate,'yyyy-mm-dd') birthdate, birthplace, passno , passcontry, "
			  +"passcon , nation , to_char(passvalid,'yyyy-mm-dd') passvalid, lastname, firstname, middlename from dftcrew "
			  +" where empno = '" + empno + "'");
		  

	while (rs.next())
	{
		
		name = rs.getString("name");
		ename = rs.getString("ename");
		sex = rs.getString("sex");
		flag = rs.getString("flag");
		cabin = rs.getString("cabin");
		box = rs.getString("box");
		nflrk = rs.getString("nflrk");
		oflrk = rs.getString("oflrk");
		ovrk = rs.getString("ovrk");
		indt = rs.getString("indt");
		poid = rs.getString("poid");
		podt = rs.getString("podt");
		pout = rs.getString("pout");
		post = rs.getString("post");
		occu = rs.getString("occu");
		fleet = rs.getString("fleet");
		base = rs.getString("base");
		sect = rs.getString("sect");
		paycode = rs.getString("paycode");
		brk = rs.getString("brk");
		brkrate = rs.getString("brkrate");
		banknont = rs.getString("banknont");
		banknous = rs.getString("banknous");
		taxfmin = rs.getString("taxfmin");
		ipcp = rs.getString("ipcp");
		traf = rs.getString("traf");
	// add by cs66...start
	
		birthdate	= rs.getString("birthdate");//.sub(0,10);
		birthplace	= rs.getString("birthplace");
		passno		= rs.getString("passno");
		passcontry	= rs.getString("passcontry");
		passcon		= rs.getString("passcon");
		nation		= rs.getString("nation");
		passvalid	= rs.getString("passvalid");//.sub(0,10);
		lastname		= rs.getString("lastname");
		firstname	= rs.getString("firstname");
		middlename	= rs.getString("middlename");

	 // add by cs66...end
		 count ++;
	 }
}catch (Exception e){
	  out.println(e.toString());
}finally{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>
<html>
<head>
<title>
DFCrew detail Information
</title>
<meta http-equiv="pragma" content="no-cache">
<link href="../menu.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=big5"></head>
<%
if(count != 0 ){	
%>
<script language="javascript">
	function initData(){
		document.forms[0].occu.value="<%=occu%>";
		document.forms[0].flag.value="<%=flag%>";
	}
</script>
<body onLoad="initData()">
<%
}else{
%>
<body >
<%
}
%>
<center>

<%

if(count != 0){	 
%>
  <p class="txttitletop">Crew Detail Information</p>

  <form method="post" action="upddfcrew.jsp">
    <br>
    <br>
	<table border="1" class="fortable">
      <tr>
        <td width="71" class="tablehead3"><font color="#CCFF66">EmpNo</font><span class="txtxred">*</span></td>
        <td width="186"><span class="txtblue"><%= empno %>
            <input type="hidden" name="empno" value="<%= empno %>">
        </span> </td>
        <td width="78" class="tablehead3"><font color="#CCFF66">Name<span class="txtxred">*</span></font></td>
        <td width="168" colspan="3"><input type="text" name="name" value="<%= name %>">
        </td>

      </tr>
      <tr>
        <td class="tablehead3">Ename</td>
        <td><input type="text" name="ename" value="<%= ename %>">
        </td>
        <td class="tablehead3">Sex</td>
        <td><input type="text" name="sex" value="<%= sex %>"></td>
      </tr>
      <tr>
        <td class="tablehead3">Flag</td>
        <td>
			<select name="flag">
				<option value="Y">Y</option>
				<option value="N">N</option>
			</select>
		</td>
        <td class="tablehead3">Cabin</td>
        <td><input type="text" name="cabin" value="<%= cabin %>"></td>
      </tr>
      <tr>
        <td class="tablehead3">Box</td>
        <td><input type="text" name="box" value="<%= box %>"></td>
        <td class="tablehead3">Nflrk</td>
        <td><input type="text" name="nflrk" value="<%= nflrk %>"></td>
      </tr>
      <tr>
        <td class="tablehead3">Oflrk</td>
        <td><input type="text" name="oflrk" value="<%= oflrk %>">
        </td>
        <td class="tablehead3">Ovrk</td>
        <td><input type="text" name="ovrk" value="<%= ovrk %>">
        </td>
      </tr>
      <tr>
        <td class="tablehead3">Indt</td>
        <td><input type="text" name="indt" value="<%= indt %>">
        </td>
        <td class="tablehead3">Poid</td>
        <td><input type="text" name="poid" value="<%= poid %>">
        </td>
      </tr>
      <tr>
        <td class="tablehead3">Podt</td>
        <td><input type="text" name="podt" value="<%= podt %>">
        </td>
        <td class="tablehead3">Pout</td>
        <td><input type="text" name="pout" value="<%= pout %>">
        </td>
      </tr>
      <tr>
        <td class="tablehead3">Post</td>
        <td><input type="text" name="post" value="<%= post %>">
        </td>
        <td class="tablehead3">Occu</td>
        <td>
		<select name="occu">
		<%
			for(int i=0;i<occuAL.size();i++){
		%>
		<option value="<%=occuAL.get(i)%>"><%=occuAL.get(i)%></option>

		<%
				}

		%>
		</select>
        </td>
      </tr>
      <tr>
        <td class="tablehead3">Fleet</td>
        <td><input type="text" name="fleet" value="<%= fleet %>">
        </td>
        <td class="tablehead3">Base</td>
        <td><input type="text" name="base" value="<%= base %>">
        </td>
      </tr>
      <tr>
        <td class="tablehead3">Sect</td>
        <td><input type="text" name="sect" value="<%= sect %>">
        </td>
        <td class="tablehead3">Paycode</td>
        <td><input type="text" name="paycode" value="<%= paycode %>">
        </td>
      </tr>
      <tr>
        <td class="tablehead3">Brk</td>
        <td><input type="text" name="brk" value="<%= brk %>">
        </td>
        <td class="tablehead3">Brkrate</td>
        <td><input type="text" name="brkrate" value="<%= brkrate %>">
        </td>
      </tr>
      <tr>
        <td class="tablehead3">Banknont</td>
        <td><input type="text" name="banknont" value="<%= banknont %>">
        </td>
        <td class="tablehead3">Banknous</td>
        <td><input type="text" name="banknous" value="<%= banknous %>">
        </td>
      </tr>
      <tr>
        <td class="tablehead3">Taxfmin</td>
        <td><input type="text" name="taxfmin" value="<%= taxfmin %>">
        </td>
        <td class="tablehead3">Ipcp</td>
        <td><input type="text" name="ipcp" value="<%= ipcp %>">
        </td>
      </tr>
      <tr>
        <td class="tablehead3">Traf</td>
        <td><input type="text" name="traf" value="<%= traf %>">
        </td>
        <td class="tablehead3">Birthdate</td>
        <td><input type="text" name="birthdate" value="<%=birthdate%>">
        </td>
      </tr>
      <tr>
        <td class="tablehead3">Birthplace</td>
        <td><input type="text" name="birthplace" value="<%=birthplace%>">
        </td>
        <td class="tablehead3">Passno</td>
        <td><input type="text" name="passno" value="<%=passno%>">
        </td>
      </tr>
      <tr>
        <td class="tablehead3">Passcontry</td>
        <td><input type="text" name="passcontry" value="<%=passcontry%>">
        </td>
        <td class="tablehead3">Passcon</td>
        <td><input type="text" name="passcon" value="<%=passcon%>">
        </td>
      </tr>
      <tr>
        <td class="tablehead3">Nation</td>
        <td><input type="text" name="nation" value="<%=nation%>">
        </td>
        <td class="tablehead3">Passvalid</td>
        <td><input type="text" name="passvalid" value="<%=passvalid%>">
        </td>
      </tr>
      <tr>
        <td class="tablehead3">Lastname</td>
        <td><input type="text" name="lastname" value="<%=lastname%>">
        </td>
        <td class="tablehead3">Firstname</td>
        <td><input type="text" name="firstname" value="<%=firstname%>">
        </td>
      </tr>
      <tr>
        <td class="tablehead3">Middlename</td>
        <td colspan="3"><input type="text" name="middlename" value="<%=middlename%>"></td>
      </tr>
      <tr>
        <td colspan="4"><div align="center"><font face="Arial, Helvetica, sans-serif" size="2">
            <input name="submit" type="submit" value="Update" >
            <br>
            <span class="txttitle">column marked by</span><span class="txtxred"> *</span><span class="txttitle"> must
        be insert</span></font> <br>
        <span class="txtblue">date format is: yyyy-mm-dd (ex:2004-01-02) </span></div></td>
      </tr>


    </table>
    <br>
  </form>
<%        
}  else{
%>
  <p class="txttitletop">No DATA!!</p>
<%	
}
%>
</center>
</body>
</html>
