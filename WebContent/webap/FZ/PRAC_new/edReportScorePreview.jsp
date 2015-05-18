<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.*,java.sql.*,
				java.net.URLEncoder,
				java.util.GregorianCalendar,				
				fz.pracP.UpdCfltCol"%>
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
<script language="javascript" src="changeAction.js" type="text/javascript"></script>

</head>
<body >
<div align="center">
<div align="center">
      <%
//String GdYear = request.getParameter("GdYear");

String fdate 	= request.getParameter("fdate");
//取得考績年度
String GdYear = fz.pracP.GdYear.getGdYear(fdate);

String fltno 	= request.getParameter("fltno").trim();
String dpt 		= request.getParameter("dpt").trim();
String arv 		= request.getParameter("arv").trim();
String CA 		= request.getParameter("CA").trim();
String comm = request.getParameter("comm");

String sect = dpt+arv;

String CAEmpno = request.getParameter("CAEmpno").trim();
String CACName = request.getParameter("CACName").trim();
String gdyear 	= request.getParameter("gdyear");
String ShowPeople = request.getParameter("ShowPeople");
String total 	= request.getParameter("total");

String f = request.getParameter("f");//F艙人數
	if(f.equals("")){f = "0";}
String c = request.getParameter("c");//C艙人數
	if(c.equals("")){c = "0";}
String y = request.getParameter("y");//C艙人數
	if(y.equals("")){y = "0";}

String acno 	= request.getParameter("acno").trim();

//out.print(dpt+arv);


String[] cname	= request.getParameterValues("cname");
String[] ename 	= request.getParameterValues("ename");
String[] empno 	= request.getParameterValues("empno");
String[] sern	= request.getParameterValues("sern");
String[] score	= request.getParameterValues("score");
String[] occu 	= request.getParameterValues("occu");

//insert egtcflt的column Value（組員及分數部分）
String insertColumnValue = "";
UpdCfltCol CfltCol = new UpdCfltCol();
insertColumnValue = CfltCol.getColValue(empno,sern,cname,score);
//out.print(updateColumnValue);


//insert egtcflt的column Name（組員及分數部分）
String insertColumnName = "";
insertColumnName =CfltCol.getColName();

//update egtcflt的值（組員及分數部分）
String updValue = "";
updValue = CfltCol.getUPDValue(empno,sern,cname,score);

String bcolor="";
String fontcolor = "";


Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
ResultSet myResultSet = null;
boolean t = false;
//String sqlPurser = null;
String sqlModifyCFlt = null;
String sqlModifyPsac = null;
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

//ORP3
/*
dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
conn = dbDriver.connect("jdbc:weblogic:pool:CAL.FZCP02", null);
stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
		ResultSet.CONCUR_READ_ONLY);
*/
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
/*if(!sGetUsr.equals("638716") && !sGetUsr.equals("640073") ){	//cs55,cs66可編輯

	if(  !sGetUsr.equals("purserEmpno")  ){	//非本班機座艙長，不得使用此功能
		response.sendRedirect("../showMessage.jsp?messagestring="+URLEncoder.encode("You're not authorized.<BR>非本班機座艙長，不得使用此功能") );
	}

}*/

%>
   <strong>   </strong></div>
  <form name="form1" method="post" action="edReportComm.jsp" target="_self" >
    <table width="604" border="0" cellpadding="0" cellspacing="0" align="center">
      <tr>
        <td colspan="3" valign="left">
          <div align="center" class="txtred"></div>
          <div align="left"><span class="txtblue">Cabin's Report&nbsp; &nbsp;</span><span class="red12"><strong> Step3.Preview the Report</strong></span></div>
        </td>
      </tr>
      <tr>
        <td colspan="2" valign="middle" class="txtblue"> 
          <div align="left">FDate:<span class="txtred"><%=fdate%>&nbsp;</span>&nbsp;Fltno:<span class="txtred"><%=fltno%>&nbsp;&nbsp;</span>Sector:<span class="txtred"><%=sect%></span> </div>
        </td>
        <td width="56" valign="middle">&nbsp;</td>
      </tr>
      <tr>
        <td colspan="2" valign="middle" class="txtblue">
          <div align="left">Cabin:<span class="txtred"><%=psrname%>&nbsp;<%=psrsern%>&nbsp;<%=purserEmpno%></span>&nbsp;CA&nbsp;:<span class="txtred"><%=CA%></span></div>
        </td>
        <td valign="middle">&nbsp;</td>
      </tr>
      <tr>
        <td width="381" valign="middle"  class="txtblue">
          <div align="left">A/C:<span class="txtred"><%=acno%></span></div>
        </td>
        <td width="142" valign="middle">&nbsp; </td>
        <td valign="middle" align="right"></td>
      </tr>
      <tr>
        <td valign="middle"  class="txtblue"> 
          <div align="left">F:<span class="txtred"><%=f%></span>&nbsp; C:<span class="txtred"><%=c%></span>&nbsp; Y:<span class="txtred"><%=y%></span>&nbsp;

