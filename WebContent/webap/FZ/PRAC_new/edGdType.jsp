<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="java.sql.*,java.util.ArrayList,ci.db.ConnDB,java.net.URLEncoder" %>
<%
//新增、刪除GdType
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);

if (session.isNew() || sGetUsr == null) {		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
	
}

String sern  = request.getParameter("sern");
String cname = request.getParameter("cname");
String ename = request.getParameter("ename");
if (ename == null) {ename = "&nbsp;";}
String fltno = request.getParameter("fltno");
String fdate = request.getParameter("fdate");
String sect  = request.getParameter("s");
//String GdYear = "2005";
//request.getParameter("g");
//取得考績年度
String GdYear = fz.pracP.GdYear.getGdYear(fdate);

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

//考評項目
fz.pracP.GdTypeName gn = new fz.pracP.GdTypeName();
try {
	gn.SelectData();
} catch (InstantiationException e) {
	out.print(e.toString());
} catch (IllegalAccessException e) {
	out.print(e.toString());
} catch (ClassNotFoundException e) {
	out.print(e.toString());
} catch (SQLException e) {
	out.print(e.toString());
}


ArrayList CommAL = gn.getCommAL();

try{
	ConnDB cn = new ConnDB();
	cn.setORP3EGUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
	stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
		ResultSet.CONCUR_READ_ONLY);

sql = "SELECT * FROM EGTGDDT WHERE  gdtype IS NOT NULL AND gdtype  not in ('GD1','GD2')"+ //gdtype <> 'GD1' "+
	"and empn ='"+empno+"' AND fltd=to_date('"+fdate+
	"','yyyy/mm/dd') AND fltno='"+fltno+"' AND sect='"+sect+"'";

myResultSet = stmt.executeQuery(sql);
	if(myResultSet!= null){
		while(myResultSet.next()){
			IsNewData="N";
			SelectgdTypeAL.add(gn.ConverGdTypeToName(myResultSet.getString("gdtype")));
			
			SelectgdNameAL.add(myResultSet.getString("comments"));		
			SelectYearSern.add(myResultSet.getString("yearsern"));
		}
	}
myResultSet.close();	
			

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
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>檢視及新增考核項目View &amp; Add In-Flight Service Grade Ed</title>
<link href="style2.css" rel="stylesheet" type="text/css">
<script src="checkDel.js" type="text/javascript"></script>

