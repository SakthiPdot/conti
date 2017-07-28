package com.conti.manifest;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.conti.config.SessionListener;
import com.conti.master.customer.CustomerModel;
import com.conti.others.ConstantValues;
import com.conti.others.Loggerconf;
import com.conti.others.UserInformation;
import com.conti.setting.usercontrol.UsersDao;

/**
 * @Project_Name conti
 * @Package_Name com.conti.master.manifest.add
 * @File_name AddManifestDaoImpl.java
 * @author Suresh
 * @Created_date_time July 24, 2017 3:31:53 PM
 * @Updated_date_time Jly 24, 2017 3:31:53 PM
 */
@RestController
public class ManifestRestController 
{
	final Logger logger = LoggerFactory.getLogger(ManifestRestController.class);

	@Autowired
	private UsersDao usersDao;
	
	@Autowired
	private ManifestDao manifestDao;
		
	@Autowired
	@Qualifier("sessionRegistry")
	private SessionRegistry sessionRegistry;
		
	Loggerconf loggerconf = new Loggerconf();
	SessionListener sessionListener = new SessionListener();

	private UserInformation userInformation;

	
	//========================== to display Add Manifest Screen==========================
	
	@RequestMapping(value =  "add_manifest", method = RequestMethod.GET)
	public ModelAndView add_manifest(HttpServletRequest request) throws Exception {
		
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
			
			model.addObject("title", "Add Manifest");
			model.addObject("message", "This page is for ROLE_ADMIN only!");
			model.setViewName("Manifest/add_manifest");

			
		} catch (Exception exception) {
			loggerconf.saveLogger(username,  "Admin / ", ConstantValues.LOGGER_STATUS_E, exception);
		}
		return model;
	}
	
	
	
	//========================== to display View Manifest Screen==========================
	
	@RequestMapping(value =  "view_manifest", method = RequestMethod.GET)
	public ModelAndView view_manifest(HttpServletRequest request) throws Exception {
		
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
			
			model.addObject("title", "View Manifest");
			model.addObject("message", "This page is for ROLE_ADMIN only!");
			model.setViewName("Manifest/view_manifest");

			
		} 
		catch (Exception exception) 
		{
			loggerconf.saveLogger(username,  "Admin / ", ConstantValues.LOGGER_STATUS_E, exception);
		}
		return model;
	}
		
		
		@RequestMapping( value = "/manifest/", method = RequestMethod.GET)
		public ResponseEntity<List<ManifestModel>> fetchAllManifest(HttpServletRequest request) 
		{
			userInformation = new UserInformation(request);
			String username = userInformation.getUserName();
			String branch_id = userInformation.getUserBranchId();
			try 
			{
				loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
				List<ManifestModel> manifestModel = manifestDao.getAllManifest(Integer.parseInt(branch_id));
				System.out.println("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP");
				if(manifestModel.isEmpty()) 
				{
					return new ResponseEntity<List<ManifestModel>> (HttpStatus.NO_CONTENT);
				}
				else 
				{
					return new ResponseEntity<List<ManifestModel>> (manifestModel, HttpStatus.OK);	
				}			
			} 
			catch (Exception exception) 
			{			
				loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, exception);
				return new ResponseEntity<List<ManifestModel>> (HttpStatus.UNPROCESSABLE_ENTITY);
			}
		}

	
	
	
	
	
}