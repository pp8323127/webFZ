package ws.crew;

import fzAuthP.CheckEIP;
import fzAuthP.CheckFZCrew;
import fzAuthP.CheckFZUser;
import fzAuthP.CheckHR;
import fzAuthP.UserID;

public class CrewLogin {

	/**
	 * @param args
	 */
	LoginAppBObj auth = null;
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}
	public void LoginiCrew(String userid, String password) {
		auth = new LoginAppBObj();// xml return
        UserID uid;
        CheckHR ckHR;
        CheckFZUser ckFZUsr;
        CheckEIP ckEIP;
        CheckFZCrew ckCrew;
        /****************/
        // �]�w�b���K�X
        try
        {
            // DESede d = new DESede();
            // password = d.decryptProperty("password");

            // �]�w�b���K�X
            uid = new UserID(userid, password);

            // check HR
            ckHR = new CheckHR();
            // auth.setHrObj(ckHR.getHrObj()); //�v�����--�ȵ���

            // check fzuser
            ckFZUsr = new CheckFZUser();

            // check eip
            ckEIP = null;

            // check fzcrew
            ckCrew = new CheckFZCrew();

            // �L�b���K�X
            if (userid == null | password == null | "".equals(userid)
                    | "".equals(password))
            {
                auth.setCode("2");
                auth.setResult(false);
                auth.setMessage("NO ID or PW");
            }
            // Check Crew
            else if (ckCrew.isFZCrew())
            {
                if (ckFZUsr.isHasFZAccount())
                {
                    if (ckFZUsr.isFZUser())
                    {
                        // login success
                        auth.setCode("1");
                        auth.setResult(true);
                        auth.setMessage("Crew Login Successful");
                        // setFzCrewObj(ckCrew.getFzCrewObj());
                    }
                    else
                    {
                        // password error.
                        auth.setCode("2");
                        auth.setResult(false);
                        auth.setMessage("password error.");
                    }
                }
                else
                {// Crew�Lfztuser�b��
                    auth.setCode("3");
                    auth.setResult(false);
                    auth.setMessage("ID not find");
                }
                // Eip & FZT �ҥi�n�J
                if (!"1".equals(auth.getCode()))
                {
                    if ("Y".equals(ckHR.getHrObj().getExstflg()))
                    {
                        ckEIP = new CheckEIP(userid, password);
                        if (ckEIP.isPassEIP())
                        {
                            // login success
                            auth.setCode("7");
                            auth.setResult(true);
                            auth.setMessage("EIP Login Successful");
                        }
                        else
                        {
                            // password error(eip)
                            auth.setCode("8");
                            auth.setResult(false);
                            auth.setMessage("password error.");
                        }
                    }
                    else
                    {
                        auth.setCode("9");
                        auth.setResult(false);
                        auth.setMessage("Not find data of HR.");
                    }
                }
            }
            // Eip�b¾,���D�῵�խ�
            else if ("Y".equals(ckHR.getHrObj().getExstflg())
                    && !"200".equals(ckHR.getHrObj().getAnalysa()))
            {
                ckEIP = new CheckEIP(userid, password);
                if (ckEIP.isPassEIP())
                {
                    // login success
                    auth.setCode("4");
                    auth.setResult(true);
                    auth.setMessage("EIP Login Successful");
                }
                else
                {
                    // password error(eip)
                    auth.setCode("5");
                    auth.setResult(false);
                    auth.setMessage("EIP password error");
                }
            }
            else
            {
                auth.setCode("6");
                auth.setResult(false);
                auth.setMessage("Not find data of HR.");
            }
            if ("1".equals(auth.getCode()) || "7".equals(auth.getCode()))
            {
                auth.setFzCrewObj(ckCrew.getFzCrewObj());

                // auth.setBase(ckCrew.getFzCrewObj().getBase());
                // auth.setCname(ckCrew.getFzCrewObj().getCname());
                // auth.setEmployid(ckCrew.getFzCrewObj().getEmpno());
                // auth.setEname(ckCrew.getFzCrewObj().getEname());
            }
        }
        catch ( NullPointerException e )
        {
            // ��initial UserID
            // out.println("�ʤֱb���K�X,�Э��s��J");
            auth.setCode("0");
            auth.setResult(false);
            auth.setMessage("Login NullPointerException :" + e.toString());
            // System.out.println("Login NullPointerException :" +
            // e.toString());
        }
        catch ( Exception e )
        {
            auth.setCode("0");
            auth.setResult(false);
            auth.setMessage("Login Exception :" + e.toString());
            // System.out.println("Login Exception :" + e.toString());
        }
		
	}
	public LoginAppBObj getAuth() {
		return auth;
	}
	public void setAuth(LoginAppBObj auth) {
		this.auth = auth;
	}
	
}
