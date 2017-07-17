package com.conti.setting.usercontrol;


import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base64;
import org.codehaus.jackson.JsonProcessingException;
import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.authentication.session.SessionAuthenticationException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.conti.config.SessionListener;
import com.conti.master.vehicle.VehicleMaster;
import com.conti.others.ConstantValues;
import com.conti.others.Loggerconf;
import com.conti.others.UserInformation;
import com.conti.setting.usercontrol.RoleDao;
import com.conti.setting.usercontrol.User;
import com.conti.setting.usercontrol.UsersDao;
import com.conti.settings.company.Company;
import com.conti.settings.company.CompanySettingDAO;

/**
 * @Project_Name conti
 * @Package_Name com.conti.setting.usercontrol
 * @File_name UserController.java
 * @author Sankar
 * @Created_date_time Jun 20, 2017 2:21:39 PM
 * @Updated_date_time Jun 20, 2017 2:21:39 PM
 */

@Controller
public class UserController {

	final Logger logger = LoggerFactory.getLogger(UserController.class);

	@Autowired
	private UsersDao usersDao;
	@Autowired
	private CompanySettingDAO companySettingDAO;
		
	@Autowired
	@Qualifier("sessionRegistry")
	private SessionRegistry sessionRegistry;
		
	Loggerconf loggerconf = new Loggerconf();
	SessionListener sessionListener = new SessionListener();

	@RequestMapping(value =  "user", method = RequestMethod.GET)
	public ModelAndView adminPage(HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		
		UserInformation userinfo = new UserInformation(request);
		String username = userinfo.getUserName();		
		String userid = userinfo.getUserId();
		ModelAndView model = new ModelAndView();
		
		try
		{
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
			
			model.addObject("title", "User Master");
			model.addObject("message", "This page is for ROLE_ADMIN only!");
			model.setViewName("Settings/user_master");

			
		} catch (Exception exception) {
			loggerconf.saveLogger(username,  "Admin / ", ConstantValues.LOGGER_STATUS_E, exception);
		}
		return model;

	}
	
	@RequestMapping(value = {"forgot_password"}, method = RequestMethod.GET)
	public ModelAndView forgot_password() throws Exception {
		
		ModelAndView model = new ModelAndView();
			
			model.addObject("title", "Conti - Forgot Password");
			model.addObject("message", "Forgot password in Conti");
			model.setViewName("forgot_password");
			
		
		return model;

	}
	
	
	

}