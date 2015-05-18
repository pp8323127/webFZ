package fz.pracP;

import java.util.ArrayList;

/**
 * @author cs66
 *  
 */
public class ChangeType {

    //    public static void main(String[] args) {
    //		
    //		String s = "'25801','25802','25803'";
    //		
    //
    //    	ArrayList a = new ArrayList();
    //    	String s = null;
    //    	a.add("25801");
    //    	a.add("25802");
    //    	a.add("25803");
    //    	ChangeType ct = new ChangeType();
    //    	s = ct.ArrayListToStirng(a);
    //    	System.out.println("ArralyList to String:\t"+s);
    //    }

    public String ArrayListToStirng(ArrayList al) {
        String st = null;
        for ( int i = 0; i < al.size(); i++) 
        {
            if ( i == 0 ) 
            {
                st = "'" + al.get(0) + "'";
            }
            else 
            {
                st = st + ",'" + al.get(i) + "'";
            }
        }

        return st;
    }

    public ArrayList StringToArrayList(String s) {
        ArrayList al = new ArrayList();
        for ( int i = 0; i < al.size(); i = i + 5) {
            al.add(s.substring(i + 1 ,i + 6));
        }

        return al;
    }
}