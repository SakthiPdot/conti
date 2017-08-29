package com.conti.config;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.session.SessionInformation;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.session.SessionRegistryImpl;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

/**
 * @Project_Name conti
 * @Package_Name com.conti.config
 * @File_name SecurityConfig.java
 * @author Sankar
 * @Created_date_time Jun 20, 2017 2:21:39 PM
 * @Updated_date_time Jun 20, 2017 2:21:39 PM
 *
 */

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {
	
	@Autowired
	@Qualifier("userDetailsService")
	public UserDetailsService userDetailsService;
	
	@Autowired 
	AuthenticationSuccessHandler customAuthenticatonSuccessHandler;

	@Autowired
	public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception
	{
		auth.userDetailsService(userDetailsService).passwordEncoder(passwordEncoder());
	}
	

	/* (non-Javadoc)
	 * @see org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter#configure(org.springframework.security.config.annotation.web.builders.HttpSecurity)
	 */
	@Override
	public void configure(HttpSecurity http) throws Exception 
	{
		http.
		
		            authorizeRequests()

							
							//.antMatchers("/admin/**").access("hasRole('FULL ACCESS')")
							
							.antMatchers("/","/admin/**").access("hasRole('SUPER_ADMIN') or hasRole('MANAGER')or hasRole('STAFF')")
							.antMatchers("/employee/").access("hasRole('SUPER_ADMIN') or hasRole('MANAGER')")
							.antMatchers("/company_settings/").access("hasRole('SUPER_ADMIN') or hasRole('MANAGER')")
							.antMatchers("/user/").access("hasRole('SUPER_ADMIN') or hasRole('MANAGER')")
							.antMatchers("/product/").access("hasRole('SUPER_ADMIN') or hasRole('MANAGER')")
							.antMatchers("/location/").access("hasRole('SUPER_ADMIN') or hasRole('MANAGER')")
							.antMatchers("/branch/").access("hasRole('SUPER_ADMIN') or hasRole('MANAGER')")
							.antMatchers("/service/").access("hasRole('SUPER_ADMIN') or hasRole('MANAGER')")
							.antMatchers("/vehicle/").access("hasRole('SUPER_ADMIN') or hasRole('MANAGER')")
							.antMatchers("/price_settings_register/").access("hasRole('SUPER_ADMIN') or hasRole('MANAGER')")
							.antMatchers("/price_settings/").access("hasRole('SUPER_ADMIN') or hasRole('MANAGER')or hasRole('STAFF')")
							.and()				
							.formLogin().loginPage("/login").failureUrl("/login?error").successHandler(customAuthenticatonSuccessHandler)			
							.usernameParameter("username")
							.passwordParameter("password")				
							.and().logout().logoutSuccessUrl("/login?logout").invalidateHttpSession(true)			
						    .deleteCookies("JSESSIONID")
						    .permitAll()
						  
							.and().csrf()	
							  .and().exceptionHandling().accessDeniedPage("/403")		
							  .and()
							  .sessionManagement()

							  .sessionFixation().changeSessionId()
							  	.invalidSessionUrl("/login?invalid")					  	
							    .maximumSessions(1)				    				    				    
							    	.maxSessionsPreventsLogin(true)
							    	.expiredUrl("/login?expired")							    	
							    	.sessionRegistry(sessionRegistry());
	}
	

	
	
	@Override
    public void configure(WebSecurity web) throws Exception {
        web
                .ignoring()
                .antMatchers("/resources/**");
    }
	
	
	@Bean
	public PasswordEncoder passwordEncoder(){
		PasswordEncoder encoder = new BCryptPasswordEncoder();		
		return encoder;
	}
	
	
	
	@Bean(name = "sessionRegistry")
	public SessionRegistry sessionRegistry() {
	  return new SessionRegistryImpl();
	}

	@Autowired
	private SessionRegistry sessionRegistry;
	 
	public List<SessionInformation> getActiveSessions() {
	  List<SessionInformation> activeSessions = new ArrayList<>();
	  for(Object principal : sessionRegistry.getAllPrincipals()) {
	    activeSessions.addAll(sessionRegistry.getAllSessions(principal, false));
	    
	    
	  }
	  return activeSessions;
	}
	
	

}