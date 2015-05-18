package ws.menu;

public class SaveObj
{
    private String seqno = null;
    private String catalog  = null; //m:餐點,b:飲料
    private String type = null; //子類別:早,中,晚餐.餐前酒,烈酒
    private String alacarttype = null;//Dessert ,Drink
    private String cname = null;//中文名稱
    private String ename = null;//英文名稱
    private String detail = null;//細項
    private String quantity = null;//數量
    public String getSeqno()
    {
        return seqno;
    }
    public void setSeqno(String seqno)
    {
        this.seqno = seqno;
    }
    public String getCatalog()
    {
        return catalog;
    }
    public void setCatalog(String catalog)
    {
        this.catalog = catalog;
    }
    public String getType()
    {
        return type;
    }
    public void setType(String type)
    {
        this.type = type;
    }
    public String getAlacarttype()
    {
        return alacarttype;
    }
    public void setAlacarttype(String alacarttype)
    {
        this.alacarttype = alacarttype;
    }
    public String getCname()
    {
        return cname;
    }
    public void setCname(String cname)
    {
        this.cname = cname;
    }
    public String getEname()
    {
        return ename;
    }
    public void setEname(String ename)
    {
        this.ename = ename;
    }
    public String getDetail()
    {
        return detail;
    }
    public void setDetail(String detail)
    {
        this.detail = detail;
    }
    public String getQuantity()
    {
        return quantity;
    }
    public void setQuantity(String quantity)
    {
        this.quantity = quantity;
    }
    

    
    
}
