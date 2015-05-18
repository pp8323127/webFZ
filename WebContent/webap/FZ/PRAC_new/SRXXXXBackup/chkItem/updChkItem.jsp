<%@ page contentType="text/html; charset=big5" language="java"  pageEncoding="big5" %>
<%@ page import="java.sql.*,ci.db.*"%>
<%

String fltd  = request.getParameter("fltd");
String fltno  = request.getParameter("fltno");
String sector  = request.getParameter("sector");
String psrEmpn  = request.getParameter("psrEmpn");
String LingPar = request.getParameter("LingPar");
String goPage = request.getParameter("goPage");

String checkRdSeq = null;
if(null != request.getParameter("checkRdSeq") && !"".equals(request.getParameter("checkRdSeq"))){
	checkRdSeq = request.getParameter("checkRdSeq");
}


String executeStatus = request.getParameter("executeStatus");//執行狀態, Y/N
String ev =null;
String[] evItm  =null;
String[] correctItm = null;


if("Y".equals(executeStatus)){
 ev = request.getParameter("ev");//已執行,執行狀態=正常Y/未達標準N
 evItm =  request.getParameterValues("evItm");//已執行,未達標準的選項
 correctItm = request.getParameterValues("correctItm");//已執行,未達標準,以矯正的選項, 	
 
}


String esYComm = request.getParameter("esYComm").trim();//已執行Comments
String esNComm = request.getParameter("esNComm").trim();//未執行Comments

String seqno = request.getParameter("seqno");

boolean status = true;
boolean updateStatus = false;
String errMsg = "";
if("".equals(executeStatus) || null == executeStatus){
	errMsg = "請選擇考核執行狀態(已執行/未執行).";
	status = false;

}else if("N".equals(executeStatus) && ( esNComm== null |"".equals(esNComm))){
	errMsg = "未執行考核,請輸入原因.";
	status = false;
}else if("Y".equals(executeStatus) && ( ev== null |"".equals(ev))){
	errMsg = "請選擇考核執行結果(正常/未達標準).";
	status = false;
		
}


if(status){

Connection conn = null;
PreparedStatement pstmt = null;
ConnDB cn = new ConnDB();
ResultSet rs = null;
Driver dbDriver = null;

try {     
	cn.setORP3EGUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
	conn.setAutoCommit(false);
	
	
	pstmt = conn.prepareStatement("update egtchkrdm set executestatus=?,evalstatus=?,comments=? where seqno=? ");
	
	pstmt.setString(1,executeStatus);//executestatus
	pstmt.setString(2,ev);//evalstatus
	if("Y".equals(executeStatus)){
		pstmt.setString(3,esYComm);//comments
	
	}else{
		pstmt.setString(3,esNComm);//comments
	
	}
	pstmt.setString(4,checkRdSeq);//checkseqno
	
	
	pstmt.executeUpdate();
	
	//先刪除現有comm
	pstmt = conn.prepareStatement("delete egtchkrdd where checkrdseq=?");
	pstmt.setString(1,checkRdSeq);
	pstmt.executeUpdate();
	
	if(evItm != null){
		for(int i=0;i<evItm.length;i++){
			
				pstmt = conn.prepareStatement("INSERT INTO egtchkrdd(checkseqno,checkdetailseq,checkrdseq,correct) "
						+"VALUES(?,?,?,?)");
				pstmt.setString(1,seqno);//checkseqno
				pstmt.setString(2,evItm[i]);//checkdetailseq
				pstmt.setString(3,checkRdSeq);//checkrdseq
				if(correctItm != null){
					pstmt.setString(4,"N");
				for(int idx=0;idx<correctItm.length;idx++){
					if(correctItm[idx].equals(evItm[i])){
						pstmt.setString(4,"Y");						
					}			
				}
				}else{
					pstmt.setString(4,"N");
				}
				pstmt.executeUpdate();
				pstmt.close();			


			
		}
	}
	
	
	
	conn.commit();
	
	
	updateStatus = true;
	
	
}catch(SQLException e){
	updateStatus = false;
	errMsg += e.getMessage();
	try {
	//有錯誤時 rollback
		conn.rollback();
	} catch (SQLException e1) {
		errMsg += e1.getMessage();
	}
		
}catch(Exception e){
	updateStatus = false;
	errMsg += e.getMessage();

	try {
	//有錯誤時 rollback
		conn.rollback();
	} catch (SQLException e1) {
		errMsg += e1.getMessage();
	}
}  finally {
	if (rs != null)
		try {
			rs.close();
		} catch (SQLException e) {	errMsg += e.getMessage();}
	if (pstmt != null)
		try {
			pstmt.close();
		} catch (SQLException e) {	errMsg += e.getMessage();}
	if (conn != null) {
		try {
			conn.close();
		} catch (SQLException e) {
				errMsg += e.getMessage();
		}
		conn = null;
	}
}





}