<script language="JavaScript" type="text/JavaScript">
function checkCharacter()
{
	var gdname = document.form2.gdname.value;	
	var message = document.form2.comm.value;
	var len = document.form2.comm.value.length;
	
	
		//alert(len);
	if(len >800){
		alert("Comments字元數限制為1000個字元，\n所輸入字數超過"+(len-800)+"個字元，請重新輸入");
		document.form2.comm.focus();
		return false;
	}
	else if (gdname == "")
	{
		alert("尚未選擇考評項目/專業知識項目");
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
	if(comm == "GD17")
	{
		document.form2.gdComm.length=<%=CommAL.size()%>+1;
		document.form2.gdComm.options[0] = new Option("","");
		document.form2.gdComm.options[0].selected;
		<%
		for(int i=0;i<CommAL.size();i++){
		out.print("document.form2.gdComm.options["+(i+1)+"] = new Option(\""+CommAL.get(i)+"\",\""+CommAL.get(i)+"\");\r\n");
		}		
		%>		
		
	}else if(comm == "GD20"){
		document.form2.gdComm.length=2;
		document.form2.gdComm.options[0] = new Option("YES","YES");
		document.form2.gdComm.options[1] = new Option("NO","NO");
	}else if(comm == "GD25"){
		document.form2.gdComm.length=2;
		document.form2.gdComm.options[0] = new Option("YES","YES");
		document.form2.gdComm.options[1] = new Option("NEED TO IMPROVE","NEED TO IMPROVE");
	}else if(comm == "GD28"){
		document.form2.gdComm.length=2;
		document.form2.gdComm.options[0] = new Option("YES","YES");
		document.form2.gdComm.options[1] = new Option("NO","NO");
	}else{
		document.form2.gdComm.length=<%=CommAL.size()%>;
		<%
		for(int i=0;i<CommAL.size();i++){
		out.print("document.form2.gdComm.options["+i+"] = new Option(\""+CommAL.get(i)+"\",\""+CommAL.get(i)+"\");\r\n");
		}		
		%>		
		//document.form2.gdComm.value = "工作敬業、認真";
	}
}

function showspan(val,val2)
{
	var colname = "gd_str";
	//alert(val2);
	document.form2.comm.value = "";
	document.form2.gddesc.value = val2;
	document.form2.gdname.value = val;

	for (var i=0; i < eval("document.form2."+colname+".length"); i++)
	{
		eval("document.form2."+colname+"[i].checked=false");		
	}

	if(val=='GD3')
	{
		document.getElementById("GD3_span").style.display="";
		document.getElementById("GD17_span").style.display="none";
		document.getElementById("GD20_span").style.display="none";	
		document.getElementById("GD25_span").style.display="none";
		document.getElementById("GD28_span").style.display="none";	
	}
	if(val=='GD17')
	{
		document.getElementById("GD3_span").style.display="none";
		document.getElementById("GD17_span").style.display="";
		document.getElementById("GD20_span").style.display="none";	
		document.getElementById("GD25_span").style.display="none";
		document.getElementById("GD28_span").style.display="none";	
	}
	if(val=='GD20')
	{
		document.getElementById("GD3_span").style.display="none";
		document.getElementById("GD17_span").style.display="none";
		document.getElementById("GD20_span").style.display="";	
		document.getElementById("GD25_span").style.display="none";
		document.getElementById("GD28_span").style.display="none";	
	}
	if(val=='GD25')
	{
		document.getElementById("GD3_span").style.display="none";
		document.getElementById("GD17_span").style.display="none";
		document.getElementById("GD20_span").style.display="none";	
		document.getElementById("GD25_span").style.display="";
		document.getElementById("GD28_span").style.display="none";	
	}
	if(val=='GD28')
	{
		document.getElementById("GD3_span").style.display="none";
		document.getElementById("GD17_span").style.display="none";
		document.getElementById("GD20_span").style.display="none";	
		document.getElementById("GD25_span").style.display="none";
		document.getElementById("GD28_span").style.display="";	
	}
	if(val=='GD18')
	{
		document.getElementById("GD3_span").style.display="none";
		document.getElementById("GD17_span").style.display="none";
		document.getElementById("GD20_span").style.display="none";	
		document.getElementById("GD25_span").style.display="none";
		document.getElementById("GD28_span").style.display="none";	
	}
}


function compose_note(colname)
{
	var c_value = "";
	for (var i=0; i < eval("document.form2."+colname+".length"); i++)
	{
		if (eval("document.form2."+colname+"[i].checked"))
		{
			c_value = c_value+" "+ eval("document.form2."+colname+"[i].value") ;
		}
	}

	//alert(c_value);
	document.getElementById("comm").value = c_value ;
}



</script>
<script src="../js/subWindow.js" language="javascript" type="text/javascript"></script>
<script src="../../js/CheckAll.js" language="javascript" type="text/javascript"></script>
<style type="text/css">
input.st1
{
	border-bottom: 0px solid #FFFFFF ;
	border-top: 0px solid #FFFFFF ;
	border-left: 0px solid #FFFFFF ;
	border-right: 0px solid #FFFFFF ;
	vertical-align: bottom;
	font-size: 10pt;
}
</style>
</head>

<body>
<div align="center">

    <span class="txttitletop">In-Flight Service Grade Edit</span>
</div>
<form name="form1" method="post" action="delGdType.jsp" onSubmit="return del('form1')">
  <table width="85%"  border="0" align="center" cellpadding="2" cellspacing="0" >
    <tr>
      <td class="txtblue">Date:<span class="txtred"><%=fdate%></span></td>
      <td class="txtblue">Fltno:<span class="txtred"><%=fltno%></span></td>
      <td class="txtblue">Sern:<span class="txtred"><%=sern%></span></td>
      <td class="txtblue"><span class="txtblue">Name:</span><span class="txtred"><%=cname%>&nbsp;<%=ename%></span></td>
    </tr>
  </table>
  <%
  if(!SelectgdTypeAL.isEmpty())
  {  	
  %>
  <table width="85%"  border="0" align="center" cellpadding="2" cellspacing="0" class="fortable">
    <tr class="tablehead3 fortable">
      <td width="11%"><input name="allchkbox" type="checkbox" onClick="CheckAll('form1','allchkbox')"> 
      Select
</td>
      <td width="29%">Item</td>
      <td width="60%">Comments</td>
    </tr>
	<%	for(int i=0;i<SelectgdTypeAL.size();i++)
	    {
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

%>
</form>
<!--****************************************************************************-->
<br>
<form name="form2" method="post" action="upGdType.jsp" onSubmit="return checkCharacter()">
  <table width="85%"  border="0" align="center" cellpadding="2" cellspacing="0" >
    <tr>
      <td align="center" class="txtblue">
	    <strong>考評項目 : </strong>        
        <input name="gd_yn" id="gd_yn" type="radio"  value="GD3" onClick="showspan('GD3','優點')">
        優點&nbsp;  
        <input name="gd_yn" id="gd_yn" type="radio"  value="GD29" onClick="showspan('GD29','優點(ML)')">
        優點(ML)&nbsp;         
		<input name="gd_yn" id="gd_yn" type="radio"  value="GD17" onClick="showspan('GD17','註記(REC)')">
        註記(REC)
      </td>
      <td align="center" class="txtblue">
	    <strong>專業知識 : </strong>
        <input name="gd_yn" id="gd_yn" type="radio"  value="GD20" onClick="showspan('GD20','CCOM考核')">CCOM考核&nbsp;
        <input name="gd_yn" id="gd_yn" type="radio"  value="GD25" onClick="showspan('GD25','KPI')">KPI&nbsp;
        <input name="gd_yn" id="gd_yn" type="radio"  value="GD28" onClick="showspan('GD28','SMS Q&A')">SMS Q&A&nbsp;
        <input name="gd_yn" id="gd_yn" type="radio"  value="GD18" onClick="showspan('GD18','其他')">其他
      </td>
    </tr>
  </table>
  <br>
  <table width="85%"  border="0" align="center" cellpadding="2" cellspacing="0" class="fortable">
    <tr height="20">
      <td class="tablehead3" colspan="3">個人考評</td>
    </tr>
    <tr>
      <td  class="tablehead3 fortable">Item</td>
      <td class="txtblue fortable" align="left">
		<input name="gddesc" id="gddesc" type="text" value="" size="10" class="st1"></td>
		<input name="gdname" id="gdname" type="hidden" value=""></td>
      <td class="txtblue fortable" align="center">Template</td>
    </tr>
    <tr>
      <td height="59"class="tablehead3 fortable">Comments</td>
      <td class="fortable">
          <textarea name="comm" id="comm" cols="50" rows="5"></textarea>
      </td>
	  <td class="txtblue fortable" >
		<span style="display:none " name="GD3_span" id="GD3_span" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td>
		  <input type="checkbox" name="gd_str" value="旅客讚揚" onclick="compose_note('gd_str')">旅客讚揚<br> 
		  <input type="checkbox" name="gd_str" value="笑容可鞠、服務親切" onclick="compose_note('gd_str')">笑容可鞠、服務親切<br>
		  <input type="checkbox" name="gd_str" value="服務主動、認真積極" onclick="compose_note('gd_str')">服務主動、認真積極<br>
		  <input type="checkbox" name="gd_str" value="溝通技巧佳" onclick="compose_note('gd_str')">溝通技巧佳<br>
		  <!-- <input type="checkbox" name="gd_str" value="服裝儀容佳" onclick="compose_note('gd_str')">服裝儀容佳-->
		  </td>
		  </tr>
		</table>
		</span>
		<span style="display:none" name="GD17_span" id="GD17_span" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td>
		  <input type="checkbox" name="gd_str" value="旅客抱怨" onclick="compose_note('gd_str')">旅客抱怨<br> 
		  <input type="checkbox" name="gd_str" value="缺乏笑容" onclick="compose_note('gd_str')">缺乏笑容<br>
		  <input type="checkbox" name="gd_str" value="態度、應對不佳" onclick="compose_note('gd_str')">態度、應對不佳<br>
		  <input type="checkbox" name="gd_str" value="工作怠惰、被動" onclick="compose_note('gd_str')">工作怠惰、被動<br>
		  <input type="checkbox" name="gd_str" value="情緒管理不佳" onclick="compose_note('gd_str')">情緒管理不佳<br>
		  <input type="checkbox" name="gd_str" value="廚房工作區大聲說話" onclick="compose_note('gd_str')">廚房工作區大聲說話<br>
		  <input type="checkbox" name="gd_str" value="服儀缺失" onclick="compose_note('gd_str')">服儀缺失
		  </td>
		  </tr>
		</table>
		</span>
		<span style="display:none" name="GD20_span" id="GD20_span" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td>
		  <input type="checkbox" name="gd_str" value="YES" onclick="compose_note('gd_str')">YES<br> 
		  <input type="checkbox" name="gd_str" value="NO" onclick="compose_note('gd_str')">NO
		  </td>
		  </tr>
		</table>
		</span>
		<span style="display:none" name="GD25_span" id="GD25_span" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td>
		  <input type="checkbox" name="gd_str" value="YES" onclick="compose_note('gd_str')">YES<br> 
		  <input type="checkbox" name="gd_str" value="NEED TO IMPROVE" onclick="compose_note('gd_str')">NEED TO IMPROVE
		  </td>
		  </tr>
		</table>
		</span>
		<span style="display:none" name="GD28_span" id="GD28_span" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td>
		  <input type="checkbox" name="gd_str" value="YES" onclick="compose_note('gd_str')">YES<br> 
		  <input type="checkbox" name="gd_str" value="NO" onclick="compose_note('gd_str')">NO
		  </td>
		  </tr>
		</table>
		</span>
      </td>
    </tr>
  </table>
  <div align="center">
    <input type="submit" name="Submit" value="Save (儲存)" class="addButton">&nbsp;&nbsp;&nbsp;
		<input name="reset" type="reset" value="Reset (清除重寫)">&nbsp;&nbsp;&nbsp;
        <input name="button" type="button"  onClick="javascript:self.close()" value="Exit (離開)">		&nbsp;&nbsp;&nbsp;
 		<input type="hidden" name="fltno" value="<%=fltno%>">
		<input type="hidden" name="fdate" value="<%=fdate%>">
		<input type="hidden" name="sern"  value="<%=sern%>">
		<input type="hidden" name="cname" value="<%=cname%>">
		<input type="hidden" name="ename" value="<%=ename%>">
		<input type="hidden" name="sect"  value="<%=sect%>">
		<input type="hidden" name="GdYear" value="<%=GdYear%>">
		<input type="hidden" name="empno"  value="<%=empno%>">
		<input type="hidden" name="IsNewData" value="<%=IsNewData%>">
 </div>
</form>
<table width="85%"  border="0" align="center" cellpadding="2" cellspacing="0" >
  <tr >
    <td colspan="2"  >
      <div align="left" class="purple_txt">
        <p><strong>Comments除了樣板項目外，亦可自行輸入。<br>
        輸入完畢請選擇Save(儲存)。</strong></p>
      </div>
    </td>
  </tr>
</table>
<p align="center">&nbsp;</p>
</body>
</html>

