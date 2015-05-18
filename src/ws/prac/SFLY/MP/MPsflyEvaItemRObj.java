package ws.prac.SFLY.MP;

public class MPsflyEvaItemRObj
{ 
    private String errorMsg = null;
    private String resultMsg = null;
    private String[] cho = {"NDIP","AVRG","GOOD"};
//  題目
    private MPsflyEvaItemObj[] evaItemArr = null;    
//  航班事務改善建議 選項
    private MPsflySugObj[] sugItemArr = null; 
//  旅客反映 選項&罐頭文字
    private MPsflyCatObj[] cateItemAr = null;
    public String getErrorMsg()
    {
        return errorMsg;
    }
    public void setErrorMsg(String errorMsg)
    {
        this.errorMsg = errorMsg;
    }
    public String getResultMsg()
    {
        return resultMsg;
    }
    public void setResultMsg(String resultMsg)
    {
        this.resultMsg = resultMsg;
    }
    public String[] getCho()
    {
        return cho;
    }
    public void setCho(String[] cho)
    {
        this.cho = cho;
    }
    public MPsflyEvaItemObj[] getEvaItemArr()
    {
        return evaItemArr;
    }
    public void setEvaItemArr(MPsflyEvaItemObj[] evaItemArr)
    {
        this.evaItemArr = evaItemArr;
    }
    public MPsflySugObj[] getSugItemArr()
    {
        return sugItemArr;
    }
    public void setSugItemArr(MPsflySugObj[] sugItemArr)
    {
        this.sugItemArr = sugItemArr;
    }
    public MPsflyCatObj[] getCateItemAr()
    {
        return cateItemAr;
    }
    public void setCateItemAr(MPsflyCatObj[] cateItemAr)
    {
        this.cateItemAr = cateItemAr;
    }
        
    
    
    
}
