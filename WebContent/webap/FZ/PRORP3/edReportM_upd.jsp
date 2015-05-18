<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.*,java.sql.*,
				java.net.URLEncoder,
				java.util.GregorianCalendar,
				fz.pr.orp3.*,
				ci.db.*"%>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) {		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} 
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>儲存座艙長報告</title>
<link href="style2.css" rel="stylesheet" type="text/css">
<script>
function switchColor(){	
	if(Success.style.color=="navy"){
		Success.style.color="yellow";
	}
	else if(Success.style.color=="yellow"){
		Success.style.color="navy";
	}
	setTimeout("switchColor()",750);
}

function disableButton(){
	document.form1.save.disabled=1;
	return true;

}

</script>
<script src="../../MT/js/subWindow.js" language="javascript" type="text/javascript"></script>
<script language="javascript" src="changeAction.js" type="text/javascript"></script>

</head>
<body  onload='switchColor()'>
<div align="center">
  <div align="center">
<%
String[] gs = null;
String[] gsEmpno = null;
String[] gsSern = null;

if(request.getParameterValues("gs") != null){
	gs = request.getParameterValues("gs");//最佳服務者的員工號及序號
	gsEmpno = new String[gs.length];//最佳服務者的員工號
	gsSern = new String[gs.length];  //最佳服務者的序號
	for (int i = 0; i < gs.length; i++) {
		gsEmpno[i]= gs[i].substring(0,6);
		gsSern[i] = gs[i].substring(6);
	}
}		
String fdate 	= request.getParameter("fdate");
//取得考績年度
String GdYear = fz.pr.orp3.GdYear.getGdYear(fdate);

String fltno 	= request.getParameter("fltno").trim();
String dpt 		= request.getParameter("dpt").trim();
String arv 		= request.getParameter("arv").trim();
String CA 		= request.getParameter("CA").trim();

String sect = dpt+arv;

String CAEmpno = request.getParameter("CAEmpno").trim();
String CACName = request.getParameter("CACName").trim();
String total 	= request.getParameter("total");

String f = request.getParameter("f");//F 艙人數
	if(f.equals("")){f = "0";}
String c = request.getParameter("c");//C 艙人數
	if(c.equals("")){c = "0";}
String y = request.getParameter("y");//Y 艙人數
	if(y.equals("")){y = "0";}
String inf = request.getParameter("inf");//INF 艙人數
	if(inf.equals("")){inf = "0";}
int ShowPeople = Integer.parseInt(f) + Integer.parseInt(c) + Integer.parseInt(y) + Integer.parseInt(inf);
String acno 	= request.getParameter("acno").trim();

//out.print(dpt+arv);

String[] crew	= request.getParameterValues("crew");
String[] empno 	= request.getParameterValues("empn");
String[] sern	= request.getParameterValues("sern");
String[] score	= request.getParameterValues("score");
String[] duty	= request.getParameterValues("duty");

//insert egtcflt的column Value（組員及分數部分）
String insertColumnValue = "";
DelReport modifyReport = new DelReport();
UpdCfltCol CfltCol = new UpdCfltCol();
insertColumnValue = CfltCol.getColValue(empno,sern,crew,score);
//out.print(updateColumnValue);


//insert egtcflt的column Name（組員及分數部分）
/*String insertColumnName = "";
insertColumnName =CfltCol.getColName();*/

//update egtcflt的值（組員及分數部分）
String updValue = "";
updValue = CfltCol.getUPDValue(empno,sern,crew,score,duty);
//get crew duty column's value insert string
String insDutyValue = "";
insDutyValue = CfltCol.getDutyValue(duty);

//update egtgddt (add & delete crew score records into egtgddt)
String rs = modifyReport.doScore(fdate, fltno, sect, empno, sern, score, GdYear, sGetUsr);
if (!rs.equals("0")){
	response.sendRedirect("../showmessage.jsp?messagestring="+URLEncoder.encode(rs));
}


String bcolor="";
String fontcolor = "";

Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
PreparedStatement pstmt = null;
ResultSet myResultSet = null;
boolean t = false;
//String sqlPurser = null;
String sql = null;

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
	ConnDB cn = new ConnDB();
	cn.setORP3EGUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
	
sql = "SELECT * FROM egtcflt WHERE fltd=to_date('"+fdate+"','yyyy/mm/dd') "+
				"AND fltno='"+fltno+"' AND sect ='"+sect+"'";
stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
		ResultSet.CONCUR_READ_ONLY); 

int rowCount = 0;//psac的資料數

myResultSet = stmt.executeQuery(sql); 
 
if(myResultSet != null){
	while(myResultSet.next()){
		rowCount++;		
	}
}

myResultSet.close();
if(rowCount == 0){//若無資料，則insert
sql ="insert into egtcflt (fltd,fltno,sect,cpname,cpno,acno,psrempn,"
+"psrsern,psrname,pgroups,empn1,sern1,crew1,score1,empn2,sern2,crew2,"
+"score2,empn3,sern3,crew3,score3,empn4,sern4,crew4,score4,empn5,sern5,"
+"crew5,score5,empn6,sern6,crew6,score6,empn7,sern7,crew7,score7,empn8,"
+"sern8,crew8,score8,empn9,sern9,crew9,score9,empn10,sern10,crew10,score10,"
+"empn11,sern11,crew11,score11,empn12,sern12,crew12,score12,empn13,sern13,crew13,"
+"score13,empn14,sern14,crew14,score14,empn15,sern15,crew15,score15,empn16,sern16,"
+"crew16,score16,empn17,sern17,crew17,score17,empn18,sern18,crew18,score18,empn19,"
+"sern19,crew19,score19,empn20,sern20,crew20,score20,chguser,chgdate,remark,book_f,"
+"book_c,book_y,pxac,upd,inf,duty1,duty2,duty3,duty4,duty5,duty6,duty7,duty8,duty9,"
+"duty10,duty11,duty12,duty13,duty14,duty15,duty16,duty17,duty18,duty19,duty20,"
+"reject,reject_dt,reply) "
+" values(to_date('"+fdate+"','yyyy/mm/dd'),'"+fltno+
"','"+sect+"','"+CACName+"','"+CAEmpno+"','"+acno+
"','"+purserEmpno+"','"+psrsern+"','"+psrname+"','"+pgroups
+"',"+insertColumnValue+"null,sysdate,null,"+
f+","+c+","+y+","+ShowPeople+",'Y',"+inf+","+insDutyValue+")";   

/*
	sql = "insert into egtcflt values(to_date('"+fdate+"','yyyy/mm/dd'),'"+fltno+
					"','"+sect+"','"+CACName+"','"+CAEmpno+"','"+acno+
					"','"+purserEmpno+"','"+psrsern+"','"+psrname+"','"+pgroups
					+"',"+insertColumnValue+"null,sysdate,null,"+
					f+","+c+","+y+","+ShowPeople+",'Y',"+inf+","+insDutyValue+")";      
*/									
}
else{	//有資料，update
//updValue
	sql= "update egtcflt set "+updValue+
				  " chguser=null,chgdate=sysdate,remark=null,"+
				  "book_f="+f+",book_c="+c+",book_y="+y+
				  ",pxac="+ShowPeople+",upd='Y', inf="+inf+
 				  ",cpname='"+CACName+"',cpno='"+CAEmpno+"',acno='"+acno+
				  "' WHERE fltd=to_date('"+fdate+"','yyyy/mm/dd') "+
				  "AND Trim(fltno)='"+fltno+"' AND sect ='"+sect+"'";
}

//out.print(sql);

stmt.executeQuery(sql); 
int rptcount=0;
int PsacCount = 0;
sql = "select *  from egtpsac where gdyear='"+
				GdYear +"' and empn='"+ purserEmpno+"'";
		//		out.print(sql);
myResultSet = stmt.executeQuery(sql);
if(myResultSet != null){
	while(myResultSet.next()){
		rptcount = myResultSet.getInt("rptcount");
		PsacCount++;
	}
}				
myResultSet.close();
//out.print(CountPsac);

