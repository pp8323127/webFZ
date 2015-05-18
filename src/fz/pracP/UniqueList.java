package fz.pracP;
import java.util.Arrays;
import java.util.HashSet;
import java.util.StringTokenizer;

/**
 * @author cs69
 *
 */
public class UniqueList {
	

	public String getUniqueList(String OList){
		StringTokenizer st = new StringTokenizer(OList, ",");
		String[] tmpStrArray = new String[st.countTokens()];
		String List = "";
		int i = 0;

		while (st.hasMoreTokens()) {
			tmpStrArray[i] = st.nextToken();
			i++;
		}
		
		HashSet hsTmp = new HashSet();
		for (i = 0; i < tmpStrArray.length; i++) {
			//放值用add，只能加入物件
			hsTmp.add(tmpStrArray[i]);
		}
		
		String[] HashSetArray = (String[])hsTmp.toArray(new String[0]);
		Arrays.sort(HashSetArray);
		for (int j = 0; j < HashSetArray.length; j++) {
			if(j==0){
				List = HashSetArray[j];
			}
			else{
				List = List+","+HashSetArray[j];
			}
			//HashSetArray
			
			//List = List +hsTmp.g[i].toString();
        }
		return List;
	}
}
