package com.conti.config;

import javax.servlet.http.HttpSessionEvent;

//import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Scope;

//import com.broman.dao.UsersDao;


import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import org.springframework.security.web.session.HttpSessionEventPublisher;
import org.springframework.stereotype.Component;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.conti.setting.usercontrol.UsersDao;

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

    	ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(event.getSession().getServletContext());
        HttpSessionEventPublisher service = ctx.getBean(HttpSessionEventPublisher.class);

        SecurityContextHolder.clearContext();
        super.sessionDestroyed(event);
        
        System.out.println(service);
    }
    
}