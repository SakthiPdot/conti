package com.conti.config;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.conti.others.ConstantValues;
import com.conti.setting.usercontrol.User;
import com.conti.setting.usercontrol.UsersDao;
import com.conti.settings.company.Company;
import com.conti.settings.company.CompanySettingDAO;


/**
 * Servlet implementation class CustomAuthenticationSuccessHandler
 */
/**
 * @Project_Name conti
 * @Package_Name com.conti.config
 * @File_name CustomAuthenticationSuccessHandler.java
 * @author Sankar
 * @Created_date_time Jun 20, 2017 2:21:39 PM
 * @Updated_date_time Jun 20, 2017 2:21:39 PM
 */

public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {
	private static final long serialVersionUID = 1L;
	private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
		
	@Autowired
	private UsersDao usersdao;
	@Autowired
	private CompanySettingDAO companyDao;
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		
		System.out.println(authentication.getName()+" == authenticator name =============");
		
		//for getting user name from session
		HttpSession session = request.getSession();
		String usern =authentication.getName();
		session.setAttribute("bromanuser", usern);
	
		
		//get the client id from user dao using user name and set the client id in session
		User user=usersdao.findByUserName(usern);
		int userclientid=user.getCompany_id();
		session.setAttribute("userclientid", userclientid);
	
		//Check
		System.out.println("+++++++++++++++"+usern);
		System.out.println("+++++++++++++++"+ userclientid);
		

		Company company=companyDao.getById(1);
	
		if(company != null){
		if(company.getCompany_apptimeout() != 0 ){
			session.setMaxInactiveInterval(60*company.getCompany_apptimeout() );
		}else{
			session.setMaxInactiveInterval(60*Integer.parseInt(ConstantValues.APPLICATION_TIMEOUT));
		}
		}else{
			session.setMaxInactiveInterval(60*Integer.parseInt(ConstantValues.APPLICATION_TIMEOUT));
		}
		
		System.out.println(session.getMaxInactiveInterval()+" == max interval session time =============");	
		
		redirectStrategy.sendRedirect(request, response, "/");
	}
	
	public RedirectStrategy getRedirectStrategy() {
		return this.redirectStrategy;
	}

	public void setRedirectStrategy(RedirectStrategy redirectStrategy) {
		this.redirectStrategy = redirectStrategy;
	}


    
}
