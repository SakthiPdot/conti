package com.conti.settings.price;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.conti.master.branch.BranchModel;

/**
 * @Project_Name conti
 * @Package_Name com.conti.settings.price  com.conti.settings.price
 * @File_name PriceSettingDetail.java com.conti.settings.price
 * @author Monu.C
 * @Created_date_time Jul 20, 2017 10:16:38 AM
 */


@Entity
@Table (name="a_pricesettingdetail")
public class PriceSettingDetail {

	public PriceSettingDetail() {
	}

	
	private int pricesettingdetail_id;
	private float ps_weightfrom;
	private float ps_weightto;
	private float ps_price;
	
	private PriceSetting priceSetting;
	
	
	
	@ManyToOne(cascade=CascadeType.ALL)
	@JoinColumn(name="pricesetting_id")
	public PriceSetting getPriceSetting() {
		return this.priceSetting;
	}


	public void setPriceSetting(PriceSetting priceSetting) {
		this.priceSetting = priceSetting;
	}


	private BranchModel branch;	


	@JoinColumn(name="tobranch_id", referencedColumnName = "branch_id")
	@OneToOne(fetch = FetchType.EAGER,cascade = CascadeType.ALL)
	public BranchModel getBranch() {
		return this.branch;
	}

	public void setBranch(BranchModel branch) {
		this.branch = branch;
	}

	@Id
	@GeneratedValue
	@Column(name="a_pricesettingdetail")
	public int getPricesettingdetail_id() {
		return this.pricesettingdetail_id;
	}
	


	
	@Column(name="ps_weightfrom")
	public float getPs_weightfrom() {
		return this.ps_weightfrom;
	}

	
	@Column(name="ps_weightto")
	public float getPs_weightto() {
		return this.ps_weightto;
	}

	
	@Column(name="ps_price")
	public float getPs_price() {
		return this.ps_price;
	}

	public void setPricesettingdetail_id(int pricesettingdetail_id) {
		this.pricesettingdetail_id = pricesettingdetail_id;
	}


	public void setPs_weightfrom(float ps_weightfrom) {
		this.ps_weightfrom = ps_weightfrom;
	}

	public void setPs_weightto(float ps_weightto) {
		this.ps_weightto = ps_weightto;
	}

	public void setPs_price(float ps_price) {
		this.ps_price = ps_price;
	}
	
	
	
	
}