String sqlInsertPsac= "";
String Modify = "Y";
if(rowCount==0 && PsacCount ==0 ){//Insert new Row to egtpsac
  sql = "insert into egtpsac(gdyear,empno,sern,rptcount,newuser,newdate) "+
				"values('"+GdYear+"','"+ purserEmpno+"','"+ psrsern+"',1,'"+sGetUsr+"',sysdate)";

}
else if (rowCount==0 && PsacCount !=0){	//update egtpsac
	sql = "update egtpsac set rptcount=rptcount+1,chguser='"+sGetUsr+"',chgdate=sysdate  "+
				"where gdyear='" +GdYear+"' and empn='"+purserEmpno+"' and sern="+psrsern;


}
else{	//egtcflt有資料，則egtpsac不做更動
	Modify = "N";
}
//out.print(Modify);
//out.print(sqlInsertPsac);
if(Modify.equals("Y")){
	stmt.executeQuery(sql);
	//存入egtprep
	if( !modifyReport.doAddReport(fdate,purserEmpno,psrsern,GdYear,sGetUsr).equals("0")){
		try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
		try{if(stmt != null) stmt.close();}catch(SQLException e){}
		try{if(conn != null) conn.close();}catch(SQLException e){}
		
		response.sendRedirect("../showmessage.jsp?messagestring="+URLEncoder.encode("寫入資料失敗，請重新輸入！！&linkto=javascript:history.back(-1)"));
	}
}

/*if(!sGetUsr.equals("638716") && !sGetUsr.equals("640073") ){	//cs55,cs66可編輯

	if(  !sGetUsr.equals("purserEmpno")  ){	//非本班機座艙長，不得使用此功能
		response.sendRedirect("../showmessage.jsp?messagestring="+URLEncoder.encode("非本班機座艙長，不得使用此功能") );
	}

}*/


//先把該航班所有的最佳服務刪掉，再重新insert
sql = "DELETE egtgddt WHERE  gdyear='"+GdYear+"' "+
	"AND fltd= to_date('"+fdate+"','yyyy/mm/dd') "+
	"AND fltno='"+fltno+"' AND sect = '"+sect+"' AND gdtype='GD1'";

myResultSet = stmt.executeQuery(sql);
myResultSet.close();

//存入egtgddt 最佳服務--先check是否有勾選最佳服務
if(request.getParameterValues("gs") != null){
	sql = "INSERT INTO egtgddt(yearsern,gdyear,empn,sern,fltd,fltno,sect,gdtype,newuser,newdate) "+
		  "VALUES(EGQGDYS.NEXTVAL,'"+GdYear+"',?,?,to_date('" +fdate +
		  "','yyyy/mm/dd'),'"+fltno+"','"+sect+"','GD1','"+sGetUsr+"',sysdate)";
		  
	pstmt = conn.prepareStatement(sql);
	pstmt.clearBatch();
	
	for(int i=0;i<gsEmpno.length;i++){
		pstmt.setString(1,gsEmpno[i]);
		pstmt.setString(2,gsSern[i]);
		pstmt.addBatch();
	}
	
	pstmt.executeBatch();
	pstmt.clearBatch();
	pstmt.close();
}	
%>
     <strong> 
	 <span  style="background:#FF6666;color:navy " class="txtxred" id="Success">Score &amp; Crew Evaluation / Flt Irregularity Update Success!!</span> </strong></div>
  <form name="form1" method="post" action="upReportSave.jsp" target="_self"  onsubmit="return disableButton()">
    <table width="66%" border="0" cellpadding="0" cellspacing="0" align="center">
      <tr>
        <td colspan="3" valign="left">
          <div align="left" class="txtred">
          <span class="txtblue">Purser's Report&nbsp; &nbsp;</span><span class="red12"><strong> Give In-Flight Service Grade  to each crew</strong></span></div></td>
      </tr>
      <tr>
        <td colspan="2" valign="middle" class="txtblue"> 
          <div align="left">FDate:<span class="txtred"><%=fdate%>&nbsp;</span>&nbsp;Fltno:<span class="txtred"><%=fltno%>&nbsp;&nbsp;</span>Sector:<span class="txtred"><%=sect%></span> </div>
        </td>
        <td width="123" valign="middle">&nbsp;</td>
      </tr>
      <tr>
        <td colspan="2" valign="middle" class="txtblue">
          <div align="left">Purser:<span class="txtred"><%=psrname%>&nbsp;<%=psrsern%>&nbsp;<%=purserEmpno%></span>&nbsp;CA&nbsp;:<span class="txtred"><%=CA%></span></div>
        </td>
        <td valign="middle">&nbsp;</td>
      </tr>
      <tr>
        <td width="384" valign="middle"  class="txtblue">
          <div align="left">A/C:<span class="txtred"><%=acno%></span></div>
        </td>
        <td width="143" valign="middle">&nbsp; </td>
        <td valign="middle" align="right"></td>
      </tr>
      <tr>
        <td valign="middle"  class="txtblue"> 
          <div align="left">F:<span class="txtred"><%=f%></span>&nbsp; C:<span class="txtred"><%=c%></span>&nbsp; Y:<span class="txtred"><%=y%></span>&nbsp;INF:<span class="txtred"><%=inf%></span>

