
/**
 * @Project_Name conti
 * @Package_Name com.conti.master.customer
 * @File_name CustomerRestController.java
 * @author Suresh
 * @Created_date_time July 14, 2017 12:50:56 AM
 * @Updated_date_time July 14, 2017 12:50:56 AM
 */


package com.conti.master.customer;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.function.Function;
import java.util.function.Predicate;
import java.util.stream.Collectors;

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
import com.conti.setting.usercontrol.RoleDao;
import com.conti.setting.usercontrol.UsersDao;
import com.conti.settings.company.Company;
import com.conti.settings.company.CompanySettingDAO;

@RestController
public class CustomerRestController 
{
	@Autowired
	private UsersDao usersDao;
	@Autowired
	private RoleDao roleDao;
	@Autowired
	private CustomerDao customerDao;
	@Autowired
	private CompanySettingDAO companySettingDAO;
	
	Loggerconf loggerconf = new Loggerconf();
	ConstantValues constantVal = new ConstantValues();
	SessionListener sessionListener = new SessionListener();
	UserInformation userInformation;
	
	@RequestMapping( value = "/customers/", method = RequestMethod.GET)
	public ResponseEntity<List<CustomerModel>> fetchAllCustomers(HttpServletRequest request) 
	{
		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();
		
		try 
		{
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
			List<CustomerModel> customers = customerDao.getAllCustomers();
			if(customers.isEmpty()) 
			{
				return new ResponseEntity<List<CustomerModel>> (HttpStatus.NO_CONTENT);
			} else 
			{
				return new ResponseEntity<List<CustomerModel>> (customers, HttpStatus.OK);	
			}			
		} 
		catch (Exception exception) 
		{			
			loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, exception);
			return new ResponseEntity<List<CustomerModel>> (HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
		
		@RequestMapping( value = "/customers/category/", method = RequestMethod.GET)
		public ResponseEntity<List<CustomerModel>> fetchCustomerbycat(HttpServletRequest request) {
			userInformation = new UserInformation(request);
			String username = userInformation.getUserName();
			
			try {
				loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
				List<CustomerModel> customers = customerDao.getAllCustomers();
				if(customers.isEmpty()) {
					return new ResponseEntity<List<CustomerModel>> (HttpStatus.NO_CONTENT);
				} else {
					List<CustomerModel> customerCategory = customers.stream().filter(distinctByKey(customer->customer.getCustomer_type())).collect(Collectors.toList());
					return new ResponseEntity<List<CustomerModel>> (customerCategory, HttpStatus.OK);	
				}			
			} catch (Exception exception) {			
				loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, exception);
				return new ResponseEntity<List<CustomerModel>> (HttpStatus.UNPROCESSABLE_ENTITY);
			}
			
		}	
		/**
		 * @param object
		 * @return
		 */
		 public static <T> Predicate<T> distinctByKey(Function<? super T, Object> keyExtractor) 
		    {
		        Map<Object, Boolean> map = new ConcurrentHashMap<>();
		        return t -> map.putIfAbsent(keyExtractor.apply(t), Boolean.TRUE) == null;
		    }
		 
		 
		/* ------------------------- Create a Customer begin -------------------------------------  */
		@RequestMapping( value = "/create_customer", method = RequestMethod.POST)
		public ResponseEntity<Void> createCustomer(@RequestBody CustomerModel customerModel, UriComponentsBuilder ucBuilder, HttpServletRequest request) {
			userInformation = new UserInformation(request);
			String username = userInformation.getUserName();
			int user_id = Integer.parseInt(userInformation.getUserId());
					
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date date = new Date();
			
//			try {
				customerModel.setObsolete("N");
				customerModel.setActive("Y");
				customerModel.setCreated_by(user_id);
				customerModel.setUpdated_by(user_id);	
				customerModel.setCreated_datetime(dateFormat.format(date).toString());
				customerModel.setUpdated_datetime(dateFormat.format(date).toString());
				
				customerDao.saveOrUpdate(customerModel);		
				
				HttpHeaders headers = new HttpHeaders();
				System.out.println("yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy");
		        headers.setLocation(ucBuilder.path("/customers/{id}").buildAndExpand(customerModel.getCustomer_id()).toUri());
		        System.out.println("yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy");
		        loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.SAVE_SUCCESS, null);
		        System.out.println("yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy");
				return new ResponseEntity<Void> (headers, HttpStatus.CREATED);
				
//			} catch (Exception exception) {
//				loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS, exception);
//				return new ResponseEntity<Void> (HttpStatus.UNPROCESSABLE_ENTITY);
//			}
			
		}
		/* ------------------------- Create a Customer end -------------------------------------  */
		
		
		/* ------------------------- Update Customer begin ------------------------------------- */
		@RequestMapping(value = "update_customer/{id}", method = RequestMethod.PUT)
		public ResponseEntity<CustomerModel> updateCustomer(@PathVariable ("id") int id, @RequestBody CustomerModel customerModel, HttpServletRequest request) {
			CustomerModel customerModeldb = customerDao.getCustomerbyId(id);
			userInformation = new UserInformation(request);
			String username = userInformation.getUserName();
			int user_id = Integer.parseInt(userInformation.getUserId());
			try {
				
				if(customerModeldb == null) {
					loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS, null);
					return new ResponseEntity<CustomerModel>(HttpStatus.NOT_FOUND);
				} else {
					
					Date date = new Date();
					DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ");
					
					customerModel.setUpdated_by(user_id);
					customerModel.setUpdated_datetime(dateFormat.format(date));
									
					customerDao.saveOrUpdate(customerModel);
					loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.SAVE_SUCCESS, null);
					return new ResponseEntity<CustomerModel> (customerModel,HttpStatus.OK);
				}
			} catch (Exception exception) {
				loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS, exception);
				return new ResponseEntity<CustomerModel> (HttpStatus.INTERNAL_SERVER_ERROR);
			}
		}
		/* ------------------------- Update Customer end ------------------------------------- */
		
		
		/* ------------------------- Delete Customer begin ------------------------------------- */
		@RequestMapping(value = "delete_customer/{id}", method = RequestMethod.DELETE)
		public ResponseEntity<CustomerModel> deleteCustomer(@PathVariable ("id") int id, HttpServletRequest request) {
			CustomerModel customerModel = customerDao.getCustomerbyId(id);
			userInformation = new UserInformation(request);
			String username = userInformation.getUserName();
			int user_id = Integer.parseInt(userInformation.getUserId());
			try {
				
				if(customerModel == null) {
					loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.DELETE_NOT_SUCCESS, null);
					return new ResponseEntity<CustomerModel>(HttpStatus.NOT_FOUND);
				} else {
					
					Date date = new Date();
					DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ");
					
					customerModel.setUpdated_by(user_id);
					customerModel.setUpdated_datetime(dateFormat.format(date));
					customerModel.setActive("N");
					customerModel.setObsolete("Y");
					
					customerDao.saveOrUpdate(customerModel);
					loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.DELETE_SUCCESS, null);
					return new ResponseEntity<CustomerModel> (customerModel,HttpStatus.OK);
				}
			} catch (Exception exception) {
				loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.DELETE_NOT_SUCCESS, exception);
				return new ResponseEntity<CustomerModel> (HttpStatus.INTERNAL_SERVER_ERROR);
			}
		}
		/* ------------------------- Delete Customer end ------------------------------------- */
		
		
		
		/* ------------------------- Make active in Customer begin ------------------------------------- */
		@RequestMapping(value = "make_activecustomer", method = RequestMethod.POST)
		public ResponseEntity<Void> make_activecustomer(@RequestBody int[] id, HttpServletRequest request) {
			userInformation = new UserInformation(request);
			String username = userInformation.getUserName();
			int user_id = Integer.parseInt(userInformation.getUserId());
			
			int active_flag = 0;
			try {
				for(int i=0; i<id.length; i++) {
					CustomerModel customerModelDB = customerDao.getCustomerbyId(id[i]);
					
					if(customerModelDB == null) {
						loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS, null);
						active_flag = 1;
						
					} else {
						
						Date date = new Date();
						DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ");
						
						customerModelDB.setActive("Y");
						customerModelDB.setUpdated_by(user_id);
						customerModelDB.setUpdated_datetime(dateFormat.format(date));
										
						customerDao.saveOrUpdate(customerModelDB);
						loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.SAVE_SUCCESS, null);
						
					}
				}
				
				if( active_flag == 1) 
				{
					return new ResponseEntity<Void>(HttpStatus.NOT_FOUND);
				} else {
					return new ResponseEntity<Void> (HttpStatus.OK);
				}
			} 
			catch (Exception exception) 
			{
				loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS, exception);
				return new ResponseEntity<Void> (HttpStatus.INTERNAL_SERVER_ERROR);
			}
		}
		/* ------------------------- Make active Customer end ------------------------------------- */
		
		/* ------------------------- Make inactive in Customer begin ------------------------------------- */
		@RequestMapping(value = "make_inactivecustomer", method = RequestMethod.POST)
		public ResponseEntity<Void> make_inactivecustomer(@RequestBody int[] id, HttpServletRequest request) {
			userInformation = new UserInformation(request);
			String username = userInformation.getUserName();
			int user_id = Integer.parseInt(userInformation.getUserId());
			
			int active_flag = 0;
			try {
				for(int i=0; i<id.length; i++) {
					CustomerModel customerModelDB = customerDao.getCustomerbyId(id[i]);
					
					if(customerModelDB == null) {
						loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS, null);
						active_flag = 1;
						
					} else {
						
						Date date = new Date();
						DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ");
						
						customerModelDB.setActive("N");
						customerModelDB.setUpdated_by(user_id);
						customerModelDB.setUpdated_datetime(dateFormat.format(date));
										
						customerDao.saveOrUpdate(customerModelDB);
						loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.SAVE_SUCCESS, null);
						
					}
				}
				
				if( active_flag == 1) {
					return new ResponseEntity<Void>(HttpStatus.NOT_FOUND);
				} else {
					return new ResponseEntity<Void> (HttpStatus.OK);
				}
			} catch (Exception exception) {
				loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS, exception);
				return new ResponseEntity<Void> (HttpStatus.INTERNAL_SERVER_ERROR);
			}
		}
		/* ------------------------- Make active Customer end ------------------------------------- */
	
		
