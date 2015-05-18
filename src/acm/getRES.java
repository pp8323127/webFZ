package acm;

import ci.db.*;
import java.sql.*;
import java.util.*;
import java.text.*;
import java.io.*;

public class getRES
{

	public static void main(String []args)
	{
		try
		{
			getRES t1 = new getRES();
			t1.getAlcs();
//			System.out.println(t1.getStr());
		}
		catch (Exception e)
		{
			System.out.println(e.toString());
		}
	}

	String srcpath = "/apsource/csap/projfz/webap/FZ/tsa/ACMList/mailin/";
	String copypath = "/apsource/csap/projfz/webap/FZ/tsa/ACMList/mailinBackup/";
//	String srcpath = "C:\\getRES\\mailin\\";
//	String copypath = "C:\\getRES\\mailinBackup\\";
	String srcFile = "CREWRES.TXT";
	String useFile = "BOOK.TXT";
	String renameFile = "";
	String sql  = "";
	String tempsql  = "";
	String getSect = "";
	String curryyyy = "";	
	String currmm = "";	
	String currdd = "";	
	String fileDate = "";
	int versf = 1;
	boolean isNewFile = true;
	String errstr = "Y";

	Connection conn = null;
	Driver dbDriver = null;
	PreparedStatement pstmt = null;
	Statement stmt = null;
	ResultSet rs = null;
	ConnDB cn = new ConnDB();
 
