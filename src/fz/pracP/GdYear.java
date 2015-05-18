package fz.pracP;

/**
 * GdYear 根據所給的flight date(yyyy/mm or yyyy/mm/dd),取得考績年度GdYear, <br>
 * 每個考績年度的月份，為前年度11月至當年度的10月. <br>
 * ex: 2004/10/22,考績年度為2004. <br>
 * 2005/11/11,考績年度為2005
 * 
 * 
 * @author cs66
 * @version 1.0 2005/10/19
 * @exception 若傳入的flight date 格式不符，回傳值為空白字元
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