package com.conti.others;

/**
 * @Project_Name conti
 * @Package_Name com.conti.others
 * @File_name ConstantValues.java
 * @author Sankar
 * @Created_date_time Jun 20, 2017 2:21:39 PM
 * @Updated_date_time Jun 20, 2017 2:21:39 PM
 */

public final class ConstantValues {
	
	public ConstantValues() {
		 
	}

	public static final String LOGGER_STATUS_L = "LOAD";
	public static final String LOGGER_STATUS_S = "SAVE";
	public static final String LOGGER_STATUS_U = "UPDATE";
	public static final String LOGGER_STATUS_D = "DELETE";
	public static final String LOGGER_STATUS_E = "EXCEPTION";
	public static final String SAVE_SUCCESS = "SUCCESS";
	public static final String SAVE_NOT_SUCCESS = "NOT_SUCCESS";
	
	public static final String FETCH_NOT_SUCCESS="FETCH_NOT_SUCCESS";
	public static final String FETCH_SUCCESS="FETCH_SUCCESS";
	public static final String DELETE_SUCCESS="DELETE_SUCCESS";
	public static final String DELETE_NOT_SUCCESS="DELETE_NOT_SUCCESS";	
	public static final String CSV_DOWNLOADED = "CSV";
	public static final String PRINT ="PRINT";
	
	//APPLICATION_TIMEOUT
	public static final String APPLICATION_TIMEOUT = "30";
	
	//REFERENCE NUMBER FOR ENTRY SCREENS- STANDARDIZED
	
	//Send success
	public static final String SEND_SUCCESS ="SEND_SUCCESS";
	public static final String SEND_NOT_SUCCESS ="SEND_NOT_SUCCESS";	
	
	//Email config
	public static final String MAIL_ID = "pointdot2016@gmail.com";
	public static final String MAIL_PASSWORD = "pointdot@123";
	
	//SMS config
	public static final String SMS_URL = "http://103.250.30.5/SendSMS/sendmsg.php";
	public static final String SMS_USERNAME = "conti02";
	//public static final String SMS_USERNAME = "ss";
	public static final String SMS_PASSWORD = "abc321";
	public static final String SMS_SENDER_CODE = "CONTIK";
//	public static final String SMS_SENDER_CODE = "dd";
	
	// in minutes (2 hrs)
	public static final int SMS_MAXHOUR_FORGOT_USERNAME = 120;
	public static final int SMS_MAXCOUNT_FORGOT_USERNAME = 2;
	
	// USER ROLE
	public static final String ROLE_SADMIN = "SUPER_ADMIN";
	public static final String ROLE_ADMIN = "MANAGER";
	public static final String ROLE_CUSER = "STAFF";
	
}
