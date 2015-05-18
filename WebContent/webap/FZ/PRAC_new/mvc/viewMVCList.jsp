<%@ page contentType="text/html; charset=big5" language="java" import="java.util.*,eg.mvc.*,java.text.*"%>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} 
else
{
String fdate = request.getParameter("fdate");
String fltno = request.getParameter("fltno");
String sector = request.getParameter("port");
String purempn = request.getParameter("purempn");

//fdate = "2012/04/06";
//fltno = "0004";
//sector = "TPESFO";
//purempn = request.getParameter("purempn");

boolean status = false;
String errMsg = "";
String flt_str = "";
GregorianCalendar cal1 = new GregorianCalendar();
cal1.set(Calendar.YEAR,Integer.parseInt(fdate.substring(0,4)));
cal1.set(Calendar.MONTH,Integer.parseInt(fdate.substring(5,7))-1);
cal1.set(Calendar.DATE,Integer.parseInt(fdate.substring(8,10)));
SimpleDateFormat dFormat = new SimpleDateFormat("ddMMM", Locale.US);
flt_str = "*CI"+fltno+"/"+dFormat.format(cal1.getTime()).toUpperCase()+"/"+sector.substring(0,3);
//out.println(" fresh   "+flt_str);

MVCRecord mvc = new MVCRecord();
String cardnum = mvc.getCardnum(sGetUsr,flt_str);	  

if(!"".equals(cardnum))
{
	mvc.getMVCData(cardnum);
}
ArrayList objAL = new ArrayList();
objAL = mvc.getObjAL();
//out.println(objAL.size());

%>
<html>
<head>
<title>MVC Record By Flt Query</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<style type="text/css">
<!--
.txtblue {font-size: 12px;line-height: 13.5pt;color: #464883;font-family:  "Verdana";}
.tablehead {	font-family: "Arial", "Helvetica", "sans-serif";background-color: #006699;font-size: 12px;text-align: center;font-style: normal;font-weight: bold;color: #FFFFFF;}
.fontbige_dblue{color:#339999;font-size:14pt;font-family: Arial, Helvetica, sans-serif}
.btn2
{
	background-color:#C3C3C3;	
	font-family:Verdana;
	font-size:10pt;
}
-->
</style>
<script language="javascript" type="text/javascript">
function SaveFile(fname)
{	
	document.execCommand('saveas', null ,fname);
}
</script>
</head>

<body bgcolor="#FFFFFF" text="#000000">
<div align="center">
  <table width="90%" border="0" cellspacing="0" cellpadding="2">
    <tr>
	<td align="center"><p><font face="Comic Sans MS" color="#000099"><%=fdate%> <%=fltno%> <%=sector%>  MVC Record</font></p></td>
	<td align="right" width="150px"><div name="divprint" id="divprint" style="display:''">
		<a href="javascript:window.print();"><img src="http://tpeweb02.china-airlines.com/webeg/images/print.gif" width="17" height="20" border="0" alt="列印"></a>
		<!--<a href="javascript:SaveFile('mvc.html');"><img src="http://tpeweb02.china-airlines.com/webeg/images/filesave.gif" width="17" height="20" border="0" alt="Download File"></a>-->
		<input type="button" name="rep" id="rep" value="download File" onClick="downreport();">
		</div>
	</td>
    </tr>
  </table>
  <br>
  <table width="90%" border="1" cellspacing="0" cellpadding="2">
  <tr> 
	  <td class="tablehead" width="15%"><font face="Arial, Helvetica, sans-serif" size="2"><b>卡號</b></font></td>
	 <td class="tablehead" colspan="2" width="40%"><font face="Arial, Helvetica, sans-serif" size="2"><b>姓名</b></font></td>
	  <td class="tablehead" width="15%"><font face="Arial, Helvetica, sans-serif" size="2"><b>生日</b></font></td>
	  <td class="tablehead" width="5%"><font face="Arial, Helvetica, sans-serif" size="2"><b>姓別</b></font></td> 
	  <td class="tablehead" width="25%"><font face="Arial, Helvetica, sans-serif" size="2"><b>頭銜</b></font></td>
  </tr>    
<%
String meal_str = "";
String beverage_str = "";
String magazine_str = "";
String newspaper_str = "";
String tempbgcolor = "";
Hashtable objHT = new Hashtable();
int count =0;
for(int i=1; i<objAL.size()-1; i++)
{
	MVCObj aobj = (MVCObj) objAL.get(i-1);
	MVCObj obj = (MVCObj) objAL.get(i);
	MVCObj bobj = (MVCObj) objAL.get(i+1);

	if(!aobj.getCardnum().equals(obj.getCardnum()))
	{
		if(count%2==1)
		{
			tempbgcolor = "#33FF99";
		}
		else
		{
			tempbgcolor = "#33CCFF";
		}
		count++;
		objHT.clear();
%>
	 <tr class="btn2"> 
      <td class="txtblue" align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=obj.getCardnum()%><br><%=obj.getCard_type()%></font></td>
	  <td class="txtblue" align="center" colspan="2"><font face="Arial, Helvetica, sans-serif" size="2"><%=obj.getCname()%>&nbsp;&nbsp<%=obj.getEname()%>&nbsp;&nbsp;<%=obj.getEname2()%></font></td>
      <td class="txtblue" align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=obj.getBrthdt()%></font></td>
      <td class="txtblue" align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=obj.getGender()%></font></td>
      <td class="txtblue" align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=obj.getCompany_cname()%>&nbsp;&nbsp<%=obj.getTitle_desc()%><br> <%=obj.getCompany_ename()%>&nbsp;&nbsp<%=obj.getTitle()%></font></td>
     </tr>   
	<tr bgcolor="#F0B5E6"> 
      <td align="center" class="txtblue"><font face="Arial, Helvetica, sans-serif" size="2">Note</font></td>
	  <td colspan="5" align="left" class="txtblue"><font face="Arial, Helvetica, sans-serif" size="2"><%=obj.getNote()%></font></td>
    </tr>    
<%
	}
	
	if(obj.getCode_desc()!=null && !"".equals(obj.getCode_desc()))
	{
		//if(objHT.size()<=0)
		if(objHT.get(obj.getType_desc())==null)
		{
			objHT.put(obj.getType_desc(),obj.getCode_desc().trim());  
		}
		else
		{
			objHT.put(obj.getType_desc(),objHT.get(obj.getType_desc())+" / "+obj.getCode_desc().trim()); 
		}
	}

	if(!obj.getCardnum().equals(bobj.getCardnum()))
	{
		Set keyset = objHT.keySet();
        Iterator it = keyset.iterator();
        while(it.hasNext())
    	{
    	    String key = String.valueOf(it.next());
    	    String value = (String) objHT.get(key);
%>
	<tr> 
      <td class="txtblue" align="center"><font face="Arial, Helvetica, sans-serif" size="2"><%=key%></font></td>
	  <td class="txtblue" align="left" colspan="5"><font face="Arial, Helvetica, sans-serif" size="2"><%=value%></font></td>
	 </tr>   
<%
		}
	}
}

if(count<=0)
{
%>
	<tr> 
      <td class="txtblue" align="center" colspan="6"><font face="Arial, Helvetica, sans-serif" size="2" >No Data Found!!</font></td>
	 </tr>   
<%
}
%>
  </table>
</div>
</body>
</html>

<script language="javascript" type="text/javascript">
function downreport()
{
	location.replace("report_download.jsp?fdate=<%=fdate%>&fltno=<%=fltno%>&sector=<%=sector%>");
}
</script>

<%
session.setAttribute("mvcobjAL",objAL);	
//out.println("sb.toString()  "+sb.toString());
}
%>

