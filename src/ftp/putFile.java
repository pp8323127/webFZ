package ftp;

//import java.net.*;

public class putFile
{
	public String doFtp(String locfilepath, String ftpfilename)
	{
		try{
		    //Path: TPESUNAP02(192.168.242.40)
		    //soc/airops/AIROPS_REL/data/sitatelex/mailout
			//FtpUtility example = new FtpUtility("192.168.242.15","/soc/airops/AIROPS_REL/data/sitatelex/mailout/","lccjw","#calpis0");
//		    FtpUtility example = new FtpUtility("192.168.50.18","/host-rpt/jcs/jc772/","co01","HA235");
		    FtpUtility example = new FtpUtility("TPESUNAP02","/soc/airops/AIROPS_REL/data/sitatelex/mailout","apis","Ci9999");
			example.connect();
			example.setDirectory("/soc/airops/AIROPS_REL/data/sitatelex/mailout");
			example.putBinFile(locfilepath, ftpfilename);
			example.close();
			return "0";
		}
		catch(Exception e){
			return e.toString();
		}
	}
}
