package eg;

import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;
import java.sql.*;
import ci.db.ConnDB;

public class Apply_Mail {
    private Connection con = null;
    private Driver dbDriver = null;
    private PreparedStatement pstmt = null;

    /*public static void main (String arg[])
    {
        try{
        //***************************
        }catch(Exception e){System.out.println(e.toString());}
    }*/
    public String sendApply(String[] empno, String[] dept, String[] email, String mcomm, String yearsern, String userid, String flag, String formno){
    
    	String sql = "";
    	
        try{
        //connect ORP3 EGDB
        ConnDB cn = new ConnDB();
	cn.setORP3EGUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	con = dbDriver.connect(cn.getConnURL(), null);
	//R:主管 M:改分
	if("R".equals(flag)){
		sql = "update egtreply set mempno='"+empno[0]+"' " +
		"where formno='"+formno+"'";
	}
	else if("M".equals(flag)){
		sql = "update egtreply set empno='"+empno[0]+"' " +
		"where formno='"+formno+"'";
	}
	else{
		//寄出客艙動態待處理通知(mail)並記錄處理記錄(egtreply)
		sql = "insert into egtreply(formno, yearsern, dept, empno, closed, sendempno, senddate) " +
		"values(egqformno.nextval,?,?,?,?,?,sysdate)"; 
	}
	pstmt = con.prepareStatement(sql); 
	
        //connect
        Properties props = new Properties();
        props.put("mail.smtp.host", "192.168.2.3");
        //**************
        Session mailSession = Session.getInstance(props,null);
        MimeMessage msg = new MimeMessage(mailSession);
        msg.setFrom(new InternetAddress(userid + "@cal.aero"));//send user empno
        //msg.setSubject("客艙動態待處理通知");
        msg.setSubject("Handling Flt Irregularity");
	
	for(int i=0; i < empno.length; i++){
	        msg.setRecipient(Message.RecipientType.TO,new InternetAddress(email[i]));
	        msg.setContent(mcomm, "text/plain; charset=big5");
	        Transport.send(msg);
		
		if(!"R".equals(flag) && !"M".equals(flag)){
		        pstmt.setString(1, yearsern);
		        pstmt.setString(2, dept[i]);
		        pstmt.setString(3, empno[i]);
		        pstmt.setString(4, "N");
		        pstmt.setString(5, userid);
		        pstmt.addBatch(); 
	        }
        }
        msg = null;
        if("R".equals(flag) || "M".equals(flag)){
        	pstmt.execute(); 
        }
        else{
        	pstmt.executeBatch();
        }
        //end update
                
        return "0";    
         
        } catch(Exception e) {
        	return "Apply_Mail.java " + e.toString();
        }
        finally
        { 
        	try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
		try{if(con != null) con.close();}catch(SQLException e){}
        }
    }
}