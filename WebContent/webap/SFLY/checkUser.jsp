<%@page contentType="text/html; charset=big5" language="java"%>
<%@ page import="ci.auth.chkAuth,java.util.ArrayList"%>
<%

	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader ("Expires", 0);
	
	
	chkAuth ca = new chkAuth();
	String userid = request.getParameter("userid").trim();
	String password = request.getParameter("password");
	String unitcd = null;
	String postcd = null;
	String gid = "";
	boolean hasAuth = false;
	String rr = null;
	ArrayList gidAL = null;



try {

    rr = ca.chkUser(userid,password);

	if ("0".equals(rr)  )
	{
	   	 session.setAttribute("userid", userid);
		 session.setAttribute("password",password);
		 
		int count = 0;
            for(int i = 0; i < userid.length(); i++) 
			{
                char c = userid.charAt(i);
                if("0123456789".indexOf(c) >= 0)
              	  count++;
            }		
				
		//���ϥ��v�����GCSOZEZ,�ŪA�|�p(180B),�ŪA����(190A),�����ŪA��(635),�żг�(193B)
		if(count==6)
		{//���u��
			 session.setAttribute("Unitcd",ca.getUnitcd());
			 session.setAttribute("Postcd",ca.getPostcd());

			 unitcd = ca.getUnitcd();
			 postcd = ca.getPostcd();
			 gidAL = ca.getGid();		
			
			
			for(int i=0;i<gidAL.size();i++)
			{
				if("CSOZEZ".equals(gidAL.get(i)))
				{
					session.setAttribute("group","CSOZEZ");
					hasAuth=true;
				}
			}
			
			//if( hasAuth==true || unitcd.substring(0,2).equals("18") || unitcd.substring(0,2).equals("19") || unitcd.substring(0,3).equals("635")  )
			/*  postcd���,
			200802,�s�W �N�Ʋz �P �N�ժ����v��
			
			191G,617G	�N�ժ�,�����N�ժ�
			192G,193G,	�ժ�
			193F,191J   �żХN�ժ�
			401F,		�Ʋz
			403F,		�N�Ʋz
			638716		�}�Q�f
			631255		��ܮ�
			256G,401E   �ź޸g/�Ʋz
			632970      �ȭŭ�
			631711      �d��P
			631210      �B�g��

			*/

			if( hasAuth==true || (postcd.length()==4 && ("192G".equals(postcd.substring(0,4)) || "193G".equals(postcd.substring(0,4)) ||"401F".equals(postcd.substring(0,4)) ||  "191G".equals(postcd.substring(0,4)) ||"191H".equals(postcd.substring(0,4)) ||  "403F".equals(postcd.substring(0,4)))) || "631255".equals(userid) || ("195B".equals(ca.getUnitcd()) && "400E".equals(postcd)) || ("195B".equals(ca.getUnitcd()) && "401E".equals(postcd)) || ("195B".equals(ca.getUnitcd()) && "256G".equals(postcd)) || ("635".equals(ca.getUnitcd()) && "439G".equals(postcd)) || ("635".equals(ca.getUnitcd()) && "191J".equals(postcd)) || ("193F".equals(ca.getUnitcd()) && "191J".equals(postcd))  || "631175".equals(userid) || "629518".equals(userid) || "631199".equals(userid) || "632970".equals(userid) || "631711".equals(userid) || "629648".equals(userid) || "630533".equals(userid) || "631210".equals(userid))
			{

				%>
					<jsp:forward page="egFrame.htm" /> 
				<%		
			
			}
			else
			{
			%> 
			<jsp:forward page="showMessage.jsp">
			<jsp:param name="messagestring" value="You are not authorized!" />
			<jsp:param name="messagelink" value="Back to Login" />
			<jsp:param name="linkto" value="index.htm" />
			</jsp:forward>
			<%
			}
	 
		}
		else
		{//�@�αb���A�LUnitcd & Postcd
			gidAL = ca.getGid();		
			gid = "";
		
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
					<jsp:forward page="egFrame.htm" />
				<%		
			
			}
			else
			{
	
			%> 
				<jsp:forward page="showMessage.jsp">
				<jsp:param name="messagestring" value="You are not authorized!" />
				<jsp:param name="messagelink" value="Back to Login" />
				<jsp:param name="linkto" value="index.htm" />
				</jsp:forward>
			<%
			}
	
		}
	//rr !=0
	}
	else//"You are not authorized!"   
	{
		%> 
		<jsp:forward page="showMessage.jsp"> 
		<jsp:param name="messagestring" value="<%=rr%>" />
		<jsp:param name="messagelink" value="Back to Login" />
		<jsp:param name="linkto" value="index.htm" />
		</jsp:forward>
		<%
	}
} 
catch(Exception e)
{
	//e.printStackTrace();
	    %> 
		<jsp:forward page="showMessage.jsp"> 
		<jsp:param name="messagestring" value="Please check your ID or Password !" />
		<jsp:param name="messagelink" value="Back to Login" />
		<jsp:param name="linkto" value="index.htm" />
		</jsp:forward>
		<%
}


%>