package ws.menu;

public class MenuDrinkObj {
	private String type = null;//餐前酒.烈酒
	private String name = null;//飲料名稱.ex:斯梅諾夫伏特加,櫻桃白蘭地
	private String eName = null;//英文名稱
	private int quantity = 0;//數量
	private String classType = null; //艙等
	private String detail = null; //冰,熱...等等
	
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public String getClassType() {
		return classType;
	}
	public void setClassType(String classType) {
		this.classType = classType;
	}
	public String geteName() {
		return eName;
	}
	public void seteName(String eName) {
		this.eName = eName;
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
