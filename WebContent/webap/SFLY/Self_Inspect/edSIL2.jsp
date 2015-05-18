<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*,java.util.*,ci.db.*,tool.ReplaceAll,java.util.ArrayList,java.net.URLEncoder" %>
<%
//新增、刪除Flt Irregularity
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if ( sGetUsr == null) {		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
	
}

 /*
//抓取動態選單
ThreeSelect ts = new ThreeSelect();
ts.getStatement();
String getItem1 = ts.getItem1();//第一層選單
String getItem2 = ts.getItem2();//第二層選單
//out.print(getItem2);
String getItem3= ts.getItem3();//第三層選單
String script = ts.select1();
ts.closeStatement();
*/

boolean hasRecord = false;
String GdYear = "2005";//request.getParameter("GdYear");
String fdate = request.getParameter("fdate");
String fltno = request.getParameter("fltno");
String dpt = request.getParameter("dpt");
String arv = request.getParameter("arv");
String acno = request.getParameter("acno");
session.setAttribute("fz.acno",acno);
//out.print("acno="+acno);
//String GdYear = request.getParameter("GdYear");


//String itemNo = null;
String itemNoDsc = null;//大項的敘述
String itemDsc = null;//細項的敘述
String comm	= null;
String yearsern = null;//流水號


int count = 0;  
Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
ResultSet myResultSet = null;

//************************************Get live sche table
ctlTable ct = new ctlTable();
ct.doSet();
//purser的empno,sern,name,group
String purserEmpno = null;
String psrsern	= null;
String psrname	= null;
String pgroups = null;
String sql = null;
String upd = null;
try{



//驗證是否為Purser
String sqlPurser = "select a.empno empno, b.ename ename,b.name cname, b.occu occu,Trim(eg.groups) groups,Trim(eg.sern) sern "+
				"from "+ct.getTable()+" a, fztcrew b,egtcbas eg "+
				"where (a.empno=b.empno AND a.empno = Trim(eg.empn) ) and a.empno not in ('593027','625303','625304','628484','628539','628997','625296') "+
				"AND SubStr(Trim(a.qual),1,1) ='P' and a.spcode not in ('I','S') and a.dh <> 'Y' "+	//purser的queal為PM或P
				"and a.fdate='"+fdate+"' "+
				"and dpt='"+dpt+"' and arv='"+arv+"' and trim(dutycode)='"+fltno+"'";
				

dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
conn = dbDriver.connect("jdbc:weblogic:pool:CAL.FZCP02", null);
stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
		ResultSet.CONCUR_READ_ONLY);

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
conn.close();


String pbuser = (String)session.getAttribute("pbuser");

//驗證是否為Purser
//可使用者:cs55,cs66,cs27,cs40,cs71,cs73
//新增630166 ->吉鎮麗，.....EF人員

if(!sGetUsr.equals("638716") && !sGetUsr.equals("640073") && !sGetUsr.equals("633007") && !sGetUsr.equals("634319") && !sGetUsr.equals("640790") && !sGetUsr.equals("640792") && !sGetUsr.equals("627018") && !sGetUsr.equals("627536") && !sGetUsr.equals("630208") && !sGetUsr.equals("629019") && !sGetUsr.equals("625384") && !sGetUsr.equals("630166") && !sGetUsr.equals("628997") && !"Y".equals(pbuser))

{
	if(  !sGetUsr.equals(purserEmpno)  ){	//非本班機座艙長，不得使用此功能
		response.sendRedirect("../showmessage.jsp?messagestring="+URLEncoder.encode("非本班機座艙長，不得使用此功能") );
	}

}		

ConnDB cn = new ConnDB();
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
		ResultSet.CONCUR_READ_ONLY);

