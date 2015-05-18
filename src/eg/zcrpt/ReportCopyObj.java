package eg.zcrpt;

public class ReportCopyObj {

	/**
	 * @param args
	 */
	 
    private String fileName	 = "";
    private String fileDsc	 = "";
    
    private String itemno 	= "";
    private String itemDsc 	= "";
    private String comments = "";
    private String itemNoDsc = "";//A05 ´y­z

    private String flag		 = "";
    private String itemClose = "";
    private String itemClsDt="";

    
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFileDsc() {
		return fileDsc;
	}
	public void setFileDsc(String fileDsc) {
		this.fileDsc = fileDsc;
	}
	public String getItemno() {
		return itemno;
	}
	public void setItemno(String itemno) {
		this.itemno = itemno;
	}
	public String getItemDsc() {
		return itemDsc;
	}
	public void setItemDsc(String itemDsc) {
		this.itemDsc = itemDsc;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	public String getItemClose() {
		return itemClose;
	}
	public void setItemClose(String itemClose) {
		this.itemClose = itemClose;
	}
	public String getItemClsDt() {
		return itemClsDt;
	}
	public void setItemClsDt(String itemClsDt) {
		this.itemClsDt = itemClsDt;
	}
    public String getItemNoDsc()
    {
        return itemNoDsc;
    }
    public void setItemNoDsc(String itemNoDsc)
    {
        this.itemNoDsc = itemNoDsc;
    }
    
	

}
