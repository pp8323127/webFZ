package fzAuthP;

/**
 * 班表資訊網，身份驗證流程主程式
 * 
 * @author cs66 at 2005/7/1
 * @version 1.1 2006/03/02
 * @author cs80 2015/01/05 EIP & FZT ac 皆可登入
 */

public class AuthFlow 
{
        public static void main(String[] args) 
        {
            AuthFlow auth = new AuthFlow("643886", "999999");
            int key = auth.getAuthCase();
            System.out.println("身份判斷=" + key);
            switch (key) {
            case 11:
                System.out.println("PowerUser 登入成功!!");
                break;
            case 12:
                System.out.println("Crew 登入成功!!");
                FZCrewObj o = auth.getFzCrewObj();
                System.out.println(o.getCname() + "\t" + o.getEname() + "\t"
                        + o.getBase() + "\t" + o.getSess() + "\t" + o.getLocked()
                        + "\t" + o.getSern() + "\t" + o.getOccu());
    
                break;
            case 13:
                System.out.println("ED 登入成功!!");
                break;
            case 14:
                System.out.println("Officer 登入成功!!");
                break;
            case 15:
                System.out.println("簽派暫時帳號登入成功!!");
                break;
            case 2:
                System.out.println("密碼錯誤!!");
                break;
            case 3:
                System.out.println("密碼錯誤(ED or FZOfficer is via EIP authorization!! )");
                break;
            case 4:
                System.out.println("無帳號");
                break;
            case 5:
                System.out.println("缺少帳號密碼");
                break;
            case 6:
                System.out.println("未被授權");
                break;
            case 7:
                System.out.println("登入失敗");
                break;
            case 8:
                System.out.println("非簽派帳號，不得登入");
                break;
            default:
                System.out.println("登入失敗!!");
                break;
            }
    
        }

    private String userid="";
    private String password="";
    private int authCase = 0;
    private boolean loginSuccess = false;
    private FZCrewObj fzCrewObj;
    private String eip_key = "";
    private String eip_empn = "";
    private String hostip = "";
    private String clientip = "";

    public AuthFlow(String userid, String password) 
    {
        this.userid = userid;
        this.password = password;
        setAuthCase();
    }

