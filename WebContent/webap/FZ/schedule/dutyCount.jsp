<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*" errorPage="" %>
<%@page import="eg.report.DutyCount,eg.report.DutyCountObj"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login
String pageid = (String) request.getParameter("pageid") ;  
if (session.isNew() || userid == null) 
{		//check user session start first
	response.sendRedirect("../logout.jsp");
} 
String year1 = (String)request.getParameter("year1");
String year2 = (String)request.getParameter("year1");//琩
String month1 = (String)request.getParameter("month1");
String month2 = (String)request.getParameter("month2");
String sdate = year1+month1;
String edate = year2+month2;
String empn = (String) request.getParameter("empn");
//out.println(sdate+","+edate+","+empn);
ArrayList oriSkjObjAL = new ArrayList();
ArrayList oriOffDaysObjAL = new ArrayList();
ArrayList oriADODaysObjAL = new ArrayList();

ArrayList actSkjObjAL = new ArrayList();
ArrayList actOffDaysObjAL = new ArrayList();
ArrayList actADODaysObjAL = new ArrayList();

String tempbgcolor ="";
int wd = 5;
if(!"".equals(empn))
{
	try{	

		DutyCount dc = new DutyCount();		
		dc.getOriADODays(sdate,edate,empn); 
		oriADODaysObjAL = dc.getObjAL();
		//out.println("oado"+oriADODaysObjAL.size());		
		
		dc.setObjAL(new ArrayList());		
		dc.getActADODays(sdate,edate,empn);
		actADODaysObjAL  = dc.getObjAL();
		//out.println("aado"+actADODaysObjAL.size());
		
		dc.setObjAL(new ArrayList());		
		dc.getOriOffDays(sdate,edate,empn);
		oriOffDaysObjAL = dc.getObjAL();	
		//out.println("ooff"+oriOffDaysObjAL.size());	
		
		dc.setObjAL(new ArrayList());		
		dc.getActOffDays(sdate,edate,empn);
		actOffDaysObjAL = dc.getObjAL();		
		//out.println("aoff"+actOffDaysObjAL.size());
		
		dc.setObjAL(new ArrayList());		
		dc.getOriSkj(sdate,edate,empn);
		oriSkjObjAL = dc.getObjAL();
		//out.println("oskj"+oriSkjObjAL.size());
		
		dc.setObjAL(new ArrayList());		
		dc.getActSkj(sdate,edate,empn);
		actSkjObjAL  = dc.getObjAL();	
		//out.println("askj"+actSkjObjAL.size());
		
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5" />
<link rel="stylesheet" href="../style.css">
<link rel="stylesheet" href="../menu.css">
<title>舱ヴ叭参璸</title>
</head>

<body>
<div id="divTit" align="center"  class="txttitletop" >
<h3>舱ヴ叭参璸(<%=year1%>)の–るヰ安ぱ计<br /></h3>
</div>
<div id="divTb" class="black">
	<table width="<%=wd*14%>%" border="1" align="center" id="table1" >
	<%		
		if(actSkjObjAL.size() > 0){	
			DutyCountObj obj= (DutyCountObj) actSkjObjAL.get(0);
	%>
		<tr class="tablehead">	
			<td>Empn</td>
			<td>Sern</td>
			<td>Cname</td>			
			<td>Base</td>
			<td>Groups</td>
		</tr>
		<tr class="tablebody" >		
			<td><%=obj.getStaff_num()%></td>			
			<td><%=obj.getSern() %></td>
			<td><%=obj.getCname()%></td>	
			<td><%=obj.getBase()%></td>		
			<td><%=obj.getGrp()%></td>
		</tr>	
		<%
		}
		%>
	</table>
	
	<hr />
	<h5 class="txttitletop"  align="center">舱ヰ安参璸(ぱヰ安)</h5>
	<table  border="1" align="center" id="table1" >
		<tr class="tablehead">
			<td width="<%=wd*4%>%">YYYYMM</td>
			<%
			if(actOffDaysObjAL.size() > 0){
				for(int j=0;j<actOffDaysObjAL.size();j++){
					DutyCountObj obj= (DutyCountObj) actOffDaysObjAL.get(j);
					out.println("<td width='"+wd*2+"%'>"+obj.getOffyyyymm()+"</td>");				
				} 
			}else{
				out.println("<td>None</td>");	
			}
			%>
		</tr>
		<tr class="tablebody" >
			<td>箇逼ヰ安ぱ计</td>
			<%
			if(oriOffDaysObjAL.size() > 0){
				for(int j=0;j<oriOffDaysObjAL.size();j++){
					DutyCountObj obj= (DutyCountObj) oriOffDaysObjAL.get(j);
					out.println("<td>"+obj.getOff_days()+"</td>");
				} 
			}else{
				out.println("<td>"+0+"</td>");	
			}
			
			%>
		</tr>
		<tr class="tablebody" >
			<td>龟悔ヰ安ぱ计</td>
			<%
			if(actOffDaysObjAL.size() > 0)
			{
				for(int j=0;j<actOffDaysObjAL.size();j++)
				{
					DutyCountObj obj= (DutyCountObj) actOffDaysObjAL.get(j);					
					out.println("<td>"+obj.getOff_days()+"</td>");
				} 
			}
			else
			{
				out.println("<td>"+0+"</td>");	
			}
			%>
		</tr>
		<tr class="tablebody" >
			<td>箇逼ADOぱ计</td>
			<%
			if(oriADODaysObjAL.size() > 0)
				{
				for(int j=0;j<oriADODaysObjAL.size();j++)
				{
					DutyCountObj obj= (DutyCountObj) oriADODaysObjAL.get(j);
					//out.println("<td>"+obj.getAdo_days()+"</td>");
					out.println("<td>"+obj.getCnt()+"</td>");
				} 
			}else{
				out.println("<td>"+0+"</td>");	
			} 
			%>
		</tr>
		<tr class="tablebody" >
			<td>龟悔ADOぱ计</td>
			<%
			if(actADODaysObjAL.size() > 0){				
				for(int j=0;j<actADODaysObjAL.size();j++){
					DutyCountObj obj= (DutyCountObj) actADODaysObjAL.get(j);
					//out.println("<td>"+obj.getAdo_days()+"</td>");
					out.println("<td>"+obj.getCnt()+"</td>");
				} 
			}else{
				out.println("<td>"+0+"</td>");	
			} 
			%>
		</tr>
	</table>
	
	<hr />
	<h5 class="txttitletop"  align="center">舱ヴ叭参璸(<%=sdate%>~<%=edate%>)</h5>
	
		<table width="<%=wd*9%>%" border="1" style="float:left;" >
		<tr class="tablehead">	
			<td colspan="5">箇逼痁</td>
		</tr>
		<tr class="tablehead">	
			<td width="<%=wd*1%>%">#</td>
			<td width="<%=wd*2%>%">Fltno</td>
			<td width="<%=wd*3%>%">Dep</td>
			<td width="<%=wd*3%>%">Arv</td>
			<td width="<%=wd*1%>%">Ω计</td>
		</tr>
		<%		
		if(oriSkjObjAL.size() > 0){	
			for(int i=0;i<oriSkjObjAL.size();i++){
				DutyCountObj obj= (DutyCountObj) oriSkjObjAL.get(i);			
				if (i%2 == 0)
				{
					tempbgcolor = "#C9C9C9";
				}
				else
				{
					tempbgcolor = "#FFFFFF";
				}	
			
		%>
		<tr  class="tablebody" bgcolor="<%=tempbgcolor%>">
			<td><%=(i+1)%></td>
			<td><%=obj.getDuty_cd()%></td>
			<td><%=obj.getDpt()%></td>
			<td><%=obj.getArv()%></td>
			<td><%=obj.getCnt()%></td>
		</tr>
		<%
			}
		} 
		%>
	</table>
	
	<table width="<%=wd*10%>%" border="1" style="float:right;" >
		<tr class="tablehead">	
			<td colspan="5">龟悔痁</td>
		</tr>
		<tr class="tablehead">	
			<td width="<%=wd*1%>%">#</td>
			<td width="<%=wd*2%>%">Fltno</td>
			<td width="<%=wd*3%>%">Dep</td>
			<td width="<%=wd*3%>%">Arv</td>
			<td width="<%=wd*1%>%">Ω计</td>
		</tr>
		<%		
		if(actSkjObjAL.size() > 0){	
			for(int i=0;i<actSkjObjAL.size();i++){
				DutyCountObj obj= (DutyCountObj) actSkjObjAL.get(i);	
				if (i%2 == 0)
				{
					tempbgcolor = "#C9C9C9";
				}
				else
				{
					tempbgcolor = "#FFFFFF";
				}	
		%>
		<tr  class="tablebody" bgcolor="<%=tempbgcolor%>">
			<td><%=(i+1)%></td>
			<td><%=obj.getDuty_cd()%></td>
			<td><%=obj.getDpt()%></td>
			<td><%=obj.getArv()%></td>
			<td><%=obj.getCnt()%></td>
		</tr>
		<%
			}
		}
		%>
	</table>
</div>
</body>
</html>
<%
}catch(Exception e){
		out.println(e.toString());
	}
	
	
	
}
 %>