<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="ci.db.*,fz.*,java.sql.*,java.net.URLEncoder,fz.pracP.*,java.util.ArrayList" %>
<%
//�s�W�B�R��Flt Irregularity
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if ( sGetUsr == null) {		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
	
}

//�ˬd�O�_��Power user(�}�o�H��.groupId=CSOZEZ)
String  isPowerUser = (String)session.getAttribute("powerUser"); 


 /*
//����ʺA���
ThreeSelect ts = new ThreeSelect();
ts.getStatement();
String getItem1 = ts.getItem1();//�Ĥ@�h���
String getItem2 = ts.getItem2();//�ĤG�h���
String getItem3= ts.getItem3();//�ĤT�h���
String script = ts.select1();
ts.closeStatement();
*/
boolean hasRecord = false;

String yearsern = request.getParameter("yearsern");

int count = 0;  
Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
ResultSet myResultSet = null;
//modify by cs66 2005/2/21 
String pur  = request.getParameter("pur");

String purserEmpno = request.getParameter("purserEmpno");
String src = request.getParameter("src");
String sql = null;

String itemdsc1 = null;//�Ĥ@�h��檺�w�]��
String itemdsc2 = null;//�ĤG�h��檺�w�]��
String itemdsc = null;//�ĤT�h��檺�w�]��
String itemno	= null;
String fdate	= null;
String fltno	= null;
String sect = null;
String acno	= null;
String comments = null;
String clb="";
String mcr="";
String rca="";
String emg="";


try
{
	ConnDB cn = new ConnDB();

//���ҬO�_��Purser

if(!"Y".equals(isPowerUser))
{
	//modify by cs66 at 2005/2/21 
	/*
	purserEmpno  �� sql select�X�Ӫ��Ĥ@�ӫDS�ΫDI ��purser empno
	pur ���W�@���ǨӪ�purser empno
	�S���p�|�X�{�A�ӯZpurser�A�ëDselect�X�Ӫ����u���A
	�]�W�@���|��ܨ�Ӯy�����A�ҥH�Y�ǤJ�����u�����n�J�̡A�h�i�s�覹�����i
	
	*/
	if(  !sGetUsr.equals(purserEmpno) &&!sGetUsr.equals(pur) )
	{			response.sendRedirect("../showMessage.jsp?messagestring="+URLEncoder.encode("�D���Z���y�����A���o�ϥΦ��\��") );
	}
}		

cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
		ResultSet.CONCUR_READ_ONLY);

sql = "select dt.* ,To_Char(dt.fltd,'yyyy/mm/dd') fltd2,pi.itemdsc dsc "+
	"from egtcmdt dt, egtcmpi pi "+
	"where dt.itemno = pi.itemno and yearsern='"+yearsern+"'";
			  
myResultSet = stmt.executeQuery(sql);
	
while(myResultSet.next())
{
	 itemdsc2		= myResultSet.getString("dsc");//�ĤG�h
	 itemno		= myResultSet.getString("itemno");
	 itemdsc	= myResultSet.getString("itemdsc");//�ĤT�h
	 fdate		= myResultSet.getString("fltd2");
	 fltno		= myResultSet.getString("fltno");
	 sect 		= myResultSet.getString("sect");
	 acno		= myResultSet.getString("acno");
	 comments	= myResultSet.getString("comments");
	 clb 		= myResultSet.getString("clb");
	 mcr 		= myResultSet.getString("mcr");
	 rca 		= myResultSet.getString("rca");
	 emg 		= myResultSet.getString("emg");
	 
}

