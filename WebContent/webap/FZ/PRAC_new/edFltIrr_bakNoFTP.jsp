<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="ci.db.*,fz.*,java.sql.*,java.net.URLEncoder,fz.pracP.*,java.util.ArrayList" %>
<%
//�s�W�B�R��Flt Irregularity
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if ( sGetUsr == null) {		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
	
}

 /*
//����ʺA���
ThreeSelect ts = new ThreeSelect();
ts.getStatement();
String getItem1 = ts.getItem1();//�Ĥ@�h���
String getItem2 = ts.getItem2();//�ĤG�h���
//out.print(getItem2);
String getItem3= ts.getItem3();//�ĤT�h���
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
String itemNoDsc = null;//�j�����ԭz
String itemDsc = null;//�Ӷ����ԭz
String comm	= null;
String yearsern = null;//�y����


int count = 0;  
Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
ResultSet myResultSet = null;

//************************************Get live sche table
ctlTable ct = new ctlTable();
ct.doSet();
//modify by cs66 2005/2/23�A�]�e��FltIrrList�w���ҡA���B���A���ҬO�_���y�����A
String purserEmpno  = request.getParameter("pur");

chkUser ck = new chkUser();
ck.findCrew(sGetUsr);
//�n�J�̪�empno,sern,name,group
String psrsern	= ck.getSern();
String psrname	= ck.getName();
String pgroups = ck.getGroup();



String sql = null;
String upd = null;
try{
//modify by cs66 at 2005/02/23,marked���ҳ����A�]FltIrr�w����...���B���ݦA���ҬO�_��Purser
/*


//���ҬO�_��Purser
String sqlPurser = "select a.empno empno, b.ename ename,b.name cname, b.occu occu,Trim(eg.groups) groups,Trim(eg.sern) sern "+
				"from "+ct.getTable()+" a, fztcrew b,egtcbas eg "+
				"where (a.empno=b.empno AND a.empno = Trim(eg.empn) ) and a.empno not in ('593027','625303','625304','628484','628539','628997','625296') "+
				"AND SubStr(Trim(a.qual),1,1) ='P' and a.spcode not in ('I','S') and a.dh <> 'Y' "+	//purser��queal��PM��P
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
*/

String pbuser = (String)session.getAttribute("pbuser");

//���ҬO�_��Purser
//�i�ϥΪ�:cs55,cs66,cs27,cs40,cs71,cs73
//�s�W630166 ->�N���R�A.....EF�H��

if(!sGetUsr.equals("638716") && !sGetUsr.equals("640073") && !sGetUsr.equals("633007") && !sGetUsr.equals("634319") && !sGetUsr.equals("640790") && !sGetUsr.equals("640792") && !sGetUsr.equals("627018") && !sGetUsr.equals("627536") && !sGetUsr.equals("630208") && !sGetUsr.equals("629019") && !sGetUsr.equals("625384") && !sGetUsr.equals("630166") && !sGetUsr.equals("628997") && !"Y".equals(pbuser))

{
	//modify by cs66 at 2005/2/21 
	/*
	purserEmpno  �� sql select�X�Ӫ��Ĥ@�ӫDS�ΫDI ��purser empno
	pur ���W�@���ǨӪ�purser empno
	�S���p�|�X�{�A�ӯZpurser�A�ëDselect�X�Ӫ����u���A
	�]�W�@���|��ܨ�Ӯy�����A�ҥH�Y�ǤJ�����u�����n�J�̡A�h�i�s�覹�����i
	
	*/
	//if(  !sGetUsr.equals(purserEmpno) &&!sGetUsr.equals(pur) ){	
	if(!sGetUsr.equals(purserEmpno)){

		response.sendRedirect("../showMessage.jsp?messagestring="+URLEncoder.encode("�D���Z���y�����A���o�ϥΦ��\��") );
		
	}

}		

ConnDB cn = new ConnDB();
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
		ResultSet.CONCUR_READ_ONLY);

