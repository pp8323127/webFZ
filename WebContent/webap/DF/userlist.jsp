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
Driver DriverRecordset2 = (Driver)Class.forName(MM_cnORP3DF_DRIVER).newInstance();
Connection ConnRecordset2 = DriverManager.getConnection(MM_cnORP3DF_STRING,MM_cnORP3DF_USERNAME,MM_cnORP3DF_PASSWORD);
PreparedStatement StatementRecordset2 = ConnRecordset2.prepareStatement("SELECT *  FROM DFTUSGP  ORDER BY USERID ASC");
ResultSet Recordset2 = StatementRecordset2.executeQuery();
boolean Recordset2_isEmpty = !Recordset2.next();
boolean Recordset2_hasData = !Recordset2_isEmpty;
Object Recordset2_data;
int Recordset2_numRows = 0;
%>
<%
Driver DriverRecordset3 = (Driver)Class.forName(MM_cnORP3DF_DRIVER).newInstance();
Connection ConnRecordset3 = DriverManager.getConnection(MM_cnORP3DF_STRING,MM_cnORP3DF_USERNAME,MM_cnORP3DF_PASSWORD);
PreparedStatement StatementRecordset3 = ConnRecordset3.prepareStatement("SELECT *  FROM DFTGRPI  ORDER BY GROUPCD ASC");
ResultSet Recordset3 = StatementRecordset3.executeQuery();
boolean Recordset3_isEmpty = !Recordset3.next();
boolean Recordset3_hasData = !Recordset3_isEmpty;
Object Recordset3_data;
int Recordset3_numRows = 0;
%>
<%
int Repeat1__numRows = -1;
int Repeat1__index = 0;
Recordset1_numRows += Repeat1__numRows;
%>
<%
int Repeat2__numRows = -1;
int Repeat2__index = 0;
Recordset2_numRows += Repeat2__numRows;
%>
<%
int Repeat3__numRows = -1;
int Repeat3__index = 0;
Recordset3_numRows += Repeat3__numRows;
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
// *** Recordset Stats, Move To Record, and Go To Record: declare stats variables

int Recordset2_first = 1;
int Recordset2_last  = 1;
int Recordset2_total = -1;

if (Recordset2_isEmpty) {
  Recordset2_total = Recordset2_first = Recordset2_last = 0;
}

//set the number of rows displayed on this page
if (Recordset2_numRows == 0) {
  Recordset2_numRows = 1;
}
%>
<%
// *** Recordset Stats, Move To Record, and Go To Record: declare stats variables

int Recordset3_first = 1;
int Recordset3_last  = 1;
int Recordset3_total = -1;

if (Recordset3_isEmpty) {
  Recordset3_total = Recordset3_first = Recordset3_last = 0;
}

