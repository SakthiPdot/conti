package com.conti.master.employee;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonBackReference;
import org.codehaus.jackson.annotate.JsonIgnoreProperties;

import com.conti.master.branch.BranchModel;
import com.conti.master.location.Location;
import com.conti.setting.usercontrol.User;

/**
 * @Project_Name conti
 * @Package_Name com.conti.master.employee
 * @File_name EmployeeMaster.java
 * @author Sankar
 * @Created_date_time Jun 22, 2017 12:09:22 PM
 * @Updated_date_time Jun 22, 2017 12:09:22 PM
 */
@Entity
@Table(name = "m_employee")
@JsonIgnoreProperties(ignoreUnknown = true)
public class EmployeeMaster /*implements Serializable*/{
	

	private int emp_id, /*branch_id, location_id,*/ update_by, created_by;
	private long emp_phoneno;
	private String emp_name, emp_code, empcategory, emp_address1, emp_address2, emp_email, dob, doj, created_datetime, updated_datetime, obsolete, active;
	
	public EmployeeMaster() {
		
	}

	private User user;
	
	@OneToOne(fetch = FetchType.LAZY)
	@PrimaryKeyJoinColumn
	@JsonBackReference	
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
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
	
	public BranchModel branchModel;
	@JoinColumn(name = "branch_id")
	@OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
	public BranchModel getBranchModel() {
		return branchModel;
	}
	public void setBranchModel(BranchModel branchModel) {
		this.branchModel = branchModel;
	}
	
	/**
	 * @param emp_id
	 * @param branch_id
	 * @param update_by
	 * @param created_by
	 * @param emp_name
	 * @param emp_code
	 * @param empcategory
	 * @param emp_address
	 * @param emp_email
	 * @param created_datetime
	 * @param updated_datetime
	 * @param obsolete
	 * @param active
	 * @param user
	 */
/*	public EmployeeMaster(int emp_id, int branch_id, int location_id, int emp_phoneno, int update_by, int created_by, String emp_name, String emp_code,
			String empcategory, String emp_address, String emp_email, String dob, String doj, String created_datetime, String updated_datetime,
			String obsolete, String active, User user) {
		super();
		this.emp_id = emp_id;
		this.branch_id = branch_id;
		this.location_id = location_id;
		this.update_by = update_by;
		this.created_by = created_by;
		this.emp_name = emp_name;
		this.emp_code = emp_code;
		this.empcategory = empcategory;
		this.emp_address = emp_address;
		this.emp_email = emp_email;
		this.dob = dob;
		this.doj = doj;		
		this.created_datetime = created_datetime;
		this.updated_datetime = updated_datetime;
		this.obsolete = obsolete;
		this.active = active;
		this.user = user;
	}
*/


	@Id
	@Column(name = "emp_id")
	public int getEmp_id() {
		return emp_id;
	}
	public void setEmp_id(int emp_id) {
		this.emp_id = emp_id;
	}
	/*	@Column(name = "branch_id")
	public int getBranch_id() {
		return branch_id;
	}
	public void setBranch_id(int branch_id) {
		this.branch_id = branch_id;
	}*/
	

	
/*	@Column(name = "location_id")
	 public int getLocation_id() {
		return location_id;
	}
	public void setLocation_id(int location_id) {
		this.location_id = location_id;
	}*/

	@Column(name = "emp_phoneno")
	public long getEmp_phoneno() {
		return emp_phoneno;
	}

	public void setEmp_phoneno(long emp_phoneno) {
		this.emp_phoneno = emp_phoneno;
	}

	@Column(name = "updated_by")
	public int getUpdate_by() {
		return update_by;
	}




	public void setUpdate_by(int update_by) {
		this.update_by = update_by;
	}	
	@Column(name = "created_by")
	public int getCreated_by() {
		return created_by;
	}
	public void setCreated_by(int created_by) {
		this.created_by = created_by;
	}
	@Column(name = "emp_name")
	public String getEmp_name() {
		return emp_name;
	}
	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}
	@Column(name = "emp_code")
	public String getEmp_code() {
		return emp_code;
	}
	public void setEmp_code(String emp_code) {
		this.emp_code = emp_code;
	}
	@Column(name = "empcategory")
	public String getEmpcategory() {
		return empcategory;
	}
	public void setEmpcategory(String empcategory) {
		this.empcategory = empcategory;
	}
	@Column(name = "emp_address1")
	public String getEmp_address1() {
		return emp_address1;
	}
	public void setEmp_address1(String emp_address1) {
		this.emp_address1 = emp_address1;
	}
	@Column(name = "emp_address2")
	public String getEmp_address2() {
		return emp_address2;
	}
	public void setEmp_address2(String emp_address2) {
		this.emp_address2 = emp_address2;
	}
	
	
	@Column(name = "emp_email")
	public String getEmp_email() {
		return emp_email;
	}
	
	public void setEmp_email(String emp_email) {
		this.emp_email = emp_email;
	}
	
	
	@Column(name ="dob")  
	public String getDob() {
		return dob;
	}



	public void setDob(String dob) {
		this.dob = dob;
	}


	@Column(name ="doj")  
	public String getDoj() {
		return doj;
	}



	public void setDoj(String doj) {
		this.doj = doj;
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
