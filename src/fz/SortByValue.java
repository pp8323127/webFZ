package fz;
import java.util.*;
public class SortByValue implements Comparable {    
	private final String key;
    private final int value;
    
    public SortByValue(String key, int value) {        
    	this.key = key;
        this.value = value;
    }    
    
    public SortByValue(String key, String value) throws NumberFormatException {    
    	this.key = key;
        this.value = Integer.parseInt(value);
    }    
    
    // TreeMap.set() will auto call this method 
    public int compareTo(Object o) {   
    	if (o instanceof SortByValue) {            
    		int cmp = Double.compare(((SortByValue) o).value, value);
    		if (cmp != 0) {                
    			return cmp;
    		}   
    		return key.compareTo(((SortByValue) o).key);
        }        
    	throw new ClassCastException("Cannot compare SortByValue with " + o.getClass().getName());    
    }       
    
    public String toString() {        
    	return  key+"\t"+value ;
    } 
}//SortByValue