//		@RequestMapping(value = "/employee_print", method = RequestMethod.POST)
//		public ModelAndView farmPrint(@RequestParam("emp") String emp) throws JsonProcessingException, IOException
//		{
//			JSONArray jsonArray = new JSONArray(emp);
//			String[] empid = new String[jsonArray.length()];
//			for(int i=0; i <jsonArray.length();i++) 
//			{
//				JSONObject jsonObject = jsonArray.getJSONObject(i);
//				empid[i] = Integer.toString(jsonObject.getInt("emp_id"));			
//			}
//			
//			List<CustomerModel> listEmp = new ArrayList<CustomerModel> ();
//			for(int i=0; i<empid.length;i++)
//			{
//				CustomerModel customerModel = customerDao.getCustomerbyId(Integer.parseInt(empid[i]));
//				listEmp.add(customerModel);
//			}
//			Company company = companySettingDAO.getById(1);
//			ModelAndView model = new ModelAndView("print/employee_print");
//			
//			byte[] encodeBase64 = Base64.encodeBase64(company.getCompany_logo());
//			String base64DataString = new String(encodeBase64 , "UTF-8");
//			
//			model.addObject("title", "Employee");
//			model.addObject("company", company);
//			model.addObject("listEmp", listEmp);
//			model.addObject("image",base64DataString);
//				
//			return model;
//		}
		
		//======================================Excel==========================================
//		@RequestMapping(value="downloadExcelEmployee",method=RequestMethod.GET)
//		public ModelAndView downloadExcelCustomer()
//		{
//			List<CustomerModel> customerList=customerDao.getAllCustomers();
//			return new ModelAndView("customerExcelView","customerList",customerList);
//		}
		
		
		
	}
	
	
	
	

