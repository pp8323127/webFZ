<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,fz.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%

String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
/*response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);*/

if (session.isNew() || sGetUsr == null) 
{		//check user session start first
  %> <jsp:forward page="sendredirect.jsp" /> <%
} 

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Show Flight Crew(No Edit)</title>
<link href="../menu.css" rel="stylesheet" type="text/css">
</head>

<body>
<p>
  <%
//************************************Get live sche table
ctlTable ct = new ctlTable();
ct.doSet();
//*************************************
String y = request.getParameter("yy");
String m = request.getParameter("mm");
String d = request.getParameter("dd");
String requestFdate = y+"/"+m+"/"+d;
String requestFltno = request.getParameter("fltno").trim();
String showMakeFile = request.getParameter("showMakeFile");


String fdate 	= null;
String fltno 	= null;
String crewName = null;
String empno 	= null;
String occu 	= null;
String smsphone	= null;


String sql = "select a.empno empno,b.NAME cname, a.dutycode fltno,a.fdate,"+
			" b.occu occu, eg.smsphone "+
			" FROM "+ct.getTable()+" a, fztcrew b,egtcbas eg "+
			" where a.empno=b.empno and a.empno=Trim(eg.empn) and a.dpt='TPE' and b.occu in('FA','FS','PR') "+
			" and a.fdate='"+requestFdate+"' and trim(a.dutycode)='"+requestFltno+"' "+
			" order by b.occu desc,a.empno";
//out.print(sql);

Driver dbDriver = null;
Connection conn = null;
Statement stmt = null;
ResultSet myResultSet = null;
boolean t = false;
int xCount=0;
String bcolor=null;

try{

dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
conn = dbDriver.connect("jdbc:weblogic:pool:CAL.FZCP02", null);
stmt = conn.createStatement();
myResultSet = stmt.executeQuery(sql);

%>
</p>
<div align="center" class="txtblue">組員名單
</div>
<table width="90%"  border="0" align="center" cellpadding="2" cellspacing="0" class="fortable">
  <tr class="tablehead3">
    <td width="11%">
      <div align="center">Date</div>
    </td>
    <td width="10%">
      <div align="center">Flt</div>
    </td>
    <td width="17%">
      <div align="center">Crew</div>
    </td>
    <td width="18%">Empno</td>
    <td width="11%">
      <div align="center">Occu</div>
    </td>
    <td width="33%">
      <div align="center">MobilPhone</div>
    </td>
  </tr>
  <%
  if(myResultSet!= null){
  	while(myResultSet.next()){
		fdate 	= myResultSet.getString("fdate");
		fltno 	= myResultSet.getString("fltno");
		crewName = myResultSet.getString("cname");
		empno 	= myResultSet.getString("empno");
		occu 	= myResultSet.getString("occu");
		smsphone	= myResultSet.getString("smsphone");
	
	xCount++;	
		if (xCount%2 == 0){
			bcolor = "#99CCFF";
		}
		else{
			bcolor = "#FFFFFF";
		}
  
  %>
  <tr bgcolor="<%=bcolor%>">
    <td class="tablebody"><%=fdate%></td>
    <td class="tablebody"><%=fltno%></td>
    <td class="tablebody"><%=crewName%></td>
    <td class="tablebody"><%=empno%></td>
    <td class="tablebody"><%=occu%></td>
    <td class="tablebody">&nbsp;<%=smsphone%></td>
  </tr>
  <%
  		}
	}
  
  %>
</table>

<table width="90%"  border="0" align="center" cellpadding="2" cellspacing="0" >
  <tr >
    <td class="txtblue" >Total：<%=xCount%></td>
  </tr>
  
  <%
if(showMakeFile.equals("Y")){
%>
  <tr >
    <td class="txtblue" >
      <form name="form1" method="post" action="SMSMakeFile.jsp?fdate=<%=requestFdate%>&fltno=<%=requestFltno%>&db=<%=ct.getTable()%>">
        <div align="center">
          <input type="submit" name="Submit" value="Make File" >
        </div>
      </form>
    </td>
  </tr>
 <%
}
else{

%>   <tr >
    <td class="txtblue" >
      <div align="center">           <input type="button" name="closeWindow" value="Close" onClick="self.close()" >
           <br>
        <span class="txtxred">註：此處不提供修改單一航班組員名單， 若欲更動，請<br>
        取消此航班，另行於輸入Fltno後顯示的組員名單中增刪。</span> </div>
      
    </td>
  </tr>
  <%
}
%>
</table>
</body>
</html>
<%

if(xCount ==0 && showMakeFile.equals("Y")){
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}

%>
	<jsp:forward page="../showmessage.jsp">
	<jsp:param name="messagestring" value="<p style='font-size:10pt;color:#0066FF'>查無資料，可能為無此航班，或此航班無後艙組員<BR>本系統僅發送簡訊後艙組員</p>"/>
	<jsp:param name="messagelink" value="<p style='font-size:10pt;color:FF0000'>BACK</p>" />
	<jsp:param name="linkto" value="javascript:history.back(-1)"/>
	</jsp:forward>

<%

}
else if(xCount ==0 && showMakeFile.equals("N")){
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
%>
	<jsp:forward page="../showmessage.jsp">
	<jsp:param name="messagestring" value="<p style='font-size:10pt;color:#0066FF'>本系統僅發送簡訊至後艙組員</p>"/>
	<jsp:param name="messagelink" value="<p style='font-size:10pt;color:FF0000'>Close</p>" />
	<jsp:param name="linkto" value="javascript:self.close()"/>
	</jsp:forward>
<%

}
}
catch (Exception e)
{
	  t = true;
	  out.print(e.toString());
}
finally
{
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}

%>
