<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="ci.db.*,fz.*,java.sql.*,java.net.URLEncoder,fz.pracP.*,java.util.ArrayList" %>
<%
//�s�W�B�R��Flt Irregularity
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if ( sGetUsr == null) {		//check user session start first or not login
	//response.sendRedirect("../sendredirect.jsp");
	
}


boolean hasRecord = false;
boolean isZ = false;

if(!"".equals(request.getParameter("isZ")) && null != request.getParameter("isZ")){
	isZ = true;
}


//String GdYear = "2005";//request.getParameter("GdYear");
String fdate = request.getParameter("fdate"); //2005/07/07
//���o���Z�~��
String GdYear = fz.pracP.GdYear.getGdYear(fdate);

String fltno = request.getParameter("fltno"); //003
String dpt = request.getParameter("dpt"); //SFO
String arv = request.getParameter("arv"); //TPE
String acno = request.getParameter("acno"); //18201
session.setAttribute("fz.acno",acno);
//out.print("acno="+acno);
//String GdYear = request.getParameter("GdYear");

//String itemNo = null;
String itemNoDsc = null;//�j�����ԭz
String itemDsc = null;//�Ӷ����ԭz
String comm	= null;
String yearsern = null;//�y����
String clb  = "";
String mcr="";

int count = 0;  
Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
ResultSet myResultSet = null;

//modify by cs66 2005/2/23�A�]�e��FltIrrList�w���ҡA���B���A���ҬO�_���y�����A
String purserEmpno  = request.getParameter("pur");
/*
chkUser ck = new chkUser();
ck.findCrew(sGetUsr);
//�n�J�̪�empno,sern,name,group
String psrsern	= ck.getSern();
String psrname	= ck.getName();
String pgroups = ck.getGroup();
*/

//���o�y�������
String psrsern	 = null;
String psrname	 = null;
String pgroups = null;
fzac.CrewInfo cInfo = new fzac.CrewInfo(purserEmpno);
aircrew.CrewCName cc = new aircrew.CrewCName();
if( cInfo.isHasData()){
	fzac.CrewInfoObj cObj= cInfo.getCrewInfo();
	psrsern =cObj.getSern();
//	psrname =cObj.getCname();
	psrname = cc.getCname(purserEmpno);
	pgroups =cObj.getGrp();
}




//�n���Ǯɸ�T
fz.pracP.BordingOnTime borot = new fz.pracP.BordingOnTime(fdate,fltno,dpt+arv,purserEmpno);
try {
	borot.SelectData();
//	System.out.println("�O�_��flight��ơG" + borot.isHasFlightInfo());
//	System.out.println("�O�_���n����ơG" + borot.isHasBdotInfo());

} catch (SQLException e) {
	System.out.print(e.toString());
} catch (Exception e) {
	System.out.print(e.toString());
}

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

		response.sendRedirect("../showmessage.jsp?messagestring="+URLEncoder.encode("�D���Z���y�����A���o�ϥΦ��\��") );
		
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
			response.sendRedirect("../showmessage.jsp?messagestring="+URLEncoder.encode("���i�w�e�X�A���o�ק�"));
			
			
		}
		
	}




sql = "select dt.* ,pi.itemdsc dsc from egtcmdt dt, egtcmpi pi "+
			  " where dt.itemno = pi.itemno and fltno='"+fltno+
			  "' and fltd=to_date('"+fdate+"','yyyy/mm/dd') "+
			  "and sect='"+dpt+arv+"'";

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

