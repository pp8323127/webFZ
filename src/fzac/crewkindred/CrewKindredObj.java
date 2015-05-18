package fzac.crewkindred;

import java.util.*;

/**
 * CrewContactObj 家屬聯絡資訊物件
 * 
 * 
 * @author cs66
 * @version 1.0 2007/12/26
 * 
 * Copyright: Copyright (c) 2007
 */
public class CrewKindredObj {
	private String empno;// 組員員工號
	private String kindred_First_Name;//家屬姓氏
	private String kindred_surName;//家屬名字
	private String kinddred_Phone_Num;// 家屬手機
	private String delete_ind;//刪除註記
	private String export_ind;//匯入註記
	private Date export_time;//匯入時間
	private Date apply_time;//申請時間
	private String export_Empno;//匯入者員工號
	
	public String getEmpno() {
		return empno;
	}
	public void setEmpno(String empno) {
		this.empno = empno;
	}
	public String getKindred_First_Name() {
		return kindred_First_Name;
	}
	public void setKindred_First_Name(String kindred_First_Name) {
		this.kindred_First_Name = kindred_First_Name;
	}
	public String getKindred_surName() {
		return kindred_surName;
	}
	public void setKindred_surName(String kindred_surName) {
		this.kindred_surName = kindred_surName;
	}
	public String getKinddred_Phone_Num() {
		return kinddred_Phone_Num;
	}
	public void setKinddred_Phone_Num(String kinddred_Phone_Num) {
		this.kinddred_Phone_Num = kinddred_Phone_Num;
	}
	public String getDelete_ind() {
		return delete_ind;
	}
	public void setDelete_ind(String delete_ind) {
		this.delete_ind = delete_ind;
	}
	public String getExport_ind() {
		return export_ind;
	}
	public void setExport_ind(String export_ind) {
		this.export_ind = export_ind;
	}
	public Date getExport_time() {
		return export_time;
	}
	public void setExport_time(Date export_time) {
		this.export_time = export_time;
	}
	public String getExport_Empno() {
		return export_Empno;
	}
	public void setExport_Empno(String export_Empno) {
		this.export_Empno = export_Empno;
	}
	public Date getApply_time() {
			
		return apply_time;
	}
	public void setApply_time(Date apply_time) {
		this.apply_time = apply_time;
	}
	
	


}
