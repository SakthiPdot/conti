package com.conti.setting.usercontrol;


import javax.persistence.Column;
import javax.persistence.Entity;

import javax.persistence.Id;

import javax.persistence.Table;

/**
 * @Project_Name conti
 * @Package_Name com.conti.setting.usercontrol
 * @File_name RolePrivilege.java
 * @author Sankar
 * @Created_date_time Jun 20, 2017 2:21:39 PM
 * @Updated_date_time Jun 20, 2017 2:21:39 PM
 */

@Entity
@Table(name="a_roleprivilege")
public class RolePrivilege {

	private int roleprivilege_Id, role_id;
	private String role_menuname, role_screenname, role_add, role_modify, role_delete, role_print, role_view, created_datetime, updated_datetime, obsolete, active;
	
	@Id
	@Column(name = "roleprivilege_Id")
	public int getRoleprivilege_Id() {
		return roleprivilege_Id;
	}
	public void setRoleprivilege_Id(int roleprivilege_Id) {
		this.roleprivilege_Id = roleprivilege_Id;
	}
	
	@Column(name = "role_id")
	public int getRole_id() {
		return role_id;
	}
	public void setRole_id(int role_id) {
		this.role_id = role_id;
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
	
	@Column(name = "role_add")
	public String getRole_add() {
		return role_add;
	}
	public void setRole_add(String role_add) {
		this.role_add = role_add;
	}
	
	@Column(name = "role_modify")
	public String getRole_modify() {
		return role_modify;
	}
	public void setRole_modify(String role_modify) {
		this.role_modify = role_modify;
	}
	
	@Column(name = "role_delete")
	public String getRole_delete() {
		return role_delete;
	}
	public void setRole_delete(String role_delete) {
		this.role_delete = role_delete;
	}
	
	@Column(name = "role_print")
	public String getRole_print() {
		return role_print;
	}
	public void setRole_print(String role_print) {
		this.role_print = role_print;
	}
	
	@Column(name = "role_view")
	public String getRole_view() {
		return role_view;
	}
	public void setRole_view(String role_view) {
		this.role_view = role_view;
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
	
	
	
	
	
	/*private int RolePrivilege_Id,Role_Id;
	private String Role_MenuName,Role_ScreenName,Role_ADD,Role_MODIFY,Role_DELETE,Role_PRINT,Role_VIEW,
	Role_CreatedDate,Role_UpdatedDate,Obsolete,Active;
	@Id
	@Column(name = "roleprivilege_Id")
	public int getRolePrivilege_Id() {
		return RolePrivilege_Id;
	}
	public void setRolePrivilege_Id(int rolePrivilege_Id) {
		RolePrivilege_Id = rolePrivilege_Id;
	}
	
	@Column(name = "role_id")
	public int getRole_Id() {
		return Role_Id;
	}
	public void setRole_Id(int role_Id) {
		Role_Id = role_Id;
	}
	@Column(name = "role_menuname")
	public String getRole_MenuName() {
		return Role_MenuName;
	}
	public void setRole_MenuName(String role_MenuName) {
		Role_MenuName = role_MenuName;
	}
	@Column(name = "role_screenname")
	public String getRole_ScreenName() {
		return Role_ScreenName;
	}
	public void setRole_ScreenName(String role_ScreenName) {
		Role_ScreenName = role_ScreenName;
	}
	@Column(name = "role_add")
	public String getRole_ADD() {
		return Role_ADD;
	}
	public void setRole_ADD(String role_ADD) {
		Role_ADD = role_ADD;
	}
	@Column(name = "role_modify")
	public String getRole_MODIFY() {
		return Role_MODIFY;
	}
	public void setRole_MODIFY(String role_MODIFY) {
		Role_MODIFY = role_MODIFY;
	}
	@Column(name = "role_delete")
	public String getRole_DELETE() {
		return Role_DELETE;
	}
	public void setRole_DELETE(String role_DELETE) {
		Role_DELETE = role_DELETE;
	}
	@Column(name = "role_print")
	public String getRole_PRINT() {
		return Role_PRINT;
	}
	public void setRole_PRINT(String role_PRINT) {
		Role_PRINT = role_PRINT;
	}
	@Column(name = "role_view")
	public String getRole_VIEW() {
		return Role_VIEW;
	}
	public void setRole_VIEW(String role_VIEW) {
		Role_VIEW = role_VIEW;
	}
	@Column(name = "created_datetime")
	public String getRole_CreatedDate() {
		return Role_CreatedDate;
	}
	public void setRole_CreatedDate(String role_CreatedDate) {
		Role_CreatedDate = role_CreatedDate;
	}
	@Column(name = "updated_datetime")
	public String getRole_UpdatedDate() {
		return Role_UpdatedDate;
	}
	public void setRole_UpdatedDate(String role_UpdatedDate) {
		Role_UpdatedDate = role_UpdatedDate;
	}
	@Column(name = "obsolete")
	public String getObsolete() {
		return Obsolete;
	}
	public void setObsolete(String obsolete) {
		Obsolete = obsolete;
	}
	@Column(name = "active")
	public String getActive() {
		return Active;
	}
	public void setActive(String active) {
		Active = active;
	}*/
	
}