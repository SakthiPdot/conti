
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
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.function.Function;
import java.util.function.Predicate;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.codec.binary.Base64;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.JsonMappingException;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.UriComponentsBuilder;

import com.conti.config.SessionListener;
import com.conti.master.branch.BranchDao;
import com.conti.master.branch.BranchModel;
import com.conti.master.employee.EmployeeMaster;
import com.conti.master.location.Location;
import com.conti.master.location.LocationDao;
import com.conti.others.ConstantValues;
import com.conti.others.Loggerconf;
import com.conti.others.UserInformation;
import com.conti.setting.usercontrol.RoleDao;
import com.conti.setting.usercontrol.User;
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
	
	@Autowired
	private LocationDao locationDao;
	@Autowired
	private BranchDao branchDao;
	
	Loggerconf loggerconf = new Loggerconf();
	ConstantValues constantVal = new ConstantValues();
	SessionListener sessionListener = new SessionListener();
	UserInformation userInformation;
	
	@RequestMapping( value = "/customers/", method = RequestMethod.GET)
	public ResponseEntity<List<CustomerModel>> fetchAllCustomers(HttpServletRequest request) 
	{
		userInformation = new UserInformation(request);
		String username = userInformation.getUserName();
		String branch_id = userInformation.getUserBranchId();
		try 
		{
			loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
			List<CustomerModel> customers = customerDao.getAllCustomers(Integer.parseInt(branch_id));
			if(customers.isEmpty())                      
			{
				return new ResponseEntity<List<CustomerModel>> (HttpStatus.NO_CONTENT);
			}
			else 
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
			String branch_id = userInformation.getUserBranchId();
			
			try {
				loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
				List<CustomerModel> customers = customerDao.getAllCustomers(Integer.parseInt(branch_id));
				if(customers.isEmpty()) 
				{
					return new ResponseEntity<List<CustomerModel>> (HttpStatus.NO_CONTENT);
				} 
				else
				{
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
		 
		//======================================sort by==========================================
			@RequestMapping(value="sortByCustomerService/{name}",method=RequestMethod.POST,produces=MediaType.APPLICATION_JSON_VALUE)
			public  ResponseEntity<List<CustomerModel>>  sortByCustomerService(@RequestBody String status,@PathVariable("name") String name,HttpServletRequest request){
			
				String sortBy="";

				switch(name.trim()){
				case "customerName":
					 sortBy="customer_name";
					break;
				case "customerCode":
					 sortBy="customer_code";
					break;
				case "customerType":
					 sortBy="customer_type";
					break;
				case "custBranch":
					 sortBy="branchModel.branch_name";
					break;
				case "custCompanyName":
					 sortBy="company_name";
					break;
				case "custAddress":
					 sortBy="customer_addressline1";
					break;
				case "custPhoneNumber":
					 sortBy="customer_mobileno";
					break;
				case "custEmail":
					 sortBy="customer_email";
					break;
				case "custStatus":
					 sortBy="active";
					break;
				default:
					break;
				}
				
				List<CustomerModel> customerList=new ArrayList<>();
				
				try{
					customerList=customerDao.getCustomerSorting100(sortBy.trim(),status.trim().equals("ASC")?"ASC":"DESC");
					loggerconf.saveLogger(request.getUserPrincipal().getName(), request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
					if(customerList.isEmpty()){
						return new ResponseEntity<List<CustomerModel>>(HttpStatus.NO_CONTENT);
					}
					return new ResponseEntity<List<CustomerModel>>(customerList,HttpStatus.OK);
				}catch(Exception e){
					loggerconf.saveLogger(request.getUserPrincipal().getName(), request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS,e);
					e.printStackTrace();
					return new ResponseEntity<List<CustomerModel>>(HttpStatus.INTERNAL_SERVER_ERROR);
				}
				
			}
		 
		/* ------------------------- Create a Customer begin -------------------------------------  */
		@RequestMapping( value = "/create_customer", method = RequestMethod.POST)
		public ResponseEntity<Void> createCustomer(@RequestBody CustomerModel customerModel, UriComponentsBuilder ucBuilder, HttpServletRequest request) {
			userInformation = new UserInformation(request);
			String username = userInformation.getUserName();
			int user_id = Integer.parseInt(userInformation.getUserId());
			
					
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date date = new Date();
			
//		try {
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
		@RequestMapping(value = "update_customer", method = RequestMethod.POST)
		public ResponseEntity<CustomerModel> updateCustomer(@RequestBody CustomerModel customerModel, HttpServletRequest request) {
			//CustomerModel customerModeldb = customerDao.getCustomerbyId(id);
			userInformation = new UserInformation(request);
			String username = userInformation.getUserName();
			int user_id = Integer.parseInt(userInformation.getUserId());
			try 
			{
				
//				if(customerModeldb == null)
//				{
//					loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.SAVE_NOT_SUCCESS, null);
//					return new ResponseEntity<CustomerModel>(HttpStatus.NOT_FOUND);
//				} 
//				else 
//				{
					Date date = new Date();
					DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ");
					
					customerModel.setUpdated_by(user_id);
					customerModel.setUpdated_datetime(dateFormat.format(date));
									
					customerDao.saveOrUpdate(customerModel);
					loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.SAVE_SUCCESS, null);
					return new ResponseEntity<CustomerModel> (customerModel,HttpStatus.OK);
				//}
			} 
			catch (Exception exception)
			{
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
		@RequestMapping(value = "make_active_customer", method = RequestMethod.POST)
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
		@RequestMapping(value = "make_inactive_customer", method = RequestMethod.POST)
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
	
		
		/* ------------------------- Print in Customer begin ------------------------------------- */	
		@RequestMapping(value = "/customer_print", method = RequestMethod.POST)
		public ModelAndView farmPrint(@RequestParam("cust") String cust, HttpServletRequest request) throws JsonProcessingException, IOException{

			JSONArray jsonArray = new JSONArray(cust);
			String[] customerid = new String[jsonArray.length()];
			for(int i=0; i <jsonArray.length();i++) {
				JSONObject jsonObject = jsonArray.getJSONObject(i);
				customerid[i] = Integer.toString(jsonObject.getInt("customer_id"));			
			}
			
			List<CustomerModel> listCust = new ArrayList<CustomerModel> ();
			for(int i=0; i<customerid.length;i++) {
				CustomerModel customerModel = customerDao.getCustomerbyId(Integer.parseInt(customerid[i]));
				listCust.add(customerModel);
			}
			Company company = companySettingDAO.getById(1);
			ModelAndView model = new ModelAndView("print/customer_print");

			String base64DataString ="";
			if(company!=null && company.getCompany_logo()!=null){
				byte[] encodeBase64 = Base64.encodeBase64(company.getCompany_logo());
				try {
					 base64DataString = new String(encodeBase64 , "UTF-8");
				} catch (UnsupportedEncodingException e) {
					loggerconf.saveLogger(request.getUserPrincipal().getName(),  request.getServletPath(), "Image support error", e);
				}		
			}else{
				base64DataString = ConstantValues.NO_IMAGE;	
			}
			
			model.addObject("title", "Customer");
			model.addObject("company", company);
			model.addObject("listCust", listCust);
			model.addObject("image",base64DataString);
				
			return model;
		}
		/* ------------------------- Print in Employee end ------------------------------------- */	

		//======================================Excel==========================================
		
		
		
		//======================================Excel begin==========================================
		@RequestMapping(value="downloadExcelCustomer",method=RequestMethod.GET)
		public ModelAndView downloadExcelCustomer()
		{
			String branch_id = userInformation.getUserBranchId();
			List<CustomerModel> customerList=customerDao.getAllCustomers(Integer.parseInt(branch_id));
			return new ModelAndView("customerExcelView","customerList",customerList);
		}
		
		@RequestMapping(value = "register_search_customer", method=RequestMethod.POST)
		public ResponseEntity<List<CustomerModel>> register_search_customer(@RequestBody String searchkey, HttpServletRequest request) 
		{
			
			List<CustomerModel> customerList = customerDao.searchbyeyCustomer(searchkey);
			return new ResponseEntity<List<CustomerModel>> (customerList, HttpStatus.OK);
		}
		//======================================Excel end==========================================
		
		//======================================Pagination begin==========================================
		
		@RequestMapping(value = "pagination_customer", method=RequestMethod.POST)
		public ResponseEntity<List<CustomerModel>> pagination(@RequestBody int page, HttpServletRequest request) {
			
			userInformation = new UserInformation(request);
			String username = userInformation.getUserName();
			String branch_id = userInformation.getUserBranchId();
		
			int from_limit = 0, to_limit = 0;
			String order = "DESC";
			if(page == 1) { // First
				from_limit = 0;
				to_limit = page * 100;
			} else if ( page == 0 ) { // Last
				order = "ASC";
				from_limit = page;
				to_limit = 10;
			} else {
				from_limit = (page * 10) + 1;
				to_limit =  (page + 1 ) * 100;
			}
			
			List<CustomerModel> customerList = customerDao.getCustomerswithLimit(Integer.parseInt(branch_id), from_limit, to_limit, order);
			if(customerList.isEmpty())
			{
				loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
				return new ResponseEntity<List<CustomerModel>> ( HttpStatus.NO_CONTENT);
			}
			else
			{
				loggerconf.saveLogger(username, request.getServletPath(), ConstantValues.FETCH_SUCCESS, null);
				return new ResponseEntity<List<CustomerModel>> (customerList, HttpStatus.OK);
			}
		}
		
	//======================================Pagination end==========================================
		
		
	//===========================To get all location for Customer search ================================
		
		@RequestMapping(value="getLocations4Search/{str}", method = RequestMethod.GET,produces=MediaType.APPLICATION_JSON_VALUE)
		public ResponseEntity<Map<String,List<Location>>> fetchAllLocations4Customer(HttpServletRequest request,
				@PathVariable("str") String searchStr) throws JsonGenerationException, JsonMappingException, JSONException, IOException {
			
			List<Location> locations = locationDao.searchbyeyLocationName(searchStr);

			 Map result = new HashMap();
			 result.put("Location", locations);
			
			System.err.println(searchStr+"464644");
			return new ResponseEntity<Map<String,List<Location>>> (result,HttpStatus.OK);
		}
		
		
		
		//===========================To get all Branch for Customer search ================================
		
		@RequestMapping(value="getBranch4Search/{str}", method = RequestMethod.GET,produces=MediaType.APPLICATION_JSON_VALUE)
		public ResponseEntity<Map<String,List<BranchModel>>> fetchAllBranches4Search(HttpServletRequest request,
				@PathVariable("str") String searchStr) throws JsonGenerationException, JsonMappingException, JSONException, IOException 
		{
			
			List<BranchModel> branches = branchDao.searchbyeyBranchName(searchStr);

			 Map result = new HashMap();
			 result.put("Branch", branches);
			
			System.err.println(searchStr+"464644");
			return new ResponseEntity<Map<String,List<BranchModel>>> (result,HttpStatus.OK);
		}
		
		
		/* ------------------------- Find record count begin ------------------------------------- */
		
		@RequestMapping(value = "/customer_record_count/", method = RequestMethod.GET)
		public ResponseEntity<String> customerrecordCount(HttpServletRequest request) {
			String username = userInformation.getUserName();
			
			try 
			{
				int userid = Integer.parseInt(userInformation.getUserId());	
				User user = usersDao.get(userid);
				List<User> userList = new ArrayList<User>();
				if( user.getRole().getRole_Name().equals(constantVal.ROLE_SADMIN) ) 
				{
					String rec_count = Integer.toString(customerDao.find_record_countforSA());
					return new ResponseEntity<String> (rec_count, HttpStatus.OK);	
				} 
				else 
				{
					String rec_count = Integer.toString(customerDao.find_record_count());
					return new ResponseEntity<String> (rec_count, HttpStatus.OK);	
				}
				
			} 
			catch (Exception exception) 
			{
				loggerconf.saveLogger(username,  request.getServletPath(), ConstantValues.FETCH_NOT_SUCCESS, exception);
				return new ResponseEntity<String> (HttpStatus.UNPROCESSABLE_ENTITY);
			}
			
		}
		
		/* ------------------------- Find record count end ------------------------------------- */
		
		
	//===========================To get all Customer search by mobileno ================================
		
		@RequestMapping(value="fetchAllCustomer4Search/{str}", method = RequestMethod.GET,produces=MediaType.APPLICATION_JSON_VALUE)
		public ResponseEntity<Map<String,List<CustomerModel>>> fetchAllCustomer4Search(HttpServletRequest request,
				@PathVariable("str") String searchStr) throws JsonGenerationException, JsonMappingException, JSONException, IOException 
		{
			
			List<CustomerModel> customers = customerDao.searchbyMobileno(searchStr);

			 Map result = new HashMap();
			 result.put("Customers", customers);
			
			return new ResponseEntity<Map<String,List<CustomerModel>>> (result,HttpStatus.OK);
		}
	}
	
	
	
	