<jsp:include page="select.jsp" />


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
	if(len >3000){	//column��쭭�4000�A��J��3500�Ӧr��
		alert("Comments�r���ƭ��4000�Ӧr���A\n�ҿ�J�r�ƶW�L"+(len-3500)+"�Ӧr���A�Э��s��J");
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
//TODO�b���B����n���Ǯɸ�T������J
function sendReport(){	
	
	
	<%
		if(hasRecord){
		
			out.print("document.form1.Submit.disabled=1;");
		}

		if( !borot.isHasBdotInfo()){
		

	%>
			alert("Crew Boarding on Time ��T������J,���e�X���i!!\n"
			+"�п�J�n���ɶ��A\n���I�� Update Boarding On Time ���s.");
			document.getElementById("bdtm").focus();
			

		return false;
	<%
		}else{
		String submitPage = "upReportSave.jsp";
		if(isZ){
		submitPage= "upReportSaveZ.jsp";
		}
	
	%>
		document.form2.Submit.disabled=1;
		document.form2.SendReport.disabled=1;
		document.form2.action="<%=submitPage%>";
		document.form2.submit();
	<%
	}
	%>
		

	//return true;
}

function showBt(flag){
	if("1" == flag){	//��ܷǮɬ�Y
		document.getElementById("botN").style.display="none";
		document.getElementById("bdtm").focus();
	}else{	//��ܷǮɬ�N
		document.getElementById("botN").style.display="";
		document.getElementById("bdtm").focus();
		document.getElementById("bdreason").style.background="#FFFFCC";
	}

}
function initBt(){//��l�Ƶn���Ǯɸ�T
	<%
	if ( !borot.isHasFlightInfo()
		| (borot.isHasFlightInfo() && !borot.isHasBdotInfo() ) ) { //�w�]�Ȭ��Ǯ�
	%>
		document.getElementById("bdotY").checked=true;
		document.getElementById("bdotN").checked=false;
		showBt(1);
	<%
	}else{
		if("Y".equals(borot.getBdot())){
%>
		document.getElementById("bdotY").checked=true;
		document.getElementById("bdotN").checked=false;
		showBt(1);
<%		}else{
%>
		document.getElementById("bdotY").checked=false;
		document.getElementById("bdotN").checked=true;
		<%
		String str = "";
		if(borot.getBdReason() != null){
			str = ci.tool.ReplaceAllFor1_3.replace(borot.getBdReason(),"\"","\\\"");
		}
		%>
		document.getElementById("bdreason").value="<%=str%>";		
		
		
	showBt(2);
<%		}
	%>
	
		document.getElementById("bdtmyyyy").value="<%=borot.getBdtmYear()%>";
		document.getElementById("bdtmmm").value="<%=borot.getBdtmMonth()%>";
		document.getElementById("bdtmdd").value="<%=borot.getBdtmDay()%>";
		document.getElementById("bdtm").value="<%=borot.getBdtmHM()%>";


		
		
	<%	
	}
	%>
}

function chkBdot(){
	//��ܤ��ǮɡA�ݿ�J�ɶ��βz��
	var bdr = document.getElementById("bdreason").value;
	var bdtm = document.getElementById("bdtm").value;
	if(document.getElementById("bdotN").checked ){
		if("" == bdtm | bdtm.length !=4 ){
			alert("�п�J�n���ɶ�(HHMM)");
			document.getElementById("bdtm").focus();
			return false;
		}else if("2400"==bdtm){
			alert("�n���ɶ��A�ж�24�p�ɨ�\n��0000 ~ 2359.");
			document.getElementById("bdtm").focus();
			return false;
		}else if( "" == bdr){
			alert("�п�J���Ǯɭ�]!!");
			document.getElementById("bdreason").focus();
			return false;
		}else{
			document.getElementById("bdsb").disabled=1;
			return true;
		
		}
	}else{
		if("" == bdtm | bdtm.length !=4 ){
			alert("�п�J�n���ɶ�(HHMM)");
			document.getElementById("bdtm").focus();
			return false;
		}else if("2400"==bdtm){
			alert("�n���ɶ��A�ж�24�p�ɨ�\n��0000 ~ 2359.");
			document.getElementById("bdtm").focus();
			return false;
		}else{
			document.getElementById("bdsb").disabled=1;
			return true;			
		}
	}
}

function setdisp()
{//SR9019
    document.form2.item1.value = "�խ�����";
	Buildkey(document.form2.item1.selectedIndex);
	document.form2.item2.value = "�{�ɼu��";
	Buildkey1(document.form2.item2.selectedIndex);
}

</script>
</head>

<body onLoad="initBt()">
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
      <td width="25%" class="txtblue">Sector:<span class="txtxred"><%=dpt%><%=arv%></span></td>
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
      <td width="38%">Comments</td>
      <td width="4%">CLB</td>
 	 <td width="5%">Meal<br>
      Check</td>
    </tr>
	<%
	while(myResultSet.next()){
		clb="";
		mcr="";
		
		itemNoDsc 	= myResultSet.getString("dsc");
		itemDsc 	= myResultSet.getString("itemdsc");
		comm		= myResultSet.getString("comments");
		yearsern 	= myResultSet.getString("yearsern");
		if("Y".equals(myResultSet.getString("clb"))){	clb="YES";}else if("N".equals(myResultSet.getString("clb"))){clb="NO";}
		if("Y".equals(myResultSet.getString("mcr"))){	mcr="YES";}else if("N".equals(myResultSet.getString("mcr"))){mcr="NO";}

	%>
    <tr class="fortable">
      <td align="center" class="fortable"><input type="checkbox" value="<%=yearsern%>" name="delItem"></td>
      <td width="10%" class="fortable txtblue" align="left" ><a href="#" onClick="subwinXY('edFltIrr2.jsp?isZ=<%=request.getParameter("isZ")%>&yearsern=<%=yearsern%>&purserEmpno=<%=purserEmpno%>&pur=<%=purserEmpno%>','','700','350')"><u><%=itemNoDsc%></u></a></td>
      <td width="16%" class="fortable txtblue" ><%=itemDsc%></td>
      <td class="fortable txtblue"><%=comm%></td>
      <td class="fortable txtblue">&nbsp;<%=clb%> </td>
      <td class="fortable txtblue">&nbsp;<%=mcr%> </td>
    </tr>
	<%
	
	}

	%>
  </table>
  <div align="center">
    <input name="Submit" type="submit" class="delButon" value="Delete Selected" >
  <br><span class="purple_txt"><strong>*Click Item to Edit
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
		  <input type="hidden" name="pur" value="<%=purserEmpno%>">
		  <input type="hidden" name="isZ" value="<%=request.getParameter("isZ")%>">

</form>
<%
ArrayList filename = new ArrayList();
ArrayList filedsc = new ArrayList();
count = 0;

myResultSet = stmt.executeQuery("select filename, filedsc from egtfile where fltd=to_date('"+fdate+"','yyyy/mm/dd') and fltno='"+fltno+"' and sect='"+dpt+arv+"'");
while(myResultSet.next()){
	filename.add(myResultSet.getString("filename"));
	filedsc.add(myResultSet.getString("filedsc"));
	count++;
}
if(count > 0){
%>
<table width="78%"  border="0" align="center" cellpadding="2" cellspacing="0" class="fortable">
  <tr class="tablehead3">
    <td width="13%">&nbsp;</td>
    <td width="51%">FileName</td>
    <td width="36%">Description</td>
  </tr>
  <%
  for(int i=0; i < filename.size(); i++){
  %>
  <tr>
    <td class="fortable txtblue">
      <div align="center">
        <input type="button" value="DELETE" onClick="if(confirm('�T�w�n�R���ɮסG<%=filename.get(i)%> ?')){self.location='FTP/delFile.jsp?isZ=<%=request.getParameter("isZ")%>&fdate=<%=fdate%>&fltno=<%=fltno%>&dpt=<%=dpt%>&arv=<%=arv%>&uploadFileName=<%=filename.get(i)%>&purserEmpno=<%=purserEmpno%>&acno=<%=acno%>';this.disabled=1;}else{return false;}" style="background-color:#BFE4FF;color:#00487D;font-family:Verdana ">
      </div>
    </td>
    <td class="fortable txtblue"><a href="http://cabincrew.china-airlines.com/prpt/<%=filename.get(i)%>" target="_blank"><%=filename.get(i)%></a></td>
    <td class="fortable txtblue"><%=filedsc.get(i)%></td>
  </tr>
  <%
  }
  %>
</table>
<%
}
%>
<div align="center">
  <input name="upload" type="button" class="addButton" value="Upload(�W���ɮ�)" onClick="subwinXY('FTP/uploadfile.jsp?isZ=<%=request.getParameter("isZ")%>&fdate=<%=fdate%>&fltno=<%=fltno%>&dpt=<%=dpt%>&arv=<%=arv%>&purserEmpno=<%=purserEmpno%>&acno=<%=acno%>','delUpload','700','350')">
  <br>
 </div>
<hr noshade>
<%

//���o�y��������T

%>
<form name="bdForm" method="post" action="updBdot.jsp" onsubmit="return chkBdot()">
<table align="center"  width="78%">
<tr><td colspan="2">

&nbsp;&nbsp;<span style="background-color:#3366CC;color:#FFFFFF;font-size:10pt;padding:2pt;font-family:Verdana "><br>
Crew Boarding On Time </span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="guide/bot/index.htm" target="_blank"><span style="color:#FF0000;text-decoration:underline;font-weight:bold ">�ϥλ���</span></a><br>
</td>
</tr>
<tr>
  <td width="2%">&nbsp;</td>
  <td width="98%"><span class="txtblue">�խ��n���ǮɡG
      <label>
      <input type="radio" name="bdot" value="Y"  onClick="showBt(1)" id="bdotY">
      <span class="txtxred">Yes</span></label>
      <label>
      <input type="radio" name="bdot" value="N" onClick="showBt(2)" id="bdotN">
      </label>
  </span>
    <label><span class="txtblue">No</span></label>
	<br>
    <span class="txtblue"> 
�խ��n���ɶ��G
<input type="text" name="bdtmyyyy" value="<%=fdate.substring(0,4)%>" size="4" maxlength="4" id="bdtmyyyy">
/
<input type="text" name="bdtmmm" value="<%=fdate.substring(5,7)%>" size="2" maxlength="2" id="bdtmmm">
/
<input type="text" name="bdtmdd" value="<%=fdate.substring(8)%>" size="2" maxlength="2" id="bdtmdd">
<input  type="text" name="bdtm" size="4" maxlength="4" id="bdtm" style="background-color:#FFFFCC " >
(yyyy/mm/dd HHMM) ,�ɶ��ж�24�p�ɨ�(0000~2359)<br>
    </span>
<div style="display:none " id="botN">
<span class="txtblue"> ���Ǯɭ�]�G
<input type="text" name="bdreason" maxlength="150" size="50" id="bdreason"><br>
<span class="txtxred">�п�J300�ӭ^��r,��150�Ӥ���r�H�����ԭz.</span>    
	</div>
  </td>
