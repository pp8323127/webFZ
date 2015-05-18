<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="java.sql.*,java.util.ArrayList,fz.pr.orp3.GdType_Name,ci.db.ConnDB,java.net.URLEncoder" %>
<%
//新增、刪除GdType
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);

if (session.isNew() || sGetUsr == null) {		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
	
}

String sern  = request.getParameter("sern");
String cname	= request.getParameter("cname");
String ename = request.getParameter("ename");
if (ename == null) {ename = "&nbsp;";}
String fltno = request.getParameter("fltno");
String fdate = request.getParameter("fdate");
String sect  = request.getParameter("s");
//String GdYear = "2005";//request.getParameter("g");
//取得考績年度
String GdYear = fz.pr.orp3.GdYear.getGdYear(fdate);

String empno = request.getParameter("empno");
//out.print(sect+"<BR>"+gdyear);
//out.print(empno);

ArrayList SelectgdTypeAL = new ArrayList();
ArrayList SelectgdNameAL = new ArrayList();
ArrayList SelectYearSern = new ArrayList();

ArrayList gdNameAL = new ArrayList();
ArrayList gdTypeAL = new ArrayList();
ArrayList gdComm   = new ArrayList();

Driver dbDriver = null;
Connection conn = null;
Statement stmt = null;
ResultSet myResultSet = null;
String sql = "";
String IsNewData= "Y";


GdType_Name myGdType = new GdType_Name();
myGdType.setStatement();

try{
	ConnDB cn = new ConnDB();
	cn.setORP3EGUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
	stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
		ResultSet.CONCUR_READ_ONLY);

sql = "SELECT * FROM EGTGDDT WHERE  gdtype IS NOT NULL AND gdtype <> 'GD1' "+
	"and empn ='"+empno+"' AND fltd=to_date('"+fdate+
	"','yyyy/mm/dd') AND fltno='"+fltno+"' AND sect='"+sect+"'";

myResultSet = stmt.executeQuery(sql);
	if(myResultSet!= null){
		while(myResultSet.next()){
			IsNewData="N";
			SelectgdTypeAL.add(myGdType.getGdName(myResultSet.getString("gdtype")));
			SelectgdNameAL.add(myResultSet.getString("comments"));		
			SelectYearSern.add(myResultSet.getString("yearsern"));
		}
	}

//抓預設comments欄位
String	selectStr = myGdType.getComm();
//關閉連線	
myGdType.closeStatement();
			
%> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>檢視及新增考核項目View &amp; Add In-Flight Service Grade Ed</title>
<link href="style2.css" rel="stylesheet" type="text/css">
<script src="checkDel.js" type="text/javascript"></script>

