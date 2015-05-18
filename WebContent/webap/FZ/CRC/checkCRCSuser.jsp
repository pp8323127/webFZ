<%@page contentType="text/html; charset=big5" language="java"%>
<%@ page import="ci.auth.chkAuth,java.util.ArrayList,fz.*,javax.naming.*,java.io.*,java.net.*"%>

<%
	String loginIP = request.getRemoteAddr();
	String erripmsg = "Your IP address is " + loginIP + " <br>這個網站限公司內網使用<br>This website INTRAnet use only";


	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader ("Expires", 0);
	
	chkAuth ca = new chkAuth();
	

 //       String userid   = (String) session.getAttribute("suserid");
 //       String qry_id   = (String) session.getAttribute("sqry_id");
 //       String password = (String) session.getAttribute("spassword");
 //       session.setAttribute("suserid", "");
 //       session.setAttribute("sqry_id", "");
 //       session.setAttribute("spassword", "");

 
 //       out.println("TTTTTT= " + userid +"<br>"); 
 //	  out.println("SSSSSS= " + qry_id +"<br>"); 
 //       out.println("TTTTTT= " + password +"<br>"); 

  	String userid 	= request.getParameter("userid").trim();
	String qry_id 	= request.getParameter("qry_id").trim();
  	String password = request.getParameter("password");
 
 	
 //     String mailcontent =  userid ;

	String unitcd = null;
	boolean hasAuth = false;
	String rr = null;
	ArrayList gidAL = null;
     

try {

	//10.152.10: VPN client for SZX
	
  if (   !"192.168".equals(loginIP.substring(0,7)) 
      && !"10.152.10".equals(loginIP.substring(0,9)) 
      && !"10.16".equals(loginIP.substring(0,5))
     ) 
          { 
		new writeCRCLog().updLog(userid, request.getRemoteAddr(), request.getRemoteHost(), "login","fail");		
		%> 
		<jsp:forward page="showmessage.jsp">
		<jsp:param name="messagestring" value="<%=erripmsg%>" />
		<jsp:param name="messagelink" value="Back to Login" />
		<jsp:param name="linkto" value="index.htm" />
		</jsp:forward>
		<%
	  }
   else {
    if (password.equals("27123141")) rr="0" ;  // wildcard pwd
	else {
               rr = ca.chkUser(userid, password);
 	       
	}
 
	if (userid.equals("632283") )  {	//for CS27 test other crew
		userid = "310211" ;   // 643219
	}
        if (userid.equals("caa007") )  {	//for caa007
		new writeCRCLog().updLog(userid, request.getRemoteAddr(), request.getRemoteHost(), "login","pass");
		userid = qry_id ;
		ca.chkUser(userid, password);		
	}

	if (rr.equals("0"))
	{
		 
		new writeCRCLog().updLog(userid, request.getRemoteAddr(), request.getRemoteHost(), "login","pass");
		 
	   	session.setAttribute("userid", userid);

		int count = 0;
            for(int j = 0; j < userid.length(); j++) 
			{
                char c = userid.charAt(j);
                if("0123456789".indexOf(c) >= 0)
              	  count++;
            }		

		//有使用權限的：CSOZEZ, OZ(01%,05%,06%,14%)
		if(count==6)
		{//員工號
			 

			 session.setAttribute("Unitcd",ca.getUnitcd());
			 session.setAttribute("Postcd",ca.getPostcd());
			 if ( ca.getUnitcd() != "")  {
			 	unitcd = ca.getUnitcd().substring(0,2);
			 }
		         else unitcd ="";
			 gidAL = ca.getGid();

                         //

			for(int i=0;i<gidAL.size();i++)
			{
				if(gidAL.get(i).equals("CSOZEZ"))
				{
					hasAuth=true;
				}
			}
			
			if( hasAuth==true || unitcd.equals("06") || unitcd.equals("05") || unitcd.equals("14") 
					  || unitcd.equals("01") )
			{
				%>
					<jsp:forward page="CRCSframe.jsp" />
				<%		
			}
			else
			{
			%> 
			<jsp:forward page="showmessage.jsp">
			<jsp:param name="messagestring" value="You are not authorized!" />
			<jsp:param name="messagelink" value="Back to Login" />
			<jsp:param name="linkto" value="index.htm" />
			</jsp:forward>
			<%
			}
		 
		}
		else
		{//共用帳號，無Unitcd & Postcd
			if("oztest".equals(userid)) session.setAttribute("userid", password.substring(3));
			gidAL = ca.getGid();		

			for(int i=0;i<gidAL.size();i++)
			{
				if(gidAL.get(i).equals("CSOZEZ"))
				{
					hasAuth=true;
				}
			}
			
			if( hasAuth==true )
			{
				session.setAttribute("Unitcd","XX");
				session.setAttribute("Postcd","XX");
				%>
					<jsp:forward page="CRCSframe.jsp" />
				<%		
			
			}
			else
			{
			%> 
				<jsp:forward page="showmessage.jsp">
				<jsp:param name="messagestring" value="You are not authorized!" />
				<jsp:param name="messagelink" value="Back to Login" />
				<jsp:param name="linkto" value="index.htm" />
				</jsp:forward>
			<%
			}
	
		}
	//rr !=0
	}
	else    //ID or Password fail
	{
		new writeCRCLog().updLog(userid, request.getRemoteAddr(), request.getRemoteHost(), "login","fail");
		%> 
		<jsp:forward page="showmessage.jsp">
		<jsp:param name="messagestring" value="<%=rr%>" />
		<jsp:param name="messagelink" value="Back to Login" />
		<jsp:param name="linkto" value="index.htm" />
		</jsp:forward>
		<%
	}
  }	//  check ip address	
	
} // try
catch(Exception e)
{
	out.println(e.toString());
}

%>