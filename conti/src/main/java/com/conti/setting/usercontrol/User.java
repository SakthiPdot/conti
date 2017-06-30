package com.conti.setting.usercontrol;


import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonBackReference;
import org.codehaus.jackson.annotate.JsonManagedReference;

import com.conti.master.employee.EmployeeMaster;

/**
 * @Project_Name conti
 * @Package_Name com.conti.settings.user
 * @File_name UserModel.java
 * @author Sankar
 * @Created_date_time Jun 20, 2017 2:21:39 PM
 * @Updated_date_time Jun 20, 2017 2:21:39 PM
 */

@Entity
@Table(name="a_user")
//@JsonIgnoreProperties(ignoreUnknown = true)

public class User implements Serializable{
	
	private int company_id, user_id, branch_id, role_id, emp_id;
	private String username, userpassword, user_phoneno, user_emailid; 
	private String obsolete, active, created_datetime, updated_datetime;
	
	private EmployeeMaster employeeMaster;
	
	
	/**
	 * @param company_id
	 * @param user_id
	 * @param branch_id
	 * @param role_id
	 * @param emp_id
	 * @param username
	 * @param userpassword
	 * @param user_phoneno
	 * @param user_emailid
	 * @param obsolete
	 * @param active
	 * @param created_datetime
	 * @param updated_datetime
	 * @param employeeMaster
	 */
	
	public User () {}
	public User(int company_id, int user_id, int branch_id, int role_id, int emp_id, String username,
			String userpassword, String user_phoneno, String user_emailid, String obsolete, String active,
			String created_datetime, String updated_datetime, EmployeeMaster employeeMaster) {
		super();
		this.company_id = company_id;
		this.user_id = user_id;
		this.branch_id = branch_id;
		this.role_id = role_id;
		this.emp_id = emp_id;
		this.username = username;
		this.userpassword = userpassword;
		this.user_phoneno = user_phoneno;
		this.user_emailid = user_emailid;
		this.obsolete = obsolete;
		this.active = active;
		this.created_datetime = created_datetime;
		this.updated_datetime = updated_datetime;
		this.employeeMaster = employeeMaster;
	}
	
	
	
	@Column(name = "company_id")
	public int getCompany_id() {
		return company_id;
	}
	public void setCompany_id(int company_id) {
		this.company_id = company_id;
	}
	@Id
	@Column(name = "user_id")
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	@Column(name = "branch_id")
	public int getBranch_id() {
		return branch_id;
	}
	public void setBranch_id(int branch_id) {
		this.branch_id = branch_id;
	}
	@Column(name = "role_id")
	public int getRole_id() {
		return role_id;
	}
	public void setRole_id(int role_id) {
		this.role_id = role_id;
	}
	@Column(name = "username")
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	@Column(name = "userpassword")
	public String getUserpassword() {
		return userpassword;
	}
	public void setUserpassword(String userpassword) {
		this.userpassword = userpassword;
	}
	@Column(name = "emp_id")
	public int getEmp_id() {
		return emp_id;
	}
	public void setEmp_id(int emp_id) {
		this.emp_id = emp_id;
	}
	@Column(name = "user_phoneno")
	public String getUser_phoneno() {
		return user_phoneno;
	}
	public void setUser_phoneno(String user_phoneno) {
		this.user_phoneno = user_phoneno;
	}
	@Column(name = "user_emailid")
	public String getUser_emailid() {
		return user_emailid;
	}
	public void setUser_emailid(String user_emailid) {
		this.user_emailid = user_emailid;
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

	@OneToOne(fetch = FetchType.LAZY, mappedBy = "user", cascade = CascadeType.ALL)
	@JsonManagedReference
	public EmployeeMaster getEmployeeMaster() {
		return employeeMaster;
	}

	public void setEmployeeMaster(EmployeeMaster employeeMaster) {
		this.employeeMaster = employeeMaster;
	}

	
}
