package ws.menu;

public class MenuDrinkObj {
	private String type = null;//�\�e�s.�P�s
	private String name = null;//���ƦW��.ex:�����դҥ�S�[,�������a
	private String eName = null;//�^��W��
	private int quantity = 0;//�ƶq
	private String classType = null; //����
	private String detail = null; //�B,��...����
	
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
