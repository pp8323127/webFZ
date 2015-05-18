<%@page contentType="text/html; charset=big5" language="java" import="java.sql.*"%> 
<%@ include file="../Connections/cnORP3DF.jsp" %>
<%
Driver DriverRecordset1 = (Driver)Class.forName(MM_cnORP3DF_DRIVER).newInstance();
Connection ConnRecordset1 = DriverManager.getConnection(MM_cnORP3DF_STRING,MM_cnORP3DF_USERNAME,MM_cnORP3DF_PASSWORD);
PreparedStatement StatementRecordset1 = ConnRecordset1.prepareStatement("SELECT *  FROM DFTPAGI  ORDER BY PAGEID ASC");
ResultSet Recordset1 = StatementRecordset1.executeQuery();
boolean Recordset1_isEmpty = !Recordset1.next();
boolean Recordset1_hasData = !Recordset1_isEmpty;
Object Recordset1_data;
int Recordset1_numRows = 0;
%>
<%
int Repeat1__numRows = 15;
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
// *** Move To Record and Go To Record: declare variables

ResultSet MM_rs = Recordset1;
int       MM_rsCount = Recordset1_total;
int       MM_size = Recordset1_numRows;
String    MM_uniqueCol = "";
          MM_paramName = "";
int       MM_offset = 0;
boolean   MM_atTotal = false;
boolean   MM_paramIsDefined = (MM_paramName.length() != 0 && request.getParameter(MM_paramName) != null);
%>
<%
// *** Move To Record: handle 'index' or 'offset' parameter

if (!MM_paramIsDefined && MM_rsCount != 0) {

  //use index parameter if defined, otherwise use offset parameter
  String r = request.getParameter("index");
  if (r==null) r = request.getParameter("offset");
  if (r!=null) MM_offset = Integer.parseInt(r);

  // if we have a record count, check if we are past the end of the recordset
  if (MM_rsCount != -1) {
    if (MM_offset >= MM_rsCount || MM_offset == -1) {  // past end or move last
      if (MM_rsCount % MM_size != 0)    // last page not a full repeat region
        MM_offset = MM_rsCount - MM_rsCount % MM_size;
      else
        MM_offset = MM_rsCount - MM_size;
    }
  }

  //move the cursor to the selected record
  int i;
  for (i=0; Recordset1_hasData && (i < MM_offset || MM_offset == -1); i++) {
    Recordset1_hasData = MM_rs.next();
  }
  if (!Recordset1_hasData) MM_offset = i;  // set MM_offset to the last possible record
}
%>
<%
// *** Move To Record: if we dont know the record count, check the display range

if (MM_rsCount == -1) {

  // walk to the end of the display range for this page
  int i;
  for (i=MM_offset; Recordset1_hasData && (MM_size < 0 || i < MM_offset + MM_size); i++) {
    Recordset1_hasData = MM_rs.next();
  }

  // if we walked off the end of the recordset, set MM_rsCount and MM_size
  if (!Recordset1_hasData) {
    MM_rsCount = i;
    if (MM_size < 0 || MM_size > MM_rsCount) MM_size = MM_rsCount;
  }

  // if we walked off the end, set the offset based on page size
  if (!Recordset1_hasData && !MM_paramIsDefined) {
    if (MM_offset > MM_rsCount - MM_size || MM_offset == -1) { //check if past end or last
      if (MM_rsCount % MM_size != 0)  //last page has less records than MM_size
        MM_offset = MM_rsCount - MM_rsCount % MM_size;
      else
        MM_offset = MM_rsCount - MM_size;
    }
  }

  // reset the cursor to the beginning
  Recordset1.close();
  Recordset1 = StatementRecordset1.executeQuery();
  Recordset1_hasData = Recordset1.next();
  MM_rs = Recordset1;

  // move the cursor to the selected record
  for (i=0; Recordset1_hasData && i < MM_offset; i++) {
    Recordset1_hasData = MM_rs.next();
  }
}
%>
<%
// *** Move To Record: update recordset stats

// set the first and last displayed record
Recordset1_first = MM_offset + 1;
Recordset1_last  = MM_offset + MM_size;
if (MM_rsCount != -1) {
  Recordset1_first = Math.min(Recordset1_first, MM_rsCount);
  Recordset1_last  = Math.min(Recordset1_last, MM_rsCount);
}

