package swap3ackhh.smsacP;
import java.io.*;
import java.util.*;

import fz.smsacP.ContactPhoneObj;

/**
 * SMSFile 製作簡訊號碼檔
 * 
 * 
 * @author cs66
 * @version 1.0 2006/4/11
 * 
 * Copyright: Copyright (c) 2006
 */
public class SMSFile {

	// public static void main(String[] args) {
	// CrewPhoneListAllFlt cflt2 = new CrewPhoneListAllFlt("2006", "04", "13");
	// ArrayList al = null;
	// try {
	// System.out.println(new java.util.Date() + "\tSTART!!");
	// // cflt2.initFLYData();
	// cflt2.initFLYData2("08", "46", "1");
	// System.out.println(new java.util.Date() + "\tEND!!");
	// al = cflt2.getDataAL();
	//
	// SMSFile sm = new SMSFile("2006", null, al, "640073");
	// sm.setMutipleFlt(true);
	// sm.initData();
	// System.out.println("ok!!");
	// } catch (SQLException e) {
	// e.printStackTrace();
	// } catch (Exception e) {
	// e.printStackTrace();
	// }
	// }

	private String fdate;
	private String fltno;
	private ArrayList dataAL;
	private String user;
	private boolean mutipleFlt = false;
	/**
	 * @param fdate
	 *            yyyy/mm/dd
	 * @param fltno
	 *            Flight number
	 * @param dataAL
	 *            ArrayList (CrewPhoneListObj)
	 * @param user
	 *            make file user
	 */
	public SMSFile(String fdate, String fltno, ArrayList dataAL, String user) {
		this.fdate = fdate;
		this.fltno = fltno;
		this.dataAL = dataAL;
		this.user = user;
	}

	public void setMutipleFlt(boolean allFlt) {
		this.mutipleFlt = allFlt;
	}

	public void initData() throws IOException {
		if (mutipleFlt) {
			makeMutipleFlt();
		} else {
			makeFlt();
		}
	}
	/**
	 * 製作單一航班的手機號碼檔案
	 * 
	 * @return
	 * @throws IOException
	 * 
	 */
	public boolean makeFlt() throws IOException {
		FileWriter fw = null;
		FileWriter fw2 = null;// 製作個人化簡訊的txt file
		FileWriter fwLog = null;
		boolean status = false;

		for (int i = 0; i < dataAL.size(); i++) {
			CrewPhoneListObj o = (CrewPhoneListObj) dataAL.get(i);
			// 判斷mphone是否為10位數字
			int count = 0;
			for (int j = 0; j < o.getMphone().length(); j++) {
				char cc = o.getMphone().charAt(j);
				if ("0123456789".indexOf(cc) >= 0) {
					count++;
				}
			}
			if (count != 10) {
				dataAL.remove(i);
				i--;
			}

		}

		try {
			fw = new FileWriter(
					"/apsource/csap/projfz/webap/FZ/tsa/SMS/sms.txt", false);

			fwLog = new FileWriter(
					"/apsource/csap/projfz/webap/FZ/tsa/SMS/smsLog.txt", true);

			fw2 = new FileWriter(
					"/apsource/csap/projfz/webap/FZ/tsa/SMS/sms2.txt", false);
			fwLog
					.write("******************************************************");
			fwLog.write("\r\nWrite file at: " + new java.util.Date() + "\t by "
					+ user + "\r\n");
			fwLog.write("Date\t\tFltno\tEmpno\tPhone\r\n");
			for (int i = 0; i < dataAL.size(); i++) {
				CrewPhoneListObj o = (CrewPhoneListObj) dataAL.get(i);
				fw.write(o.getMphone() + "\r\n");
				fwLog.write(fdate + "\t" + fltno + "\t" + o.getEmpno() + "\t"
						+ o.getMphone() + "\r\n");
				// fw2.write(smsphone + "\t" + cname + "\t" + fltno
				// + "\r\n");
				fw2.write(o.getMphone() + "," + o.getCname() + "," + fltno
						+ "\r\n");

			}
			fwLog.write("Make File in  " + dataAL.size() + " message(s)"
					+ "\r\n");

			status = true;
		} finally {
			try {
				fw.flush();
				fwLog.flush();
				fw2.flush();
			} catch (Exception e) {}
			try {
				if (fw != null)
					fw.close();
				if (fwLog != null)
					fwLog.close();
				if (fw2 != null)
					fw2.close();
			} catch (Exception e) {}

		}
		return status;
	}
	/**
	 * 製作多航班之手機號碼檔案
	 * 
	 * @return
	 * @throws IOException
	 * 
	 */
	public boolean makeMutipleFlt() throws IOException {
		FileWriter fw = null;
		FileWriter fw2 = null;// 製作個人化簡訊的txt file
		FileWriter fwLog = null;
		boolean status = false;

		// 去除非10位數mphone
		for (int i = 0; i < dataAL.size(); i++) {
			SMSFlightObj o = (SMSFlightObj) dataAL.get(i);
			// 判斷mphone是否為10位數字

			ArrayList al = o.getCrewPhoneList();

			for (int idx = 0; idx < al.size(); idx++) {
				int count = 0;
				CrewPhoneListObj cobj = (CrewPhoneListObj) al.get(idx);

				for (int j = 0; j < cobj.getMphone().length(); j++) {
					char cc = cobj.getMphone().charAt(j);
					if ("0123456789".indexOf(cc) >= 0) {
						count++;
					}
				}
				if (count != 10) {
					al.remove(idx);

					idx--;
				}
			}

		}

		try {
			fw = new FileWriter(
					"/apsource/csap/projfz/webap/FZ/tsa/SMS/sms.txt", false);

			fwLog = new FileWriter(
					"/apsource/csap/projfz/webap/FZ/tsa/SMS/smsLog.txt", true);

			fw2 = new FileWriter(
					"/apsource/csap/projfz/webap/FZ/tsa/SMS/sms2.txt", false);

			fwLog
					.write("******************************************************");
			fwLog.write("\r\nWrite file at: " + new java.util.Date() + "\t by "
					+ user + "\r\n");
			fwLog.write("Date\t\tFltno\tEmpno\tPhone\r\n");

			for (int i = 0; i < dataAL.size(); i++) {
				SMSFlightObj sobj = (SMSFlightObj) dataAL.get(i);
				ArrayList al = sobj.getCrewPhoneList();
				for (int idx = 0; idx < al.size(); idx++) {
					CrewPhoneListObj o = (CrewPhoneListObj) al.get(idx);

					fw.write(o.getMphone() + "\r\n");
					fwLog.write(sobj.getFdate() + "\t" + sobj.getFltno() + "\t"
							+ o.getEmpno() + "\t" + o.getMphone() + "\r\n");

					fw2.write(o.getMphone() + "," + o.getCname() + ","
							+ sobj.getFltno() + "\r\n");
				}

			}
			fwLog.write("Make File in  " + dataAL.size() + " Flight(s)"
					+ "\r\n");

			
			
			status = true;
		} finally {
			try {
				fw.flush();
				fwLog.flush();
				fw2.flush();
			} catch (Exception e) {}
			try {
				if (fw != null)
					fw.close();
				if (fwLog != null)
					fwLog.close();
				if (fw2 != null)
					fw2.close();
			} catch (Exception e) {}

		}
		return status;
	}

