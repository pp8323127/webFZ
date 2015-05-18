package QRcode;

import java.awt.*;
import java.awt.image.*;
import java.io.File;
import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.GregorianCalendar;

import javax.imageio.ImageIO;

import ci.db.ConnDB;
import ci.db.ConnectionHelper;

import com.swetake.util.Qrcode;

public class EnQRCode {

	/**
	 * @param args
	 */
	private String err ="";
	
	public static void main(String[] args) { 
		// TODO Auto-generated method stub
		EnQRCode a = new EnQRCode();
		String str = "20140821,0006,TPE,LAX,640001,640002,640003,640004,640005";//,640006,640007,640008,640009,640010,640011,640012,640013,640014,640015,640016,640017,640018,640019,640020,640021";
//		System.out.println(a.makeqrcode);
//		String str1 = "'632948','643051','630231','634722','634167','642092','643742','643745','632948','632949'," +
//						"'632950','632951','632952','632953','632954','632955','632956','632957','632958','632959','632960',";
//		String fltno = "";
//		String sect = "";
//		String fltd = "";
//		System.out.println(a.empnoChkJobno(str1.substring(0,str1.length()-1), fltno, sect, fltd));

	}
	//3.產生QR Code
	public BufferedImage makeqrcode(String str ,String info) {
        // 設定圖檔寬度 140*140
        BufferedImage bi = new BufferedImage(180, 180,
                BufferedImage.TYPE_INT_RGB);
        try {
 
            // Constructor Qrcode Object
            Qrcode testQrcode = new Qrcode();
            //容錯率L M Q H 
            testQrcode.setQrcodeErrorCorrect('M');
            //字元模式,N A 或其它的A是英文,N是數字,其它是8 byte
            testQrcode.setQrcodeEncodeMode('B');
            //可使用的字串長短跟所設定的QrcodeVersion有關,越大可設定的字越多
            //0-40,0是自動
            testQrcode.setQrcodeVersion(10);
 
            // 設定QR Code 編碼內容
//            str = "643937\r\n" +
//            		"635863\r\n" +
//            		"633020\r\n";
            // 把字串變成byte陣列
            byte[] d = str.getBytes("Utf-8");
 
            // createGraphics
            Graphics2D g = (Graphics2D) bi.getGraphics();
 
            // set background
            g.setBackground(Color.WHITE);
            g.clearRect(0, 0, 200, 200);
 
            // 設定字型顏色 => BLACK
            g.setColor(Color.BLACK);
 
            // 轉出 Bytes
 
            if (d.length > 0 && d.length < 200) {
                boolean[][] s = testQrcode.calQrcode(d);
                for (int i = 0; i < s.length; i++) {
                    for (int j = 0; j < s.length; j++) {
                        if (s[j][i]) {
                            g.fillRect(j * 3 + 2, i * 3 + 2, 3, 3);
                        }
                    }
                }
            }else {    
//                System.out.println("QRCode content bytes length = " + d.length + " not in [ 0,200 ]. ");    
            } 
 
            g.dispose();          
            
            bi.flush();
            // 如需輸出成檔案可利用以下方式
            // 設定 產生檔案路徑
            String FilePath="/apsource/csap/projfz/webap/FZ/GD/QRcode"+info+".jpg";
//            		"E:\\TestQRCode.jpg";
            File f = new File(FilePath);
 
            // 產生QRCode JPG File
            ImageIO.write(bi, "jpg", f);
 
        } // end try
        catch (Exception e) {
            setErr(e.toString());
        } // end catch
        return bi;
    }
	
