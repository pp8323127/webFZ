<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*,java.util.*" %>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("logout.jsp");
} 

Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
ConnDB cn = new ConnDB();

String sql = null;
String bgColor=null;
String kin = null;
String itemno= null;
String itemdesc= null;
String status = null;
String keyno = null;
String sflag = "";
int rowCount = 0;

status = request.getParameter("status").trim();

Driver dbDriver = null;

try{
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
		if (status.equals("ins"))
		{
			kin = request.getParameter("kin").trim();
			itemno = request.getParameter("itemno").trim();
			itemdesc = request.getParameter("itemdesc").trim();

			sql = "select * from egtstsi where itemno = '" + itemno + "' ";
			rs = stmt.executeQuery(sql);
			if (rs != null)
			{
				rs.last();	
				rowCount = rs.getRow();

				if (rowCount == 0)
				{
				sql = "";
				sql = "insert into egtstsi (itemno,itemdsc,kin,sflag) values('"+itemno+"','"+itemdesc+"',upper('"+kin+"'),'Y')";
				stmt.executeUpdate(sql); 	
%>
				<script language=javascript>
				alert("Insert completed!!\n存入成功!!");
				//close_self("insSItem.jsp");
				window.opener.location.reload();
				this.window.close();
				</script>
<%
				}
				else
				{
%>
				<script language=javascript>
				alert("The input has existed.!!\n輸入資料已存在!!");
				</script>
<%
				}
			}
		}
		else if (status.equals("upd"))
		{
			kin = request.getParameter("kin").trim();
			itemno = request.getParameter("itemno").trim();
			itemdesc = request.getParameter("itemdesc").trim(); 	
			keyno = request.getParameter("keyno").trim(); 	
			sflag = request.getParameter("sflag").trim();

			sql = "";
			sql = "update egtstsi set itemno='"+itemno+"',itemdsc='"+itemdesc+"', sflag = '"+sflag+"' where itemno = '"+keyno+"'";
			stmt.executeUpdate(sql); 	
%>
				<script language=javascript>
				alert("Update completed!!\n更新成功!!");
				//close_self("insSItem.jsp");
				window.opener.location.reload();
				this.window.close();
				</script>
<%
		}
		else if (status.equals("del"))
		{
			kin = request.getParameter("kin").trim();
			String[] delItem = request.getParameterValues("itemno");
			String delStr="";

			//out.print ("kin="+kin);
			for(int i=0;i<delItem.length;i++)
			{
				if(i==0)
				{
					delStr = "'"+delItem[i]+"'";
				}
				else
				{
					delStr +=",'"+delItem[i]+"'";
				}
			}
			sql = "";
			sql = "delete egtstsi where itemno in(" + delStr+")";					
			stmt.executeUpdate(sql);
%>
				<script language=javascript>
				alert("Delete completed!!\n刪除成功!!");
				</script>
<%
				response.sendRedirect("edSItem.jsp?kin="+kin);
		}
		else
		{}
	}
	catch(Exception e)
	{
		out.print(e.toString());
	}
	finally
	{
		try{if(rs != null) rs.close();}catch(SQLException e){}
		try{if(stmt != null) stmt.close();}catch(SQLException e){}
		try{if(conn != null) conn.close();}catch(SQLException e){}
	}

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Insert SubItem </title>
<link href="style.css" rel="stylesheet" type="text/css">
<script src="js/close.js" type="text/javascript"></script>
</head>
<body>
</body>
</html>
