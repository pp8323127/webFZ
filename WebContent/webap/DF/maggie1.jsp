<html>

 <head>
  <meta http-equiv="Content-Type" content="text/html; charset=big5">
  <meta http-equiv="Content-Language" content="Zh_TW">
  <title>���o��Ʈw������T</title>
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
     out.println("�L�k���J�X�ʵ{���I");
     e.printStackTrace();
   }
 
   try {
     Connection DBcon = dbDriver.connect("jdbc:weblogic:pool:CAL.DFCP01", null);
     if(!DBcon.isClosed())
       out.println("���\�a�s���ܸ�Ʈw�I<BR>");

     DatabaseMetaData DBMsg = DBcon.getMetaData();
     
     out.println("��Ʈw�W�١G");
     out.println(DBMsg.getDatabaseProductName() + "&nbsp;");
     out.println("�����G");
     out.println(DBMsg.getDatabaseProductVersion() + "<BR>");

     out.println("JDBC�W�١G");
     out.println(DBMsg.getDriverName() + "&nbsp;");
     out.println("�����G");
     out.println(DBMsg.getDriverVersion() + "<BR>");

     out.println("��Ʈw��}�G");
     out.println(DBMsg.getURL() + "&nbsp;");
     out.println("�b���G");
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
     out.println("<BR>�L�k�s���ܸ�Ʈw�I");
     SQLe.printStackTrace();
   }

 %>

 </center>
 </body>
 
</html>
