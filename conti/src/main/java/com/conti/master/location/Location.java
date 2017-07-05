package com.conti.master.location;

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
import org.codehaus.jackson.annotate.JsonManagedReference;
import org.codehaus.jackson.annotate.JsonProperty;

import com.conti.address.AddressModel;

/**
 * @Project_Name conti
 * @Package_Name com.conti.master.location  
 * @File_name Location.java 
 * @author Monu.C
 * @Created_date_time Jun 30, 2017 11:03:08 AM
 */
@Entity 
@Table(name="m_location")
public class Location {
	
	private int location_id,updated_by,created_by;
	private String location_name,location_code,abbreviation,obsolete,active,
	created_datetime,updated_datetime,pincode;
	

	

	public Location() {
	}
	



	
	public AddressModel address;
	

	@JoinColumn(name="city_id")
	@OneToOne(fetch = FetchType.LAZY,cascade = CascadeType.ALL)
	public AddressModel getAddress() {
		return this.address;
	}

	public void setAddress(AddressModel address) {
		this.address = address;
	}
	
	@Id
	@GeneratedValue
	@Column(name="location_id")
	public int getLocation_id() {
		return this.location_id;
	}

	public int getUpdated_by() {
		return this.updated_by;
	}
	public int getCreated_by() {
		return this.created_by;
	}
	public String getLocation_name() {
		return this.location_name;
	}
	public String getLocation_code() {
		return this.location_code;
	}
	public String getAbbreviation() {
		return this.abbreviation;
	}
	public String getObsolete() {
		return this.obsolete;
	}
	public String getActive() {
		return this.active;
	}
	public String getCreated_datetime() {
		return this.created_datetime;
	}
	public String getUpdated_datetime() {
		return this.updated_datetime;
	}
	
	public String getPincode() {
		return this.pincode;
	}

	public void setPincode(String pincode) {
		this.pincode = pincode;
	}

	public void setLocation_id(int location_id) {
		this.location_id = location_id;
	}

	public void setUpdated_by(int updated_by) {
		this.updated_by = updated_by;
	}
	public void setCreated_by(int created_by) {
		this.created_by = created_by;
	}
	public void setLocation_name(String location_name) {
		this.location_name = location_name;
	}
	public void setLocation_code(String location_code) {
		this.location_code = location_code;
	}
	public void setAbbreviation(String abbreviation) {
		this.abbreviation = abbreviation;
	}
	public void setObsolete(String obsolete) {
		this.obsolete = obsolete;
	}
	public void setActive(String active) {
		this.active = active;
	}
	public void setCreated_datetime(String created_datetime) {
		this.created_datetime = created_datetime;
	}
	public void setUpdated_datetime(String updated_datetime) {
		this.updated_datetime = updated_datetime;
	}
	
	
	
}
