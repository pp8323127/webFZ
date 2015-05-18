package ws.header;

import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESedeKeySpec;

import com.sun.crypto.provider.*;
import com.sun.org.apache.xml.internal.security.exceptions.Base64DecodingException;
import com.sun.org.apache.xml.internal.security.utils.Base64;

public class DESede {

    /**
     * @param args
     */
	/*vCSUdVv8w3NfnmHsw8elPA==*/
    public static void main(String[] args) {
    	
//    	DateFormat df = new SimpleDateFormat("yyyyMMdd");
//		String strText = df.format(new Date()) + "CS#APP";
		DESede d = new DESede();
////        String strText = "This is a testing";
//
//        String text1 = d.encryptProperty(strText);
//
//        String text2 = d.decryptProperty(text1);
//
//        System.out.println(text1);
//
//        System.out.println(text2);
        System.out.println(d.auth("h9H0j54SfCBfnmHsw8elPA=="));
        
    }
    
    public boolean auth(String pwd){
        boolean result = false;
        DateFormat df = new SimpleDateFormat("yyyyMMdd");
        String strText = df.format(new Date()) + "CS#APP";
        DESede d = new DESede();
        String deText = d.encryptProperty(strText);
//        System.out.println(deText);
        if(null != pwd){
            if(deText.equals(pwd)){
                result = true;
            }
        }
        return result;
    }
    

    public  String encryptProperty(String clearText) {
        DESede d = new DESede();
        String KEY_STRING = "RRYa6li5NGFodgKUtvS1I6fZwY8xpJjI";

        byte[] key = null;

        try {
            key = Base64.decode(KEY_STRING);
        } catch (Base64DecodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return d.performDESedeCoder(clearText, key, true);
    }

    public  String decryptProperty(String cipherText) {
        DESede d = new DESede();
        String KEY_STRING = "RRYa6li5NGFodgKUtvS1I6fZwY8xpJjI";

        byte[] key = null;

        try {
            key = Base64.decode(KEY_STRING);
        } catch (Base64DecodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return d.performDESedeCoder(cipherText, key, false);
    }

    public  String performDESedeCoder(String inputValue, byte[] key,
            boolean encrypt) {
        String rtnValue = "";

        String KEY_ALGORITHM = "DESede";
        String CIPHER_ALGORITHM = "DESede/ECB/PKCS5Padding";

        byte[] data = null;
        try {
            DESedeKeySpec dks = new DESedeKeySpec(key);

            SecretKeyFactory keyFactory = SecretKeyFactory
                    .getInstance(KEY_ALGORITHM);

            SecretKey secretKey = keyFactory.generateSecret(dks);

            Cipher cipher = Cipher.getInstance(CIPHER_ALGORITHM);

            byte[] input = null;
            if (encrypt) {
                cipher.init(Cipher.ENCRYPT_MODE, secretKey);
                input = inputValue.getBytes();
            } else {
                cipher.init(Cipher.DECRYPT_MODE, secretKey);
                input = Base64.decode(inputValue);
            }

            data = cipher.doFinal(input);
        } catch (InvalidKeyException e) {
            System.out.println(e.getMessage());
        } catch (NoSuchAlgorithmException e) {
            System.out.println(e.getMessage());
        } catch (InvalidKeySpecException e) {
            System.out.println(e.getMessage());
        } catch (NoSuchPaddingException e) {
            System.out.println(e.getMessage());
        } catch (IllegalBlockSizeException e) {
            System.out.println(e.getMessage());
        } catch (BadPaddingException e) {
            System.out.println(e.getMessage());
        } catch (Base64DecodingException e) {
            System.out.println(e.getMessage());
        }

        if (data == null) {
            rtnValue = inputValue;
        } else {
            if (encrypt) {
                rtnValue = com.sun.org.apache.xml.internal.security.utils.Base64
                        .encode(data);
            } else {
                rtnValue = new String(data);
            }
        }

        return rtnValue;
    }
}