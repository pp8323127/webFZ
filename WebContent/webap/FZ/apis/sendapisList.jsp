<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,apis_new.*,java.util.*,java.text.*" %>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);

String fullUCD = (String) session.getAttribute("fullUCD");//登入CII時，取得之登入者單位代碼
String userid = (String) session.getAttribute("userid") ; //get user id if already login
String idx = (String) request.getParameter("idx") ; 
String ftime = (String) request.getParameter("ftime") ; 
ArrayList apisfltAL = (ArrayList) session.getAttribute("apisfltAL");
APISObj obj = (APISObj) apisfltAL.get(Integer.parseInt(idx));
String error = "";
String fltdate = obj.getStdtpe();
String tempbgcolor = "";


swap3ac.PublishCheck pc = new swap3ac.PublishCheck(fltdate.substring(0,4), fltdate.substring(5,7));

//非航務、空服簽派者，才檢查班表是否公佈
if( (!"190A".equals(fullUCD) && !"068D".equals(fullUCD)) && !pc.isPublished()) 
{
%>
<div style="background-color:#99FFFF;text-align:center;color:#FF0000;font-family:Verdana;font-size:10pt; ">
		<%=fltdate.substring(0,7)%>班表尚未正式公佈!!
</div>
<%
}
else
{

ArrayList apisdetailAL = new ArrayList();
Hashtable myHT  = new Hashtable();
Hashtable myHT2  = new Hashtable();
Hashtable myHT3  = new Hashtable();
boolean iscargo = false;

APISSkjJob c = new APISSkjJob();
if(ftime != null)
{//re-match da13 flt info
	obj.setDa13AL(c.getAPISFltDetail_DA13(obj.getFltno(), ftime));		
}

//out.println("Da13AL "+obj.getDa13AL().size()+"<br>");
if(obj.getDa13AL().size()>0)
{
	 DA13Obj da13obj = (DA13Obj) obj.getDa13AL().get(0) ;
	 //out.println("actp "+da13obj.getDa13_actp()+"<br>");
	 if("74X".equals(da13obj.getDa13_actp()) | "74Y".equals(da13obj.getDa13_actp()))
	 {
		 iscargo = true;
	 }
}

c.getAPISFltDetail_Aircrews(obj.getStdtpe(),obj.getFltno(),obj.getDpt(),obj.getArv());
//out.println(c.getSql()+"<br>");

c.getAPISFltDetail_DB2(obj.getFdate(),obj.getFltno(),obj.getDpt(),obj.getArv(),obj.getStr_port_local(),obj.getEnd_port_local(),obj.getStdtpe(),obj.getFly_status());
//out.println(c.getSql()+"<br>");

//out.println(c.getSql()+"<br>");
//out.println("**********************************"+"<br>");
//out.println(c.getStr()+"<br>");

apisdetailAL = c.getObjAL();
session.setAttribute("apisdetailAL",apisdetailAL);

//get Country
PortCity pcy = new PortCity();
pcy.getPortCityData();		
//out.println(apisdetailAL.size()+"<br>");

if(apisdetailAL.size()>0)
{
	//get apis un/edifact txt, send apis
	//myHT = c.getDptAPISTxtHT(obj,apisdetailAL);
	//myHT2 = c.getArvAPISTxtHT(obj,apisdetailAL); 

	StringBuffer errorSB = new StringBuffer();
	boolean ifcorrect = true;
	//get apis un/edifact txt, send apis
	PortCityObj portobj1 = pcy.getPortCityObj(obj.getDpt());
	PortCityObj portobj2 = pcy.getPortCityObj(obj.getArv());  

	boolean ifneedapis = false;
	if("USA,CHINA,CANADA,KOREA,INDIA,NEW ZEALAND,TAIWAN,UK".indexOf(portobj1.getCtry())>=0)
	{
		ifneedapis = true ;
	}
	
	if("USA,CHINA,JAPAN,CANADA,KOREA,INDIA,NEW ZEALAND,TAIWAN,UK,NETHERLANDS,VIETNAM".indexOf(portobj2.getCtry())>=0)
	{
		ifneedapis = true ;
	}	
	
	boolean ifneedRUSApis = false;
	String sect = obj.getDpt() + obj.getArv(); 
	String msg = c.CheckOverFly(sect, "RUS");
	if( !"".equals(sect) && null != sect && "Y".equals(msg)){
		ifneedRUSApis = true;
	}
	//out.println(sect + ifneedRUSApis);
//			庫頁島:
//          CI003   SFOTPE
//          CI005   LAXTPE CI007            
//          CI011   ANC/JFK-TPE
//          CI031   YVRTPE
//
//          西伯利亞:
//          CI061   TPEFRA CI6622  FRATPE
//          CI062   FRATPE CI5622 FRATPE
//          CI063   TPEVIE
//          CI064   VIETPE

//out.println(portobj2.getCtry());
	if(ifneedapis==true)
	{
		if("".equals(portobj1.getCtry()) | portobj1.getCtry() == null)
		{
			ifcorrect = false;
			errorSB.append(" "+obj.getDpt()+" DOES NOT IN FZTCITY");
		}
		
		if("".equals(portobj2.getCtry()) | portobj2.getCtry() == null)
		{
			ifcorrect = false;
			errorSB.append(" "+obj.getArv()+" DOES NOT IN FZTCITY");
		}
		
		 if("UK".equals(portobj1.getCtry()))
		 {
			 myHT = c.getUKDptAPISTxtHT(obj,apisdetailAL);
			 if(!"Y".equals(c.getErrorStr()))
			 {
				 ifcorrect = false;
				 errorSB.append(" INSUFFICIENT CREW INFO");
			 }
		 }
		 else if("NEW ZEALAND".equals(portobj1.getCtry()))
		 {
			 myHT = c.getNZDptAPISTxtHT(obj,apisdetailAL);
			 if(!"Y".equals(c.getErrorStr()))
			 {
				 ifcorrect = false;
				 errorSB.append(" INSUFFICIENT CREW INFO");
			 }
		 }
		 else if("NETHERLANDS".equals(portobj1.getCtry()))
		 {
			 myHT = c.getNLDptAPISTxtHT(obj,apisdetailAL);
			 if(!"Y".equals(c.getErrorStr()))
			 {
				 ifcorrect = false;
				 errorSB.append(" INSUFFICIENT CREW INFO");
			 }
		 }
		 else if("CHINA".equals(portobj1.getCtry()))
		 {
			 myHT = c.getCNDptAPISTxtHT(obj,apisdetailAL);
			 if(!"Y".equals(c.getErrorStr()))
			 {
				 ifcorrect = false;
				 errorSB.append(" INSUFFICIENT CREW INFO");
			 }
		 }
		 else if("TAIWAN".equals(portobj1.getCtry()))
		 {
			 myHT = c.getTWDptAPISTxtHT(obj,apisdetailAL);
			 if(!"Y".equals(c.getErrorStr()))
			 {
				 ifcorrect = false;
				 errorSB.append(" INSUFFICIENT CREW INFO");
			 }
		 }	 
		 else if("JAPAN".equals(portobj1.getCtry()))
		 {
			 myHT = c.getJANDptAPISTxtHT(obj,apisdetailAL);
			 if(!"Y".equals(c.getErrorStr()))
			 {
				 ifcorrect = false;
				 errorSB.append(" INSUFFICIENT CREW INFO");
			 }
		 }
		 else
		 {
			 myHT = c.getDptAPISTxtHT(obj,apisdetailAL);
			 if(!"Y".equals(c.getErrorStr()))
			 {
				 ifcorrect = false;
				 errorSB.append(" INSUFFICIENT CREW INFO");
			 }
		 }
		 
		 if("UK".equals(portobj2.getCtry()))
		 {
			 myHT2 = c.getUKArvAPISTxtHT(obj,apisdetailAL); 
			 if(!"Y".equals(c.getErrorStr()))
			 {
				 ifcorrect = false;
				 errorSB.append(" INSUFFICIENT CREW INFO");
			 }
		 }
		 else if("NEW ZEALAND".equals(portobj2.getCtry()))
		 {
			 myHT2 = c.getNZArvAPISTxtHT(obj,apisdetailAL); 
			 if(!"Y".equals(c.getErrorStr()))
			 {
				 ifcorrect = false;
				 errorSB.append(" INSUFFICIENT CREW INFO");
			 }
		 }
		 else if("NETHERLANDS".equals(portobj2.getCtry()))
		 {
			 myHT2 = c.getNLArvAPISTxtHT(obj,apisdetailAL); 
			 if(!"Y".equals(c.getErrorStr()))
			 {
				 ifcorrect = false;
				 errorSB.append(" INSUFFICIENT CREW INFO");
			 }
		 }
		
		 else if("CHINA".equals(portobj2.getCtry()))
		 {
			 myHT2 = c.getCNArvAPISTxtHT(obj,apisdetailAL); 
			 if(!"Y".equals(c.getErrorStr()))
			 {
				 ifcorrect = false;
				 errorSB.append(" INSUFFICIENT CREW INFO");
			 }
		 }
		 else if("TAIWAN".equals(portobj2.getCtry()))
		 {
			 myHT2 = c.getTWArvAPISTxtHT(obj,apisdetailAL); 
			 if(!"Y".equals(c.getErrorStr()))
			 {
				 ifcorrect = false;
				 errorSB.append(" INSUFFICIENT CREW INFO");
			 }
		 } 
		 else if("VIETNAM".equals(portobj2.getCtry()))//20140402 cs80add
		 {
			 myHT2 = c.getVNIArvAPISTxtHT(obj,apisdetailAL); 
			 if(!"Y".equals(c.getErrorStr()))
			 {
				 ifcorrect = false;
				 errorSB.append(" INSUFFICIENT CREW INFO");
			 }
		 }
		 else if("JAPAN".equals(portobj2.getCtry()))//20140808 cs80add
		 {
			 myHT2 = c.getJANArvAPISTxtHT(obj, apisdetailAL); 
			 if(!"Y".equals(c.getErrorStr()))
			 {
				 ifcorrect = false;
				 errorSB.append(" INSUFFICIENT CREW INFO");
			 }
		 }
		 else
		 {
			 myHT2 = c.getArvAPISTxtHT(obj,apisdetailAL); 
			 if(!"Y".equals(c.getErrorStr()))
			 {
				 ifcorrect = false;
				 errorSB.append(" INSUFFICIENT CREW INFO");
			 }
		 }
	}//if(ifneedapis==true)
	//out.println(c.getSql()+"<br>");
	//out.println("**********************************"+"<br>");
	//out.println(c.getStr()+"<br>");
	//out.println("myHT.size() "+myHT.size()+"<br>");
	if(ifneedRUSApis){
		myHT3 = c.getRUSoverAPISTxtHT(obj, apisdetailAL);
		if(!"Y".equals(c.getErrorStr()))
		 {
			 ifcorrect = false;
			 errorSB.append(" INSUFFICIENT CREW INFO");
		 }
	}
	//out.println("myHT3.size() "+myHT3.size()+"<br>");
	if(ifneedapis==false)
	{
%>
		<div align = "center" class="txtxred"><strong>無需發送APIS</strong></div><p><p>
<%
	}
	else if(ifcorrect == true)
	{
		session.setAttribute("myHT",myHT);
		session.setAttribute("myHT2",myHT2);
		session.setAttribute("myHT3",myHT3);
		if(myHT.size()>0)
		{
			Set keyset = myHT.keySet();
			Iterator itr = keyset.iterator();
			int idx2 = 0;
			while(itr.hasNext())
			{
				idx2++;
				String key = String.valueOf(itr.next());
				String value = (String)myHT.get(key);	
				String filename = obj.getStdtpe().replaceAll("/|:| ","")+"_"+obj.getFltno()+"_"+obj.getDpt()+"_"+obj.getArv()+"_DPT"+idx2+".txt";
	%>
				  <div align="center" class="txtblue">
				  <br>
				   <a href="apistxt_download.jsp?filename=<%=filename%>&ht=myHT&key=<%=key%>">
				  <font size="4" size="10px"><img src="../images/ed4.gif" border="0"><span class="txtblue"> <%=filename%></span></font></a>
				  </div>
	<%
			} 	
		}

		if(myHT2.size()>0)

		{
			Set keyset = myHT2.keySet();
			Iterator itr = keyset.iterator();
			int idx2 = 0;
			while(itr.hasNext())
			{
				idx2++;
				String key = String.valueOf(itr.next());
				String value = (String)myHT2.get(key);
				//out.print(value);
				String filename = obj.getStdtpe().replaceAll("/|:| ","")+"_"+obj.getFltno()+"_"+obj.getDpt()+"_"+obj.getArv()+"_ARV"+idx2+".txt";
	%>
				  <div align="center">
				  <br>
				   <a href="apistxt_download.jsp?filename=<%=filename%>&ht=myHT2&key=<%=key%>">
				  <font size="4" size="10px"><img src="../images/ed4.gif" border="0"><span class="txtblue"> <%=filename%></span></font></a>
				  </div>
	<%
			} 	
		}
		
		if(myHT3.size()>0)//飛越領空

		{
			Set keyset = myHT3.keySet();
			Iterator itr = keyset.iterator();
			int idx2 = 0;
			while(itr.hasNext())
			{
				idx2++;
				String key = String.valueOf(itr.next());
				String value = (String)myHT3.get(key);
				//out.print(value);
				String filename = obj.getStdtpe().replaceAll("/|:| ","")+"_"+obj.getFltno()+"_"+obj.getDpt()+"_"+obj.getArv()+"_OVERRUS"+idx2+".txt";
	%>
				  <div align="center">
				  <br>
				   <a href="apistxt_download.jsp?filename=<%=filename%>&ht=myHT3&key=<%=key%>">
				  <font size="4" size="10px"><img src="../images/ed4.gif" border="0"><span class="txtblue"> <%=filename%></span></font></a>
				  </div>
	<%
			} 	
		}
	}
	else
	{
%>
		<div align = "center" class="txtxred"><strong>Error :  <%=errorSB.toString()%></strong></div><p><p>
<%
	}

/*
	if(myHT.size()>0 | myHT2.size()>0)
	{               
		//write fztselg
		String sendtmst = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(new java.util.Date());
		for(int d=0; d<apisdetailAL.size(); d++)
		{	    
			APISObj detailobj = (APISObj) apisdetailAL.get(d);
			detailobj.setTmst(sendtmst);
			c.writeSentLog(detailobj,userid,"MANU");
		}
	}
*/

//dispaly crew List
%>
<html>
<head>
<title>Send APIS</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="style.css" rel="stylesheet" type="text/css">
<script language=javascript>
function telex()
{
	document.form1.Submit.disabled=1;
	flag = confirm("Are you sure to send the APIS?");
	if (flag) 
	{
		return true;
	}
	else
	{
		document.form1.Submit.disabled=0;
		return false;
	}
}
</script>
</head>
<body>
<%
if(ifcorrect == true && ifneedapis==true)
{
%>
<div align = "center">
  <form name="form1" method="post" action="telexAPIS.jsp?idx=<%=idx%>&ftime=<%=ftime%>" onSubmit="return telex()">  
  <input name="Submit" type="submit" value=" 確認無誤,發送電報">
  </form>
</div>
<%
}	
%>
<hr>
<p>
<p>
<p>
<table width="70%" border="1" cellspacing="0" cellpadding="0" align="center">
 <tr class="tablehead" height="20">
  <td align="center">#</td>
  <td align="center">Empno</td>
  <td align="center">Cname/Ename</td>
  <td align="center">Occu</td>
  <td align="center">Passcountry</td>
 </tr>
<%
int cr1 =0;
int cr2 =0;
int cr3 =0;
int cr4 =0;
int cr5 =0;

for(int i=0; i<apisdetailAL.size(); i++)
{
	if(i%2==0)
	{
		tempbgcolor = "#FFFFFF";
	}
	else
	{
		tempbgcolor = "#CCCCCC";
	}

	APISObj apisdetailobj = (APISObj) apisdetailAL.get(i);
	if("CR1".equals(apisdetailobj.getTvlstatus()))
	{
		cr1 ++;
	}
	if("CR2".equals(apisdetailobj.getTvlstatus()))
	{
		cr2 ++;
	}
	if("CR3".equals(apisdetailobj.getTvlstatus()))
	{
		cr3 ++;
	}
	if("CR4".equals(apisdetailobj.getTvlstatus()))
	{
		cr4 ++;
	}
	if("CR5".equals(apisdetailobj.getTvlstatus()))
	{
		cr5 ++;
	}

	eg.HRInfo hr = new eg.HRInfo(apisdetailobj.getEmpno());    
%>
 <tr class="txtblue" bgcolor="<%=tempbgcolor%>">
  <td align="center"><%=(i+1)%></td>
  <td align="center">&nbsp;<%=apisdetailobj.getEmpno()%></td>
  <td align="left">&nbsp;&nbsp;&nbsp;<%=hr.getCname(apisdetailobj.getEmpno())%>     <%=apisdetailobj.getLname()%>  <%=apisdetailobj.getFname()%></td>
  <td align="center">&nbsp;<%=apisdetailobj.getOccu()%></td>
  <td align="center">&nbsp;<%=apisdetailobj.getPasscountry()%></td>
 </tr>
<%
}
%>
</table>
<table width="70%" border="1" cellspacing="0" cellpadding="0" align="center">
<tr class="tablehead" height="20">
  <td align="center">Total : <%=apisdetailAL.size()%></td>
  <td align="center">CR1 : <%=cr1%></td>
  <td align="center">CR2 : <%=cr2%></td>
  <td align="center">CR3 : <%=cr3%></td>
  <td align="center">CR4 : <%=cr4%></td>
  <td align="center">CR5 : <%=cr5%></td>
 </tr>
</table>
<%
//*************************************
//Telex Crew Count
StringBuffer crewcntSB = new StringBuffer();
//crewcntSB.append("QD TPEOSCI TPEEDCI TPEWGCI TPETTCI"+"\r\n");

crewcntSB.append("QD TPEOSCI TPEEDCI TPEWGCI ");
if(iscargo == true)
{
	crewcntSB.append(obj.getDpt()+"FFCI "+obj.getArv()+"FFCI"+"\r\n");
	crewcntSB.append("."+obj.getDpt()+"FFCI"+"\r\n");
}
else
{
	crewcntSB.append(obj.getDpt()+"TTCI "+obj.getArv()+"TTCI "+"\r\n");
	crewcntSB.append("."+obj.getDpt()+"TTCI"+"\r\n");
}
//crewcntSB.append(".TPETTCI"+"\r\n");
//crewcntSB.append("."+obj.getDpt()+"TTCI"+"\r\n");
crewcntSB.append("****MANUALLY BY "+userid+" ****\r\n");
crewcntSB.append(obj.getCarrier()+obj.getFltno()+" "+obj.getStdtpe()+" "+obj.getDpt()+obj.getArv()+" APIS HAS SENT"+"\r\n");
crewcntSB.append("CREW   "+apisdetailAL.size()+"\r\n");
crewcntSB.append("CR1    "+cr1+"\r\n");
crewcntSB.append("CR2    "+cr2+"\r\n");
crewcntSB.append("CR3    "+cr3+"\r\n");
crewcntSB.append("CR4    "+cr4+"\r\n");
crewcntSB.append("CR5    "+cr5+"\r\n");	
crewcntSB.append("\r\n"+"IF NEED RESEND X PLZ CONTACT TPEOSCI OR TPEEDCI"+"\r\n");
//*************************************
//out.println(crewcntSB.toString());
session.setAttribute("crewcntSB",crewcntSB.toString());
}//if(apisdetailAL.size()>0)
}
%>
</body>
</html>