// set the boolean used by hide region to check if we are on the last record
MM_atTotal  = (MM_rsCount != -1 && MM_offset + MM_size >= MM_rsCount);
%>
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
<%
// *** Move To Record: set the strings for the first, last, next, and previous links

String MM_moveFirst,MM_moveLast,MM_moveNext,MM_movePrev;
{
  String MM_keepMove = MM_keepBoth;  // keep both Form and URL parameters for moves
  String MM_moveParam = "index=";

  // if the page has a repeated region, remove 'offset' from the maintained parameters
  if (MM_size > 1) {
    MM_moveParam = "offset=";
    int start = MM_keepMove.indexOf(MM_moveParam);
    if (start != -1 && (start == 0 || MM_keepMove.charAt(start-1) == '&')) {
      int stop = MM_keepMove.indexOf('&', start);
      if (start == 0 && stop != -1) stop++;
      if (stop == -1) stop = MM_keepMove.length();
      if (start > 0) start--;
      MM_keepMove = MM_keepMove.substring(0,start) + MM_keepMove.substring(stop);
    }
  }

  // set the strings for the move to links
  StringBuffer urlStr = new StringBuffer(request.getRequestURI()).append('?').append(MM_keepMove);
  if (MM_keepMove.length() > 0) urlStr.append('&');
  urlStr.append(MM_moveParam);
  MM_moveFirst = urlStr + "0";
  MM_moveLast  = urlStr + "-1";
  MM_moveNext  = urlStr + Integer.toString(MM_offset+MM_size);
  MM_movePrev  = urlStr + Integer.toString(Math.max(MM_offset-MM_size,0));
}
%>
<html>
<head>
<title>Page Item List</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<meta http-equiv="pragma" content="no-cache">
</head>
<body bgcolor="#FFFFFF" text="#000000" background="clearday.jpg">
<div align="center"> 
  <p><font face="Comic Sans MS" color="#333333">Page Item List </font></p>
  <table width="75%" border="0">
    <tr> 
      <td><font face="Arial, Helvetica, sans-serif" size="2">Total : <%=(Recordset1_total)%></font></td>
      <td> 
        <div align="right"><font face="Arial, Helvetica, sans-serif" size="2"><%=(Recordset1_first)%>/<%=(Recordset1_last)%></font></div>
      </td>
    </tr>
  </table>
  <table width="75%" border="0">
    <tr bgcolor="#CCCCCC"> 
      <td> 
        <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">PageId</font></b></div>
      </td>
      <td> 
        <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">PageName</font></b></div>
      </td>
      <td> 
        <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">Comments</font></b></div>
      </td>
    </tr>
    <% while ((Recordset1_hasData)&&(Repeat1__numRows-- != 0)) { %>
    <tr> 
      <td> 
        <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><A HREF="pageitemdetail.jsp?<%= MM_keepNone + ((MM_keepNone!="")?"&":"") + "pageid=" + (((Recordset1_data = Recordset1.getObject("PAGEID"))==null || Recordset1.wasNull())?"":Recordset1_data) %>"><%=(((Recordset1_data = Recordset1.getObject("PAGEID"))==null || Recordset1.wasNull())?"":Recordset1_data)%></A></font></div>
      </td>
      <td> 
        <div align="left"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Recordset1_data = Recordset1.getObject("PAGENAME"))==null || Recordset1.wasNull())?"":Recordset1_data)%></font></div>
      </td>
      <td> 
        <div align="left"><font face="Arial, Helvetica, sans-serif" size="2"><%=(((Recordset1_data = Recordset1.getObject("COMMENTS"))==null || Recordset1.wasNull())?"":Recordset1_data)%></font></div>
      </td>
    </tr>
    <%
  Repeat1__index++;
  Recordset1_hasData = Recordset1.next();
}
%>
  </table>
  <p>&nbsp;<A HREF="<%=MM_movePrev%>">Previous</A>/<A HREF="<%=MM_moveNext%>">Next</A></p>
  <p><a href="addpageitem.jsp">New PageItem</a></p>
</div>
</body>
</html>
<%
Recordset1.close();
ConnRecordset1.close();
%>
