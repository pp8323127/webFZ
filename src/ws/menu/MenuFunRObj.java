package ws.menu;

import java.util.ArrayList;


public class MenuFunRObj {
	private String errorMsg = "";
	private String resultMsg = "";
	private MenuMealTypeObj MenuMarr[] = null;//�D�\
	private MenuDrinkObj MenuDarr[] = null;//����
	
	public String getErrorMsg() {
		return errorMsg;
	}
	public void setErrorMsg(String errorMsg) {
		this.errorMsg = errorMsg;
	}
	public String getResultMsg() {
		return resultMsg;
	}
	public void setResultMsg(String resultMsg) {
		this.resultMsg = resultMsg;
	}
	public MenuMealTypeObj[] getMenuMarr() {
		return MenuMarr;
	}
	public void setMenuMarr(MenuMealTypeObj[] menuMarr) {
		MenuMarr = menuMarr;
	}
	public MenuDrinkObj[] getMenuDarr() {
		return MenuDarr;
	}
	public void setMenuDarr(MenuDrinkObj[] menuDarr) {
		MenuDarr = menuDarr;
	}
	
}
