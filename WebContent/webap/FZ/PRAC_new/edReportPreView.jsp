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
<title>編輯客艙報告</title>
<link href="style2.css" rel="stylesheet" type="text/css">
<script language="javascript" src="checkDel.js" type="text/javascript"></script>

</head>
<body>
<%

String fdate 	= request.getParameter("fdate");
String fltno 	= request.getParameter("fltno").trim();
String dpt 		= request.getParameter("dpt").trim();
String CA 		= request.getParameter("CA").trim();
String CAEmpno = request.getParameter("CAEmpno").trim();
String CACName = request.getParameter("CACName").trim();
//String gdyear 	= request.getParameter("gdyear");
//取得考績年度
String gdyear = fz.pracP.GdYear.getGdYear(fdate);

String ShowPeople = request.getParameter("ShowPeople");
String total 	= request.getParameter("total");

String f = request.getParameter("f");//F艙人數
String c = request.getParameter("c");//C艙人數
String y = request.getParameter("y");//C艙人數


/*
轉換聯管與班表的station
前頁抓聯管，因此此處要轉換成fz 
*/
TransferStation tfs = new TransferStation();

String arv 		= tfs.da13ToFz(request.getParameter("arv").trim());
String acno 	= tfs.da13ToFz(request.getParameter("acno").trim());

//out.print(dpt+arv);


String[] cname	= request.getParameterValues("cname");
String[] ename 	= request.getParameterValues("ename");
String[] empno 	= request.getParameterValues("empno");
String[] sern	= request.getParameterValues("sern");
String[] score	= request.getParameterValues("score");
String[] occu 	= request.getParameterValues("occu");

String bcolor="";
String fontcolor = "";
//purser的empno,sern,name,group
String purserEmpno = null;
String psrsern	= null;
String psrname	= null;
String pgroups = null;

Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
ResultSet myResultSet = null;
boolean t = false;
String sqlPurser = null;
//************************************2.Get live sche table
ctlTable ct = new ctlTable();
ct.doSet();
//out.println(ct.getTable() + "," + ct.getUpdDate());

/*
轉換聯管與班表的station
前頁flightcrew.jsp抓聯管，因此此處要轉換成fz 
*/
TransferStation tf = new TransferStation();


try{

dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
conn = dbDriver.connect("jdbc:weblogic:pool:CAL.FZCP02", null);
stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
		ResultSet.CONCUR_READ_ONLY);

sqlPurser = "select a.empno empno, b.ename ename,b.name cname, a.occu occu,Trim(eg.groups) groups,Trim(eg.sern) sern "+
				"from "+ct.getTable()+" a, fztcrew b,egtcbas eg "+
				"where (a.empno=b.empno AND a.empno = Trim(eg.empn) )AND SubStr(Trim(a.qual),1,1) ='P' "+	//purser的queal為PM或P
				"and a.fdate='"+fdate+"' "+
				"and dpt='"+tf.da13ToFz(dpt)+"' and arv='"+tf.da13ToFz(arv)+"' and LPad(trim(a.dutycode),4,'0')='"+fltno+"'";
				
myResultSet	= stmt.executeQuery(sqlPurser);
if(myResultSet != null){
	while(myResultSet.next()){
		purserEmpno	= myResultSet.getString("empno");
		psrsern		= myResultSet.getString("sern");
		psrname		= myResultSet.getString("cname");
		pgroups 	= myResultSet.getString("groups");

	}
}
myResultSet.close();
/*if(!sGetUsr.equals("638716") && !sGetUsr.equals("640073") ){	//cs55,cs66可編輯

	if(  !sGetUsr.equals("purserEmpno")  ){	//非本班機座艙長，不得使用此功能
		response.sendRedirect("../showMessage.jsp?messagestring="+URLEncoder.encode("非本班機座艙長，不得使用此功能") );
	}

}*/

%> <p align="center"><span class="txtblue"> Cabin's Report&nbsp;<br> 
  <%=fdate%> &nbsp; Fltno:<%=fltno%></span></p> 
  <form name="form1" method="post" action="#" target="_self">
