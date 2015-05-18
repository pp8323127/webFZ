package fzAuthP;

import java.sql.*;
import ci.db.*;

/**
 * ���ҤH�Ƹ�� <br>
 * DB:Connection pool
 * 
 * @author cs66 at 2005/6/29
 * @version 1.1 2006/03/01
 */
public class CheckHR 
{
    private ConnDB cn;;
    private Connection conn;
    private Statement stmt;
    private String sql = null;
    private Driver dbDriver = null;
    private ResultSet rs;
    private HRObj hrObj;
    private boolean isHR; //���H�O���
    private boolean isDutyEmp; //�b¾���u
    private boolean isCrew; //�O�խ�
    private boolean isFZOfficer; //���v���ϥίZ������줽�ǤH��
    private boolean isCockpit; //���e���խ�
    private boolean isCabin; //���῵�խ�
    private boolean isCrewBefore; //�O�_�����խ�,�Ω�{�b�D�խ��A��¾�Ŭ��խ���
    private boolean isED; //�O�_��ñ���H��
    private boolean is180A = false; //�O�_���ŪA�B�B�줽��
    
    public CheckHR() 
    {
        cn = new ConnDB();
//        cn.setORP3FZUser();
        cn.setORP3FZUserCP();
        RetrieveData();
    }

    public void RetrieveData() throws NullPointerException 
    {
        try 
        {
//				java.lang.Class.forName(cn.getDriver());
//				conn = DriverManager.getConnection(cn.getConnURL(),cn.getConnID(),cn.getConnPW());
				
            dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
            conn = dbDriver.connect(cn.getConnURL() ,null);

            stmt = conn.createStatement();
            sql = "select * from hrvegemploy where employid='"+ UserID.getUserid() + "'";
            rs = stmt.executeQuery(sql);
//System.out.println(sql);
            while (rs.next()) 
            {
                hrObj = new HRObj();
                hrObj.setEmployid(rs.getString("employid"));
                hrObj.setCname(rs.getString("cname"));
                hrObj.setExstflg(rs.getString("exstflg"));
                hrObj.setUnitcd(rs.getString("unitcd"));
                hrObj.setAnalysa(rs.getString("analysa"));
                hrObj.setPostlvl(rs.getString("postlvl"));
                hrObj.setPostcd(rs.getString("postcd"));

                setHrObj(hrObj);
            }

            if ( null == hrObj ) 
            {
                setNoHR();
            } 
            else 
            {
                setHR(true);

                //					�ˬd�O�_�b¾
                if ( "Y".equals(hrObj.getExstflg()) ) 
                {
                    setDutyEmp(true);
                } 
                else 
                {
                    setDutyEmp(false);
                }
                //���ҬO�_��ñ���H��
                if ( "190A".equals(hrObj.getUnitcd()) ) 
                {
                    setED(true);
                } 
                else 
                {
                    setED(false);                    
                }
                
                //���ҬO�_��FZ�B���줽��
                if ( "180A".equals(hrObj.getUnitcd()) ) 
                {
                    setIs180A(true);
                    
                }
                else
                {
                    setIs180A(false);
                }

                //				���ҬO�_�����v���ϥίZ���T�����줽�ǤH��
                //				����A�ϥ�analysa=100 or 200�P�_�O�_���խ�
                //				�~���ϥ�post�P�_
                if ( "05".equals(hrObj.getUnitcd().substring(0 ,2))
                        | "06".equals(hrObj.getUnitcd().substring(0 ,2))
                        | "18".equals(hrObj.getUnitcd().substring(0 ,2))
                        | "19".equals(hrObj.getUnitcd().substring(0 ,2)) ) 
                {
                    if ( "100".equals(hrObj.getAnalysa()) | "200".equals(hrObj.getAnalysa()) ) 
                    {
                        //						�ư��խ�
                        setFZOfficer(false);
                    } 
                    else 
                    {
                        setFZOfficer(true);
                    }

                } 
                else if ( "635".equals(hrObj.getUnitcd())
                        | "850".equals(hrObj.getUnitcd()) | "8501".equals(hrObj.getUnitcd()) | "8508".equals(hrObj.getUnitcd()) 
                        | "837".equals(hrObj.getUnitcd())
                        | "811".equals(hrObj.getUnitcd())
                        | "827".equals(hrObj.getUnitcd()) | "790A".equals(hrObj.getUnitcd()) ) 
                { //�~��EM
                    if ( "292".equals(hrObj.getPostcd().substring(0 ,2)) ) {
                        setFZOfficer(false);//�~���խ�
                    } else {
                        setFZOfficer(true);
                    }

                } 
                else 
                {
                    setFZOfficer(false);
                }

                //		���ҬO�_���e���խ�
                if ( "100".equals(hrObj.getAnalysa()) ) { //�e��
                    setCrew(true);
                    setCockpit(true);
                    setCabin(false);
                } else if ( "200".equals(hrObj.getAnalysa()) ) {//�῵
                    setCrew(true);
                    setCockpit(false);
                    setCabin(true);
                } else if ( "635".equals(hrObj.getUnitcd()) //�~��
                        | "850".equals(hrObj.getUnitcd()) | "8508".equals(hrObj.getUnitcd()) 
                        | "837".equals(hrObj.getUnitcd())
                        | "811".equals(hrObj.getUnitcd())
                        | "827".equals(hrObj.getUnitcd()) | "790A".equals(hrObj.getUnitcd()) ) {

                    if ( "292".equals(hrObj.getPostcd().substring(0 ,2)) ) {
                        setCrew(true);//�~���խ�
                    } else {
                        setCrew(false);

                    }
                }

                //			�P�_�O�_�����խ�
                int iPostlvl = 0;
                try {
                    iPostlvl = Integer.parseInt(hrObj.getPostlvl());
                    setCrewBefore(false);
                } catch (NumberFormatException e) {
                    //					Postlv ���O�Ʀr�A�h���խ�
                    setCrewBefore(true);
                }
            }
        } 
        catch (ClassNotFoundException e) 
        {
            System.out.println(e.toString());
        } 
        catch (SQLException e) 
        {
            System.out.println(e.toString());
        } 
        catch (Exception e) 
        {
            System.out.println(e.toString());
        } 
//        catch (InstantiationException e) 
//        {
//            System.out.println(e.toString());
//        } 
//        catch (IllegalAccessException e) 
//        {
//            System.out.println(e.toString());
//        } 
        finally 
        {
            if ( rs != null ) try {
                rs.close();
            } catch (SQLException e) {
                System.out.println(e.toString());
            }
            if ( stmt != null ) try {
                stmt.close();
            } catch (SQLException e) {
                System.out.println(e.toString());
            }
            if ( conn != null ) try {
                conn.close();
            } catch (SQLException e) {
                System.out.println(e.toString());
            }
        }
    }

