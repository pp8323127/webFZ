package ws.prac;

public class FtpFileRObj {
	private String errorMsg = null;
	private String resultMsg = null;
	private FtpFileObj[] fileObj = null;
//    private byte[] zipFile = null;//return zip file
	public String getErrorMsg() {
		return errorMsg;
	}
	public void setErrorMsg(String errorMsg) {
		this.errorMsg = errorMsg;
	}
	public String getResultMsg() {
		return resultMsg;
	}
	public void setResultMsg(String resultMsg) {
		this.resultMsg = resultMsg;
	}
	public FtpFileObj[] getFileObj() {
		return fileObj;
	}
	public void setFileObj(FtpFileObj[] fileObj) {
		this.fileObj = fileObj;
	}
//    public byte[] getZipFile()
//    {
//        return zipFile;
//    }
//    public void setZipFile(byte[] zipFile)
//    {
//        this.zipFile = zipFile;
//    }
	
}