//���ҳ��i�O�_�w�g�e�X
 sql = "select nvl(upd,'Y') upd from egtcflt where fltd = to_date('"+fdate+"','yyyy/mm/dd') "+
	 "and fltno = '"+fltno+"' and sect = '"+dpt+arv+"'";
	 
	myResultSet = stmt.executeQuery(sql); 
	
	if(myResultSet.next()){
		upd = myResultSet.getString("upd");
		if (upd.equals("N")){ //���i�w�e�X���i�ק�
						
			try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
			try{if(stmt != null) stmt.close();}catch(SQLException e){}
			try{if(conn != null) conn.close();}catch(SQLException e){}
			response.sendRedirect("../showMessage.jsp?messagestring="+URLEncoder.encode("���i�w�e�X�A���o�ק�"));
			
			
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
		count = myResultSet.getRow();//���o����
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
<title>�˵��ηs�W��L�ƶ�View &amp; Add Flt Irregularity</title>
<link href="style2.css" rel="stylesheet" type="text/css">
<script src="checkDel.js" type="text/javascript"></script>
<script src="../../js/CheckAll.js" language="javascript" type="text/javascript"></script>
<script src="../../MT/js/subWindow.js" language="javascript" type="text/javascript"></script>

<script language="JavaScript" type="text/JavaScript">
//�]�w�ʺA�����--���J�}�C�r��
<%@ include file="select.jsp"%>



function Buildkey(num)
{
Buildkey1(0);
document.form2.item2.selectedIndex=0;
for(ctr=0;ctr<array02[num].length;ctr++)
{
document.form2.item2.options[ctr]=new Option(array02[num][ctr],array02[num][ctr]);
}
document.form2.item2.length=array02[num].length;
}

function Buildkey1(num)
{
document.form2.item3.selectedIndex=0;
for(ctr=0;ctr<array03[document.form2.item1.selectedIndex][num].length;ctr++)
{
document.form2.item3.options[ctr]=new Option(array03[document.form2.item1.selectedIndex][num][ctr],array03[document.form2.item1.selectedIndex][num][ctr]);
}
document.form2.item3.length=array03[document.form2.item1.selectedIndex][num].length;
}


function checkCharacter(){

	var message = document.form2.comm.value;
	var len = document.form2.comm.value.length;
		//alert(len);
	if(len >800){	//column��쭭�1000�A��J��800�Ӧr��
		alert("Comments�r���ƭ��1000�Ӧr���A\n�ҿ�J�r�ƶW�L"+(len-800)+"�Ӧr���A�Э��s��J");
		document.form2.comm.focus();
		return false;
	}
	else if(len == ""){
		if(confirm("�|�����Comments�ԭz�A�T�w�n�e�X�H")){
		document.form2.Submit.disabled=1;
		document.form2.SendReport.disabled=1;
		<%
			if(hasRecord){
				out.print("document.form1.Submit.disabled=1;");
			}
		%>		
			return true;
		}
		else{
			document.form2.comm.focus();
			return false;
		}
	}
	else{
		document.form2.Submit.disabled=1;
		document.form2.SendReport.disabled=1;
		<%
			if(hasRecord){
				out.print("document.form1.Submit.disabled=1;");
			}
		%>		
		return true;
	}
}

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
      <div align="center"><span class="txttitletop">Flt Irregularity</span></div>
    </td>
  </tr>
</table>
</div>
  <table width="78%"  border="0" align="center" cellpadding="2" cellspacing="0" >
    <tr>
      <td width="27%" class="txtblue">FltDate:<span class="txtxred"><%=fdate%></span></td>
      <td width="23%" class="txtblue">Fltno:<span class="txtxred"><%=fltno%></span></td>
      <td width="25%" class="txtblue">Sec:<span class="txtxred"><%=dpt%><%=arv%></span></td>
      <td width="25%" class="txtblue">ACNO:<span class="txtxred"><%=acno%></span></td>
    </tr>
  </table>
<%
//����Ƥ~show
if(hasRecord){
	
%>

  <table width="78%"  border="0" align="center" cellpadding="2" cellspacing="0" class="fortable">
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
      <td width="19%" class="fortable txtblue" align="left" ><a href="#" onClick="subwinXY('edFltIrr2.jsp?yearsern=<%=yearsern%>&purserEmpno=<%=purserEmpno%>&pur=<%=purserEmpno%>','','700','350')"><u><%=itemNoDsc%></u></a></td>
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
  <p>
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
		  	<input type="hidden" name="pur" value="<%=purserEmpno%>">
  </p>
  <p>&nbsp;</p>
</form>
  <hr noshade>


<form name="form2" method="post" action="upFltIrr.jsp" onSubmit="return checkCharacter()">
  <table width="78%"  border="0" align="center" cellpadding="2" cellspacing="0" >
    <tr >
      <td colspan="2" class="txttitle" >
        <div align="center">Add Comments</div>
      </td>
    </tr>
  </table>
  <table width="78%"  border="0" align="center" cellpadding="2" cellspacing="0" class="fortable">
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
    <input type="submit" name="Submit" value="Save (�s�W)" class="addButton" >&nbsp;&nbsp;&nbsp;
	<input name="SendReport" type="button" class="addButton" value="Next(�U�@�B)" onClick="sendReport()">&nbsp;&nbsp;&nbsp;
	<input name="reset" type="reset" value="Reset (�M�����g)">
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
		<input type="hidden" name="pur" value="<%=purserEmpno%>">
		<br>
  <span class="txtxred">Input comments max length English 1500 words�BChinese 750 words</span> </div>
</form>
<p align="center">&nbsp;</p>
</body>
</html>

<%

}
catch (Exception e)
{
	 out.print(e.toString());
	 //  response.sendRedirect("../showMessage.jsp?messagestring="+URLEncoder.encode("�t�Φ��L���A�еy��A��"));
}
finally
{
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>