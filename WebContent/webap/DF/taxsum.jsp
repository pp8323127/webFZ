<%@page contentType="text/html; charset=big5" language="java" import="java.sql.*"%> 
<%@ include file="../Connections/cnORP3DF.jsp" %>
<%
String Recordset1__mypayid = "TPEOG";
if (request.getParameter("payid")  !=null) {Recordset1__mypayid = (String)request.getParameter("payid") ;}
%>
<%
String Recordset1__myyear = "2003";
if (request.getParameter("year")   !=null) {Recordset1__myyear = (String)request.getParameter("year")  ;}
%>
<%
String Recordset1__mymonth = "01";
if (request.getParameter("month")   !=null) {Recordset1__mymonth = (String)request.getParameter("month")  ;}
%>
<%
Driver DriverRecordset1 = (Driver)Class.forName(MM_cnORP3DF_DRIVER).newInstance();
Connection ConnRecordset1 = DriverManager.getConnection(MM_cnORP3DF_STRING,MM_cnORP3DF_USERNAME,MM_cnORP3DF_PASSWORD);
PreparedStatement StatementRecordset1 = ConnRecordset1.prepareStatement("SELECT sum(tflypay) tflypay, sum(tover) tover, sum(stby) stby, sum(rew) rew, sum(disp + crus) sdc, sum(othb) othb, sum(wine) wine, sum(sale) sale, sum(tsum) tsum  FROM dftpock a, dftcrew b  WHERE a.empno = b.empno and yyyy = '" + Recordset1__myyear + "' and mm = '" + Recordset1__mymonth + "' and b.paycode = '" + Recordset1__mypayid + "'");
ResultSet Recordset1 = StatementRecordset1.executeQuery();
boolean Recordset1_isEmpty = !Recordset1.next();
boolean Recordset1_hasData = !Recordset1_isEmpty;
Object Recordset1_data;
int Recordset1_numRows = 0;
%>
<html>
<head>
<title>DFFP033</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
</head>
<body bgcolor="#FFFFFF" text="#000000">
<div align="center"> 
  <p><font face="Comic Sans MS" color="#000099">All crews flypay taxable Sum</font></p>
  <p><font face="Comic Sans MS" color="#000099">PayID : <%= ((request.getParameter("payid")!=null)?request.getParameter("payid"):"") %></font></p>
  <table width="85%" border="1" cellspacing="0" cellpadding="0">
    <tr bgcolor="#CCCCCC"> 
      <td> 
        <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2"> 
          Year<br>
          Month </font></b></div>
      </td>
      <td> 
        <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2"> 
          Flypay<br>
          Taxable </font></b></div>
      </td>
      <td> 
        <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2"> 
          Overtime<br>
          Taxable </font></b></div>
      </td>
      <td> 
        <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">Standby</font></b></div>
      </td>
      <td> 
        <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">Rew</font></b></div>
      </td>
      <td> 
        <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">巡航/<br>
          派遣<br>
          獎金</font></b></div>
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
        <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%= ((request.getParameter("year")!=null)?request.getParameter("year"):"") %>/<%= ((request.getParameter("month")!=null)?request.getParameter("month"):"") %></font></div>
      </td>
      <td> 
        <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Recordset1_data = Recordset1.getObject("TFLYPAY"))==null || Recordset1.wasNull())?"":Recordset1_data)%></font></div>
      </td>
      <td> 
        <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Recordset1_data = Recordset1.getObject("TOVER"))==null || Recordset1.wasNull())?"":Recordset1_data)%></font></div>
      </td>
      <td> 
        <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Recordset1_data = Recordset1.getObject("STBY"))==null || Recordset1.wasNull())?"":Recordset1_data)%></font></div>
      </td>
      <td> 
        <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Recordset1_data = Recordset1.getObject("REW"))==null || Recordset1.wasNull())?"":Recordset1_data)%></font></div>
      </td>
      <td> 
        <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Recordset1_data = Recordset1.getObject("SDC"))==null || Recordset1.wasNull())?"":Recordset1_data)%></font></div>
      </td>
      <td> 
        <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Recordset1_data = Recordset1.getObject("OTHB"))==null || Recordset1.wasNull())?"":Recordset1_data)%></font></div>
      </td>
      <td> 
        <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Recordset1_data = Recordset1.getObject("WINE"))==null || Recordset1.wasNull())?"":Recordset1_data)%></font></div>
      </td>
      <td> 
        <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Recordset1_data = Recordset1.getObject("SALE"))==null || Recordset1.wasNull())?"":Recordset1_data)%></font></div>
      </td>
      <td> 
        <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Recordset1_data = Recordset1.getObject("TSUM"))==null || Recordset1.wasNull())?"":Recordset1_data)%></font></div>
      </td>
    </tr>
  </table>
  <p>&nbsp; </p>
</div>
</body>
</html>
<%
Recordset1.close();
ConnRecordset1.close();
%>

