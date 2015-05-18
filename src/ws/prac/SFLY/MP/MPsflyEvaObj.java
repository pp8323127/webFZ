package ws.prac.SFLY.MP;

import eg.prfe.*;

public class MPsflyEvaObj
{

    
//    private PRFuncEvalObj[] prfe = null;
//    private PRFuncEvalObj2[] prfe2 = null;
    
    private MPEvalObj[] prfe = null;
    private MPEvalObj2[] prfe2 = null;
    
    private MemofbkObj[] sugfbk = null;//航班事務改善
    private MemofbkObj[] catefbk = null;//旅客反映

    private SaveReportMpFileObj[] file = null;
    

    public SaveReportMpFileObj[] getFile()
    {
        return file;
    }
    public void setFile(SaveReportMpFileObj[] file)
    {
        this.file = file;
    }
    public MPEvalObj[] getPrfe()
    {
        return prfe;
    }
    public void setPrfe(MPEvalObj[] prfe)
    {
        this.prfe = prfe;
    }
    public MPEvalObj2[] getPrfe2()
    {
        return prfe2;
    }
    public void setPrfe2(MPEvalObj2[] prfe2)
    {
        this.prfe2 = prfe2;
    }
    public MemofbkObj[] getSugfbk()
    {
        return sugfbk;
    }
    public void setSugfbk(MemofbkObj[] sugfbk)
    {
        this.sugfbk = sugfbk;
    }
    public MemofbkObj[] getCatefbk()
    {
        return catefbk;
    }
    public void setCatefbk(MemofbkObj[] catefbk)
    {
        this.catefbk = catefbk;
    }

    
}