&nbsp; Pax:<span class="txtred"><%=ShowPeople%></span></div>
        </td>
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
        <input type="text" style="background-color:<%=bcolor%> ;border:0pt;text-decoration:underline;cursor:hand" readonly  size="6" value="<%=sern[i]%>" name="sern" onClick="subwinXY('edGdType.jsp?sern=<%=sern[i]%>&cname=<%=URLEncoder.encode(cname[i])%>&ename=<%=ename[i]%>&fltno=<%=fltno%>&fdate=<%=fdate%>&s=<%=sect%>&g=<%=GdYear%>&empno=<%=empno[i]%>','edGdType','800','500')">
</td>
      <td class="tablebody"><input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="6" value="<%=empno[i]%>" name="empno"> </td>
      <td class="tablebody">
        <input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="2" value="<%=occu[i]%>" name="occu" tabindex="999"> 
      </td>
      <td class="tablebody">
	  <%
	  if (score[i].equals("9") ||  score[i].equals("10") || score[i].equals("1") || score[i].equals("2") || score[i].equals("3")){
	  	fontcolor="#FF33CC;font-weight: bold";
	  }
	  else{
	  	fontcolor="#000000";
	  }
	  %>
<input type="text" style="background:<%=bcolor%> ;border:0pt;color:<%=fontcolor%>;text-decoration:underline;cursor:hand" readonly  size="2" value="<%=score[i]%>" name="score" onClick="subwinXY('edGdType.jsp?sern=<%=sern[i]%>&cname=<%=URLEncoder.encode(cname[i])%>&ename=<%=ename[i]%>&fltno=<%=fltno%>&fdate=<%=fdate%>&s=<%=sect%>&g=<%=GdYear%>&empno=<%=empno[i]%>','edGdType','800','500')">      </td>
      </tr>
  <%
	}
%>	
  </table>
  <table width="604" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
      <td colspan="4">
        <p align="left" class="bold"><u>Crew Evaluation / Flt Irregularity </u><br>
          <span class="txtxred" ><%=comm%></span><span class="txtblue" ><span class="txtblue" >
          <hr>
          </span> </span>
          </p>
       </td>
    </tr>
    <tr>
      <td width="26">&nbsp;</td>
      <td width="105">
        <div align="left" class="txtblue">Total:<%=total%>        </div>
      </td>
      <td width="444"><span class="txttitletop">
        <input name="send" type="submit" class="addButton" value="Update & Send Report" >
		<input type="button" name="save" value="Save as Draft"  onClick="preview('form1','upReportSave.jsp')">&nbsp;&nbsp;&nbsp;
<input type="button" name="back" value="   Back  " onClick="javascript:history.back(-1)">  
&nbsp;&nbsp;&nbsp;<span class="txtblue">
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
		<input type="hidden" name="comm" value="<%=comm%>">
   		</span></td>
      <td width="29">
       
      </td>
    </tr>
    <tr>
      <td colspan="4" class="purple_txt"><strong>*You must click Sern or Score column to edit In-Flight Service Grade 
          <br>
      if the crew's socre is 1,2,3,9 or 10</strong></td>
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
		//  response.sendRedirect("../showMessage.jsp?messagestring="+URLEncoder.encode("系統忙碌中，請稍後再試"));
}
finally
{
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>
