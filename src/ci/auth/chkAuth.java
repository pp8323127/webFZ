/**@author cs66
 *  in Tsaweb02
 * �����{��
 * 1.��J�b��������Ʀr->���ҥ����H�c
 * 		1.1��H�Ƹ��
 * 		1.2��fzuidg���s�ջP�v��
 * 2.��J�b���D����Ʀr->����fzuidg
 * 		2.1��fzuidg���s�ջP�v��
 * */

package ci.auth;

import ci.db.*;
import java.sql.*;
import java.util.ArrayList;
import javax.mail.*;


public class chkAuth
{
    private Statement stmt = null;
    private ResultSet myResultSet = null;
    private Connection conn = null;
    private String rs = "0";
	private Store store = null;
    
    private String unitcd = "";
    private String postcd = "";
    private ArrayList gid = new ArrayList();
    private ArrayList authu = new ArrayList();
    private String cname = "";
    private String ename = "";
    private String authp = "";

    
    int xCount = 0;
    int i = 0;
    String sql = null;
        
/**
 * @return rs =0:���Ҧ��\<br>
 * 				rs!=0:���Ҥ����\�A��ܿ��~�T��
 * */    
    public String chkUser(String usid, String pwd)
    {
        try
        {
            //connect to ORP3 FZ
        ConnDB cdb = new ConnDB();	
	    cdb.setORP3FZUser();
	   
	    Class.forName(cdb.getDriver());
        conn = DriverManager.getConnection(cdb.getConnURL(),cdb.getConnID(),cdb.getConnPW());
	    
            stmt = conn.createStatement();
            
            //�P�_�O�_��FZTUIDG���]�w���H��
            //�p�G��Juserid ��6��Ʀr, �h�ϥΥ����H�c�{��
            for(int j = 0; j < usid.length(); j++) {
                char c = usid.charAt(j);
                if("0123456789".indexOf(c) >= 0)
                i++;
            }
          
            if( i == 6  )  // ��J����Ʀr�G1. ���P�_�����H�cID & Password�O�_���T
            {
                Session mailSession = Session.getInstance(System.getProperties(), null);
                // Get the store
                store = mailSession.getStore("imap");

//    	        store.connect("202.165.148.123", usid, pwd);
    	        store.connect("APmailimap.china-airlines.com", usid, pwd);
    	        store.close();
    	        

                //1.1����򥻸��:hrvegemploy(�H�Ƹ����)
                myResultSet = stmt.executeQuery("select * from hrvegemploy where employid='"+usid+"'");
                if(myResultSet.next())
                {
                    unitcd = myResultSet.getString("unitcd");
                    postcd = myResultSet.getString("postcd");
                    cname = myResultSet.getString("cname");
                    ename = myResultSet.getString("lname")+" "+myResultSet.getString("fname");
                }
                //1.2��FZTUIDG�������v��
                myResultSet.close();

				sql = "select nvl(username,' ') username, nvl(gid,' ')gid, nvl(authu,' ') authu "
						+ "from fztuidg where userid='" + usid + "'";
				
                myResultSet = stmt.executeQuery(sql);
                if(myResultSet!=null)
                {
                        while(myResultSet.next())
                        {
                            if(cname.equals("")) cname = myResultSet.getString("username").trim();
                            gid.add(myResultSet.getString("gid").trim());
                            authu.add(myResultSet.getString("authu").trim());
                            xCount++;
                        }
                }                
                
                
            } else { //2.�D����Ʀr�A�P�_FZTUIDG�����H��

				sql = "select nvl(username,' ') username, nvl(gid,' ')gid, nvl(authu,' ') authu "
						+ "from fztuidg where userid='"+ usid+ "' and password='" + pwd + "'";
                
				
				myResultSet = stmt.executeQuery(sql);
                if(myResultSet!=null)
                {
                        while(myResultSet.next())
                        {
                            if(cname.equals("")) cname = myResultSet.getString("username").trim();
                            gid.add(myResultSet.getString("gid").trim());
                            authu.add(myResultSet.getString("authu").trim());
                            xCount++;
                        }
                }                
                if(xCount ==0){
                	rs = "Please check your ID or Password !";
                }
				
			}

        }catch(AuthenticationFailedException afe)
        {
                rs = "Please check your ID or Password !";
        }catch(Exception e){
                rs = "Error : "+e.toString();  
        }
        finally
        {
        	if(myResultSet!=null)try{myResultSet.close();}catch(Exception e){}
            if(stmt!=null)try{stmt.close();}catch(Exception e){}
            if(conn!=null)try{conn.close();}catch(Exception e){}
			if (store.isConnected()) 
			try {store.close();} 
			catch (MessagingException e) {e.printStackTrace();}
        }
        return rs;
    }
    public String getAuthp(String pageid, String usid)
    {
        try{
            //connect to ORP3 FZ
            ConnDB cdb = new ConnDB();	
	    cdb.setORP3FZUser();
	    Class.forName(cdb.getDriver());
        conn = DriverManager.getConnection(cdb.getConnURL(),cdb.getConnID(),cdb.getConnPW());
            stmt = conn.createStatement();
            //�P�_�惡���O�_���s���v��
            myResultSet = stmt
					.executeQuery("select p.authp authp from fztpidg p, fztuidg u where p.gid=u.gid and u.userid='"
							+ usid + "' and p.pageid=upper('" + pageid + "')"); 
            if(myResultSet.next())
            {
                authp = myResultSet.getString("authp");
            }
        }catch(Exception e){
                rs = "Error : "+e.toString();  
        }
        finally
        {
                if(stmt!=null)try{stmt.close();}catch(Exception e){}
                if(conn!=null)try{conn.close();}catch(Exception e){}
        }
        return authp;
    }
    public String getCname(){return cname;}
    public String getEname(){return ename;}
    public ArrayList getGid(){return gid;}
    public ArrayList getAuthu(){return authu;}
    public String getUnitcd(){return unitcd;}
    public String getPostcd(){return postcd;}
    
    public static void main(String args []) 
    {
        chkAuth ca = new chkAuth();
        ArrayList gd = new ArrayList();
        ArrayList au = new ArrayList();
        String rr = ca.chkUser("cs66","12324");
        System.out.println(rr);
        System.out.println("CNAME="+ca.getCname());
        System.out.println("ENAME="+ca.getEname());
        gd = ca.getGid();
        au = ca.getAuthu();
        System.out.println("Group\tAuth");
        for(int i=0;i<gd.size();i++)
        {
                System.out.println((String)gd.get(i)+"\t"+(String)au.get(i));
                
        }
        System.out.println("UnitCD="+ca.getUnitcd());
        System.out.println("PostCD="+ca.getPostcd());
        System.out.println(ca.getAuthp("p001","638716"));
        gd.clear();
        au.clear();
    }
}