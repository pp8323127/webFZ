package fz.ipad;

/**
 * @author CS71 Created on  2012/5/9
 */
public class PsrStationDocToIpadObj
{
    //PK(decimal(18, 0)), Subject(nvarchar(100)), ContentPK(nvarchar(4000)), DateEdit(datetime), DateOn(datetime), 
    //DateOff(datetime), DefaultLang(nvarchar(50)), Author_Empno(nvarchar(50)), Author_Cname(nvarchar(100)), 
    //Author_Ename(nvarchar(100)), Author_ext(nvarchar(50)), PKTAB(nvarchar(50)), TITLE(nvarchar(100)), 
    //Content(ntext), Text(ntext)
    //PK(int), FileName(nvarchar(100)), ContentType(nvarchar(100)), BLOB(image)

    private String pk = "";
    private String subject = "";
    private String contentPK ="";
    private String dateedit = "";
    private String dateon = "";
    private String dateoff ="";
    private String defaultlang = "";
    private String author_empno = "";
    private String author_cname ="";
    private String author_ename = "";
    private String author_ext = "";
    private String pktab ="";
    private String title = "";
    private String content ="";
    private String text = "";
    private String filepk = "";
    private String filename ="";
    private String contenttype = "";
    private byte[] blob = null;
    
    
    public byte[] getBlob()
    {
        return blob;
    }
    public void setBlob(byte[] blob)
    {
        this.blob = blob;
    }
    public String getAuthor_cname()
    {
        return author_cname;
    }
    public void setAuthor_cname(String author_cname)
    {
        this.author_cname = author_cname;
    }
    public String getAuthor_empno()
    {
        return author_empno;
    }
    public void setAuthor_empno(String author_empno)
    {
        this.author_empno = author_empno;
    }
    public String getAuthor_ename()
    {
        return author_ename;
    }
    public void setAuthor_ename(String author_ename)
    {
        this.author_ename = author_ename;
    }
    public String getAuthor_ext()
    {
        return author_ext;
    }
    public void setAuthor_ext(String author_ext)
    {
        this.author_ext = author_ext;
    }
    
    public String getContent()
    {
        return content;
    }
    public void setContent(String content)
    {
        this.content = content;
    }
    public String getContentPK()
    {
        return contentPK;
    }
    public void setContentPK(String contentPK)
    {
        this.contentPK = contentPK;
    }
    public String getContenttype()
    {
        return contenttype;
    }
    public void setContenttype(String contenttype)
    {
        this.contenttype = contenttype;
    }
    public String getDateedit()
    {
        return dateedit;
    }
    public void setDateedit(String dateedit)
    {
        this.dateedit = dateedit;
    }
    public String getDateoff()
    {
        return dateoff;
    }
    public void setDateoff(String dateoff)
    {
        this.dateoff = dateoff;
    }
    public String getDateon()
    {
        return dateon;
    }
    public void setDateon(String dateon)
    {
        this.dateon = dateon;
    }
    public String getDefaultlang()
    {
        return defaultlang;
    }
    public void setDefaultlang(String defaultlang)
    {
        this.defaultlang = defaultlang;
    }
    public String getFilename()
    {
        return filename;
    }
    public void setFilename(String filename)
    {
        this.filename = filename;
    }
    public String getFilepk()
    {
        return filepk;
    }
    public void setFilepk(String filepk)
    {
        this.filepk = filepk;
    }
    public String getPk()
    {
        return pk;
    }
    public void setPk(String pk)
    {
        this.pk = pk;
    }
    public String getPktab()
    {
        return pktab;
    }
    public void setPktab(String pktab)
    {
        this.pktab = pktab;
    }
    public String getSubject()
    {
        return subject;
    }
    public void setSubject(String subject)
    {
        this.subject = subject;
    }
    public String getText()
    {
        return text;
    }
    public void setText(String text)
    {
        this.text = text;
    }
    public String getTitle()
    {
        return title;
    }
    public void setTitle(String title)
    {
        this.title = title;
    }
}
