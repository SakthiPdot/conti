package com.conti.master.branch;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

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
public class BranchModel {
	int branch_id, location_id, updated_by, created_by;
	String branch_name, branch_code, branch_contactperson, branch_email, lrno_prefix, receiptno_prefix, created_datetime, updated_datetime, obsolete, active;
	
	@Id
	@Column(name = "branch_id")
	public int getBranch_id() {
		return branch_id;
	}
	public void setBranch_id(int branch_id) {
		this.branch_id = branch_id;
	}
	@Column(name = "location_id")
	public int getLocation_id() {
		return location_id;
	}
	public void setLocation_id(int location_id) {
		this.location_id = location_id;
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