<table width="528" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
      <td width="8">&nbsp;</td>
      <td>
        <div align="left" class="txtred">
         CA&nbsp;:<%=CA%>  </div>
        <div align="center"><span class="txtred">        </span></div>
      </td>
      <td width="141">&nbsp;</td>
      <td width="27">&nbsp;        
      </td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td> <div align="left" class="txtred">A/C:<%=acno%></div></td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td><span class="txtred">F:<%=f%>&nbsp;C:<%=c%>&nbsp;Y:<%=y%>&nbsp;Pax:<%=ShowPeople%></span></td>
      <td><span class="txtred"><span class="txtxred">GradeYear：<%=gdyear%></span></span></td>
      <td><div align="right"><a href="javascript:window.print()"> <img src="../images/print.gif" width="17" height="15" border="0" alt="列印"></a> </div></td>
    </tr>
</table>
  <table width="528"  border="0" align="center" cellpadding="2" cellspacing="0" >
    <tr class="tablehead3">
      <td width="76">Name</td>
      <td width="166">EName</td>
      <td width="57">Sern</td>
      <td width="68">Empno</td>
      <td width="32">Occu</td>
      <td width="33">Score</td>
    </tr>
	<%


for(int i=0;i<empno.length;i++){

		if (i%2 == 0){
			bcolor = "#99CCFF";
		}
		else{
			bcolor = "#FFFFFF";
		}		
%>
  <tr bgcolor="<%=bcolor%>">
      <td class="tablebody">
	  <input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="12" value="<%=cname[i]%>" name="cname">
	  </td>
      <td class="tablebody">
        <div align="left">&nbsp;
		<input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="30" value="<%=ename[i]%>" name="ename">
        </div>
      </td>
      <td class="tablebody">
	  <input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="6" value="<%=sern[i]%>" name="sern"> </td>
      <td class="tablebody"><input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="6" value="<%=empno[i]%>" name="empno"> </td>
      <td class="tablebody">
		<%=occu[i]%>
	   </td>
      <td class="tablebody">
        <%	  if(score[i].equals("0")){	 
		  	    fontcolor="#FF0000";}
			else {
				fontcolor="#000000";
			}
	   %>
        <input type="text" style="background-color:<%=bcolor%> ;border:0pt;color:<%=fontcolor%>" readonly  size="2" value="<%=score[i]%>" name="score">
      </td>
  </tr>
  <%
	}
%>	
  </table>
  <table width="528" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
      <td width="43">&nbsp;</td>
      <td width="228">
        <div align="left" class="txtblue">Total:<%=total%>        </div>
      </td>
      <td width="561"><span class="txttitletop">
        <input type="button" name="Send" value="   Send  ">
        &nbsp;&nbsp;&nbsp;
        <input type="submit" name="delEmpno2" value="Save as Draft"  >
&nbsp;&nbsp;&nbsp;
<input type="button" name="back" value="   ReWrite  " onClick="javascript:history.back(-1)">        
<span class="txtblue">
		  <input type="hidden" name="dpt" value="<%=dpt%>">
		  <input type="hidden" name="arv" value="<%=arv%>">
		  <input type="hidden" name="fltno" value="<%=fltno%>">
		  <input type="hidden" name="fdate" value="<%=fdate%>">
		  <input type="hidden" name="CA" value="<%=CA%>">
		  <input type="hidden" name="ShowPeople" value="<%=ShowPeople%>">
		  <input type="hidden" name="acno" value="<%=acno%>">
  		<input type="hidden" name="CACName" value="<%=CACName%>">
   		<input type="hidden" name="CAEmpno" value="<%=CAEmpno%>"> 
   		</span></td>
      <td width="44">
       
      </td>
    </tr>
</table>
</form>
  <form name="form2" method="post" action="edReportAdd.jsp" onSubmit="return checkEmpno()">
  <table width="528" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
      <td width="5%">
        <div align="right"><a href="javascript:window.print()"> </a> </div>
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
