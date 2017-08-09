package com.conti.manifest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.conti.others.ConstantValues;
import com.conti.others.Loggerconf;
import com.conti.others.UserInformation;

/**
 * @Project_Name conti
 * @Package_Name com.conti.manifest  com.conti.manifest
 * @File_name addManifestRestController.java com.conti.manifest
 * @author Monu.C
 * @Created_date_time Aug 8, 2017 3:19:48 PM
 */


@RestController
public class addManifestRestController {

	@Autowired
	private ManifestDao mDao;
	
	Loggerconf loggerconf = new Loggerconf();
	
	
	
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
	
	@RequestMapping(value="/fetchLastManifestNo/",method=RequestMethod.GET)
	public ResponseEntity<String> fetchLastManifestNo(HttpServletRequest request){		
		try {
			return new ResponseEntity<String>(String.valueOf(mDao.fetchLastManifestNo()),HttpStatus.OK);
		} catch (Exception e) {
			loggerconf.saveLogger(request.getUserPrincipal().getName(),  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, e);
			return new ResponseEntity<String> (HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
}
