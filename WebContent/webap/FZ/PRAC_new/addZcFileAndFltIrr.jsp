<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="eg.zcrpt.*,java.sql.*,java.util.ArrayList"%>
<%
//CM套用PR客艙動態及檔案
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
String fltd = request.getParameter("fdate");
String fltno = request.getParameter("fltno");
String sect = request.getParameter("sect");
String acno = request.getParameter("acno");
String purserEmpno = request.getParameter("purserEmpno");
String psrname = request.getParameter("psrname");
String psrsern = request.getParameter("psrsern");
String GdYear = request.getParameter("GdYear");


if ( sGetUsr == null) 
{		//check user session start first or not login
	response.sendRedirect("/webfz/FZ/sendredirect.jsp");
}
else
{
	String liveUrl="http://cabincrew.china-airlines.com/prpt/";
	String testUrl="http://cabincrew.china-airlines.com/prptt/";
	String url =testUrl; 
	ReportCopy file = new ReportCopy();
	//irr
	file.getZCFltIrr(fltd, fltno, sect);
	ArrayList zcirrobjAL = file.getIrrObjAL();
	//file
	file.getZCReportFile(fltd, fltno, sect);
	ArrayList zcfileobjAL = file.getFileObjAL();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title></title>
<link href="style2.css" rel="stylesheet" type="text/css">
<script LANGUAGE="JavaScript">
function bnt_click(para)
{
	var str = "";
	var flag = false;
	var c = 0;
	if(para == "save_irr_btn")
	{
		document.form1.target= "_self" ;
		document.form1.action= "updCopyZcFltIrr.jsp" ;
		str= "客艙動態";
		alert(form1.itemno.length );
		for (var i=0;i<form1.irr.length;i++) {
     		if (form1.irr[i].checked) {c+=1;}
   		}
		if(c <= 0){	
			alert("請至少勾選一個"+str+"項目");
			return false;
		}else{
			flag = true;
		}
			
	}else if(para == "save_file_btn"){
		document.form1.target= "_self" ;
		document.form1.action= "updCopyZcFile.jsp" ;
		str= "檔案";
		c = 0;
		for (var i=0;i<form1.file.length;i++) {
			//alert(form1.filename[i].checked );
     		if (form1.file[i].checked) {c+=1;}
   		}
		if(c <= 0){	
			alert("請至少勾選一個"+str+"項目");
			return false;
		}else{
			flag = true;
		}
	}
	
	if(flag){
		if(confirm("是否套用已勾選之"+str+"?"))
		{
			document.form1.submit();
		}
		else
		{
			return false;
		}
	}else{
		return false;
	}
	
}


</script>

<style type="text/css">
<!--
.style1 {
	font-size: x-large;
	font-weight: bold;
}
.style10 {font-size: small; font-weight: bold; color: #000000; }
.style21 {font-family: Arial, Helvetica, sans-serif; font-size: 14px; }
-->
</style>
</head>
<body>
<div align="center">
  <span class="style1">Purser Report</span><p>
</div>
	<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">
	
		<tr>
	      <td><strong>Date : </strong><%=fltd%></td>
		  <td><strong>Fltno :</strong><%=fltno%></td>
		  <td><strong>Sect : </strong> <%=sect%></td>
		  
	    </tr>
	</table>
<form name="form1" method="post" target="_self">
	<input type="hidden" name="acno" value="<%=acno%>">	
	<input type="hidden" name="fltd" value="<%=fltd%>">
	<input type="hidden" name="fltno" value="<%=fltno%>">
	<input type="hidden" name="sect" value="<%=sect%>">		
	<input type="hidden" name="purserEmpno" value="<%=purserEmpno%>">	
	<input type="hidden" name="psrname" value="<%=psrname%>">	
	<input type="hidden" name="psrsern" value="<%=psrsern%>">
	<input type="hidden" name="GdYear" value="<%=GdYear%>">

   <!-- <table width="100%" border="1" align="center" cellpadding="0" cellspacing="0">
    <tr valign="top">
      <td height="150" colspan="4" valign="top"><strong>Flight Irregularity : </strong>
        <table width="100%"  border="1" cellpadding="0" cellspacing="0">
	       	<tr class="tablehead">
	          	<td width = "10%"  valign="top"></td>
	          	<td width = "30%"  valign="top"><span class="style21">ItemNoDsc</span></td>
				<td width = "30%"  valign="top"><span class="style21">ItemDsc</span></td>
	            <td width = "40%"  valign="top"><span class="style21">Comments</span></td>
			</tr>
        
		<%
		if(zcirrobjAL.size()>0)
		{
			for(int i=0; i<zcirrobjAL.size(); i++)
			{
				ReportCopyObj fltirrobj = (ReportCopyObj) zcirrobjAL.get(i);
		%>
          <tr>
          	<td width = "10%"  valign="top" class="fortable txtblue"><input type="checkbox" name="irr" id="irr[<%=i%>]" value=<%=i%>></td>
			<td width = "30%"  valign="top" class="fortable txtblue"><%=fltirrobj.getItemNoDsc()%></td>
			<td width = "30%"  valign="top" class="fortable txtblue"><%=fltirrobj.getItemDsc()%></td>
            <td width = "40%"  valign="top" class="fortable txtblue"><%=fltirrobj.getComments()%></td>
            
		  </tr>
		 	<input type="hidden" name="itemno" id="itemno[<%=i%>]" value=<%=fltirrobj.getItemno()%>>
			<input type="hidden" name="dsc" id="dsc[<%=i%>]" value=<%=fltirrobj.getItemDsc()%>>
			<input type="hidden" name="com" id="com[<%=i%>]" value=<%=fltirrobj.getComments()%>>
			<input type="hidden" name="flag" id="flag[<%=i%>]" value=<%=fltirrobj.getFlag()%>>  
		<%
			}//for(int i=0; i<zcirrobjAL.size(); i++)
		}//if(zcirrobjAL.size()>0)
%>
      </table>
		<center>
			<input type="button" name="save_irr_btn" id="save_irr_btn" value="套用客艙動態" onclick="bnt_click('save_irr_btn')"></a>
		</center>
	</td>
</tr>
</table> -->

<!-- PR report file -->
<table width="100%" border="1" align="center" cellpadding="0" cellspacing="0">
	<tr valign="top">
		<td height="150" colspan="4" valign="top"><strong>PR Report File List: </strong>
			<table  width="100%"  border="1" cellpadding="0" cellspacing="0">
				<tr class="tablehead">
					<td width = "10%"  valign="top"><span class="style21"> </span></td>
					<td width = "45%"  valign="top"><span class="style21">File Name</span></td>
					<td width = "45%"  valign="top"><span class="style21">File Desc</span></td>
				</tr>
				<%
				if(zcfileobjAL != null || zcfileobjAL.size()>0){
					for(int i=0 ; i<zcfileobjAL.size() ; i ++){
						ReportCopyObj obj = (ReportCopyObj) zcfileobjAL.get(i);
				%>
				<tr>
					<td class="fortable txtblue"><input type="checkbox" name="file" id="file[<%=i%>]" value=<%=i%>></td>
					<td class="fortable txtblue"><a href="<%=url%>PR/<%=obj.getFileName()%>" target="_blank"><%=obj.getFileName()%></a></td>
					<td class="fortable txtblue"><%=obj.getFileDsc()%></td>
				</tr>
					<input type="hidden" name="filename" id="filename[<%=i%>]" value=<%=obj.getFileName()%>>
					<input type="hidden" name="filedsc" id="filedsc[<%=i%>]" value=<%=obj.getFileDsc()%>>
			<%
				}//for
			}//if(zcfileobjAL != null || zcfileobjAL.size()>0)
			 %>
				
			</table>
			<center>
				<input type="button" name="save_file_btn" id="save_file_btn" value="套用檔案" onclick="bnt_click('save_file_btn')"></a>
			</center>
		</td>
	</tr>

</table>
<!-- PR report file -->
</form>
</body>
</html>
<%
}	
%>