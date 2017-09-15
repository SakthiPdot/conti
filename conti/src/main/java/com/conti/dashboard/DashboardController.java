package com.conti.dashboard;


import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.security.web.authentication.session.SessionAuthenticationException;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.conti.config.SessionListener;
import com.conti.others.ConstantValues;
import com.conti.others.DateTimeCalculation;
import com.conti.others.Loggerconf;
import com.conti.others.UserInformation;
import com.conti.setting.usercontrol.User;
import com.conti.setting.usercontrol.UsersDao;
import com.conti.userlog.UserLogDao;
import com.conti.userlog.UserLogModel;

/**
 * @Project_Name conti
 * @Package_Name com.conti.dashboard
 * @File_name DashboardController.java
 * @author Sankar
 * @Created_date_time Jun 20, 2017 2:21:39 PM
 * @Updated_date_time Jun 20, 2017 2:21:39 PM
 */

@RestController
public class DashboardController {

	final Logger logger = LoggerFactory.getLogger(DashboardController.class);

	@Autowired
	private UsersDao usersDao;
	
	@Autowired
	private UserLogDao userLogDao;
	@Autowired
	@Qualifier("sessionRegistry")
	private SessionRegistry sessionRegistry;
	@Autowired
	private DateTimeCalculation datetimeCalc;
	Loggerconf loggerconf = new Loggerconf();
	SessionListener sessionListener = new SessionListener();

	@RequestMapping(value = {"/","admin"}, method = RequestMethod.GET)
	public ModelAndView adminPage(HttpServletRequest request, UserLogModel userLogModel) throws Exception {
		
		HttpSession session = request.getSession();
		String username = request.getUserPrincipal().getName();
		User user = usersDao.findByUserName(username);
		int userid = user.getUser_id();
		
		session.setAttribute("username", username);
		session.setAttribute("userid", userid);
		
		User userDetails = usersDao.get(userid);
		int branch_id = userDetails.branchModel.getBranch_id();
		session.setAttribute("branch_id", branch_id);
		
		ModelAndView model = new ModelAndView();
		
		//UserInformation userinfo = new UserInformation(request);
		//String username = userinfo.getUserName();
		try
		{
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
			
			Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			
			// get current date
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date date = new Date();
			
			userLogModel.setUser_id(userid);
			userLogModel.setLoggedin_date(dateFormat.format(date));
			userLogModel.setForgotusernme_count(0);
			userLogDao.saveorupdate(userLogModel);
			loggerconf.saveLogger(username,  "Admin / ", ConstantValues.SAVE_SUCCESS, null);
			if (principal instanceof UserDetails) {
				String user1 = ((UserDetails) principal).getUsername();
			} else {
				String user1 = principal.toString();
			}
			model.addObject("title", "CONTI");
			model.addObject("message", "This page is for ROLE_ADMIN only!");
			model.setViewName("Dashboard/dashboard");

			
		} catch (Exception exception) {
			loggerconf.saveLogger(username,  "Admin / ", ConstantValues.LOGGER_STATUS_E, exception);
		}
		return model;

	}
	


	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public ModelAndView login(@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "logout", required = false) String logout,
			@RequestParam(value = "expired", required = false) String expired, HttpServletRequest request) {

		ModelAndView model = new ModelAndView();
		if (error != null) {
			model.addObject("error", getErrorMessage(request, "SPRING_SECURITY_LAST_EXCEPTION"));
		}

		if (logout != null) {
			model.addObject("msg", "You've been logged out successfully.");
		}

		if (expired != null) {
			model.addObject("msg", "Someone logged in..!");

		}
		model.setViewName("login");

		return model;

	}


	// customize the error message
	private String getErrorMessage(HttpServletRequest request, String key) {

		Exception exception = (Exception) request.getSession().getAttribute(key);

		String error = "";
		if (exception instanceof BadCredentialsException) {
			error = "Invalid username and password!";
		} else if (exception instanceof LockedException) {
			error = exception.getMessage();
		} else if (exception instanceof SessionAuthenticationException) {
			error = " Already the session is open...!";
			/*error = exception.toString();*/
		}

		else {
			error = "Invalid username and password!";
		}

		return error;
	}

	// for 403 access denied page
	@RequestMapping(value = "/403", method = RequestMethod.GET)
	public ModelAndView accesssDenied() {

		ModelAndView model = new ModelAndView();

		// check if user is login
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (!(auth instanceof AnonymousAuthenticationToken)) {
			UserDetails userDetail = (UserDetails) auth.getPrincipal();
			
			model.addObject("username", userDetail.getUsername());

		
		}

		model.setViewName("Dashboard/restriction");
		return model;

	}
	
	@RequestMapping(value = "/clogout", method = RequestMethod.GET)
	public ModelAndView logOut(HttpServletRequest request, HttpServletResponse response) {
		UserInformation userInformation = new UserInformation(request);
		int user_id = Integer.parseInt(userInformation.getUserId());
		List<UserLogModel> userlog_list = userLogDao.getUserlogListbyId(user_id);
		UserLogModel lastUserlog = Collections.max(userlog_list, Comparator.comparing(c -> c.getLog_id()));
		String[] hour = null;
		try {
			hour = datetimeCalc.calculateDateDiff(lastUserlog.getLoggedin_date());
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		lastUserlog.setLast_loginhours(Integer.parseInt(hour[2]));
		userLogDao.saveorupdate(lastUserlog);
		// check if user is login
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if(auth != null){
			new SecurityContextLogoutHandler().logout(request, response, auth);	         
		}
		
		ModelAndView model = new ModelAndView("redirect:" + "/login?logout");
		/*model.setViewName("/login");*/
		/*response.setHeader("Location", "/login");*/
		
		return model;

	}
	

}