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
<script src="changeAction.js" type="text/javascript"></script>
<script type="text/javascript" language="javascript">
function disableSubmit(){
	document.form1.GiveComments.disabled=1;
	return true;
}
function checkNUM(col){
	eval("data = document.form1."+col+".value.match(/[^0-9]/g);");
	if(data){
		alert("本欄位只能輸入半形數字");
		eval("document.form1."+col+".value='';");
		return false;
	}else{
		return true;
	}
}

/*
function checkCharacter(){

	var message = document.form1.comm.value;
	var len = document.form1.comm.value.length;
		//alert(len);
	if(len >500){
		alert("Comments字元數限制為500個字元，\n所輸入字數超過"+(len-500)+"個字元，請重新輸入");
		document.form1.comm.focus();
		return false;
	}
	else if(len == ""){
		if(confirm("尚未輸入Crew Evaluation / Flt Irregularity，確定要送出？")){
			document.form1.GiveComments.disabled=1;
			return true;
		}
		else{
			document.form1.comm.focus();
			return false;
		}
	}
	else{
		return true;
	}
}
*/
</script>
</head>
<body>
<%
String fdate 	= request.getParameter("fdate");
//取得考績年度
String GdYear = fz.pr.orp3.GdYear.getGdYear(fdate);

String fltno 	= request.getParameter("fltno").trim();
String dpt 		= request.getParameter("dpt").trim();
String arv 		= request.getParameter("arv").trim();

String CA 		= request.getParameter("CA").trim();
String CAEmpno = request.getParameter("CAEmpno").trim();
String CACName = request.getParameter("CACName").trim();
String ShowPeople = request.getParameter("ShowPeople");
String total 	= request.getParameter("total");

String f = request.getParameter("f");//F艙人數
String c = request.getParameter("c");//C艙人數
String y = request.getParameter("y");//C艙人數



String acno 	= request.getParameter("acno").trim();

//out.print(dpt+arv);


String[] cname	= request.getParameterValues("cname");
String[] ename 	= request.getParameterValues("ename");
String[] empno 	= request.getParameterValues("empno");

//modify by cs66 at 2005/02/17 檢查組員人數
if(empno.length >20){
	response.sendRedirect("../showmessage.jsp?messagestring="+URLEncoder.encode("組員人數超過20人，請刪除ACM組員.")+"&messagelink=Back&linkto=javascript:history.back(-2)" );
}

String[] sern	= request.getParameterValues("sern");
String[] scoreShow	= {"X","1","2","3","4","5","6","7","8","9","10"};
String[] score	= {"0","1","2","3","4","5","6","7","8","9","10"};
String[] occu 	= request.getParameterValues("occu");

String bcolor="";
//String fontcolor = "";


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
/*if(!sGetUsr.equals("638716") && !sGetUsr.equals("640073") ){	//cs55,cs66可編輯

	if(  !sGetUsr.equals("purserEmpno")  ){	//非本班機座艙長，不得使用此功能
		response.sendRedirect("../showmessage.jsp?messagestring="+URLEncoder.encode("非本班機座艙長，不得使用此功能") );
	}

}*/

%> 
  <form name="form1" method="post" action="edReportComm.jsp" target="_self" onSubmit="return disableSubmit()">
    <table width="579" border="0" cellpadding="0" cellspacing="0" align="center">
      <tr>
        <td colspan="3" valign="middle">
          <div align="center" class="txtred"></div>
          <span class="txtblue">Purser's Report&nbsp; &nbsp;</span><span class="purple_txt"><strong> Step2.To score each crew and modify number of passengers</strong></span></td>
      </tr>
      <tr>
        <td colspan="2" valign="middle" class="txtblue"> FDate:<span class="txtred"><%=fdate%>&nbsp;</span>&nbsp;Fltno:<span class="txtred"><%=fltno%>&nbsp;&nbsp;</span>Sector:<span class="txtred"><%=dpt%><%=arv%></span> </td>
        <td width="56" valign="middle">&nbsp;</td>
      </tr>
      <tr>
        <td colspan="2" valign="middle" class="txtblue">Purser:<span class="txtred"><%=psrname%>&nbsp;<%=psrsern%>&nbsp;<%=purserEmpno%></span>&nbsp;CA&nbsp;:<span class="txtred"><%=CA%></span></td>
        <td valign="middle">&nbsp;</td>
      </tr>
      <tr>
        <td width="381" valign="middle"  class="txtblue">A/C:<span class="txtred">
          <input type="text" name="acno" value="<%=acno%>" size="5" maxlength="5">
        </span></td>
        <td width="142" valign="middle">&nbsp; </td>
        <td valign="middle" align="right"></td>
      </tr>
      <tr>
        <td valign="middle"  class="txtblue"> F:
            <input type="text" name="f" size="3"  value="<%=f%>" onkeyup="return checkNUM('f')" >
