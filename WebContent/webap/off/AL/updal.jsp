<link href="../FZ/menu.css" rel="stylesheet" type="text/css">
<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="eg.off.*,eg.*, java.net.URLEncoder,java.io.*,java.util.*,java.text.*"%>
<%
response.setHeader("Pragma","no-cache"); 
response.setHeader("Cache-Control","no-cache"); 
response.setDateHeader("Expires", 0); //prevents caching at the proxy server
String userid = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || userid == null || "null".equals(userid)) 
{		//check user session start first
	response.sendRedirect("../login.jsp");
} 
else
{
//	String offsdate = request.getParameter("validfrm");//yyyy/mm/dd
//	String offedate = request.getParameter("validto");//yyyy/mm/dd
//offsdate = offsdate.replaceAll("-", "/");//yyyy/mm/dd
//offedate = offedate.replaceAll("-", "/");//yyyy/mm/dd
	
	String off_type = request.getParameter("off_type");
	int sheetNum = Integer.parseInt(request.getParameter("sheetNum"));
	String[] offsdate = new String[sheetNum];
	String[] offedate = new String[sheetNum];
	String[] str = new String[sheetNum];
	String[] str2 = new String[sheetNum];
	String[] gdyear = new String[sheetNum];
	String[] str3 = new String[sheetNum];
	String errMsg = "";
	int flag = 0;//錯誤
	
	for(int i=0; i<sheetNum ;i++){//no.1-no.6
		offsdate[i] = request.getParameter("validfrm_"+(i+1));//yyyy/mm/dd
		offedate[i] = request.getParameter("validto_"+(i+1));//yyyy/mm/dd
		out.println(offsdate[i]+offedate[i]);
		if(offsdate[i] != null && !offsdate[i].equals("") && offedate[i] != null && !offedate[i].equals("")){
			ALProgress al = new ALProgress(userid,off_type, offsdate[i],offedate[i],userid);
			//暫停二秒
			try { Thread.sleep ( 2000 ) ; } catch (InterruptedException ie){}
			str[i] = al.crewALCheck();
			//out.println(str);
			
			if("Y".equals(str[i]))
			{
				str2[i] = al.insALRequest();
				if("Y".equals(str2[i]))
				{
					gdyear[i] = offsdate[i].substring(0,4);		
					str3[i] = al.ifTrainInPreviousMonth();
			
					if("N".equals(str3[i]))
					{
						errMsg += "親愛的空服員，您好！\r\n您所申請的 《"+offsdate[i].substring(5,7)+"月》";
						flag = 3;
			%>
						<%-- <script language=javascript>		
						alert("親愛的空服員，您好！\r\n您所申請的 《<%=offsdate[i].substring(5,7)%>月》全月休假，適逢ETS受訓月份，為了不影響您的休假權益\r\n，請務必與空訓部分機6455聯繫，提前安排受訓事宜。");	window.open('trainMonthChk.jsp?offsdate=<%=offsdate%>','','left=800,top=800,width=10,height=10,scrollbars=yes');
						window.location.href="viewoffsheet.jsp?offyear=<%=gdyear%>";	
						</script> --%>
			<%
					}
					else //if("Y".equals(str3))
					{
						errMsg += "第"+(i+1)+"筆:"+offsdate[i] +" ~ "+ offedate[i]+", AL/XL 遞單成功"+"<br>";
						//response.sendRedirect("viewoffsheet.jsp?offyear="+gdyear);
					}
			
				}
				else
				{
					//Record Error Log
					//*************************************************************************************
					String filename = "offErrorLog.txt";	 	
					String path = "/apsource/csap/projfz/txtin/off/";
					FileWriter fwlog = new FileWriter(path+filename,true);
					flag = 2;
					try
					{
						java.util.Date runDate1 = Calendar.getInstance().getTime();
						String time1 = new SimpleDateFormat("yyyy/MM/dd EEE HH:mm:ss a").format(runDate1);
						fwlog.write("Userid : "+userid+" Runtime: "+time1+" Empno : "+userid+" Offdate : "+offsdate[i]+"~"+offedate[i]+" Offtype : "+off_type+"  Error Msg : "+str2[i]+"  \r\n");
						fwlog.write("*************************************** \r\n");	
					}
					catch (Exception e)
					{
						errMsg += e.toString();
					} 
					finally
					{
						fwlog.close();	
					}
					//*************************************************************************************
					errMsg +="第"+(i+1)+"筆:AL/XL"+offsdate[i] +" ~ "+ offedate[i]+", request failed!! Msg: "+str2[i]+"<br>";
					//String str1 ="AL/XL request failed!!<br> Msg: "+str2+"!!<br><a href='javascript:history.back(-1)'>back</a>";
					//response.sendRedirect("sm.jsp?messagestring="+URLEncoder.encode(str1));
				}
			}
			else
			{
				//Record Error Log
				//*************************************************************************************
				String filename = "offErrorLog.txt";	 	
				String path = "/apsource/csap/projfz/txtin/off/";
				FileWriter fwlog = new FileWriter(path+filename,true);
				flag = 1;
				try
				{
					java.util.Date runDate1 = Calendar.getInstance().getTime();
					String time1 = new SimpleDateFormat("yyyy/MM/dd EEE HH:mm:ss a").format(runDate1);
					fwlog.write("Userid : "+userid+" Runtime: "+time1+" Empno : "+userid+" Offdate : "+offsdate[i]+"~"+offedate[i]+" Offtype : "+off_type+"  Error Msg : "+str[i]+"  \r\n");
					fwlog.write("***************************************\r\n");	
				}
				catch (Exception e)
				{
					errMsg += e.toString();
				} 
				finally
				{
					fwlog.close();	
				}
				//*************************************************************************************
				errMsg += "第"+(i+1)+"筆:AL/XL"+offsdate[i] +" ~ "+ offedate[i]+", request failed!! Msg: "+str[i]+"<br>";
				//String str1 ="AL/XL request failed!!<br> Msg: "+str+"!!<br><a href='javascript:history.back(-1)'>back</a>";
				//response.sendRedirect("sm.jsp?messagestring="+URLEncoder.encode(str1));
			}
		}
	
	
	}	//for(int i=0; i<sheetNum ;i++){//no.1-no.6
	/*******列出訊息******************************************************/
	switch(flag){
		case 0:
			errMsg += "送出多筆假單,以【本年度】優先顯示。";
			response.sendRedirect("viewoffsheet.jsp?offyear="+gdyear[0]+"&msg="+URLEncoder.encode(errMsg));
			break;
		case 1:
			errMsg +="<br><a href='javascript:history.back(-1)'>back1</a>";
			response.sendRedirect("sm.jsp?messagestring="+URLEncoder.encode(errMsg));
			break;
		case 2:
			errMsg += "<br><a href='javascript:history.back(-1)'>back2</a>";
			response.sendRedirect("sm.jsp?messagestring="+URLEncoder.encode(errMsg));
			break;
		case 3:
			%>
			<script language=javascript>		
			alert(errMsg+"\r\n全月休假，適逢ETS受訓月份，為了不影響您的休假權益\r\n，請務必與空訓部分機6455聯繫，提前安排受訓事宜。");	
			window.open('trainMonthChk.jsp?offsdate=<%=offsdate[0]%>','','left=800,top=800,width=10,height=10,scrollbars=yes');
			window.location.href="viewoffsheet.jsp?offyear=<%=gdyear[0]%>";	
			</script>
			<%
			break;
	}
	/*
	if(flag3){//str1
	*/
		%>
		<%-- <script language=javascript>		
		alert(errMsg+"\r\n全月休假，適逢ETS受訓月份，為了不影響您的休假權益\r\n，請務必與空訓部分機6455聯繫，提前安排受訓事宜。");	
		window.open('trainMonthChk.jsp?offsdate=<%=offsdate%>','','left=800,top=800,width=10,height=10,scrollbars=yes');
		window.location.href="viewoffsheet.jsp?offyear=<%=gdyear%>";	
		</script> --%>
		<%
	/*
	}else if (flag2){//str2
		errMsg = "<br><a href='javascript:history.back(-1)'>back</a>";
		response.sendRedirect("sm.jsp?messagestring="+URLEncoder.encode(errMsg));
	}else if (flag1){//str1
		errMsg ="<br><a href='javascript:history.back(-1)'>back</a>";
		response.sendRedirect("sm.jsp?messagestring="+URLEncoder.encode(errMsg));
	}else{//Success
		response.sendRedirect("viewoffsheet.jsp?offyear="+gdyear);
	} */
}
%>