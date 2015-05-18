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
<%
String Recordset1__myempno = "310104";
if (request.getParameter("empno")  !=null) {Recordset1__myempno = (String)request.getParameter("empno") ;}
%>
<%
Driver DriverRecordset1 = (Driver)Class.forName(MM_cnORP3DF_DRIVER).newInstance();
Connection ConnRecordset1 = DriverManager.getConnection(MM_cnORP3DF_STRING,MM_cnORP3DF_USERNAME,MM_cnORP3DF_PASSWORD);
PreparedStatement StatementRecordset1 = ConnRecordset1.prepareStatement("SELECT RECTYPE,              YY,              MM,              STAFF_NUM,              FLEET_CD,              CA,              FO,              FE,              INST,              NIGHT,              DUTYIP,              DUTYSF,              DUTYCA,              DUTYFO,              DUTYIFE,              DUTYFE,              TODAY,              TONIT,              LDDAY,              LDNIT,              PIC  FROM DFTCREC  WHERE STAFF_NUM = '" + Recordset1__myempno + "' ORDER BY YY DESC,              MM DESC");
ResultSet Recordset1 = StatementRecordset1.executeQuery();
boolean Recordset1_isEmpty = !Recordset1.next();
boolean Recordset1_hasData = !Recordset1_isEmpty;
Object Recordset1_data;
int Recordset1_numRows = 0;
%>
<%
int Repeat1__numRows = -1;
int Repeat1__index = 0;
Recordset1_numRows += Repeat1__numRows;
%>
<%
// *** Recordset Stats, Move To Record, and Go To Record: declare stats variables

int Recordset1_first = 1;
int Recordset1_last  = 1;
int Recordset1_total = -1;

if (Recordset1_isEmpty) {
  Recordset1_total = Recordset1_first = Recordset1_last = 0;
}

//set the number of rows displayed on this page
if (Recordset1_numRows == 0) {
  Recordset1_numRows = 1;
}
%>
<%
// *** Recordset Stats: if we don't know the record count, manually count them

if (Recordset1_total == -1) {

  // count the total records by iterating through the recordset
    for (Recordset1_total = 1; Recordset1.next(); Recordset1_total++);

  // reset the cursor to the beginning
  Recordset1.close();
  Recordset1 = StatementRecordset1.executeQuery();
  Recordset1_hasData = Recordset1.next();

  // set the number of rows displayed on this page
  if (Recordset1_numRows < 0 || Recordset1_numRows > Recordset1_total) {
    Recordset1_numRows = Recordset1_total;
  }

  // set the first and last displayed record
  Recordset1_first = Math.min(Recordset1_first, Recordset1_total);
  Recordset1_last  = Math.min(Recordset1_first + Recordset1_numRows - 1, Recordset1_total);
}
%>
<% String MM_paramName = ""; %>
<%
// *** Go To Record and Move To Record: create strings for maintaining URL and Form parameters

String MM_keepBoth,MM_keepURL="",MM_keepForm="",MM_keepNone="";
String[] MM_removeList = { "index", MM_paramName };

// create the MM_keepURL string
if (request.getQueryString() != null) {
  MM_keepURL = '&' + request.getQueryString();
  for (int i=0; i < MM_removeList.length && MM_removeList[i].length() != 0; i++) {
  int start = MM_keepURL.indexOf(MM_removeList[i]) - 1;
    if (start >= 0 && MM_keepURL.charAt(start) == '&' &&
        MM_keepURL.charAt(start + MM_removeList[i].length() + 1) == '=') {
      int stop = MM_keepURL.indexOf('&', start + 1);
      if (stop == -1) stop = MM_keepURL.length();
      MM_keepURL = MM_keepURL.substring(0,start) + MM_keepURL.substring(stop);
    }
  }
}

// add the Form variables to the MM_keepForm string
if (request.getParameterNames().hasMoreElements()) {
  java.util.Enumeration items = request.getParameterNames();
  while (items.hasMoreElements()) {
    String nextItem = (String)items.nextElement();
    boolean found = false;
    for (int i=0; !found && i < MM_removeList.length; i++) {
      if (MM_removeList[i].equals(nextItem)) found = true;
    }
    if (!found && MM_keepURL.indexOf('&' + nextItem + '=') == -1) {
      MM_keepForm = MM_keepForm + '&' + nextItem + '=' + java.net.URLEncoder.encode(request.getParameter(nextItem));
    }
  }
}

