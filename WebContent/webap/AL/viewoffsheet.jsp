<%@page contentType="text/html; charset=big5" language="java" import="java.sql.*,al.*,javax.sql.DataSource,javax.naming.*"%>
<%
//response.setHeader("Cache-Control","no-cache");
//response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first
	response.sendRedirect("login.jsp");
} 
String gdyear = request.getParameter("offyear");
String f = request.getParameter("f");
String sumoff = request.getParameter("sumoff");
if("Y".equals(sumoff)){
%>
	<script language="JavaScript" type="text/JavaScript">
	alert("為符合法規，請再次確認ETS及SS訓練到期月份，自行控管休假天數。");
	</script>
	<%
}

if(f != null){
	%>
	<script language="JavaScript" type="text/JavaScript">
	alert("假單輸入成功\n<%=f%>\n請確認假單明細是否正確 !");
	</script>
	<%
}
String cdept = null;
String cname = null;
String sern = null;
String lastday = null;
String thisday = null;
String nextday = null;
String indate = null;
String rs = null;

Connection con = null;
//Driver dbDriver = null;
ResultSet myResultSet = null;
Statement stmt = null;
String sql = null;
String offno = null;
String offtype = null;
String offsdate = null;
String offedate = null;
String offdays = null;
String newdate = null;
String remark = null;
String bc = null;
int rCount = 0;
try{
	//use connection pool
	/*ConnDB cn = new ConnDB();
	cn.setORP3EGUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	con = dbDriver.connect(cn.getConnURL(), null);*/
	
	Context initContext = null;
	DataSource ds = null;
	
	initContext = new InitialContext();
	
	ds = (javax.sql.DataSource)initContext.lookup ("CAL.EGDS01");
	//return ds;
	//=================================================

	//DataSource ds = DbConnPool.getDataSource();
	con = ds.getConnection();
	
	stmt = con.createStatement();
	sql = "SELECT OFFNO, EMPN, SERN, DECODE(OFFTYPE, '0', 'AL', "+
											 " '1', 'WL', " +   
											 " '2', 'FL', " +
											 " '3', 'SL', " +  
											 " '4', 'IL', " +
											 " '5', 'EL', " +
											 " '6', 'BL', " +
											 " '7', 'NB', " +
											 " '8', 'OL', " +
											 " '9', 'NP', " +
											 " OFFTYPE) MYOFFTYPE, " +
	"to_char(OFFSDATE, 'yyyy-mm-dd') myoffsdate, to_char(OFFEDATE, 'yyyy-mm-dd') myoffedate, OFFDAYS, nvl(remark,'Y') remark, NEWDATE  FROM EGDB.EGTOFFS  WHERE EMPN='" + sGetUsr + "' AND GRADEYEAR='" + gdyear + "'  ORDER BY OFFSDATE";
	myResultSet = stmt.executeQuery(sql);
	
	//get crew basic information
	ALInfo ai = new ALInfo();
	rs = ai.setCrewInfo(sGetUsr);
	if("0".equals(rs)){
		cdept = ai.getCdept();
		cname = ai.getCname();
		sern = ai.getSern();
		indate = ai.getIndate();
	}
	rs = ai.setALDays(sGetUsr);
	if("0".equals(rs)){
		lastday = ai.getLastdays();
		thisday = ai.getThisdays();
		nextday = ai.getNextdays();
	}
	CheckUpdateAl cual = new CheckUpdateAl();
	int cutdate = cual.getCutday(sern);
%>
<html>
<head>
<title>View offsheet</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
</head>
<body bgcolor="#FFFFFF" text="#000000">
<div align="center"> 
  <p><font face="Comic Sans MS" color="#000099"> Offsheet List</font></p>
  <table width="75%" border="0">
    <tr> </tr>
  </table>
  <table width="75%" border="0">
    <tr> 
      <td width="24%"><font face="Arial, Helvetica, sans-serif" size="2"><b>Dept 
        / <%=cdept%></b></font></td>
      <td width="24%"><font face="Arial, Helvetica, sans-serif" size="2"><b>Name 
        / <%=cname%></b></font></td>
      <td width="25%"><font face="Arial, Helvetica, sans-serif" size="2"><b>EmpNo 
        / <%=sGetUsr%></b> </font></td>
      <td width="27%"><font face="Arial, Helvetica, sans-serif" size="2"><b>SerNo 
        / <%=sern%></b></font></td>
    </tr>
    <tr> 
      <td width="24%"><b><font size="2" face="Arial, Helvetica, sans-serif">Lastyear 
        / <%=lastday%></font></b></td>
      <td width="24%"><b><font size="2" face="Arial, Helvetica, sans-serif">Thisyear 
        / <%=thisday%></font></b></td>
      <td width="25%"><b><font size="2" face="Arial, Helvetica, sans-serif">Nextyear 
        / <%=nextday%></font></b></td>
      <td width="27%"><b><font size="2" face="Arial, Helvetica, sans-serif">Indate 
        / <%=indate%></font></b></td>
    </tr>
  </table>
  <font color="#0000CC" size="2">未扣除特休假總天數 :</font><font color="#FF0000" size="2"> <strong><%=cutdate%></strong></font>
  <form name="form1" method="post" ONSUBMIT="return f_submit()" action="delal.jsp">
  <table width="75%" border="1" cellpadding="0" cellspacing="0">
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
        <div align="center"><font color="#000000"><b><font face="Arial, Helvetica, sans-serif" size="2">ApplyDate</font></b></font></div>
      </td>
	  <td> 
        <div align="center"><font color="#000000"><b><font face="Arial, Helvetica, sans-serif" size="2">Remark</font></b></font></div>
      </td>
	  <td> 
        <div align="center"><font color="#000000"><b><font face="Arial, Helvetica, sans-serif" size="2">Del</font></b></font></div>
      </td>
    </tr>
<%
if (myResultSet != null)
{
	while(myResultSet.next())
	{
		offno = myResultSet.getString("OFFNO");
		offtype = myResultSet.getString("MYOFFTYPE");
		offsdate = myResultSet.getString("myoffsdate");
		offedate = myResultSet.getString("myoffedate");
		offdays = myResultSet.getString("OFFDAYS");
		newdate = myResultSet.getString("NEWDATE");
		remark = myResultSet.getString("remark");
		rCount++;
		if (remark.equals("N"))
		{
			bc = "#FFCCFF";
		}
		else
		{
			if (rCount%2 == 0)
			{
				bc = "#C9C9C9";
			}
			else
			{
				bc = "#FFFFFF";
			}
		}
%>
    <tr bgcolor = "<%=bc%>"> 
      <td> 
        <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=offno%></font></div>
      </td>
      <td> 
        <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=offtype%></font></div>
      </td>
      <td> 
        <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=offsdate%></font></div>
      </td>
      <td> 
        <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=offedate%></font></div>
      </td>
      <td> 
        <div align="center"><font face="Arial, Helvetica, sans-serif" size="2" color="#0000FF"><%=offdays%></font></div>
      </td>
      <td> 
        <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=newdate%></font></div>
      </td>
	  <%
	  if (remark.equals("*")){
	  	bc = "#FF0000";
	  }
	  else {
	  	bc = "#0000CC";
	  }
	  %>
	  <td> 
        <div align="center"><font color="<%=bc%>" size="2" face="Arial, Helvetica, sans-serif"><strong><%=remark%></strong></font></div>
      </td>
	  <%
	  if (remark.equals("N")){
	  %>
	  <td> 
        <div align="center"><font face="Arial, Helvetica, sans-serif" size="2">
          <input name="checkdel" type="checkbox" id="checkdel" value="<%=offsdate%><%=offedate%><%=offno%>">
        </font></div>
      </td>
	  <%
	  }
	  else{
	  %>
	  <td>&nbsp;</td>
	  <%
	  }
	  %>
    </tr>
<%
	}
}
%>

  </table>
  <p>
    <input type="submit" name="Submit" value="送出刪除假單">
    <input name="gdyear" type="hidden" id="gdyear" value="<%=gdyear%>">
  </p>
  </form>
  <table width="75%"  border="0">
  <tr>
  <td><font color="#0000CC" size="2"><strong>Remark</strong> : <font color="#FF0000"><strong>* </strong></font>--&gt;已刪除假單、<strong>Y</strong> --&gt; 已扣除假單、<strong>N </strong>--&gt; 未扣除假單</font></td>
  </tr>
  <tr>
  <td><strong><font color="#FF0000" size="2">重要提示:<br>
  1.特休假單將由您本假單休假起始日當時有效休假日數扣除。<br>
  2.特休假單如跨進公司日,系統將自動拆為兩張假單。<br>
  如有任何問題請洽空服行政。</font></strong></td>
  </tr>
  </table>
  <table width="75%"  border="0">
    <tr>
      <td width="20%"><font face="Comic Sans MS" size="2"><A HREF='selectpage.jsp'><strong>Select Page</strong></A></font></td>
      <td width="58%"><div align="center"><font face="Comic Sans MS" size="2"><a href="inputal.jsp"><strong>Input
      AL offsheet</strong></a></font></div></td>
      <td width="22%"><div align="right"><font face="Comic Sans MS" size="2"><a href="sendredirect.jsp"><b>Logout</b></a></font></div></td>
    </tr>
  </table>
  <p><font face="Comic Sans MS" size="2"><a href="sendredirect.jsp"></a></font></p>
  <p>&nbsp;</p>
</div>
</body>
</html>
<%
}catch(Exception e)
{
	  out.println(e.toString());
}
finally{
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(con != null) con.close();}catch(SQLException e){}
}
%>
<script language=javascript>
function f_submit()
{  
	 return confirm("Delete offsheet ?")
}
</script>
