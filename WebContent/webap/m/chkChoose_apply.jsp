<%@page import="ws.CrewMsgObj"%>
<%@page import="java.util.ArrayList"%>
<%@page import="ws.crew.CrewPickApplyNumRObj"%>
<%@page import="fzAuthP.FZCrewObj"%>
<%@page import="ws.crew.CrewPickFun"%>
<%@page import="ws.crew.LoginAppBObj"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>

<%
LoginAppBObj lObj= (LoginAppBObj) session.getAttribute("loginAppBobj");
if(lObj == null ) {
	out.println("請登入");
	response.sendRedirect("login.jsp");
}
else
{
	try{	
		FZCrewObj uObj = lObj.getFzCrewObj();
		String type = (String)request.getParameter("type");
		
		String att = "";
		String pointList =  "";
		CrewPickFun cpf = null;
		if("1".equals(type)){
			att = (String)request.getParameter("att");
			String sdate = (String)request.getParameter("sdate");
			String edate = (String)request.getParameter("edate");
			String comment = (String)request.getParameter("comment");
			cpf = new CrewPickFun();		
			CrewMsgObj msg = cpf.SendPickAttForm( uObj.getEmpno(), uObj.getBase(), sdate, edate, comment);
			if("1".equals(msg.getResultMsg())){
				out.println("Successful:"+msg.getErrorMsg());
			}else{
				out.println(msg.getErrorMsg());
			}
			//out.println("Successful:"+att+ "/" +sdate+ "/" +edate+ "/"+comment);
		}else if("2".equals(type)){
			pointList = (String)request.getParameter("pointList");
			if(null != pointList && !"".equals(pointList)){
				String[] chkItem = pointList.split(",");
				cpf = new CrewPickFun();	
				CrewMsgObj msg = cpf.SendPickCtForm(chkItem, uObj.getEmpno(), uObj.getBase());
				if("1".equals(msg.getResultMsg())){
					out.println("Successful:"+msg.getErrorMsg());
				}else{
					out.println(msg.getErrorMsg());
				}
				//out.println("Successful:"+pointList);
			}else{
				out.println("申請失敗,請勾選3個積點或選班單");
			}
		}
	}
	catch(Exception e){
		out.println(e.toString());
	}
}	

%>