&nbsp; Pax:<span class="txtred"><%=ShowPeople%></span></div>
        </td>
        <td valign="middle"><span class="txtred">GradeYear：<%=GdYear%></span></td>
        <td valign="middle" align="right"><a href="javascript:window.print()"><img src="../images/print.gif" width="17" height="15" border="0" alt="列印"></a></td>
      </tr>
    </table>
    <table width="66%"  border="0" align="center" cellpadding="0" cellspacing="0" >
    <tr class="tablehead3">
      <td>Name</td>
      <td>EmpNo</td>
      <td>S.No</td>
	  <td>Duty</td>
      <td>Score</td>
      <td>最佳服務</td>
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
      <td height="27" class="tablebody">
	  <input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="12" value="<%=crew[i]%>" name="cname">
	  </td>
      <td class="tablebody">
		<div align="center">
		  <input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="6" value="<%=empno[i]%>" name="empno">
      </div></td>
      <td class="tablebody">
        <input type="text" style="background-color:<%=bcolor%> ;border:0pt;text-decoration:underline;cursor:hand" readonly  size="6" value="<%=sern[i]%>" name="sern" onClick="subwinXY('edGdType.jsp?sern=<%=sern[i]%>&cname=<%=URLEncoder.encode(crew[i])%>&fltno=<%=fltno%>&fdate=<%=fdate%>&s=<%=sect%>&g=<%=GdYear%>&empno=<%=empno[i]%>','edGdType','800','500')">
	  </td>
	  <td class="tablebody"><%=duty[i].toUpperCase()%></td>
      <td class="tablebody">
        <%
	  if (score[i].equals("9") ||  score[i].equals("10") || score[i].equals("1") || score[i].equals("2") || score[i].equals("3")){
	  	fontcolor="#FF33CC;font-weight: bold";
	  }
	  else{
	  	fontcolor="#000000";
	  }
	  %>
        <input type="text" style="background:<%=bcolor%> ;border:0pt;color:<%=fontcolor%>;text-decoration:underline;cursor:hand" readonly  size="2" value="<%if("0".equals(score[i])) out.print("X");else out.print(score[i]);%>" name="score" onClick="subwinXY('edGdType.jsp?sern=<%=sern[i]%>&cname=<%=URLEncoder.encode(crew[i])%>&fltno=<%=fltno%>&fdate=<%=fdate%>&s=<%=sect%>&g=<%=GdYear%>&empno=<%=empno[i]%>','edGdType','800','500')"></td>
      <td class="tablebody">
	  <%
	  if(request.getParameterValues("gs") != null){
	  
	  for(int j=0;j<gsEmpno.length;j++){
	  	if(empno[i].equals(gsEmpno[j])){
%>
	<img src="../images/ed1.gif" border="0">
<%		
		}
	  }
	}else{out.print("&nbsp;");}
	  %></td>
  </tr>
  <%
	}
%>	
  </table>
  <table width="66%" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
      <td width="24">&nbsp;</td>
      <td width="102">
        <div align="left" class="txtblue">Total:<%=total%>        </div>
      </td>
      <td><span class="txttitletop">
       <!-- <input name="send" type="submit" class="addButton" value="Update & Send Report" >		  -->
        <input type="submit" name="save" value="  Save (Next) " class="addButton"  >&nbsp;&nbsp;&nbsp;
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
		   <input type="hidden" name="GdYear" value="<%=GdYear%>">
	  </span>      </td>
    </tr>
    <tr>
      <td colspan="3" class="purple_txt">
        <div align="left"><strong>*You must click Sern or Score column to edit In-Flight Service Grade 
            <br>
        if the crew's socre is 1,2,3,9 or 10</strong></div>
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
		//  response.sendRedirect("../showmessage.jsp?messagestring="+URLEncoder.encode("系統忙碌中，請稍後再試"));
}
finally
{
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>
<script>
alert("Score & Crew Evaluation / Flt Irregularity Update Success!!");
</script>