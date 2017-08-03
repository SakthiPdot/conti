package com.conti.hsn;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * @Project_Name conti
 * @Package_Name com.conti.hsn
 * @File_name Hsn.java
 * @author Sankar
 * @Created_date_time Aug 2, 2017 12:26:30 PM
 * @Updated_date_time Aug 2, 2017 12:26:30 PM
 */
@Entity
@Table(name = "m_hsn")

public class Hsn {
	private int hsn_id, created_by, updated_by;
	private String hsn_code, hsn_description, 
				hsn_shortdescription, created_datetime, updated_datetime,
				obsolete, active;
	
	@Id
	@Column(name = "hsn_id")
	public int getHsn_id() {
		return hsn_id;
	}
	public void setHsn_id(int hsn_id) {
		this.hsn_id = hsn_id;
	}
	
	@Column(name = "hsn_code")
	public String getHsn_code() {
		return hsn_code;
	}
	public void setHsn_code(String hsn_code) {
		this.hsn_code = hsn_code;
	}
	@Column(name = "hsn_description")
	public String getHsn_description() {
		return hsn_description;
	}
	public void setHsn_description(String hsn_description) {
		this.hsn_description = hsn_description;
	}
	@Column(name = "hsn_shortdescription")
	public String getHsn_shortdescription() {
		return hsn_shortdescription;
	}
	public void setHsn_shortdescription(String hsn_shortdescription) {
		this.hsn_shortdescription = hsn_shortdescription;
	}
	@Column(name = "created_by")
	public int getCreated_by() {
		return created_by;
	}
	public void setCreated_by(int created_by) {
		this.created_by = created_by;
	}
	
	@Column(name = "updated_by")
	public int getUpdated_by() {
		return updated_by;
	}
	public void setUpdated_by(int updated_by) {
		this.updated_by = updated_by;
	}
	
	@Column(name ="created_datetime")
	public String getCreated_datetime() {
		return created_datetime;
	}
	public void setCreated_datetime(String created_datetime) {
		this.created_datetime = created_datetime;
	}
	
	
	@Column(name = "updated_datetime")
	public String getUpdated_datetime() {
		return updated_datetime;
	}
	public void setUpdated_datetime(String updated_datetime) {
		this.updated_datetime = updated_datetime;
	}
	
	@Column(name = "obsolete")
	public String getObsolete() {
		return obsolete;
	}
	public void setObsolete(String obsolete) {
		this.obsolete = obsolete;
	}
	
	@Column(name = "active")
	public String getActive() {
		return active;
	}
	public void setActive(String active) {
		this.active = active;
	}
	
	
	
	
}
