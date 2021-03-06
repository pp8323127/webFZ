<%@page contentType="text/html; charset=" language="java" %>
<%@page import="fz.*,java.sql.*,java.net.URLEncoder,java.util.GregorianCalendar,fz.pracP.*,fz.pracP.dispatch.*,ci.db.*"%>
<%
/*response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);*/

String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if ( sGetUsr == null) 
{		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} 

String fdate 	= request.getParameter("fdate");
//取得考績年度
String GdYear = fz.pracP.GdYear.getGdYear(fdate);
String linkstring = null;
String[] gs = null;
String[] gsEmpno = null;
String[] gsSern = null;

if(request.getParameterValues("gs") != null)
{

	 gs = request.getParameterValues("gs");//最佳服務者的員工號及序號
	 gsEmpno = new String[gs.length];//最佳服務者的員工號
	 gsSern = new String[gs.length];  //最佳服務者的序號
	for (int i = 0; i < gs.length; i++) 
	{
		gsEmpno[i]= gs[i].substring(0,6);
		gsSern[i] = gs[i].substring(6);
	}
}

String fltno 	= request.getParameter("fltno").trim();
String dpt 		= request.getParameter("dpt").trim();
String arv 		= request.getParameter("arv").trim();
String CA 		= request.getParameter("CA").trim();
//String comm = request.getParameter("comm");

String sect = dpt+arv;

String CAEmpno = request.getParameter("CAEmpno").trim();
String CACName = request.getParameter("CACName").trim();
//String ShowPeople = request.getParameter("ShowPeople");
String total 	= request.getParameter("total");

String f = request.getParameter("f").trim();//F 艙人數
	if(f.equals("")|| f== null){f = "0";}
String c = request.getParameter("c").trim();//C 艙人數
	if(c.equals("") || c == null){c = "0";}
String y = request.getParameter("y").trim();//Y 艙人數
	if(y.equals("") || y == null){y = "0";}
String inf = request.getParameter("inf").trim();//INF 艙人數
	if(inf.equals("") || inf == null){inf = "0";}
int ShowPeople = Integer.parseInt(f) + Integer.parseInt(c) + Integer.parseInt(y) + Integer.parseInt(inf);
String acno 	= request.getParameter("acno").trim();
String fleet 	= request.getParameter("fleet").trim();

//out.print(dpt+arv);
String[] cname	= request.getParameterValues("cname");
String[] ename 	= request.getParameterValues("ename");
String[] empno 	= request.getParameterValues("empno");
String[] sern	= request.getParameterValues("sern");
String[] score	= request.getParameterValues("score");
String[] scoreShow =  {"X","1","2","3","4","5","6","7","8","9","10"};

String[] duty 	= request.getParameterValues("duty");
String astring = "";
//判斷duty code是否重複 2004/12/04
int countODduty =0;
int countPAduty =0;
for(int i=0; i<duty.length; i++)
{
	if("OD".equals(duty[i]))
	{
		countODduty++;
	}

	if("PA".equals(duty[i]))
	{
		countPAduty++;
	}

	for(int j=0; j<duty.length; j++)
	{
		//out.println(duty[i].toUpperCase() + "," + duty[j].toUpperCase());
		if(duty[i].toUpperCase().equals(duty[j].toUpperCase()) && i != j && !duty[i].equals("X") && !duty[i].equals("ZC")  && !duty[i].equals("OD") && !duty[i].equals("PA") && !duty[i].equals("DFA")  && !duty[i].equals("ACM"))
		{
			astring = "Duty Code " + duty[i] + " 重複, 請檢查 !";
			%>
			<script>
				alert("<%=astring%>" );
				history.back(-1);
			</script>
			<%
		}
	}
}

//****************************************
//是否為Ferry Flt
//boolean isFerry = false;
//FlexibleDispatch fd = new FlexibleDispatch();
//isFerry = fd.isFerry(fdate, fltno, sect) ;
//if(isFerry == true && countODduty <=0)
//{
%>
<!--<script>
	alert("Ferry Flt請選擇 打工組員 ( Duty code OD )!" );
	history.back(-1);
</script>
-->
<%
//}
//****************************************

if(countODduty <=0)
{
	if(countPAduty <=0)
	{
%>
	<script>
		alert("PA 組員請選擇 <PA> Duty code!" );
	</script>
<%
	}

	if(countPAduty > 3)
	{
%>
	<script>
		alert("至多請僅輸入三位PA 組員!" );
		history.back(-1);
	</script>
<%
	}

}