//set the number of rows displayed on this page
if (Recordset3_numRows == 0) {
  Recordset3_numRows = 1;
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
<%
// *** Recordset Stats: if we don't know the record count, manually count them

if (Recordset2_total == -1) {

  // count the total records by iterating through the recordset
    for (Recordset2_total = 1; Recordset2.next(); Recordset2_total++);

  // reset the cursor to the beginning
  Recordset2.close();
  Recordset2 = StatementRecordset2.executeQuery();
  Recordset2_hasData = Recordset2.next();

  // set the number of rows displayed on this page
  if (Recordset2_numRows < 0 || Recordset2_numRows > Recordset2_total) {
    Recordset2_numRows = Recordset2_total;
  }

  // set the first and last displayed record
  Recordset2_first = Math.min(Recordset2_first, Recordset2_total);
  Recordset2_last  = Math.min(Recordset2_first + Recordset2_numRows - 1, Recordset2_total);
}
%>
<%
// *** Recordset Stats: if we don't know the record count, manually count them

if (Recordset3_total == -1) {

  // count the total records by iterating through the recordset
    for (Recordset3_total = 1; Recordset3.next(); Recordset3_total++);

  // reset the cursor to the beginning
  Recordset3.close();
  Recordset3 = StatementRecordset3.executeQuery();
  Recordset3_hasData = Recordset3.next();

  // set the number of rows displayed on this page
  if (Recordset3_numRows < 0 || Recordset3_numRows > Recordset3_total) {
    Recordset3_numRows = Recordset3_total;
  }

  // set the first and last displayed record
  Recordset3_first = Math.min(Recordset3_first, Recordset3_total);
  Recordset3_last  = Math.min(Recordset3_first + Recordset3_numRows - 1, Recordset3_total);
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
<title>User list</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<meta http-equiv="pragma" content="no-cache">
</head>
<body bgcolor="#FFFFFF" text="#000000" background="clearday.jpg">
<div align="center"> 
  <table width="90%" border="1">
    <tr> 
      <td colspan="2"> 
        <div align="center"><b><font face="Comic Sans MS" size="2" color="#000066">UserId 
          and Password list</font></b></div>
      </td>
      <td colspan="2"> 
        <div align="center"><b><font face="Comic Sans MS" size="2" color="#000066">User 
          Groups list</font></b></div>
      </td>
      <td colspan="2" width="34%"> 
        <div align="center"><b><font face="Comic Sans MS" size="2" color="#000066">Group 
          Items list</font></b></div>
      </td>
    </tr>
    <tr> 
      <td width="17%"><font face="Arial, Helvetica, sans-serif" size="2">total 
        : <%=(Recordset1_total)%></font></td>
      <td width="17%"> 
        <div align="right"><font face="Arial, Helvetica, sans-serif" size="2"><a href="addusr.jsp">new 
          user</a></font></div>
      </td>
      <td width="17%"><font face="Arial, Helvetica, sans-serif" size="2">total 
        : <%=(Recordset2_total)%></font></td>
      <td width="17%"> 
        <div align="right"><font face="Arial, Helvetica, sans-serif" size="2"><a href="addusrgroup.jsp">new 
          usergroup</a></font></div>
      </td>
      <td width="17%"><font face="Arial, Helvetica, sans-serif" size="2">total 
        : <%=(Recordset3_total)%></font></td>
      <td width="17%"> 
        <div align="right"><font face="Arial, Helvetica, sans-serif" size="2"><a href="addgroupitem.jsp">new 
          group</a></font></div>
      </td>
    </tr>
    <tr valign="top"> 
      <td colspan="2"> 
        <table width="100%" border="0">
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
              <div align="center"><font face="Arial, Helvetica, sans-serif" size="2">**********</font></div>
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
      </td>
      <td colspan="2"> 
        <table width="100%" border="0">
          <tr bgcolor="#99CCFF"> 
            <td> 
              <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">UserId</font></b></div>
            </td>
            <td> 
              <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">GroupCd</font></b></div>
            </td>
            <td> 
              <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">Comments</font></b></div>
            </td>
          </tr>
          <% while ((Recordset2_hasData)&&(Repeat2__numRows-- != 0)) { %>
          <tr> 
            <td> 
              <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><A HREF="usrgroupdetail.jsp?<%= MM_keepNone + ((MM_keepNone!="")?"&":"") + "userid=" + (((Recordset2_data = Recordset2.getObject("USERID"))==null || Recordset2.wasNull())?"":Recordset2_data)+"&groupcd=" + (((Recordset2_data = Recordset2.getObject("GROUPCD"))==null || Recordset2.wasNull())?"":Recordset2_data) %>"><%=(((Recordset2_data = Recordset2.getObject("USERID"))==null || Recordset2.wasNull())?"":Recordset2_data)%></A></font></div>
            </td>
            <td> 
              <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Recordset2_data = Recordset2.getObject("GROUPCD"))==null || Recordset2.wasNull())?"":Recordset2_data)%></font></div>
            </td>
            <td> 
              <div align="left"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Recordset2_data = Recordset2.getObject("COMMENTS"))==null || Recordset2.wasNull())?"":Recordset2_data)%></font></div>
            </td>
          </tr>
          <%
  Repeat2__index++;
  Recordset2_hasData = Recordset2.next();
}
%>
        </table>
      </td>
      <td width="34%" colspan="2"> 
        <table width="100%" border="0">
          <tr bgcolor="#CCCCCC"> 
            <td> 
              <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">GroupCd</font></b></div>
            </td>
            <td> 
              <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">GroupName</font></b></div>
            </td>
            <td> 
              <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">Comments</font></b></div>
            </td>
          </tr>
          <% while ((Recordset3_hasData)&&(Repeat3__numRows-- != 0)) { %>
          <tr> 
            <td> 
              <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><A HREF="groupitemdetail.jsp?<%= MM_keepNone + ((MM_keepNone!="")?"&":"") + "groupcd=" + (((Recordset3_data = Recordset3.getObject("GROUPCD"))==null || Recordset3.wasNull())?"":Recordset3_data) %>"><%=(((Recordset3_data = Recordset3.getObject("GROUPCD"))==null || Recordset3.wasNull())?"":Recordset3_data)%></A></font></div>
            </td>
            <td> 
              <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Recordset3_data = Recordset3.getObject("GROUPNAME"))==null || Recordset3.wasNull())?"":Recordset3_data)%></font></div>
            </td>
            <td> 
              <div align="left"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Recordset3_data = Recordset3.getObject("COMMENTS"))==null || Recordset3.wasNull())?"":Recordset3_data)%></font></div>
            </td>
          </tr>
          <%
  Repeat3__index++;
  Recordset3_hasData = Recordset3.next();
}
%>
        </table>
      </td>
    </tr>
  </table>
</div>
</body>
</html>
<%
Recordset1.close();
ConnRecordset1.close();
%>
<%
Recordset2.close();
ConnRecordset2.close();
%>
<%
Recordset3.close();
ConnRecordset3.close();
%>
