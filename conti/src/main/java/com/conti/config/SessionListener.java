package com.conti.config;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;

//import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Scope;

//import com.broman.dao.UsersDao;


import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.session.HttpSessionEventPublisher;
import org.springframework.stereotype.Component;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.conti.others.UserInformation;
import com.conti.setting.usercontrol.UsersDao;
import com.conti.userlog.UserLogDao;
import com.conti.userlog.UserLogModel;

/**
 * @Project_Name conti
 * @Package_Name com.conti.config
 * @File_name SessionListener.java
 * @author Sankar
 * @Created_date_time Jun 20, 2017 2:21:39 PM
 * @Updated_date_time Jun 20, 2017 2:21:39 PM
 *
 */

@Component
@Scope(value = "session", proxyMode = ScopedProxyMode.INTERFACES)
public class SessionListener extends HttpSessionEventPublisher {
	
	//private static final Logger logger = Logger.getLogger(SessionListener.class);
	
	@SuppressWarnings("unused")
	@Autowired
	private UsersDao usersDao;
	@Autowired
	private UserLogDao userLogDao;

	UserInformation userInformation;
	
    @Override
    public void sessionCreated(HttpSessionEvent event) {

        
        event.getSession().setMaxInactiveInterval(50*60);
        
        ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(event.getSession().getServletContext());
        HttpSessionEventPublisher service = ctx.getBean(HttpSessionEventPublisher.class);
        super.sessionCreated(event);
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        System.out.println(service);
        System.out.println(auth);
        
    } 
 
    @Override
    public void sessionDestroyed(HttpSessionEvent event) {
    	/*UserLogModel userLogModel = new UserLogModel();
    	
    	
    	HttpSession session = event.getSession();
        SecurityContext context = (SecurityContext)session.getAttribute("SPRING_SECURITY_CONTEXT");
        Authentication authentication = context.getAuthentication();
        Object principal = authentication.getPrincipal();
        System.out.println("############################################");
        String user1 = null;
        if (principal instanceof UserDetails) {
			user1 = ((UserDetails) principal).getUsername();
		} else {
			user1 = principal.toString();
		}
        userLogModel.setUser_id(Integer.parseInt(userInformation.getUserId()));
        userLogModel.setLast_loginhours(2);
        userLogDao.saveorupdate(userLogModel); userInformation.getUserName();
        
        System.out.println(principal.toString());*/

    	ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(event.getSession().getServletContext());
        HttpSessionEventPublisher service = ctx.getBean(HttpSessionEventPublisher.class);
        
        SecurityContextHolder.clearContext();
        super.sessionDestroyed(event);
        
        System.out.println(service);
    }
    
}