C:
<input type="text" name="c" size="3" value="<%=c%>"   onkeyup="return checkNUM('c')" >
Y:
<input type="text" name="y" size="3" value="<%=y%>"   onkeyup="return checkNUM('y')" >
INF:
<input type="text" name="inf" size="3"  onkeyup="return checkNUM('inf')" >
&nbsp; Pax:<%=ShowPeople%></td>
        <td valign="middle"><span class="txtred">GradeYear：<%=GdYear%></span></td>
        <td valign="middle" align="right"><a href="javascript:window.print()"><img src="../images/print.gif" width="17" height="15" border="0" alt="列印"></a></td>
      </tr>
    </table>
    <table width="604"  border="0" align="center" cellpadding="2" cellspacing="0" >
    <tr class="tablehead3">
      <td width="86">Name</td>
      <td width="212">EName</td>
      <td width="47">Sern</td>
      <td width="68">Empno</td>
      <td width="49">Duty</td>
      <td width="39">Score</td>
      <td width="75">最佳服務</td>
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
	  <input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="12" value="<%=cname[i]%>" name="cname" tabindex="999">
	  </td>
      <td class="tablebody">
        <div align="left">
		<input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="30" value="<%=ename[i]%>" name="ename" tabindex="999">
        </div>
      </td>
      <td class="tablebody">
	  <input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="6" value="<%=sern[i]%>" name="sern"  tabindex="999"> </td>
      <td class="tablebody"><input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="6" value="<%=empno[i]%>" name="empno" tabindex="999"> </td>
      <td class="tablebody">
	  	<select name="duty"  tabindex="<%=(1+i)%>">
			<option value="X">X</option>
			<option value="Z1">Z1</option>
			<option value="1L">1L</option>
			<option value="1R">1R</option>
			<option value="Z2">Z2</option>
			<option value="2L">2L</option>
			<option value="2R">2R</option>
			<option value="UDZ">UDZ</option>
			<option value="UDR">UDR</option>
			<option value="UDL">UDL</option>
			<option value="UDA">UDA</option>
			<option value="Z3">Z3</option>
			<option value="3L">3L</option>
			<option value="3R">3R</option>
			<option value="3LA">3LA</option>
			<option value="3RA">3RA</option>
			<option value="4LA">4LA</option>
			<option value="4RA">4RA</option>
			<option value="4L">4L</option>
			<option value="4R">4R</option>
			<option value="5L">5L</option>
			<option value="5R">5R</option>
		</select>
	  </td>
      <td class="tablebody">
        <select name="score"  tabindex="<%=(51+i)%>">
          <%  	  	for(int j=0;j<=10;j++){	  %>
          <option value="<%=score[j]%>"><%=scoreShow[j]%></option>
          <%		}	  					  %>
        </select>
</td>
      <td class="tablebody">
        <input type="checkbox" name="gs" value="<%=empno[i]+sern[i]%>">
      </td>
  </tr>
  <%
	}
%>	
  </table>
  <table width="604" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
      <td width="10">&nbsp;</td>
      <td width="148">
        <div align="left" class="txtblue">Total:<%=total%>        </div>
      </td>
      <td width="353"><span class="txttitletop">
        <input name="GiveComments" type="submit" class="addButton" value="Save ( Next ) " tabindex="<%=(total+2)%>">
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
  		<input type="hidden" name="CACName" value="<%=CACName%>">
   		<input type="hidden" name="CAEmpno" value="<%=CAEmpno%>"> 
		  <input type="hidden" name="purserEmpno" value="<%=purserEmpno%>">
		  <input type="hidden" name="psrsern" value="<%=psrsern%>">
		  <input type="hidden" name="psrname" value="<%=psrname%>">
		  <input type="hidden" name="pgroups" value="<%=pgroups%>">
		  <input type="hidden" name="total" value="<%=total%>">
<input type="hidden" name="GdYear" value="<%=GdYear%>">		
   		</span></td>
      <td width="17">
       
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
