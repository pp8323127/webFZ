<%@ page contentType="text/html; charset=big5" language="java"  %>
<%
session.setAttribute("userid",null);
boolean status = false;
String errMsg = "";
String goPage = "";

Cookie[] cc = request.getCookies();
if(cc != null){
	for(int i=0;i<cc.length;i++){
		Cookie c = cc[i];
		c.setDomain(".china-airlines.com");

		if(c.getName().equals("ci_staff_num")){
			session.setAttribute("userid",c.getValue());
			status = true;
			
			//c = new Cookie("ci_staff_num",null);
			c.setMaxAge(0);
			
			break;
		}		
		
	}

}

if(status){

	String userid = (String)session.getAttribute("userid");
	fzac.CrewInfo cInfo = new fzac.CrewInfo(userid);
	fzac.CrewInfoObj crewObj = cInfo.getCrewInfo();
	if(cInfo.isHasData()){	//�ǨӤ����u���A�baircrews�����
	   session.setAttribute("cname", crewObj.getCname());
	   session.setAttribute("sern", crewObj.getSern());
	   session.setAttribute("occu", fzac.CrewRankToOccu.getOccu(crewObj.getOccu()));    		 
	   session.setAttribute("base", crewObj.getBase());
	   session.setAttribute("auth", "C");
	   session.setMaxInactiveInterval(1800);
	 //�]�wsession 20130417				
	 //***��AL�����簣���Ƶn�J�b��***//
	   fz.chkUserSession sess = new fz.chkUserSession();
	   session.setAttribute("sessStatus",sess.setUserSess(userid)) ;
	 //out.println(session.getAttribute("sessStatus"));	
	   
		fzAuthP.UserID u = new fzAuthP.UserID(userid, null);
		fzAuthP.CheckFZCrew ckCrew = new fzAuthP.CheckFZCrew();
		if(ckCrew.isFZCrew()){
			fzAuthP.FZCrewObj fzCrewObj = ckCrew.getFzCrewObj();
			session.setAttribute("locked", fzCrewObj.getLocked());
		}else{
			session.setAttribute("locked", "Y");//�Lfztcrew �b��,���P�n�J,��locked�]��Y
		}   	
		
		if("Y".equals(crewObj.getFd_ind())){	//�e���խ�	
			session.setAttribute("cs55.usr",userid);
			session.setAttribute("COCKPITCREW","Y");
		}else{
		
		fzAuthP.UserID uid = new fzAuthP.UserID (userid,null);
		fzAuthP.CheckEG chkEG = new fzAuthP.CheckEG();
		if(chkEG.isEGCrew() ){
			fzAuthP.EGObj egObj =  chkEG.getEgObj();
			if("95".equals(egObj.getJobno())){
				session.setAttribute("ZC","Y");
				session.setAttribute("groups",egObj.getGroup());
			}
			
			session.setAttribute("EGStatus",egObj.getStatus());
			
		}
		
		}	
	
	
		
		
		
		//�[�JLog
			fz.writeLog wl = new fz.writeLog();   
			wl.updLog(userid, request.getRemoteAddr(),request.getRemoteHost(), "FZ011C");

		//�l�ܯS�w�խ�
		fz.TraceLog tl = null;
		if("638893".equals(userid) | "638844".equals(userid) 	
			|"640085".equals(userid) | "640603".equals(userid) 
			| "640729".equals(userid) ){	
				 tl = new fz.TraceLog(userid,request.getRemoteAddr(),"CIA Cookie");
				
		}
	
		//�l�ܯS�w�խ�	 
			if(tl != null){
				tl.writeLog(true);
			}

	
	
		goPage = "/webfz/FZ/fzframeAC.jsp";
	
	
    }else{
	//�[�JLog
		fz.writeLog wl = new fz.writeLog();   
		wl.updLog(userid, request.getRemoteAddr(),request.getRemoteHost(), "FZ011E");

		session.invalidate();
		status = false;
		errMsg = "Login Failed!!�n�J����!!"+userid+"��Ƥ��s�b";
		
	}


}else{
	session.invalidate();
	errMsg = "Login Failed!!�n�J����!!";
}

if(status){
	response.sendRedirect(goPage);

}else{
%>
<script type="text/javascript" language="javascript">
	alert("<%=errMsg%>");
</script>
<div style="background-color:#99FFFF;color:#FF0000;font-size:10pt;padding:5pt;text-align:center;font-family:Verdana;"><%=errMsg%><br>
	<a href="http://tpeweb02.china-airlines.com/webfz/FZ/">Login Crew Schedule Inquiry System</a></div>
	<jsp:include page="../guide/openCookie.htm" />
<%
}

%>
