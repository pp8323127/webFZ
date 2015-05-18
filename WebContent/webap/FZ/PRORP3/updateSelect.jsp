<%@ page contentType="text/html; charset=big5" language="java" %>
<%@ page import="java.sql.*,fz.pr.orp3.Select" %>
<%

try{
Select sel = new Select();
		sel.getStatement();
		sel.select1();
		sel.getItem1();
		sel.getItem2();
		sel.getItem3();
		sel.closeStatement();
		
}catch(Exception e){
	out.print(e.toString());
	
}

%>
