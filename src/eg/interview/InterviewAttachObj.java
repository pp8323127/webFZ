package eg.interview;


/**
 * @author CS71 Created on  2011/1/14
 */
public class InterviewAttachObj
{
    private String interview_no  	="";
    private String seq  			="";
    private String sern				="";
    private String attach_name		="";
    private String attach_desc	    ="";    
    
    public String getAttach_desc()
    {
        return attach_desc;
    }
    public void setAttach_desc(String attach_desc)
    {
        this.attach_desc = attach_desc;
    }
    public String getAttach_name()
    {
        return attach_name;
    }
    public void setAttach_name(String attach_name)
    {
        this.attach_name = attach_name;
    }
    public String getInterview_no()
    {
        return interview_no;
    }
    public void setInterview_no(String interview_no)
    {
        this.interview_no = interview_no;
    }
    public String getSeq()
    {
        return seq;
    }
    public void setSeq(String seq)
    {
        this.seq = seq;
    }
    public String getSern()
    {
        return sern;
    }
    public void setSern(String sern)
    {
        this.sern = sern;
    }
}
