<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="eg.zcrpt.*,java.sql.*,java.util.ArrayList,ci.db.*,java.net.URLEncoder" %>
<%
//新增、刪除GdType
//response.setHeader("Cache-Control","no-cache");
//response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
ArrayList objAL = (ArrayList) session.getAttribute("zcreportobjAL"); 
if ( sGetUsr == null | objAL == null) 
{		//check user session start first or not login
	response.sendRedirect("/webfz/FZ/sendredirect.jsp");
}
else
{
	String idx = request.getParameter("idx");
	String subidx = request.getParameter("subidx");
	boolean chkdup = false;
	ZCReportObj obj = (ZCReportObj) objAL.get(Integer.parseInt(idx));
	ArrayList crewListobjAL = new ArrayList();
	crewListobjAL = obj.getZccrewObjAL();
	ZCReportCrewListObj zccrewobj = (ZCReportCrewListObj) crewListobjAL.get(Integer.parseInt(subidx));	ArrayList crewgradeobjAL = new ArrayList();
	crewgradeobjAL = zccrewobj.getGradeobjAL();

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

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>檢視及新增考核項目View &amp; Add In-Flight Service Grade Ed</title>
<link href="../style2.css" rel="stylesheet" type="text/css">
<script src="../checkDel.js" type="text/javascript"></script>

<script language="JavaScript" type="text/JavaScript">
function checkCharacter()
{
	var message = document.form2.comm.value;
	var len = document.form2.comm.value.length;
	
		//alert(len);
	if(len >800)
	{
		alert("Comments字元數限制為1000個字元，\n所輸入字數超過"+(len-800)+"個字元，請重新輸入");
		document.form2.comm.focus();
		return false;
	}
	else if(len == "")
	{
		if(confirm("尚未選擇Comments敘述，確定要送出？")){
		document.form2.Submit.disabled=1;
		document.form2.addToComm.disabled=1;
			
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
		return true;
	}
}
function addComm2()
{//將第一個comments的選項值帶到輸入欄位，可重複附加
    var addcomm = document.form2.gdComm.value;
	var originalComm = document.form2.comm.value;
	originalComm +=  ","+addcomm;	//用,隔開
	if(document.form2.comm.value == "")
	{	
		document.form2.comm.value = addcomm;	//輸入欄位無內容，直接加入選取的comments
	}
	else
	{
		document.form2.comm.value = originalComm;	//輸入欄位已有內容，附加選取的comments並用,隔開
	}
}

function clearcomm()
{
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

</script>
<script src="../../js/subWindow.js" language="javascript" type="text/javascript"></script>
<script src="../../../js/CheckAll.js" language="javascript" type="text/javascript"></script>

</head>

<body>
<div align="center">

    <span class="txttitletop">In-Flight Service Grade Edit</span>
</div>
<form name="form1" method="post" action="zcdelGdType.jsp" onSubmit="return del('form1')">
  <table width="78%"  border="0" align="center" cellpadding="2" cellspacing="0" >
    <tr>
      <td class="txtblue">Date:<span class="txtred"><%=obj.getFdate()%></span></td>
      <td class="txtblue">Fltno:<span class="txtred"><%=obj.getFlt_num()%></span></td>
      <td class="txtblue">Sern:<span class="txtred"><%=zccrewobj.getSern()%></span></td>
      <td class="txtblue"><span class="txtblue">Name:</span><span class="txtred"><%=zccrewobj.getCname()%></span></td>
    </tr>
  </table>
  <%
  if(crewgradeobjAL.size()>0)
  {
  %>
  <table width="78%"  border="0" align="center" cellpadding="2" cellspacing="0" class="fortable">
    <tr class="tablehead3 fortable">
      <td width="11%"><input name="allchkbox" type="checkbox" onClick="CheckAll('form1','allchkbox')"> 
      Select
</td>
      <td width="29%">Grade</td>
      <td width="60%">Comments</td>
    </tr>
	<%	for(int i=0;i<crewgradeobjAL.size();i++)
	    {
			ZCGradeObj gradeobj = (ZCGradeObj) crewgradeobjAL.get(i) ;	
	%>
    <tr class="fortable">
      <td align="center" class="fortable"><input type="checkbox" name="delgdtype" value="<%=gradeobj.getGdtype()%>"></td>
      <td class="fortable txtblue" style="cursor:hand"><a href="#" onClick="subwinXY('zcedGdType2.jsp?idx=<%=idx%>&subidx=<%=subidx%>&subsubidx=<%=i%>','edit','600','350')"><u><%=gradeobj.getGddesc()%></u></a></td>
      <td class="fortable txtblue"><%=gradeobj.getComments()%></td>
    </tr>
	<%
	  }
	%>
  </table>
  <div align="center">
    <input name="Submit" type="submit" class="delButon" value="Delete Selected" >
	 	<input type="hidden" name="idx" value="<%=idx%>">
		<input type="hidden" name="subidx" value="<%=subidx%>">
        <br>
        <span class="purple_txt"><strong>*Click Grade to Edit
  </strong></span></div>
  <hr noshade>

  <%
}

%>
</form>
<form name="form2" method="post" action="zcupGdType.jsp" onSubmit="return checkCharacter()">
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
		<option value="GD20">CCOM考核</option>		
		<option value="GD18">其他</option>
        </select>
</td>
    </tr>
    <tr >
      <td height="59"class="tablehead3 fortable">Comments</td>
      <td class="fortable">
        <p>
        <select name="gdComm"  >
			<%=gn.getCommOptionList()%>
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
        <input name="button" type="button"  onClick="javascript:self.close()" value="Exit (離開)">
		<input type="hidden" name="idx" value="<%=idx%>">
		<input type="hidden" name="subidx" value="<%=subidx%>">
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
%>
