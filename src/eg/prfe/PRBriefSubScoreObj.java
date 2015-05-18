package eg.prfe;

/**
 * @author cs71 Created on  2009/6/16
 */
public class PRBriefSubScoreObj
{
    private String brief_dt   		="";
    private String purempno   		="";
    private String purcname   		="";
    private String item_no        	="";
    private String item_desc        ="";
    private String subitem_no     	="";
    private String subitem_desc     ="";
    private String score          	="";
    private String main_percentage 	="";    
    private String sub_percentage	="";  
    private String comm 			="";
    
    public String getComm()
    {
        return comm;
    }
    public void setComm(String comm)
    {
        this.comm = comm;
    }
    public String getMain_percentage()
    {
        return main_percentage;
    }
    public void setMain_percentage(String main_percentage)
    {
        this.main_percentage = main_percentage;
    }
    public String getSub_percentage()
    {
        return sub_percentage;
    }
    public void setSub_percentage(String sub_percentage)
    {
        this.sub_percentage = sub_percentage;
    }
    public String getBrief_dt()
    {
        return brief_dt;
    }
    public void setBrief_dt(String brief_dt)
    {
        this.brief_dt = brief_dt;
    }
    public String getItem_desc()
    {
        return item_desc;
    }
    public void setItem_desc(String item_desc)
    {
        this.item_desc = item_desc;
    }
    public String getItem_no()
    {
        return item_no;
    }
    public void setItem_no(String item_no)
    {
        this.item_no = item_no;
    }
    public String getPurcname()
    {
        return purcname;
    }
    public void setPurcname(String purcname)
    {
        this.purcname = purcname;
    }
    public String getPurempno()
    {
        return purempno;
    }
    public void setPurempno(String purempno)
    {
        this.purempno = purempno;
    }
    public String getScore()
    {
        return score;
    }
    public void setScore(String score)
    {
        this.score = score;
    }
    public String getSubitem_desc()
    {
        return subitem_desc;
    }
    public void setSubitem_desc(String subitem_desc)
    {
        this.subitem_desc = subitem_desc;
    }
    public String getSubitem_no()
    {
        return subitem_no;
    }
    public void setSubitem_no(String subitem_no)
    {
        this.subitem_no = subitem_no;
    }
}
