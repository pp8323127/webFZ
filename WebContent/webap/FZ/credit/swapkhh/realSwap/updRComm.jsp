<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="java.sql.*,ci.db.*"%>
<%
//新增手工換班附註
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String userid 	=(String) session.getAttribute("userid") ; 
if (userid == null) 
{		
	response.sendRedirect("/webfz/FZ/sendredirect.jsp");
}else{

String addcomm = request.getParameter("addcomm");

Connection conn = null;
Driver dbDriver = null;

PreparedStatement pstmt = null;
ResultSet rs = null;
boolean status = false;
String errMsg = "";
ci.db.ConnDB cn = new ci.db.ConnDB();

try{

cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
	

//判斷是否已有值
int count = 0;

pstmt = conn.prepareStatement("select citem from fztrcomf where station='KHH' and  citem =?");
pstmt.setString(1,addcomm);

rs = pstmt.executeQuery();

while(rs.next()){
	count++;
}
pstmt.close();
rs.close();
if(count != 0){
	errMsg = "重複設定附註：" +addcomm;
}else{
	pstmt = conn.prepareStatement("insert into fztrcomf(citem,station) values(?,'KHH')");
	pstmt.setString(1,addcomm);
	pstmt.executeUpdate();
	
	status = true;
	pstmt.close();
	
}


}catch (SQLException e){	 
	 errMsg = e.toString();
}finally{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}

	if(!status){
	%>
		<div style="background-color:#99FFFF;
				color:#FF0000;
				font-family:Verdana;
				font-size:10pt;padding:5pt;
				text-align:center; ">更新失敗<br>
		ERROR:<%=errMsg%><br>
		<a href="javascript:history.back(-1);" target="_self">BACK</a></div>		
	<%
		
	
	}else{
	%>
		<script language="javascript" type="text/javascript">
			alert("更新成功!!");
			self.location.href="rcomm.jsp";
			parent.topFrame.location.href="../blank.htm";
			
		</script>
	<%
		
	}



}
%>