package com.conti.others;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @Project_Name conti
 * @Package_Name com.conti.others
 * @File_name UserInformation.java
 * @author Sankar
 * @Created_date_time Jun 20, 2017 2:21:39 PM
 * @Updated_date_time Jun 20, 2017 2:21:39 PM
 */
public class UserInformation {
	private  final Logger logger = LoggerFactory.getLogger(UserInformation.class);
	Loggerconf loggerconf = new Loggerconf();
		public String userName;
		public String userBranchId;
		public String userId;
		public String currentDate;
		
	Date date=new Date();
	DateFormat dateformat = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
		
	public UserInformation(HttpServletRequest request) {
		
		HttpSession session = request.getSession(false);
		try
		{
			loggerconf.saveLogger(userName, "Session(UserInformation call)", ConstantValues.FETCH_SUCCESS,null);
//			if(session != null && session.getAttribute("userclientid") != null) 
//			{
				this.userName=(String) request.getSession().getAttribute("username");	
				this.userId=(String) request.getSession().getAttribute("userid").toString();
				this.userBranchId = (String) request.getSession().getAttribute("branch_id").toString();
				this.currentDate = dateformat.format(date);
			//} 
		}
		catch (Exception exception)
		{
			loggerconf.saveLogger(userName, "Session(UserInformation Error)", ConstantValues.FETCH_NOT_SUCCESS,exception);
			
			session.invalidate();
		}
		
	}
	
	public UserInformation(){
		
	}
	
	public String getUserName() {
		return this.userName;
	}


	public String getUserBranchId() {
		return this.userBranchId;
	}


	public String getUserId() {
		return this.userId;
	}


	public String getDate() {
		return this.currentDate;
	}

	

}
