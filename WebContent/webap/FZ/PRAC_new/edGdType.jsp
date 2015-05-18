<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="java.sql.*,java.util.ArrayList,ci.db.ConnDB,java.net.URLEncoder" %>
<%
//�s�W�B�R��GdType
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
//���o���Z�~��
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

//�ҵ�����
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
<title>�˵��ηs�W�Үֶ���View &amp; Add In-Flight Service Grade Ed</title>
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
		alert("Comments�r���ƭ��1000�Ӧr���A\n�ҿ�J�r�ƶW�L"+(len-800)+"�Ӧr���A�Э��s��J");
		document.form2.comm.focus();
		return false;
	}
	else if (gdname == "")
	{
		alert("�|����ܦҵ�����/�M�~���Ѷ���");
		return false;
	}
	else if(len == ""){
		if(confirm("�|�����Comments�ԭz�A�T�w�n�e�X�H")){
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
//������w�]comments��A�N�ȱa���J���A�i���ƪ��[
function addComments(){
    var addcomm = document.form2.gdComm.value;
	var originalComm = document.form2.comm.value;
	originalComm +=  ","+addcomm;	//��,�j�}
	if(document.form2.comm.value == ""){	
		document.form2.comm.value = addcomm;	//��J���L���e�A�����[�J�����comments
	}
	else{
		document.form2.comm.value = originalComm;	//��J���w�����e�A���[�����comments�å�,�j�}
	}
	
}
*/
function addComm2(){//�N�Ĥ@��comments���ﶵ�ȱa���J���A�i���ƪ��[
    var addcomm = document.form2.gdComm.value;
	var originalComm = document.form2.comm.value;
	originalComm +=  ","+addcomm;	//��,�j�}
	if(document.form2.comm.value == ""){	
		document.form2.comm.value = addcomm;	//��J���L���e�A�����[�J�����comments
	}
	else{
		document.form2.comm.value = originalComm;	//��J���w�����e�A���[�����comments�å�,�j�}
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
		//document.form2.gdComm.value = "�u�@�q�~�B�{�u";
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
	    <strong>�ҵ����� : </strong>        
        <input name="gd_yn" id="gd_yn" type="radio"  value="GD3" onClick="showspan('GD3','�u�I')">
        �u�I&nbsp;  
        <input name="gd_yn" id="gd_yn" type="radio"  value="GD29" onClick="showspan('GD29','�u�I(ML)')">
        �u�I(ML)&nbsp;         
		<input name="gd_yn" id="gd_yn" type="radio"  value="GD17" onClick="showspan('GD17','���O(REC)')">
        ���O(REC)
      </td>
      <td align="center" class="txtblue">
	    <strong>�M�~���� : </strong>
        <input name="gd_yn" id="gd_yn" type="radio"  value="GD20" onClick="showspan('GD20','CCOM�Ү�')">CCOM�Ү�&nbsp;
        <input name="gd_yn" id="gd_yn" type="radio"  value="GD25" onClick="showspan('GD25','KPI')">KPI&nbsp;
        <input name="gd_yn" id="gd_yn" type="radio"  value="GD28" onClick="showspan('GD28','SMS Q&A')">SMS Q&A&nbsp;
        <input name="gd_yn" id="gd_yn" type="radio"  value="GD18" onClick="showspan('GD18','��L')">��L
      </td>
    </tr>
  </table>
  <br>
  <table width="85%"  border="0" align="center" cellpadding="2" cellspacing="0" class="fortable">
    <tr height="20">
      <td class="tablehead3" colspan="3">�ӤH�ҵ�</td>
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
		  <input type="checkbox" name="gd_str" value="�ȫ��g��" onclick="compose_note('gd_str')">�ȫ��g��<br> 
		  <input type="checkbox" name="gd_str" value="���e�i���B�A�ȿˤ�" onclick="compose_note('gd_str')">���e�i���B�A�ȿˤ�<br>
		  <input type="checkbox" name="gd_str" value="�A�ȥD�ʡB�{�u�n��" onclick="compose_note('gd_str')">�A�ȥD�ʡB�{�u�n��<br>
		  <input type="checkbox" name="gd_str" value="���q�ޥ���" onclick="compose_note('gd_str')">���q�ޥ���<br>
		  <!-- <input type="checkbox" name="gd_str" value="�A�˻��e��" onclick="compose_note('gd_str')">�A�˻��e��-->
		  </td>
		  </tr>
		</table>
		</span>
		<span style="display:none" name="GD17_span" id="GD17_span" class="txtblue">
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
		<tr><td>
		  <input type="checkbox" name="gd_str" value="�ȫȩ��" onclick="compose_note('gd_str')">�ȫȩ��<br> 
		  <input type="checkbox" name="gd_str" value="�ʥF���e" onclick="compose_note('gd_str')">�ʥF���e<br>
		  <input type="checkbox" name="gd_str" value="�A�סB���藍��" onclick="compose_note('gd_str')">�A�סB���藍��<br>
		  <input type="checkbox" name="gd_str" value="�u�@��k�B�Q��" onclick="compose_note('gd_str')">�u�@��k�B�Q��<br>
		  <input type="checkbox" name="gd_str" value="�����޲z����" onclick="compose_note('gd_str')">�����޲z����<br>
		  <input type="checkbox" name="gd_str" value="�p�Фu�@�Ϥj�n����" onclick="compose_note('gd_str')">�p�Фu�@�Ϥj�n����<br>
		  <input type="checkbox" name="gd_str" value="�A���ʥ�" onclick="compose_note('gd_str')">�A���ʥ�
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
    <input type="submit" name="Submit" value="Save (�x�s)" class="addButton">&nbsp;&nbsp;&nbsp;
		<input name="reset" type="reset" value="Reset (�M�����g)">&nbsp;&nbsp;&nbsp;
        <input name="button" type="button"  onClick="javascript:self.close()" value="Exit (���})">		&nbsp;&nbsp;&nbsp;
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
        <p><strong>Comments���F�˪O���إ~�A��i�ۦ��J�C<br>
        ��J�����п��Save(�x�s)�C</strong></p>
      </div>
    </td>
  </tr>
</table>
<p align="center">&nbsp;</p>
</body>
</html>

