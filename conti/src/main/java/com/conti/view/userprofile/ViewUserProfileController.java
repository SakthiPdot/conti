package com.conti.view.userprofile;



import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import com.conti.config.SessionListener;
import com.conti.others.ConstantValues;
import com.conti.others.Loggerconf;
import com.conti.others.UserInformation;
import com.conti.setting.usercontrol.User;
import com.conti.setting.usercontrol.UsersDao;

/**
 * @Project_Name conti
 * @Package_Name com.conti.view.userprofile
 * @File_name ViewUserProfileController.java
 * @author Sakthi
 * @Created_date_time Jun 20, 2017 2:21:39 PM
 * @Updated_date_time Jun 20, 2017 2:21:39 PM
 */

@RestController
public class ViewUserProfileController {

	final Logger logger = LoggerFactory.getLogger(ViewUserProfileController.class);

	@Autowired
	private UsersDao usersDao;

		
	@Autowired
	@Qualifier("sessionRegistry")
	private SessionRegistry sessionRegistry;
		
	Loggerconf loggerconf = new Loggerconf();
	SessionListener sessionListener = new SessionListener();
	UserInformation userinfo;
	@RequestMapping(value =  "user_profile", method = RequestMethod.GET)
	public ModelAndView adminPage( HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		System.out.println(session);
		userinfo = new UserInformation(request);
		String username = userinfo.getUserName();
		int user_id = Integer.parseInt(userinfo.getUserId());
		
		
		ModelAndView model = new ModelAndView();
		
		try
		{
			User user = usersDao.get(user_id);
			String role_name = user.role.getRole_Name();
			model.addObject("role_name", role_name);
			
			
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
			model.addObject("user", user);
			model.addObject("user_id", user_id);
			model.addObject("title", " User Profile");
			model.addObject("message", "This page is for ROLE_ADMIN only!");
			model.setViewName("User Profile/user_profile");

		} catch (Exception exception) {
			loggerconf.saveLogger(username,  "Admin / ", ConstantValues.LOGGER_STATUS_E, exception);
		}
		return model;

	}

	 

}