    /**
     * �]�w�L�H�Ƹ�ƪ̤��U�������P�_.
     */
    public void setNoHR() {
        setHR(false);
        setCrew(false);
        setDutyEmp(false);
        setFZOfficer(false);
    }

    public boolean isDutyEmp() {
        return isDutyEmp;
    }

    public void setDutyEmp(boolean hasHR) {
        this.isDutyEmp = hasHR;
    }

    public boolean isCrew() {
        return isCrew;
    }

    public void setCrew(boolean isCrew) {
        this.isCrew = isCrew;
    }

    public boolean isHR() {
        return isHR;
    }

    public void setHR(boolean isHR) {
        this.isHR = isHR;
    }

    public boolean isFZOfficer() {
        return isFZOfficer;
    }

    public void setFZOfficer(boolean isFZOfficer) {
        this.isFZOfficer = isFZOfficer;
    }

    public boolean isCabin() {
        return isCabin;
    }

    public void setCabin(boolean isCabin) {
        this.isCabin = isCabin;
    }

    public boolean isCockpit() {
        return isCockpit;
    }

    public void setCockpit(boolean isCockpit) {
        this.isCockpit = isCockpit;
    }

    public boolean isCrewBefore() {
        return isCrewBefore;
    }

    public void setCrewBefore(boolean isCrewBefore) {
        this.isCrewBefore = isCrewBefore;
    }

    public boolean isED() {
        return isED;
    }

    public void setED(boolean isED) {
        this.isED = isED;
    }

    public HRObj getHrObj() {
        if ( null == hrObj ) {
            hrObj = new HRObj();
        }
        return hrObj;
    }

    public void setHrObj(HRObj hrObj) {
        this.hrObj = hrObj;
    }
    
    
    public boolean isIs180A()
    {
        return is180A;
    }
    public void setIs180A(boolean is180A)
    {
        this.is180A = is180A;
    }
}