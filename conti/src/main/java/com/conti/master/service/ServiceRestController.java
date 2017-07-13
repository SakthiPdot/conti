package com.conti.master.service;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.util.UriComponentsBuilder;

import com.conti.config.SessionListener;
import com.conti.others.ConstantValues;
import com.conti.others.Loggerconf;
import com.conti.others.UserInformation;

@RestController
public class ServiceRestController {
	
	@Autowired
	private ServiceDao serviceDao;
	
	
	Loggerconf loggerconf = new Loggerconf();
	ConstantValues constantVal = new ConstantValues();
	SessionListener sessionListener = new SessionListener();
	UserInformation userInformation;
	
	
	@RequestMapping( value ="/services/", method = RequestMethod.GET)
	public ResponseEntity<List<ServiceMaster>> fetchAllServices(HttpServletRequest request) {
		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();
		
		try{
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
			List<ServiceMaster> services = serviceDao.getAllServices();
			if(services.isEmpty()) {
				return new ResponseEntity<List<ServiceMaster>> (HttpStatus.NO_CONTENT);	
			} else {
				return new ResponseEntity<List<ServiceMaster>> (services, HttpStatus.OK);	
			}
		} catch (Exception exception) {
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, exception);
			return new ResponseEntity<List<ServiceMaster>> (HttpStatus.UNPROCESSABLE_ENTITY);
			
		}
		
	}
	
	//=================  Create a Service Function  Begin =============//
		@RequestMapping( value = "/create_service", method = RequestMethod.POST)
		public ResponseEntity<Void> createService(@RequestBody ServiceMaster service, UriComponentsBuilder ucBuilder, HttpServletRequest request) {
			userInformation = new UserInformation(request);
			String username = userInformation.getUserName();
			int user_id = Integer.parseInt(userInformation.getUserId());
			
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date date = new Date();
			
			try {
				service.setObsolete("N");
				service.setActive("Y");
				service.setCreated_by(user_id);
				service.setUpdated_by(user_id);
				service.setCreated_datetime(dateFormat.format(date).toString());
				service.setUpdated_datetime(dateFormat.format(date).toString());
				
				
				serviceDao.saveOrUpdate(service);
				
				HttpHeaders headers = new HttpHeaders();
				loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.SAVE_SUCCESS, null);
				return new ResponseEntity<Void> (headers,HttpStatus.CREATED);
			} catch (Exception exception) {
				loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS, exception);
				return new ResponseEntity<Void> (HttpStatus.UNPROCESSABLE_ENTITY);
			}
		}
	//=================  Create a Service Function End =================//
		
	//================= Update a Service Function Begins ================//
			
			@RequestMapping(value = "update_service/{id}", method = RequestMethod.PUT)
			public ResponseEntity<ServiceMaster> updateService(@PathVariable("id") int id, @RequestBody ServiceMaster serviceModel, HttpServletRequest request) {
				ServiceMaster serviceModelDB = serviceDao.getServiceId(id);
				userInformation = new UserInformation(request);
				String username = userInformation.getUserName();
				int user_id = Integer.parseInt(userInformation.getUserId());
				
				try{
					if(serviceModelDB == null) {
						loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS, null);
						return new ResponseEntity<ServiceMaster> (HttpStatus.NOT_FOUND);
					} else {
						
						Date date = new Date();
						DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ");
						
						serviceModel.setUpdated_by(user_id);
						serviceModel.setUpdated_datetime(dateFormat.format(date));
						
						serviceDao.saveOrUpdate(serviceModel);
						loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.SAVE_SUCCESS,null);
						return new ResponseEntity<ServiceMaster> (serviceModel,HttpStatus.OK);
					}
				 
				} catch (Exception exception) {
					loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS, exception);
					return new ResponseEntity<ServiceMaster> (HttpStatus.INTERNAL_SERVER_ERROR);
				
				}				
			}
	//================= Update a Service Function End ====================//
			
	
	//================= Delete Service Function Begin ======================//
			
			@RequestMapping(value = "delete_service/{id}", method = RequestMethod.DELETE)
			public ResponseEntity<ServiceMaster> deleteService(@PathVariable ("id") int id, HttpServletRequest request) {
				ServiceMaster serviceModel = serviceDao.getServiceId(id);
				userInformation = new UserInformation(request);
				String username = userInformation.getUserName();
				int user_id = Integer.parseInt(userInformation.getUserId());
				try {
					  
						 if(serviceModel == null) {
							 loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.DELETE_NOT_SUCCESS, null);
							 return new ResponseEntity<ServiceMaster> (HttpStatus.NOT_FOUND);
			            } else {
			            	
			            	Date date = new Date();
			            	DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			            	
			            	serviceModel.setUpdated_by(user_id);
			            	serviceModel.setUpdated_datetime(dateFormat.format(date));
			            	serviceModel.setActive("N");
			            	serviceModel.setObsolete("Y");
			            	
			            	
			            	serviceDao.saveOrUpdate(serviceModel);
			            	loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.DELETE_SUCCESS, null);
			            	return new ResponseEntity<ServiceMaster> (serviceModel,HttpStatus.OK);
			            	
			            }
				     } catch (Exception exception) {
				    	 loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.DELETE_NOT_SUCCESS, exception);
				    	 return new ResponseEntity<ServiceMaster> (HttpStatus.INTERNAL_SERVER_ERROR);	
				    	
				     }
				}
			
	//================= Delete Service Function End ========================//
			
			
}
