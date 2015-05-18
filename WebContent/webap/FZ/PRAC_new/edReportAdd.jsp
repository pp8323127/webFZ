<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.*,java.sql.*,java.net.URLEncoder,java.util.GregorianCalendar"%>
<%
//座艙長報告--新增組員
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) {		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} 
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>客艙報告--新增組員</title>
<link href="style2.css" rel="stylesheet" type="text/css">
<script language="javascript" src="checkDel.js" type="text/javascript"></script>
<script language="javascript" src="../js/changeAction.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript">
function checkAdd(){

	var e  = document.form1.addSern.value;
	if (e == ""){
		alert("請輸入組員序號\nPLease insert crew's serial number");
		document.form1.addSern.focus();
		return false;
	}
	else{
		preview('form1','edReportAdd.jsp');

	}

}
</script>

</head>
<body>
<%

String newMessage = "";
String CA = request.getParameter("CA");

String addSern = request.getParameter("addSern");
String OsernList= request.getParameter("OsernList");
String addSernList = request.getParameter("addSernList");
if( addSernList.equals("")){
	addSernList = "'"+addSern+"'";}
else{	
	addSernList = addSernList + ",'"+addSern+"'";
}

String ListAfterAdd = OsernList+","+addSernList;
String ListUnique = "";
UniqueList ul = new UniqueList();//消除重複的
ListUnique = ul.getUniqueList(ListAfterAdd);
/*
AddSern myAdd = new AddSern();
out.print(myAdd.FindSern(OsernList,addSern));
out.print("原始名單OsernList:<BR>"+OsernList+"<HR>");
out.print("新增組員:<BR>"+addSern+"<HR>");
out.print("addSernList:<BR>"+addSernList+"<HR>");
*/

//抓今年跟去年的值，import java.util.GregorianCalendar;
GregorianCalendar currentDate = new GregorianCalendar();
int thisYear = currentDate.get(GregorianCalendar.YEAR);
int nextYear = thisYear +1;

//************************************2.Get live sche table
ctlTable ct = new ctlTable();
ct.doSet();
//out.println(ct.getTable() + "," + ct.getUpdDate());

//顯示旅客總人數
String ShowPeople =request.getParameter("ShowPeople");
String f = request.getParameter("f");//F艙人數
String c = request.getParameter("c");//C艙人數
String y = request.getParameter("y");//C艙人數

//out.print(f);

String fdate = request.getParameter("fdate");
String fltno = request.getParameter("fltno").trim();
String dpt = request.getParameter("dpt").trim();
String arv = request.getParameter("arv").trim();
String acno = request.getParameter("acno").trim();
String CAEmpno = request.getParameter("CAEmpno").trim();
String CACName = request.getParameter("CACName").trim();

String purserEmpno = null;

String empno 	= null;
String sern		= null;
String cname	= null;
String ename	= null;
String occu 	= null;

Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
ResultSet myResultSet = null;
boolean t = false;
String sql = null;
/*
轉換聯管與班表的station
前頁flightcrew.jsp抓聯管，因此此處要轉換成fz 
*/
TransferStation tf = new TransferStation();

//驗證是否為Purser
String sqlPurser = "select a.empno empno, b.ename ename,b.name cname, a.occu occu "+
				"from "+ct.getTable()+" a, fztcrew b "+
				"where a.empno=b.empno AND SubStr(Trim(a.qual),1,1) ='P' "+	//purser的queal為PM或P
				"and a.fdate='"+fdate+"' "+
				"and dpt='"+tf.da13ToFz(dpt)+"' and arv='"+tf.da13ToFz(arv)+"' and LPad(trim(a.dutycode),4,'0')='"+fltno+"'";

				
int xCount=0;
String bcolor=null;

try{

dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
conn = dbDriver.connect("jdbc:weblogic:pool:CAL.FZCP02", null);
stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
		ResultSet.CONCUR_READ_ONLY);
