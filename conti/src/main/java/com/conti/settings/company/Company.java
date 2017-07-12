package com.conti.settings.company;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

import com.conti.master.location.Location;

/**
 * @Project_Name conti
 * @Package_Name com.conti.settings.company  com.conti.settings.company
 * @File_name Company.java com.conti.settings.company
 * @author Monu.C
 * @Created_date_time Jun 22, 2017 3:20:24 PM
 */

@Entity
@Table(name="a_generalsetting")
@JsonIgnoreProperties(ignoreUnknown=true)
public class Company {
	
	private int company_id,expct_deliverydate,company_apptimeout,created_by,updated_by;
	private String company_name,company_address1,company_address2,
	TIN_number,GST_number,company_email;
	private  byte[] company_logo;
	private String created_datetime,updated_datetime,HSN_code;
	private float SGST,CGST,IGST;
	private long company_landlineno,company_alternateno;
	

	
	

	






	public Company() {
	}

	public Location location;
	
	@JoinColumn(name="location_id")
	@OneToOne(fetch = FetchType.EAGER,cascade = CascadeType.ALL)	
	public Location getLocation() {
		return this.location;
	}

	public void setLocation(Location location) {
		this.location = location;
	}
	


	//====================================================================
	@Id
	/*@GeneratedValue*/
	@Column(name="company_id")	
	public int getCompany_id() {
		return this.company_id;
	}
	 
	@Column(name="created_by")
	public int getCreated_by() {
		return this.created_by;
	}


	@Column(name="updated_by")
	public int getUpdated_by() {
		return this.updated_by;
	}
	
	@Column(name="SGST")
	public float getSGST() {
		return this.SGST;
	}

	@Column(name="CGST")
	public float getCGST() {
		return this.CGST;
	}

	@Column(name="IGST")
	public float getIGST() {
		return this.IGST;
	}


	@Column(name="HSN_code")
	public String getHSN_code() {
		return this.HSN_code;
	}

	@Column(name="expct_deliverydate")
	
	public int getExpct_deliverydate() {
		return this.expct_deliverydate;
	}
	
	@Column(name="company_apptimeout")
	
	public int getCompany_apptimeout() {
		return this.company_apptimeout;
	}
	
	@Column(name="company_landlineno")
	public long getCompany_landlineno() {
		return this.company_landlineno;
	}
	
	
	@Column(name="company_alternateno")
	public long getCompany_alternateno() {
		return this.company_alternateno;
	}



	@Column(name="company_name")
	
	public String getCompany_name() {
		return this.company_name;
	}
	
	@Column(name="company_address1")
	
	public String getCompany_address1() {
		return this.company_address1;
	}
	
	@Column(name="company_address2")
	
	public String getCompany_address2() {
		return this.company_address2;
	}
	

	

	@Column(name="TIN_number")
	
	public String getTIN_number() {
		return this.TIN_number;
	}
	
	@Column(name="GSTIN_number")
	
	public String getGST_number() {
		return this.GST_number;
	}
	
	@Column(name="company_email")
	
	public String getCompany_email() {
		return this.company_email;
	}
	
	@Column(name="company_logo")
	
	public byte[] getCompany_logo() {
		return this.company_logo;
	}
	
	@Column(name="created_datetime")
	public String getCreated_datetime() {
		return this.created_datetime;
	}
	
	@Column(name="updated_datetime")
	public String getUpdated_datetime() {
		return this.updated_datetime;
	}

	
	



	public void setCompany_id(int company_id) {
		this.company_id = company_id;
	}
	public void setExpct_deliverydate(int expct_deliverydate) {
		this.expct_deliverydate = expct_deliverydate;
	}
	public void setCompany_apptimeout(int company_apptimeout) {
		this.company_apptimeout = company_apptimeout;
	}

	public void setCompany_name(String company_name) {
		this.company_name = company_name;
	}
	public void setCompany_address1(String company_address1) {
		this.company_address1 = company_address1;
	}
	public void setCompany_address2(String company_address2) {
		this.company_address2 = company_address2;
	}
	public void setCompany_landlineno(long company_landlineno) {
		this.company_landlineno = company_landlineno;
	}
	public void setCompany_alternateno(long company_alternateno) {
		this.company_alternateno = company_alternateno;
	}
	public void setTIN_number(String tIN_number) {
		this.TIN_number = tIN_number;
	}
	public void setGST_number(String gST_number) {
		this.GST_number = gST_number;
	}
	public void setCompany_email(String company_email) {
		this.company_email = company_email;
	}
	public void setCompany_logo(byte[] company_logo) {
		this.company_logo = company_logo;
	}
	public void setCreated_datetime(String created_datetime) {
		this.created_datetime = created_datetime;
	}
	public void setUpdated_datetime(String updated_datetime) {
		this.updated_datetime = updated_datetime;
	}

	public void setCreated_by(int created_by) {
		this.created_by = created_by;
	}
	public void setUpdated_by(int updated_by) {
		this.updated_by = updated_by;
	}
	public void setSGST(float sGST) {
		this.SGST = sGST;
	}

	public void setCGST(float cGST) {
		this.CGST = cGST;
	}

	public void setIGST(float iGST) {
		this.IGST = iGST;
	}


	public void setHSN_code(String hSN_code) {
		this.HSN_code = hSN_code;
	}



	
	
}
