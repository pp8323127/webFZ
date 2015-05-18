package ws;

import java.sql.*;

import ci.db.*;
import fzac.CrewInfo;
import fzac.CrewInfoObj;

public class test {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
//	    ResultSet rs = null;
//        Statement stmt  = null;   
//        Driver dbDriver = null;
//        Connection  conn    = null;
//        String sql = "";
//        
//        try {           
//            
//          ConnectionHelper ch = new ConnectionHelper();
//          conn = ch.getConnection();             
//            stmt = conn.createStatement();   
//            
//            sql = "select * from crew_v where staff_num = '633020'" ;
//                       
//           System.out.println(sql);
//             rs = stmt.executeQuery(sql);       
//             if(rs!= null){
//                while (rs.next()){ 
//                  System.out.println(rs.getString("staff_num")) ;
//                }//while
//             }//if
//                        
//        } catch (Exception e) {
//            System.out.println( e.toString()+sql);
////          rosterAssign = e.toString();    
//        } finally {
//            if ( rs != null )   try { rs.close();}    catch (SQLException e) {}
//            if ( stmt != null ) try { stmt.close();}  catch (SQLException e) {}
//            if ( conn != null ) try { conn.close(); } catch (SQLException e) {}
//        }//try
	    String content = "?";
	    char ch1 = 57344;
	    System.out.println(ch1);
	    for (int i = 0; i < content.length(); i++) {
	          char ch = content.charAt(i);
	          
	          System.out.println(ch);
	          if ((ch == '\t') || (ch == '\n') || (ch == '\r') || 
	            ((ch >= ' ') && (ch <= 55295)) || 
	            ((ch >= 57344) && (ch <= 65533)) || (
	            (ch >= 65536) && (ch <= 1114111))) {
	            
	          }
	        }
	}
//	public CrewInfoObj isCrewInfo(String userid){
	    
        
        
//		CrewInfo c = new CrewInfo(userid);
//		CrewInfoObj obj = null;
//		if (c.isHasData()) {
//
//			obj = c.getCrewInfo();
//		}
//		return obj;
//	}
	

    public static String wrapXmlContent(String content)
    {
      StringBuffer appender = new StringBuffer("");
     
      if ((content != null) && (!content.trim().isEmpty())) {
        appender = new StringBuffer(content.length());
     
        for (int i = 0; i < content.length(); i++) {
          char ch = content.charAt(i);
          if ((ch == '\t') || (ch == '\n') || (ch == '\r') || 
            ((ch >= ' ') && (ch <= 55295)) || 
            ((ch >= 57344) && (ch <= 65533)) || (
            (ch >= 65536) && (ch <= 1114111))) {
            appender.append(ch);
          }
        }
      }
      String result = appender.toString();
     
      return "<![CDATA[" + result.replaceAll("]]>", "]]<") + "]]>";
    }

}
