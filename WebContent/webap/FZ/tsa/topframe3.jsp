<%
String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login
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
%>
<html>
<head>
<title>Top Frame</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<meta http-equiv="pragma" content="no-cache">
<link href="../menu.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<table width="81%" border="0">
  <tr> 
    <td height="38"> 
      <form name="form1" method="post" action="dfr001.jsp" target="mainFrame">
        <span class="txttitle">Year 
        <select name="year" size="1">
			<option value="2001">2001</option>
			<option value="2002">2002</option>
			<option value="2003">2003</option>
			<option value="2004">2004</option>
			<option value="2005">2005</option>
			<option value="2006">2006</option>
			<option value="2007">2007</option>
			<option value="2008">2008</option>
			<option value="2009">2009</option>
			<option value="2010">2010</option>
			<option value="2011">2011</option>
			<option value="2012">2012</option>
			<option value="2013">2013</option>
			<option value="2014">2014</option>
			<option value="2015">2015</option>
			<option value="2016">2016</option>
			<option value="2017">2017</option>
			<option value="2018">2018</option>
			<option value="2019">2019</option>
			<option value="2020">2020</option>
        </select>
        Fleet
        <select name="fleet" size="1">
		  <option value="" selected>ALL</option>
          <option value="333">333</option>
          <option value="343">343</option>
          <option value="738">738</option>
          <option value="744">744</option>
          <option value="AB6">AB6</option>
        </select>
		Rank
        <select name="rank" size="1">
		  <option value="" selected>ALL</option>
          <option value="CA">CA</option>
          <option value="FO">FO</option>
        </select>
		</span>
        <input type="submit" name="Submit" value="Submit" class="btm">
      </form>
    </td>
  </tr>
</table>
</body>
</html>
