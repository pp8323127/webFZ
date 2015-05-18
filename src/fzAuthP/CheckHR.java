package fzAuthP;

import java.sql.*;
import ci.db.*;

/**
 * 驗證人事資料 <br>
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
    private boolean isHR; //有人力資料
    private boolean isDutyEmp; //在職員工
    private boolean isCrew; //是組員
    private boolean isFZOfficer; //有權限使用班表網之辦公室人員
    private boolean isCockpit; //為前艙組員
    private boolean isCabin; //為後艙組員
    private boolean isCrewBefore; //是否曾為組員,用於現在非組員，但職級為組員者
    private boolean isED; //是否為簽派人員
    private boolean is180A = false; //是否為空服處處辦公室
    
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

                //					檢查是否在職
                if ( "Y".equals(hrObj.getExstflg()) ) 
                {
                    setDutyEmp(true);
                } 
                else 
                {
                    setDutyEmp(false);
                }
                //驗證是否為簽派人員
                if ( "190A".equals(hrObj.getUnitcd()) ) 
                {
                    setED(true);
                } 
                else 
                {
                    setED(false);                    
                }
                
                //驗證是否為FZ處長辦公室
                if ( "180A".equals(hrObj.getUnitcd()) ) 
                {
                    setIs180A(true);
                    
                }
                else
                {
                    setIs180A(false);
                }

                //				驗證是否為有權限使用班表資訊網之辦公室人員
                //				本國，使用analysa=100 or 200判斷是否為組員
                //				外站使用post判斷
                if ( "05".equals(hrObj.getUnitcd().substring(0 ,2))
                        | "06".equals(hrObj.getUnitcd().substring(0 ,2))
                        | "18".equals(hrObj.getUnitcd().substring(0 ,2))
                        | "19".equals(hrObj.getUnitcd().substring(0 ,2)) ) 
                {
                    if ( "100".equals(hrObj.getAnalysa()) | "200".equals(hrObj.getAnalysa()) ) 
                    {
                        //						排除組員
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
                { //外站EM
                    if ( "292".equals(hrObj.getPostcd().substring(0 ,2)) ) {
                        setFZOfficer(false);//外站組員
                    } else {
                        setFZOfficer(true);
                    }

                } 
                else 
                {
                    setFZOfficer(false);
                }

                //		驗證是否為前艙組員
                if ( "100".equals(hrObj.getAnalysa()) ) { //前艙
                    setCrew(true);
                    setCockpit(true);
                    setCabin(false);
                } else if ( "200".equals(hrObj.getAnalysa()) ) {//後艙
                    setCrew(true);
                    setCockpit(false);
                    setCabin(true);
                } else if ( "635".equals(hrObj.getUnitcd()) //外站
                        | "850".equals(hrObj.getUnitcd()) | "8508".equals(hrObj.getUnitcd()) 
                        | "837".equals(hrObj.getUnitcd())
                        | "811".equals(hrObj.getUnitcd())
                        | "827".equals(hrObj.getUnitcd()) | "790A".equals(hrObj.getUnitcd()) ) {

                    if ( "292".equals(hrObj.getPostcd().substring(0 ,2)) ) {
                        setCrew(true);//外站組員
                    } else {
                        setCrew(false);

                    }
                }

                //			判斷是否曾為組員
                int iPostlvl = 0;
                try {
                    iPostlvl = Integer.parseInt(hrObj.getPostlvl());
                    setCrewBefore(false);
                } catch (NumberFormatException e) {
                    //					Postlv 不是數字，則為組員
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
     * 設定無人事資料者之各項身份判斷.
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