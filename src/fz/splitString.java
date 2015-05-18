package fz;
//ºIe-mail address
public class splitString
{
        /**public static void main(String []args){
        splitString p = new splitString();
        String[] rs = p.doSplit("638716,640073", ",");
        for(int i=0; i < rs.length; i++)
        {System.out.println(rs[i]);}
        } **/
        public String[] doSplit(String strSource, String strMark)
        {
                String [] rstr = new String[20];//Max 20
                int intPos;
                int x = 0;

                while((intPos=strSource.indexOf(strMark))!=-1)
                {       //System.out.println(intPos);
                        rstr[x] = strSource.substring(0,intPos);
                        strSource = strSource.substring(intPos+1);
                        x++;
                }
                rstr[x] = strSource;

                return rstr;
        }
}