// create the Form + URL string and remove the intial '&' from each of the strings
MM_keepBoth = MM_keepURL + MM_keepForm;
if (MM_keepBoth.length() > 0) MM_keepBoth = MM_keepBoth.substring(1);
if (MM_keepURL.length() > 0)  MM_keepURL = MM_keepURL.substring(1);
if (MM_keepForm.length() > 0) MM_keepForm = MM_keepForm.substring(1);
%>
<html>
<head>
<title>Crew Record List</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<meta http-equiv="pragma" content="no-cache">
</head>
<body bgcolor="#FFFFFF" text="#000000" background="clearday.jpg">
<p><font face="Comic Sans MS" size="2">Empno : <%=(((Recordset1_data = Recordset1.getObject("STAFF_NUM"))==null || Recordset1.wasNull())?"":Recordset1_data)%></font> </p>
<p><font face="Comic Sans MS" size="2">Record : <%=(Recordset1_total)%></font></p>
<table width="100%" border="1">
  <tr> 
    <td width="6%"> 
      <div align="center"><font face="Arial, Helvetica, sans-serif" size="2">RecType</font></div>
    </td>
    <td width="3%"> 
      <div align="center"><font face="Arial, Helvetica, sans-serif" size="2">Year</font></div>
    </td>
    <td width="4%"> 
      <div align="center"><font face="Arial, Helvetica, sans-serif" size="2">Month</font></div>
    </td>
    <td width="7%"> 
      <div align="center"><font face="Arial, Helvetica, sans-serif" size="2">Fleet_cd</font></div>
    </td>
    <td width="8%"> 
      <div align="center"><font face="Arial, Helvetica, sans-serif" size="2">CA</font></div>
    </td>
    <td width="0%"> 
      <div align="center"><font face="Arial, Helvetica, sans-serif" size="2">FO</font></div>
    </td>
    <td width="2%"> 
      <div align="center"><font face="Arial, Helvetica, sans-serif" size="2">FE</font></div>
    </td>
    <td width="1%"> 
      <div align="center"><font face="Arial, Helvetica, sans-serif" size="2">Inst</font></div>
    </td>
    <td width="2%"> 
      <div align="center"><font face="Arial, Helvetica, sans-serif" size="2">Night</font></div>
    </td>
    <td width="3%"> 
      <div align="center"><font face="Arial, Helvetica, sans-serif" size="2">DutyIP</font></div>
    </td>
    <td width="4%"> 
      <div align="center"><font face="Arial, Helvetica, sans-serif" size="2">DutySF</font></div>
    </td>
    <td width="5%"> 
      <div align="center"><font face="Arial, Helvetica, sans-serif" size="2">DutyCA</font></div>
    </td>
    <td width="5%"> 
      <div align="center"><font face="Arial, Helvetica, sans-serif" size="2">DutyFO</font></div>
    </td>
    <td width="5%"> 
      <div align="center"><font face="Arial, Helvetica, sans-serif" size="2">DutyIFE</font></div>
    </td>
    <td width="5%"> 
      <div align="center"><font face="Arial, Helvetica, sans-serif" size="2">DutyFE</font></div>
    </td>
    <td width="5%"> 
      <div align="center"><font face="Arial, Helvetica, sans-serif" size="2">ToDay</font></div>
    </td>
    <td width="4%"> 
      <div align="center"><font face="Arial, Helvetica, sans-serif" size="2">ToNit</font></div>
    </td>
    <td width="4%"> 
      <div align="center"><font face="Arial, Helvetica, sans-serif" size="2">LdDay</font></div>
    </td>
    <td width="4%"> 
      <div align="center"><font face="Arial, Helvetica, sans-serif" size="2">LdNit</font></div>
    </td>
    <td width="23%"> 
      <div align="center"><font face="Arial, Helvetica, sans-serif" size="2">PIC</font></div>
    </td>
  </tr>
  <% while ((Recordset1_hasData)&&(Repeat1__numRows-- != 0)) { %>
  <tr> 
    <td width="5%"> 
      <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Recordset1_data = Recordset1.getObject("RECTYPE"))==null || Recordset1.wasNull())?"":Recordset1_data)%></font></div>
    </td>
    <td width="5%"> 
      <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Recordset1_data = Recordset1.getObject("YY"))==null || Recordset1.wasNull())?"":Recordset1_data)%></font></div>
    </td>
    <td width="5%"> 
    <%
    if (!session.getAttribute("cs55.auth").equals("R"))
    {
    %>  
      <div align="center"><font face="Arial, Helvetica, sans-serif" size="2">
      <A HREF="crewrecdetail.jsp?<%= MM_keepBoth + ((MM_keepBoth!="")?"&":"") + "rectype=" + (((Recordset1_data = Recordset1.getObject("RECTYPE"))==null || Recordset1.wasNull())?"&":Recordset1_data)+"&fleet=" + (((Recordset1_data = Recordset1.getObject("FLEET_CD"))==null || Recordset1.wasNull())?"&":Recordset1_data)+"&mm="+(((Recordset1_data = Recordset1.getObject("MM"))==null || Recordset1.wasNull())?"":Recordset1_data)+"&yy="+(((Recordset1_data = Recordset1.getObject("YY"))==null || Recordset1.wasNull())?"":Recordset1_data)%>">
      <%=(((Recordset1_data = Recordset1.getObject("MM"))==null || Recordset1.wasNull())?"":Recordset1_data)%></A></font></div>
    <%
    }
    else
    {
    %>
      <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Recordset1_data = Recordset1.getObject("MM"))==null || Recordset1.wasNull())?"":Recordset1_data)%></font></div>
    <%
    }
    %>
    </td>
    <td width="5%"> 
      <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Recordset1_data = Recordset1.getObject("FLEET_CD"))==null || Recordset1.wasNull())?"":Recordset1_data)%></font></div>
    </td>
    <td width="5%"> 
      <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Recordset1_data = Recordset1.getObject("CA"))==null || Recordset1.wasNull())?"":Recordset1_data)%></font></div>
    </td>
    <td width="5%"> 
      <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Recordset1_data = Recordset1.getObject("FO"))==null || Recordset1.wasNull())?"":Recordset1_data)%></font></div>
    </td>
    <td width="5%"> 
      <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Recordset1_data = Recordset1.getObject("FE"))==null || Recordset1.wasNull())?"":Recordset1_data)%></font></div>
    </td>
    <td width="5%"> 
      <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Recordset1_data = Recordset1.getObject("INST"))==null || Recordset1.wasNull())?"":Recordset1_data)%></font></div>
    </td>
    <td width="5%"> 
      <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Recordset1_data = Recordset1.getObject("NIGHT"))==null || Recordset1.wasNull())?"":Recordset1_data)%></font></div>
    </td>
    <td width="5%"> 
      <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Recordset1_data = Recordset1.getObject("DUTYIP"))==null || Recordset1.wasNull())?"":Recordset1_data)%></font></div>
    </td>
    <td width="5%"> 
      <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Recordset1_data = Recordset1.getObject("DUTYSF"))==null || Recordset1.wasNull())?"":Recordset1_data)%></font></div>
    </td>
    <td width="5%"> 
      <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Recordset1_data = Recordset1.getObject("DUTYCA"))==null || Recordset1.wasNull())?"":Recordset1_data)%></font></div>
    </td>
    <td width="5%"> 
      <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Recordset1_data = Recordset1.getObject("DUTYFO"))==null || Recordset1.wasNull())?"":Recordset1_data)%></font></div>
    </td>
    <td width="5%"> 
      <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Recordset1_data = Recordset1.getObject("DUTYIFE"))==null || Recordset1.wasNull())?"":Recordset1_data)%></font></div>
    </td>
    <td width="5%"> 
      <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Recordset1_data = Recordset1.getObject("DUTYFE"))==null || Recordset1.wasNull())?"":Recordset1_data)%></font></div>
    </td>
    <td width="5%"> 
      <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Recordset1_data = Recordset1.getObject("TODAY"))==null || Recordset1.wasNull())?"":Recordset1_data)%></font></div>
    </td>
    <td width="5%"> 
      <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Recordset1_data = Recordset1.getObject("TONIT"))==null || Recordset1.wasNull())?"":Recordset1_data)%></font></div>
    </td>
    <td width="5%"> 
      <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Recordset1_data = Recordset1.getObject("LDDAY"))==null || Recordset1.wasNull())?"":Recordset1_data)%></font></div>
    </td>
    <td width="5%"> 
      <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Recordset1_data = Recordset1.getObject("LDNIT"))==null || Recordset1.wasNull())?"":Recordset1_data)%></font></div>
    </td>
    <td width="5%"> 
      <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Recordset1_data = Recordset1.getObject("PIC"))==null || Recordset1.wasNull())?"":Recordset1_data)%></font></div>
    </td>
  </tr>
  <%
  Repeat1__index++;
  Recordset1_hasData = Recordset1.next();
}
%>
</table>
<p>&nbsp; </p>
</body>
</html>
<%
Recordset1.close();
ConnRecordset1.close();
%>