eg.flightcheckitem.CheckItemKeyValue ckKey = new eg.flightcheckitem.CheckItemKeyValue();
	ckKey.setFltd(fltd);
	ckKey.setFltno(fltno);
	ckKey.setSector(sector);
	ckKey.setPsrEmpn(psrEmpn);
eg.flightcheckitem.CheckItemWithFlight ckhItemFlt = null;
ArrayList al = null;
try{
	ckhItemFlt = new eg.flightcheckitem.CheckItemWithFlight(ckKey);
	
	al = ckhItemFlt.getChkItemAL();
	
	
}catch(Exception e){}



%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>查核項目</title>
<link rel="stylesheet" type="text/css" href="checkStyle1.css">
<script language="javascript"  type="text/javascript">
function goToPage(targetPage){
	eval("document.form1.action='"+targetPage+"';");
		eval("document.form1.submit();");
}
</script>

</head>

<body>
<%
if(!status || !updateStatus ){
%>
<div class="paddingTopBottom1 bg3 red center"><%=errMsg%><br><a href="javascript:history.back(-1);" target="_self">Back</a></div>
<%
}else{
%>
<script language="javascript" type="text/javascript">
alert("查核項目資料更新完成!!");
</script>
<div >
  
 
   
  <form  method="post" name="form1">
   <table width="70%" cellpadding="0" cellspacing="1" style="border-collapse:collapse; " align="center">
<caption class="paddingTopBottom1 bg3 red center">
 Check Item is updated!!! 
</caption>	  
<tr>
	<td width="13%" height="35">&nbsp;</td>
	<td width="87%"class="left">
	   <input name="mform" type="button"  value="Modify Report" onClick="javascript:goToPage('../<%=goPage%>')" >&nbsp;
   <input name="mform" type="button"  value="Edit Flt Irregularity" onClick="javascript:goToPage('../<%=LingPar%>')" >
</td>
</tr>
<%
if (al != null) {
%>
<tr>
  <td height="35">&nbsp;</td>
  <td class="left red">需完成方能繳交報告之查核項目：</td>
</tr>
<tr>
  <td height="35">&nbsp;</td>
  <td class="left">
<%
		for(int i=0;i<al.size();i++){
			eg.flightcheckitem.CheckMainItemObj obj 
					= (eg.flightcheckitem.CheckMainItemObj)al.get(i);
			StringBuffer str =new StringBuffer("輸入</span>");
			if(!obj.isHasCheckData()){
				str.insert(0,"<span class='red'>尚未");
			}else{
				str.insert(0,"<span class='blue'>已");
			}
		
%>
		<a href="javascript:editChkform('<%=obj.getSeqno()%>','<%=obj.getCheckRdSeq()%>',<%=obj.isHasCheckData()%>)" target="_self">
		<img src="../../images/layout_edit.gif" width="16" height="16" align="absmiddle" >&nbsp;<%=obj.getDescription()+"("+str.toString()+")"%></a><br>
<%			
			
		}
%>  
  </td>
</tr>
<%
}
%>
</table>
	<input type="hidden" name="seqno" value="<%=seqno%>">
	<input type="hidden" name="fltd" value="<%=fltd%>">
	<input type="hidden" name="fltno" value="<%=fltno%>">
	<input type="hidden" name="sector" value="<%=sector%>">
	<input type="hidden" name="psrEmpn" value="<%=psrEmpn%>">
	<input type="hidden" name="section" value="<%=sector%>">
	<input type="hidden" name="dpt" value="<%=request.getParameter("dpt").trim()%>">		
	<input type="hidden" name="arv" value="<%=request.getParameter("arv").trim()%>">	
	<input type="hidden" name="purserEmpno" value="<%=psrEmpn%>">	
	<input type="hidden" name="psrname" value="<%=request.getParameter("psrname")%>">	
	<input type="hidden" name="psrsern" value="<%=request.getParameter("psrsern")%>">
	<input type="hidden" name="pur" value="<%=psrEmpn%>">	
	<input type="hidden" name="LingPar" value="<%=request.getParameter("LingPar")%>">
	<input type="hidden" name="goPage" value="<%=request.getParameter("goPage")%>">
	<input type="hidden" name="checkRdSeq">

  </form>
	
   

<%
}
%>


<script language="javascript" type="text/javascript">
//function editChkform(seqno,edited){
function editChkform(seqno,checkRdSeq,edited){

	document.getElementById("seqno").value = seqno;
	if(edited){
		document.form1.action="ModChkItem.jsp";
		document.getElementById("checkRdSeq").value = checkRdSeq;
	}else{
		document.form1.action="EditChkItem.jsp";
	}
	document.form1.submit();
}


</script>

</body>
</html>
