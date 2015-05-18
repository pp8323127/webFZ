package ws.personal;

public class CusItemsRObj
{
  
    private CusItemsObj[] option = null;
//    private String[] cateItemAr =  {"SG001/訂位","SG002/票務","SG003/會員事宜","SG004/座椅","SG005/設備","SG006/貴賓室","SG007/餐飲","SG008/空服","SG009/登機作業","SG010/AVOD","SG011/劃位櫃檯","SG012/公司政策","SG013/其他"};
//    private String[] magItemAr = {"00001/天下雜誌","00004/遠見雜誌","00005/商業週刊"};
//    private String[] newsItemAr = {"00001/中國時報","00002/聯合報","00007/經濟日報"};
//    private String[] beverItemAr = {"teaac/紅茶","teaaa/綠茶","teaab/烏龍茶"};
//    private String[] prioItemAr = {"1/Must","2/Nice to Have","3/Option"};
//    private String[] freqItemAr = {"1/Every Time","2/Periodically","3/One Time"};
//    private String[] placeItemAr = {"報到櫃台","登機門口","客艙"};
//    
    private String errorMsg = null;
    private String resultMsg = null;
    

    
    public CusItemsObj[] getOption()
    {
        return option;
    }
    public void setOption(CusItemsObj[] option)
    {
        this.option = option;
    }
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
    

}
