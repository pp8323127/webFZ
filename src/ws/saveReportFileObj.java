package ws;

import java.io.*;
import java.util.zip.*;


/**
 * @author 640790 Created on  2013/8/20
 */
public class saveReportFileObj
{    
    private String fltd 			  = "";
    private String fltno              = "";
    private String sect               = "";
    private String filename           = "";
    private String filedsc            = "";
    private String upduser            = "";    
    private String upddate            = "";
    private byte[]  zipfile           = null;       
    
    public byte[] getZipfile()
    {
        return zipfile;
    }
    public void setZipfile(byte[] zipfile)
    {
        this.zipfile = zipfile;
    }
    public String getFltd()
    {
        return fltd;
    }
    public String getFltno()
    {
        return fltno;
    }
    public String getSect()
    {
        return sect;
    }
    public String getFilename()
    {
        return filename;
    }
    public String getFiledsc()
    {
        return filedsc;
    }
    public String getUpduser()
    {
        return upduser;
    }
    public String getUpddate()
    {
        return upddate;
    }
    public void setFltd(String fltd)
    {
        this.fltd = fltd;
    }
    public void setFltno(String fltno)
    {
        this.fltno = fltno;
    }
    public void setSect(String sect)
    {
        this.sect = sect;
    }
    public void setFilename(String filename)
    {
        this.filename = filename;
    }
    public void setFiledsc(String filedsc)
    {
        this.filedsc = filedsc;
    }
    public void setUpduser(String upduser)
    {
        this.upduser = upduser;
    }
    public void setUpddate(String upddate)
    {
        this.upddate = upddate;
    }
    
   }
