<html>

 <head>
  <meta http-equiv="Content-Type" content="text/html; charset=big5">
  <meta http-equiv="Content-Language" content="Zh_TW">
  <title>取得資料庫相關資訊</title>
 </head>

 <body>
 <center>
 <%@ page language = "java" %>
 <%@ page contentType = "text/html;charset=Big5" %>
 <%@ page import = "java.io.*, java.sql.*, javax.servlet.*, javax.servlet.http.*, java.util.Properties, weblogic.db.jdbc.*" %>

 <%!
   Statement stmt = null;
   ResultSet rs = null;
 %>

 <%
   Driver dbDriver = null;
   try {
     dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
   } catch(Exception e) {
     out.println("無法載入驅動程式！");
     e.printStackTrace();
   }
 
   try {
     Connection DBcon = dbDriver.connect("jdbc:weblogic:pool:CAL.DFCP01", null);
     if(!DBcon.isClosed())
       out.println("成功地連結至資料庫！<BR>");

     DatabaseMetaData DBMsg = DBcon.getMetaData();
     
     out.println("資料庫名稱：");
     out.println(DBMsg.getDatabaseProductName() + "&nbsp;");
     out.println("版本：");
     out.println(DBMsg.getDatabaseProductVersion() + "<BR>");

     out.println("JDBC名稱：");
     out.println(DBMsg.getDriverName() + "&nbsp;");
     out.println("版本：");
     out.println(DBMsg.getDriverVersion() + "<BR>");

     out.println("資料庫位址：");
     out.println(DBMsg.getURL() + "&nbsp;");
     out.println("帳號：");
     out.println(DBMsg.getUserName() + "<BR></CENTER>");

     stmt = DBcon.createStatement();

     try {
       rs = stmt.executeQuery("select * from fleet_t order by 1");
       %>
       <TABLE BORDER=1 cellspacing=0><TR valign=top><TD>
       <%
       out.println("<P>Testing retrieve fleet_t :<P>");
       while (rs.next()) {
          %>
          <li><%= rs.getString(1)%>&nbsp;<%= rs.getString(2)%>
          <%
        }
       rs = stmt.executeQuery("select * from fleet_t order by 1");
       %>
       </TD>
       </TR></TABLE>
       <%
     } catch(Exception e) {
       out.println("<P>RETRIEVE ERROR !<P>");
       e.printStackTrace();
     }

     DBcon.close();
   } catch(SQLException SQLe) {
     out.println("<BR>無法連結至資料庫！");
     SQLe.printStackTrace();
   }

 %>

 </center>
 </body>
 
</html>