	//2. 顯示有打工組員 ,排除special :S(組長*8名),I(教師OJT),T(學員),P(生病不打工),ACM
	public String empnoChkJobno(String empnoStr,String fltno,String sect,String fltd){
		ConnDB cn = new ConnDB();
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;
        Driver dbDriver = null;
        String sql = null;
        try
        {
            
        	ConnectionHelper ch = new ConnectionHelper();
            con = ch.getConnection();            
            stmt = con.createStatement();       
            
//            sql = "select trim(empn) empn from egtcbas where jobno > 30 and empn in ("+empnoStr+") ";
////            System.out.println(sql);
//            rs = stmt.executeQuery(sql);
//            if(null!= rs){
//            	empnoStr ="";
//            	while(rs.next()){
//                	empnoStr += rs.getString("empn")+",";
//                }  
//            }
            
            sql =" select trim(empn) empn from egtcbas" +
            	 " where trim(empn) in (" +
            	 " select staff_num" +
//            	 " ,dps.duty_cd, r.DUTY_CD, dps.flt_num fltno, to_char(dps.str_dt_tm_loc, 'yyyy/mm/dd') fdate"+
//            	 " ,dps.act_port_a || dps.act_port_b sect, r.special_indicator, Nvl(dps.FLEET_CD,'X') actp" +
            	 " from duty_prd_seg_v dps, roster_v r" +
            	 " where dps.series_num = r.series_num" +
            	 " and dps.delete_ind = 'N' AND r.delete_ind = 'N'" +
            	 " AND dps.str_dt_tm_gmt BETWEEN" +
            	 " to_date('"+fltd+" 00:00', 'yyyy/mm/dd hh24:mi') AND" +
            	 " To_Date('"+fltd+" 23:59', 'yyyy/mm/dd hh24:mi')" +
            	 " AND r.duty_cd = 'FLY' AND dps.duty_cd  = 'FLY'" +
            	 " AND dps.FLT_NUM = '"+fltno+"' AND dps.act_port_a || dps.act_port_b = '"+sect+"'" +
            	 " AND (nvl(special_indicator,' ') not in ('I','S','T','P'))" +
            	 " )" +
            	 " and jobno > 30  " +
            	 " order by empn ";
            rs = stmt.executeQuery(sql);
            
            if(null!= rs){
            	empnoStr ="";
            	while(rs.next()){
                	empnoStr += rs.getString("empn")+",";
                }  
            }
            
      }
      catch(Exception e)
      {
//         empnoStr = e.toString(); 
    	 empnoStr = "Error";
         setErr(e.toString());
      }
      finally
      {
          try{if(rs != null) rs.close();}catch(SQLException e){}
          try{if(stmt != null) stmt.close();}catch(SQLException e){}
          try{if(con != null) con.close();}catch(SQLException e){}
      }
        return empnoStr ;
	}

	//1.是否要印QR code date range & fltno + sect
	public boolean chkApplyDate(String yyyy , String mm, String dd,String fltno,String dpt_short,String arv_short){
		boolean flag = false;
		GregorianCalendar cal1 = new GregorianCalendar();//fltd
		//System.out.println("td:"+cal1.getTime());
		cal1.set(1, Integer.parseInt(yyyy));
		cal1.set(2, Integer.parseInt(mm)-1);
		cal1.set(5, Integer.parseInt(dd));
		cal1.set(10, 0);
		cal1.set(12, 0);
		cal1.set(13, 0);
		GregorianCalendar cal2 = new GregorianCalendar();//3/25生效日
		cal2.set(1, 2015);
		cal2.set(2, 3-1);
		cal2.set(5, 25);
		cal2.set(10, 0);
		cal2.set(12, 0);
		cal2.set(13, 0);
		GregorianCalendar cal3 = new GregorianCalendar();//3/19生效日 test only one day
		cal3.set(1, 2015);
		cal3.set(2, 3-1);
		cal3.set(5, 19);
		cal3.set(10, 0);
		cal3.set(12, 0);
		cal3.set(13, 0);
		
		if (cal1.after(cal2) || cal1.equals(cal2)){
			if("0761TPECGK,0762CGKTPE,0783TPESGN,0784SGNTPE,0791TPEHAN,0792HANTPE,0833TPEBKK,0834BKKTPE,0102KHHNRT,0103NRTKHH,0839KHHBKK,0840BKKKHH,0757KHHSIN,0758SINKHH".indexOf(fltno+dpt_short+arv_short) >= 0){
				flag = true;	
				
			}else{
				flag = false;
			}
		}else if(cal1.equals(cal3)){
			if("0833TPEBKK,0834BKKTPE, 0839KHHBKK,0840BKKKHH".indexOf(fltno+dpt_short+arv_short) >= 0){
				flag = true;
			}else{
				flag = false;
			}
		}else{
			flag = false;
			
		}
		
		return flag;
	}
	
	public String getErr() {
		return err;
	}
	public void setErr(String err) {
		this.err = err;
	}
}
