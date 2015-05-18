package df.flypay;

/**
 * @author cs66 at 2005/8/18
 * @version 1.1 2005/12/01 by betty 新增銀行帳號
 * @version 1.2 2006/3/20 by cs66 新增超時給付項目
 * @versionn 1.3 2006/7/31 by cs66 刪除【Pocket Money by actual】及【Standby】
 * @version 1.4	2007/03/15 by cs66  員工號38開頭者,新增Tax及bankNT項目Tax項目要加負號
 * @v1.5 2009/03/24 by CS27 otha othb
 * @v1.6 2009/08/21 by cs27 add PRFXDY item
 * @v1.7 2011/05/07 by cs27 add rorpay item
 * @v1.8 2011/05/13 by cs27 add oth1_flypay oth3_flypay oth1_overpay oth3_overpay
 *                              oth1_stby   sum_oth1    sum_oth3
 * @v1.9 2011/09/15 by cs27 add overmin_y overpay_y description
 * @v2.0 2011/10/27 by cs27 add xiypay item
 */
public class FlyPayObj {

	private String empno;
	private String cname;
	private String ename;
	private String cabin;
	private String sern;
	private String post;
	private String base;
	private String sect;

	private String year;
	private String month;
	private String payhr;
	private String inchr;
	private String dechr;
	private String ovrhr;
	private String inthr;
	private String pock;
	private String flypay2;
	private String pock2;
	private String over;
	private String stby;
	private String rew;
	private String disp;
	private String lwop;
	private String pen;
	private String otha;
	private String othb;
	private String wine;
	private String sale;
	private String sale2;
	private String netnt;
	private String uperd;
	private String udfs;
	private String uotha;
	private String uothb;
	private String netus;
	private String nflrk;
	private String crus;
	private String mgr;
	private String theday;
	private String swho;
	private String ipcp;

	// add by betty
	private String banknont;
	private String banknous;

	// add by cs66 2006/3/22
	private String overtmHr;
	private String overPay;
	private String overRate;
	// Overtime Hr = round (dftpock. ovrmindd/60, 4)
	// Overtime $ = dftpock.ovrpaydd
	// Overtime rate = dftpock.ovrpayratedd

	// add by cs66 2006/09/06
	private String taxable;
	private String taxfree;
	// 是否使用新版有 taxable & taxfree的飛加清單
	private boolean NewVersionWithTaxItem;


	// add by cs66 2007/03/15 員工號38開頭者才有
	private String tax;
	private String bankNT;

	// v1.6 add PRFXDT       purser fixed duty
	private String prfxdt;

        // v1.7 add rorpay   ROR Travel Expense    
	private String rorpay;

        // v1.8 add oth1_flypay    
	private String oth1_flypay;
	private String oth3_flypay;
	private String oth1_overpay;
	private String oth3_overpay;
	private String oth1_stby;
	private String sum_oth1;
	private String sum_oth3;

        // v1.9 add overmin_y    
	private String overmin_y;
	private String overpay_y;

        // v2.0 add xiypay   XIY Travel Expense    
	private String xiypay;


	public String getBase() {
		return base;
	}

	public void setBase(String base) {
		this.base = base;
	}

	public String getCabin() {
		return cabin;
	}

	public void setCabin(String cabin) {
		this.cabin = cabin;
	}

