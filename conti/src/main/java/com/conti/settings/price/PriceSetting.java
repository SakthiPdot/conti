package com.conti.settings.price;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonManagedReference;

import com.conti.master.branch.BranchModel;
import com.conti.master.product.Product;
import com.conti.master.service.ServiceMaster;

/**
 * @Project_Name conti
 * @Package_Name com.conti.settings.price  com.conti.settings.price
 * @File_name PriceSetting.java com.conti.settings.price
 * @author Monu.C
 * @Created_date_time Jul 20, 2017 9:53:23 AM
 */

@Entity
@Table (name="a_pricesetting")
public class PriceSetting {


	
	public PriceSetting() {
	}
	
	private int pricesetting_id;
	private float default_price;
	private float defaulthandling_charge;
	private String created_datetime;
	private String updated_datetime;
	private int updated_by;
	private int created_by;
	private String obsolete;
	private String active;
	
	
	private Set<PriceSettingDetail> PriceSettingDetail=new HashSet<>();
	
	
	/*@JoinColumn(name="pricesetting_id", referencedColumnName = "pricesetting_id")*/
	//@JsonIgnore
	/*@OneToMany(cascade=CascadeType.ALL,fetch = FetchType.EAGER,mappedBy="priceSetting") */ 
	@JoinColumn(name="pricesetting_id", referencedColumnName = "pricesetting_id",insertable=false, updatable=false)
	@OneToMany(cascade=CascadeType.ALL,orphanRemoval=true,fetch = FetchType.EAGER)
	@JsonManagedReference
	public Set<PriceSettingDetail> getPriceSettingDetail() {
		return this.PriceSettingDetail;
	}

	public void setPriceSettingDetail(Set<PriceSettingDetail> priceSettingDetail) {
		this.PriceSettingDetail = priceSettingDetail;
	}
	
	
	private Product product;
	
	@JoinColumn(name="product_id", referencedColumnName = "product_id")
	@OneToOne(fetch = FetchType.EAGER,cascade = CascadeType.ALL)
	public Product getProduct() {
		return this.product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	private ServiceMaster service;
		
	
	@JoinColumn(name="service_id", referencedColumnName = "service_id")
	@OneToOne(fetch = FetchType.EAGER,cascade = CascadeType.ALL)
	public ServiceMaster getService() {
		return this.service;
	}

	public void setService(ServiceMaster service) {
		this.service = service;
	}

	private BranchModel branch;	


	@JoinColumn(name="frombranch_id", referencedColumnName = "branch_id")
	@OneToOne(fetch = FetchType.EAGER,cascade = CascadeType.ALL)
	public BranchModel getBranch() {
		return this.branch;
	}

	public void setBranch(BranchModel branch) {
		this.branch = branch;
	}

	@Id
	@GeneratedValue
	@Column(name="pricesetting_id")
	public int getPricesetting_id() {
		return this.pricesetting_id;
	}
	


	@Column(name="default_price")
	public float getDefault_price() {
		return this.default_price;
	}
	@Column(name="defaulthandling_charge")
	public float getDefaulthandling_charge() {
		return this.defaulthandling_charge;
	}
	
	@Column(name="created_datetime")
	public String getCreated_datetime() {
		return this.created_datetime;
	}
	
	@Column(name="updated_datetime")
	public String getUpdated_datetime() {
		return this.updated_datetime;
	}
	
	@Column(name="updated_by")
	public int getUpdated_by() {
		return this.updated_by;
	}
	
	@Column(name="created_by")
	public int getCreated_by() {
		return this.created_by;
	}
	
	@Column(name="obsolete")
	public String getObsolete() {
		return this.obsolete;
	}
	
	@Column(name="active")
	public String getActive() {
		return this.active;
	}
	
	
	public void setPricesetting_id(int pricesetting_id) {
		this.pricesetting_id = pricesetting_id;
	}
	
	public void setDefault_price(float default_price) {
		this.default_price = default_price;
	}
	public void setDefaulthandling_charge(float defaulthandling_charge) {
		this.defaulthandling_charge = defaulthandling_charge;
	}
	public void setCreated_datetime(String created_datetime) {
		this.created_datetime = created_datetime;
	}
	public void setUpdated_datetime(String updated_datetime) {
		this.updated_datetime = updated_datetime;
	}
	public void setUpdated_by(int updated_by) {
		this.updated_by = updated_by;
	}
	public void setCreated_by(int created_by) {
		this.created_by = created_by;
	}
	public void setObsolete(String obsolete) {
		this.obsolete = obsolete;
	}
	public void setActive(String active) {
		this.active = active;
	}
	
	
}
