<%@ page contentType="text/html;charset=big5" import="java.io.*, java.net.*"%><%   
    // 下載檔案   
    //String exportPath = application.getRealPath("/") + "/txtin/mvc/";   
	String exportPath = "/apsource/csap/projfz/txtin/mvc/";   
    String filename = "mvcRecord.htm";   
    filename = new String(filename.getBytes("ISO-8859-1"), "Big5");   
    File file = new File(exportPath + filename);   
    if (file.exists()) 
	{   
        response.setHeader("Content-Disposition",   
                "attachment; filename=\""   
                        + URLEncoder.encode(filename, "UTF-8") + "\"");   
        try {   
            OutputStream output = response.getOutputStream();   
            InputStream in = new FileInputStream(file);   
            int c = in.read();   
            while (c != -1) {   
                output.write(c);   
                c = in.read();   
            }   
            in.close();   
            output.close(); // remember to close the OutputStream   
        } catch (Exception e) {   
            System.out.println(e.getMessage());   
            e.printStackTrace();
        }          
    } else {   
        out.println("檔案"+filename+"不存在");   
    }   
%>  