	public String getCname() {
		return cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	public String getCrus() {
		return crus;
	}

	public void setCrus(String crus) {
		this.crus = crus;
	}

	public String getDechr() {
		return dechr;
	}

	public void setDechr(String dechr) {
		this.dechr = dechr;
	}

	public String getDisp() {
		return disp;
	}

	public void setDisp(String disp) {
		this.disp = disp;
	}

	public String getEmpno() {
		return empno;
	}

	public void setEmpno(String empno) {
		this.empno = empno;
	}

	public String getEname() {
		return ename;
	}

	public void setEname(String ename) {
		this.ename = ename;
	}

	public String getFlypay2() {
		return flypay2;
	}

	public void setFlypay2(String flypay2) {
		this.flypay2 = flypay2;
	}

	public String getInchr() {
		return inchr;
	}

	public void setInchr(String inchr) {
		this.inchr = inchr;
	}

	public String getInthr() {
		return inthr;
	}

	public void setInthr(String inthr) {
		this.inthr = inthr;
	}

	public String getIpcp() {
		return ipcp;
	}

	public void setIpcp(String ipcp) {
		this.ipcp = ipcp;
	}

	public String getLwop() {
		return lwop;
	}

	public void setLwop(String lwop) {
		this.lwop = lwop;
	}

	public String getMgr() {
		return mgr;
	}

	public void setMgr(String mgr) {
		this.mgr = mgr;
	}

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	public String getNetnt() {
		return netnt;
	}

	public void setNetnt(String netnt) {
		this.netnt = netnt;
	}

	public String getNetus() {
		return netus;
	}

	public void setNetus(String netus) {
		this.netus = netus;
	}

	public String getNflrk() {
		return nflrk;
	}

	public void setNflrk(String nflrk) {
		this.nflrk = nflrk;
	}

	public String getOtha() {
		return otha;
	}

	public void setOtha(String otha) {
		this.otha = otha;
	}

	public String getOthb() {
		return othb;
	}

	public void setOthb(String othb) {
		this.othb = othb;
	}

	public String getOver() {
		return over;
	}

	public void setOver(String over) {
		this.over = over;
	}

	public String getOvrhr() {
		return ovrhr;
	}

	public void setOvrhr(String ovrhr) {
		this.ovrhr = ovrhr;
	}

	public String getPayhr() {
		return payhr;
	}

	public void setPayhr(String payhr) {
		this.payhr = payhr;
	}

	public String getPen() {
		return pen;
	}

	public void setPen(String pen) {
		this.pen = pen;
	}

	public String getPock() {
		return pock;
	}

	public void setPock(String pock) {
		this.pock = pock;
	}

	public String getPock2() {
		return pock2;
	}

	public void setPock2(String pock2) {
		this.pock2 = pock2;
	}

	public String getPost() {
		return post;
	}

	public void setPost(String post) {
		this.post = post;
	}

	public String getRew() {
		return rew;
	}

	public void setRew(String rew) {
		this.rew = rew;
	}

	public String getSale() {
		return sale;
	}

	public void setSale(String sale) {
		this.sale = sale;
	}

	public String getSale2() {
		return sale2;
	}

	public void setSale2(String sale2) {
		this.sale2 = sale2;
	}

	public String getSect() {
		return sect;
	}

	public void setSect(String sect) {
		this.sect = sect;
	}

	public String getSern() {
		return sern;
	}

	public void setSern(String sern) {
		this.sern = sern;
	}

	public String getStby() {
		return stby;
	}

	public void setStby(String stby) {
		this.stby = stby;
	}

	public String getSwho() {
		return swho;
	}

	public void setSwho(String swho) {
		this.swho = swho;
	}

	public String getTheday() {
		return theday;
	}

	public void setTheday(String theday) {
		this.theday = theday;
	}

	public String getUdfs() {
		return udfs;
	}

	public void setUdfs(String udfs) {
		this.udfs = udfs;
	}

	public String getUotha() {
		return uotha;
	}

	public void setUotha(String uotha) {
		this.uotha = uotha;
	}

	public String getUothb() {
		return uothb;
	}

	public void setUothb(String uothb) {
		this.uothb = uothb;
	}

	public String getUperd() {
		return uperd;
	}

	public void setUperd(String uperd) {
		this.uperd = uperd;
	}

	public String getWine() {
		return wine;
	}

	public void setWine(String wine) {
		this.wine = wine;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public String getBanknont() {
		return banknont;
	}

	public void setBanknont(String banknont) {
		this.banknont = banknont;
	}

	public String getBanknous() {
		return banknous;
	}

	public void setBanknous(String banknous) {
		this.banknous = banknous;
	}

	public String getOverPay() {
		return overPay;
	}

	public void setOverPay(String overPay) {
		this.overPay = overPay;
	}

	public String getOverRate() {
		return overRate;
	}

	public void setOverRate(String overRate) {
		this.overRate = overRate;
	}

	public String getOvertmHr() {
		return overtmHr;
	}

	public void setOvertmHr(String overtmHr) {
		this.overtmHr = overtmHr;
	}

	public String getTaxable() {
		return taxable;
	}

	public void setTaxable(String taxable) {
		this.taxable = taxable;
	}

	public String getTaxfree() {
		return taxfree;
	}

	public void setTaxfree(String taxfree) {
		this.taxfree = taxfree;
	}

	public boolean isNewVersionWithTaxItem() {
		return NewVersionWithTaxItem;
	}

	public void setNewVersionWithTaxItem(boolean newVersionWithTaxItem) {
		NewVersionWithTaxItem = newVersionWithTaxItem;
	}

	public String getFlyPayContent() {
		StringBuffer sb = new StringBuffer();
		sb.append(year + "/" + month + "  Flight Payment list\r\n");
		if ("A".equals(cabin)) {
			sb.append("Emp.No. : " + empno + "  Name : " + cname + "  " + ename
					+ "\r\n");
		} else {
			sb.append("Emp.No. : " + empno + "  " + sern);
			sb.append("  Name : " + cname + "  " + ename + "\r\n");
		}
		sb.append("Working Month : " + year + "/" + month + "\r\n");
		sb.append("FLRK : " + nflrk + "  POST : " + post + "\r\n");
		sb.append("HomeBase : " + base);
		if (!"A".equals(cabin)) {
			sb.append("  Section : " + sect);
		}
		sb.append("\r\n");
		sb.append("\r\n");
		sb.append("Flight time\r\n");
		sb.append("\r\n");
		sb.append("Pay Hours                " + payhr + "\r\n");
		sb.append("Inc Hours                " + inchr + "\r\n");
		sb.append("Dec Hours                " + dechr + "\r\n");
		sb.append("Over Hours               " + ovrhr + "\r\n");
		sb.append("Travel Hours             " + inthr + "\r\n");
		sb.append("\r\n");
		sb.append("NT$\r\n");
		sb.append("\r\n");
		// sb.append("NT Acc# " + banknont + "\r\n");

		// modify by cs66 後艙去除pocket money ,
		// 2006/09/06 改成 Flight Pay Allowance 字樣
		if ("A".equals(cabin)) {
			if (NewVersionWithTaxItem) {
				sb.append("Flight Pay Allowance     " + pock + "\r\n");

			} else {
				sb.append("Pocket Money             " + pock + "\r\n");
			}

		}
 
		sb.append("Flypay by actual         " + flypay2 + "\r\n");
		// sb.append("Pocket Money by actual " + pock2 + "\r\n");
		sb.append("Overtime pay             " + over + "\r\n");

		// 前艙不用reward 206/09/06
		if (isNewVersionWithTaxItem()) {
			if (!"A".equals(cabin)) {
				sb.append("Reward                   " + rew + "\r\n");

			}
		} else {
			sb.append("Reward                   " + rew + "\r\n");
		}
 
		if ("A".equals(cabin))
		{
		    //add by Betty  2006/09/15
		    // mod by cs27 otha ohthb 2009/03/24
			sb.append("Standby 		            " + stby + "\r\n");
			sb.append("Crusing reward           " + crus + "\r\n");
			sb.append("IPCP reward              " + ipcp + "\r\n");			
			sb.append("Manager reward           " + mgr + "\r\n");
			sb.append("Leave without pay        " + lwop + "\r\n");
			sb.append("Penalty                  " + pen + "\r\n");
			sb.append("Other-A (NON TAX ADJUST) " + otha + "\r\n");
			sb.append("Other-B (TAX ADJUST)     " + othb + "\r\n");
			
			//add  by cs66 2007/03/15 員工號38開頭者,新增Tax項目,summary=bankNT
			if("38".equals(empno.substring(0,2))){				
				sb.append("Tax                     -"+tax +"\r\n");
				sb.append("Summary                  " + bankNT + "\r\n");				
			}else{
				sb.append("Summary                  " + netnt + "\r\n");
				
			}				

			// add by cs66 2006/09/06,新增tabale & taxfree
			// modify by Betty 2006/09/15
			if (isNewVersionWithTaxItem()) 
			{
				sb.append("Flypay Taxable           " + taxable + "\r\n");
				
			}
                        // v1.8 
			if (!(sum_oth1.equals("0") || sum_oth3.equals("0") )) {
				sb.append("OTHER-A $ " + sum_oth3 + " = Flight Pay " + oth3_flypay + " + Overtime Pay " + oth3_overpay + "\r\n");
				sb.append("OTHER-B $ " + sum_oth1 + " = Flight Pay " + oth1_flypay + " + Overtime Pay " + oth1_overpay + " + Standby Pay " + oth1_stby + "\r\n");
			}
		
			sb.append("\r\n");
			
			sb.append("US$\r\n");
			sb.append("\r\n");
			// sb.append("US Acc# " + banknous + "\r\n");
			sb.append("Perdiem                  " + uperd + "\r\n");

		} else {
			sb.append("Dispatch reward          " + disp + "\r\n");
			sb.append("Leave without pay        " + lwop + "\r\n");
			sb.append("Penalty                  " + pen + "\r\n");
			sb.append("Other-A                  " + otha + "\r\n");
			sb.append("Other-B                  " + othb + "\r\n");
			sb.append("Wine reward              " + wine + "\r\n");
			sb.append("Top sales reward         " + sale + "\r\n");
			sb.append("Sales reward             " + sale2 + "\r\n");

			// add by cs66 over pay
			sb.append("Overtime Hr              " + overtmHr + "\r\n");
			sb.append("Overtime rate            " + overRate + "\r\n");
			sb.append("Overtime $               " + overPay + "\r\n");

                // v1.6
                if ("B".equals(cabin) && base.equals("TPE") ) {          //TPE cabin crew only
		sb.append("PurserFixedDuty          " + prfxdt + "\r\n");
		}

                        sb.append("ROR Trvl Expense         " + rorpay + "\r\n");
			sb.append("XIY Trvl Expense         " + xiypay + "\r\n");
			sb.append("Summary                  " + netnt + "\r\n");
                // v1.9   start
		 if (!(overmin_y.equals("0"))) {
		 	sb.append("Other-B：2010 Overtime Payment Adjustment(Overtime Mins：" + overmin_y + "Mins / Overtime $" + overpay_y + ")\r\n");
               		 }
                //  v1.9 end 
			sb.append("\r\n");
			sb.append("US$\r\n");
			sb.append("\r\n");
			// sb.append("US Acc# " + banknous + "\r\n");
			sb.append("Perdiem                  " + uperd + "\r\n");
			sb.append("Surplus & Deficit        " + udfs + "\r\n");

		}

		sb.append("Other-A                  " + uotha + "\r\n");
		sb.append("Other-B                  " + uothb + "\r\n");
		sb.append("Summary                  " + netus + "\r\n");

		return sb.toString();

	}

	public String getBankNT() {
		return bankNT;
	}

	public void setBankNT(String bankNT) {
		this.bankNT = bankNT;
	}

	public String getTax() {
		return tax;
	}

	public void setTax(String tax) {
		this.tax = tax;
	}

        // v1.6
	public String getPrfxdt() {
		return prfxdt ;
	}
	public void setPrfxdt(String prfxdt) {
		this.prfxdt = prfxdt;
	}
        // v1.7
	public String getRorpay() {
		return rorpay ;
	}	
	public void setRorpay(String rorpay) {
		this.rorpay = rorpay;
	}
        // v2.0
	public String getXiypay() {
		return xiypay ;
	}
	public void setXiypay(String xiypay) {
		this.xiypay = xiypay;
	}
        // v1.8
	public String getOth1_flypay() {
		return oth1_flypay ;
	}
	public void setOth1_flypay(String oth1_flypay) {
		this.oth1_flypay = oth1_flypay;
	}

	public String getOth3_flypay() {
		return oth3_flypay ;
	}
	public void setOth3_flypay(String oth3_flypay) {
		this.oth3_flypay = oth3_flypay;
	}

   	public String getOth1_overpay() {
		return oth1_overpay ;
	}
	public void setOth1_overpay(String oth1_overpay) {
		this.oth1_overpay = oth1_overpay;
	}

	public String getOth3_overpay() {
		return oth3_overpay ;
	}
	public void setOth3_overpay(String oth3_overpay) {
		this.oth3_overpay = oth3_overpay;
	}

	public String getOth1_stby() {
		return oth1_stby ;
	}
	public void setOth1_stby(String oth1_stby) {
		this.oth1_stby = oth1_stby;
	}

	public String getSum_oth1() {
		return sum_oth1 ;
	}
	public void setSum_oth1(String sum_oth1) {
		this.sum_oth1 = sum_oth1;
	}
	public String getSum_oth3() {
		return sum_oth3 ;
	}
	public void setSum_oth3(String sum_oth3) {
		this.sum_oth3 = sum_oth3 ;
	}

        public String getOvermin_y() {
		return overmin_y ;
	}
	public void setOvermin_y(String overmin_y) {
		this.overmin_y = overmin_y;
	}
	public String getOverpay_y() {
		return overpay_y ;
	}
	public void setOverpay_y(String overpay_y) {
		this.overpay_y = overpay_y;
	}

}