package com.conti.others;

import java.io.IOException;

/**
 * @Project_Name conti
 * @Package_Name com.conti.others
 * @File_name SendMailSMS.java
 * @author Sankar
 * @Created_date_time Jun 23, 2017 2:33:03 PM
 * @Updated_date_time Jun 23, 2017 2:33:03 PM
 */
public interface SendMailSMS {

	
	public void send_Mail(String[] email, String subject, String message);
	
	//multiple mobile number separated by comma (,) 
	public String send_SMS(String mobileno, String message) throws IOException;
}
