package ws.prac.SFLY.MP;

public class MPsflyCatObj
{
    private String itemNo = null;
    private String item = null;
    private String[] seletItem =  {"��r1","��r2","��r3"};//���Y��r
    public String getItemNo()
    {
        return itemNo;
    }
    public void setItemNo(String itemNo)
    {
        this.itemNo = itemNo;
    }
    public String getItem()
    {
        return item;
    }
    public void setItem(String item)
    {
        this.item = item;
    }
    public String[] getSeletItem()
    {
        return seletItem;
    }
    public void setSeletItem(String[] seletItem)
    {
        this.seletItem = seletItem;
    }
    
}
