package ws.header;

import java.security.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.crypto.*;
import javax.crypto.spec.SecretKeySpec;
/*3a3aad2acffdeba018d5a8b82064d1d6*/
public class ThreeDes {
    
    public static void main(String[] args) {
      Security.addProvider(new com.sun.crypto.provider.SunJCE());
//      final byte[] keyBytes = { 0x11, 0x22, 0x4F, 0x58, (byte) 0x88, 0x10,
//              0x40, 0x38, 0x28, 0x25, 0x79, 0x51, (byte) 0xCB, (byte) 0xDD,
//              0x55, 0x66, 0x77, 0x29, 0x74, (byte) 0x98, 0x30, 0x40, 0x36,
//              (byte) 0xE2 };
        final byte[] keyBytes = 
                { 0x31, 0x23, 0x3F, 0x38,    
                (byte) 0x83, 0x13, 0x42, 0x30, 0x08, 0x45, 0x39, 0x41, 
                (byte) 0x38, (byte) 0xDD, 0x51, 0x61, 0x77, 0x29, 0x74, 
                (byte) 0xCB, 0x30, 0x40,  0x36, 
                (byte) 0xE2 };
//      System.out.println(new String(keyBytes));
      //String szSrc = "This is a 3DES test. 測試";
      DateFormat df = new SimpleDateFormat("yyyyMMdd");
      String szSrc = df.format(new Date()) + "CS#APP";
      System.out.println("加密前的字串:" + szSrc);
      
      String encoded = mybyte2hex(encryptMode(keyBytes, szSrc.getBytes()));
      
      //This is OTS password
      System.out.println("加密後的字串:" + encoded);        
//      
      byte[] srcBytes = decryptMode(keyBytes, myhex2byte(encoded));
      System.out.println("解密後的字串:" + (new String(srcBytes).substring(8)));
        ThreeDes d = new ThreeDes();
//      System.out.println(d.auth("ec6530721b4986fc840c5b83b68c76e9")); 
//      System.out.println(d.auth("a6890f03bbc21100840c5b83b68c76e9"));
//        System.out.println(d.auth("3a3aad2acffdeba018d5a8b82064d1d6"));
    }
	private static final String Algorithm = "DESede";
	private static final String CipherAlg = "DESede/ECB/PKCS5Padding";

//	public static final byte[] keyBytes = { 0x12, 0x66, 0x37, 0x52, (byte) 0x86, 0x12,
//			0x75, 0x06, 0x58, 0x22, (byte) 0x96, 0x32, 0x67, (byte) 0x88,
//			0x17, 0x11, 0x76, 0x21, 0x52, (byte) 0x96, 0x23, 0x09, 0x76,
//			0x67};
	
    public static final byte[] keyBytes =  { 0x31, 0x23, 0x3F, 0x38,    
        (byte) 0x83, 0x13, 0x42, 0x30, 0x08, 0x45, 0x39, 0x41, 
        (byte) 0x38, (byte) 0xDD, 0x51, 0x61, 0x77, 0x29, 0x74, 
        (byte) 0xCB, 0x30, 0x40,  0x36, 
        (byte) 0xE2 };
	
	public boolean auth(String pwd){
	    boolean result = false;
	    Security.addProvider(new com.sun.crypto.provider.SunJCE());
//        final byte[] keyBytes = { 0x11, 0x22, 0x4F, 0x58, (byte) 0x88, 0x10,
//              0x40, 0x38, 0x28, 0x25, 0x79, 0x51, (byte) 0xCB, (byte) 0xDD,
//              0x55, 0x66, 0x77, 0x29, 0x74, (byte) 0x98, 0x30, 0x40, 0x36,
//              (byte) 0xE2 };
	    final byte[] keyBytes = { 0x31, 0x23, 0x3F, 0x38,    
                (byte) 0x83, 0x13, 0x42, 0x30, 0x08, 0x45, 0x39, 0x41, 
                (byte) 0x38, (byte) 0xDD, 0x51, 0x61, 0x77, 0x29, 0x74, 
                (byte) 0xCB, 0x30, 0x40,  0x36, 
                (byte) 0xE2 };
	    try{
	        DateFormat df = new SimpleDateFormat("yyyyMMdd");
//	        String oriPwd = df.format(new Date()) + "CS#APP";
	        String oriPwd = "CS#APP";
	        byte[] srcBytes = decryptMode(keyBytes, myhex2byte(pwd));        
	        String detxt = new String(srcBytes);
//	        System.out.println(oriPwd);
//	        System.out.println(detxt);
	        
	        if(null != pwd){
	            if(detxt.substring(8).equals(oriPwd)){
	                result = true;
	            }
	        } 
	        
	    }catch(Exception e){
	        return false;
	    }
	    
        return result;
    }
	
	// keybyte為加密密鑰 長度24長度24byte
	// src為被加密的字串緩衝區
	public static byte[] encryptMode(byte[] keybyte, byte[] src) {
		try {
			SecretKey deskey = new SecretKeySpec(keybyte, Algorithm);
			Cipher c1 = Cipher.getInstance(CipherAlg);
			c1.init(Cipher.ENCRYPT_MODE, deskey);
			return c1.doFinal(src);
		} catch (java.security.NoSuchAlgorithmException e1) {
//			e1.printStackTrace();
		} catch (javax.crypto.NoSuchPaddingException e2) {
//			e2.printStackTrace();
		} catch (java.lang.Exception e3) {
//			e3.printStackTrace();
		}
		return null;
	}

	// keybyte為加密密鑰 長度24byte
	// src為加密後的字串緩衝區
	public static byte[] decryptMode(byte[] keybyte, byte[] src) {
		try {
			SecretKey deskey = new SecretKeySpec(keybyte, Algorithm);
			Cipher c1 = Cipher.getInstance(CipherAlg);
			c1.init(Cipher.DECRYPT_MODE, deskey);
			return c1.doFinal(src);
		} catch (java.security.NoSuchAlgorithmException e1) {
//			e1.printStackTrace();
		} catch (javax.crypto.NoSuchPaddingException e2) {
//			e2.printStackTrace();
		} catch (java.lang.Exception e3) {
//			e3.printStackTrace();
		}
		return null;
	}

	public static String byte2hex(byte[] b) {
		String hs = "";
		String stmp = "";
		for (int n = 0; n < b.length; n++) {
			stmp = (java.lang.Integer.toHexString(b[n] & 0XFF));
			if (stmp.length() == 1)
				hs = hs + "0" + stmp;
			else
				hs = hs + stmp;
			if (n < b.length - 1)
				hs = hs + ":";
		}
		return hs.toUpperCase();
	}

	public static String mybyte2hex(byte[] data) {
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < data.length; i++) {
            String temp = Integer.toHexString(((int) data[i]) & 0xFF);
            for(int t = temp.length();t<2;t++)
            {
                sb.append("0");
            }
            sb.append(temp);
        }
        return sb.toString();
    }
    public static byte[] myhex2byte(String hexStr){
        byte[] bts = new byte[hexStr.length() / 2];
        for (int i = 0,j=0; j < bts.length;j++ ) {
           bts[j] = (byte) Integer.parseInt(hexStr.substring(i, i+2), 16);
           i+=2;
        }
        return bts;
    }

	
}