package ws.personal;

public class CusItemsRObj
{
  
    private CusItemsObj[] option = null;
//    private String[] cateItemAr =  {"SG001/�q��","SG002/����","SG003/�|���Ʃy","SG004/�y��","SG005/�]��","SG006/�Q����","SG007/�\��","SG008/�ŪA","SG009/�n���@�~","SG010/AVOD","SG011/�����d�i","SG012/���q�F��","SG013/��L"};
//    private String[] magItemAr = {"00001/�ѤU���x","00004/�������x","00005/�ӷ~�g�Z"};
//    private String[] newsItemAr = {"00001/����ɳ�","00002/�p�X��","00007/�g�٤��"};
//    private String[] beverItemAr = {"teaac/����","teaaa/���","teaab/�Q�s��"};
//    private String[] prioItemAr = {"1/Must","2/Nice to Have","3/Option"};
//    private String[] freqItemAr = {"1/Every Time","2/Periodically","3/One Time"};
//    private String[] placeItemAr = {"�����d�x","�n�����f","�ȿ�"};
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
