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
<title></title>
<link href="style2.css" rel="stylesheet" type="text/css">

<style type="text/css">
<!--
.style1 {
	font-size: x-large;
	font-weight: bold;
}
.style4 {font-size: medium}
.style5 {
	font-size: x-small;
	font-weight: bold;
}
.style6 {font-size: small}
.style8 {color: #000000}
.style10 {font-size: small; font-weight: bold; color: #000000; }
-->
</style>
</head>
<body>
  <div align="center">
<%
//************************************2.Get live sche table
ctlTable ct = new ctlTable();
ct.doSet();

String f = request.getParameter("f");//F艙人數
String c = request.getParameter("c");//C艙人數
String y = request.getParameter("y");//C艙人數
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
String purserEmpno = null;
String psrsern	= null;
String psrname	= null;
String pgroups = null;


ArrayList sern	 = new ArrayList();
ArrayList cname	 = new ArrayList();
ArrayList groups = new ArrayList();
ArrayList qual = new ArrayList();

Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
ResultSet myResultSet = null;
boolean t = false;
String sql = null;
String CACName =null;
String CAEName =null;
String CAEmpno = null;


//驗證是否為Purser
String sqlPurser = "select a.empno empno, b.ename ename,b.name cname, b.occu occu,Trim(eg.groups) groups,Trim(eg.sern) sern "+
				"from "+ct.getTable()+" a, fztcrew b,egtcbas eg "+
				"where (a.empno=b.empno AND a.empno = Trim(eg.empn) ) AND SubStr(Trim(a.qual),1,1) ='P' and a.spcode not in ('I','S') and a.dh <> 'Y' "+	//purser的queal為PM或P
				"and a.fdate='"+fdate+"' "+
				"and dpt='"+dpt+"' and arv='"+arv+"' and trim(dutycode)='"+fltno+"'";


//out.print(sqlPurser);
				
//抓CA	資料
String sqlCA = "select a.empno empno, b.ename ename,b.name cname, a.occu occu "+
				"from "+ct.getTable()+" a, fztcrew b "+
				"where a.empno=b.empno AND (Trim(b.occu) ='CA'  AND a.dh <> 'Y' AND a.dh IS NOT NULL) "+	
				"and a.fdate='"+fdate+"' "+
				//"and dpt='"+tf.da13ToFz(dpt)+"' and arv='"+tf.da13ToFz(arv)+"' and LPad(trim(a.dutycode),4,'0')='"+fltno+"' "+
				"and dpt='"+dpt+"' and arv='"+arv+"' and trim(a.dutycode)='"+fltno+"' "+
				"ORDER BY a.empno";

//登機準時資訊
fz.pr.orp3.BordingOnTime borot =null; 

				
try{

dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
conn = dbDriver.connect("jdbc:weblogic:pool:CAL.FZCP02", null);
stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
		ResultSet.CONCUR_READ_ONLY);

//抓取該班組員名單
sql = "select a.groups groups,b.name cname, to_number(b.box) sern,a.dh dh,a.qual qual " +
"from "+ct.getTable()+" a, fztcrew b where a.empno=b.empno " +
"and b.occu in ('FA','FS') " +
"and a.fdate='"+fdate+"' and dpt='"+dpt+"' and arv='"+arv+"' " +
"and trim(a.dutycode)='"+fltno+"' and (a.dh <> 'Y' or a.dh is null) " +
"order by sern";


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
		response.sendRedirect("../showmessage.jsp?messagestring="+URLEncoder.encode("非本班機座艙長，不得使用此功能") );
	}
}*/
//抓CA的資料，若有多個CA：依照員工號排序後抓第一筆
myResultSet	= stmt.executeQuery(sqlCA);
if(myResultSet.next()){
		CACName	= myResultSet.getString("cname");
		CAEName = myResultSet.getString("ename");
		CAEmpno	= myResultSet.getString("empno");
}
//String CA = CAEmpno+"&nbsp;"+CACName+"&nbsp;"+CAEName;
myResultSet.close();

//登機準時資訊
borot = new fz.pr.orp3.BordingOnTime(fdate,fltno,dpt+arv,purserEmpno);
try {
	borot.SelectData();
	
	//System.out.println("是否有flight資料：" + borot.isHasFlightInfo());
//	System.out.println("是否有登機資料：" + borot.isHasBdotInfo());

} catch (SQLException e) {
	System.out.print(e.toString());
} catch (Exception e) {
	System.out.print(e.toString());
}


