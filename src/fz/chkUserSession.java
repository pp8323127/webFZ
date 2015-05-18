package fz;

import java.sql.*;

import ci.db.ConnectionHelper;


public class chkUserSession {

	/**
	 * @param args
	 */
	
	private String empno ="";
	private String nowSess ="";
	private String starTime = "";
	private String endTime = "";
	private String errorstr = "";
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		chkUserSession sess = new chkUserSession();
//		System.out.println(sess.setUserSess("643937"));
		System.out.println(sess.chkUserSess("643937", "001"));
		System.out.println("done");

	}	
	public chkUserSession() {
		
	}
	public String setUserSess(String empno){
		Connection conn = null;
		Statement stmt = null;
    	PreparedStatement pstmt = null;
    	ResultSet rs = null;	
        String sql = "";      
        String sess = "";
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();	
            stmt = conn.createStatement();  
            
            sql = " select trim(max(sessionid)) sess from fztuserss where empno = '"+empno+"'";
            
			rs = stmt.executeQuery(sql);
			String tempStr = "";
			if(rs.next()){
				//System.out.println(sess);
				tempStr = rs.getString("sess");
				if(tempStr != "" && tempStr != null){
					//if(tempStr.substring(6,9).equals("015")){
					if(tempStr.equals("9")){	
						sql = " delete fztuserss where empno = '"+empno+"'";
				        pstmt = conn.prepareStatement(sql);	
				        pstmt.execute();
				        conn.commit();
				        sess = "1";
					}else{
						sess = (Integer.parseInt(rs.getString("sess"))+1)+"";
					}
					
				}else{//¥¼µn¤J¹L
	                sess = "1";
	            }
			}
			rs.close();
			/*****************************************************/
			
            sql = " insert into fztuserss " +
            	  " (empno,sessionid,star_time) values " +
            	  " (?,?,sysdate) ";
            
            pstmt = conn.prepareStatement(sql);		
            pstmt.setString(1, empno);
            pstmt.setString(2, sess);
            //System.out.println(sess+sql);
            
            pstmt.execute();
            //System.out.println(pstmt.execute());
        }
        catch (Exception e)
        {
        	//System.out.println(" Ins session error: "+e.toString());
        	sess = " Error: "+e.toString();
        	try{
        		conn.rollback(); 
        	} 
        	catch (SQLException e1){ //System.out.print(e1.toString()); 
        		sess = " Error: "+ e1.toString();
        	}
        } 
        finally
        {
            try
            {
                if (rs != null)
                    rs.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (stmt != null)
                    stmt.close();
            }
            catch ( Exception e )
            {
            }
            
            try
            {
                if (conn != null)
                    conn.close();
            }
            catch ( Exception e )
            {
            }
        }
        return sess;
		
	}
	public boolean chkUserSess(String empno,String nowSess){
		Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        String sql = "";
        boolean effSession = false ;
        
        try
        {
            ConnectionHelper ch = new ConnectionHelper();
            conn = ch.getConnection();
            stmt = conn.createStatement();

            sql = " select max(sessionid) sess from fztuserss where empno = '"+empno+"'";
            rs = stmt.executeQuery(sql);
            
            if(rs.next())
            {
            	if(nowSess.equals(rs.getString("sess"))){
            		effSession = true;
            	}
            }           

        }
        catch ( Exception e )
        {
            System.out.println(e.toString());
            errorstr = e.toString();
        }
        finally
        {
            try
            {
                if (rs != null)
                    rs.close();
            }
            catch ( Exception e )
            {
            }
            try
            {
                if (stmt != null)
                    stmt.close();
            }
            catch ( Exception e )
            {
            }
            
            try
            {
                if (conn != null)
                    conn.close();
            }
            catch ( Exception e )
            {
            }
        }
        return effSession;
	}

}
