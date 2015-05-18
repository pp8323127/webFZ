<%@page import="java.sql.SQLException"%>
<%@page import="ci.db.ConnDB"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Driver"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="eg.zcrpt.*,java.util.*" %>
<%
//新增、刪除Flt Irregularity
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
ArrayList objAL = (ArrayList) session.getAttribute("zcreportobjAL"); 
if ( sGetUsr == null | objAL == null) 
{		//check user session start first or not login
	response.sendRedirect("/webfz/FZ/sendredirect.jsp");
}
else
{
String idx = request.getParameter("idx");
ZCReportObj obj = (ZCReportObj) objAL.get(Integer.parseInt(idx));
String itemNoDsc = null;//大項的敘述
String itemDsc = null;//細項的敘述
String comm	= null;
boolean hasRecord = true ;
String liveUrl="http://cabincrew.china-airlines.com/prpt/";
String testUrl="http://cabincrew.china-airlines.com/prptt/";

String url =testUrl; 

%> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>檢視及新增其他事項View &amp; Add Flt Irregularity</title>
<link href="../style2.css" rel="stylesheet" type="text/css">
<script src="../checkDel.js" type="text/javascript"></script>
<script src="../../../js/CheckAll.js" language="javascript" type="text/javascript"></script>
<script src="../../../MT/js/subWindow.js" language="javascript" type="text/javascript"></script>

<script language="JavaScript" type="text/JavaScript">
//設定動態選單選單--載入陣列字串
<jsp:include page="select.jsp" />

function Buildkey(num)
{
//alert(num);
Buildkey1(0);
document.form2.item2.selectedIndex=0;
for(ctr=0;ctr<array02[num].length;ctr++)
{
document.form2.item2.options[ctr]=new Option(array02[num][ctr],array02[num][ctr]);
}
document.form2.item2.length=array02[num].length;
}

function Buildkey1(num)
{
//alert(num);
document.form2.item3.selectedIndex=0;
for(ctr=0;ctr<array03[document.form2.item1.selectedIndex][num].length;ctr++)
{
document.form2.item3.options[ctr]=new Option(array03[document.form2.item1.selectedIndex][num][ctr],array03[document.form2.item1.selectedIndex][num][ctr]);
}
document.form2.item3.length=array03[document.form2.item1.selectedIndex][num].length;
}


function checkCharacter()
{
	var message = document.form2.comm.value;
	var len = document.form2.comm.value.length;
		//alert(len);
	if(len >3000)
	{	//column欄位限制為4000，折衷取3500個字元
		alert("Comments字元數限制為4000個字元，\n所輸入字數超過"+(len-3500)+"個字元，請重新輸入");
		document.form2.comm.focus();
		return false;
	}
	else if(len == "")
	{
		if(confirm("尚未選擇Comments敘述，確定要送出？"))
		{
		document.form2.Submit.disabled=1;
		document.form2.SendReport.disabled=1;
		<%
			if(true)
			{
				out.print("document.form1.Submit.disabled=1;");
			}
		%>		
			return true;
		}
		else
		{
			document.form2.comm.focus();
			return false;
		}
	}
	else
	{
		document.form2.Submit.disabled=1;
		document.form2.SendReport.disabled=1;
		<%
			if(hasRecord)
			{
				out.print("document.form1.Submit.disabled=1;");
			}
		%>		
		return true;
	}
}

function sendReport()
{	
	document.form2.Submit.disabled=1;
	document.form2.SendReport.disabled=1;
	document.form2.action = "zceditCrewList.jsp";
	document.form2.submit();
}
</script>
</head>

<body onload="Buildkey(0);" >
<form name="form1" onSubmit="return del('form1');" action="zcdelFltIrr.jsp">
<input type="hidden" name="idx" value="<%=idx%>">
<div align="center">
<table width="90%"  border="0" cellspacing="0" cellpadding="2">
  <tr>
    <td>
      <div align="center"><span class="txttitletop">Flt Irregularity</span></div>
    </td>
  </tr>
</table>
</div>
  <table width="78%"  border="0" align="center" cellpadding="2" cellspacing="0" >
    <tr>
      <td width="27%" class="txtblue">FltDate:<span class="txtxred"><%=obj.getFdate()%></span></td>
      <td width="23%" class="txtblue">Fltno:<span class="txtxred"><%=obj.getFlt_num()%></span></td>
      <td width="25%" class="txtblue">Sector:<span class="txtxred"><%=obj.getPort()%></span></td>
      <td width="25%" class="txtblue">ACNO:<span class="txtxred"><%=obj.getAcno()%></span></td>
    </tr>
  </table>
<%
if(!"".equals(obj.getSeqno()) && obj.getSeqno() != null)
{
	ZCReport zcrt = new ZCReport();
	zcrt.getZCFltIrrItem(obj.getSeqno());
	ArrayList fltirrAL = new ArrayList();
	fltirrAL = zcrt.getFltIrrObjAL();
	if(fltirrAL.size()>0)
	{
%>
  <table width="78%"  border="0" align="center" cellpadding="2" cellspacing="0" class="fortable">
    <tr class="tablehead3 fortable">
      <td width="11%"><input name="allchkbox" type="checkbox" onClick="CheckAll('form1','allchkbox')"> 
      Select</td>
      <td>ItemNo</td>
      <td>ItemDesc</td>
      <td width="43%">Comments</td>
    </tr>
<%
	for(int i=0; i<fltirrAL.size(); i++)
	{
		ZCFltIrrItemObj fltirrobj =(ZCFltIrrItemObj) fltirrAL.get(i);
%>
    <tr class="fortable">
      <td align="center" class="fortable"><input type="checkbox" value="<%=fltirrobj.getSeqkey()%>" name="delItem"></td>
      <td width="10%" class="fortable txtblue" align="left" ><a href="#" onClick="subwinXY('zcedFltIrr2.jsp?idx=<%=idx%>&itemno=<%=fltirrobj.getItemno()%>&seqkey=<%=fltirrobj.getSeqkey()%>','','700','350')"><u><%=fltirrobj.getItemdsc2()%></u></a></td>
      <td width="16%" class="fortable txtblue" ><%=fltirrobj.getItemdsc()%></td>
      <td class="fortable txtblue"><%=fltirrobj.getComments()%></td>
    </tr>
<%
	}//for(int i=0; i<fltirrAL.size(); i++)
%>
	</table>	
	<div align="center">
    <input name="Submit" type="submit" class="delButon" value="Delete Selected" >
    <br><span class="purple_txt"><strong>*Click Item to Edit
    </strong></span></div>
</br>
<%
	}//if(fltirrAL.size()>0)
}//if(!"".equals(obj.getSeqno()) && obj.getSeqno() == null)


%>

<%
int count = 0;  
Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
ResultSet myResultSet = null;
try{
	ConnDB cn = new ConnDB();
	cn.setORP3EGUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
	stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
	
	ArrayList filename = new ArrayList();
	ArrayList filedsc = new ArrayList();
	count = 0;
	
	myResultSet = stmt.executeQuery("select filename, filedsc from egtzcfile where fltd=to_date('"+obj.getFdate()+"','yyyy/mm/dd') and fltno='"+obj.getFlt_num()+"' and sect='"+obj.getPort()+"'");
	while(myResultSet.next()){
		filename.add(myResultSet.getString("filename"));
		filedsc.add(myResultSet.getString("filedsc"));
		count++;
	}


	if(count > 0){
	%>
	<table width="90%"  border="0" align="center" cellpadding="2" cellspacing="0" class="fortable">
	  <tr class="tablehead3">
	    <td width="13%">&nbsp;</td>
	    <td width="51%">FileName</td>
	    <td width="36%">Description</td>
	  </tr>
	  <%
	 
	  for(int i=0; i < filename.size(); i++){
	  %>
	  <tr>
	    <td class="fortable txtblue">
	      <div align="center">
	        <input type="button" value="DELETE" onClick="if(confirm('確定要刪除檔案：<%=filename.get(i)%> ?')){self.location='FTP/delFile.jsp?idx=<%=idx%>&fdate=<%=obj.getFdate()%>&fltno=<%=obj.getFlt_num()%>&dpt=<%=obj.getPort().substring(0,3)%>&arv=<%=obj.getPort().substring(3,6)%>&uploadFileName=<%=filename.get(i)%>&zcEmpno=<%=obj.getZcempn()%>&acno=<%=obj.getAcno()%>&src=3';this.disabled=1;}else{return false;}" style="background-color:#BFE4FF;color:#00487D;font-family:Verdana "/>
	      </div>
	    </td>
		<!-- test<td class="fortable txtblue"><a href="<%=url%>PR/<%=filename.get(i)%>" target="_blank"><%=filename.get(i)%></a></td>-->
		<td class="fortable txtblue"><a href="<%=url%>PR/<%=filename.get(i)%>" target="_blank"><%=filename.get(i)%></a></td>
	    <td class="fortable txtblue"><%=filedsc.get(i)%></td>
	  </tr>
	  <%
	  }
	  %>
	</table>
	<%
	}

}catch(Exception e ){
	out.println(e.toString());
}finally{
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}

%>
<div align="center">
  <input name="upload" type="button" class="addButton" value="Upload(上傳檔案)" onClick="subwinXY('FTP/uploadfile.jsp?fdate=<%=obj.getFdate()%>&fltno=<%=obj.getFlt_num()%>&dpt=<%=obj.getPort().substring(0,3)%>&arv=<%=obj.getPort().substring(3,6)%>&zcEmpno=<%=obj.getZcempn()%>&acno=<%=obj.getAcno()%>&idx=<%=idx%>&src=3','delUpload','700','350')">
  <br>
</div>

</form>
<hr noshade>
<form name="form2" method="post" action="zcupFltIrr.jsp" onSubmit="return checkCharacter()">
<input type="hidden" name="idx" value="<%=idx%>">
  <table width="78%"  border="0" align="center" cellpadding="2" cellspacing="0" >
    <tr >
      <td colspan="2" class="txttitle" >
        <div align="center">Add Comments</div>
      </td>
    </tr>
  </table>
  <table width="78%"  border="0" align="center" cellpadding="2" cellspacing="0" class="fortable">
    <tr>
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
         <textarea name="comm" cols="50" rows="4"></textarea>
      </td>
    </tr>
  </table>
  <div align="center">
    <input type="submit" name="Submit" value="Save (新增)" class="addButton" >&nbsp;&nbsp;&nbsp;
	<input name="SendReport" type="button" class="addButton" value="Next(下一步)" onClick="sendReport()">&nbsp;&nbsp;&nbsp;
	<input name="reset" type="reset" value="Reset (清除重寫)"><br>
  <span class="txtxred">Input comments max length English 4000 words、Chinese 2000 words</span> </div>
</form>
<p align="center">&nbsp;</p>
</body>
</html>
<%
}		
%>