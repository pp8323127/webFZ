<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,fz.*,java.util.ArrayList" errorPage="" %>
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

Driver dbDriver = null;
Connection conn = null;
Statement stmt = null;
ResultSet myResultSet = null;
boolean t = false;
int xCount=0;
String bcolor=null;
try{

String crewName = null;
String empno 	= null;
String occu 	= null;
String smsphone	= null;

//************************************Get live sche table
ctlTable ct = new ctlTable();
ct.doSet();
//*************************************


String requestFdate = request.getParameter("requestFdate");
String requestFltno = request.getParameter("requestFltno");
String showMakeFile = request.getParameter("showMakeFile");
String empnoList = request.getParameter("empnoList").trim();
//out.print(empnoList);
//String addEmpno = request.getParameter("addEmpno");
String [] delEmpno = request.getParameterValues("delEmpno");

if(delEmpno == null ){
%>
	<jsp:forward page="../showmessage.jsp">
	<jsp:param name="messagestring" value="<p style='font-size:10pt;color:#0066FF'>Error!!<br>尚未選擇要刪除何筆資料<br></p>" />
	<jsp:param name="messagelink" value="<p style='font-size:10pt;color:FF0000'>BACK</p>" />
	<jsp:param name="linkto" value="javascript:history.back(-1)"/>
	</jsp:forward>
<%
}



//將選取要取消的empno，存入ArrayList : delEmpnoLisy 
ArrayList delEmpnoList = new ArrayList();
for(int i=0; i<delEmpno.length;i++){
	delEmpnoList.add(delEmpno[i]);
}



//由傳遞的參數empnoList，取得目前empno名單，存入ArrayList : allEmpnoList
//empnoList format:'######','######'
ArrayList allEmpnoList = new ArrayList();

		for (int i = 0; i < empnoList.length();  i=i+9) {
			allEmpnoList.add(empnoList.substring(i+1,i+7));
				
		}


//將allEmpnoList中，符合delEmpnoList的刪除
//以delEmpnoList為外層迴圈，尋找allEmpnoList中符合的項目，否則會出現Exception
for(int j=0;j<delEmpnoList.size();j++){
	for(int i=0; i< allEmpnoList.size();i++){
		if( allEmpnoList.get(i).equals(delEmpnoList.get(j)) ){
			allEmpnoList.remove(i);
			//out.print("remove "+delEmpnoList.get(j) );
		}
	}
}



String empnoListNew = null;	//經過刪除後的名單
for(int i=0; i< allEmpnoList.size();i++){
	if(i==0){
		empnoListNew="'"+allEmpnoList.get(0)+"'";
	}
	else{
		empnoListNew = empnoListNew+",'"+allEmpnoList.get(i)+"'";
	}
}

String EmpnoSql = "select c.empno empno,c.name cname,c.ename ename,c.occu occu,eg.smsphone smsphone "+
				"from fztcrew c,egtcbas eg "+
				"where c.empno = Trim(eg.empn) "+
				"and c.empno in("+empnoListNew+") "+
				"order by c.occu desc,c.empno";


dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
conn = dbDriver.connect("jdbc:weblogic:pool:CAL.FZCP02", null);
stmt = conn.createStatement();
				
myResultSet = stmt.executeQuery(EmpnoSql);
%>
</p>
<div align="center" class="txtxred">確認名單
</div>
<form action="Show1FltAE.jsp?requestFdate=<%=requestFdate%>&requestFltno=<%=requestFltno%>&showMakeFile=Y&empnoList=<%=empnoListNew%>" method="post" name="form1" target="_self" onSubmit="return del()">
<table width="90%"  border="0" align="center" cellpadding="2" cellspacing="0" class="fortable">
  <tr class="tablehead3">
    <td width="11%">
      <div align="center">Date(Taipei)</div>
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
    <td width="22%">
      <div align="center">MobilPhone</div>
    </td>
    <td width="11%">Delete</td>
  </tr>
  <%
  if(myResultSet!= null){
  	while(myResultSet.next()){
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
    <td class="tablebody"><%=requestFdate%></td>
    <td class="tablebody"><%=requestFltno%></td>
    <td class="tablebody"><%=crewName%></td>
    <td class="tablebody"><%=empno%></td>
    <td class="tablebody"><%=occu%></td>
    <td class="tablebody">&nbsp;<%=smsphone%></td>
    <td class="tablebody"> <input name="delEmpno" type="checkbox"  value="<%=empno%>"></td>
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
    <p class="txtxred">註：製作手機號碼檔案時，系統會自動排除無手機號碼，<br>
  或非國內手機號碼等無法傳送情況，不需自行刪除。</p>
    </td>
  <td width="22%">&nbsp;</td>
</tr>
</table>
</form>
<table width="90%"  border="0" align="center" cellpadding="2" cellspacing="0" >
  <tr >
    <td class="txtblue" >Total：<%=xCount%></td>
  </tr>
  <tr>
	  <td>
<form name="form2" action="Show1FltAEAdd.jsp?requestFdate=<%=requestFdate%>&requestFltno=<%=requestFltno%>&showMakeFile=Y&empnoList=<%=empnoListNew%>" method="post" target="_self" onSubmit="return checkEmpno()">
	    <span class="txtblue">新增組員，請輸入員工號（Add Empno）：</span>	    
	    <input type="text" name="addEmpno" size="6" maxlength="6">
	  <input type="submit" name="addEmpSubmit" value="Add">
	</form>	  
	  </td>
  </tr>
  <%
if(showMakeFile.equals("Y")){
%>
  <tr >
    <td class="txtblue" >
      <form name="form3" method="post" action="SMSMakeFile.jsp?fdate=<%=requestFdate%>&fltno=<%=requestFltno%>&db=<%=ct.getTable()%>&empnoList=<%=empnoListNew%>">
        <div align="center">
          <input type="submit" name="Submit" value="Make File" >&nbsp;&nbsp;&nbsp;&nbsp;
		  <input type="button" name="back" value="重新選擇" onClick="javascript:history.back(-1)">
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


<p>&nbsp;</p>
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
