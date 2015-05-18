package ws;

/**
 * @author 640790 Created on  2013/8/20
 */
public class saveReportChkrddObj
{

    public static void main(String[] args)
    {
    }    
    private String checkseqno 		= "";
    private String checkdetailseq   = "";
    private String checkrdseq       = "";
    private String comments         = "";
    private String correct          = "Y";
    
    public String getCheckseqno()
    {
        return checkseqno;
    }
    public String getCheckdetailseq()
    {
        return checkdetailseq;
    }
    public String getCheckrdseq()
    {
        return checkrdseq;
    }
    public String getComments()
    {
        return comments;
    }
    public String getCorrect()
    {
        return correct;
    }
    public void setCheckseqno(String checkseqno)
    {
        this.checkseqno = checkseqno;
    }
    public void setCheckdetailseq(String checkdetailseq)
    {
        this.checkdetailseq = checkdetailseq;
    }
    public void setCheckrdseq(String checkrdseq)
    {
        this.checkrdseq = checkrdseq;
    }
    public void setComments(String comments)
    {
        this.comments = comments;
    }
    public void setCorrect(String correct)
    {
        this.correct = correct;
    }
}
