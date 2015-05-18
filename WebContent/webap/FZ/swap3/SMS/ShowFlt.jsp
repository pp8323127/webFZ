<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*,fz.*,java.util.ArrayList"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
//顯示當日全部航班，可刪除航班
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
<script src="../js/subWindow.js" language="javascript" type="text/javascript"></script>
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


String fdate 	= null;
String fltno 	= null;
String dpt		= null;
String arv 		= null;
String btime 	= null;
String etime 	= null;


String sql = "select DISTINCT fdate, dutycode fltno, dpt, arv,btime,etime FROM "+ct.getTable()+
			 " where dpt='TPE' AND fdate='"+requestFdate+"' "+
			 " AND substr(trim(dutycode),1,1) in ('0','1','2','3','4','5','6','7','8','9','S') "+
			 " ORDER BY fdate,btime,dutycode";
//out.print(sql);


Driver dbDriver = null;
Connection conn = null;
Statement stmt = null;
ResultSet myResultSet = null;
boolean t = false;
int xCount=0;
String bcolor=null;
ArrayList fltnoList = new ArrayList();//將fltno存入ArrayList


try{

dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
conn = dbDriver.connect("jdbc:weblogic:pool:CAL.FZCP02", null);
stmt = conn.createStatement();
myResultSet = stmt.executeQuery(sql);

%>
</p>
<table width="80%"  border="0" align="center" cellpadding="2" cellspacing="0"  >
  <tr >
    <td class="txtblue" >
      <form name="form1" method="post" action="SMSMakeFileAllFltno.jsp?fdate=<%=requestFdate%>">
        <div align="center"> 
         <input type="submit" name="Submit" value="Make File"  class="btm" >
        </div>
      </form>
    </td>
  </tr>
</table>
<form name="form2" action="ShowFltAE.jsp?requestFdate=<%=requestFdate%>" target="_self" method="post" onSubmit="return del()">
<table width="80%"  border="0" align="center" cellpadding="2" cellspacing="0" class="fortable">
  <tr class="tablehead3">
    <td width="17%">
      <div align="center">Date(Taipei)</div>
    </td>
    <td width="10%">
      <div align="center">Flt</div>
    </td>
    <td width="11%">Dpt</td>
    <td width="14%">Arv</td>
    <td width="15%">BTime</td>
    <td width="15%">ETime</td>
    <td width="9%">
      <div align="center">Crew</div>
    </td>
    <td width="9%">Delete</td>
  </tr>
    <%
  if(myResultSet!= null){
  	while(myResultSet.next()){
		fdate 	= myResultSet.getString("fdate");
		fltno 	= myResultSet.getString("fltno");

		fltnoList.add(fltno);

		dpt		= myResultSet.getString("dpt");
		arv 	= myResultSet.getString("arv");
		btime 	= myResultSet.getString("btime");
		etime 	= myResultSet.getString("etime");
		
		
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
    <td class="tablebody"><%=dpt%></td>
    <td class="tablebody"><%=arv%></td>
    <td class="tablebody"><%=btime%></td>
    <td class="tablebody"><%=etime%></td>
    <td class="tablebody"><a href="#" onClick="subwinXY('Show1FltNoMake.jsp?yy=<%=y%>&mm=<%=m%>&dd=<%=d%>&fltno=<%=fltno%>&showMakeFile=N','showFlt','750','500')" ><img src="../images/userlist.gif" border="0"></a></td>
    <td class="tablebody"><input type="checkbox" name="delFltno" value="<%=fltno%>"> </td>
  </tr>
  <%
  		}
	}
   %>
</table>
<table width="80%"  border="0" align="center" cellpadding="2" cellspacing="0" >
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
    <p class="txtxred">註：此處不提供修改單一航班組員名單， 若欲更動，請<br>
取消此航班，另行於輸入Fltno後顯示的組員名單中增刪。</p>
    </td>
  <td width="22%">&nbsp;</td>
</tr>
</table>
</form>
<table width="80%"  border="0" align="center" cellpadding="2" cellspacing="0" >
  <tr >
    <td class="txtblue" >Total Flight：<%=xCount%> </td>
  </tr>
  <tr >
    <td class="txtblue" >
      <form name="form3" method="post" action="SMSMakeFileAllFltno.jsp?fdate=<%=requestFdate%>">
        <div align="center"> 
         <input type="submit" name="Submit" value="Make File" class="btm" >
        </div>
      </form>
    </td>
  </tr>
</table>
</body>
</html>
<%
if(xCount ==0 ){
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}

%>

	<jsp:forward page="../showmessage.jsp">
	<jsp:param name="messagestring" value="<p style='font-size:10pt;color:#0066FF'>查無資料，本系統只保留兩個月內的航班資料</p>"/>
	<jsp:param name="messagelink" value="<p style='font-size:10pt;color:FF0000'>BACK</p>" />
	<jsp:param name="linkto" value="javascript:history.back(-1)"/>
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
