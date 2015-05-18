<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="eg.zcrpt.*,java.sql.*,java.util.ArrayList"%>
<%
//CM處理事務長<--助理座艙長報告
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
String yy = (String) request.getParameter("yy");
String mm = (String) request.getParameter("mm");
String fdate = request.getParameter("fdate");
String fltno = request.getParameter("fltno");
String sect = request.getParameter("port");
String purempn = request.getParameter("purempn");
String src = request.getParameter("src");
String cpname ="";
String cpno ="";
String acno ="";
String psrempn ="";
String psrsern = "";
String psrname = "";
String pgroups = "";
String zcempn = "";
String zcsern = "";
String zcname = "";
String zcgrps ="";

//out.println("fdate"+fdate+",fltno"+fltno+",sect"+sect+","+src+",purempn"+purempn);

if( (src != null && "APP".equals(src)) || ( sGetUsr != null && !"".equals(sGetUsr))  ) 
{
	String liveUrl="http://cabincrew.china-airlines.com/prpt/";
	String testUrl="http://cabincrew.china-airlines.com/prptt/";
	String url =testUrl; 
	
	ZCReportCheck zcrt = new ZCReportCheck();
    zcrt.getUnHandleZCReportForCM(purempn,fdate,fltno,sect);
	ArrayList unhandleobjAL = zcrt.getObjAL();
	
	if(unhandleobjAL.size()>0)
	{
		 ZCReportCheckObj firstobj = (ZCReportCheckObj) unhandleobjAL.get(0);
         cpname = firstobj.getCpname();
		 cpno = firstobj.getCpno();
		 acno = firstobj.getAcno();
		 psrempn = firstobj.getPsrempn();
		 psrsern = firstobj.getPsrsern();
		 psrname = firstobj.getPsrname();
		 pgroups = firstobj.getPgroups();
		 zcempn = firstobj.getZcempn();
		 zcsern = firstobj.getZcsern();
		 zcname = firstobj.getZcname();     
		 zcgrps = firstobj.getZcgrps();
		 acno = firstobj.getAcno();
	
		session.setAttribute("unhandleobjAL",unhandleobjAL);
		//file
		ReportCopy file = new ReportCopy();
		file.getCMReportFile(fdate, fltno, sect);
		ArrayList cmfileobjAL = file.getFileObjAL();
		file.getZCReportFile(fdate, fltno, sect);
		ArrayList zcfileobjAL = file.getFileObjAL();
		//file
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
	if(para == "close_btn")
	{
		document.form1.target= "_self" ;
		document.form1.action= "updZCRptHandling.jsp" ;
		str = "CLOSE";
		document.getElementById("act_type").value = "close";	
	}

	if(para == "save_btn")
	{
		document.form1.target= "_self" ;
		document.form1.action= "updZCRptHandling.jsp" ;
		str = "SAVE";
		document.getElementById("act_type").value = "save";	
	}
	
	if(para == "save_file_btn")
	{
		document.form1.target= "_self" ;
		document.form1.action= "updCopyZcFile.jsp" ;
		str = "save_file_btn";
		//document.getElementById("save_file_btn").value = "save file";	
	}
	
	if( confirm("Are you sure to "+str+" the case?"))
	{
		document.form1.save_btn.disabled=1;
		document.form1.close_btn.disabled=1;
		document.form1.submit();
	}
	else
	{
		return false;
	}
}

function compose_note(colname)
{
	var c_value = "";
	for (var i=0; i < eval("document.form1.str_"+colname+".length"); i++)
	{
		if (eval("document.form1.str_"+colname+"[i].checked"))
		{
			c_value = c_value+" "+ eval("document.form1.str_"+colname+"[i].value") ;
		}
	}
	document.getElementById("comm"+colname).value = c_value ;
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
	      <td><strong>CM :</strong>&nbsp;&nbsp;<%=psrempn%>&nbsp;&nbsp; <%=psrsern%>&nbsp;&nbsp;<%=psrname%>&nbsp;&nbsp;Group : <%=pgroups%></td>
		  <td><strong>PR  :</strong>&nbsp;&nbsp; <%=zcempn%>&nbsp;&nbsp;<%=zcsern%>&nbsp;&nbsp;<%=zcname%>&nbsp;&nbsp;<strong>Group</strong> : <%=zcgrps%></td>
		  <td><strong>CA  :</strong>&nbsp;&nbsp;<%=cpname%>&nbsp;&nbsp;A/C &nbsp;<%=acno%></td>
	    </tr>
	    <tr>
	      <td><strong>Date : </strong><%=fdate%></td>
		  <td><strong>Fltno : </strong><%=fltno%></td>
		  <td><strong>Sect : </strong> <%=sect%></td>
	    </tr>
	</table>
<form name="form1" method="post" target="_self">
  <input type="hidden" name="act_type" id="act_type" value="">
  <input type="hidden" name="src" id="src" value="<%=src%>">
  <input type="hidden" name="yy" id="yy" value="<%=yy%>">
  <input type="hidden" name="mm" id="mm" value="<%=mm%>">

   <table width="100%" border="1" align="center" cellpadding="0" cellspacing="0">
    <tr valign="top">
      <td height="150" colspan="4" valign="top"><strong>Flight Irregularity : </strong>
        <table width="100%"  border="1" cellpadding="0" cellspacing="0">
		<%
		if(unhandleobjAL.size()>0)
		{
			for(int i=0; i<unhandleobjAL.size(); i++)
			{
				ZCReportCheckObj fltirrobj = (ZCReportCheckObj) unhandleobjAL.get(i);
		%>
          <tr class="tablehead">
			<td width = "80"  valign="top"><span class="style21"> <%=fltirrobj.getItemdsc_m()%></span></td>
            <td valign="top"><span class="style21">&nbsp;<%=fltirrobj.getItemdsc_s()%></span></td>
            <td valign="top"><span class="style21">&nbsp;<%=fltirrobj.getItemdsc()%></span></td>
            <td width="375"  valign="top" align="left"><span class="style21">&nbsp;<%=fltirrobj.getZccomm()%></span></td>
		  </tr>
		  <tr>
		    <td width = "80" class="style10" bgcolor="#CCCCCC" align="center" valign="middle">回覆</td>
			<td colspan = "3" class="style21"  valign="top"><textarea NAME="comm<%=fltirrobj.getSeqkey()%>" id="comm<%=fltirrobj.getSeqkey()%>" ROWS="4" COLS="70" wrap="virtual"><%=fltirrobj.getCmcomm()%></textarea><br>
			<input type="checkbox" name="str_<%=fltirrobj.getSeqkey()%>" value="已誌客艙經理報告" onclick="compose_note('<%=fltirrobj.getSeqkey()%>')">已誌客艙經理報告&nbsp;&nbsp;
	        <input type="checkbox" name="str_<%=fltirrobj.getSeqkey()%>" value="反映事項存查" onclick="compose_note('<%=fltirrobj.getSeqkey()%>')">反映事項存查<br></td>
		  </tr>
		<%
			}//for(int i=0; i<unhandleobjAL.size(); i++)

		}//if(zcrpthandleobjAL.size()>0)
%>
      </table>
      
	  <center>
		<input type="button" name="save_btn" id="save_btn" value="暫存" onclick="bnt_click('save_btn')">&nbsp;&nbsp;&nbsp;
		<input type="button" name="close_btn" id="close_btn" value="結案" onclick="bnt_click('close_btn')">&nbsp;&nbsp;&nbsp;
		<input type="button" name="Exit" id="Exit" value="Exit" onclick="javascript:window.close()">
		</center>
	  
	</td>
</tr>
<!-- 已存在CM report File (含套用之PR file)-->
<tr class="tablehead">
	<td  valign="top" colspan = "4" ><span class="style21">CM report File List:</span></td>
</tr>	
<tr class="tablehead">		
	<td valign="top" colspan = "2"><span class="style21">File Name</span></td>
	<td valign="top" colspan = "2"><span class="style21">File Desc</span></td>
</tr>
				<%
				if(cmfileobjAL != null || cmfileobjAL.size()>0){
					for(int i=0 ; i<cmfileobjAL.size() ; i ++){
						ReportCopyObj obj = (ReportCopyObj) cmfileobjAL.get(i);
				%>
				<tr>				
					<td class="fortable txtblue" colspan = "2"><a href="<%=url%><%=obj.getFileName()%>" target="_blank"><%=obj.getFileName()%></a></td>
					<td class="fortable txtblue" colspan = "2"><%=obj.getFileDsc()%></td>
				</tr>
			<%
				}//for
			}//if(zcfileobjAL != null || zcfileobjAL.size()>0)
			 %>
				


<!-- 已存在CM report File (含套用之PR file)-->
</table>
</form>

<form name="form2" method="post" target="_self">
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
					<td class="fortable txtblue"><input type="checkbox" name="file" id="file<%=i%>" value="<%=i%>"></td>
					 <input type="hidden" name="src" id="src" value="<%=src%>">
					<input type="hidden" name="filename" id="filename<%=i%>" value="<%=obj.getFileName()%>">
					<input type="hidden" name="filedsc" id="filedsc<%=i%>" value="<%=obj.getFileDsc()%>">
					<td class="fortable txtblue"><a href="<%=url%>PR/<%=obj.getFileName()%>" target="_blank"><%=obj.getFileName()%></a></td>
				<td class="fortable txtblue"><%=obj.getFileDsc()%></td>
				</tr>
			<%
				}//for
			}//if(zcfileobjAL != null || zcfileobjAL.size()>0)
			 %>
				
			</table>
			<center>
				<input type="button" name="save_file_btn" id="save_file_btn" value="套用圖檔" onclick="bnt_click('save_file_btn')"></a>
			</center>
		</td>
	</tr>

</table>
<!-- PR report file -->
</form>
</body>
</html>
<%
	}else{
		out.println("No Data.");
	}
}
else 
{		//check user session start first or not login
	response.sendRedirect("/webfz/FZ/sendredirect.jsp");
}
%>