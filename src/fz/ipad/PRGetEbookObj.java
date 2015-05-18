package fz.ipad;

/**
 * @author CS71 Created on  2012/5/9
 */
public class PRGetEbookObj
{
    private String folder = "";
    private String filename = "";
    private String url = "";
    private String file_info ="";
    
    public String getFilename()
    {
        return filename;
    }
    public void setFilename(String filename)
    {
        this.filename = filename;
    }
    public String getFolder()
    {
        return folder;
    }
    public void setFolder(String folder)
    {
        this.folder = folder;
    }
    public String getUrl()
    {
        return url;
    }
    public void setUrl(String url)
    {
        this.url = url;
    }    
    public String getFile_info()
    {
        return file_info;
    }
    public void setFile_info(String file_info)
    {
        this.file_info = file_info;
    }
}
