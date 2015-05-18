package eg.off;

import java.util.*;

/**
 * @author cs71 Created on  2007/9/6
 */
public class OffsObj
{
    private String offno = ""; 
    private String empn= ""; 
    private String sern= ""; 
    private String offtype= ""; 
    private String offsdate= ""; 
    private String offedate= ""; 
    private String offdays= ""; 
    private String offftno= ""; 
    private String station= ""; 
    private String remark= ""; 
    private String offyear= ""; 
    private String gradeyear= ""; 
    private String newuser= ""; 
    private String newdate= ""; 
    private String chguser= ""; 
    private String chgdate= ""; 
    private String form_num= ""; 
    private String rank= ""; 
    private String reassign= "N"; 
    private String ef_judge_status= ""; 
    private String ef_judge_user= ""; 
    private String ef_judge_tmst= ""; 
    private String ed_inform_user= ""; 
    private String ed_inform_tmst= ""; 
    private String doc_status= "N"; 
    private String doc_days  = "";
    private String delete_user= ""; 
    private String delete_tmst= ""; 
    private String occur_date = "";
    private String relation = "";
    private String relationid = "";
    
    
    public String getRelationid()
    {
        return relationid;
    }
    public void setRelationid(String relationid)
    {
        this.relationid = relationid;
    }
    public String getRelation()
    {
        return relation;
    }
    public void setRelation(String relation)
    {
        this.relation = relation;
    }
    
    public String getOccur_date()
    {
        return occur_date;
    }
    public void setOccur_date(String occur_date)
    {
        this.occur_date = occur_date;
    }
    private ArrayList objAL = new ArrayList();
    
    public String getDoc_days()
    {
        return doc_days;
    }
    public void setDoc_days(String doc_days)
    {
        this.doc_days = doc_days;
    }
    public String getChgdate()
    {
        return chgdate;
    }
    public void setChgdate(String chgdate)
    {
        this.chgdate = chgdate;
    }
    public String getChguser()
    {
        return chguser;
    }
    public void setChguser(String chguser)
    {
        this.chguser = chguser;
    }
    public String getDelete_tmst()
    {
        return delete_tmst;
    }
    public void setDelete_tmst(String delete_tmst)
    {
        this.delete_tmst = delete_tmst;
    }
    public String getDelete_user()
    {
        return delete_user;
    }
    public void setDelete_user(String delete_user)
    {
        this.delete_user = delete_user;
    }
    public String getDoc_status()
    {
        return doc_status;
    }
    public void setDoc_status(String doc_status)
    {
        this.doc_status = doc_status;
    }
    public String getEd_inform_tmst()
    {
        return ed_inform_tmst;
    }
    public void setEd_inform_tmst(String ed_inform_tmst)
    {
        this.ed_inform_tmst = ed_inform_tmst;
    }
    public String getEd_inform_user()
    {
        return ed_inform_user;
    }
    public void setEd_inform_user(String ed_inform_user)
    {
        this.ed_inform_user = ed_inform_user;
    }
    public String getEf_judge_status()
    {
        return ef_judge_status;
    }
    public void setEf_judge_status(String ef_judge_status)
    {
        this.ef_judge_status = ef_judge_status;
    }
    public String getEf_judge_tmst()
    {
        return ef_judge_tmst;
    }
    public void setEf_judge_tmst(String ef_judge_tmst)
    {
        this.ef_judge_tmst = ef_judge_tmst;
    }
    public String getEf_judge_user()
    {
        return ef_judge_user;
    }
    public void setEf_judge_user(String ef_judge_user)
    {
        this.ef_judge_user = ef_judge_user;
    }
    public String getEmpn()
    {
        return empn;
    }
    public void setEmpn(String empn)
    {
        this.empn = empn;
    }
    public String getForm_num()
    {
        return form_num;
    }
    public void setForm_num(String form_num)
    {
        this.form_num = form_num;
    }
    public String getGradeyear()
    {
        return gradeyear;
    }
    public void setGradeyear(String gradeyear)
    {
        this.gradeyear = gradeyear;
    }
    public String getNewdate()
    {
        return newdate;
    }
    public void setNewdate(String newdate)
    {
        this.newdate = newdate;
    }
    public String getNewuser()
    {
        return newuser;
    }
    public void setNewuser(String newuser)
    {
        this.newuser = newuser;
    }
    public String getOffdays()
    {
        return offdays;
    }
    public void setOffdays(String offdays)
    {
        this.offdays = offdays;
    }
    public String getOffedate()
    {
        return offedate;
    }
    public void setOffedate(String offedate)
    {
        this.offedate = offedate;
    }
    public String getOffftno()
    {
        return offftno;
    }
    public void setOffftno(String offftno)
    {
        this.offftno = offftno;
    }
    public String getOffno()
    {
        return offno;
    }
    public void setOffno(String offno)
    {
        this.offno = offno;
    }
    public String getOffsdate()
    {
        return offsdate;
    }
    public void setOffsdate(String offsdate)
    {
        this.offsdate = offsdate;
    }
    public String getOfftype()
    {
        return offtype;
    }
    public void setOfftype(String offtype)
    {
        this.offtype = offtype;
    }
    public String getOffyear()
    {
        return offyear;
    }
    public void setOffyear(String offyear)
    {
        this.offyear = offyear;
    }
    public String getRank()
    {
        return rank;
    }
    public void setRank(String rank)
    {
        this.rank = rank;
    }
    public String getReassign()
    {
        return reassign;
    }
    public void setReassign(String reassign)
    {
        this.reassign = reassign;
    }
    public String getRemark()
    {
        return remark;
    }
    public void setRemark(String remark)
    {
        this.remark = remark;
    }
    public String getSern()
    {
        return sern;
    }
    public void setSern(String sern)
    {
        this.sern = sern;
    }
    public String getStation()
    {
        return station;
    }
    public void setStation(String station)
    {
        this.station = station;
    }
    public ArrayList getObjAL()
    {
        return objAL;
    }
    public void setObjAL(ArrayList objAL)
    {
        this.objAL = objAL;
    }
}
