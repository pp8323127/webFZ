package eg.crewbasic;

/**
 * @author CS71 Created on  2010/8/5
 */
public class CrewDocObj
{
    private String empno = "";
    private String doc_type = "";
    private String doc_num = "";
    private String doc_issue_date  = "";
    private String doc_issue_place = "";
    private String doc_due_date = "";
    private String doc_cname = "";
    private String doc_ename = "";
    private String doc_memo = "";    
    
    public String getDoc_cname()
    {
        return doc_cname;
    }
    public void setDoc_cname(String doc_cname)
    {
        this.doc_cname = doc_cname;
    }
    public String getDoc_due_date()
    {
        return doc_due_date;
    }
    public void setDoc_due_date(String doc_due_date)
    {
        this.doc_due_date = doc_due_date;
    }
    public String getDoc_ename()
    {
        return doc_ename;
    }
    public void setDoc_ename(String doc_ename)
    {
        this.doc_ename = doc_ename;
    }
    public String getDoc_issue_date()
    {
        return doc_issue_date;
    }
    public void setDoc_issue_date(String doc_issue_date)
    {
        this.doc_issue_date = doc_issue_date;
    }
    public String getDoc_issue_place()
    {
        return doc_issue_place;
    }
    public void setDoc_issue_place(String doc_issue_place)
    {
        this.doc_issue_place = doc_issue_place;
    }
    public String getDoc_memo()
    {
        return doc_memo;
    }
    public void setDoc_memo(String doc_memo)
    {
        this.doc_memo = doc_memo;
    }
    public String getDoc_num()
    {
        return doc_num;
    }
    public void setDoc_num(String doc_num)
    {
        this.doc_num = doc_num;
    }
    public String getDoc_type()
    {
        return doc_type;
    }
    public void setDoc_type(String doc_type)
    {
        this.doc_type = doc_type;
    }
    public String getEmpno()
    {
        return empno;
    }
    public void setEmpno(String empno)
    {
        this.empno = empno;
    }
}
