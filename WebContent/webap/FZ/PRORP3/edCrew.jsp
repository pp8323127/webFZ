<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.*,java.sql.*,java.net.URLEncoder,java.util.GregorianCalendar"%>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) {		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} 

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>編輯座艙長報告</title>
<link href="style2.css" rel="stylesheet" type="text/css">
<script language="javascript" src="checkDel.js" type="text/javascript"></script>
<script language="javascript" src="changeAction.js" type="text/javascript"></script>

</head>
<body>
<%
String GdYear = request.getParameter("GdYear");

String addSernList = "";


//************************************2.Get live sche table
ctlTable ct = new ctlTable();
ct.doSet();
//out.println(ct.getTable() + "," + ct.getUpdDate());


String f = request.getParameter("f");//F艙人數
String c = request.getParameter("c");//C艙人數
String y = request.getParameter("y");//Y艙人數
String pxac = request.getParameter("pxac");//總人數
String book_total = request.getParameter("book_total");
String ShowPeople = null;
if( pxac.equals("0")){
	ShowPeople = book_total;
}
else{
	ShowPeople = pxac;
}

String fdate = request.getParameter("fdate");
String fltno = request.getParameter("fltno").trim();

String dpt = request.getParameter("dpt").trim();
String arv = request.getParameter("arv").trim();
String acno = request.getParameter("acno");
//purser的empno,sern,name,group
String purserEmpno = request.getParameter("purserEmpno");
String pursern	= request.getParameter("pursern");
String purname	= request.getParameter("purname");
String pgroups = request.getParameter("pgroups");

String empno 	= null;
String sern		= null;
String cname	= null;
String ename 	= null;
String occu 	= null;
String spcode	= null;

Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
ResultSet myResultSet = null;
String sql = null;
String CACName =null;
String CAEName =null;
String CAEmpno = null;
				
//抓CA	資料
String sqlCA = "select a.empno empno, b.ename ename,b.name cname, a.occu occu "+
				"from "+ct.getTable()+" a, fztcrew b "+
				"where a.empno=b.empno AND (Trim(b.occu) ='CA'  AND a.dh <> 'Y' AND a.dh IS NOT NULL) "+	
				"and a.fdate='"+fdate+"' "+
				"and dpt='"+dpt+"' and arv='"+arv+"' and trim(a.dutycode)='"+fltno+"' "+
				"ORDER BY a.empno";


				
int xCount=0;
String bcolor=null;

try{

dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
conn = dbDriver.connect("jdbc:weblogic:pool:CAL.FZCP02", null);
stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
		ResultSet.CONCUR_READ_ONLY);

//抓取該班組員名單
sql = "select a.dutycode,a.empno empno, a.spcode spcode, b.ename ename,b.name cname, b.box sern, "+
	  "trim(b.occu) occu,a.dpt,a.arv,nvl(a.dh,'&nbsp;') dh "+
	  "from "+ct.getTable()+" a, fztcrew b "+
	  "where a.empno=b.empno and b.occu in ('FA','FS') and a.fdate='"+fdate+"' "+
  	  "and a.dh <>'Y' and a.dpt='"+dpt+"' and a.arv='"+arv+"' "+
	  "and trim(a.dutycode)='"+fltno+"' order by empno";

//抓CA的資料，若有多個CA：依照員工號排序後抓第一筆
myResultSet	= stmt.executeQuery(sqlCA);
if(myResultSet.next()){

		CACName	= myResultSet.getString("cname");
		CAEName = myResultSet.getString("ename");
		CAEmpno	= myResultSet.getString("empno");
	
}
String CA = CAEmpno+"&nbsp;"+CACName+"&nbsp;"+CAEName;
myResultSet.close();
%> 
<form name="form1" method="post" action="edCrewDel.jsp" target="_self" onSubmit="return del('form1','delSern')">
  <table width="579" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
      <td colspan="3" valign="middle">
        <div align="center" class="txtred"></div>
      
        <span class="txtblue">Purser's Report&nbsp;       <strong>&nbsp;</strong></span><span class="txtxred"><strong> Step1.Select Crew List(Add or Delete Crew List) </strong></span></td>
    </tr>
    <tr>
      <td colspan="2" valign="middle" class="txtblue"> FDate:<span class="txtred"><%=fdate%>&nbsp;</span>&nbsp;Fltno:<span class="txtred"><%=fltno%>&nbsp;&nbsp;</span>Sector:<span class="txtred"><%=dpt%><%=arv%></span> </td>
      <td width="62" valign="middle">&nbsp;</td>
    </tr>
    <tr>
      <td colspan="3" valign="middle" class="txtblue">Purser:<span class="txtred"><%=purname%>&nbsp;<%=pursern%>&nbsp;<%=purserEmpno%></span>&nbsp;CA&nbsp;:<span class="txtred"><%=CA%></span></td>
    </tr>
    <tr>
      <td width="168" valign="middle"  class="txtblue">A/C:<span class="txtred"><%=acno%></span></td>
      <td width="349" valign="middle">
        <div align="right"><span class="purple_txt"><strong>GradeYear：<%=GdYear%></strong></span> </div>
      </td>
      <td valign="middle" align="right"><a href="javascript:window.print()"><img src="../images/print.gif" width="17" height="15" border="0" alt="列印"></a></td>
    </tr>
