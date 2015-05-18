package ws.prac.SFLY.MP;

public class MPsflyCatObj
{
    private String itemNo = null;
    private String item = null;
    private String[] seletItem =  {"文字1","文字2","文字3"};//罐頭文字
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
