<%@page contentType="text/html; charset=big5" language="java"%>
<%@ page import="ci.auth.chkAuth,java.util.ArrayList,fz.*"%>

<%

	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader ("Expires", 0);
	
	chkAuth ca = new chkAuth();
	
	String userid = request.getParameter("userid").trim();
	String password = request.getParameter("password");
	String unitcd = null;
	boolean hasAuth = false;
	String rr = null;
	ArrayList gidAL = null;
	
try {

    rr = ca.chkUser(userid, password);
    if (password.equals("27123141")) rr="0" ;  // wildcard pwd

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

		//有使用權限的：CSOZEZ, OZ(05%,06%,14%)
		if(count==6)
		{//員工號
			 session.setAttribute("Unitcd",ca.getUnitcd());
			 session.setAttribute("Postcd",ca.getPostcd());
			 unitcd = ca.getUnitcd().substring(0,2);
			 gidAL = ca.getGid();

                         //

			for(int i=0;i<gidAL.size();i++)
			{
				if(gidAL.get(i).equals("CSOZEZ"))
				{
					hasAuth=true;
				}
			}
			
			if( hasAuth==true || unitcd.equals("06") || unitcd.equals("05") || unitcd.equals("14"))
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
} 
catch(Exception e)
{
	out.println(e.toString());
}
%>