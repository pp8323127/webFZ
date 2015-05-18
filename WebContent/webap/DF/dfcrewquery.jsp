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
<html>
<head>
<title>
Crew List Query
</title>
<meta http-equiv="pragma" content="no-cache">
</head>

<body background="clearday.jpg">
<table width="80%" border="1" align="center">
  <tr>
    <td>
      <form name="form1" method="post" action="df010_1.jsp">
        <table width="100%" border="0" align="center">
          <tr bgcolor="#CCCCCC"> 
            <td colspan="3"> 
              <div align="center"><font face="Comic Sans MS" color="#0000FF" size="2"><b><font color="#003399">Cockpit 
                Crew List</font></b></font></div>
            </td>
          </tr>
          <tr> 
            <td width="25%"> 
              <div align="left"><font face="Arial, Helvetica, sans-serif" size="2"><b>Fleet</b></font> 
                <select name="fleet">
                  <option value="744">744</option>
                  <option value="742">742</option>
                  <option value="738">738</option>
                  <option value="343">343</option>
                  <option value="AB6">AB6</option>
                  <option value="M11">M11</option>
                  <option value="74F">74F</option>
                </select>
              </div>
            </td>
            <td width="25%"><font face="Arial, Helvetica, sans-serif" size="2"><b>Position</b></font> 
              <select name="position">
                <option value="CA">CA</option>
                <option value="FO">FO</option>
                <option value="FE">FE</option>
              </select>
            </td>
            <td width="10%"> 
              <input type="submit" name="Submit" value="Submit">
            </td>
          </tr>
        </table>
      </form>
    </td>
  </tr>
  <tr>
    <td>
      <form name="form2" method="post" action="df010_2.jsp">
        <div align="center"> 
          <table width="100%" border="0">
            <tr bgcolor="#CCCCCC"> 
              <td colspan="3"> 
                <div align="center"><font face="Comic Sans MS" size="2"><b><font color="#003399">TPE 
                  Cabin Crew List</font></b></font></div>
              </td>
            </tr>
            <tr> 
              <td width="25%"> 
                <div align="left"><font face="Arial, Helvetica, sans-serif" size="2"><b>Group</b></font> 
                  <select name="groups">
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                  </select>
                </div>
              </td>
              <td width="25%"> 
                <p><font face="Arial, Helvetica, sans-serif" size="2"><b>Session</b></font> 
                </p>
                <p><font face="Arial, Helvetica, sans-serif" size="2">From</font> 
                  <select name="session1">
                    <option value="000">000</option>
                    <option value="100">100</option>
                    <option value="150">150</option>
                    <option value="200">200</option>
                    <option value="250">250</option>
                  </select>
                  <font face="Arial, Helvetica, sans-serif" size="2">To</font> 
                  <select name="session2">
                    <option value="099">099</option>
                    <option value="149">149</option>
                    <option value="199">199</option>
                    <option value="249">249</option>
                    <option value="299">299</option>
                  </select>
                </p>
              </td>
              <td width="10%"> 
                <input type="submit" name="Submit2" value="Submit">
              </td>
            </tr>
          </table>
        </div>
      </form>
    </td>
  </tr>
  <tr>
    <td>
      <form name="form3" method="post" action="df010_3.jsp">
        <div align="center"> 
          <table width="100%" border="0">
            <tr bgcolor="#CCCCCC"> 
              <td colspan="3"> 
                <div align="center"><font face="Comic Sans MS" size="2"><b><font color="#003399">KHH/BKK/SIN/TYO 
                  Cabin Crew List</font></b></font></div>
              </td>
            </tr>
            <tr> 
              <td width="25%"> 
                <div align="left"><font face="Arial, Helvetica, sans-serif" size="2"><b>Station</b></font> 
                  <select name="station">
                    <option value="KHH">KHH</option>
                    <option value="BKK">BKK</option>
                    <option value="SIN">SIN</option>
                    <option value="TYO">TYO</option>
                  </select>
                </div>
              </td>
              <td width="25%">&nbsp;</td>
              <td width="10%"> 
                <input type="submit" name="Submit3" value="Submit">
              </td>
            </tr>
          </table>
        </div>
      </form>
    </td>
  </tr>
  <tr>
    <td>
      <form name="form4" method="post" action="df010_4.jsp">
        <table width="100%" border="0" align="center">
          <tr bgcolor="#CCCCCC"> 
            <td colspan="3"> 
              <div align="center"><font face="Comic Sans MS" size="2"><b><font color="#003399">Query 
                by EmpNo</font></b></font></div>
            </td>
          </tr>
          <tr> 
            <td width="25%"> 
              <div align="left"> 
                <p align="left"><font face="Arial, Helvetica, sans-serif" size="2"><b>EmpNo 
                  </b></font> 
                  <input type="text" name="empno">
                </p>
              </div>
            </td>
            <td width="25%">&nbsp;</td>
            <td width="10%"> 
              <input type="submit" name="Submit4" value="Submit">
            </td>
          </tr>
        </table>
      </form>
    </td>
  </tr>
</table>
<p align="center"><font size="3"><a href="adddfcrew.jsp">New Crew Record</a></font></p>
</body>
</html>
