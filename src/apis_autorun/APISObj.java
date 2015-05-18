package apis_autorun;

import java.util.*;

/**
 * @author cs71 Created on  2006/8/31
 */
public class APISObj
{
    private String empno= ""; 
    private String carrier = ""; 
    private String fltno= ""; 
    private String fdate= ""; //YYmmdd
    private String lname= ""; 
    private String fname= ""; 
    private String nation = "";
    private String birth= ""; 
    private String passport= ""; 
    private String passport2= ""; 
    private String gender = "";
    private String dpt= ""; 
    private String arv= "";     
    private String occu = "";
    private String str_port_local = "";
    private String end_port_local = "";   
    private String stdtpe = "";//tpe time  yyyy/mm/dd hh24:mi
    private String resicountry= ""; 
    private String birthcity= ""; 
    private String birthcountry= ""; 
    private String tvlstatus= "";     
    private String passcountry= "";     
    private String passcountry2= "";      
    private String passexp= ""; 
    private String passexp2= ""; 
    private String certno= ""; 
    private String certctry= ""; 
    private String certtype= ""; 
    private String certexp = ""; 
    private String fly_status = "";
    private String remark = "N";
    private String tmst = "";
    private String resiaddr1 = "";
    private String resiaddr2 = "";
    private String resiaddr3 = "";
    private String resiaddr4 = "";
    private String resiaddr5 = "";
    
    private StringBuffer msgSB = new StringBuffer();     
    ArrayList da13AL = new ArrayList();    
    private boolean cargo_passenger = false;      
    
    public String getPasscountry2()
    {
        return passcountry2;
    }
    public void setPasscountry2(String passcountry2)
    {
        this.passcountry2 = passcountry2;
    }
    public String getPassexp2()
    {
        return passexp2;
    }
    public void setPassexp2(String passexp2)
    {
        this.passexp2 = passexp2;
    }
    public String getPassport2()
    {
        return passport2;
    }
    public void setPassport2(String passport2)
    {
        this.passport2 = passport2;
    }
    public String getResiaddr1()
    {
        return resiaddr1;
    }
    public void setResiaddr1(String resiaddr1)
    {
        this.resiaddr1 = resiaddr1;
    }
    public String getResiaddr2()
    {
        return resiaddr2;
    }
    public void setResiaddr2(String resiaddr2)
    {
        this.resiaddr2 = resiaddr2;
    }
    public String getResiaddr3()
    {
        return resiaddr3;
    }
    public void setResiaddr3(String resiaddr3)
    {
        this.resiaddr3 = resiaddr3;
    }
    public String getResiaddr4()
    {
        return resiaddr4;
    }
    public void setResiaddr4(String resiaddr4)
    {
        this.resiaddr4 = resiaddr4;
    }
    public String getResiaddr5()
    {
        return resiaddr5;
    }
    public void setResiaddr5(String resiaddr5)
    {
        this.resiaddr5 = resiaddr5;
    }
    public boolean isCargo_passenger()
    {
        return cargo_passenger;
    }
    public void setCargo_passenger(boolean cargo_passenger)
    {
        this.cargo_passenger = cargo_passenger;
    }
    public String getTmst()
    {
        return tmst;
    }
    public void setTmst(String tmst)
    {
        this.tmst = tmst;
    }
    public StringBuffer getMsgSB()
    {
        return msgSB;
    }
    public void setMsgSB(StringBuffer msgSB)
    {
        msgSB.append("");
        this.msgSB = msgSB;
    }
    public ArrayList getDa13AL()
    {
        return da13AL;
    }
    public void setDa13AL(ArrayList da13AL)
    {
        this.da13AL = da13AL;
    }    
    public String getRemark()
    {
        return remark;
    }
    public void setRemark(String remark)
    {
        this.remark = remark;
    }
    public String getFly_status()
    {
        return fly_status;
    }
    public void setFly_status(String fly_status)
    {
        this.fly_status = fly_status;
    }
    public String getArv()
    {
        return arv;
    }
    public void setArv(String arv)
    {
        this.arv = arv;
    }
    public String getBirth()
    {
        return birth;
    }
    public void setBirth(String birth)
    {
        this.birth = birth;
    }
    public String getBirthcity()
    {
        return birthcity;
    }
    public void setBirthcity(String birthcity)
    {
        this.birthcity = birthcity;
    }
    public String getBirthcountry()
    {
        return birthcountry;
    }
    public void setBirthcountry(String birthcountry)
    {
        this.birthcountry = birthcountry;
    }
    public String getCarrier()
    {
        return carrier;
    }
    public void setCarrier(String carrier)
    {
        this.carrier = carrier;
    }
    public String getCertctry()
    {
        return certctry;
    }
    public void setCertctry(String certctry)
    {
        this.certctry = certctry;
    }
    
    public String getCerttype()
    {
        return certtype;
    }
    public void setCerttype(String certtype)
    {
        this.certtype = certtype;
    }
    public String getCertexp()
    {
        return certexp;
    }
    public void setCertexp(String certexp)
    {
        this.certexp = certexp;
    }
    public String getCertno()
    {
        return certno;
    }
    public void setCertno(String certno)
    {
        this.certno = certno;
    }
    public String getDpt()
    {
        return dpt;
    }
    public void setDpt(String dpt)
    {
        this.dpt = dpt;
    }
    public String getEmpno()
    {
        return empno;
    }
    public void setEmpno(String empno)
    {
        this.empno = empno;
    }
    public String getEnd_port_local()
    {
        return end_port_local;
    }
    public void setEnd_port_local(String end_port_local)
    {
        this.end_port_local = end_port_local;
    }
    public String getFdate()
    {
        return fdate;
    }
    public void setFdate(String fdate)
    {
        this.fdate = fdate;
    }
    public String getFltno()
    {
        return fltno;
    }
    public void setFltno(String fltno)
    {
        this.fltno = fltno;
    }
    public String getFname()
    {
        return fname;
    }
    public void setFname(String fname)
    {
        this.fname = fname;
    }
    public String getGender()
    {
        return gender;
    }
    public void setGender(String gender)
    {
        this.gender = gender;
    }
    public String getLname()
    {
        return lname;
    }
    public void setLname(String lname)
    {
        this.lname = lname;
    }
    public String getNation()
    {
        return nation;
    }
    public void setNation(String nation)
    {
        this.nation = nation;
    }
    public String getOccu()
    {
        return occu;
    }
    public void setOccu(String occu)
    {
        this.occu = occu;
    }
    public String getPasscountry()
    {
        return passcountry;
    }
    public void setPasscountry(String passcountry)
    {
        this.passcountry = passcountry;
    }
    public String getPassexp()
    {
        return passexp;
    }
    public void setPassexp(String passexp)
    {
        this.passexp = passexp;
    }
    public String getPassport()
    {
        return passport;
    }
    public void setPassport(String passport)
    {
        this.passport = passport;
    }
    public String getResicountry()
    {
        return resicountry;
    }
    public void setResicountry(String resicountry)
    {
        this.resicountry = resicountry;
    }
    public String getStdtpe()
    {
        return stdtpe;
    }
    public void setStdtpe(String stdtpe)
    {
        this.stdtpe = stdtpe;
    }
    public String getStr_port_local()
    {
        return str_port_local;
    }
    public void setStr_port_local(String str_port_local)
    {
        this.str_port_local = str_port_local;
    }
    public String getTvlstatus()
    {
        return tvlstatus;
    }
    public void setTvlstatus(String tvlstatus)
    {
        this.tvlstatus = tvlstatus;
    }
}
