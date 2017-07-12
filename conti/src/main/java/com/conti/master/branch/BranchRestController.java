package com.conti.master.branch;


import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpHeaders;
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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.UriComponentsBuilder;

import com.conti.config.SessionListener;
import com.conti.master.employee.EmployeeMaster;
import com.conti.others.ConstantValues;
import com.conti.others.Loggerconf;
import com.conti.others.UserInformation;
import com.conti.setting.usercontrol.RoleDao;
import com.conti.setting.usercontrol.User;
import com.conti.setting.usercontrol.UsersDao;

/**
 * @Project_Name conti
 * @Package_Name com.conti.master.branch
 * @File_name BranchController.java
 * @author Sakthi
 * @Created_date_time Jun 20, 2017 2:21:39 PM
 * @Updated_date_time Jun 20, 2017 2:21:39 PM
 */

@RestController
public class BranchRestController {

	final Logger logger = LoggerFactory.getLogger(BranchRestController.class);

	@Autowired
	private UsersDao usersDao;
	@Autowired
	private BranchDao branchDao;
		
	@Autowired
	@Qualifier("sessionRegistry")
	private SessionRegistry sessionRegistry;
		
	Loggerconf loggerconf = new Loggerconf();
	ConstantValues constantVal = new ConstantValues();
	SessionListener sessionListener = new SessionListener();
	UserInformation userInformation;

	@RequestMapping(value =  "branch", method = RequestMethod.GET)
	public ModelAndView adminPage(HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		
		UserInformation userinfo = new UserInformation(request);
		String username = userinfo.getUserName();
		
		String userid = userinfo.getUserId();
		
		session.setAttribute("username", username);
		session.setAttribute("userid", userid);
		
		
		ModelAndView model = new ModelAndView();
		
		
		try
		{
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
			
			model.addObject("title", "Branch Master");
			model.addObject("message", "This page is for ROLE_ADMIN only!");
			model.setViewName("Masters/branch");

			
		} catch (Exception exception) {
			loggerconf.saveLogger(username,  "Admin / ", ConstantValues.LOGGER_STATUS_E, exception);
		}
		return model;

	}
	
	
	@RequestMapping( value = "/branches/", method = RequestMethod.GET)
	public ResponseEntity<List<BranchModel>> fetchAllBranches(HttpServletRequest request) 
	{
		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();
		
		try 
		{
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
			List<BranchModel> branches = branchDao.getAllBranches();
			if(branches.isEmpty()) 
			{
				return new ResponseEntity<List<BranchModel>> (HttpStatus.NO_CONTENT);
			}
			else
			{
				return new ResponseEntity<List<BranchModel>> (branches, HttpStatus.OK);	
			}			
		} 
		catch (Exception exception) 
		{			
			loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, exception);
			return new ResponseEntity<List<BranchModel>> (HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
	}

	//-------Create Branch begin---------------------
	 
	@RequestMapping(value="/create_branch", method=RequestMethod.POST)
	public ResponseEntity<Void> createBranch(@RequestBody BranchModel branchModel,UriComponentsBuilder ucBuilder, HttpServletRequest request)
	{
		userInformation=new UserInformation(request);
		String username=userInformation.getUserName();
		int user_id=Integer.parseInt(userInformation.getUserId());
		
		DateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date=new Date();
		try
		{
			branchModel.setObsolete("N");
			branchModel.setActive("Y");
			branchModel.setCreated_by(user_id);
			branchModel.setUpdated_by(user_id);
			branchModel.setCreated_datetime(dateFormat.format(date).toString());
			branchModel.setUpdated_datetime(dateFormat.format(date).toString());
			branchDao.saveOrUpdate(branchModel);
			HttpHeaders headers=new HttpHeaders();
			headers.setLocation(ucBuilder.path("/branches/{id}").buildAndExpand(branchModel.getBranch_id()).toUri());
			loggerconf.saveLogger(username,request.getServletPath(), ConstantValues.SAVE_SUCCESS,null);
			return new ResponseEntity<Void>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
		catch(Exception exception)
		{
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS, exception);
			return new ResponseEntity<Void>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
	
	/* ------------------------- Update Branch begin ------------------------------------- */
	@RequestMapping(value = "branch/{id}", method = RequestMethod.PUT)
	public ResponseEntity<BranchModel> updateBranch(@PathVariable ("id") int id, @RequestBody BranchModel branchModel, HttpServletRequest request) 
	{
		BranchModel branchModelDB = branchDao.getBranchbyId(id);
		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();
		int user_id = Integer.parseInt(userInformation.getUserId());
		try {
			
			if(branchModelDB == null) {
				loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS, null);
				return new ResponseEntity<BranchModel>(HttpStatus.NOT_FOUND);
			} else {
				
				Date date = new Date();
				DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ");
				
				branchModel.setUpdated_by(user_id);
				branchModel.setUpdated_datetime(dateFormat.format(date));
								
				branchDao.saveOrUpdate(branchModel);
				loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.SAVE_SUCCESS, null);
				return new ResponseEntity<BranchModel> (branchModel,HttpStatus.OK);
			}
		} catch (Exception exception) {
			loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS, exception);
			return new ResponseEntity<BranchModel> (HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	/* ------------------------- Update Branch end ------------------------------------- */
	
	/* ------------------------- Delete Branch begin ------------------------------------- */
	@RequestMapping(value = "delete_branch/{id}", method = RequestMethod.DELETE)
	public ResponseEntity<BranchModel> deleteBranch(@PathVariable ("id") int id, HttpServletRequest request) {
		BranchModel branchModel = branchDao.getBranchbyId(id);
		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();
		int user_id = Integer.parseInt(userInformation.getUserId());
		try {
			
			if(branchModel == null) {
				loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.DELETE_NOT_SUCCESS, null);
				return new ResponseEntity<BranchModel>(HttpStatus.NOT_FOUND);
			} else {
				
				Date date = new Date();
				DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ");
				
				branchModel.setUpdated_by(user_id);
				branchModel.setUpdated_datetime(dateFormat.format(date));
				branchModel.setActive("N");
				branchModel.setObsolete("Y");
				
				branchDao.saveOrUpdate(branchModel);
				loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.DELETE_SUCCESS, null);
				return new ResponseEntity<BranchModel> (branchModel,HttpStatus.OK);
			}
		} catch (Exception exception) {
			loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.DELETE_NOT_SUCCESS, exception);
			return new ResponseEntity<BranchModel> (HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	/* ------------------------- Delete Branch end ------------------------------------- */

}