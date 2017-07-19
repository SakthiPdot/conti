package com.conti.master.service;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.codec.binary.Base64;
import org.codehaus.jackson.JsonProcessingException;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.UriComponentsBuilder;

import com.conti.config.SessionListener;
import com.conti.others.ConstantValues;
import com.conti.others.Loggerconf;
import com.conti.others.UserInformation;
import com.conti.settings.company.Company;
import com.conti.settings.company.CompanySettingDAO;

@RestController
public class ServiceRestController {
	
	@Autowired
	private ServiceDao serviceDao;
	@Autowired
	private CompanySettingDAO companySettingDAO;
	
	
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
		
		//================ Active Service Function Begin ===================//
			
					@RequestMapping(value = "make_serviceactive", method = RequestMethod.POST)
					public ResponseEntity<Void> make_serviceactive(@RequestBody int[] id, HttpServletRequest request) {
						userInformation = new UserInformation(request);
						String username = userInformation.getUserName();
						int user_id = Integer.parseInt(userInformation.getUserId());
						
						int active_flag =0;
						try {
								for(int i=0; i<id.length; i++) {
									ServiceMaster serviceModelDB = serviceDao.getServiceId(id[i]);
									
									if(serviceModelDB == null) {
										loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS, null);
										active_flag = 1;
									} else {
										
										Date date = new Date();
										DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
										
										serviceModelDB.setActive("Y");
										serviceModelDB.setUpdated_by(user_id);
										serviceModelDB.setUpdated_datetime(dateFormat.format(date));
										
										serviceDao.saveOrUpdate(serviceModelDB);
										loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.SAVE_SUCCESS, null);
									}
								}
								
								if( active_flag ==1) {
									return new ResponseEntity<Void>(HttpStatus.NOT_FOUND);
								} else {
									return new ResponseEntity<Void> (HttpStatus.OK);
								}
						 } catch (Exception exception) {
								loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS, exception);
								return new ResponseEntity<Void> (HttpStatus.INTERNAL_SERVER_ERROR);
							}
												
					}
			
			
		 //=============== Active Service Function End ======================//
					
		//================ InActive Service Function Begin =================//
					
					@RequestMapping(value = "make_serviceinactive", method = RequestMethod.POST)
					public ResponseEntity<Void> make_serviceinactive(@RequestBody int[] id, HttpServletRequest request) {
						userInformation = new UserInformation(request);
						String username = userInformation.getUserName();
						int user_id = Integer.parseInt(userInformation.getUserId());
						
						int active_flag = 0;
						try {
							for(int i=0; i<id.length;i++) {
								ServiceMaster serviceModelDB = serviceDao.getServiceId(id[i]);
								
								if(serviceModelDB == null) {
									loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS, null);
									active_flag = 1;
								} else {
									
									Date date = new Date();
									DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
									
									serviceModelDB.setActive("N");
									serviceModelDB.setUpdated_by(user_id);
									serviceModelDB.setUpdated_datetime(dateFormat.format(date));
									
									serviceDao.saveOrUpdate(serviceModelDB);
									loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.SAVE_SUCCESS, null);
								}
							}
							
							if( active_flag ==1) {
								return new ResponseEntity<Void>(HttpStatus.NOT_FOUND);
							} else {
								return new ResponseEntity<Void> (HttpStatus.OK);
							}
						} catch (Exception exception) {
							loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS, exception);
							return new ResponseEntity<Void> (HttpStatus.INTERNAL_SERVER_ERROR);
						}
						
						
					}
					
					
		//================ Inactive service Function End ==================//
			
		//================= Print Begin ==========================//
		
					@RequestMapping(value = "/service_print", method = RequestMethod.POST)
					public ModelAndView servicePrint(@RequestParam("service") String service, HttpServletRequest request ) throws JsonProcessingException, IOException {
						
						JSONArray jsonArray = new JSONArray(service);
						String[] serviceid = new String[jsonArray.length()];
						for(int i=0; i<jsonArray.length();i++) {
							JSONObject jsonObject = jsonArray.getJSONObject(i);
							serviceid[i] = Integer.toString(jsonObject.getInt("service_id"));
							
						}
						
						List<ServiceMaster> listService = new ArrayList<ServiceMaster> ();
						for(int i=0; i<serviceid.length;i++){
							ServiceMaster serviceModel = serviceDao.getServiceId(Integer.parseInt(serviceid[i]));
							listService.add(serviceModel);
						}
						Company company = companySettingDAO.getById(1);
						ModelAndView model = new ModelAndView("print/service_print");
						
						String base64DataString = "";
						if(company!=null && company.getCompany_logo()!=null) {
							byte[] encodeBase64 = Base64.encodeBase64(company.getCompany_logo());
							try {
								base64DataString = new String(encodeBase64 , "UTF-8");
							} catch (UnsupportedEncodingException e) {
								loggerconf.saveLogger(request.getUserPrincipal().getName(), request.getServletPath(), "Image support error", e);	
							}
						} else {
							base64DataString = ConstantValues.NO_IMAGE;	
						}
						model.addObject("title","Service");
						model.addObject("company",company);
						model.addObject("listService",listService);
						model.addObject("image",base64DataString);
						
						return model;
						
					}
					
	   //================== Print End ===========================//
					
		//================== Excel Begin ======================//
		
					@RequestMapping(value = "downloadExcelService", method= RequestMethod.GET)
					public ModelAndView downloadExcelSevice() {
						List<ServiceMaster> serviceList = serviceDao.getAllServices();						
						return new ModelAndView("serviceExcelView","serviceList",serviceList);
						
					}
					
		//================== Excel End =========================//
					
		//================== Service Search Function Begin  =========//
					
					@RequestMapping(value = "service_registersearch", method=RequestMethod.POST)
					public ResponseEntity<List<ServiceMaster>> service_registersearch(@RequestBody String  search_key, HttpServletRequest request) {
						List<ServiceMaster> servicelist = serviceDao.searchbyService(search_key);
						
						return new ResponseEntity<List<ServiceMaster>> (servicelist,HttpStatus.OK);
						
					}
					
		//================= Service Search Function End ==============//
					
		//=============== Pagination Function  Begin ================//
		
					@RequestMapping(value = "service_pagination", method=RequestMethod.POST)
					public ResponseEntity<List<ServiceMaster>> pagination(@RequestBody int page, HttpServletRequest request) {
						
						userInformation  = new UserInformation(request);
						
						int from_limit = 0, to_limit = 0;
						String order = "DESC";
						if(page == 1) {
							from_limit = 0;
							to_limit = page * 100;
						} else if (page == 0) {
							order = "ASC";
							from_limit = page;
							to_limit = 10;
						} else {
							from_limit = (page * 100) + 1;
							to_limit = (page + 1) * 100;
						}
						
						List<ServiceMaster> servlist = serviceDao.getServiceswithLimit(from_limit, to_limit, order);
						
						return new ResponseEntity <List<ServiceMaster>> (servlist,HttpStatus.OK);
						
					}
					
					
		//================ Pagination Function End ==================//
			
}