	/**
	 * 取得家屬電話
	 * 
	 * @param dataAL
	 *            組員名單
	 * @return
	 * 
	 */
	public ArrayList getContactNumber(ArrayList dataAL) {
	
		ArrayList contactAL = null;
		if (dataAL == null) {
			contactAL = null;
		} else {
			// 1.取得所有組員家屬聯絡電話
	
			ContactPhone cp = new ContactPhone();
			try {
				cp.SelectData();
			} catch (Exception e) {
	
			}
	
			// 2.比對組員名單，剔除不在組員名單內者
	
			if (cp.getDataAL() != null) {
	
				if (mutipleFlt) {
					// 取得多航班
	
					for (int i = 0; i < dataAL.size(); i++) {
						SMSFlightObj sobj = (SMSFlightObj) dataAL.get(i);
						ArrayList al = sobj.getCrewPhoneList();
	
						for (int idx = 0; idx < al.size(); idx++) {
							CrewPhoneListObj o = (CrewPhoneListObj) al.get(idx);
	
							for (int j = 0; j < cp.getDataAL().size(); j++) {
								ContactPhoneObj obj = (ContactPhoneObj) cp
										.getDataAL().get(j);
								if (o.getEmpno().equals(obj.getEmpno())) {
	
									if (contactAL == null) {
										contactAL = new ArrayList();
									}
									obj.setFdate(fdate);
									obj.setFltno(sobj.getFltno());
									obj.setCrewName(o.getCname());
									contactAL.add(obj);
	
								}
	
							}
						}
					}
	
				} else {
					// 單一航班
	
					for (int i = 0; i < dataAL.size(); i++) {
						CrewPhoneListObj o = (CrewPhoneListObj) dataAL.get(i);
						for (int j = 0; j < cp.getDataAL().size(); j++) {
							ContactPhoneObj obj = (ContactPhoneObj) cp
									.getDataAL().get(j);
							if (o.getEmpno().equals(obj.getEmpno())) {
								if (contactAL == null) {
									contactAL = new ArrayList();
								}
								obj.setCrewName(o.getCname());
								obj.setFltno(fltno);
								contactAL.add(obj);
	
							}
	
						}
					}
	
				}
	
			}
	
			// 去除非10位數字的號碼
			if (contactAL != null) {
				for (int i = 0; i < contactAL.size(); i++) {
					ContactPhoneObj obj = (ContactPhoneObj) contactAL.get(i);
					int count = 0;
	
					for (int j = 0; j < obj.getPhoneNumber().length(); j++) {
						char cc = obj.getPhoneNumber().charAt(j);
						if ("0123456789".indexOf(cc) >= 0) {
							count++;
						}
					}
					if (count != 10) {
						contactAL.remove(i);
						i--;
					}
				}
	
			}
	
		}
		return contactAL;
	
	}
}
