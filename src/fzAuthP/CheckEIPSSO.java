
package fzAuthP;
import java.sql.*;
/**
 * ����EIP
 * 
 * @author cs71 at 2012/01/05
 */
public class CheckEIPSSO 
{
	private boolean	passEIPSSO;

	/**
	 * @throws NullPointerException
	 *             �L�b���K�X�]��Initial UserID)
	 * @throws AuthenticationFailedException
	 *             �b���K�X���~
	 */
	 public static void main(String[] args) 
	 {
	     CheckEIPSSO ckEIPSSO = new CheckEIPSSO("640790","A123456","","");
	     System.out.println(ckEIPSSO.isPassEIPSSO());
	 }
	
	public CheckEIPSSO(String eip_key, String eip_empn, String hostip, String clientip) 
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
            for(int j = 0; j < eip_empn.length(); j++) 
            {
                char c = eip_empn.charAt(j);
                if("0123456789".indexOf(c) >= 0)
                i++;
            }
          
            if( i == 6  )  // ��J����Ʀr
            {  			        
			    Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver");
		        conn = DriverManager.getConnection("jdbc:microsoft:sqlserver://10.16.48.20:1433;DatabaseName=EIP_LOG", "hr_cs","cz6312cs");
				select = conn.prepareCall("{call UserSSOAuthorization_SSO_CS(?,?,?,?,?,?,?,?,?,?)}");
				select.setString(1, eip_key);
				select.setString(2, eip_empn);
				select.setString(3, hostip);
				select.setString(4, clientip);
				select.setTimestamp(5, new Timestamp((new java.util.Date()).getTime()));
				select.setInt(6, (int) (Math.random() * 10000));
				select.registerOutParameter(7, Types.VARCHAR);//result of EIP check -> Y or N 
				select.registerOutParameter(8, Types.TIMESTAMP);//timestamp of eip write in  
				select.registerOutParameter(9, Types.TIMESTAMP);//timestamp of ap call 
				select.registerOutParameter(10, Types.VARCHAR);//
				select.execute();
				
				String iCheck = select.getString(7);
				Timestamp isysWriteDatetime = select.getTimestamp(8);
				Timestamp isysCheckDatetime = select.getTimestamp(9);
				String iCheckOut = select.getString(10);

				if (!"Y".equalsIgnoreCase(iCheck)) 
				{
				    setPassEIPSSO(false);
				}
				
				if (isysWriteDatetime == null) 
				{
				    setPassEIPSSO(false);
				}
				
				if (isysCheckDatetime == null) 
				{
				    setPassEIPSSO(false);
				}

				int TMDiff = (int) ((isysCheckDatetime.getTime() - isysWriteDatetime.getTime()) / (1000));

				if ("Y".equalsIgnoreCase(iCheck) && TMDiff > 600) 
				{
				    setPassEIPSSO(false);
				}	
				
				//pass SSO Authorization
				if ("Y".equalsIgnoreCase(iCheck) && TMDiff <= 600) 
				{
				    setPassEIPSSO(true);
				}
            }//if( i == 6  )  // ��J����Ʀr�G1. ���P�_�����H�cID & Password�O�_���T
            else
            {
                setPassEIPSSO(false);    
            }
        }     
        catch(Exception e)
        {
             setPassEIPSSO(false);
        }
        finally
        {
        	if(rs!=null)try{rs.close();}catch(Exception e){}
            if(select!=null)try{select.close();}catch(Exception e){}
            if(conn!=null)try{conn.close();}catch(Exception e){}
        }
	}

	public boolean isPassEIPSSO() {
		return passEIPSSO;
	}

	public void setPassEIPSSO(boolean passEIPSSO) {
		this.passEIPSSO = passEIPSSO;
	}
}