//if(countODduty != 0 && countODduty != 2)
if(countODduty != 0 && countODduty > 2)
//if(countODduty != 0 && (("738".equals(fleet) && countODduty != 1) | (!"738".equals(fleet) && countODduty != 2)))
{
%>
	<script>
		//alert("打工組員 ( Duty code OD )不正確, 738機型僅一人,其餘機型二人,請檢查 !" );
		alert("打工組員 ( Duty code OD )不正確, 請檢查 !" );
		history.back(-1);
	</script>
<%
}
//***********判斷 End

//insert egtcflt的column Value（組員及分數部分）
String insertColumnValue = "";

UpdCfltCol CfltCol = new UpdCfltCol();
DelReport modifyReport = new DelReport();

insertColumnValue = CfltCol.getColValue(empno,sern,cname,score);
//out.print(updateColumnValue);

//insert egtcflt的column Name（組員及分數部分）
/*String insertColumnName = "";
insertColumnName =CfltCol.getColName();*/

//update egtcflt的值（組員及分數部分）
String updValue = "";
updValue = CfltCol.getUPDValue(empno,sern,cname,score,duty);
//get crew duty column's value insert string
String insDutyValue = "";
insDutyValue = CfltCol.getDutyValue(duty);

//update egtgddt (add & delete crew score records into egtgddt)
String rs = modifyReport.doScore(fdate, fltno, sect, empno, sern, score, GdYear, sGetUsr);
if (!rs.equals("0"))
{
	response.sendRedirect("../showMessage.jsp?messagestring="+URLEncoder.encode(rs));
}

String bcolor="";
String fontcolor = "";


Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
PreparedStatement pstmt = null;
ResultSet myResultSet = null;
//String sqlPurser = null;
String sql = null;

//************************************2.Get live sche table
//ctlTable ct = new ctlTable();
//ct.doSet();
//out.println(ct.getTable() + "," + ct.getUpdDate());

//purser的empno,sern,name,group
String purserEmpno	= request.getParameter("purserEmpno");
String psrsern		= request.getParameter("psrsern");
String psrname		= request.getParameter("psrname");
String pgroups    = request.getParameter("pgroups");


//out.print(purserEmpno+"<HR>"+psrsern+"<HR>"+psrname+"<HR>"+pgroups+"<HR>");
try
{
	ConnDB cn = new ConnDB();
	cn.setORP3EGUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
	stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
		ResultSet.CONCUR_READ_ONLY); 
	
 sql = "SELECT * FROM egtcflt WHERE fltd=to_date('"+fdate+"','yyyy/mm/dd') "+
				"AND fltno='"+fltno+"' AND sect ='"+sect+"'";
				
int rowCount = 0;//psac的資料數

myResultSet = stmt.executeQuery(sql); 

if(myResultSet.next())
{
	myResultSet.last();
	rowCount =myResultSet.getRow();
	myResultSet.beforeFirst();
}


