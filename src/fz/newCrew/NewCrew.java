package fz.newCrew;

import java.sql.*;
import java.util.*;
import ci.db.*;

/**
 * @author cs71 Created on  2006/10/12
 */
public class NewCrew
{
        public static void main(String[] args)
        {
            NewCrew g = new NewCrew();
            System.out.println(g.getNewCrew("290"));
            //System.out.println(g.isExist());
            //System.out.println(g.insDB());
            //System.out.println(g.updDB());
            System.out.println("Done");
            
        }

        private String sess 	= "";
    	private Connection conn = null;
    	private Driver dbDriver = null;
    	private Statement stmt = null;
    	private PreparedStatement pstmt = null;
    	private ResultSet rs = null; 
    	private String sql = "";
    	private ArrayList objAL = new ArrayList();
    	private String returnstr = "";

        public String getNewCrew(String sess)
        {
                try
                {
                    ConnDB cn = new ConnDB();  
                    
//                    cn.setORP3FZUser();
//                    java.lang.Class.forName(cn.getDriver());
//                    conn = DriverManager.getConnection(cn.getConnURL() ,cn.getConnID() ,
//                            cn.getConnPW());
//                    stmt = conn.createStatement();                    
                    
                    
            		cn.setORP3FZUserCP();
            		dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            		conn = dbDriver.connect(cn.getConnURL(), null);
            		stmt = conn.createStatement(); 
                    
                    sql = " SELECT Trim(empn) empno, sern, SECTION sess, cname, ename, 'B' cabin, " +
                    	  " Decode(sex,'F','FS','FA') occu, station base, Trim(empn)||'@cal.aero' email " +
                    	  " FROM egtcbas WHERE SECTION = '"+sess+"' AND status = '1'";
                    
					rs = stmt.executeQuery(sql);
        	
        			while (rs.next()) 
        			{        			    
                        NewCrewObj obj1 = new NewCrewObj();
                        obj1.setEmpno(rs.getString("empno"));
                        obj1.setSern(rs.getString("sern"));
                        obj1.setSess(rs.getString("sess"));
                        obj1.setCname(rs.getString("cname"));
                        obj1.setEname(rs.getString("ename"));
                        obj1.setCabin("B");
                        obj1.setOccu(rs.getString("occu"));
                        obj1.setBase(rs.getString("base"));
                        obj1.setEmail(rs.getString("email"));                        
    	                objAL.add(obj1); 
        			}
        			
        			if(objAL.size() > 0)
        			{
        			    //insert into fztcrew
        			    //**********************************************************************************
	        			sql = " insert into fztcrew (empno,box, sess, name, ename, cabin, occu, base, email, locked) " +
	        				  " values (?,?,?,?,?,?,?,?,?,'N') ";
	        		
	                    pstmt = conn.prepareStatement(sql);
	                     
	      	            int count =0;    
	        			for(int i=0; i < objAL.size(); i++)
	        			{
	        			    int j = 1;
	        			    NewCrewObj obj = (NewCrewObj)objAL.get(i);	  
	        			    
	        			    pstmt.setString(j, obj.getEmpno());
	     	                pstmt.setString(++j, obj.getSern());     
	     	                pstmt.setString(++j, obj.getSess());     
	     	                pstmt.setString(++j, obj.getCname());
	     	                pstmt.setString(++j, obj.getEname());
	     	                pstmt.setString(++j, obj.getCabin());
	     	                pstmt.setString(++j, obj.getOccu());
	     	                pstmt.setString(++j, obj.getBase());
	     	                pstmt.setString(++j, obj.getEmail());     
	     	                pstmt.addBatch();
	     	                
	     	                count++;
							if (count == 10)
							{
							     pstmt.executeBatch();
							     pstmt.clearBatch();
							     count = 0;
							}	        			
	        			}
	        			
	        			if (count > 0)
	        			{
	        			    pstmt.executeBatch();
	        			    pstmt.clearBatch();
	        			}  
	        			
	        			
	        			//insert into fztuser
	        			//***********************************************************************************
	        			sql = " insert into fztuser (userid, pwd) values (?,?)";
			            pstmt = conn.prepareStatement(sql);
			                   
			    	    count =0;    
		      			for(int i=0; i < objAL.size(); i++)
		      			{
		      			    int j = 1;
		      			    NewCrewObj obj = (NewCrewObj)objAL.get(i);	  
		      			    
		      			    pstmt.setString(j, obj.getEmpno());
		   	                pstmt.setString(++j, "999999");     
		   	                pstmt.addBatch();
		   	                
		   	                count++;
							if (count == 10)
							{
							     pstmt.executeBatch();
							     pstmt.clearBatch();
							     count = 0;
							}	        			
		      			}
		      			
		      			if (count > 0)
		      			{
		      			    pstmt.executeBatch();
		      			    pstmt.clearBatch();
		      			}  
	        			
	      				returnstr = "Y";
        			}
        			else
        			{
        			    returnstr = "N";
        			}
                }
                catch (Exception e)
                {
                    returnstr = e.toString();
                }
                finally
                {            
                	try{if(rs != null) rs.close();}catch(SQLException e){}
                	try{if(stmt != null) stmt.close();}catch(SQLException e){}
                	try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
                	try{if(conn != null) conn.close();}catch(SQLException e){}	
                }
                System.out.println(returnstr);
                return returnstr;
               
      }  
        
}
