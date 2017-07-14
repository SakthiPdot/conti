package com.conti.master.branch;

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
 * @Package_Name com.conti.master.branch
 * @File_name BranchModel.java
 * @author Sankar
 * @Created_date_time Jul 4, 2017 12:50:11 PM
 * @Updated_date_time Jul 4, 2017 12:50:11 PM
 */
@Entity
@Table(name = "m_branch")
@JsonIgnoreProperties(ignoreUnknown = true)
public class BranchModel {
	int branch_id,  branch_mobileno, updated_by, created_by;
	String branch_name, branch_code, branch_addressline1,branch_addressline2,branch_contactperson, branch_email, lrno_prefix, receiptno_prefix, created_datetime, updated_datetime, obsolete, active;
	
	
	
	
	@Id
	@Column(name = "branch_id")
	public int getBranch_id() {
		return branch_id;
	}
	public void setBranch_id(int branch_id) {
		this.branch_id = branch_id;
	}
	
	
	@Column(name = "BRANCH_ADDRESSLINE1")
	public String getBranch_addressline1() {
		return branch_addressline1;
	}
	public void setBranch_addressline1(String branch_addressline1) {
		this.branch_addressline1 = branch_addressline1;
	}
	
	@Column(name = "BRANCH_ADDRESSLINE2")
	public String getBranch_addressline2() {
		return branch_addressline2;
	}
	public void setBranch_addressline2(String branch_addressline2) {
		this.branch_addressline2 = branch_addressline2;
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
		
		
		
	
	@Column(name = "updated_by")
	public int getUpdated_by() {
		return updated_by;
	}
	public void setUpdated_by(int updated_by) {
		this.updated_by = updated_by;
	}
	@Column(name = "created_by")
	public int getCreated_by() {
		return created_by;
	}
	public void setCreated_by(int created_by) {
		this.created_by = created_by;
	}
	@Column(name = "branch_mobileno")
	public int getBranch_mobileno() {
		return branch_mobileno;
	}
	public void setBranch_mobileno(int branch_mobileno) {
		this.branch_mobileno = branch_mobileno;
	}
	
	@Column(name = "branch_name")
	public String getBranch_name() {
		return branch_name;
	}
	public void setBranch_name(String branch_name) {
		this.branch_name = branch_name;
	}
	
	@Column(name = "branch_code")
	public String getBranch_code() {
		return branch_code;
	}
	public void setBranch_code(String branch_code) {
		this.branch_code = branch_code;
	}
	
	
	@Column(name = "branch_contactperson")
	public String getBranch_contactperson() {
		return branch_contactperson;
	}
	
	public void setBranch_contactperson(String branch_contactperson) {
		this.branch_contactperson = branch_contactperson;
	}
	@Column(name = "branch_email")
	public String getBranch_email() {
		return branch_email;
	}
	public void setBranch_email(String branch_email) {
		this.branch_email = branch_email;
	}
	@Column(name = "lrno_prefix")
	public String getLrno_prefix() {
		return lrno_prefix;
	}
	public void setLrno_prefix(String lrno_prefix) {
		this.lrno_prefix = lrno_prefix;
	}
	@Column(name = "receiptno_prefix")
	public String getReceiptno_prefix() {
		return receiptno_prefix;
	}
	public void setReceiptno_prefix(String receiptno_prefix) {
		this.receiptno_prefix = receiptno_prefix;
	}
	@Column(name = "created_datetime")
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