//驗證報告是否已經送出
 sql = "select nvl(upd,'Y') upd from egtcflt where fltd = to_date('"+fdate+"','yyyy/mm/dd') "+
	 "and fltno = '"+fltno+"' and sect = '"+dpt+arv+"'";
	 
	myResultSet = stmt.executeQuery(sql); 
	
	if(myResultSet.next()){
		upd = myResultSet.getString("upd");
		if (upd.equals("N")){ //報告已送出不可修改
						
			try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
			try{if(stmt != null) stmt.close();}catch(SQLException e){}
			try{if(conn != null) conn.close();}catch(SQLException e){}
			response.sendRedirect("../showmessage.jsp?messagestring="+URLEncoder.encode("報告已送出，不得修改"));
			
			
		}
		
	}




sql = "select dt.* ,pi.itemdsc dsc from egtcmdt dt, egtcmpi pi "+
			  " where dt.itemno = pi.itemno and fltno='"+fltno+
			  "' and fltd=to_date('"+fdate+"','yyyy/mm/dd') "+
			  "and sect='"+dpt+arv+"'";

//			  out.print(sql);
myResultSet = stmt.executeQuery(sql);
	
	if(myResultSet.next()){
		myResultSet.last();
		count = myResultSet.getRow();//取得筆數
		myResultSet.beforeFirst();
	}

if(count >0){
	hasRecord = true;
	
}

%> 

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>檢視及新增其他事項View &amp; Add Flt Irregularity</title>
<link href="../style.css" rel="stylesheet" type="text/css">
<script src="checkDel.js" type="text/javascript"></script>
<script src="../js/CheckAll.js" language="javascript" type="text/javascript"></script>
<script src="../js/subWindow.js" language="javascript" type="text/javascript"></script>

<script language="JavaScript" type="text/JavaScript">

function sendReport(){	
	document.form2.Submit.disabled=1;
	document.form2.SendReport.disabled=1;
	
	<%
		if(hasRecord){
		
			out.print("document.form1.Submit.disabled=1;");
		}
	%>
	
	document.form2.action="upReportSave.jsp";
	document.form2.submit();
	//return true;
}

</script>
</head>

<body>


<form name="form1" onSubmit="return del('form1');" action="delFltIrr.jsp">

<div align="center">
<table width="90%"  border="0" cellspacing="0" cellpadding="2">
  <tr>
    <td>
      <div align="center"><span class="txttitletop">Self Inspection List </span></div>
    </td>
  </tr>
</table>
</div>
<table width="78%"  border="1" align="center" cellpadding="1" cellspacing="1" class="table_border2">        
	<tr class="tablebody">
	  <td width="25%"><div align="left">&nbsp;<strong>Date</strong>:<%=fdate_y%>Y&nbsp;<%=fdate_m%>&nbsp;M<%=fdate_d%>D</div></td>
    	<td width="25%"><div align="left">&nbsp;<strong>Flt</strong>:<%=allFltno%> 　</div></td>
    	<td width="25%"><div align="left">&nbsp;<strong>Purser</strong>：<%=purserName%></div></td>
    	<td width="25%"><div align="left">&nbsp;<strong>Inspector</strong>：<%=inspector%></div></td>
  	</tr> 