myResultSet.close();
if(rowCount == 0)
{//若無資料，則insert

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
+"reject,reject_dt,reply,bdot,bdtime,bdreason) "
+"values(to_date('"+fdate+"','yyyy/mm/dd'),'"+fltno+
"','"+sect+"','"+CACName+"','"+CAEmpno+"','"+acno+
"','"+purserEmpno+"','"+psrsern+"','"+psrname+"','"+pgroups
+"',"+insertColumnValue+"null,sysdate,null,"+
f+","+c+","+y+","+ShowPeople+",'Y',"+inf+","+insDutyValue+",null,null,null,null,null,null)";    
/*

	sql = "insert into egtcflt values(to_date('"+fdate+"','yyyy/mm/dd'),'"+fltno+
					"','"+sect+"','"+CACName+"','"+CAEmpno+"','"+acno+
					"','"+purserEmpno+"','"+psrsern+"','"+psrname+"','"+pgroups
					+"',"+insertColumnValue+"null,sysdate,null,"+
					f+","+c+","+y+","+ShowPeople+",'Y',"+inf+","+insDutyValue+",null,null,null)";      
					
	*/								
}
else
{	//有資料，update
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
String sqlSelPsac = "select *  from egtpsac where gdyear='"+
				GdYear +"' and empn='"+ purserEmpno+"'";
		//		out.print(sqlSelPsac);
myResultSet = stmt.executeQuery(sqlSelPsac);
if(myResultSet != null)
{
	while(myResultSet.next())
	{
		rptcount = myResultSet.getInt("rptcount");
		PsacCount++;
	}
}				
myResultSet.close();
//out.print(CountPsac);

String sqlInsertPsac= "";
String Modify = "Y";
if(rowCount==0 && PsacCount ==0 )
{//Insert new Row to egtpsac
  sql = "insert into egtpsac(gdyear,empn,sern,rptcount,newuser,newdate) "+
				"values('"+GdYear+"','"+ purserEmpno+"','"+ psrsern+"',1,'"+sGetUsr+"',sysdate)";

}
else if (rowCount==0 && PsacCount !=0)
{	//update egtpsac
	sql = "update egtpsac set rptcount=rptcount+1,chguser='"+sGetUsr+"',chgdate=sysdate  "+
				"where gdyear='" +GdYear+"' and empn='"+purserEmpno+"' and sern="+psrsern+"";
}
else
{	//egtcflt有資料，則egtpsac不做更動
	Modify = "N";
}
//out.print(Modify);
//out.print(sqlInsertPsac);
if(Modify.equals("Y"))
{
	stmt.executeQuery(sql);
	
//存入egtprep
	if( !modifyReport.doAddReport(fdate,purserEmpno,psrsern,GdYear,sGetUsr).equals("0")){
		try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
		try{if(stmt != null) stmt.close();}catch(SQLException e){}
		try{if(conn != null) conn.close();}catch(SQLException e){}
		
		response.sendRedirect("../showMessage.jsp?messagestring="+
			URLEncoder.encode("寫入資料失敗，請重新輸入！！&linkto=javascript:history.back(-1)"));
	
	}	
}

//先把該航班所有的最佳服務刪掉，再重新insert
sql = "DELETE egtgddt WHERE  gdyear='"+GdYear+"' "+
	"AND fltd=to_date('"+fdate+"','yyyy/mm/dd') "+
	"AND fltno='"+fltno+"' AND sect = '"+sect+"' AND gdtype='GD1'";

myResultSet = stmt.executeQuery(sql);
myResultSet.close();

//存入egtgddt 最佳服務--先check是否有勾選最佳服務
if(request.getParameterValues("gs") != null)
{
	sql = "INSERT INTO egtgddt(yearsern,gdyear,empn,sern,fltd,fltno,sect,gdtype,newuser,newdate) "+
		  "VALUES(EGQGDYS.NEXTVAL,'"+GdYear+"',?,?,to_date('" +fdate +
		  "','yyyy/mm/dd'),'"+fltno+"','"+sect+"','GD1','"+sGetUsr+"',sysdate)";
		  
	pstmt = conn.prepareStatement(sql);
	pstmt.clearBatch();
	
	for(int i=0;i<gsEmpno.length;i++)
	{
		pstmt.setString(1,gsEmpno[i]);
		pstmt.setString(2,gsSern[i]);
		pstmt.addBatch();
	}
	
	pstmt.executeBatch();
	pstmt.clearBatch();
	pstmt.close();
}

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=">
<title>編輯座艙長報告</title>
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
	/*if(confirm("提醒您:\n2006/7/1起,越洋航線,請務必輸入組員CCOM考核.\n\n已輸入或不需輸入CCOM考核,請點選「確定」將報告存檔.\n若您尚未輸入,請按「取消」,並於組員考核項目部分輸入組員CCOM考核.\n")){
		document.form1.save.disabled=1;
		return true;
	}else{
		return false;
	}*/
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
     <strong> 
	 <span  style="background:#FF6666;color:navy " class="txtxred" id="Success">Score &amp; Crew Evaluation Update Success!!</span> </strong></div>
  <form name="form1" method="post" action="upReportSave.jsp" target="_self"  onsubmit="return disableButton()">
    <table width="604" border="0" cellpadding="0" cellspacing="0" align="center">
<noscript>
    <tr>
      <td height="24" colspan="4" style="background-color:#CCFFFF;color:#FF0000;font-size:10pt; ">
	    <div align="center"><span >若無法開啟編輯優點/註記之視窗，請<a href="guide/openjs/index.htm" target="_blank">點此參照說明</a>更改瀏覽器之設定.</span></div>
      </td>
    </tr>
	</noscript>

      <tr>
        <td colspan="3" valign="left">
          <div align="left" class="txtred">
          <span class="txtblue">Purser's Report&nbsp; &nbsp;</span><span class="red12"><strong> Step3.Give In-Flight Service Grade  to each crew</strong></span></div></td>
      </tr>
      <tr>
        <td colspan="2" valign="middle" class="txtblue"> 
          <div align="left">FDate:<span class="txtred"><%=fdate%>&nbsp;</span>&nbsp;Fltno:<span class="txtred"><%=fltno%>&nbsp;&nbsp;</span>Sector:<span class="txtred"><%=sect%></span> </div>
        </td>
        <td width="56" valign="middle">&nbsp;</td>
      </tr>
      <tr>
        <td colspan="2" valign="middle" class="txtblue">
          <div align="left">Purser:<span class="txtred"><%=psrname%>&nbsp;<%=psrsern%>&nbsp;<%=purserEmpno%></span>&nbsp;CA&nbsp;:<span class="txtred"><%=CA%></span></div>
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
          <div align="left">F:<span class="txtred"><%=f%></span>&nbsp; C:<span class="txtred"><%=c%></span>&nbsp; Y:<span class="txtred"><%=y%></span>&nbsp;INF:<span class="txtred"><%=inf%></span>

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
      <td width="44">Sern</td>
      <td width="44">Empno</td>
      <td width="54">Duty</td>
      <td width="69">Score</td>
      <td width="70">最佳服務</td>
	  <td width="25">ZC</td>
	  <td width="25">PA</td>
    </tr>
	<%

for(int i=0;i<empno.length;i++)
{

		if (i%2 == 0)
		{
			bcolor = "#99CCFF";
		}
		else
		{
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
        <input type="text" style="background-color:<%=bcolor%> ;border:0pt;text-decoration:underline;cursor:hand" readonly  size="6" value="<%=sern[i]%>" name="sern" onClick="subwinXY('edGdType.jsp?sern=<%=sern[i]%>&cname=<%=URLEncoder.encode(cname[i])%>&ename=<%=ename[i]%>&fltno=<%=fltno%>&fdate=<%=fdate%>&s=<%=sect%>&g=<%=GdYear%>&empno=<%=empno[i]%>','edGdType','600','800')">
</td>
      <td class="tablebody"><input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="6" value="<%=empno[i]%>" name="empno"> </td>
      <td class="tablebody"><input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="3" value="<%=duty[i].toUpperCase()%>" name="duty"> </td>
      <td class="tablebody">
	  <%
	  if (score[i].equals("9") ||  score[i].equals("10") || score[i].equals("1") || score[i].equals("2") || score[i].equals("3")){
	  	fontcolor="#FF33CC;font-weight: bold";
	  }
	  else{
	  	fontcolor="#000000";
	  }
	  %>
<input type="text" style="background:<%=bcolor%> ;border:0pt;color:<%=fontcolor%>;text-decoration:underline;cursor:hand" readonly  size="2" value="<%if("0".equals(score[i])) out.print("X");else out.print(score[i]);%>" name="score" onClick="subwinXY('edGdType.jsp?sern=<%=sern[i]%>&cname=<%=URLEncoder.encode(cname[i])%>&ename=<%=ename[i]%>&fltno=<%=fltno%>&fdate=<%=fdate%>&s=<%=sect%>&g=<%=GdYear%>&empno=<%=empno[i]%>','edGdType','800','500')">      </td>
      <td class="tablebody">&nbsp;<%
	  if(request.getParameterValues("gs") != null){
	  for(int j=0;j<gsEmpno.length;j++){
	  	if(empno[i].equals(gsEmpno[j])){
%>
	<img src="../images/ed1.gif" border="0">
<%		
		}
	  }
	  }

	  %></td>
	  <td class="tablebody">
	  <%
	  if("ZC".equals(duty[i])){
	/*  	linkstring = "edZC.jsp?sern="+sern[i]+"ename="+ename[i]+"&fltno="+fltno+"&fdate="+fdate+"&s="+sect+"&empno="+empno[i];
	*/
	  %>
	  	<a href="javascript:goEditZC('<%=empno[i]%>')"><img src='../images/edRP.gif' border='0'></a>
	  <%
	  }
	  else{
	  	out.println("&nbsp;");
	  }
	  %>
	  </td>
	  <td class="tablebody">
	  <%
	  if("PA".equals(duty[i]))
	  {
	/*  	linkstring = "edZC.jsp?sern="+sern[i]+"ename="+ename[i]+"&fltno="+fltno+"&fdate="+fdate+"&s="+sect+"&empno="+empno[i];
	*/
	  %>
	  	<a href="javascript:goEditPA('<%=empno[i]%>')"><img src='../images/edRP.gif' border='0'></a>
	  <%
	  }
	  else
	  {
	  	out.println("&nbsp;");
	  }
	  %>
	  </td>
  </tr>
  <%
	}
%>	
  </table>
  <table width="604" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
      <td width="26">&nbsp;</td>
      <td width="105">
        <div align="left" class="txtblue">Total:<%=total%>        </div>
      </td>
      <td width="444"><span class="txttitletop">
        <!-- <input name="send" type="submit" class="addButton" value="Update & Send Report" >   -->
		<input type="submit" name="save" value="  Save (Next) " class="addButton"  >
		&nbsp;&nbsp;&nbsp;
		<input type="button" name="back" value="   Back  " onClick="javascript:history.back(-1)">  
		&nbsp;&nbsp;&nbsp;<span class="txtblue">
		<!--ZC-->
	<%
		eg.zcrpt.ZCReport zcrt = new eg.zcrpt.ZCReport();
		zcrt.getZCFltListForPR(fdate,fltno,dpt+arv,purserEmpno);
		ArrayList zcAL = zcrt.getObjAL();
		if(zcAL.size()>0)
		{
			eg.zcrpt.ZCReportObj zcobj = (eg.zcrpt.ZCReportObj) zcAL.get(0);
			if("Y".equals(zcobj.getIfsent()))
			{//已送出
		  
	%>
			&nbsp;&nbsp;&nbsp;
			<input type="button" name="viewzc" value="ZC Report" class="bu" Onclick="javascript:window.open ('ZC/ZCreport_print.jsp?idx=0&fdate=<%=fdate%>&fltno=<%=fltno%>&port=<%=dpt%><%=arv%>&purempn=<%=purserEmpno%>','zcreport','height=800, width=800, toolbar=no, menubar=no, scrollbars=yes, resizable=yes');" >
	<%
			}//已送出if("Y".equals(zcobj.getIfsent()))
		}//if(zcAL.size()>0)			
	%>
		<!--ZC-->
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
		
	  </span></td>
      <td width="29">
       
      </td>
    </tr>
    <tr>
      <td colspan="4" class="purple_txt">
        <div align="left"><strong>*You must click Sern or Score column to edit In-Flight Service Grade 
            <br>
        if the crew's socre is 1,2,3,9 or 10</strong></div>
      </td>
    </tr>
</table>
</form>
<form name="zcForm" method="post"  action="edZC.jsp" >
<input type="hidden" name="fltd" value="<%=fdate%>">
<input type="hidden" name="fltno" value="<%=fltno%>">
<input type="hidden" name="sect" value="<%=dpt+arv%>">
<input type="hidden" name="empno">
</form>

<form name="paForm" method="post"  action="edPA.jsp" >
<input type="hidden" name="fltd" value="<%=fdate%>">
<input type="hidden" name="fltno" value="<%=fltno%>">
<input type="hidden" name="sect" value="<%=dpt+arv%>">
<input type="hidden" name="empno">
</form>


<script language="javascript" type="text/javascript">

function goEditZC(e)
{
	document.zcForm.empno.value = e;
	
	wx = 800,wy=600;	
	x =(screen.width - wx) /2;
	y = (screen.height - wy) /2;
	window.open("","zc","left="+x+",top="+y+",width="+wx+",height="+wy+",scrollbars=yes");
	document.zcForm.target="zc";
	document.zcForm.submit();
}

function goEditPA(e)
{
	document.paForm.empno.value = e;
	
	wx = 800,wy=600;	
	x =(screen.width - wx) /2;
	y = (screen.height - wy) /2;
	window.open("","pa","left="+x+",top="+y+",width="+wx+",height="+wy+",scrollbars=yes");
	document.paForm.target="pa";
	document.paForm.submit();
}

</script>

</body>

</html>

<%
}
catch (Exception e)
{
	
	  out.print(e.toString());
		//  response.sendRedirect("../showMessage.jsp?messagestring="+URLEncoder.encode("系統忙碌中，請稍後再試"));
}
finally
{
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>
<script>
alert("Score & Crew Evaluation  Update Success!!");
</script>