myResultSet.close();
//��Ĥ@�h��檺��
sql = "select itemdsc from egtcmti where itemno='"+ itemno.substring(0,1)+"'";
myResultSet = stmt.executeQuery(sql);
while(myResultSet.next())
{
	itemdsc1 = myResultSet.getString("itemdsc");
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
<script language="JavaScript" type="text/JavaScript">
//�]�w�ʺA�����--���J�}�C�r��
<jsp:include page="select.jsp" />

function Buildkey(num)
{
Buildkey1(0);
document.form1.item2.selectedIndex=0;
for(ctr=0;ctr<array02[num].length;ctr++)
{
document.form1.item2.options[ctr]=new Option(array02[num][ctr],array02[num][ctr]);
}
document.form1.item2.length=array02[num].length;
}

function Buildkey1(num)
{
document.form1.item3.selectedIndex=0;
for(ctr=0;ctr<array03[document.form1.item1.selectedIndex][num].length;ctr++)
{
document.form1.item3.options[ctr]=new Option(array03[document.form1.item1.selectedIndex][num][ctr],array03[document.form1.item1.selectedIndex][num][ctr]);
}
document.form1.item3.length=array03[document.form1.item1.selectedIndex][num].length;
}


function checkCharacter()
{
	var message = document.form1.comm.value;
	var len = document.form1.comm.value.length;

		//alert(len);
	if(len >3000){	//column��쭭�4000�A��J��3500�Ӧr��
		alert("Comments�r���ƭ��4000�Ӧr���A\n�ҿ�J�r�ƶW�L"+(len-3500)+"�Ӧr���A�Э��s��J");
		document.form1.comm.focus();
		return false;
	}
	else if(len == ""){
		if(confirm("�|�����Comments�ԭz�A�T�w�n�e�X�H")){
		document.form1.Submit.disabled=1;
		
		<%
			if(hasRecord){
				out.print("document.form1.Submit.disabled=1;");
			}
		%>		
			return true;
		}
		else{
			document.form1.comm.focus();
			return false;
		}
	}
	else{
		document.form1.Submit.disabled=1;
		
		<%
			if(hasRecord){
				out.print("document.form1.Submit.disabled=1;");
			}
		%>		
		return true;
	}
}


function show()
{//�N�T�h���w�]�ȡA��ܬ���X�Ӫ���ƭ�

	document.getElementById('item1').value="<%=itemdsc1%>";//�Ĥ@�h��檺�w�]�Ȭ���X�Ӫ���
	Buildkey(document.getElementById('item1').selectedIndex);//�ҰʰʺA�ĤG�h���
	document.getElementById('item2').value="<%=itemdsc2%>";//�ĤG�h��檺�w�]�Ȭ���X�Ӫ����
	Buildkey1(document.getElementById('item2').selectedIndex);//�ҰʰʺA�ĤT�h���
	document.getElementById('item3').value="<%=itemdsc%>";//�ĤT�h��檺�w�]�Ȭ���X�Ӫ����

	//**********************************************************
	var item3_str = document.getElementById('item3').value;
	if(item3_str=="" || item3_str == null)
	{
		var s = document.getElementById('item3');        
		var new_option = new Option('�Щ��������','�Щ��������');        
		s.options.add(new_option);	
		s.options[(document.getElementById("item3").length)-1].setAttribute("selected", "selected");
	}
}

function initData()
{	//�]�wradio button���w�]��
	var clbO = "<%=clb%>";
	var mcrO = "<%=mcr%>";
	var rcaO = "<%=rca%>";
	var emgO = "<%=emg%>";

	
	if( clbO =="Y"){
		document.form1.clb[0].checked = true;
	}else if(clbO =="N"){
		document.form1.clb[1].checked = true;
	}
	if( mcrO =="Y"){
		document.form1.mcr[0].checked = true;
	}else if(mcrO =="N"){
		document.form1.mcr[1].checked = true;
	}
	if( rcaO =="Y"){
		document.form1.rca[0].checked = true;
	}else if(rcaO =="N"){
		document.form1.rca[1].checked = true;
	}
	if( emgO =="Y"){
		document.form1.emg[0].checked = true;
	}else if(emgO =="N"){
		document.form1.emg[1].checked = true;
	}
}
</script>
</head>

<body onLoad="show();initData();">
<form name="form1" action="upFltIrr2.jsp" onSubmit="return checkCharacter()" >

<div align="center">
<table width="90%"  border="0" cellspacing="0" cellpadding="2">
  <tr>
    <td width="85%">
      <div align="center"><span class="txttitletop">Flt Irregularity</span></div>
    </td>
    <td width="15%">&nbsp;       </td>
  </tr>
</table>
</div>
  <table width="90%"  border="0" align="center" cellpadding="2" cellspacing="0" >
    <tr>
      <td width="27%" class="txtblue">FltDate:<span class="txtxred"><%=fdate%></span></td>
      <td width="23%" class="txtblue">Fltno:<span class="txtxred"><%=fltno%></span></td>
      <td width="25%" class="txtblue">Sec:<span class="txtxred"><%=sect%></span></td>
      <td width="25%" class="txtblue">ACNO:<span class="txtxred"><%=acno%></span></td>
    </tr>
  </table>



    <div align="center">      <br>
      </div>

	    <table width="90%"  border="0" align="center" cellpadding="2" cellspacing="0" class="fortable">
    <tr >
      <td  class="tablehead3 fortable">Item</td>
      <td class="fortable">
		  <select name="item1" id="item1" OnChange="Buildkey(this.selectedIndex);">
<jsp:include page="select1.jsp" />
	


		</select> 
		    <select name="item2" id="item2" OnChange="Buildkey1(this.selectedIndex);"  >
<jsp:include page="select2.jsp" />
		
        </select>
			
			<select  name="item3" id="item3">
<jsp:include page="select3.jsp" />
            </select>      
	  </td>
    </tr>
    <tr >
      <td height="59"class="tablehead3 fortable">Comments</td>
      <td class="fortable">
         <textarea name="comm" cols="50" rows="4"><%=comments%></textarea>
      </td>
    </tr>
    <tr >
      <td height="59" colspan="2"><span class="txtblue">
	      1. �w�xCLB�G
           <label>
           <input type="radio" name="clb" value="Y">
           <span class="txtxred">YES</span></label>
           <label>
           <input  type="radio" name="clb" value="N">NO</label>
          <br>
		  2. �w�xIn Flight Meal Check Report�G
			<label>
			<input type="radio" name="mcr" value="Y">
			<span class="txtxred">YES</span></label>
			<label>
			<input type="radio" name="mcr" value="N">NO</label>
			<br>
		  3. �w�^������խ��G
			<label>
			<input type="radio" name="rca" value="Y">
			<span class="txtxred">YES</span></label>
			<label>
			<input type="radio" name="rca" value="N">NO</label>
			<br>
		  4. �w�ϥκ��˳ơG
			<label>
			<input type="radio" name="emg" value="Y">
			<span class="txtxred">YES</span></label>
			<label>
			<input type="radio" name="emg" value="N">NO</label>
      </span></td>
      </tr>	
  </table>
  <div align="center">
    <input type="submit" name="Submit" value="Save (�x�s)" class="addButton"  >&nbsp;&nbsp;&nbsp;		&nbsp;&nbsp;&nbsp;
       <!-- <input name="button" type="button"  onClick="javascript:self.close()" value="Discard (����x�s)">-->		
       <input name="button" type="button"  onClick="javascript:self.close()" value="Exit (���})">
       &nbsp;&nbsp;&nbsp;

		<input type="hidden" name="fltd" value="<%=fdate%>">
        <input type="hidden" name="fltno" value="<%=fltno%>">
        <input type="hidden" name="sect" value="<%=sect%>">
		<input type="hidden" name="acno" value="<%=acno%>">
		<input type="hidden" name="yearsern" value="<%=yearsern%>">
        <input type="hidden" name="purserEmpno" value="<%=purserEmpno%>">
		<input type="hidden" name="pur" value="<%=pur%>">
		<input type="hidden" name="isZ" value="<%=request.getParameter("isZ")%>">
		<input type="hidden" name="src" value="<%=src%>">

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