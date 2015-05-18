
package fzAuthP;
import java.sql.*;
/**
 * 驗證EIP
 * 
 * @author cs71 at 2012/01/05
 */
public class CheckEIP 
{
	private boolean	passEIP;

	/**
	 * @throws NullPointerException
	 *             無帳號密碼（未Initial UserID)
	 * @throws AuthenticationFailedException
	 *             帳號密碼錯誤
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
            //判斷是否為FZTUIDG有設定之人員
            //如果輸入userid 為6位數字, 則使用全員信箱認證
            for(int j = 0; j < usid.length(); j++) 
            {
                char c = usid.charAt(j);
                if("0123456789".indexOf(c) >= 0)
                i++;
            }
          
            if( i == 6  )  // 輸入六位數字：1. 先判斷全員信箱ID & Password是否正確
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
            }//if( i == 6  )  // 輸入六位數字：1. 先判斷全員信箱ID & Password是否正確
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