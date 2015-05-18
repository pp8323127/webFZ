package fz.pracP;

/**
 * GdYear �ھکҵ���flight date(yyyy/mm or yyyy/mm/dd),���o���Z�~��GdYear, <br>
 * �C�Ӧ��Z�~�ת�����A���e�~��11��ܷ�~�ת�10��. <br>
 * ex: 2004/10/22,���Z�~�׬�2004. <br>
 * 2005/11/11,���Z�~�׬�2005
 * 
 * 
 * @author cs66
 * @version 1.0 2005/10/19
 * @exception �Y�ǤJ��flight date �榡���šA�^�ǭȬ��ťզr��
 * 
 * Copyright: Copyright (c) 2005
 */
public class GdYear {

    public static void main(String[] args) {
      
        System.out.println(GdYear.getGdYear(null));
    }

    public static String getGdYear(String fdate) {
        String gdYear = "";
        try {
            int year = Integer.parseInt(fdate.substring(0 ,4));
            int month = Integer.parseInt(fdate.substring(5 ,7));

            if ( month > 10 ) {
                year = year + 1;
            }
            gdYear = Integer.toString(year);
        } catch (NumberFormatException e) {

        }catch(NullPointerException e){
        	
        }
        return gdYear;

    }
}