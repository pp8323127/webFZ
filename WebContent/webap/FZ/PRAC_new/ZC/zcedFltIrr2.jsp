<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="eg.zcrpt.*,ci.db.*,fz.*,java.sql.*,java.net.URLEncoder,fz.pracP.*,java.util.ArrayList" %>
<%
//�s�W�B�R��Flt Irregularity
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
ArrayList objAL = (ArrayList) session.getAttribute("zcreportobjAL"); 
if ( sGetUsr == null) 
{		//check user session start first or not login
	response.sendRedirect("/webfz/FZ/sendredirect.jsp");
}

//�ˬd�O�_��Power user(�}�o�H��.groupId=CSOZEZ)
String idx = request.getParameter("idx");
ZCReportObj obj = (ZCReportObj) objAL.get(Integer.parseInt(idx));
String seqkey = (String) request.getParameter("seqkey");
String itemno = (String) request.getParameter("itemno");

//out.print(obj.getSeqno()+"****"+itemno+"*******"+itemdesc+"****<br>");

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
int count = 0;  
Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
ResultSet myResultSet = null;
String sql = null;
String itemdsc1 = null;//�Ĥ@�h��檺�w�]��
String itemdsc2 = null;//�ĤG�h��檺�w�]��
String itemdsc = null;//�ĤT�h��檺�w�]��
String fdate	= null;
String fltno	= null;
String sect = null;
String acno	= null;
String comments = null;

try
{
ConnectionHelper ch = new ConnectionHelper();
conn = ch.getConnection();
stmt = conn.createStatement();

sql = " select dt.* ,pi.itemdsc dsc from egtzccmdt dt, egtcmpi pi where dt.itemno = pi.itemno  AND  dt.seqkey = to_number("+seqkey+")";
//out.println(sql+"<br>");			  
myResultSet = stmt.executeQuery(sql);
	
while(myResultSet.next())
{
	 itemdsc2	= myResultSet.getString("dsc");//�ĤG�h
	 itemno		= myResultSet.getString("itemno");
	 itemdsc	= myResultSet.getString("itemdsc");//�ĤT�h
	 comments	= myResultSet.getString("comments");
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
<link href="../style2.css" rel="stylesheet" type="text/css">
<script src="../checkDel.js" type="text/javascript"></script>
<script src="../../../js/CheckAll.js" language="javascript" type="text/javascript"></script>
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


function checkCharacter(){

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


function show(){//�N�T�h���w�]�ȡA��ܬ���X�Ӫ���ƭ�

	document.getElementById('item1').value="<%=itemdsc1%>";//�Ĥ@�h��檺�w�]�Ȭ���X�Ӫ���
	Buildkey(document.getElementById('item1').selectedIndex);//�ҰʰʺA�ĤG�h���
	document.getElementById('item2').value="<%=itemdsc2%>";//�ĤG�h��檺�w�]�Ȭ���X�Ӫ����
	Buildkey1(document.getElementById('item2').selectedIndex);//�ҰʰʺA�ĤT�h���
	document.getElementById('item3').value="<%=itemdsc%>";//�ĤT�h��檺�w�]�Ȭ���X�Ӫ����


}
</script>
</head>

<body onLoad="show();">

<form name="form1" action="zcupFltIrr2.jsp" onSubmit="return checkCharacter()" >
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
      <td width="27%" class="txtblue">FltDate:<span class="txtxred"><%=obj.getFdate()%></span></td>
      <td width="23%" class="txtblue">Fltno:<span class="txtxred"><%=obj.getFlt_num()%></span></td>
      <td width="25%" class="txtblue">Sector:<span class="txtxred"><%=obj.getPort()%></span></td>
      <td width="25%" class="txtblue">ACNO:<span class="txtxred"><%=obj.getAcno()%></span></td>
    </tr>
  </table>



    <div align="center">      <br>
      </div>

	    <table width="90%"  border="0" align="center" cellpadding="2" cellspacing="0" class="fortable">
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
	  </td>
    </tr>
    <tr >
      <td height="59"class="tablehead3 fortable">Comments</td>
      <td class="fortable">
         <textarea name="comm" cols="50" rows="4"><%=comments%></textarea>
      </td>
    </tr>
  </table>
  <div align="center">
    <input type="submit" name="Submit" value="Save (�x�s)" class="addButton"  >&nbsp;&nbsp;&nbsp;		&nbsp;&nbsp;&nbsp;
       <input name="button" type="button"  onClick="javascript:self.close()" value="Exit (���})">
       &nbsp;&nbsp;&nbsp;
	   <input type="hidden" name="idx" value="<%=idx%>">
	   <input type="hidden" name="itemno" value="<%=itemno%>">
	   <input type="hidden" name="seqkey" value="<%=seqkey%>">
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