package ws.prac.SFLY.MP;

public class MPsflySafetyChkQueObj//egtstfi
{
    private String itemno  = "";
    private String itemDsc = "";
    private String flag = "";
    private MPsflySafetyChkQsubObj[] subQueArr = null;
    
    public String getItemno()
    {
        return itemno;
    }
    public void setItemno(String itemno)
    {
        this.itemno = itemno;
    }
    public String getItemDsc()
    {
        return itemDsc;
    }
    public void setItemDsc(String itemDsc)
    {
        this.itemDsc = itemDsc;
    }
    public String getFlag()
    {
        return flag;
    }
    public void setFlag(String flag)
    {
        this.flag = flag;
    }
    public MPsflySafetyChkQsubObj[] getSubQueArr()
    {
        return subQueArr;
    }
    public void setSubQueArr(MPsflySafetyChkQsubObj[] subQueArr)
    {
        this.subQueArr = subQueArr;
    }




    
}