<script language="JavaScript" type="text/JavaScript">
function checkCharacter(){

	var message = document.form2.comm.value;
	var len = document.form2.comm.value.length;
	
	
		//alert(len);
	if(len >800){
		alert("Comments字元數限制為1000個字元，\n所輸入字數超過"+(len-800)+"個字元，請重新輸入");
		document.form2.comm.focus();
		return false;
	}
	else if(len == ""){
		if(confirm("尚未選擇Comments敘述，確定要送出？")){
		document.form2.Submit.disabled=1;
		document.form2.addToComm.disabled=1;
		<%
			if(!SelectgdTypeAL.isEmpty())
				out.print("document.form1.Submit.disabled=1;\r\n");
				
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
		<%
			if(!SelectgdTypeAL.isEmpty())
				out.print("document.form1.Submit.disabled=1;\r\n");
				
		%>		
		return true;
	}
}

/*
//選取的預設comments後，將值帶到輸入欄位，可重複附加
function addComments(){
    var addcomm = document.form2.gdComm.value;
	var originalComm = document.form2.comm.value;
	originalComm +=  ","+addcomm;	//用,隔開
	if(document.form2.comm.value == ""){	
		document.form2.comm.value = addcomm;	//輸入欄位無內容，直接加入選取的comments
	}
	else{
		document.form2.comm.value = originalComm;	//輸入欄位已有內容，附加選取的comments並用,隔開
	}
	
}
*/
function addComm2(){//將第一個comments的選項值帶到輸入欄位，可重複附加
    var addcomm = document.form2.gdComm.value;
	var originalComm = document.form2.comm.value;
	originalComm +=  ","+addcomm;	//用,隔開
	if(document.form2.comm.value == ""){	
		document.form2.comm.value = addcomm;	//輸入欄位無內容，直接加入選取的comments
	}
	else{
		document.form2.comm.value = originalComm;	//輸入欄位已有內容，附加選取的comments並用,隔開
	}
}
function clearcomm(){
	var comm = document.form2.gdname.value;
	if(comm == "GD17"){
		document.form2.gdComm.value = "";
	}
	else{
		document.form2.gdComm.value = "工作敬業、認真";
	}
}
</script>
<script src="../../MT/js/subWindow.js" language="javascript" type="text/javascript"></script>
<script src="../../js/CheckAll.js" language="javascript" type="text/javascript"></script>

</head>

<body>
<div align="center">

    <span class="txttitletop">In-Flight Service Grade Edit</span>
</div>
<form name="form1" method="post" action="delGdType.jsp" onSubmit="return del('form1')">
  <table width="78%"  border="0" align="center" cellpadding="2" cellspacing="0" >
    <tr>
      <td class="txtblue">Date:<span class="txtred"><%=fdate%></span></td>
      <td class="txtblue">Fltno:<span class="txtred"><%=fltno%></span></td>
      <td class="txtblue">Sern:<span class="txtred"><%=sern%></span></td>
      <td class="txtblue"><span class="txtblue">Name:</span><span class="txtred"><%=cname%>&nbsp;<%=ename%></span></td>
    </tr>
  </table>
  <%
  if(!SelectgdTypeAL.isEmpty()){
  	
  %>
  <table width="78%"  border="0" align="center" cellpadding="2" cellspacing="0" class="fortable">
    <tr class="tablehead3 fortable">
      <td width="11%"><input name="allchkbox" type="checkbox" onClick="CheckAll('form1','allchkbox')"> 
      Select
</td>
      <td width="29%">Grade</td>
      <td width="60%">Comments</td>
    </tr>
	<%	for(int i=0;i<SelectgdTypeAL.size();i++){
	

	%>
    <tr class="fortable">
      <td align="center" class="fortable"><input type="checkbox" name="delYearSern" value="<%=SelectYearSern.get(i)%>"></td>
      <td class="fortable txtblue" style="cursor:hand"><a href="#" onClick="subwinXY('edGdType2.jsp?cname=<%=URLEncoder.encode(cname)%>&ename=<%=ename%>&fdate=<%=fdate%>&yearSern=<%=SelectYearSern.get(i)%>','edit','600','350')"><u><%=SelectgdTypeAL.get(i)%></u></a></td>
      <td class="fortable txtblue"><%=SelectgdNameAL.get(i)%></td>
    </tr>
	<%
	  }
	%>
  </table>
  <div align="center">
    <input name="Submit" type="submit" class="delButon" value="Delete Selected" >
	 		  <input type="hidden" name="fltno" value="<%=fltno%>">
		  <input type="hidden" name="fdate" value="<%=fdate%>">
		<input type="hidden" name="sern" value="<%=sern%>">
		<input type="hidden" name="cname" value="<%=cname%>">
		<input type="hidden" name="ename" value="<%=ename%>">
		<input type="hidden" name="sect" value="<%=sect%>">
		<input type="hidden" name="GdYear" value="<%=GdYear%>">
		<input type="hidden" name="empno" value="<%=empno%>">
        <br>
        <span class="purple_txt"><strong>*Click Grade to Edit
  </strong></span></div>
  <hr noshade>

  <%
}
//myResultSet.close();

//下拉式選單HTML字串

//String selectStr = myGdType.getName_Type();
/*
sql = "select * from egtgdtp ORDER BY To_Number(SubStr(gdtype,3))";
myResultSet = stmt.executeQuery(sql);
	if(myResultSet!= null){
		while(myResultSet.next()){
			gdNameAL.add(myResultSet.getString("gdtype"));
			gdTypeAL.add(myResultSet.getString("gdname"));		
		}
	}
	
myResultSet.close();	

//抓預設comments欄位
sql = "SELECT * FROM egtgdcm";
myResultSet = stmt.executeQuery(sql);

	if(myResultSet!= null){
		while(myResultSet.next()){
			gdComm.add(myResultSet.getString("gdcomm"));			
		}
	}
*/	
%>
</form>
<form name="form2" method="post" action="upGdType.jsp" onSubmit="return checkCharacter()">
  <table width="78%"  border="0" align="center" cellpadding="2" cellspacing="0" >
    <tr >
      <td colspan="2" class="txttitle" >
        <div align="center">Add Comments</div>
      </td>
    </tr>
  </table>
  <table width="78%"  border="0" align="center" cellpadding="2" cellspacing="0" class="fortable">
    <tr >
      <td  class="tablehead3 fortable">Grade </td>
      <td class="fortable">
        <select name="gdname" OnChange="clearcomm();">
		<option value="GD3">優點</option>
		<option value="GD17">註記(REC)</option>
		<option value="GD18">其他</option>
        </select>
</td>
    </tr>
    <tr >
      <td height="59"class="tablehead3 fortable">Comments</td>
      <td class="fortable">
        <p>
        <select name="gdComm"  >
			<%=selectStr%>
        </select>	
		<input type="button" onclick="addComm2()" name="addToComm" value="Add to comments" >
        <br>	
          <textarea name="comm" cols="50" rows="4"></textarea>
        </p>
      </td>
    </tr>
  </table>
  <div align="center">
    <input type="submit" name="Submit" value="Save (儲存)" class="addButton">&nbsp;&nbsp;&nbsp;
		<input name="reset" type="reset" value="Reset (清除重寫)">&nbsp;&nbsp;&nbsp;
        <input name="button" type="button"  onClick="javascript:self.close()" value="Exit (離開)">		&nbsp;&nbsp;&nbsp;
 		  <input type="hidden" name="fltno" value="<%=fltno%>">
		  <input type="hidden" name="fdate" value="<%=fdate%>">
		<input type="hidden" name="sern" value="<%=sern%>">
		<input type="hidden" name="cname" value="<%=cname%>">
		<input type="hidden" name="ename" value="<%=ename%>">
		<input type="hidden" name="sect" value="<%=sect%>">
		<input type="hidden" name="GdYear" value="<%=GdYear%>">
		<input type="hidden" name="empno" value="<%=empno%>">
		<input type="hidden" name="IsNewData" value="<%=IsNewData%>">
 </div>
</form>
<table width="78%"  border="0" align="center" cellpadding="2" cellspacing="0" >
  <tr >
    <td colspan="2"  >
      <div align="left" class="purple_txt">
        <p><strong>選擇Grade及Comments，Comments除預設的項目外，亦可自行輸入。<br>
        輸入完畢請選擇Save(儲存)。</strong></p>
      </div>
    </td>
  </tr>
</table>
<p align="center">&nbsp;</p>
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