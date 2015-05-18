<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first
  %> <jsp:forward page="login.jsp" /> <%
} 
String cdept = (String) session.getAttribute("cs55.cdept") ;
String cname = (String) session.getAttribute("cs55.cname") ;
String lastday = (String) session.getAttribute("cs55.lastdays") ;
String thisday = (String) session.getAttribute("cs55.thisdays") ;
String nextday = (String) session.getAttribute("cs55.nextdays") ;
String indate = (String) session.getAttribute("cs55.indate") ;
%>
<%@page contentType="text/html; charset=big5" language="java" import="java.sql.*"%>
<%@ include file="../Connections/cnORP3.jsp" %>
<%
String Recordset2__myoffyear = "2004";
if (request.getParameter("offyear") !=null) {Recordset2__myoffyear = (String)request.getParameter("offyear");}
%>
<%
String Recordset2__myempn = "631700";
if (request.getParameter("empn") !=null) {Recordset2__myempn = (String)request.getParameter("empn");}
%>
<%
Driver DriverRecordset2 = (Driver)Class.forName(MM_cnORP3_DRIVER).newInstance();
Connection ConnRecordset2 = DriverManager.getConnection(MM_cnORP3_STRING,MM_cnORP3_USERNAME,MM_cnORP3_PASSWORD);
PreparedStatement StatementRecordset2 = ConnRecordset2.prepareStatement("SELECT OFFNO, EMPN, SERN, DECODE(OFFTYPE, '0', 'AL',                                                                                          '1', 'WL',                                                                                          '2', 'FL',                                                                                          '3', 'SL',                                                                                          '4', 'IL',                                                                                          '5', 'EL',                                                                                          '6', 'BL',                                                                                          '7', 'MB',                                                                                          '8', 'OL',                                                                                          '9', 'NP',                                                                                           OFFTYPE) MYOFFTYPE, to_char(OFFSDATE, 'yyyy/mm/dd') myoffsdate, to_char(OFFEDATE, 'yyyy/mm/dd') myoffedate, OFFDAYS, REMARK, OFFYEAR, GRADEYEAR, NEWDATE  FROM EGDB.EGTOFFS  WHERE EMPN='" + Recordset2__myempn + "' AND GRADEYEAR='" + Recordset2__myoffyear + "'  ORDER BY OFFSDATE");
ResultSet Recordset2 = StatementRecordset2.executeQuery();
boolean Recordset2_isEmpty = !Recordset2.next();
boolean Recordset2_hasData = !Recordset2_isEmpty;
Object Recordset2_data;
int Recordset2_numRows = 0;
%>
<%
int Repeat1__numRows = -1;
int Repeat1__index = 0;
Recordset2_numRows += Repeat1__numRows;
%>
<%
String Recordset1__offyear = "2003";
if (request.getParameter("offyear") !=null) {Recordset1__offyear = (String)request.getParameter("offyear");}
%>
<%
Driver DriverRecordset1 = (Driver)Class.forName(MM_cnORP3_DRIVER).newInstance();
Connection ConnRecordset1 = DriverManager.getConnection(MM_cnORP3_STRING,MM_cnORP3_USERNAME,MM_cnORP3_PASSWORD);
PreparedStatement StatementRecordset1 = ConnRecordset1.prepareStatement("SELECT *  FROM EGDB.EGTOFFS  WHERE " + 
Recordset1__offyear + "='" + Recordset1__offyear + "'");
ResultSet Recordset1 = StatementRecordset1.executeQuery();
boolean Recordset1_isEmpty = !Recordset1.next();
boolean Recordset1_hasData = !Recordset1_isEmpty;
Object Recordset1_data;
int Recordset1_numRows = 0;
%>
<html>
<head>
<title>View offsheet</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
</head>
<body bgcolor="#FFFFFF" text="#000000">
<div align="center"> 
  <p><font face="Comic Sans MS" color="#000099"> <%= ((request.getParameter("offyear")!=null)?request.getParameter("offyear"):"") %> Offsheet List</font></p>
  <table width="75%" border="0">
    <tr> </tr>
  </table>
  <table width="75%" border="0">
    <tr> 
      <td width="24%"><font face="Arial, Helvetica, sans-serif" size="2">&nbsp;<b>Dept 
        / </b><%=cdept%></font></td>
      <td width="24%"><font face="Arial, Helvetica, sans-serif" size="2">&nbsp;<b>Name 
        / </b><%=cname%></font></td>
      <td width="25%"><font face="Arial, Helvetica, sans-serif" size="2"><b>EmpNo 
        /</b> <%=(((Recordset2_data = Recordset2.getObject("EMPN"))==null || Recordset2.wasNull())?"":Recordset2_data)%></font></td>
      <td width="27%"><font face="Arial, Helvetica, sans-serif" size="2"><b>SerNo 
        / </b><%=(((Recordset2_data = Recordset2.getObject("SERN"))==null || Recordset2.wasNull())?"":Recordset2_data)%></font></td>
    </tr>
    <tr> 
      <td width="24%"><b><font size="2" face="Arial, Helvetica, sans-serif">Lastday 
        / <%=lastday%></font></b></td>
      <td width="24%"><b><font size="2" face="Arial, Helvetica, sans-serif">Thisday 
        / <%=thisday%></font></b></td>
      <td width="25%"><b><font size="2" face="Arial, Helvetica, sans-serif">Nextday 
        / <%=nextday%></font></b></td>
      <td width="27%"><b><font size="2" face="Arial, Helvetica, sans-serif">Indate 
        / <%=indate%></font></b></td>
    </tr>
  </table>
  <table width="75%" border="0">
    <tr bgcolor="#CCCCCC"> 
      <td> 
        <div align="center"><font color="#000000"><b><font face="Arial, Helvetica, sans-serif" size="2">OffNo</font></b></font></div>
      </td>
      <td> 
        <div align="center"><font color="#000000"><b><font face="Arial, Helvetica, sans-serif" size="2">Offtype</font></b></font></div>
      </td>
      <td> 
        <div align="center"><font color="#000000"><b><font face="Arial, Helvetica, sans-serif" size="2">Offsdate</font></b></font></div>
      </td>
      <td> 
        <div align="center"><font color="#000000"><b><font face="Arial, Helvetica, sans-serif" size="2">Offedate</font></b></font></div>
      </td>
      <td> 
        <div align="center"><font color="#000000"><b><font face="Arial, Helvetica, sans-serif" size="2">Offdays</font></b></font></div>
      </td>
      <td> 
        <div align="center"><font color="#000000"><b><font face="Arial, Helvetica, sans-serif" size="2">Remark</font></b></font></div>
      </td>
      <td> 
        <div align="center"><font color="#000000"><b><font face="Arial, Helvetica, sans-serif" size="2">ApplyDate</font></b></font></div>
      </td>
    </tr>
    <% while ((Recordset2_hasData)&&(Repeat1__numRows-- != 0)) { %>
    <tr> 
      <td> 
        <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Recordset2_data = Recordset2.getObject("OFFNO"))==null || Recordset2.wasNull())?"":Recordset2_data)%></font></div>
      </td>
      <td> 
        <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Recordset2_data = Recordset2.getObject("MYOFFTYPE"))==null || Recordset2.wasNull())?"":Recordset2_data)%></font></div>
      </td>
      <td> 
        <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Recordset2_data = Recordset2.getObject("MYOFFSDATE"))==null || Recordset2.wasNull())?"":Recordset2_data)%></font></div>
      </td>
      <td> 
        <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Recordset2_data = Recordset2.getObject("MYOFFEDATE"))==null || Recordset2.wasNull())?"":Recordset2_data)%></font></div>
      </td>
      <td> 
        <div align="center"><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"><%=(((Recordset2_data = Recordset2.getObject("OFFDAYS"))==null || Recordset2.wasNull())?"":Recordset2_data)%></font></div>
      </td>
      <td> 
        <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><b><font color="#FF0000"><%=(((Recordset2_data = Recordset2.getObject("REMARK"))==null || Recordset2.wasNull())?"":Recordset2_data)%></font></b></font></div>
      </td>
      <td> 
        <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Recordset2_data = Recordset2.getObject("NEWDATE"))==null || Recordset2.wasNull())?"":Recordset2_data)%></font></div>
      </td>
    </tr>
    <%
  Repeat1__index++;
  Recordset2_hasData = Recordset2.next();
}
%>
  </table>
  
</div>
</body>
</html>
<%
Recordset2.close();
ConnRecordset2.close();
%>
