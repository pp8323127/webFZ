package ftp;

public class FtpUrl {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}
	//test
	private String url = "http://cabincrew.china-airlines.com/prptt/";
	//live
	//private String url = "http://cabincrew.china-airlines.com/prpt/";
	
	//FtpUtility test
	private String ip = "202.165.148.99";
	private String directory = "/EGTEST/";
	private String account = "egtestftp01";
	private String pass = "egtest#01";
	//FtpUtility live
//	private String directory = "/EG/";
//	private String account = "egftp01";
//	private String pass = "cseg#01";
	
	
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getDirectory() {
		return directory;
	}
	public void setDirectory(String directory) {
		this.directory = directory;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	
	
	
}
