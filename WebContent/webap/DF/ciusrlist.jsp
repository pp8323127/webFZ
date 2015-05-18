<%@page contentType="text/html; charset=big5" language="java" import="java.sql.*"%> 
<%@ include file="../Connections/cnORP3DF.jsp" %>
<%
Driver DriverRecordset1 = (Driver)Class.forName(MM_cnORP3DF_DRIVER).newInstance();
Connection ConnRecordset1 = DriverManager.getConnection(MM_cnORP3DF_STRING,MM_cnORP3DF_USERNAME,MM_cnORP3DF_PASSWORD);
PreparedStatement StatementRecordset1 = ConnRecordset1.prepareStatement("SELECT *  FROM DFTCUSR  ORDER BY USERID ASC");
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
<title>Userid and Password list</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<meta http-equiv="pragma" content="no-cache">
</head>
<body bgcolor="#FFFFFF" text="#000000" background="clearday.jpg">
<div align="center"> 
  <p><font face="Comic Sans MS" size="3">Userid and Password list</font></p>
  <table width="75%" border="0">
    <tr bgcolor="#CCCCCC"> 
      <td> 
        <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">UserId</font></b></div>
      </td>
      <td> 
        <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">Password</font></b></div>
      </td>
      <td> 
        <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">UserName</font></b></div>
      </td>
    </tr>
    <% while ((Recordset1_hasData)&&(Repeat1__numRows-- != 0)) { %>
    <tr> 
      <td> 
        <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><A HREF="usrdetail.jsp?<%= MM_keepNone + ((MM_keepNone!="")?"&":"") + "userid=" + (((Recordset1_data = Recordset1.getObject("USERID"))==null || Recordset1.wasNull())?"":Recordset1_data) %>"><%=(((Recordset1_data = Recordset1.getObject("USERID"))==null || Recordset1.wasNull())?"":Recordset1_data)%></A></font></div>
      </td>
      <td> 
        <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Recordset1_data = Recordset1.getObject("PASSWORD"))==null || Recordset1.wasNull())?"":Recordset1_data)%></font></div>
      </td>
      <td> 
        <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Recordset1_data = Recordset1.getObject("USERNAME"))==null || Recordset1.wasNull())?"":Recordset1_data)%></font></div>
      </td>
    </tr>
    <%
  Repeat1__index++;
  Recordset1_hasData = Recordset1.next();
}
%>
  </table>
  <p><a href="addusr.jsp">New User</a></p>
</div>
</body>
</html>
<%
Recordset1.close();
ConnRecordset1.close();
%>

