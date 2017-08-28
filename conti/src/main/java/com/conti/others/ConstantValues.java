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
	public static final String MANIFIEST_NUMBER ="Manifest Number";
	public static final String LR_NUMBER ="LR Number";
	public static final String INTRANSIT ="Intransit";
	public static final String RECEIVED ="Received";
	public static final String MISSING ="Missing";
	public static final String PENDING="Pending";
	public static final String COMPLETED="Completed";
	public static final String INCOMPLETE="Incomplete";
	public static final String DELIVERED ="Delivered";
	
	//SHIPMENT (PAID/TO PAY)
	public static final String PAID = "Sender";
	public static final String TO_PAY = "Receiver";
	
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
	
	public static final String NO_IMAGE = "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";
	
}
