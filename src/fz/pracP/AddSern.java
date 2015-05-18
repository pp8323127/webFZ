/*
 * for purser's report
 *
 *  FindSern:
 * 	add sern�ɡA�ˬd�O�_addSern�O�_�ŦX��Ӫ�sernList
 * 	�YsernList���LaddSern�Areturn false
 * 	�����N�ӵ����hight-light�A
 *
 *
 * DeleteFromArrayList:
 * 	del sern�ɡA�NOsernList���A�R���ŦXdelSern���r��
 * 	�^�ǭȬ�ArrayList
 * 
 * DeleteFromList:
 * 	del Sern�ɡA�N�s�W�M��]AddSernList�^���A�ŦX�����R�����r��R���A
 * 	�Ǧ^�Ȭ�String�Aformat��'#####','#####'
 * 	�T�O�s�W�M�椤�A�S���w�g�R�����Ǹ��C
 * 	�Y���ϥΦ���k�A�h�Y�R�����Ǹ��A�D��l��Z�խ��A�ӬO�w�g�s�W�L���A
 * 	�h�b�A���s�W��L�Ǹ��ɡA�쥻�w�R�����Ǹ��|�A�X�{
 **/
 

package fz.pracP;
import java.util.*;

public class AddSern {

//public static void main(String[] args) {
//
//    AddSern myAdd = new AddSern();
//    String sernList = "'12345','67890','0581'";
//    String[] addList = {"67890"};
//	System.out.println(myAdd.DeleteFromList(sernList,addList));
//	String a = sernList + "," + addList;
//	System.out.println("��lList:\t"+a+"\n");
//
//    String[] del = { "28511","67890"};
//   
//	System.out.println("Array Del = \n");
//	for (int i = 0; i < del.length; i++) {
//        String string = del[i];
//        System.out.println(string);
//    }
//    System.out.println("********************\nAfter Delete\n");
//
//    ArrayList myal = myAdd.DeleteFromArrayList(a, del);
//    for (int i = 0; i < myal.size(); i++) {
//        System.out.println(myal.get(i));
//
//    }
//
//}
  
    /**
     * @param sernList	:��l���M��
     * @param addSern:��J��sern
     * @return true		:addSern�A�쥻�w�s�b��sernList
     * @return false		:addSern�A���s�W��(�������New!!�r�ˤ��ܦ�)
     * 
     * */
    
    public boolean FindSern(String sernList, String addSern) {
        StringTokenizer st = new StringTokenizer(sernList, ",");
        StringTokenizer tmpSt = null;
        String tmpStr = null;
        String tmpStr2 = null;
        int count = 0;

        while (st.hasMoreTokens()) {
            tmpStr = st.nextToken();
            tmpSt = new StringTokenizer(tmpStr, "'");
            if (tmpSt.hasMoreTokens()) {

                tmpStr2 = tmpSt.nextToken();

                if (tmpStr2.equals(addSern)) {
                    return true;
                }
            }
        }
        return false;
    }
    
    /*�NString OsernList�M�椤�ŦXString[] delSern �������R���A����Ƭ�ArrayList
     * �^�ǭȬ�ArrayList
     * OsernList format:'####','#####'
     *  
     * */
     /**
      * @param OsernList	:��l�M��
      * @param delSern	:��ܧR�����Ǹ�
      * */
    public ArrayList DeleteFromArrayList(String OsernList, String[] delSern) {
        ArrayList al = new ArrayList();
        StringTokenizer st = new StringTokenizer(OsernList, ","); //���h��,
        StringTokenizer tmpSt = null;
        String tmpStr = null;
        String tmpStr2 = null;
        int count = 0;

        while (st.hasMoreTokens()) {
            tmpStr = st.nextToken();
            tmpSt = new StringTokenizer(tmpStr, "'"); //�A���޸��h��

            if (tmpSt.hasMoreTokens()) {
                tmpStr2 = tmpSt.nextToken();
                al.add(tmpStr2);	//�NOsernList�����C�Ӧr��s�JArrayList
            }

            for (int i = 0; i < delSern.length; i++) {//�R��OsernList���ŦXDelSern Array��
                al.remove(delSern[i]);
            }

        }
        return al;
    }
    
	/*�NString AddSernList�M�椤�ŦXString[] delSern �������R���A
	 * �^��String format��List
	 * OsernList format:'####','#####'
	 *  
	 * */
    
	public String DeleteFromList(String AddSernList, String[] delSern) {
		ArrayList al = new ArrayList();
		String returnST = "";
		StringTokenizer st = new StringTokenizer(AddSernList, ","); //���h��,
		StringTokenizer tmpSt = null;
		String tmpStr = null;
		String tmpStr2 = null;
	//	int count = 0;

		while (st.hasMoreTokens()) {
			tmpStr = st.nextToken();
			tmpSt = new StringTokenizer(tmpStr, "'"); //�A���޸��h��

			if (tmpSt.hasMoreTokens()) {
				tmpStr2 = tmpSt.nextToken();
				al.add(tmpStr2);	//�NOsernList�����C�Ӧr��s�JArrayList
			}


			for (int i = 0; i < delSern.length; i++) {//�R��OsernList���ŦXDelSern Array��
				al.remove(delSern[i]);
			}

		}
		
		//�NArrayList�A�ꦨString
		for (int i = 0; i < al.size(); i++) {
			if(i==0){
				returnST = "'"+(String)al.get(i)+"'";
			}
			else{
				returnST = returnST+",'"+(String)al.get(i)+"'";
			}

            
        }
		return returnST;
	}
    
}