</table>
<%
//有資料才show
if(hasRecord){
	
%>

  <table width="78%"  border="0" align="center" cellpadding="2" cellspacing="0" class="table_border2">
    <tr class="tablehead3 fortable">
      <td width="11%"><input name="allchkbox" type="checkbox" onClick="CheckAll('form1','allchkbox')"> 
      Select
</td>
      <td colspan="2">Item</td>
      <td width="47%">Comments</td>
    </tr>
	<%
	while(myResultSet.next()){
		
		itemNoDsc 	= myResultSet.getString("dsc");
		itemDsc 	= myResultSet.getString("itemdsc");
		comm		= myResultSet.getString("comments");
		yearsern 	= myResultSet.getString("yearsern");
	%>
    <tr class="fortable">
      <td align="center" class="fortable"><input type="checkbox" value="<%=yearsern%>" name="delItem"></td>
      <td width="19%" class="fortable txtblue" align="left" ><a href="#" onClick="subwinXY('edFltIrr2.jsp?yearsern=<%=yearsern%>&purserEmpno=<%=purserEmpno%>','','700','350')"><u><%=itemNoDsc%></u></a></td>
      <td width="23%" class="fortable txtblue" ><%=itemDsc%></td>
      <td class="fortable txtblue"><%=comm%></td>
    </tr>
	<%
	
	}

	%>
  </table>
  <div align="center">
    <input name="Submit" type="submit" class="delButon" value="Delete Selected" >
	    <br>
         <span class="purple_txt"><strong>*Click Item to Edit
  </strong></span></div>
  <%
  
  }	  //End of if have record
  %>
	    <input type="hidden" name="fdate" value="<%=fdate%>">
        <input type="hidden" name="fltno" value="<%=fltno%>">	
		<input type="hidden" name="acno" value="<%=acno%>">	
        <input type="hidden" name="dpt" value="<%=dpt%>">		
		<input type="hidden" name="arv" value="<%=arv%>">	
		<input type="hidden" name="GdYear" value="<%=GdYear%>">
 		<input type="hidden" name="purserEmpno" value="<%=purserEmpno%>">	
		<input type="hidden" name="psrname" value="<%=psrname%>">	
 		<input type="hidden" name="psrsern" value="<%=psrsern%>">	
  
</form>
  <hr noshade>


<form name="form2" method="post" action="upFltIrr.jsp" onSubmit="">
  <table width="78%"  border="0" align="center" cellpadding="2" cellspacing="0" >
    <tr >
      <td colspan="2" class="txttitle" >
        <div align="center">Add Comments</div>
      </td>
    </tr>
  </table>
  <table width="78%"  border="0" align="center" cellpadding="2" cellspacing="0" class="table_border2">
    <tr >
      <td  class="tablehead3 fortable">Item</td>
      <td class="fortable">
		  <select name="item1" OnChange="Buildkey(this.selectedIndex);">
<%@ include file="select1.jsp"%>


		</select> 
		    <select name="item2" OnChange="Buildkey1(this.selectedIndex);"  >
<%@ include file="select2.jsp"%>
	        </select>
			<select  name="item3">

<%@ include file="select3.jsp"%>

            </select>      
	  </td>
    </tr>
    <tr >
      <td height="59"class="tablehead3 fortable">Comments</td>
      <td class="fortable">
         <textarea name="comm" cols="50" rows="4"></textarea>
      </td>
    </tr>
  </table>
  <div align="center">
    <input type="submit" name="Submit" value="Save (新增)" class="addButton" >&nbsp;&nbsp;&nbsp;
	<input name="SendReport" type="button" class="addButton" value="Next(下一步)" onClick="sendReport()">&nbsp;&nbsp;&nbsp;
	<input name="reset" type="reset" value="Reset (清除重寫)">
        <input type="hidden" name="fltd" value="<%=fdate%>">
        <input type="hidden" name="fltno" value="<%=fltno%>">		
        <input type="hidden" name="dpt" value="<%=dpt%>">		
		<input type="hidden" name="arv" value="<%=arv%>">	
 		<input type="hidden" name="purserEmpno" value="<%=purserEmpno%>">	
		<input type="hidden" name="psrname" value="<%=psrname%>">	
 		<input type="hidden" name="psrsern" value="<%=psrsern%>">	
		
		<input type="hidden" name="fdate" value="<%=fdate%>">
		<input type="hidden" name="acno" value="<%=acno%>">	
		<input type="hidden" name="GdYear" value="<%=GdYear%>">
		<input type="hidden" name="ispart2" value="Y">	
		<br>
  <span class="txtxred">Input comments max length English 1500 words、Chinese 750 words</span> </div>
</form>
<p align="center">&nbsp;</p>
</body>
</html>

<%

}
catch (Exception e)
{
	 out.print(e.toString());
	 //  response.sendRedirect("../showmessage.jsp?messagestring="+URLEncoder.encode("系統忙碌中，請稍後再試"));
}
finally
{
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>