    //*****************************************************
    public void getAlcs() //throws Exception
	{
		ArrayList fltnoAL = new ArrayList();
		ArrayList dateAL = new ArrayList();
		ArrayList secAL = new ArrayList();
		ArrayList classAL = new ArrayList();
		ArrayList numAL = new ArrayList();
		ArrayList codeAL = new ArrayList();
		ArrayList bkidAL = new ArrayList();
		ArrayList statusAL = new ArrayList();

		//named backup file
		java.util.Date curDate = Calendar.getInstance().getTime();
		String yyyy = new SimpleDateFormat("yyyy",Locale.UK).format(curDate);
		String mm = new SimpleDateFormat("MM",Locale.UK).format(curDate);
		String dd = new SimpleDateFormat("dd",Locale.UK).format(curDate);
		renameFile = yyyy+mm+dd;

		try
		{
		//src file CREWRES.TXT
		java.io.File fsrc = new java.io.File(srcpath+srcFile);

		if (fsrc.exists())
		{
			//CREWRES.TXT exist, copy to new file named BOOK.TXT and rename original one
			//get file modified time
			DateFormat df = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");	
			java.util.Date gDate = new java.util.Date(fsrc.lastModified());
			fileDate = df.format(gDate).toString();

			//COPY file start**********************************
			BufferedReader br = new BufferedReader(new FileReader(fsrc));
			StringBuffer sb = null;
			String str = null;
			while ((str = br.readLine()) != null) 
			{
				if (sb == null)
				{
					sb = new StringBuffer();
				}
				sb.append(str);
				sb.append("\n");
			}

			if(br != null)
			{
				br.close();
			}
			//copy to new file named BOOK.TXT
			FileWriter fcopy = new FileWriter(copypath+useFile,false);
			fcopy.write(sb.toString());
			fcopy.close();
			//COPY file end*****************************************

			//copy to new file named TEMP.TXT
			FileWriter tcopy = new FileWriter(copypath+renameFile+".TXT",false);
			tcopy.write(sb.toString());
			tcopy.close();
			//COPY file end*****************************************
			//delete src file
			fsrc.delete(); 
			//delete src file end***************************************
		}
		else
		{
			isNewFile = false;
		}

		}
		catch (Exception e)
		{
			System.out.println(e.toString());
		}

		// insert res into DB
		if (isNewFile == true)
		{
			try //must try and catch,otherwide will compile error
			{
			java.io.File file_in=new java.io.File(copypath+useFile);

			if (file_in.exists() == true)
			{
				BufferedReader br = new BufferedReader(new FileReader(file_in));
				StringBuffer sb = null;
				String str = null;

				//str like  CI|0004|050426|TPESFO|C|0001|K2QAEU|XXDHC/A
				while ((str = br.readLine()) != null) 
				{
					splitString s = new splitString();
					String[] token = s.doSplit(str,"|");
					for (int i = 0; i < 8; i++)
					{
						//System.out.println(i+"  --> "+token[i].trim()+"<BR>");
						if (i==1)
						{
							fltnoAL.add(token[i].trim());
						}

						if (i==2)
						{
							dateAL.add("20"+token[i].trim());
						}

						if (i==3)
						{
							secAL.add(token[i].trim());
						}

						if (i==4)
						{
							classAL.add(token[i].trim());
						}

						if (i==5)
						{
							numAL.add(token[i].trim());
						}

						if (i==6)
						{	//K2SHDH
							bkidAL.add(token[i].trim());
						}

						if (i==7)
						{
							splitString s2 = new splitString();
							//token[i].trim() == XXDHC/A/A/A
							String[] token2 = s2.doSplit(token[i].trim(),"/");
							//get like O or A or E or 
							codeAL.add(token2[1].trim());
						}
					}//for (int i = 0; i < 8; i++)
				}//while ((str = br.readLine()) != null) 

				if(br != null)
				{
					br.close();
				}

			}// (file_in.exists() == true)

			if(file_in != null)
			{
				file_in.exists();
			}

			}
			catch (Exception e)
			{
				System.out.println(e.toString());
				errstr = e.toString();
			}

			if (fltnoAL.size() > 0)
			{
				//Insert ALCS book records
				try
				{
				//cn.setORT1FZ();
//				cn.setORP3FZUser();
//				java.lang.Class.forName(cn.getDriver());
//				conn = DriverManager.getConnection(cn.getConnURL(), cn.getConnID(),cn.getConnPW());
				
				cn.setORP3FZUserCP();
	    		dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	    		conn = dbDriver.connect(cn.getConnURL(), null);
				stmt = conn.createStatement();

				//Keep the record in two months
				sql = "delete from fztacmr where (( chgstatus = 'INS' and To_Char(fltd,'yyyymmdd') >= To_Char(SYSDATE,'yyyymmdd') ) or (chgstatus = 'VIW'))";
				stmt.executeUpdate(sql);
				stmt.executeUpdate("commit");

				sql = "insert into fztacmr values (fzqseq.nextval,to_date(?,'yyyymmdd'), ?, ?,?,?,?,to_number(?),to_number(?),?,to_date('"+fileDate+"','yyyy/mm/dd hh24:mi:ss'),'RES') ";
				pstmt = conn.prepareStatement(sql);

				for (int j = 0; j < fltnoAL.size(); j++)
				{
					if(dateAL.get(j).toString().compareTo(renameFile) >= 0)
					{//insert the data of today or later than today
					pstmt.setString(1, dateAL.get(j).toString());
					pstmt.setString(2, fltnoAL.get(j).toString());
					pstmt.setString(3, secAL.get(j).toString());
					pstmt.setString(4, classAL.get(j).toString());
					pstmt.setString(5, bkidAL.get(j).toString());
					pstmt.setString(6, codeAL.get(j).toString());
					pstmt.setString(7, numAL.get(j).toString());
					pstmt.setString(8, numAL.get(j).toString());
					pstmt.setString(9, "INS");
					pstmt.addBatch();
					}
					else
					{//before today
					pstmt.setString(1, dateAL.get(j).toString());
					pstmt.setString(2, fltnoAL.get(j).toString());
					pstmt.setString(3, secAL.get(j).toString());
					pstmt.setString(4, classAL.get(j).toString());
					pstmt.setString(5, bkidAL.get(j).toString());
					pstmt.setString(6, codeAL.get(j).toString());
					pstmt.setString(7, numAL.get(j).toString());
					pstmt.setString(8, numAL.get(j).toString());
					pstmt.setString(9, "VIW");
					pstmt.addBatch();
					}
					
//					System.out.println(dateAL.get(j).toString());
//					System.out.println(fltnoAL.get(j).toString());
//					System.out.println(secAL.get(j).toString());
//					System.out.println(classAL.get(j).toString());
//					System.out.println(bkidAL.get(j).toString());
//					System.out.println(codeAL.get(j).toString());
//					System.out.println(numAL.get(j).toString());
//					System.out.println(numAL.get(j).toString());
//					System.out.println("***********************");
//					tempsql = "insert into fztacmr values (fzqseq.nextval,to_date('"+dateAL.get(j).toString()+"','yyyymmdd'), '"+fltnoAL.get(j).toString()+"', '"+secAL.get(j).toString()+"','"+classAL.get(j).toString()+"','"+bkidAL.get(j).toString()+"','"+codeAL.get(j).toString()+"',to_number('"+numAL.get(j).toString()+"'),to_number('"+numAL.get(j).toString()+"'),'viw',to_date('"+fileDate+"','yyyy/mm/dd hh24:mi:ss'),'RES') ";
				}
				pstmt.executeBatch();

				// group by fltd, fltno, sect, bknitem  and re-insert 
				//when bknitem has two-code 				
				//***********************************************
				sql = "SELECT to_char(fltd,'yyyy/mm/dd') as fltd, fltno, sect, bknitem, chgstatus, Sum(chgnum) as c FROM fztacmr WHERE ((chgstatus = 'INS' and To_Char(fltd,'yyyymmdd') >= To_Char(SYSDATE,'yyyymmdd')) or (chgstatus = 'VIW')) and length(rtrim(bknitem)) >= 2 GROUP BY fltd, fltno, sect, bknitem, chgstatus ";
				rs = stmt.executeQuery(sql);

				fltnoAL.clear();
				dateAL.clear();
				secAL.clear();
				classAL.clear();
				numAL.clear();
				codeAL.clear();
				statusAL.clear();

				while(rs.next())
				{
					dateAL.add(rs.getString("fltd"));
					fltnoAL.add(rs.getString("fltno"));
					secAL.add(rs.getString("sect"));
					classAL.add("N");
					codeAL.add(rs.getString("bknitem"));
					statusAL.add(rs.getString("chgstatus"));
					numAL.add(rs.getString("c"));
				}

				// group by fltd, fltno, sect, class, bknitem  and re-insert 
				//when bknitem has one-code 				
				//***********************************************
				sql = "SELECT to_char(fltd,'yyyy/mm/dd') as fltd, fltno, sect, class, bknitem, chgstatus, Sum(chgnum) as c FROM fztacmr WHERE ((chgstatus = 'INS' and To_Char(fltd,'yyyymmdd') >= To_Char(SYSDATE,'yyyymmdd')) or (chgstatus = 'VIW')) and length(rtrim(bknitem)) = 1 GROUP BY fltd, fltno, sect, class, bknitem, chgstatus ";
				rs = stmt.executeQuery(sql);

				while(rs.next())
				{
					dateAL.add(rs.getString("fltd"));
					fltnoAL.add(rs.getString("fltno"));
					secAL.add(rs.getString("sect"));
					classAL.add(rs.getString("class"));
					codeAL.add(rs.getString("bknitem"));
					statusAL.add(rs.getString("chgstatus"));
					numAL.add(rs.getString("c"));
				}

				// delete previous record
				sql = "delete from fztacmr where ((chgstatus = 'INS' and To_Char(fltd,'yyyymmdd') >= To_Char(SYSDATE,'yyyymmdd') ) or (chgstatus = 'VIW')) ";
				stmt.executeUpdate(sql);
				stmt.executeUpdate("commit");

				sql = "insert into fztacmr values (fzqseq.nextval, to_date(?,'yyyy/mm/dd'), ?, ?,?,'KKKKKK',?,to_number(?), to_number(?),?,to_date('"+fileDate+"','yyyy/mm/dd hh24:mi:ss'), 'RES') ";
				pstmt = null;
				pstmt = conn.prepareStatement(sql);

				if (fltnoAL.size() > 0)
				{
					for (int k = 0; k < fltnoAL.size(); k++)
					{
						pstmt.setString(1, dateAL.get(k).toString());
						pstmt.setString(2, fltnoAL.get(k).toString());
						pstmt.setString(3, secAL.get(k).toString());
						pstmt.setString(4, classAL.get(k).toString());
						pstmt.setString(5, codeAL.get(k).toString());
						pstmt.setString(6, numAL.get(k).toString());
						pstmt.setString(7, numAL.get(k).toString());
						pstmt.setString(8, statusAL.get(k).toString());
						pstmt.addBatch();
//						tempsql = "insert into fztacmr values (fzqseq.nextval,to_date('"+dateAL.get(k).toString()+"','yyyymmdd'), '"+fltnoAL.get(k).toString()+"', '"+secAL.get(k).toString()+"','"+classAL.get(k).toString()+"','"+bkidAL.get(k).toString()+"','KKKKKK',to_number('"+numAL.get(k).toString()+"'),to_number('"+numAL.get(k).toString()+"'),'viw',to_date('"+fileDate+"','yyyy/mm/dd hh24:mi:ss'),'RES') ";
					}
					pstmt.executeBatch();
				}
				//***********************************************
				}
				catch (Exception e)
				{
//				    System.out.println(tempsql);
					System.out.println(e.toString());
					errstr = e.toString();
				}
				finally
				{
					try{if(rs != null) rs.close();}catch(SQLException e){}
					try{if(stmt != null) stmt.close();}catch(SQLException e){}
					try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
					try{if(conn != null) conn.close();}catch(SQLException e){}
				}

			}//end of if (fltnoAL.size() > 0)
		}//(isNewFile == true)
	}
    
//    public String getStr()
//    {
//        return errstr;
//    }
    
}

