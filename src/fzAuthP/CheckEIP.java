
package fzAuthP;
import java.sql.*;
/**
 * ����EIP
 * 
 * @author cs71 at 2012/01/05
 */
public class CheckEIP 
{
	private boolean	passEIP;

	/**
	 * @throws NullPointerException
	 *             �L�b���K�X�]��Initial UserID)
	 * @throws AuthenticationFailedException
	 *             �b���K�X���~
	 */
	 public static void main(String[] args) 
	 {
	     CheckEIP ckEIP = new CheckEIP("640790","A123456");
	     System.out.println(ckEIP.isPassEIP());
	 }
	
	public CheckEIP(String usid, String pwd) 
	{
		Connection conn = null;
		ResultSet rs = null;	
	    CallableStatement select = null;
        int xCount = 0;
        int i = 0;
        String sql = null;
        
        try
        {
            //�P�_�O�_��FZTUIDG���]�w���H��
            //�p�G��Juserid ��6��Ʀr, �h�ϥΥ����H�c�{��
            for(int j = 0; j < usid.length(); j++) 
            {
                char c = usid.charAt(j);
                if("0123456789".indexOf(c) >= 0)
                i++;
            }
          
            if( i == 6  )  // ��J����Ʀr�G1. ���P�_�����H�cID & Password�O�_���T
            {
			    Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver");
		        conn = DriverManager.getConnection("jdbc:microsoft:sqlserver://10.16.48.20:1433;DatabaseName=EIP_IP", "hr_cs_ecrews","cs4588ecrews");
				select = conn.prepareCall("{call UserAuthorization(?,?)}");
				select.setString(1, usid);
				select.setString(2, pwd);
				rs = select.executeQuery();

				if (rs.next()) 
				{	
					if ("1".equalsIgnoreCase(rs.getString(1))) 
					{
					    setPassEIP(true);
					}
					else
					{
					    setPassEIP(false);
					}
				}
				else
				{
				    setPassEIP(false);
				}			    
            }//if( i == 6  )  // ��J����Ʀr�G1. ���P�_�����H�cID & Password�O�_���T
        }     
        catch(Exception e)
        {
             setPassEIP(false);
             System.out.println("eip login err : "+e.toString());
        }
        finally
        {
        	if(rs!=null)try{rs.close();}catch(Exception e){}
            if(select!=null)try{select.close();}catch(Exception e){}
            if(conn!=null)try{conn.close();}catch(Exception e){}
        }
	}	
	
	public boolean isPassEIP() {
		return passEIP;
	}

	public void setPassEIP(boolean passEIP) {
		this.passEIP = passEIP;
	}
}