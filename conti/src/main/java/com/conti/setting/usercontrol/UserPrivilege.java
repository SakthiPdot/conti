package com.conti.setting.usercontrol;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.conti.master.branch.BranchModel;


/**
 * @Project_Name conti
 * @Package_Name com.conti.setting.usercontrol
 * @File_name UserPrivilege.java
 * @author Sankar
 * @Created_date_time Jun 20, 2017 2:21:39 PM
 * @Updated_date_time Jul 25, 2017 9:32:39 AM
 */


@Entity
@Table(name="a_userpriviledge")
public class UserPrivilege {
	
	private int userprivilege_id;
	private String role_menuname, role_screenname, userprivilege_add, userprivilege_delete, userprivilege_modify, userprivilege_print, userprivilege_view, created_datetime, updated_datetime,obsolete, active/*, role_name*/;
	
	@Id
	@Column(name = "userprivilege_id")
	public int getUserprivilege_id() {
		return userprivilege_id;
	}
	public void setUserprivilege_id(int userprivilege_id) {
		this.userprivilege_id = userprivilege_id;
	}
	
	
	public BranchModel branch;
	@JoinColumn(name = "branch_id")
	@OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
	public BranchModel getBranch() {
		return branch;
	}
	public void setBranch(BranchModel branch) {
		this.branch = branch;
	}
	
	public User user;
	@JoinColumn(name = "user_id")
	@OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
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
	
	@Column(name = "role_menuname")
	public String getRole_menuname() {
		return role_menuname;
	}
	
	
	public void setRole_menuname(String role_menuname) {
		this.role_menuname = role_menuname;
	}
	@Column(name = "role_screenname")
	public String getRole_screenname() {
		return role_screenname;
	}
	public void setRole_screenname(String role_screenname) {
		this.role_screenname = role_screenname;
	}
	@Column(name = "userprivilege_add")
	public String getUserprivilege_add() {
		return userprivilege_add;
	}
	
	public void setUserprivilege_add(String userprivilege_add) {
		this.userprivilege_add = userprivilege_add;
	}
	@Column(name = "userprivilege_delete")
	public String getUserprivilege_delete() {
		return userprivilege_delete;
	}
	public void setUserprivilege_delete(String userprivilege_delete) {
		this.userprivilege_delete = userprivilege_delete;
	}
	@Column(name = "userprivilege_modify")
	public String getUserprivilege_modify() {
		return userprivilege_modify;
	}
	public void setUserprivilege_modify(String userprivilege_modify) {
		this.userprivilege_modify = userprivilege_modify;
	}
	@Column(name = "userprivilege_print")
	public String getUserprivilege_print() {
		return userprivilege_print;
	}
	public void setUserprivilege_print(String userprivilege_print) {
		this.userprivilege_print = userprivilege_print;
	}
	@Column(name = "userprivilege_view")
	public String getUserprivilege_view() {
		return userprivilege_view;
	}
	public void setUserprivilege_view(String userprivilege_view) {
		this.userprivilege_view = userprivilege_view;
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
