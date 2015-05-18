package ws.menu;

public class MenuMealTypeObj {

	/**
	 * @param args
	 */
	private String mealType = null;//早,午,晚餐
	private String alacartType = null;//中文:前菜,主菜
	private String name = null;//餐點名稱.ex:A,B,C
	private String eName = null;
	private int quantity = 0;//數量
	private String classType = null; //艙等
    private String detail = null; //醬料...等等
	
	public String getMealType() {
		return mealType;
	}
	public void setMealType(String mealType) {
		this.mealType = mealType;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public String geteName() {
		return eName;
	}
	public void seteName(String eName) {
		this.eName = eName;
	}
	public int getQuantity()
    {
        return quantity;
    }
    public void setQuantity(int quantity)
    {
        this.quantity = quantity;
    }
    public String getClassType() {
		return classType;
	}
	public void setClassType(String classType) {
		this.classType = classType;
	}
    public String getAlacartType()
    {
        return alacartType;
    }
    public void setAlacartType(String alacartType)
    {
        this.alacartType = alacartType;
    }
    public String getDetail()
    {
        return detail;
    }
    public void setDetail(String detail)
    {
        this.detail = detail;
    }

	
}
