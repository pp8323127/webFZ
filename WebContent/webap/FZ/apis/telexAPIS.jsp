<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="apis_new.*,java.text.*,java.sql.*,java.util.*,ci.db.*,java.io.*,ftp.*"%>
<html>
<head>
<title>Send APIS</title>
<meta http-equiv="Content-Type" content="text/html; charset=">
<link rel="stylesheet" href="menu.css" type="text/css">
</head>
<%

response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String userid = (String) session.getAttribute("userid") ; //get user id if already login
if ( userid == null) 
{	//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} 
else
{
	String path = "/apsource/csap/projfz/txtin/apis/";
	String idx = (String) request.getParameter("idx") ; 
	String ftime = (String) request.getParameter("ftime") ; 
	ArrayList apisfltAL = (ArrayList) session.getAttribute("apisfltAL");
	ArrayList apisdetailAL = (ArrayList) session.getAttribute("apisdetailAL");
	APISObj obj = (APISObj) apisfltAL.get(Integer.parseInt(idx));

	Hashtable myHT = (Hashtable) session.getAttribute("myHT");
	Hashtable myHT2 = (Hashtable) session.getAttribute("myHT2");
	Hashtable myHT3 = (Hashtable) session.getAttribute("myHT3");
	String crewcntStr = (String) session.getAttribute("crewcntSB");
//out.println("crewcntStr = "+crewcntStr+"<br>");
//out.println("myHT= "+myHT.size()+"<br>");
//out.println("myHT2= "+myHT2.size()+"<br>");
//out.println("obj= "+obj.getStdtpe().replaceAll("/|:| ","")+"_"+obj.getFltno()+"_"+obj.getDpt()+"_"+obj.getArv()+"_DPT"+".TXT"+"<br>");
//out.println("apisdetailAL=" + apisdetailAL.size()+"<br>");

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
			//*************************************
			//Telex path
			String filename = obj.getStdtpe().replaceAll("/|:| ","")+"_"+obj.getFltno()+"_"+obj.getDpt()+"_"+obj.getArv()+"_DPT"+idx2+".TXT";
			FileWriter fw =  new FileWriter(path+filename,false);		    			    	    
			fw.write(value);
			fw.flush();
			fw.close();		
			
			ftp.putFile pf = new ftp.putFile();
			pf.doFtp(path+filename,filename);//doFtp(String locfilepath, String ftpfilename)
			//*************************************
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
			//*************************************
			//Telex path
			String filename = obj.getStdtpe().replaceAll("/|:| ","")+"_"+obj.getFltno()+"_"+obj.getDpt()+"_"+obj.getArv()+"_ARV"+idx2+".TXT";
			FileWriter fw =  new FileWriter(path+filename,false);		  
			fw.write(value);
			fw.flush();
			fw.close();
			//System.out.println("path+filename = "+path+filename);
			//System.out.println("filename = "+filename);

			ftp.putFile pf = new ftp.putFile();
			pf.doFtp(path+filename,filename);//doFtp(String locfilepath, String ftpfilename)
			//*************************************
		} 	
	}

	if(myHT3.size()>0)
	{
		Set keyset = myHT3.keySet();
		Iterator itr = keyset.iterator();
		int idx2 = 0;
		while(itr.hasNext())
		{
			idx2++;
			String key = String.valueOf(itr.next());
			String value = (String)myHT3.get(key);
			//*************************************
			//Telex path
			String filename = obj.getStdtpe().replaceAll("/|:| ","")+"_"+obj.getFltno()+"_"+obj.getDpt()+"_"+obj.getArv()+"_OVERRUS"+idx2+".TXT";
			FileWriter fw =  new FileWriter(path+filename,false);		  
			fw.write(value);
			fw.flush();
			fw.close();
			//System.out.println("path+filename = "+path+filename);
			//System.out.println("filename = "+filename);

			ftp.putFile pf = new ftp.putFile();
			pf.doFtp(path+filename,filename);//doFtp(String locfilepath, String ftpfilename)
			//*************************************
		} 	
	}

	if(myHT.size()>0 | myHT2.size()>0 | myHT3.size()>0)
	{               
		//Telex Crew Count Log
		//*************************************
		//Telex path
		String filename = obj.getStdtpe().replaceAll("/|:| ","")+"_"+obj.getFltno()+"_"+obj.getDpt()+"_"+obj.getArv()+"_CREW_CNT.TXT";
		FileWriter fw =  new FileWriter(path+filename,false);		  
		fw.write(crewcntStr);
		fw.flush();
		fw.close();

		ftp.putFile pf = new ftp.putFile();
		pf.doFtp(path+filename,filename);//doFtp(String locfilepath, String ftpfilename)
		//*************************************

		//write fztselg
		String sendtmst = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(new java.util.Date());
		for(int d=0; d<apisdetailAL.size(); d++)
		{	    
			APISObj detailobj = (APISObj) apisdetailAL.get(d);
			detailobj.setTmst(sendtmst);
			APISSkjJob c = new APISSkjJob();
			c.writeSentLog(detailobj,userid,"MANU");
		}
	}

	if(myHT.size()>0 | myHT2.size()>0 | myHT3.size()>0)
	{
%>
		<html>
		<body>
		<div align="center">
		  <br><h3><font color="blue">電報已發送完成!</font>
		  <p>
		  <p>
		  <a href="http://cksweb03/tpett/" target="_blank">
			<font size="4" size="10px"><span class="txtblue">請至『地勤服務資訊網』確認電報是否已正確送出!!</span></font></a>
		</div>
		</body>
		</html>
<%
	}
	else
	{
%>
		<html>
		<body>
		<div align="center">
		  <br><h3><font color="blue">電報發送失敗,請重新發送!</font>
		</div>
		</body>
		</html>
<%
	}
}
%>