    private int setAuthCase() 
    {
        UserID uid;
        CheckPowerUser ck;
        CheckHR ckHR;
        CheckFZUser ckFZUsr;
        CheckAeroMail ckMail;
        CheckEIP ckEIP;
        CheckEG ckEG;
        CheckSkj ckSkj;
        CheckFZCrew ckCrew;
        try 
        {
            //		設定帳號密碼
            uid = new UserID(userid, password);
            
            //		是否為power user
            ck = new CheckPowerUser();

            //		check HR
            ckHR = new CheckHR();

            //		check fzuser
            ckFZUsr = new CheckFZUser();

            //		check aero mail
            ckMail = null;
            
            //		check eip
            ckEIP = null;

            //		check EG
            ckEG = null;

            //		check schedule
            ckSkj = null;

            //		check fzcrew
            ckCrew = new CheckFZCrew();

            if ( userid == null | password == null | "".equals(userid) | "".equals(password) ) 
            {
                // 無帳號密碼
                authCase = 5;             
            }
            //check Power User
            else if ( ck.isHasPowerUserAccount() ) 
            {                
                if ( ck.isPowerUser() ) 
                {
                    //login success
                    authCase = 11;
                    setLoginSuccess(true);
                } 
                else 
                {
                    //password error
                    authCase = 2;
                }
            }
            //Check Crew
            else if ( ckCrew.isFZCrew() ) 
            {
                if ( ckFZUsr.isHasFZAccount() ) 
                {
                    if ( ckFZUsr.isFZUser() ) 
                    {//login success
                        authCase = 12;
                        setLoginSuccess(true);
                        setFzCrewObj(ckCrew.getFzCrewObj());
                    } 
                    else 
                    {
                        //password error.
                        authCase = 2;
                    }
                    
                    /*check crew EIP*/
		            if(authCase != 12){
		            	ckEIP = new CheckEIP(userid,password);
		                if ( ckEIP.isPassEIP() ) 
		                {
			            	authCase = 12;
	                        setLoginSuccess(true);
	                        setFzCrewObj(ckCrew.getFzCrewObj());
		                }
		                else 
		                {
		                	//Crew無EIP帳號
		                	//password error.
	                        authCase = 2;
		                }
		            }
		            /*check crew EIP*/
                } 
                else 
                {//Crew無fztuser帳號
                    authCase = 4;
                }
            }

            //check ED
            else if ( ckHR.isED() ) 
            {
//                ckMail = new CheckAeroMail();
//                if ( ckMail.isPassAeroMail() ) {
//                    //login success
//                    authCase = 13;
//                    setLoginSuccess(true);
//                } else {
//                    //password error(aero)
//                    authCase = 3;
//                }
                
                ckEIP = new CheckEIP(userid,password);
                if ( ckEIP.isPassEIP() ) 
                {
                    //login success
                    authCase = 13;
                    setLoginSuccess(true);
                } 
                else 
                {
                    //password error(aero)
                    authCase = 3;
                }
            }
            //FZ 處長辦公室
            else if ( ckHR.isIs180A() ) 
            {
//                ckMail = new CheckAeroMail();
//                if ( ckMail.isPassAeroMail() ) 
//                {
//                    //login success
//                    authCase = 180;
//                    setLoginSuccess(true);
//                } 
//                else 
//                {
//                    //password error(aero)
//                    authCase = 3;
//                }
                
                ckEIP = new CheckEIP(userid,password);
                if ( ckEIP.isPassEIP() ) 
                {
                    //login success
                    authCase = 180;
                    setLoginSuccess(true);
                } 
                else 
                {
                    //password error(eip)
                    authCase = 3;
                }
            }

            //check officer
            else if ( ckHR.isFZOfficer() ) 
            {               
//                ckMail = new CheckAeroMail();
//                if ( ckMail.isPassAeroMail() ) 
//                {
//                    //if ("#1234#".equals(password)) {
//                    //login success
//                    authCase = 14;
//                    setLoginSuccess(true);
//                } 
//                else 
//                {
//                    //password error(aero)
//                    authCase = 3;
//                }
                
                ckEIP = new CheckEIP(userid,password);
                if ( ckEIP.isPassEIP() ) 
                {                   
                    //login success
                    authCase = 14;
                    setLoginSuccess(true);
                } 
                else 
                {
                    //password error(eip)
                    authCase = 3;
                }
                //簽派公用帳號
            } 
            else if ( "edtemp".equals(userid) ) 
            {
                UserID edTemp = new UserID(password, null);
                CheckHR edTempCheckHR = new CheckHR();
                if ( edTempCheckHR.isED() ) 
                { //login success
                    authCase = 15;
                    setLoginSuccess(true);
                } 
                else 
                {
                    authCase = 8;
                }
            }
            else 
            { //未被授權
                authCase = 6;
            }
        } 
        catch (NullPointerException e) 
        {
            //未initial UserID
            //out.println("缺少帳號密碼,請重新輸入");
            authCase = 5;
            System.out.println("Login NullPointerException :" + e.toString());
        } 
        catch (Exception e) 
        {
            authCase = 7;
            System.out.println("Login Exception :" + e.toString());
        }

        return authCase;
    }
    
    public AuthFlow(String eip_key, String eip_empn, String hostip, String clientip)
    {
        this.eip_key = eip_key;
        this.eip_empn = eip_empn;
        this.hostip = hostip;
        this.clientip = clientip;
        setAuthCaseSSO();
    }
    
