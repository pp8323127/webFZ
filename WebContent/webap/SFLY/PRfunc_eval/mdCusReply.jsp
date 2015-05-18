<%@page import="eg.prfe.PRFuncEval"%>
<%@page import="eg.prfe.PREvalCusObj"%>
<%@page import="ws.prac.SFLY.MP.MPsflySugObj"%>
<%@page import="ws.prac.SFLY.MP.MemofbkObj"%>
<%@page import="java.util.ArrayList"%>
<%@page import="ws.prac.SFLY.MP.MPsflyCatObj"%>
<%@ page language="java" contentType="text/html; charset=BIG5"  pageEncoding="BIG5"%>
<%

String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("logout.jsp");
} 
 
//MPsflyCatObj[] cateAL =  (MPsflyCatObj[]) session.getAttribute("cateAL");

String sernno	= request.getParameter("sernno");
String seqno	= request.getParameter("seqno");

PRFuncEval eval = new PRFuncEval();
eval.getPRFuncEvalCus(sernno, seqno);
ArrayList objAL = eval.getObjAL();

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>Modify Cus Reply</title>
<link href="../style.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript">
function compose_note(colname,seq)
{
	var c_value = "";
	for (var i=0; i < eval("document.form1."+colname+".length"); i++)
	{
		if (eval("document.form1."+colname+"[i].checked"))
		{
			c_value = c_value+" "+ eval("document.form1."+colname+"[i].value") ;
		}
	}

	alert(c_value);
	document.getElementById("comm"+seq).value = c_value ;
}

</script>
</head>
<body>
<form name="form1" method="post" action="mdCusReplySave.jsp" onSubmit="">

<div align="center"><span class="txttitletop">旅客反映細項</span></div>
<table width="70%" border="1" align="center" cellpadding="1" cellspacing="1" >
  <tr bgcolor="#9CCFFF" class="txtblue">
	<td width="25%" class="table_head"><div align="center">事項分類</div></td>
	<td width="62%" class="table_head"><div align="center">反映事項</div></td>
  </tr>
  <tr>
  	
	<%
    //out.println(objAL.size());
	if(objAL !=null && objAL.size()>0){
		for(int k=0;k<objAL.size();k++){ 	
		PREvalCusObj obj = (PREvalCusObj)objAL.get(k);

	%>   
   	<td ><div align="center">
	   	 <input type="hidden" name="type" id="type<%=k%>"  value="<%=obj.getQuesNo()%>"><%=obj.getQuesDsc()%>
	</div></td>
	
   	<td>   
	  <input name="comm" type="text" id="comm<%=k%>" size="50" value="<%=obj.getFeedback()%>" ><br>
	  <%
	  if(null!=obj.getSeletItem()&& obj.getSeletItem().length>0){
	  	for(int j=0;j<obj.getSeletItem().length;j++){
	  %>
	  <input type="checkbox" name="select<%=k%>" value="<%=obj.getSeletItem()[j]%>" onclick="compose_note('select<%=k%>','<%=k%>')"><%=obj.getSeletItem()[j]%>
	  <%
	  	}
	  }
	  %>
	  </td>
		
  </tr>
  <%		
		}	
  	}

  %>  
  <tr>  
    <td colspan="3" >
    <div align="center">
		<input type="hidden" name="sernno" id="sernno"  value="<%=sernno%>">
		<input type="hidden" name="seqno" id="seqno"  value="<%=seqno%>">
        <input type="submit" name="Submit" value="Submit">　　
    	<input type="reset" name="Reset" value="Reset">
	</div>
    </td>
    </tr>

</table>
</form>
</body>
</html>
