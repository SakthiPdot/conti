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

import com.conti.others.ConstantValues;
import com.conti.others.UserInformation;
import com.conti.setting.usercontrol.UsersDao;
import com.conti.settings.company.Company;
import com.conti.settings.company.CompanySettingDAO;
import com.conti.userlog.UserLogDao;

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
	@Autowired
	private CompanySettingDAO companySettingDao;
	UserInformation userInformation;
	ConstantValues constantVal;
    @Override
    public void sessionCreated(HttpSessionEvent event) {

    	/*Company company = companySettingDao.getById(1);
        if(company!=null){
        	if(company.getCompany_apptimeout() != 0){
        		event.getSession().setMaxInactiveInterval(company.getCompany_apptimeout()*60);		
        	} else {
        		event.getSession().setMaxInactiveInterval(Integer.parseInt(constantVal.APPLICATION_TIMEOUT)*60);
        	}
        }else{
        	event.getSession().setMaxInactiveInterval(Integer.parseInt(constantVal.APPLICATION_TIMEOUT)*60);
        }*/
        
        
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