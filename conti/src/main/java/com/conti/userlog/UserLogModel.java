package com.conti.userlog;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

/**
 * @Project_Name conti
 * @Package_Name com.conti.userlog
 * @File_name UserLogModel.java
 * @author Sankar
 * @Created_date_time Jun 27, 2017 3:34:05 PM
 * @Updated_date_time Jun 27, 2017 3:34:05 PM
 */
@Entity
@Table(name = "t_userlog")
public class UserLogModel {
	
	private int log_id, user_id, last_loginhours, password_reset_flag,forgotusernme_count;
	private String loggedin_date, username_request, password_request, link;
	
	@Id
	@GeneratedValue
	@Column(name = "log_id")
	public int getLog_id() {
		return log_id;
	}
	public void setLog_id(int log_id) {
		this.log_id = log_id;
	}
	@Column(name = "user_id")
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	@Column(name = "last_loginhours")
	public int getLast_loginhours() {
		return last_loginhours;
	}
	public void setLast_loginhours(int last_loginhours) {
		this.last_loginhours = last_loginhours;
	}
	@Column(name = "loggedin_date")
	public String getLoggedin_date() {
		return loggedin_date;
	}
	public void setLoggedin_date(String loggedin_date) {
		this.loggedin_date = loggedin_date;
	}
	@Column(name = "username_request")
	public String getUsername_request() {
		return username_request;
	}
	public void setUsername_request(String username_request) {
		this.username_request = username_request;
	}
	@Column(name = "password_request")
	public String getPassword_request() {
		return password_request;
	}
	public void setPassword_request(String password_request) {
		this.password_request = password_request;
	}
	@Column(name = "link")
	public String getLink() {
		return link;
	}
	public void setLink(String link) {
		this.link = link;
	}
	@Column(name = "password_reset_flag")	
	public int getPassword_reset_flag() {
		return password_reset_flag;
	}
	public void setPassword_reset_flag(int password_reset_flag) {
		this.password_reset_flag = password_reset_flag;
	}
	
	@Column(name = "forgotusernme_count")	
	public int getForgotusernme_count() {
		return forgotusernme_count;
	}
	public void setForgotusernme_count(int forgotusernme_count) {
		this.forgotusernme_count = forgotusernme_count;
	}
	
	
	
	
}
