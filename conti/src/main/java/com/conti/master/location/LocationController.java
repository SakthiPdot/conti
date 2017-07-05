package com.conti.master.location;


import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.conti.address.AddressModel;
import com.conti.config.SessionListener;
import com.conti.others.ConstantValues;
import com.conti.others.Loggerconf;
import com.conti.others.UserInformation;
import com.conti.setting.usercontrol.UsersDao;

/**
 * @Project_Name conti
 * @Package_Name com.conti.master.location
 * @File_name LocationController.java
 * @author Sakthi
 * @Created_date_time Jun 20, 2017 2:21:39 PM
 * @Updated_date_time Jun 20, 2017 2:21:39 PM
 */


@RestController
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class LocationController {

	final Logger logger = LoggerFactory.getLogger(LocationController.class);

	@Autowired
	private UsersDao usersDao;
	
	@Autowired 
	private LocationDao locationDao; 
		
	Loggerconf loggerconf = new Loggerconf();
	SessionListener sessionListener = new SessionListener();

	@RequestMapping(value =  "location", method = RequestMethod.GET)
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
			
			model.addObject("title", "Location Master");
			model.addObject("message", "This page is for ROLE_ADMIN only!");
			model.setViewName("Masters/location");

			
		} catch (Exception exception) {
			loggerconf.saveLogger(username,  "Admin / ", ConstantValues.LOGGER_STATUS_E, exception);
		}
		return model;

	}
	//=================FETCH ALL LOCATION=====================================
	
	@RequestMapping(value="fetchAllLocation",method=RequestMethod.GET,produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<Location>>  getAllLocation(){
		List<Location> locations=locationDao.getLocation();
		if(locations.isEmpty()){
			return new ResponseEntity<List<Location>>(HttpStatus.NO_CONTENT);
		}
		return new ResponseEntity<List<Location>>(locations,HttpStatus.OK);
	}
	
	//=================GET LOCATION MODEL=====================================	
	@RequestMapping(value="LocationModel",method=RequestMethod.GET,produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Location> getLocationModel(){
		
		Location location=new Location();
		AddressModel address=new AddressModel();
		location.setAddress(address);
		return new  ResponseEntity<Location>(location,HttpStatus.CREATED);
	}
	
	//=================SAVE =====================================
	@RequestMapping(value="locationSave",method=RequestMethod.POST,
			produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Void> saveLocation (@RequestBody Location location,
			HttpServletRequest request ){
		System.out.println("++ inside location save");
		//intialize	
		String userid = request.getSession().getAttribute("userid").toString();		
		Date date = new Date();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ");
		
		//set variable
		location.setCreated_by(Integer.parseInt(userid));
		location.setUpdated_by(Integer.parseInt(userid));
		location.setCreated_datetime(dateFormat.format(date));
		
		
		//save location
		try {
			locationDao.saveOrUpdate(location);
			loggerconf.saveLogger(request.getUserPrincipal().getName(), request.getServletPath(), ConstantValues.SAVE_SUCCESS, null);
			return new ResponseEntity<Void>(HttpStatus.CREATED);
		} catch (Exception e) {
			loggerconf.saveLogger(request.getUserPrincipal().getName(), request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS,e);
			e.printStackTrace();
			return new ResponseEntity<Void>(HttpStatus.INTERNAL_SERVER_ERROR);
		}	
		
	}
}