</table>
  <table width="604"  border="0" align="center" cellpadding="2" cellspacing="0" >
    <tr class="tablehead3">
	 <td width="70">Select</td>
      <td width="123">Name</td>
      <td width="247">EName</td>
      <td width="51">Sern</td>
      <td width="58">Empno</td>
      <td width="31">Occu</td>
     
    </tr>
	<%
ArrayList OSernAList = new ArrayList();	//存入航班中原本的組員
myResultSet	= stmt.executeQuery(sql);

if(myResultSet != null){
	while(myResultSet.next()){
		 empno 	= myResultSet.getString("empno");
		 sern	= myResultSet.getString("sern");
		 cname	= myResultSet.getString("cname");
		 ename	= myResultSet.getString("ename");
		 occu 	= myResultSet.getString("occu");
		 spcode	= myResultSet.getString("spcode");
		 
		 OSernAList.add(sern);
		xCount++;	
		if (xCount%2 == 0){
			bcolor = "#99CCFF";
		}
		else{
			bcolor = "#FFFFFF";
		}		
%>
  <tr bgcolor="<%=bcolor%>">
   <td valign="middle" class="tablebody">
        <input name="delSern" type="checkbox"  value="<%=sern%>">
      </td>
      <td align="center" valign="middle" class="tablebody">&nbsp;
	  <input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="12" value="<%=cname%> <%=spcode%>" name="cname"></td>
      <td valign="middle" class="tablebody">
        <div align="left">&nbsp;
		<input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="30" value="<%=ename%>" name="ename"></div>
      </td>
      <td valign="middle" class="tablebody">
		<input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="6" value="<%=sern%>" name="sern">
	  </td>
      <td valign="middle" class="tablebody">
		<input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="6" value="<%=empno%>" name="empno">
	  </td>
      <td valign="middle" class="tablebody">
	  <input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="2" value="<%=occu%>" name="occu" >
	  </td>
     

    </tr>
  <%
	}
}
//將sern串成OsernList ,format: '#####','#####'
ChangeType cht = new ChangeType();
String OsernList = cht.ArrayListToStirng(OSernAList);		//原始組員清單
	
%>	
  </table>
  <table width="528" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
      <td width="43" height="53">&nbsp;</td>
      <td width="228">
        <div align="left" class="txtblue">Total:<%=xCount%>        </div>
      </td>
      <td width="561"><span class="txttitletop">
        <input type="button" name="Score" value="Score (Next)" onClick="this.disabled=1;preview('form1','edReportScore.jsp')" class="addButton">
        &nbsp;&nbsp;&nbsp;
        <input type="submit" name="delEmpno2" value="Delete Selected" class="delButon" >
        <span class="txtblue">
		  <input type="hidden" name="dpt" value="<%=dpt%>">
		  <input type="hidden" name="arv" value="<%=arv%>">
		  <input type="hidden" name="fltno" value="<%=fltno%>">
		  <input type="hidden" name="fdate" value="<%=fdate%>">
		  <input type="hidden" name="OsernList" value="<%=OsernList%>">
		  <input type="hidden" name="addSernList" value="<%=addSernList%>">
		  <input type="hidden" name="CA" value="<%=CA%>">
		  <input type="hidden" name="acno" value="<%=acno%>">
  		  <input type="hidden" name="CACName" value="<%=CACName%>">
   		  <input type="hidden" name="CAEmpno" value="<%=CAEmpno%>">
		  <input type="hidden" name="total" value="<%=xCount%>">
		  <input type="hidden" name="ShowPeople" value="<%=ShowPeople%>">
  		  <input type="hidden" name="total" value="<%=xCount%>">
  		  <input type="hidden" name="f" value="<%=f%>">
   		  <input type="hidden" name="c" value="<%=c%>">
		  <input type="hidden" name="y" value="<%=y%>">
		  <input type="hidden" name="purserEmpno" value="<%=purserEmpno%>">
		  <input type="hidden" name="psrsern" value="<%=pursern%>">
		  <input type="hidden" name="psrname" value="<%=purname%>">
		  <input type="hidden" name="pgroups" value="<%=pgroups%>">
		  <input type="hidden" name="GdYear" value="<%=GdYear%>">
        </span> </span></td>
      <td width="44">
      </td>
    </tr>
</table>
  <table width="528" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
      <td width="5%">&nbsp;</td>
      <td width="90%">
        <div align="left" class="txtblue">Insert Crew's Sern：
          <input type="text" name="addSern" size="5" maxlength="5">
     	   <input type="button" name="Submit2" value="Add"  onClick="checkAdd('form1','addSern','edCrewAdd.jsp')">
           <span class="txttitletop">&nbsp;&nbsp;&nbsp;
           <input type="reset" name="reset" value="Reset">
        </span></div>
      </td>
      <td width="5%">
      </td>
    </tr>
</table>
</form>

</body>
</html>

<%
}
catch (Exception e)
{
	  out.print(e.toString());
}
finally
{
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>