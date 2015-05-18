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
<title>Show flt</title>
<link href="style2.css" rel="stylesheet" type="text/css">
<script language="JavaScript"  src="Auth.js" type="text/JavaScript"></script>

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

String Empnosql = "select a.empno empno FROM "+ct.getTable()+" a, fztcrew b,egtcbas eg "+
			" where a.empno=b.empno and a.empno=Trim(eg.empn) and a.dpt='TPE' and b.occu in('FA','FS','PR') "+
			" and a.fdate='"+requestFdate+"' and trim(a.dutycode)='"+requestFltno+"' "+
			" order by b.occu desc,a.empno";
//out.print(Empnosql);

Driver dbDriver = null;
Connection conn = null;
Statement stmt = null;
ResultSet myResultSet = null;
boolean t = false;
int xCount=0;
String bcolor=null;

ArrayList allEmpnoList = new ArrayList();

try{

dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
conn = dbDriver.connect("jdbc:weblogic:pool:CAL.FZCP02", null);
stmt = conn.createStatement();
myResultSet = stmt.executeQuery(Empnosql);
  if(myResultSet!= null){
  	while( myResultSet.next()){
		allEmpnoList.add(myResultSet.getString("empno"));
	}
  }
myResultSet.close();

String empnoList = null;	
	for(int i=0; i< allEmpnoList.size();i++){
		if(i==0){
			empnoList="'"+allEmpnoList.get(0)+"'";
		}
		else{
			empnoList = empnoList+",'"+allEmpnoList.get(i)+"'";
		}
	}
//	out.print("empnoList = <br>"+empnoList+"<HR>");
myResultSet = stmt.executeQuery(sql);

%>
</p>
<form action="Show1FltAE.jsp?requestFdate=<%=requestFdate%>&requestFltno=<%=requestFltno%>&showMakeFile=Y&empnoList=<%=empnoList%>" method="post" name="form1" target="_self" onSubmit="return del()">
<table width="90%"  border="0" align="center" cellpadding="2" cellspacing="0" class="fortable">
  <tr class="tablehead3">
    <td width="13%">
      <div align="center">Date(Taipei)</div>
    </td>
    <td width="10%">
      <div align="center">Flt</div>
    </td>
    <td width="15%">
      <div align="center">Crew</div>
    </td>
    <td width="16%">Empno</td>
    <td width="11%">
      <div align="center">Occu</div>
    </td>
    <td width="18%">
      <div align="center">MobilPhone</div>
    </td>
    <td width="17%">Delete</td>
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
    <td   class="tablebody"><%=fdate%></td>
    <td class="tablebody"><%=fltno%></td>
    <td class="tablebody"><%=crewName%></td>
    <td class="tablebody"><%=empno%></td>
    <td class="tablebody"><%=occu%></td>
    <td class="tablebody">&nbsp;<%=smsphone%></td>
    <td class="tablebody"> <input name="delEmpno" type="checkbox"  value="<%=empno%>">  </td>
  </tr>
  <%
  		}
	}
  
  %>
</table>
<table width="90%"  border="0" align="center" cellpadding="2" cellspacing="0" >
<tr>
	<td colspan="3">
	  <div align="center">
	    <input type="submit" value="Delete" class="delButon">
	    <br>
	    </div>
	</td>
</tr>
<tr>
  <td width="29%">&nbsp;</td>
  <td width="49%">
    <p class="txtxred">���G�s�@������X�ɮ׮ɡA�t�η|�۰ʱư��L������X�A<br>
  �ΫD�ꤺ������X���L�k�ǰe���p�A���ݦۦ�R���C</p>
    </td>
  <td width="22%">&nbsp;</td>
</tr>
</table>
</form>
<table width="90%"  border="0" align="center" cellpadding="2" cellspacing="0" >
  <tr >
    <td class="txtblue" >
      <p>Total�G<%=xCount%></p>
    </td>
  </tr>
  <tr >
    <td class="txtblue" >
	<form name="form2" action="Show1FltAEAdd.jsp?requestFdate=<%=requestFdate%>&requestFltno=<%=requestFltno%>&showMakeFile=Y&empnoList=<%=empnoList%>" method="post" target="_self" onSubmit="return checkEmpno()">
	  �s�W�խ��A�п�J���u���]Add Empno�^�G
	    <input type="text" name="addEmpno" size="6" maxlength="6">
	  <input name="addEmpSubmit" type="submit" value="Add">
	</form>
	</td>
  </tr>
  
  <%
if(showMakeFile.equals("Y")){
%>
  <tr >
    <td class="txtblue" >
      <form name="form3" method="post" action="SMSMakeFile.jsp?fdate=<%=requestFdate%>&fltno=<%=requestFltno%>&db=<%=ct.getTable()%>&empnoList=<%=empnoList%>">
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
         <div align="center">
          <input type="button" name="closeWindow" value="Close" onClick="self.close()" >
        </div>
      
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
	<jsp:param name="messagestring" value="<p style='font-size:10pt;color:#0066FF'>�d�L��ơA�i�ର�L����Z�A�Φ���Z�L�῵�խ�<BR>���t�ζȵo�e²�T�῵�խ�</p>"/>
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
	<jsp:param name="messagestring" value="<p style='font-size:10pt;color:#0066FF'>���t�ζȵo�e²�T�ܫ῵�խ�</p>"/>
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