</tr>
<tr>
  <td colspan="2">
    <input type="submit" name="Submit" value="Update Boarding On Time" style="background-color:#3366CC;color:#FFFFFF;font-family:Verdana " id="bdsb">
	<input type="reset" value="Reset">
		<input type="hidden" name="fdate" value="<%=fdate%>">
		<input type="hidden" name="fltno" value="<%=fltno%>">	
		<input type="hidden" name="acno" value="<%=acno%>">	
		<input type="hidden" name="sect" value="<%=dpt+arv%>">		
		<input type="hidden" name="purserEmpno" value="<%=purserEmpno%>">	
		<input type="hidden" name="psrname" value="<%=psrname%>">	
		<input type="hidden" name="psrsern" value="<%=psrsern%>">
		<input type="hidden" name="pgroups" value="<%=pgroups%>">
		  <input type="hidden" name="GdYear" value="<%=GdYear%>">
		<input type="hidden" name="isZ" value="<%=request.getParameter("isZ")%>">
		  
  </td>
  </tr>
</table>
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
<jsp:include page="select1.jsp" />
		</select> 
		    <select name="item2" OnChange="Buildkey1(this.selectedIndex);"  >
<jsp:include page="select2.jsp" />
		
        </select>
			<select  name="item3">
<jsp:include page="select3.jsp" />

            </select>      
	<!--SR9019-->
	  &nbsp;<input type="button" onclick = "setdisp();" class="fortable" value="�u��">	
	<!--SR9019-->
	  </td>
    </tr>
    <tr >
      <td height="59"class="tablehead3 fortable">Comments</td>
      <td class="fortable">
         <textarea name="comm" cols="50" rows="4"></textarea>
      </td>
    </tr>
    <tr >
      <td height="50" colspan="2" class="txtblue">1. �w�xCLB�G
        <label>
  <input type="radio" name="clb" value="Y">
  <span class="txtxred">YES</span></label>
         
        <label>
        <input  type="radio" name="clb" value="N">
  NO</label>
       <br>
      2. �w�xIn Flight Meal Check Report�G
<label><input type="radio" name="mcr" value="Y">
  <span class="txtxred">YES</span></label>
        <label>
        <input type="radio" name="mcr" value="N">
  NO</label>
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
		<input type="hidden" name="isZ" value="<%=request.getParameter("isZ")%>">
		<br>
  <span class="txtxred">Input comments max length English 4000 words�BChinese 2000 words</span> </div>
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