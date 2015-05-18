/*
 * Created on 2005/2/15
 * modify at 2005/06/21 add WriteFileWithoutBreakLine
 * 
 * �g�JLogFile
 */
package ci.tool;

import java.io.*;
import java.text.*;
import java.util.*;

public class WriteLog {

	private FileWriter fw = null;
	private String filePath = null;

	/**
	 * @author cs66
	 * @param filePath:
	 *                path and name of the logfile
	 *  
	 */
	public WriteLog(String filePath) {

		this.filePath = filePath;
	}

	/**
	 * @author cs66
	 * @param msg:
	 *                the message writen in LogFile
	 * @return 0:write File Success!,otherwise: error message
	 */

	public String WriteFileWithTime(String msg) {

		//�bmessage���e�[�W�O���ɶ�
		GregorianCalendar currentDate = new GregorianCalendar();
		Date curDate = (Date) currentDate.getTime();
		String nowDate = new SimpleDateFormat("yyyy/MM/dd HH:mm", Locale.UK)
				.format(curDate);

		try {
			fw = new FileWriter(filePath, true);
			fw.write(nowDate + "\t" + msg + " \r\n");
			fw.flush();
		} catch (IOException e) {
			return e.toString();
		} finally {
			try {
				if (fw != null) fw.close();
			} catch (Exception e) {
				return e.toString();
			}
		}
		return "0";

	}

	/**
	 * 
	 * �g�J�ɮסA�B�|���[���¦����ɮפ��U
	 */
	public String WriteFile(String msg) {

		try {
			fw = new FileWriter(filePath, true);
			fw.write(msg + " \r\n");
			fw.flush();
		} catch (IOException e) {
			return e.toString();
		} finally {
			try {
				if (fw != null) fw.close();
			} catch (Exception e) {
				return e.toString();
			}
		}
		return "0";

	}

	/**
	 * 
	 * �g�J�ɮסA�B�|���[���¦����ɮפ��U,���[����Ÿ�
	 */
	public String WriteFileWithoutBreakLine(String msg) {

		try {
			fw = new FileWriter(filePath, true);
			fw.write(msg);
			fw.flush();
		} catch (IOException e) {
			return e.toString();
		} finally {
			try {
				if (fw != null) fw.close();
			} catch (Exception e) {
				return e.toString();
			}
		}
		return "0";

	}
	/**
	 * 
	 * �g�J�ɮסA�B�|���[���¦����ɮפ��U,���[����Ÿ�<br>
	 * ��isAppend���ȨM�w�O�_���[���¦����ɮפ��U
	 */
	public String WriteFileWithoutBreakLine(String msg, boolean isAppend) {

		try {
			fw = new FileWriter(filePath, isAppend);
			fw.write(msg);
			fw.flush();
		} catch (IOException e) {
			return e.toString();
		} finally {
			try {
				if (fw != null) fw.close();
			} catch (Exception e) {
				return e.toString();
			}
		}
		return "0";

	}

	/**
	 * �g�J�ɮסA��isAppend���ȨM�w�O�_���[���¦����ɮפ��U
	 *  
	 */

	public String WriteFile(String msg, boolean isAppend) {

		try {
			fw = new FileWriter(filePath, isAppend);

			fw.write(msg + " \r\n");
			fw.flush();
		} catch (IOException e) {
			return e.toString();
		} finally {
			try {
				if (fw != null) fw.close();
			} catch (Exception e) {
				return e.toString();
			}
		}
		return "0";

	}
	/*
	 * public static void main(String[] args) { WriteLog wl = new
	 * WriteLog("C:\\LogTest.txt");
	 * 
	 * System.out.println(wl.WriteFile("Francasasases Write Logasdasd,not
	 * append",true)); wl.WriteFile("");
	 * 
	 *  }
	 */
}