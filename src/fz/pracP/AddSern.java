/*
 * for purser's report
 *
 *  FindSern:
 * 	add sern時，檢查是否addSern是否符合原來的sernList
 * 	若sernList中無addSern，return false
 * 	頁面將該筆資料hight-light，
 *
 *
 * DeleteFromArrayList:
 * 	del sern時，將OsernList中，刪除符合delSern的字串
 * 	回傳值為ArrayList
 * 
 * DeleteFromList:
 * 	del Sern時，將新增清單（AddSernList）中，符合此次刪除的字串刪除，
 * 	傳回值為String，format為'#####','#####'
 * 	確保新增清單中，沒有已經刪除的序號。
 * 	若不使用此方法，則若刪除的序號，非原始航班組員，而是已經新增過的，
 * 	則在再次新增其他序號時，原本已刪除的序號會再出現
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
//	System.out.println("原始List:\t"+a+"\n");
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
     * @param sernList	:原始的清單
     * @param addSern:輸入的sern
     * @return true		:addSern，原本已存在於sernList
     * @return false		:addSern，為新增的(頁面顯示New!!字樣及變色)
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
    
    /*將String OsernList清單中符合String[] delSern 的部分刪除，並轉化為ArrayList
     * 回傳值為ArrayList
     * OsernList format:'####','#####'
     *  
     * */
     /**
      * @param OsernList	:原始清單
      * @param delSern	:選擇刪除的序號
      * */
    public ArrayList DeleteFromArrayList(String OsernList, String[] delSern) {
        ArrayList al = new ArrayList();
        StringTokenizer st = new StringTokenizer(OsernList, ","); //先去掉,
        StringTokenizer tmpSt = null;
        String tmpStr = null;
        String tmpStr2 = null;
        int count = 0;

        while (st.hasMoreTokens()) {
            tmpStr = st.nextToken();
            tmpSt = new StringTokenizer(tmpStr, "'"); //再把單引號去掉

            if (tmpSt.hasMoreTokens()) {
                tmpStr2 = tmpSt.nextToken();
                al.add(tmpStr2);	//將OsernList中的每個字串存入ArrayList
            }

            for (int i = 0; i < delSern.length; i++) {//刪除OsernList中符合DelSern Array的
                al.remove(delSern[i]);
            }

        }
        return al;
    }
    
	/*將String AddSernList清單中符合String[] delSern 的部分刪除，
	 * 回傳String format的List
	 * OsernList format:'####','#####'
	 *  
	 * */
    
	public String DeleteFromList(String AddSernList, String[] delSern) {
		ArrayList al = new ArrayList();
		String returnST = "";
		StringTokenizer st = new StringTokenizer(AddSernList, ","); //先去掉,
		StringTokenizer tmpSt = null;
		String tmpStr = null;
		String tmpStr2 = null;
	//	int count = 0;

		while (st.hasMoreTokens()) {
			tmpStr = st.nextToken();
			tmpSt = new StringTokenizer(tmpStr, "'"); //再把單引號去掉

			if (tmpSt.hasMoreTokens()) {
				tmpStr2 = tmpSt.nextToken();
				al.add(tmpStr2);	//將OsernList中的每個字串存入ArrayList
			}


			for (int i = 0; i < delSern.length; i++) {//刪除OsernList中符合DelSern Array的
				al.remove(delSern[i]);
			}

		}
		
		//將ArrayList，串成String
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