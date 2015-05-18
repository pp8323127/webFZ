/*
 * 讀取檔案，傳回字串
 */

package df.flypay;

import java.io.*;

/**
 * @param filePath:要讀入的檔案完整路徑
 */

public class ReadFile {
    private String Notice = null;

//    public static void main(String[] args) {
//        ReadFile rd = new ReadFile();
//        String a = rd.getFileString("C:\\noticeFlypay.txt");
//        System.out.println(a);
//
//    }

    public String getFileString(String filePath) {

        File aFile = new File(filePath);
        if ( aFile.isDirectory() && !aFile.isFile() ) {
            Notice = "It is not a file";
            return Notice;

        }
        if ( !aFile.exists() ) {
            Notice = "File is not exist";
            return Notice;

        }

        FileReader fr = null;
        BufferedReader br = null;
        StringBuffer sb = new StringBuffer();

        try {
            fr = new FileReader(aFile);
            br = new BufferedReader(fr);
            while (br.ready()) {
                sb.append(br.readLine());
                sb.append("\n");
            }
            if ( sb != null ) {
                Notice = sb.toString();
            }
        } catch (FileNotFoundException e) {
            Notice = e.toString();
            return Notice;

        } catch (IOException e) {
            Notice = e.toString();
            return Notice;
        } finally {
            try {
                if ( fr != null ) fr.close();
            } catch (IOException e) {}
            try {
                if ( br != null ) br.close();
            } catch (IOException e) {}
        }
        return Notice;

    }

}