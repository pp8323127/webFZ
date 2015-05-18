
package fz.pracP;

public class UpdCfltCol {

    public static void main(String[] args) {
                    String[] list = new String[20];
                    String allColumn = "";
         for (int i = 1; i <= 20; i++) {
            
                allColumn = allColumn+"empn"+i+",sern"+i+",crew"+i+",score"+i+",score"+i+",sh_crew"+i+",";
           }
                System.out.println(allColumn);
                
                
            String[] empn = {"empn1","empn2","empn3","empn4"};
            String[] sern = {"sern1","sern2","sern3","sern4"};
            String[] crew = {"crew1","crew2","crew3","crew4"};
            String[] score = {"1","2","3","4"};
            String[] duty = {"CREW","CREW","Z1","PR"};
            String[] sh_crew = {"1","2","1","1"};
            
            UpdCfltCol my = new UpdCfltCol();
            String Value = my.getUPDValue(empn,sern,crew,score,duty,sh_crew);
            System.out.println(Value);
    //
    //      String Name = my.getColName();
    //      System.out.println("ColName = "+Name);
    
    }

    /**
     * @author cs66
     *
     * 將「員工號、序號、姓名、考評數」串成字串，
     * 預設有20個，
     * 傳回insert egtCflt的值
     */
    public String getColValue(String[] empn, String[] sern, String[] crew,
            String[] score) {
        String updateColumnValue = "";
        for (int i = 0; i < empn.length; i++) {
            updateColumnValue = updateColumnValue + "'" + empn[i] + "',"
                    + sern[i] + ",trim('" + crew[i] + "')," + score[i] + ",";

        }
        for (int i = empn.length; i < 20; i++) {
            updateColumnValue = updateColumnValue + "'000000',0,null,0,";

        }
        return updateColumnValue;
    }
    
    /*override getColValue(String[] empn, String[] sern, String[] crew, String[] score)
     * 加入輪休紀錄*/
    public String getColValue(String[] empn, String[] sern, String[] crew,String[] score,String[] sh_crew) {
        String updateColumnValue = "";
        for (int i = 0; i < empn.length; i++) {
            updateColumnValue = updateColumnValue + "'" + empn[i] + "',"
                    + sern[i] + ",trim('" + crew[i] + "')," + score[i] + "," + sh_crew[i] + "," ;

        }
        for (int i = empn.length; i < 20; i++) {
            updateColumnValue = updateColumnValue + "'000000',0,null,0,'0',";

        }
        return updateColumnValue;
    }
    /**
     * @author cs66
     *
     * 傳回insert egtCflt的Column Name(組員部分)
     * * 加入輪休紀錄
     */
    public String getColName() {
        String[] list = new String[20];
        String ColName = "";
        for (int i = 1; i <= 20; i++) {
            ColName = ColName + "empn" + i + ",sern" + i + ",crew" + i
                    + ",score" + i + ",sh_crew" + i + ",";
        }
        return ColName;
    }

    /**
     * @author cs66
     *
     * 將「員工號、序號、姓名、考評數」串成字串，
     * 預設有20個，
     * 傳回update egtCflt的值
     */
    public String getUPDValue(String[] empn, String[] sern, String[] crew,String[] score, String[] duty) {
        String updateColumnValue = "";
        for (int i = 0; i < empn.length; i++) {
            updateColumnValue = updateColumnValue +
                    "empn" + (i + 1) + "='" + empn[i] + "',sern" + (i + 1) + "='" + sern[i] + 
                    "',crew"+ (i + 1) + "= trim('" + crew[i] + "'),score" + (i + 1) + "=" + score[i] + 
                    ",duty" + (i + 1) + "=upper('" + duty[i] + "'),";

        }
        for (int i = empn.length; i < 20; i++) {
            updateColumnValue = updateColumnValue + "empn" + (i + 1)
                    + "='000000'," + "sern" + (i + 1) + "=0,crew" + (i + 1)
                    + "=null,score" + (i + 1) + "=0,duty" + (i + 1) + "=null,";

        }
        return updateColumnValue;
    }
    /*override getColValue(String[] empn, String[] sern, String[] crew, String[] score)
     * 加入輪休紀錄*/
    public String getUPDValue(String[] empn, String[] sern, String[] crew,String[] score, String[] duty ,String[] sh_crew) {
        String updateColumnValue = "";
        for (int i = 0; i < empn.length; i++) {
            updateColumnValue = updateColumnValue +
                    "empn" + (i + 1) + "='" + empn[i] + "',sern" + (i + 1) + "='" + sern[i] + 
                    "',crew"+ (i + 1) + "= trim('" + crew[i] + "'),score" + (i + 1) + "=" + score[i] + 
                    ",duty" + (i + 1) + "=upper('" + duty[i] + "'),sh_crew"+ (i + 1) + "=upper('" + sh_crew[i] + "'),";

        }
        for (int i = empn.length; i < 20; i++) {
            updateColumnValue = updateColumnValue + 
                    "empn" + (i + 1)+ "='000000'," + "sern" + (i + 1) + "=0,crew" + (i + 1)
                    + "=null,score" + (i + 1) + "=0,duty" + (i + 1) + "=null,sh_crew"+ (i + 1) + "='0' ,";

        }
        return updateColumnValue;
    }
    
    public String getDutyValue(String[] duty) {

        String insDutyValue = "";

        for (int i = 0; i < duty.length; i++) {
            insDutyValue = insDutyValue + "upper('" + duty[i] + "'),";

        }
        for (int i = duty.length; i < 20; i++) {
            insDutyValue = insDutyValue + "null,";
        }
        return insDutyValue.substring(0, insDutyValue.length() - 1);
    }
}

