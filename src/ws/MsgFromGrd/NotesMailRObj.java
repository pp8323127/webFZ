package ws.MsgFromGrd;

public class NotesMailRObj
{
    private String errorMsg = "";
    private String resultMsg = "";
    private NotesMailObj[] noteMailarr = null;
    private SitaCodeObj[] sitaCodearr = null;
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
    public NotesMailObj[] getNoteMailarr()
    {
        return noteMailarr;
    }
    public void setNoteMailarr(NotesMailObj[] noteMailarr)
    {
        this.noteMailarr = noteMailarr;
    }
    public SitaCodeObj[] getSitaCodearr()
    {
        return sitaCodearr;
    }
    public void setSitaCodearr(SitaCodeObj[] sitaCodearr)
    {
        this.sitaCodearr = sitaCodearr;
    }
    
    
}
