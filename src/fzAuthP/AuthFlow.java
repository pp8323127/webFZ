package fzAuthP;

/**
 * �Z���T���A�������Ҭy�{�D�{��
 * 
 * @author cs66 at 2005/7/1
 * @version 1.1 2006/03/02
 * @author cs80 2015/01/05 EIP & FZT ac �ҥi�n�J
 */

public class AuthFlow 
{
        public static void main(String[] args) 
        {
            AuthFlow auth = new AuthFlow("643886", "999999");
            int key = auth.getAuthCase();
            System.out.println("�����P�_=" + key);
            switch (key) {
            case 11:
                System.out.println("PowerUser �n�J���\!!");
                break;
            case 12:
                System.out.println("Crew �n�J���\!!");
                FZCrewObj o = auth.getFzCrewObj();
                System.out.println(o.getCname() + "\t" + o.getEname() + "\t"
                        + o.getBase() + "\t" + o.getSess() + "\t" + o.getLocked()
                        + "\t" + o.getSern() + "\t" + o.getOccu());
    
                break;
            case 13:
                System.out.println("ED �n�J���\!!");
                break;
            case 14:
                System.out.println("Officer �n�J���\!!");
                break;
            case 15:
                System.out.println("ñ���Ȯɱb���n�J���\!!");
                break;
            case 2:
                System.out.println("�K�X���~!!");
                break;
            case 3:
                System.out.println("�K�X���~(ED or FZOfficer is via EIP authorization!! )");
                break;
            case 4:
                System.out.println("�L�b��");
                break;
            case 5:
                System.out.println("�ʤֱb���K�X");
                break;
            case 6:
                System.out.println("���Q���v");
                break;
            case 7:
                System.out.println("�n�J����");
                break;
            case 8:
                System.out.println("�Dñ���b���A���o�n�J");
                break;
            default:
                System.out.println("�n�J����!!");
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
            //		�]�w�b���K�X
            uid = new UserID(userid, password);
            
            //		�O�_��power user
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
                // �L�b���K�X
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
		                	//Crew�LEIP�b��
		                	//password error.
	                        authCase = 2;
		                }
		            }
		            /*check crew EIP*/
                } 
                else 
                {//Crew�Lfztuser�b��
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
            //FZ �B���줽��
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
                //ñ�����αb��
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
            { //���Q���v
                authCase = 6;
            }
        } 
        catch (NullPointerException e) 
        {
            //��initial UserID
            //out.println("�ʤֱb���K�X,�Э��s��J");
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
            //		�]�w�b���K�X
            uid = new UserID(eip_empn, password);
            
            //		�O�_��power user
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
                // �L�b���K�X
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
		                {//Crew�Lfztuser�b��
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
	                
		            
		            //FZ �B���줽��
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
		                //ñ�����αb��
		            } 
                }
                else 
	            { //���Q���v
	                authCase = 6;
	            }
            }
        } 
        catch (NullPointerException e) 
        {
            //��initial UserID
            //out.println("�ʤֱb���K�X,�Э��s��J");
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
     * @return authCase �������ҵ��G *
     *         <li>= 2 �K�X���~(�@��user��power user,�ϥ�fztuser�K�X��ƧP�_)
     *         <li>= 3 �K�X���~(ED��Officer,�ϥ�EIP����)
     *         <li>= 4 �L�b��(�t�e�B�῵�^
     *         <li>= 5 �ʤֱb���K�X(�ǻ����Ȧ����D)
     *         <li>= 6 not authorized
     *         <li>= 7 Other (Exception...)
     *         <li>= 8 Edtemp�n�J���~�A�Dñ���b��
     *         <li>= 11 �n�J���\ PowerUser
     *         <li>= 12 �n�J���\ Crew
     *         <li>= 13 �n�J���\ ED
     *         <li>= 14 �n�J���\ Officer
     *         <li>= 15 �n�J���\ ED Temp (for aero mail disconnect)         
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

