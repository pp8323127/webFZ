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
<script src="../../MT/js/subWindow.js" language="javascript" type="text/javascript"></script>
</head>
<body>
<%
//String GdYear = request.getParameter("GdYear");

String fdate 	= request.getParameter("fdate");
//取得考績年度
String GdYear = fz.pracP.GdYear.getGdYear(fdate);

String fltno 	= request.getParameter("fltno").trim();
String dpt 		= request.getParameter("dpt").trim();
String CA 		= request.getParameter("CA").trim();
String CAEmpno = request.getParameter("CAEmpno").trim();
String CACName = request.getParameter("CACName").trim();
String gdyear 	= request.getParameter("gdyear");
String ShowPeople = request.getParameter("ShowPeople");
String total 	= request.getParameter("total");

String f = request.getParameter("f");//F艙人數
String c = request.getParameter("c");//C艙人數
String y = request.getParameter("y");//C艙人數



String arv 		= request.getParameter("arv").trim();
String acno 	= request.getParameter("acno").trim();

//out.print(dpt+arv);


String[] cname	= request.getParameterValues("cname");
String[] ename 	= request.getParameterValues("ename");
String[] empno 	= request.getParameterValues("empno");
String[] sern	= request.getParameterValues("sern");
String[] score	= {"0","1","2","3","4","5","6","7","8","9","10"};
String[] occu 	= request.getParameterValues("occu");

String bcolor="";
String fontcolor = "";


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

//purser的empno,sern,name,group
String purserEmpno	= request.getParameter("purserEmpno");
String psrsern		= request.getParameter("psrsern");
String psrname		= request.getParameter("psrname");
String pgroups    = request.getParameter("pgroups");


//out.print(purserEmpno+"<HR>"+psrsern+"<HR>"+psrname+"<HR>"+pgroups+"<HR>");
try{

dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
conn = dbDriver.connect("jdbc:weblogic:pool:CAL.FZCP02", null);
stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
		ResultSet.CONCUR_READ_ONLY);

/*
sqlPurser = "select a.empno empno, b.ename ename,b.name cname, a.occu occu,Trim(eg.groups) groups,Trim(eg.sern) sern "+
				"from "+ct.getTable()+" a, fztcrew b,egtcbas eg "+
				"where (a.empno=b.empno AND a.empno = Trim(eg.empn) )AND SubStr(Trim(a.qual),1,1) ='P' "+	//purser的queal為PM或P
				"and a.fdate='"+fdate+"' "+
				"and dpt='"+dpt+"' and arv='"+arv+"' and LPad(trim(a.dutycode),4,'0')='"+fltno+"'";
				
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
*/
/*if(!sGetUsr.equals("638716") && !sGetUsr.equals("640073")){	//cs55,cs66可編輯

	if(  !sGetUsr.equals("purserEmpno")  ){	//非本班機座艙長，不得使用此功能
		response.sendRedirect("../showMessage.jsp?messagestring="+URLEncoder.encode("非本班機座艙長，不得使用此功能") );
	}

}*/

%> 
  <form name="form1" method="post" action="javascript:alert('success!!')" target="_self" onSubmit="return checkGrade()">
    <table width="579" border="0" cellpadding="0" cellspacing="0" align="center">
      <tr>
        <td colspan="3" valign="middle">
          <div align="center" class="txtred"></div>
          <span class="txtblue">Cabin's Report&nbsp; &nbsp;</span><span class="purple_txt"><strong> Step2.To score each crew and click sern to give commands </strong></span></td>
      </tr>
      <tr>
        <td colspan="2" valign="middle" class="txtblue"> FDate:<span class="txtred"><%=fdate%>&nbsp;</span>&nbsp;Fltno:<span class="txtred"><%=fltno%>&nbsp;&nbsp;</span>Sector:<span class="txtred"><%=dpt%><%=arv%></span> </td>
        <td width="56" valign="middle">&nbsp;</td>
      </tr>
      <tr>
        <td colspan="2" valign="middle" class="txtblue">CA&nbsp;:<span class="txtred"><%=CA%></span></td>
        <td valign="middle">&nbsp;</td>
      </tr>
      <tr>
        <td width="381" valign="middle"  class="txtblue">A/C:<span class="txtred"><%=acno%></span></td>
        <td width="142" valign="middle">&nbsp; </td>
        <td valign="middle" align="right"></td>
      </tr>
      <tr>
        <td valign="middle"  class="txtblue"> F:
            <input type="text" name="f2" size="3"  value="<%=f%>">
C:
<input type="text" name="c2" size="3" value="<%=c%>">
Y:
<input type="text" name="y2" size="3" value="<%=y%>">
INF:
<input type="text" name="inf" size="3">
&nbsp; Pax:<%=ShowPeople%></td>
        <td valign="middle"><span class="txtred">GradeYear：<%=GdYear%></span></td>
        <td valign="middle" align="right"><a href="javascript:window.print()"><img src="../images/print.gif" width="17" height="15" border="0" alt="列印"></a></td>
      </tr>
    </table>
    <table width="604"  border="0" align="center" cellpadding="2" cellspacing="0" >
    <tr class="tablehead3">
      <td width="86">Name</td>
      <td width="213">EName</td>
      <td width="65">Sern</td>
      <td width="72">Empno</td>
      <td width="51">Occu</td>
      <td width="93">Score</td>
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
        <div align="left">
		<input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="30" value="<%=ename[i]%>" name="ename">
        </div>
      </td>
      <td class="tablebody">
	  <input type="text" style="background-color:<%=bcolor%> ;border:0pt;text-decoration:underline" readonly  size="6" value="<%=sern[i]%>" name="sern" onClick="subwinXY('edGdType.jsp?sern=<%=sern[i]%>&cname=<%=cname[i]%>&ename=<%=ename[i]%>&fltno=<%=fltno%>&fdate=<%=fdate%>&sect=<%=dpt%><%=arv%>','edGdType','800','400')"> </td>
      <td class="tablebody"><input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="6" value="<%=empno[i]%>" name="empno"> </td>
      <td class="tablebody"><%=occu[i]%> </td>
      <td class="tablebody">
		<select name="score">
          <%  	  	for(int j=0;j<=10;j++){	  %>
          <option value="<%=score[j]%>"><%=score[j]%></option>
          <%		}	  					  %>
        </select>

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
        <input type="submit" name="Preview" value="   Preview  " >
        &nbsp;&nbsp;&nbsp;
        
&nbsp;&nbsp;&nbsp;
<input type="button" name="back" value="   Back  " onClick="javascript:history.back(-1)">  
&nbsp;&nbsp;&nbsp;  
<input type="reset" name="reset" value="Reset">
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
		  <input type="hidden" name="purserEmpno" value="<%=purserEmpno%>">
		  <input type="hidden" name="psrsern" value="<%=psrsern%>">
		  <input type="hidden" name="psrname" value="<%=psrname%>">
		  <input type="hidden" name="pgroups" value="<%=pgroups%>">
		
   		</span></td>
      <td width="44">
       
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
