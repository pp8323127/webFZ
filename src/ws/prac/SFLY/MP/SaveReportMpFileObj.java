package ws.prac.SFLY.MP;

public class SaveReportMpFileObj
{
    private String sernno = null;;
    private String fltd = null;;
    private String fltno = null;;
    private String sect = null;;
    private String type = null;;
    private String subtype = null;
    private String filename = null;;
    private String filedsc = null;;
    private String upduser = null;;
    private String upddate = null;;
    private String src = null;;
    private String app_filename = null;;
    private byte[]  zipfile           = null;
    private String fileLink = null;
    
    
    public String getType()
    {
        return type;
    }
    public void setType(String type)
    {
        this.type = type;
    }
    public String getSubtype()
    {
        return subtype;
    }
    public void setSubtype(String subtype)
    {
        this.subtype = subtype;
    }
    public String getFileLink()
    {
        return fileLink;
    }
    public void setFileLink(String fileLink)
    {
        this.fileLink = fileLink;
    }

    public String getSernno()
    {
        return sernno;
    }
    public void setSernno(String sernno)
    {
        this.sernno = sernno;
    }
    public String getFltd()
    {
        return fltd;
    }
    public void setFltd(String fltd)
    {
        this.fltd = fltd;
    }
    public String getFltno()
    {
        return fltno;
    }
    public void setFltno(String fltno)
    {
        this.fltno = fltno;
    }
    public String getSect()
    {
        return sect;
    }
    public void setSect(String sect)
    {
        this.sect = sect;
    }
    public String getFilename()
    {
        return filename;
    }
    public void setFilename(String filename)
    {
        this.filename = filename;
    }
    public String getFiledsc()
    {
        return filedsc;
    }
    public void setFiledsc(String filedsc)
    {
        this.filedsc = filedsc;
    }
    public String getUpduser()
    {
        return upduser;
    }
    public void setUpduser(String upduser)
    {
        this.upduser = upduser;
    }
    public String getUpddate()
    {
        return upddate;
    }
    public void setUpddate(String upddate)
    {
        this.upddate = upddate;
    }
    public String getSrc()
    {
        return src;
    }
    public void setSrc(String src)
    {
        this.src = src;
    }
    public String getApp_filename()
    {
        return app_filename;
    }
    public void setApp_filename(String app_filename)
    {
        this.app_filename = app_filename;
    }
    public byte[] getZipfile()
    {
        return zipfile;
    }
    public void setZipfile(byte[] zipfile)
    {
        this.zipfile = zipfile;
    }
}