    private int setAuthCaseSSO() 
    {
        UserID uid;
        CheckPowerUser ck;
        CheckHR ckHR;
        CheckFZUser ckFZUsr;
        CheckAeroMail ckMail;
        CheckEIP ckEIP;
        CheckEG ckEG;
        CheckSkj ckSkj;
        CheckFZCrew ckCrew;
        try 
        {
            //		設定帳號密碼
            uid = new UserID(eip_empn, password);
            
            //		是否為power user
            ck = new CheckPowerUser();

            //		check HR
            ckHR = new CheckHR();

            //		check fzuser
            ckFZUsr = new CheckFZUser();

            //		check aero mail
            ckMail = null;
            
            //		check eip
            ckEIP = null;

            //		check EG
            ckEG = null;

            //		check schedule
            ckSkj = null;

            //		check fzcrew
            ckCrew = new CheckFZCrew();

            if ( eip_key == null | "".equals(eip_key)) 
            {
                // 無帳號密碼
                authCase = 5;             
            }
            else
            {
                CheckEIPSSO ckEIPSSO = new CheckEIPSSO(eip_key, eip_empn, hostip, clientip) ;
                if(ckEIPSSO.isPassEIPSSO())
                {
		            //check Power User
		            if ( ck.isHasPowerUserAccount() ) 
		            { 
	                    //login success
	                    authCase = 11;
	                    setLoginSuccess(true);
		            }		            
		            
		            //Check Crew
		            if ( ckCrew.isFZCrew() ) 
		            {
		                if ( ckFZUsr.isHasFZAccount() ) 
		                {
		                    //login success
	                        authCase = 12;
	                        setLoginSuccess(true);
	                        setFzCrewObj(ckCrew.getFzCrewObj());		                    
		                } 
		                else 
		                {//Crew無fztuser帳號
		                    authCase = 4;
		                }
		            }
		
		            //check ED
		            if ( ckHR.isED() ) 
		            {
	                    //login success
	                    authCase = 13;
	                    setLoginSuccess(true);		                
		            } 
	                
		            
		            //FZ 處長辦公室
		            if ( ckHR.isIs180A() ) 
		            { 
	                    //login success
	                    authCase = 180;
	                    setLoginSuccess(true);
		            }
		
		            //check officer
		            if ( ckHR.isFZOfficer() ) 
		            {		                             
	                    //login success
	                    authCase = 14;
	                    setLoginSuccess(true);
		                //簽派公用帳號
		            } 
                }
                else 
	            { //未被授權
	                authCase = 6;
	            }
            }
        } 
        catch (NullPointerException e) 
        {
            //未initial UserID
            //out.println("缺少帳號密碼,請重新輸入");
            authCase = 5;
            System.out.println("Login NullPointerException :" + e.toString());
        } 
        catch (Exception e) 
        {
            authCase = 7;
            System.out.println("Login Exception :" + e.toString());
        }

        return authCase;
    }

    /**
     * @return authCase 身份驗證結果 *
     *         <li>= 2 密碼錯誤(一般user及power user,使用fztuser密碼資料判斷)
     *         <li>= 3 密碼錯誤(ED及Officer,使用EIP驗證)
     *         <li>= 4 無帳號(含前、後艙）
     *         <li>= 5 缺少帳號密碼(傳遞的值有問題)
     *         <li>= 6 not authorized
     *         <li>= 7 Other (Exception...)
     *         <li>= 8 Edtemp登入錯誤，非簽派帳號
     *         <li>= 11 登入成功 PowerUser
     *         <li>= 12 登入成功 Crew
     *         <li>= 13 登入成功 ED
     *         <li>= 14 登入成功 Officer
     *         <li>= 15 登入成功 ED Temp (for aero mail disconnect)         
     */
    public int getAuthCase() {
        return authCase;
    }

    public boolean isLoginSuccess() {
        return loginSuccess;
    }

    private void setLoginSuccess(boolean loginSuccess) {
        this.loginSuccess = loginSuccess;
    }

    public FZCrewObj getFzCrewObj() {
        return fzCrewObj;
    }

    private void setFzCrewObj(FZCrewObj fzCrewObj) {
        this.fzCrewObj = fzCrewObj;
    }  
    

}

