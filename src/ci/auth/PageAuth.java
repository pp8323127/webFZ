package ci.auth;

import java.sql.*;
import java.util.*;
import ci.db.*;
import ci.tool.*;


/**
 * DZPageAuth �ˬd�ϥΪ̹�page���ϥ��v��
 * 
 * @author cs66
 * @version 1.0 2005/9/26
 * modify by cs71
 * 
 * Copyright: Copyright (c) 2005
 */

public class PageAuth 
{
    
    public static void main(String[] args) 
    {

        //PageAuth dzp = new PageAuth("640073", "190A", "DFFLOG100");
        //PageAuth dzp = new PageAuth("640790", "196", "FZCIIKB001");
        PageAuth dzp = new PageAuth("626767", "0521", "OZDZ71002");

        System.out.println("�O�_���v���G" + dzp.isPrivilege());
        if ( dzp.isPrivilege() ) 
        {
            System.out.println("�ϥ��v�����G" + dzp.getAuthorization());
        }

    }

    private boolean privilege = false;//�O�_���v��,�w�]��false
    private String authorization;//�v��, SIUD
    private String pageID;
    private String unitCD;//Unitcd Code in HR
    private String empno;//user���u��

    /**
     * @param empno ���u��
     * @param unitCD unit code in HR
     * @param pageID �{���N�X
     */
    public PageAuth(String empno, String unitCD, String pageID) 
    {
        this.empno = empno;
        this.unitCD = unitCD;
        this.pageID = pageID;
        InitData();
    }

    public void InitData() 
    {
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        Driver dbDriver = null;
        String sql = null;
        ConnDB cn = new ConnDB();
        
        String gid = null;
        String authu = null;
        String authp = null;
        String unitcd = null;
        ArrayList authuAL = new ArrayList();
        ArrayList authAL = new ArrayList();
        int rdCount = 0;       
       

        try {
            cn.setORP3FZUser();
            java.lang.Class.forName(cn.getDriver());
            conn = DriverManager.getConnection(cn.getConnURL() ,cn.getConnID() ,
                    cn.getConnPW());
            
            //cn.setDZUserCP();
			//dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
			//conn = dbDriver.connect(cn.getConnURL(), null);

            stmt = conn.createStatement();
            sql = "select * from fztpidg where pageid='"+ pageID + "'";
            rs = stmt.executeQuery(sql);
            
            while (rs.next()) 
            {
                gid = rs.getString("gid");
                authp = rs.getString("authp");
                unitcd = rs.getString("unicd");
            }
            
            //��unitcd�v��
            //if ( unitcd != null && unitCD.indexOf(unitcd) != -1 ) 
            if ( unitcd != null && !"".equals(unitCD) && unitcd.indexOf(unitCD) != -1 )  
            {
                authAL.add(authp);
                setPrivilege(true);
            }

            if ( gid != null ) 
            {//��page�ϥ�gid�����v��
                //modify by betty
                ReplaceAllFor1_3 r = new ReplaceAllFor1_3();                 
                gid = r.replace(gid,",","','");
                //System.out.println(gid);
                sql = " select * from fztuidg where gid in ('"+ gid + "') " +
                	  " and userid='" + empno + "'"; 
                
                //System.out.println(sql);           
                //sql = " select * from fztuidg where gid='"+ gid + "' " +
                //	  " and userid='" + empno + "'"; 
                
                rs = stmt.executeQuery(sql);
                //System.out.println(sql);
                
                while (rs.next()) 
                {
                    authuAL.add(rs.getString("authu"));
                    authAL.add(rs.getString("authu"));
                }

                //if ( authu != null ) 
                if(authuAL.size() > 0)
                {
                    setPrivilege(true);
                }
            }

            //���v��
            if ( privilege == true) 
            {
                /***************************************************************
                 * �v�����զX��S,IUD,SIUD,���̤j���զX
                 **************************************************************/
                String auth = "S";
                
                for(int i = 0 ; i<authAL.size(); i++)
                {
                    if("SIUD".equals((String)authAL.get(i)))
                    {
                        auth = "SIUD";
                    }                
                }
                
                setAuthorization(auth);
                
                /*
                int authPLen =0;
                if(authp != null)
                {
                    authPLen = authp.length();
                }
                int authULen = 0;
                //if ( authp != null && authu != null )
                if ( authp != null && authuAL.size() > 0 )                
                {//unitcd�Pgid�����v��                    
                    for(int i=0; i<authuAL.size(); i++)
                    {
                        if(authULen < authuAL.get(i).toString().length())
                        {
                            authULen = authuAL.get(i).toString().length();
                        }                        
                    }                    
                    //int authULen = authu.length();
                    
                    if ( Math.max(authPLen ,authULen) == 4 ) 
                    {
                        setAuthorization("SIUD");
                    } 
                    else 
                    {
                        setAuthorization("S");
                    }
                } 
                else if ( authp != null ) 
                {//��unitcd���v��
                    setAuthorization(authp);
                } 
                //else if ( authu != null ) 
                else if ( authuAL.size() > 0 ) 
                {//��gid���v��
                    if(authULen==4)
                    {
                        setAuthorization("SIUD");
                    }
                    else
                    {
                        setAuthorization("S");
                    }
                    //setAuthorization(authu);
                }*/
            }
        } 
        catch (Exception e) 
        {
            System.out.println("PageAuth error :" + e.toString());
        } 
        finally 
        {
            if ( rs != null ) try {rs.close();} catch (SQLException e) {}       
            if ( stmt != null ) try {stmt.close();} catch (SQLException e) {}
            if ( conn != null ) try {conn.close();} catch (SQLException e) {}
        }
    }

    public String getAuthorization() 
    {
        return authorization;
    }

    public void setAuthorization(String auth) 
    {
        this.authorization = auth;
    }

    public boolean isPrivilege() 
    {
        return privilege;
    }

    public void setPrivilege(boolean privilege) 
    {
        this.privilege = privilege;
    }
}