//驗證新增的sern為有效的
myResultSet = stmt.executeQuery("SELECT * FROM egtcbas WHERE sern="+addSern);
if(!myResultSet.next()){
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}

	response.sendRedirect("../showMessage.jsp?messagestring="+URLEncoder.encode("新增的序號無效，請重新輸入")+
						"&messagelink=Back&linkto=javascript:history.back(-1)" );

}
myResultSet.close();

//抓取該班組員名單
/*sql = "select a.dutycode,a.empno empno, b.ename ename,b.name cname, b.box sern, a.occu occu,a.dpt,a.arv "+
	  "from "+ct.getTable()+" a, fztcrew b "+
	  "where a.empno=b.empno and (a.occu='FA' or a.occu='FS') and a.fdate='"+fdate+"' "+
  	  "and dpt='"+tf.da13ToFz(dpt)+"' and arv='"+tf.da13ToFz(arv)+"' "+
	  "and LPad(trim(a.dutycode),4,'0')='"+fltno+"' order by empno";
*/
sql = "select empno,ename,name cname,box sern,occu "+
	  "from fztcrew where   box in("+ListUnique +") "+
	// "from fztcrew where  box in("+OsernList +") "+
	 "order by empno";
	 //out.print(sql);

myResultSet	= stmt.executeQuery(sqlPurser);
if(myResultSet != null){
	while(myResultSet.next()){
		purserEmpno	= myResultSet.getString("empno");
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
  <form name="form1" method="post" action="edReportDel.jsp" target="_self" onSubmit="return del('form1','delSern')">
<table width="579" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
      <td>
        <div align="left" class="txtred">CA&nbsp;:<%=CA%></div>
      </td>
      <td width="69" valign="middle">
        <div align="center"></div>
      </td>
      <td width="141" valign="middle">&nbsp;      </td>
      <td width="27" valign="middle">&nbsp;      </td>
    </tr>
    <tr>
      <td>
        <div align="left" class="txtred">
          A/C:<%=acno%>        </div>
      </td>
      <td valign="middle">&nbsp;</td>
      <td valign="middle">&nbsp;</td>
      <td valign="middle">&nbsp;</td>
    </tr>
    <tr>
      <td>
	  <span class="txtred">
	    F:<input type="text" name="f" size="3"  value="<%=f%>">
        C:<input type="text" name="c" size="3" value="<%=c%>">
		Y:<input type="text" name="y" size="3" value="<%=y%>">&nbsp;
		Pax:<%=ShowPeople%></span>
	  </td>
      <td valign="middle">&nbsp;</td>
      <td valign="middle"><span class="txtxred">GradeYear：</span>
        <select name="gdyear" >
          <option value="<%=thisYear%>" selected><%=thisYear%></option>
          <option value="<%=nextYear%>" ><%=nextYear%></option>
        </select>
      </td>
      <td valign="middle"> <div align="right"><a href="javascript:window.print()"> <img src="../images/print.gif" width="17" height="15" border="0" alt="列印"></a> 	</div>
</td>
    </tr>
</table>
    <table width="599"  border="0" align="center" cellpadding="2" cellspacing="0" >
    <tr class="tablehead3">
      <td width="87">Name</td>
      <td width="226">EName</td>
      <td width="47">Sern</td>
      <td width="50">Empno</td>
      <td width="31">Occu</td>
      <td width="39">Score</td>
      <td width="82">Delete</td>
    </tr>
	<%
//檢查sern是否為新增的
AddSern checkAddSern = new AddSern();
myResultSet	= stmt.executeQuery(sql);

if(myResultSet != null){
	while(myResultSet.next()){
	
		 empno 	= myResultSet.getString("empno");
		 sern	= myResultSet.getString("sern");
		 cname	= myResultSet.getString("cname");
		 ename	= myResultSet.getString("ename");
		 occu	= myResultSet.getString("occu");
	xCount++;	
		if (xCount%2 == 0){
			bcolor = "#99CCFF";
		}
		else{
			 	bcolor = "#FFFFFF";
		}

	if(addSernList.equals("")){
		if( checkAddSern.FindSern(OsernList,sern) == false){
		 	 bcolor="#CC99CC";
			 newMessage = "<span style=\"color:#FF0000 \">New!!</span>";
		}
		else{
			newMessage="";
		}

	}
	else{
		if( checkAddSern.FindSern(addSernList,sern) == true){
		 	 bcolor="#CC99CC";
			 newMessage = "<span style=\"color:#FF0000 \">New!!</span>";
		}
		else{
			newMessage="";
		}

	}

%>

  <tr bgcolor="<%=bcolor%>">
      <td class="tablebody">	  
	  <input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="12" value="<%=cname%>" name="cname">
	  </td>
      <td class="tablebody">
        <div align="left">&nbsp;
		<input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="30" value="<%=ename%>" name="ename"></div>
      </td>
      <td class="tablebody">
		<input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="6" value="<%=sern%>" name="sern"> 
	  </td>
      <td class="tablebody">
		<input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="6" value="<%=empno%>" name="empno"> 
	  </td>
      <td class="tablebody">
	  <input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="2" value="<%=occu%>" name="occu">

	  </td>
      <td class="tablebody">
        <select name="score">
          <%  	  	for(int i=0;i<=10;i++){	  %>
          <option value="<%=i%>"><%=i%></option>
          <%		}	  					  %>
        </select>
      </td>
      <td class="tablebody">
        <div align="center">
          <input name="delSern" type="checkbox"  value="<%=sern%>">  <%=newMessage%>
        </div>
      </td>
    </tr>
  <%
	}
}
%>	
  </table>
  <table width="528" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
      <td width="43">&nbsp;</td>
      <td width="228">
        <div align="left" class="txtblue">Total:<%=xCount%>        </div>
      </td>
      <td width="561"><span class="txttitletop">
        <input type="button" name="Preview" value="Preview" onClick="preview('form1','edReportPreView.jsp')">        &nbsp;&nbsp;&nbsp;
        <input type="submit" name="delEmpno2" value="Delete" class="delButon" >
        &nbsp;&nbsp;&nbsp;
        <input type="reset" name="reset" value="Reset">
        <input type="hidden" name="dpt" value="<%=dpt%>">
        <input type="hidden" name="arv" value="<%=arv%>">
        <input type="hidden" name="fltno" value="<%=fltno%>">
        <input type="hidden" name="fdate" value="<%=fdate%>">
        <input type="hidden" name="OsernList" value="<%=ListAfterAdd%>">
 	   <input type="hidden" name="addSernList" value="<%=addSernList%>">
        <input type="hidden" name="CA" value="<%=CA%>">
        <input type="hidden" name="ShowPeople" value="<%=ShowPeople%>">
		<input type="hidden" name="acno" value="<%=acno%>">
  		  <input type="hidden" name="CACName" value="<%=CACName%>">
   		  <input type="hidden" name="CAEmpno" value="<%=CAEmpno%>">
		  <input type="hidden" name="total" value="<%=xCount%>">
  		  <input type="hidden" name="f" value="<%=f%>">
   		  <input type="hidden" name="c" value="<%=c%>">
		  <input type="hidden" name="y" value="<%=y%>">
      </span></td>
      <td width="44">
        <div align="right"><a href="javascript:window.print()"> </a> </div>
      </td>
    </tr>
</table>
  <table width="528" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
      <td width="43">&nbsp;</td>
      <td width="789">
        <div align="left" class="txtblue">新增組員（輸入序號）Sern：
          <input type="text" name="addSern" size="5" maxlength="5">
     	 <input type="button" name="Submit2" value="Add"  onClick="checkAdd()">
        </div>
      </td>
      <td width="44">
      </td>
    </tr>
</table>
  </form>
<p>&nbsp;</p>
<p>  

</p>
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