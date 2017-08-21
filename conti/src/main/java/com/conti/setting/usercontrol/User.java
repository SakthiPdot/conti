package com.conti.setting.usercontrol;




import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

import com.conti.master.branch.BranchModel;
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
@JsonIgnoreProperties(ignoreUnknown = true)

public class User /*implements Serializable*/{

	private int company_id, user_id, created_by, updated_by;
	private String username, userpassword; 
	private String obsolete, active, created_datetime, updated_datetime;
	
	
	
	
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
	public User(int company_id, int user_id, int created_by, int updated_by, String username,
			String userpassword, String obsolete, String active,
			String created_datetime, String updated_datetime, EmployeeMaster employeeMaster) {
		super();
		this.company_id = company_id;
		this.user_id = user_id;

		
		this.created_by = created_by;
		this.updated_by = updated_by;
		this.username = username;
		this.userpassword = userpassword;

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
	
	private EmployeeMaster employeeMaster;
	
	/*@OneToOne(fetch = FetchType.LAZY, mappedBy = "user", cascade = CascadeType.ALL)
	@JsonManagedReference*/
	
	@OneToOne(fetch = FetchType.EAGER, optional=false, cascade = CascadeType.MERGE)
	@JoinColumn(name = "emp_id")
	public EmployeeMaster getEmployeeMaster() {
		return employeeMaster;
	}

	public void setEmployeeMaster(EmployeeMaster employeeMaster) {
		this.employeeMaster = employeeMaster;
	}
	
	public BranchModel branchModel;
	@OneToOne(fetch = FetchType.EAGER, optional=false, cascade = CascadeType.MERGE)
	@JoinColumn(name = "branch_id")
	public BranchModel getBranchModel() {
		return branchModel;
	}
	public void setBranchModel(BranchModel branchModel) {
		this.branchModel = branchModel;
	}

	public Role role;
	@JoinColumn(name = "role_id")
	@OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
	public Role getRole() {
		return role;
	}
	public void setRole(Role role) {
		this.role = role;
	}
	
	/*public Set<UserPrivilege> userPrivilege = new HashSet<>();
	@OneToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL,mappedBy="user")
	public Set<UserPrivilege> getUserPrivilege() {
		return userPrivilege;
	}
	public void setUserPrivilege(Set<UserPrivilege> userPrivilege) {
		this.userPrivilege = userPrivilege;
	}*/

	
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
