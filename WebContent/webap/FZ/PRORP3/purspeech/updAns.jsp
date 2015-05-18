<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*,java.util.*" %>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login
String formno = (String) request.getParameter("formno") ; 
String itemno = (String) request.getParameter("itemno") ; 
String editor = (String) request.getParameter("editor") ; 
String itemdsc = (String) request.getParameter("itemdsc") ; 
String itemdsc2 = (String) request.getParameter("itemdsc2") ; 
String reply = (String) request.getParameter("reply") ; 
String status = (String) request.getParameter("status") ; 
String isFirst = (String) request.getParameter("isFirst") ; 
String alertstr = "";
if(status.equals("done"))
{
	alertstr = formno.substring(0,4)+"/"+formno.substring(4,6)+"討論主題發言單已送出!!";
}
else
{
	alertstr = "草稿已儲存!!";
}

/*
out.print ("formno  = " + formno + "<br>");
out.print ("editor  = " + editor + "<br>");
out.print ("itemdsc  = " + itemdsc + "<br>");
out.print ("itemno  = " + itemno + "<br>");
out.print ("reply  = " + reply + "<br>");
out.print ("status  = " + status + "<br>");
out.print ("isFirst  = " + isFirst + "<br>");
*/

if (userid == null) 
{		
	response.sendRedirect("../sendredirect.jsp");
} 
/*
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
ConnDB cn = new ConnDB();
*/

Driver dbDriver = null;
Connection conn = null;
Statement stmt = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
ConnDB cn = new ConnDB();
String sql = null;

try{
/*
		cn.setORT1EG();
		java.lang.Class.forName(cn.getDriver());
		conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),cn.getConnPW());
		stmt = conn.createStatement();
		*/
		cn.setORP3EGUserCP();
		dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
		conn = dbDriver.connect(cn.getConnURL(), null);
		stmt = conn.createStatement();

		if (isFirst.equals("Y"))
		{
			//sql = "insert into egtpspa (formno,itemno,empno,itemdsc,itemdsc2,reply,upddate) values ('"+formno+"','"+itemno+"','"+editor+"','"+itemdsc+"','"+itemdsc2+"','"+reply+"',sysdate)";

			sql = "insert into egtpspa (reply,formno,itemno,empno,itemdsc,itemdsc2,upddate) values (?,?,?,?,?,?,sysdate)";
		}
		else
		{
			//sql = "update egtpspa set reply = '"+reply+"', upddate = sysdate where formno = '"+formno+"' and itemno ='"+itemno+"' and empno = '"+editor+"' and itemdsc = '"+itemdsc+"' and itemdsc2 = '"+itemdsc2+"'";
			
			sql = "update egtpspa set reply = ?, upddate = sysdate where formno = ? and itemno = ? and empno = ? and itemdsc = ? and itemdsc2 = ?";
		}
		pstmt = conn.prepareStatement(sql);
		int j = 1;
		pstmt.setString(j, reply);
		pstmt.setString(++j, formno);
		pstmt.setString(++j, itemno);	                
		pstmt.setString(++j, editor);
		pstmt.setString(++j, itemdsc);
		pstmt.setString(++j, itemdsc2);
		//update reply
		pstmt.executeUpdate();	       

		if (status.equals("done"))
		{
			sql = "insert into egtpspo (formno,empno,closed,senddate) values ('"+formno+"','"+editor+"','N',sysdate)";

			//out.print(sql+"<br>");
			stmt.executeUpdate(sql); 	
		}
%>
		<script language=javascript>
		alert("<%=alertstr%>!!");
		window.location.href="sphForm.jsp?fyy=<%=formno.substring(0,4)%>&fmm=<%=formno.substring(4,6)%>";
		//window.opener.location.href="sphForm.jsp?fyy=<%=formno.substring(0,4)%>&fmm=<%=formno.substring(4,6)%>";
		//self.close();
		</script>
<%
}
catch(Exception e)
{
	out.print(e.toString());
}
finally
{
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>