%> 
  </div>
  <div align="center">
  <span class="style1">CABIN CREW DIVISION</span><BR>
  <span class="style4">PURSER'S TRIP REPORT(PART I)
  </span></div>
  <table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
	  <td colspan="3"><div align="right"><a href="javascript:window.print()"><img src="../images/print.gif" width="17" height="15" border="0" alt="列印"></a></div></td>
    </tr>
    <tr>
      <td><strong>I.</strong>Pur : <%=psrname%></td>
	  <td><div align="center">Group : 1</div></td>
	  <td><div align="center">Serial No : <%=psrsern%></div></td>
    </tr>
    <tr>
      <td>Date : <%=fdate%></td>
	  <td>CI<%=fltno%>&nbsp;&nbsp;<%=dpt%> / <%=arv%></td>
	  <td><div align="right">Capt&nbsp;&nbsp;<%=CACName%>&nbsp;&nbsp;A/C&nbsp;<%=acno%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Pax F : <%=f%>&nbsp;C : <%=c%>&nbsp;Y : <%=y%></div></td>
    </tr>
</table>
  <table width="100%"  border="1" align="center" cellpadding="0" cellspacing="0" >
    <tr bgcolor="#CCCCCC">
      <td><div align="center" class="style5 style6 style8">Duty</div></td>
      <td><div align="center" class="style10">S.No</div></td>
      <td><div align="center" class="style10">Name</div></td>
      <td><div align="center" class="style10">GRP</div></td>
	  <td><div align="center" class="style10">Qual</div></td>
      <td><div align="center" class="style10">GRD</div></td>
	  <td><div align="center" class="style10">Duty</div></td>
      <td><div align="center" class="style10">S.No</div></td>
      <td><div align="center" class="style10">Name</div></td>
      <td><div align="center" class="style10">GRP</div></td>
	  <td><div align="center" class="style10">Qual</div></td>
      <td><div align="center" class="style10">GRD</div></td>
<!--	
       <td><div align="center" class="style10">Duty</div></td>
       <td><div align="center" class="style10">S.No</div></td>
      <td><div align="center" class="style10">Name</div></td>
      <td><div align="center" class="style10">GRP</div></td>
      <td><div align="center" class="style10">GRD</div></td> 
-->
    </tr>
<%
int rCount = 0;
myResultSet	= stmt.executeQuery(sql);

if(myResultSet != null){
	while(myResultSet.next()){
		 sern.add(myResultSet.getString("sern"));
		 cname.add(myResultSet.getString("cname"));
		 groups.add(myResultSet.getString("groups"));
		 qual.add(myResultSet.getString("qual"));
	}
}
for(int i=0; i<21; i++){
	rCount++;
	if(rCount > 2 ){
		rCount = 1;
	}
	if(rCount == 1){
%>
		<tr>
<%
	}
	if(i<sern.size()){
%>
      <td height="26" bgcolor="#CCCCCC"><div align="center" class="style4">&nbsp;</div></td>
      <td height="26"><div align="center" class="style4"><%=sern.get(i)%></div></td>
      <td height="26"><div align="center" class="style4"><%=cname.get(i)%></div></td>
      <td height="26"><div align="center" class="style4"><%=groups.get(i)%></div></td>
	  <td height="26"><div align="center" class="style4"><%=qual.get(i)%></div></td>
      <td height="26"><div align="center" class="style4">&nbsp;</div></td>
<%
	}
	else{
%>
      <td height="26" bgcolor="#CCCCCC"><div align="center" class="style4">&nbsp;</div></td>
      <td height="26"><div align="center" class="style4">&nbsp;</div></td>
      <td height="26"><div align="center" class="style4">&nbsp;</div></td>
      <td height="26"><div align="center" class="style4">&nbsp;</div></td>
      <td height="26"><div align="center" class="style4">&nbsp;</div></td>
	  <td height="26"><div align="center" class="style4">&nbsp;</div></td>
<%
	}
	if(rCount == 3){
		
%>
		</tr>
<%
	}
}
%>
</table>
<br>
  <table width="100%" height="354"  border="1" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td height="37" valign="middle"><p><strong>II.The Best Performance : F : _________________ C : _________________ Y : _________________</strong></p>      </td>
    </tr>
				<%
		
		
		if(borot.isHasBdotInfo()){
		%>
		<tr>
            <td >登機準時：<%=borot.getBdot()%><br>
			登機時間：<%=borot.getBdtmYear()+"/"+borot.getBdtmMonth()+"/"+borot.getBdtmDay()+" "+borot.getBdtmHM()%><br>
			<%
			if("N".equals(borot.getBdot())){
			%>
		
			不準時理由：<%=borot.getBdReason()%>
			<%
			}
			%>
			
			</td>
          </tr>
		  <%
		  }
		  %>

    <tr>
      <td height="315" valign="top"><strong>III.Crew Evaluation/Flt Irregularity : </strong></td>
    </tr>
</table>
  <p class="style6">表單編號 : F-EF002B</p>
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