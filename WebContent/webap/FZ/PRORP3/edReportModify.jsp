<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.pr.orp3.*,java.sql.*,ci.db.ConnDB,java.net.URLEncoder,ci.db.*"%>
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
<title>修改座艙長報告</title>

<link href="style2.css" rel="stylesheet" type="text/css">
<script language="javascript" src="changeAction.js" type="text/javascript"></script>

<script>
function disableSubmit(){
	document.form1.GiveComments.disabled=1;
	document.form1.delButton.disabled=1;
	return true;
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
function comfirmDel(){
		if(confirm("刪除報表，會將此份報表所有資料清除。\n確定要刪除？")){
			
			preview('form1','delReport.jsp')
			return true;
		}
		else{
			
			return false;
		}
}
</script>
</head>
<body>
<%
String fdate 	= null;
String fltno 	= null;
String dpt		= null;
String arv		= null;
String GdYear 	= null;

try{
	fdate 	= request.getParameter("fdate");
	fltno 	= request.getParameter("fltno").trim();
	dpt		= request.getParameter("dpt").trim();
	arv		= request.getParameter("arv").trim();
	//取得考績年度
	 GdYear = fz.pr.orp3.GdYear.getGdYear(fdate);

}catch (Exception e)
{
	  out.print(e.toString()+"-->"+fdate+","+fltno+","+dpt+","+arv+","+GdYear+","+GdYear);
}
String sect		= dpt+arv;

String cpname = null;
String cpno = null;
String psrempn = null;
String psrsern = null;
String psrname = null;
String pgroups = null;
String acno = null;
String[] empn = new String[20];
String[] sern = new String[20];
String[] crew = new String[20];
String[] score = new String[20];
String[] duty = new String[20];
String book_f = null;
String book_c = null;
String book_y = null;
String pxac = null;
String inf = null;
String upd = null;
String[] lscore	= {"0","1","2","3","4","5","6","7","8","9","10"};
String[] lscoreShow =  {"X","1","2","3","4","5","6","7","8","9","10"};
String bcolor="";
int cCount = 0;
ArrayList gsEmpno = new ArrayList();

Driver dbDriver = null;
Connection conn = null;
Statement stmt = null;
ResultSet myResultSet = null;

try{

ConnDB cn = new ConnDB();
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
	
String sql = "SELECT * FROM egtcflt WHERE fltd=to_date('"+fdate+"','yyyy/mm/dd') AND fltno='"+fltno+"' AND sect ='"+sect+"'";
stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
		ResultSet.CONCUR_READ_ONLY); 

myResultSet = stmt.executeQuery(sql); 
 
if(myResultSet.next()){
	cpname = myResultSet.getString("cpname");
	if(cpname == null) cpname = "";
	cpno = myResultSet.getString("cpno");
	if(cpno == null) cpno = "";
	psrempn = myResultSet.getString("psrempn");
	if(psrempn == null) psrempn = "";
	psrsern = myResultSet.getString("psrsern");
	if(psrsern == null) psrsern = "";
	psrname = myResultSet.getString("psrname");
	if(psrname == null) psrname = "";
	pgroups	= myResultSet.getString("pgroups");
	if(pgroups == null) pgroups = "";
	acno = myResultSet.getString("acno");
	if(acno == null) acno = "";
	for(int i=0; i<empn.length; i++){
		empn[i] = myResultSet.getString("empn"+String.valueOf(i+1));
		if(empn[i] == null) empn[i] = "000000";
		sern[i] = myResultSet.getString("sern"+String.valueOf(i+1));
		crew[i] = myResultSet.getString("crew"+String.valueOf(i+1));
		if(crew[i] == null) crew[i] = "";
		score[i] = myResultSet.getString("score"+String.valueOf(i+1));
		if(score[i] == null) score[i] = "0";
		duty[i] = myResultSet.getString("duty"+String.valueOf(i+1));
		if(duty[i] == null) duty[i] = "X";
		if(!empn[i].equals("000000")) cCount++;
	}
	book_f = myResultSet.getString("book_f");
	if(book_f == null) book_f = "0";
	book_c = myResultSet.getString("book_c");
	if(book_c == null) book_c = "0";
	book_y = myResultSet.getString("book_y");
	if(book_y == null) book_y = "0";
	pxac = myResultSet.getString("pxac");
	if(pxac == null) pxac = "0";
	inf = myResultSet.getString("inf");
	if(inf == null) inf = "0";
	upd = myResultSet.getString("upd");
	if(upd == null) upd = "";
}
else{
	response.sendRedirect("../showmessage.jsp?messagestring="+URLEncoder.encode("No Record Found !") );
}
myResultSet.close();
sql = "SELECT trim(empn) empn FROM egtgddt WHERE gdyear='"+GdYear+"' "+
	"AND fltd=to_date('"+fdate+"','yyyy/mm/dd') AND fltno='"+fltno+"' AND gdtype='GD1'";

myResultSet= stmt.executeQuery(sql);
if(myResultSet!= null){
	while(myResultSet.next()){
		gsEmpno.add(myResultSet.getString("empn"));
	}
}
//add by cs66 2005/03/02  duty選單,22個選項,
String[] dutySelItem = {"X","Z1","1L","1R","Z2","2L","2R","UDZ","UDR","UDL","UDA","Z3","3L","3R","3LA","3RA","4LA","4RA","4L","4R","5L","5R"};


/*if(!sGetUsr.equals("638716") && !sGetUsr.equals("640073") ){	//cs55,cs66可編輯

	if(  !sGetUsr.equals("psrempn")  ){	//非本班機座艙長，不得使用此功能
		response.sendRedirect("../showmessage.jsp?messagestring="+URLEncoder.encode("非本班機座艙長，不得使用此功能") );
	}

}*/

%>
   <form name="form1" method="post" action="edReportM_upd.jsp" target="_self" onSubmit="return disableSubmit()">
    <table width="66%" border="0" cellpadding="0" cellspacing="0" align="center">
      <tr>
        <td colspan="3" valign="left">
          <div align="left" class="txtred"></div>
          <span class="txtblue">Purser's Report&nbsp; &nbsp;</span><span class="red12"><strong> Modify In-Flight Service Grade</strong></span></td>
      </tr>
      <tr>
        <td colspan="2" valign="middle" class="txtblue"> 
          <div align="left">FDate:<span class="txtred"><%=fdate%>&nbsp;</span>&nbsp;Fltno:<span class="txtred"><%=fltno%>&nbsp;&nbsp;</span>Sector:<span class="txtred"><%=sect%></span> </div>
        </td>
        <td width="128" valign="middle">&nbsp;</td>
      </tr>
      <tr>
        <td colspan="2" valign="middle" class="txtblue">
          <div align="left">Purser:<span class="txtred"><%=psrname%>&nbsp;<%=psrsern%>&nbsp;<%=psrempn%></span>&nbsp;CA&nbsp;:<span class="txtred"><%=cpname%></span></div>
        </td>
        <td valign="middle">&nbsp;</td>
      </tr>
      <tr>
        <td width="236" valign="middle"  class="txtblue">
          <div align="left">A/C:<span class="txtred">
            <input type="text" name="acno" value="<%=acno%>" size="5" maxlength="5">
          </span></div>
        </td>
        <td width="137" valign="middle"><input type="button" value="Delete Report" class="delButon" onClick="return comfirmDel()" name="delButton"> </td>
        <td valign="middle" align="right"></td>
      </tr>
      <tr>
        <td valign="middle"  class="txtblue"> 
          <div align="left">F:<span class="txtred">
            <input name="f" type="text" id="f" value="<%=book_f%>" size="3" maxlength="3"  onkeyup="return checkNUM('f')">
            </span>C:<span class="txtred">
		    <input name="c" type="text" id="c" value="<%=book_c%>" size="3" maxlength="3" onkeyup="return checkNUM('c')">
			</span>Y:<span class="txtred">
			<input name="y" type="text" id="y" value="<%=book_y%>" size="3" maxlength="3" onkeyup="return checkNUM('y')">
			</span>INF:<span class="txtred">
			<input name="inf" type="text" id="inf" value="<%=inf%>" size="3" maxlength="3" onkeyup="return checkNUM('inf')">
			</span>

&nbsp; Pax:<span class="txtred"><%=pxac%></span></div>
        </td>
        <td valign="middle"><span class="txtred">GradeYear：<%=GdYear%></span></td>
        <td valign="middle" align="right"><a href="javascript:window.print()"><img src="../images/print.gif" width="17" height="15" border="0" alt="列印"></a></td>
      </tr>
    </table>
    <table width="68%"  border="0" align="center" cellpadding="2" cellspacing="0" >
    <tr class="tablehead3">
      <td>Name</td>
      <td>EmpNo</td>
      <td>S.No</td>
	  <td>Duty</td>
      <td>Score</td>
      <td>最佳服務</td>
    </tr>
<%

//for(int i=0;i<empn.length;i++){
for(int i=0;i<cCount;i++){
		if (i%2 == 0){
			bcolor = "#99CCFF";
		}
		else{
			bcolor = "#FFFFFF";
		}	

  		
%>
  <tr bgcolor="<%=bcolor%>">
      <td class="tablebody">
        <input name="crew" type="text" id="crew" style="background-color:<%=bcolor%> ;border:0pt" tabindex="999" value="<%=crew[i]%>"  size="12" readonly>
</td>
      <td class="tablebody">
		<div align="center">
		  <input name="empn" type="text" id="empn" style="background-color:<%=bcolor%> ;border:0pt" tabindex="999" value="<%=empn[i]%>"  size="6" readonly>
      </div></td>
      <td class="tablebody">
	  <input type="text" style="background-color:<%=bcolor%> ;border:0pt" readonly  size="6" value="<%=sern[i]%>" name="sern"  tabindex="999"> </td>
      <td class="tablebody">
	  <select name="duty" id="duty" tabindex="<%=(i+2)%>">
<%
//add by cs66 2005/03/02
	for(int j=0;j<dutySelItem.length;j++){
		if(dutySelItem[j].equals(duty[i])){
			out.print("<option value=\""+dutySelItem[j]+"\" selected>"+dutySelItem[j]+"</option>");
		}else{
			out.print("<option value=\""+dutySelItem[j]+"\">"+dutySelItem[j]+"</option>");
		}
	}
%>	  

		</select>
	  
	  </td>
	  <td class="tablebody">
	      <select name="score"  tabindex="<%=(1+i)%>">
          <option value="<%=score[i]%>"><%if("0".equals(score[i])) out.print("X");else out.print(score[i]);%></option>
          <%  	  	for(int j=0;j<=10;j++){	  %>
          <option value="<%=lscore[j]%>"><%=lscoreShow[j]%></option>
          <%		}	  					  %>
        </select></td>
		<%

		%>
      <td class="tablebody"><input type="checkbox" name="gs" value="<%=empn[i]+sern[i]%>"
	  <%
	  	for(int j=0;j<gsEmpno.size();j++){	//若有最佳服務，則checked 
			if(((String)gsEmpno.get(j)).equals(empn[i]) ){
				out.print("checked");
			}
		}
	  %>
	  ></td>
  </tr>
  <%
  		//if(empn[i+1].equals("000000")) i = 99;
	}
%>	
  </table>
  <table width="66%" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
      <td width="31">&nbsp;</td>
      <td width="108">
         <div align="left" class="txtblue">Total:<%=cCount%></div>
      </td>
      <td width="332"><span class="txttitletop">
        <input name="GiveComments" type="submit" class="addButton" value="Save ( Next ) " tabindex="<%=(cCount+2)%>">        
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
		  <input type="hidden" name="CA" value="<%=cpno%>&nbsp;<%=cpname%>">
          <input type="hidden" name="CACName" value="<%=cpname%>">   		
          <input type="hidden" name="CAEmpno" value="<%=cpno%>"> 
		  <input type="hidden" name="purserEmpno" value="<%=psrempn%>">
		  <input type="hidden" name="psrsern" value="<%=psrsern%>">
		  <input type="hidden" name="psrname" value="<%=psrname%>">
		  <input type="hidden" name="pgroups" value="<%=pgroups%>">
		  <input type="hidden" name="total" value="<%=cCount%>">
		  <input type="hidden" name="GdYear" value="<%=GdYear%>">		
	  </span></td>
      <td width="27">
       
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