/**
 * @Project_Name conti
 * @Package_Name custom js customer_service.js
 * @File_name customer_service.js
 * @author Suresh
 * @Updated_user Suresh
 * @Created_date_time July 14, 2017 1:59:17 PM
 * @Updated_date_time July 14, 2017 1:59:17 PM
 */

package com.conti.master.customer;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

import com.conti.address.AddressModel;
import com.conti.master.branch.BranchModel;
import com.conti.master.location.Location;

@Entity
@Table(name = "m_customer")
@JsonIgnoreProperties(ignoreUnknown = true)
public class CustomerModel 
{
	private int customer_id,updated_by, created_by;
	private long customer_mobileno;
	private String customer_name,customer_code,company_name,customer_addressline1,customer_addressline2,customer_type,taxin_payable,gstin_number,obsolete,active,customer_email;
	private String created_datetime,updated_datetime;
	
	@Id
	@Column(name = "CUSTOMER_ID")
	@GeneratedValue
	public int getCustomer_id() {
		return customer_id;
	}
	public void setCustomer_id(int customer_id) {
		this.customer_id = customer_id;
	}
	
	
	@Column(name = "CREATED_DATETIME")
	public String getCreated_datetime() {
		return created_datetime;
	}
	public void setCreated_datetime(String created_datetime) {
		this.created_datetime = created_datetime;
	}
	
	@Column(name = "UPDATED_DATETIME")
	public String getUpdated_datetime() {
		return updated_datetime;
	}
	public void setUpdated_datetime(String updated_datetime) {
		this.updated_datetime = updated_datetime;
	}

	@Column(name = "CUSTOMER_EMAIL")
	public String getCustomer_email() {
		return customer_email;
	}
	public void setCustomer_email(String customer_email) {
		this.customer_email = customer_email;
	}

public Location location;
	

	@JoinColumn(name = "location_id")	 
	@OneToOne(fetch=FetchType.EAGER, cascade = CascadeType.ALL)
	public Location getLocation() {
		return location;  
	}
	public void setLocation(Location location) {
		this.location = location;
	}	
	
	
	public AddressModel customer_city;
	
	@JoinColumn(name="customer_city")
	@OneToOne(fetch=FetchType.EAGER,cascade=CascadeType.MERGE)
	public AddressModel getCustomer_city() {
		return customer_city;
	}
	public void setCustomer_city(AddressModel customer_city) {
		this.customer_city = customer_city;
	}

	public BranchModel branchModel;
	@JoinColumn(name = "branch_id")
	@OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
	public BranchModel getBranchModel() {
		return branchModel;
	}
	public void setBranchModel(BranchModel branchModel) {
		this.branchModel = branchModel;
	}
	
	
	
	@Column(name = "UPDATED_BY")
	public int getUpdated_by() {
		return updated_by;
	}
	public void setUpdated_by(int updated_by) {
		this.updated_by = updated_by;
	}
	
	@Column(name = "CREATED_BY")
	public int getCreated_by() {
		return created_by;
	}
	public void setCreated_by(int created_by) {
		this.created_by = created_by;
	}
	
	@Column(name = "CUSTOMER_MOBILENO")
	public long getCustomer_mobileno() {
		return customer_mobileno;
	}
	public void setCustomer_mobileno(long customer_mobileno) {
		this.customer_mobileno = customer_mobileno;
	}
	
	@Column(name = "CUSTOMER_NAME")
	public String getCustomer_name() {
		return customer_name;
	}
	public void setCustomer_name(String customer_name) {
		this.customer_name = customer_name;
	}
	
	@Column(name = "CUSTOMER_CODE")
	public String getCustomer_code() {
		return customer_code;
	}
	public void setCustomer_code(String customer_code) {
		this.customer_code = customer_code;
	}
	
	@Column(name = "COMPANY_NAME")
	public String getCompany_name() {
		return company_name;
	}
	public void setCompany_name(String company_name) {
		this.company_name = company_name;
	}
	
	@Column(name = "CUSTOMER_ADDRESSLINE1")
	public String getCustomer_addressline1() {
		return customer_addressline1;
	}
	public void setCustomer_addressline1(String customer_addressline1) {
		this.customer_addressline1 = customer_addressline1;
	}
	
	@Column(name = "CUSTOMER_ADDRESSLINE2")
	public String getCustomer_addressline2() {
		return customer_addressline2;
	}
	public void setCustomer_addressline2(String customer_addressline2) {
		this.customer_addressline2 = customer_addressline2;
	}
	
	@Column(name = "CUSTOMER_TYPE")
	public String getCustomer_type() {
		return customer_type;
	}
	public void setCustomer_type(String customer_type) {
		this.customer_type = customer_type;
	}
	
	@Column(name = "TAXIN_PAYABLE")
	public String getTaxin_payable() {
		return taxin_payable;
	}
	public void setTaxin_payable(String taxin_payable) {
		this.taxin_payable = taxin_payable;
	}
	
	@Column(name = "GSTIN_NUMBER")
	public String getGstin_number() {
		return gstin_number;
	}
	public void setGstin_number(String gstin_number) {
		this.gstin_number = gstin_number;
	}
	
	@Column(name = "OBSOLETE")
	public String getObsolete() {
		return obsolete;
	}
	public void setObsolete(String obsolete) {
		this.obsolete = obsolete;
	}
	
	@Column(name = "ACTIVE")
	public String getActive() {
		return active;
	}
	public void setActive(String active) {
		this.active = active;
	}
	
	
	
}	
 