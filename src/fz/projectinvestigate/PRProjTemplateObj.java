package fz.projectinvestigate;

/**
 * @author cs71 Created on  2008/9/25
 */
public class PRProjTemplateObj
{   
    private String   comment_no		  = "";
    private String   comment_desc      = "";
    private String   item_no  = "";
    private String   item_desc  = "";
   
  
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
    public String getComment_desc()
    {
        return comment_desc;
    }
    public void setComment_desc(String comment_desc)
    {
        this.comment_desc = comment_desc;
    }
    public String getComment_no()
    {
        return comment_no;
    }
    public void setComment_no(String comment_no)
    {
        this.comment_no = comment_no;
    }
}