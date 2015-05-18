<%
String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login
if (session.isNew()) 
{		//check user session start first
  %> <jsp:forward page="login.jsp" /> <%
} 
if (sGetUsr == null) 
{		//check if not login
  %> <jsp:forward page="login.jsp" /> <%
} 
%>
<%@page contentType="text/html; charset=big5" language="java" import="java.sql.*"%>
<%@ include file="../Connections/cnORP3DF.jsp" %>
<html>
<head>
<title>DFFP032</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<p align="center"><font face="Comic Sans MS" color="#000099">Flypay Taxable List</font>
  <%
   String empno = request.getParameter("EMPNO");
   String yyyy = request.getParameter("year");
   String mm = request.getParameter("month");
   String payid = request.getParameter("payid");
     
   Class.forName(MM_cnORP3DF_DRIVER);
   Connection myConn = DriverManager.getConnection(MM_cnORP3DF_STRING,MM_cnORP3DF_USERNAME,MM_cnORP3DF_PASSWORD);
   Statement stmt = myConn.createStatement();
   ResultSet myResultSet = stmt.executeQuery("select name, round(paymin/60, 2) hpaymin, "+
   "round(decmin/60, 2) hdecmin, round(tmin/60, 2) htmin, flypay, flypay2, tflypay, over, tover, stby, "+
   "rew, mgr, disp, crus, othb, wine, sale, tsum "+
   "from dftpock a, dftcrew b "+
   "where a.empno = b.empno and a.empno = '"+empno+"' and yyyy = '"+yyyy+"' and mm = '"+mm+"'");
   if (myResultSet != null)
   {
   		while (myResultSet.next())
		{
 			String name = myResultSet.getString("name");
			String hpaymin = myResultSet.getString("hpaymin");
			String hdecmin = myResultSet.getString("hdecmin");
			String htmin = myResultSet.getString("htmin");
			String flypay = myResultSet.getString("flypay");
			String flypay2 = myResultSet.getString("flypay2");
			String tflypay = myResultSet.getString("tflypay");
			String over = myResultSet.getString("over");
			String tover = myResultSet.getString("tover");
			String stby = myResultSet.getString("stby");
			String rew = myResultSet.getString("rew");
			String mgr = myResultSet.getString("mgr");
			String disp = myResultSet.getString("disp");
			String crus = myResultSet.getString("crus");
			String othb = myResultSet.getString("othb");
			String wine = myResultSet.getString("wine");
			String sale = myResultSet.getString("sale");
			String tsum = myResultSet.getString("tsum");
%>
</p>
<table width="85%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
    <td><b><font face="Arial, Helvetica, sans-serif" size="2"><%=name%></font></b></td>
    <td> 
      <div align="right"><b><font face="Arial, Helvetica, sans-serif" size="2">PayID 
        : <%=payid%></font></b></div>
    </td>
  </tr>
</table>
<form name="form1" method="post" action="taxcrewsave.jsp">
  <table width="90%" border="1" cellspacing="0" cellpadding="0" align="center">
    <tr bgcolor="#CCCCCC"> 
      <td> 
        <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">EmpNo</font></b></div>
      </td>
      <td> 
        <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">Year</font></b></div>
      </td>
      <td> 
        <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">Month</font></b></div>
      </td>
      <td> 
        <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">Fly 
          Hrs</font></b></div>
      </td>
      <td> 
        <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">Dec 
          Hrs</font></b></div>
      </td>
      <td> 
        <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">Taxfree 
          Hrs</font></b></div>
      </td>
    </tr>
    <tr> 
      <td> 
        <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"> 
          <input type="hidden" name="empno" value="<%=empno%>">
          <%=empno%> 
          <input type="hidden" name="payid" value="<%=payid%>">
          </font></div>
      </td>
      <td> 
        <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"> 
          <input type="hidden" name="year" value="<%=yyyy%>">
          <%=yyyy%></font></div>
      </td>
      <td> 
        <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"> 
          <input type="hidden" name="month" value="<%=mm%>">
          <%=mm%></font></div>
      </td>
      <td> 
        <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=hpaymin%></font></div>
      </td>
      <td> 
        <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=hdecmin%></font></div>
      </td>
      <td> 
        <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=htmin%></font></div>
      </td>
    </tr>
  </table>
  <table width="90%" border="1" cellspacing="0" cellpadding="0" align="center">
    <tr bgcolor="#CCCCCC"> 
      <td> 
        <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">Flypay</font></b></div>
      </td>
      <td> 
        <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">Flypay2</font></b></div>
      </td>
      <td> 
        <div align="center"> <b><font face="Arial, Helvetica, sans-serif" size="2">Flypay</font></b><br>
          <b><font face="Arial, Helvetica, sans-serif" size="2">Taxable</font></b> 
        </div>
      </td>
      <td> 
        <div align="center"> <b><font face="Arial, Helvetica, sans-serif" size="2">Overtime</font></b><br>
          <b><font face="Arial, Helvetica, sans-serif" size="2">Pay</font></b> 
        </div>
      </td>
      <td> 
        <div align="center"> <b><font face="Arial, Helvetica, sans-serif" size="2">Overtime</font></b><br>
          <b><font face="Arial, Helvetica, sans-serif" size="2">Taxable</font></b> 
        </div>
      </td>
      <td> 
        <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">Standby</font></b></div>
      </td>
      <td> 
        <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">Rew</font></b></div>
      </td>
      <td> 
        <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">Manager</font></b></div>
      </td>
      <td> 
        <div align="center"> <b><font face="Arial, Helvetica, sans-serif" size="2">巡航/</font></b><br>
          <b><font face="Arial, Helvetica, sans-serif" size="2">派遣獎金</font></b> 
        </div>
      </td>
      <td> 
        <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">應稅</font></b><br>
          <b><font face="Arial, Helvetica, sans-serif" size="2"> 其他</font></b> 
        </div>
      </td>
      <td> 
        <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">Wine</font></b></div>
      </td>
      <td> 
        <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">Sale</font></b></div>
      </td>
      <td> 
        <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">Sum</font></b></div>
      </td>
    </tr>
    <tr> 
      <td> 
        <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=flypay%></font></div>
      </td>
      <td> 
        <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=flypay2%></font></div>
      </td>
      <td> 
        <div align="center"> 
          <input type="text" name="tflypay" size="6" maxlength="6" value="<%=tflypay%>">
        </div>
      </td>
      <td> 
        <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=over%></font></div>
      </td>
      <td> 
        <div align="center"> 
          <input type="text" name="tover" size="6" maxlength="6" value="<%=tover%>">
        </div>
      </td>
      <td> 
        <div align="center"> 
          <input type="text" name="stby" size="6" maxlength="6" value="<%=stby%>">
        </div>
      </td>
      <td> 
        <div align="center"> 
          <input type="text" name="rew" size="6" maxlength="6" value="<%=rew%>">
        </div>
      </td>
      <td> 
        <div align="center"> 
          <input type="text" name="mgr" size="6" maxlength="6" value="<%=mgr%>">
        </div>
      </td>
      <td> 
        <div align="center"> 
            <input type="text" name="disp" size="6" maxlength="6" value="<%=disp%>"><br>
            <input type="text" name="crus" size="6" maxlength="6" value="<%=crus%>">
        </div>
      </td>
      <td> 
        <div align="center"> 
          <input type="text" name="othb" size="6" maxlength="6" value="<%=othb%>">
        </div>
      </td>
      <td> 
        <div align="center"> 
          <input type="text" name="wine" size="6" maxlength="6" value="<%=wine%>">
        </div>
      </td>
      <td> 
        <div align="center"> 
          <input type="text" name="sale" size="6" maxlength="6" value="<%=sale%>">
        </div>
      </td>
      <td> 
        <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=tsum%></font></div>
      </td>
    </tr>
  </table>
  <p align="center"> 
    <input type="submit" name="Submit" value="Submit">
    <input type="reset" name="Submit2" value="Reset">
  </p>
</form>
<p align="right"><img src="logo2.gif" width="165" height="35"></p>
<%        
    	}  
   }
   stmt.close();
   myConn.close();
%>
</body>
</html>
