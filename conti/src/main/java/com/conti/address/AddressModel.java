package com.conti.address;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Servlet implementation class AddressModel
 */
@Entity 
@Table(name="m_address")
public class AddressModel  implements Serializable {

	private int id;
	private String CityCode;
	private String City;
	private String StateCode;
	private String State;
	private String Country;
	private String CountryCode;
	private String Active;
	private String District;
	private String Obsolete;

	
	



public AddressModel() {
	}
	/*	public Location location;
	
	
	@OneToOne (fetch=FetchType.LAZY,cascade=CascadeType.ALL)
	@JsonBackReference
	public Location getLocation() {
		return this.location;
	}
	public void setLocation(Location location) {
		this.location = location;
	}
	*/
	@Id
	@GeneratedValue
	@Column(name="address_id")
	public int getId() {
		return this.id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getCityCode() {
		return this.CityCode;
	}
	public void setCityCode(String cityCode) {
		this.CityCode = cityCode;
	}
	public String getCity() {
		return this.City;
	}
	public void setCity(String city) {
		this.City = city;
	}
	public String getStateCode() {
		return this.StateCode;
	}
	public void setStateCode(String stateCode) {
		this.StateCode = stateCode;
	}
	public String getState() {
		return this.State;
	}
	public void setState(String state) {
		this.State = state;
	}
	public String getCountry() {
		return this.Country;
	}
	public void setCountry(String country) {
		this.Country = country;
	}
	public String getCountryCode() {
		return this.CountryCode;
	}
	public void setCountryCode(String countryCode) {
		this.CountryCode = countryCode;
	}
	public String getActive() {
		return this.Active;
	}
	public void setActive(String active) {
		this.Active = active;
	}
	public String getObsolete() {
		return this.Obsolete;
	}
	public void setObsolete(String obsolete) {
		this.Obsolete = obsolete;
	}
	public String getDistrict() {
		return this.District;
	}
	public void setDistrict(String district) {
		this.District = district;
	}
}
